# 批量添加规则版本信息脚本 v2.0
# 为所有缺少版本信息的 .mdc 文件添加统一的版本管理块

param(
    [string]$Version = "2.6.0",
    [string]$Date = "2025-10-19",
    [string]$Author = "system",
    [string]$Status = "stable"
)

Write-Host "════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "   批量添加规则版本信息 v2.0" -ForegroundColor Green
Write-Host "════════════════════════════════════════════════`n" -ForegroundColor Cyan

$TotalFiles = 0
$UpdatedFiles = 0
$SkippedFiles = 0
$ErrorFiles = 0

# 处理所有 .mdc 文件
$AllFiles = Get-ChildItem -Path "global-rules","project-rules" -Filter "*.mdc" -Recurse

foreach ($File in $AllFiles) {
    $TotalFiles++
    
    try {
        # 读取文件内容（UTF-8 无 BOM）
        $Content = Get-Content $File.FullName -Raw -Encoding UTF8
        
        # 检查是否已有版本信息
        if ($Content -match 'version:\s*"') {
            Write-Host "  ⏭️  跳过（已有版本）: $($File.Name)" -ForegroundColor Yellow
            $SkippedFiles++
            continue
        }
        
        # 检查是否有 frontmatter
        if ($Content -notmatch '^---\s*\r?\n') {
            Write-Host "  ⚠️  跳过（无frontmatter）: $($File.Name)" -ForegroundColor Yellow
            $SkippedFiles++
            continue
        }
        
        # 提取 frontmatter 和正文
        if ($Content -match '^---\s*\r?\n(.*?)\r?\n---\s*\r?\n(.*)$' -and $Matches.Count -ge 3) {
            $Frontmatter = $Matches[1]
            $Body = $Matches[2]
            
            # 构建版本信息块
            $VersionBlock = @"

# Version Management
version: "$Version"
last_updated: "$Date"
author: "$Author"
status: "$Status"
compatibility: "rule-system >= 2.0"

changelog:
  - version: "$Version"
    date: "$Date"
    changes:
      - "添加版本管理系统"
      - "规范化规则文件结构"
"@
            
            # 组装新内容
            $NewContent = "---`r`n" + $Frontmatter.TrimEnd() + $VersionBlock + "`r`n---`r`n" + $Body
            
            # 写入文件（UTF-8 无 BOM）
            [System.IO.File]::WriteAllText($File.FullName, $NewContent, [System.Text.UTF8Encoding]::new($false))
            
            Write-Host "  ✅ 已更新: $($File.Name)" -ForegroundColor Green
            $UpdatedFiles++
        }
        else {
            Write-Host "  ❌ 解析失败: $($File.Name)" -ForegroundColor Red
            $ErrorFiles++
        }
        
    } catch {
        Write-Host "  ❌ 错误: $($File.Name) - $($_.Exception.Message)" -ForegroundColor Red
        $ErrorFiles++
    }
}

Write-Host "`n════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "📊 执行结果:" -ForegroundColor Green
Write-Host "  📁 总文件数: $TotalFiles" -ForegroundColor White
Write-Host "  ✅ 已更新: $UpdatedFiles" -ForegroundColor Green
Write-Host "  ⏭️  已跳过: $SkippedFiles" -ForegroundColor Yellow
Write-Host "  ❌ 错误: $ErrorFiles" -ForegroundColor Red
Write-Host "════════════════════════════════════════════════`n" -ForegroundColor Cyan

if ($ErrorFiles -eq 0) {
    Write-Host "✅ 批量添加完成！" -ForegroundColor Green
    exit 0
} else {
    Write-Host "⚠️  部分文件处理失败，请检查错误信息" -ForegroundColor Yellow
    exit 1
}

