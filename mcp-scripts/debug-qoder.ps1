# Debug script for Qoder detection
$MCPConfigs = @{
    Qoder = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Qoder\SharedClientCache\mcp.json"
        Name = "Qoder AI Editor"
        Format = "JSON"
        ProcessNames = @("Qoder", "qoder")
        WindowTitle = "*Qoder*"
    }
}

Write-Host "=== Qoder Detection Debug ===" -ForegroundColor Cyan
Write-Host ""

$config = $MCPConfigs["Qoder"]
Write-Host "Config Path: $($config.ConfigPath)" -ForegroundColor Yellow
Write-Host "Config Exists: $(Test-Path $config.ConfigPath)" -ForegroundColor $(if (Test-Path $config.ConfigPath) { "Green" } else { "Red" })

if (Test-Path $config.ConfigPath) {
    Write-Host "Config file size: $((Get-Item $config.ConfigPath).Length) bytes" -ForegroundColor Green
    
    try {
        $content = Get-Content $config.ConfigPath | ConvertFrom-Json
        $serverCount = 0
        if ($content.mcpServers) {
            $serverCount = $content.mcpServers.PSObject.Properties.Count
        }
        Write-Host "MCP Servers found: $serverCount" -ForegroundColor Green
        
        if ($serverCount -gt 0) {
            Write-Host "Server names:" -ForegroundColor Green
            $content.mcpServers.PSObject.Properties.Name | ForEach-Object {
                Write-Host "  - $_" -ForegroundColor White
            }
        }
    } catch {
        Write-Host "Error reading config: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Process Detection:" -ForegroundColor Yellow
foreach ($processName in $config.ProcessNames) {
    $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($processes) {
        Write-Host "  Found process: $processName" -ForegroundColor Green
        $processes | ForEach-Object {
            Write-Host "    PID: $($_.Id), Path: $($_.Path)" -ForegroundColor White
        }
    } else {
        Write-Host "  Process not found: $processName" -ForegroundColor Red
    }
}