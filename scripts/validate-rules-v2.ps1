# 规则一致性验证脚本 v2.0
# 用途: 检查规则系统的一致性、完整性和正确性
# 作者: System
# 版本: 2.6.0
# 日期: 2025-10-18

param(
    [string]$RulesPath = ".",
    [switch]$Verbose,
    [switch]$ExportReport
)

# 颜色输出函数
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# 测试结果记录
$script:TotalIssues = 0
$script:Issues = @()

function Add-Issue {
    param(
        [string]$Severity,
        [string]$Category,
        [string]$Message
    )
    
    $script:Issues += [PSCustomObject]@{
        Severity = $Severity
        Category = $Category
        Message = $Message
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
    $script:TotalIssues++
}

# ============================================
# 1. 检查优先级冲突
# ============================================
function Test-PriorityConflicts {
    Write-ColorOutput "`n🔍 [1/8] 检查优先级冲突..." "Cyan"
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $priorities = @{}
    $conflictCount = 0
    
    foreach ($rule in $rules) {
        $content = Get-Content $rule.FullName -Raw -ErrorAction SilentlyContinue
        if ($content -match "priority:\s*(\d+)") {
            $priority = [int]$Matches[1]
            $name = $rule.Name
            
            if ($priorities.ContainsKey($priority)) {
                Add-Issue "WARNING" "Priority" "优先级冲突: $name 和 $($priorities[$priority]) 都使用 $priority"
                $conflictCount++
            }
            $priorities[$priority] = $name
        }
    }
    
    if ($conflictCount -eq 0) {
        Write-ColorOutput "  ✅ 未发现优先级冲突 (检查了 $($rules.Count) 个规则文件)" "Green"
    } else {
        Write-ColorOutput "  ⚠️  发现 $conflictCount 个优先级冲突" "Yellow"
    }
    
    return $conflictCount
}

# ============================================
# 2. 检查版本字段
# ============================================
function Test-VersionFields {
    Write-ColorOutput "`n🔍 [2/8] 检查版本字段..." "Cyan"
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $missingCount = 0
    
    foreach ($rule in $rules) {
        $content = Get-Content $rule.FullName -Raw -ErrorAction SilentlyContinue
        
        if ($content -notmatch "version:\s*[`"']?\d+\.\d+\.\d+") {
            Add-Issue "INFO" "Version" "缺少版本字段: $($rule.Name)"
            $missingCount++
            
            if ($Verbose) {
                Write-ColorOutput "    📄 $($rule.Name) - 缺少版本信息" "Gray"
            }
        }
    }
    
    if ($missingCount -eq 0) {
        Write-ColorOutput "  ✅ 所有规则文件都包含版本信息" "Green"
    } else {
        Write-ColorOutput "  ⚠️  $missingCount 个文件缺少版本字段" "Yellow"
    }
    
    return $missingCount
}

# ============================================
# 3. 检查引用一致性
# ============================================
function Test-ReferenceConsistency {
    Write-ColorOutput "`n🔍 [3/8] 检查规则引用一致性..." "Cyan"
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $allRuleNames = $rules | ForEach-Object { $_.BaseName }
    $brokenRefCount = 0
    
    foreach ($rule in $rules) {
        $content = Get-Content $rule.FullName -Raw -ErrorAction SilentlyContinue
        $references = [regex]::Matches($content, "(\w[\w-]+\.mdc)")
        
        foreach ($ref in $references) {
            $refName = $ref.Groups[1].Value -replace "\.mdc$", ""
            
            if ($refName -notin $allRuleNames) {
                Add-Issue "WARNING" "Reference" "无效引用: $($rule.Name) 引用了不存在的 $($ref.Groups[1].Value)"
                $brokenRefCount++
                
                if ($Verbose) {
                    Write-ColorOutput "    🔗 $($rule.Name) → $($ref.Groups[1].Value) [不存在]" "Gray"
                }
            }
        }
    }
    
    if ($brokenRefCount -eq 0) {
        Write-ColorOutput "  ✅ 所有规则引用都有效" "Green"
    } else {
        Write-ColorOutput "  ⚠️  发现 $brokenRefCount 个无效引用" "Yellow"
    }
    
    return $brokenRefCount
}

# ============================================
# 4. 检查优先级范围
# ============================================
function Test-PriorityRanges {
    Write-ColorOutput "`n🔍 [4/8] 检查优先级范围..." "Cyan"
    
    $priorityRanges = @{
        "P0-core-safety" = @(1100, 1200)
        "P1-core-identity" = @(1000, 1099)
        "P2-intelligent-system" = @(900, 999)
        "P3-developer-workflow" = @(800, 899)
        "P4-development-tools" = @(700, 799)
        "P5-mcp-ecosystem" = @(600, 699)
        "P6-advanced-features" = @(500, 599)
        "P7-project-templates" = @(300, 499)
    }
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $outOfRangeCount = 0
    
    foreach ($rule in $rules) {
        $content = Get-Content $rule.FullName -Raw -ErrorAction SilentlyContinue
        $relativePath = $rule.DirectoryName -replace [regex]::Escape($RulesPath), ""
        
        # 提取目录层级
        $pathParts = $relativePath -split "[\\/]" | Where-Object { $_ -ne "" }
        $pLevel = $pathParts | Where-Object { $_ -match "^P\d+" } | Select-Object -First 1
        
        if ($content -match "priority:\s*(\d+)") {
            $priority = [int]$Matches[1]
            
            if ($pLevel -and $priorityRanges.ContainsKey($pLevel)) {
                $range = $priorityRanges[$pLevel]
                
                if ($priority -lt $range[0] -or $priority -gt $range[1]) {
                    Add-Issue "WARNING" "Priority Range" "优先级超出范围: $($rule.Name) ($priority) 不在 $pLevel 范围 $($range[0])-$($range[1])"
                    $outOfRangeCount++
                    
                    if ($Verbose) {
                        Write-ColorOutput "    📊 $($rule.Name): $priority [应该在 $($range[0])-$($range[1])]" "Gray"
                    }
                }
            }
        }
    }
    
    if ($outOfRangeCount -eq 0) {
        Write-ColorOutput "  ✅ 所有优先级都在正确范围内" "Green"
    } else {
        Write-ColorOutput "  ⚠️  $outOfRangeCount 个规则优先级超出范围" "Yellow"
    }
    
    return $outOfRangeCount
}

# ============================================
# 5. 检查Frontmatter格式
# ============================================
function Test-FrontmatterFormat {
    Write-ColorOutput "`n🔍 [5/8] 检查Frontmatter格式..." "Cyan"
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $invalidCount = 0
    
    foreach ($rule in $rules) {
        $content = Get-Content $rule.FullName -Raw -ErrorAction SilentlyContinue
        
        # 检查是否有frontmatter
        if ($content -notmatch "^---\r?\n") {
            Add-Issue "ERROR" "Frontmatter" "缺少Frontmatter: $($rule.Name)"
            $invalidCount++
            continue
        }
        
        # 检查必需字段
        $requiredFields = @("type", "description", "priority")
        foreach ($field in $requiredFields) {
            if ($content -notmatch "${field}:\s*") {
                Add-Issue "ERROR" "Frontmatter" "缺少必需字段 '$field': $($rule.Name)"
                $invalidCount++
            }
        }
    }
    
    if ($invalidCount -eq 0) {
        Write-ColorOutput "  ✅ 所有Frontmatter格式正确" "Green"
    } else {
        Write-ColorOutput "  ❌ $invalidCount 个文件Frontmatter格式错误" "Red"
    }
    
    return $invalidCount
}

# ============================================
# 6. 检查文件编码
# ============================================
function Test-FileEncoding {
    Write-ColorOutput "`n🔍 [6/8] 检查文件编码..." "Cyan"
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $encodingIssues = 0
    
    foreach ($rule in $rules) {
        try {
            $bytes = [System.IO.File]::ReadAllBytes($rule.FullName)
            
            # 检查BOM
            if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
                Add-Issue "WARNING" "Encoding" "文件包含UTF-8 BOM: $($rule.Name)"
                $encodingIssues++
            }
            
            # 检查是否包含乱码（简单检查）
            $content = [System.IO.File]::ReadAllText($rule.FullName)
            if ($content -match "[\x00-\x08\x0B\x0C\x0E-\x1F]") {
                Add-Issue "ERROR" "Encoding" "文件可能包含乱码: $($rule.Name)"
                $encodingIssues++
            }
        }
        catch {
            Add-Issue "ERROR" "Encoding" "无法读取文件: $($rule.Name) - $($_.Exception.Message)"
            $encodingIssues++
        }
    }
    
    if ($encodingIssues -eq 0) {
        Write-ColorOutput "  ✅ 所有文件编码正常" "Green"
    } else {
        Write-ColorOutput "  ⚠️  $encodingIssues 个文件存在编码问题" "Yellow"
    }
    
    return $encodingIssues
}

# ============================================
# 7. 检查规则依赖
# ============================================
function Test-RuleDependencies {
    Write-ColorOutput "`n🔍 [7/8] 检查规则依赖关系..." "Cyan"
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $dependencyIssues = 0
    
    foreach ($rule in $rules) {
        $content = Get-Content $rule.FullName -Raw -ErrorAction SilentlyContinue
        
        # 查找dependencies字段
        if ($content -match "dependencies:\s*\r?\n((?:\s+-\s+.+\r?\n)+)") {
            $depsBlock = $Matches[1]
            $deps = [regex]::Matches($depsBlock, '\s+-\s+"?([^">]+\.mdc)')
            
            foreach ($dep in $deps) {
                $depName = $dep.Groups[1].Value -replace "\.mdc.*$", ""
                $depExists = $rules | Where-Object { $_.BaseName -eq $depName }
                
                if (-not $depExists) {
                    Add-Issue "WARNING" "Dependency" "依赖文件不存在: $($rule.Name) 依赖 $($dep.Groups[1].Value)"
                    $dependencyIssues++
                }
            }
        }
    }
    
    if ($dependencyIssues -eq 0) {
        Write-ColorOutput "  ✅ 所有依赖关系有效" "Green"
    } else {
        Write-ColorOutput "  ⚠️  $dependencyIssues 个依赖问题" "Yellow"
    }
    
    return $dependencyIssues
}

# ============================================
# 8. 检查文件完整性
# ============================================
function Test-FileIntegrity {
    Write-ColorOutput "`n🔍 [8/8] 检查文件完整性..." "Cyan"
    
    $rules = Get-ChildItem -Path $RulesPath -Filter "*.mdc" -Recurse -ErrorAction SilentlyContinue
    $integrityIssues = 0
    
    foreach ($rule in $rules) {
        $content = Get-Content $rule.FullName -Raw -ErrorAction SilentlyContinue
        
        # 检查文件是否为空
        if ([string]::IsNullOrWhiteSpace($content)) {
            Add-Issue "ERROR" "Integrity" "文件为空: $($rule.Name)"
            $integrityIssues++
            continue
        }
        
        # 检查是否包含标题
        if ($content -notmatch "^#\s+.+") {
            Add-Issue "WARNING" "Integrity" "文件缺少主标题: $($rule.Name)"
            $integrityIssues++
        }
        
        # 检查文件大小（太小可能不完整）
        if ($rule.Length -lt 100) {
            Add-Issue "WARNING" "Integrity" "文件过小 ($($rule.Length) bytes): $($rule.Name)"
            $integrityIssues++
        }
    }
    
    if ($integrityIssues -eq 0) {
        Write-ColorOutput "  ✅ 所有文件完整性正常" "Green"
    } else {
        Write-ColorOutput "  ⚠️  $integrityIssues 个完整性问题" "Yellow"
    }
    
    return $integrityIssues
}

# ============================================
# 主执行流程
# ============================================
function Main {
    Write-ColorOutput "`n" + ("="*60) "White"
    Write-ColorOutput "  🔍 规则系统一致性验证 v2.0" "Cyan"
    Write-ColorOutput ("="*60) + "`n" "White"
    
    Write-ColorOutput "📁 扫描路径: $RulesPath" "Gray"
    Write-ColorOutput "⏰ 开始时间: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`n" "Gray"
    
    # 执行所有检查
    $checks = @(
        @{ Name = "优先级冲突"; Function = { Test-PriorityConflicts } },
        @{ Name = "版本字段"; Function = { Test-VersionFields } },
        @{ Name = "引用一致性"; Function = { Test-ReferenceConsistency } },
        @{ Name = "优先级范围"; Function = { Test-PriorityRanges } },
        @{ Name = "Frontmatter格式"; Function = { Test-FrontmatterFormat } },
        @{ Name = "文件编码"; Function = { Test-FileEncoding } },
        @{ Name = "规则依赖"; Function = { Test-RuleDependencies } },
        @{ Name = "文件完整性"; Function = { Test-FileIntegrity } }
    )
    
    $results = @{}
    foreach ($check in $checks) {
        $results[$check.Name] = & $check.Function
    }
    
    # 输出结果摘要
    Write-ColorOutput "`n" + ("="*60) "White"
    Write-ColorOutput "  📊 验证结果摘要" "Cyan"
    Write-ColorOutput ("="*60) "White"
    
    $totalErrors = ($script:Issues | Where-Object { $_.Severity -eq "ERROR" }).Count
    $totalWarnings = ($script:Issues | Where-Object { $_.Severity -eq "WARNING" }).Count
    $totalInfo = ($script:Issues | Where-Object { $_.Severity -eq "INFO" }).Count
    
    Write-ColorOutput "`n检查项目统计:" "White"
    foreach ($check in $checks) {
        $count = $results[$check.Name]
        $status = if ($count -eq 0) { "✅" } else { "⚠️" }
        Write-ColorOutput "  $status $($check.Name): $count 个问题" $(if ($count -eq 0) { "Green" } else { "Yellow" })
    }
    
    Write-ColorOutput "`n问题统计:" "White"
    Write-ColorOutput "  ❌ 错误 (ERROR): $totalErrors" $(if ($totalErrors -eq 0) { "Green" } else { "Red" })
    Write-ColorOutput "  ⚠️  警告 (WARNING): $totalWarnings" $(if ($totalWarnings -eq 0) { "Green" } else { "Yellow" })
    Write-ColorOutput "  ℹ️  信息 (INFO): $totalInfo" "Cyan"
    Write-ColorOutput "  📊 总计: $script:TotalIssues 个问题" "White"
    
    # 详细问题列表
    if ($script:TotalIssues -gt 0 -and $Verbose) {
        Write-ColorOutput "`n详细问题列表:" "White"
        foreach ($issue in $script:Issues) {
            $color = switch ($issue.Severity) {
                "ERROR" { "Red" }
                "WARNING" { "Yellow" }
                "INFO" { "Cyan" }
                default { "Gray" }
            }
            Write-ColorOutput "  [$($issue.Severity)] [$($issue.Category)] $($issue.Message)" $color
        }
    }
    
    # 导出报告
    if ($ExportReport) {
        $reportPath = "validation-report-$(Get-Date -Format 'yyyyMMdd-HHmmss').json"
        $report = @{
            Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            TotalIssues = $script:TotalIssues
            Errors = $totalErrors
            Warnings = $totalWarnings
            Info = $totalInfo
            CheckResults = $results
            Issues = $script:Issues
        }
        $report | ConvertTo-Json -Depth 10 | Out-File -FilePath $reportPath -Encoding UTF8
        Write-ColorOutput "`n📄 报告已导出: $reportPath" "Cyan"
    }
    
    # 最终判定
    Write-ColorOutput "`n" + ("="*60) "White"
    if ($totalErrors -eq 0 -and $totalWarnings -eq 0) {
        Write-ColorOutput "  ✅ 规则系统一致性检查通过！" "Green"
        Write-ColorOutput ("="*60) + "`n" "White"
        exit 0
    }
    elseif ($totalErrors -eq 0) {
        Write-ColorOutput "  ⚠️  规则系统存在 $totalWarnings 个警告" "Yellow"
        Write-ColorOutput ("="*60) + "`n" "White"
        exit 1
    }
    else {
        Write-ColorOutput "  ❌ 规则系统存在 $totalErrors 个错误，$totalWarnings 个警告" "Red"
        Write-ColorOutput ("="*60) + "`n" "White"
        exit 2
    }
}

# 执行主函数
Main

