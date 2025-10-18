# Lists cache files for MCP scripts according to new cache strategy (Option B)
# Priority: MCP_CACHE_DIR -> projectRoot/.cache -> TEMP fallback

$cacheDir = $env:MCP_CACHE_DIR
if ([string]::IsNullOrWhiteSpace($cacheDir)) {
  if ($PSScriptRoot) {
    $projectRoot = Split-Path -Parent $PSScriptRoot
  } else {
    $projectRoot = (Get-Location).Path
  }
  $cacheDir = Join-Path $projectRoot '.cache'
}

Write-Host "Cache dir: $cacheDir"
if (Test-Path $cacheDir) {
  Get-ChildItem -Path $cacheDir -Force | Select-Object Name, LastWriteTime, Length | Format-Table -AutoSize
} else {
  Write-Host 'Cache directory not found'
}