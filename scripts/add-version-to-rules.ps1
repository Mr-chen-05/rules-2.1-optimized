# 规则文件版本管理批量添加脚本 v1.0
# 为所有 .mdc 规则文件添加版本信息

param(
    [string]$RulesDir = ".",
    [string]$Version = "2.6.0",
    [string]$Author = "system",
    [string]$Status = "stable"
)

$Date = Get-Date -Format "yyyy-MM-dd"
$UpdatedCount = 0
$SkippedCount = 0
$ErrorCount = 0

Write-Host "════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "   规则文件版本管理 - 批量添加工具 v1.0" -ForegroundColor Green
Write-Host "════════════════════════════════════════════════`n" -ForegroundColor Cyan

Write-Host "📋 参数配置:" -ForegroundColor Yellow
Write-Host "  - 规则目录: $RulesDir"
Write-Host "  - 版本号: $Version"
Write-Host "  - 作者: $Author"
Write-Host "  - 状态: $Status"
Write-Host "  - 日期: $Date`n"

# 查找所有 .mdc 文件
$MdcFiles = Get-ChildItem -Path $RulesDir -Filter "*.mdc" -Recurse -File

Write-Host "🔍 找到 $($MdcFiles.Count) 个 .mdc 文件`n" -ForegroundColor Cyan

foreach ($File in $MdcFiles) {
    try {
        Write-Host "📝 处理: $($File.Name)" -NoNewline
        
        $Content = Get-Content $File.FullName -Raw -Encoding UTF8
        
        # 检查是否已有 frontmatter
        if ($Content -notmatch '(?s)^---\s*\n(.*?)\n---') {
            Write-Host " [跳过 - 无frontmatter]" -ForegroundColor Yellow
            $SkippedCount++
            continue
        }
        
        $FrontmatterMatch = [regex]::Match($Content, '(?s)^---\s*\n(.*?)\n---')
        $Frontmatter = $FrontmatterMatch.Groups[1].Value
        
        # 检查是否已有版本字段
        if ($Frontmatter -match 'version:') {
            Write-Host " [跳过 - 已有版本]" -ForegroundColor Yellow
            $SkippedCount++
            continue
        }
        
        # 构建新的版本字段
        $VersionFields = @"

# 版本管理 (Version Management)
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
        
        # 在 frontmatter 末尾添加版本字段
        $NewFrontmatter = $Frontmatter.TrimEnd() + "`n" + $VersionFields
        
        # 替换内容
        $NewContent = $Content -replace '(?s)^---\s*\n(.*?)\n---', "---`n$NewFrontmatter`n---"
        
        # 写回文件
        Set-Content -Path $File.FullName -Value $NewContent -Encoding UTF8 -NoNewline
        
        Write-Host " ✅ 已更新" -ForegroundColor Green
        $UpdatedCount++
        
    } catch {
        Write-Host " ❌ 错误: $($_.Exception.Message)" -ForegroundColor Red
        $ErrorCount++
    }
}

Write-Host "`n════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "📊 执行结果:" -ForegroundColor Green
Write-Host "  ✅ 已更新: $UpdatedCount 个文件" -ForegroundColor Green
Write-Host "  ⏭️  已跳过: $SkippedCount 个文件" -ForegroundColor Yellow
if ($ErrorCount -gt 0) {
    Write-Host "  ❌ 错误: $ErrorCount 个文件" -ForegroundColor Red
}
Write-Host "════════════════════════════════════════════════`n" -ForegroundColor Cyan

Write-Host "✅ 脚本执行完成！" -ForegroundColor Green
