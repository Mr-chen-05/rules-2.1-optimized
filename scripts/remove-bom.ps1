# Remove BOM from .mdc files
# 移除 .mdc 文件的 BOM 编码，解决中文乱码问题

param(
    [string]$RootPath = "."
)

Write-Host "开始移除 .mdc 文件的 BOM 编码..." -ForegroundColor Green

# 获取所有 .mdc 文件
$mdcFiles = Get-ChildItem -Path $RootPath -Recurse -Filter "*.mdc" | Where-Object { !$_.PSIsContainer }

$processedCount = 0
$fixedCount = 0

foreach ($file in $mdcFiles) {
    $processedCount++
    Write-Host "处理文件 [$processedCount/$($mdcFiles.Count)]: $($file.FullName)" -ForegroundColor Cyan
    
    try {
        # 读取文件内容（以字节形式）
        $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
        
        # 检查是否有 UTF-8 BOM (EF BB BF)
        $hasBOM = $false
        if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
            $hasBOM = $true
            Write-Host "  发现 BOM，正在移除..." -ForegroundColor Yellow
            
            # 移除前3个字节（BOM）
            $newBytes = $bytes[3..($bytes.Length - 1)]
            
            # 写回文件（无 BOM 的 UTF-8）
            [System.IO.File]::WriteAllBytes($file.FullName, $newBytes)
            
            $fixedCount++
            Write-Host "  ✓ BOM 已移除" -ForegroundColor Green
        } else {
            Write-Host "  ✓ 无需处理（无 BOM）" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "  ✗ 处理失败: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n处理完成！" -ForegroundColor Green
Write-Host "总文件数: $processedCount" -ForegroundColor White
Write-Host "修复文件数: $fixedCount" -ForegroundColor Green
Write-Host "无需修复: $($processedCount - $fixedCount)" -ForegroundColor Gray

if ($fixedCount -gt 0) {
    Write-Host "`n建议重新运行验证脚本确认修复效果。" -ForegroundColor Yellow
}