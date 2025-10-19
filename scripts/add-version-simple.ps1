# Version Add Script v3.0
param(
    [string]$Version = "2.6.0",
    [string]$Date = "2025-10-19"
)

$UpdatedCount = 0
$SkippedCount = 0
$ErrorCount = 0

Write-Host "Starting batch version addition..." -ForegroundColor Cyan

$VersionBlock = @"

# Version Management
version: "$Version"
last_updated: "$Date"
author: "system"
status: "stable"
compatibility: "rule-system >= 2.0"

changelog:
  - version: "$Version"
    date: "$Date"
    changes:
      - "Add version management system"
      - "Standardize rule file structure"
"@

$Files = Get-ChildItem -Path "global-rules","project-rules" -Filter "*.mdc" -Recurse

foreach ($File in $Files) {
    try {
        $Bytes = [System.IO.File]::ReadAllBytes($File.FullName)
        $Content = [System.Text.Encoding]::UTF8.GetString($Bytes)
        
        if ($Content -match 'version:\s*"') {
            Write-Host "Skip (has version): $($File.Name)" -ForegroundColor Yellow
            $SkippedCount++
            continue
        }
        
        $FirstDash = $Content.IndexOf("---")
        if ($FirstDash -lt 0) {
            Write-Host "Skip (no frontmatter): $($File.Name)" -ForegroundColor Yellow
            $SkippedCount++
            continue
        }
        
        $SecondDash = $Content.IndexOf("---", $FirstDash + 3)
        if ($SecondDash -lt 0) {
            Write-Host "Error (incomplete frontmatter): $($File.Name)" -ForegroundColor Red
            $ErrorCount++
            continue
        }
        
        $NewContent = $Content.Substring(0, $SecondDash) + $VersionBlock + "`n" + $Content.Substring($SecondDash)
        
        $Utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($File.FullName, $NewContent, $Utf8NoBom)
        
        Write-Host "Updated: $($File.Name)" -ForegroundColor Green
        $UpdatedCount++
        
    } catch {
        Write-Host "Error: $($File.Name) - $($_.Exception.Message)" -ForegroundColor Red
        $ErrorCount++
    }
}

Write-Host "`n===============================" -ForegroundColor Cyan
Write-Host "Total: $($Files.Count) files" -ForegroundColor White
Write-Host "Updated: $UpdatedCount" -ForegroundColor Green
Write-Host "Skipped: $SkippedCount" -ForegroundColor Yellow
Write-Host "Errors: $ErrorCount" -ForegroundColor Red
Write-Host "===============================" -ForegroundColor Cyan
