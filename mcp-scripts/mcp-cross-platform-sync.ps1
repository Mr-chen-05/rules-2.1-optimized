# MCP Cross-Platform Configuration Sync Script
# Supports Trae, Cursor, Claude and other AI tools

param(
    [string]$Action = "detect",  # detect, sync, backup, restore, current
    [string]$SourcePlatform = "auto",  # auto, trae, cursor, claude
    [string[]]$TargetPlatforms = @("all"),  # all, trae, cursor, claude
    [switch]$DryRun = $false,  # Show operations only, do not execute
    [switch]$Verbose = $false,  # Verbose output
    [int]$CacheTTLSeconds = 3600,
    [switch]$Force = $false
)

# MCP Configuration file paths
$MCPConfigs = @{
    "Trae" = @{
        "ConfigPath" = "$env:USERPROFILE\AppData\Roaming\Trae\User\mcp.json"
        "Name" = "Trae AI"
        "Format" = "JSON"
        "ProcessNames" = @("Trae")
        "WindowTitle" = "*Trae*"
    }
    "TraeCN" = @{
        "ConfigPath" = "$env:USERPROFILE\AppData\Roaming\Trae CN\User\mcp.json"
        "Name" = "Trae AI (Chinese)"
        "Format" = "JSON"
        "ProcessNames" = @("Trae CN")
        "WindowTitle" = "*Trae CN*"
    }
    "Cursor" = @{
        "ConfigPath" = "$env:USERPROFILE\AppData\Roaming\Cursor\User\globalStorage\cursor.mcp\mcp_settings.json"
        "Name" = "Cursor IDE"
        "Format" = "JSON"
        "ProcessNames" = @("Cursor")
        "WindowTitle" = "*Cursor*"
    }
    "Claude" = @{
        "ConfigPath" = "$env:USERPROFILE\.claude\mcp_settings.json"
        "Name" = "Claude Desktop"
        "Format" = "JSON"
        "ProcessNames" = @("Claude")
        "WindowTitle" = "*Claude*"
    }
}

# Color output function
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Unified cache file path helper (shared by detect and clearcache)
function Get-CacheFilePath {
    $scriptDir = $PSScriptRoot
    if (-not $scriptDir) {
        $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    }
    $rootDir = Split-Path -Parent $scriptDir
    $cacheDir = Join-Path $rootDir ".cache"
    if (-not (Test-Path $cacheDir)) { New-Item -ItemType Directory -Path $cacheDir | Out-Null }
    return (Join-Path $cacheDir "mcp-status-cache.json")
}

# Smart detection of current running AI tools
function Get-CurrentAITool {
    $detectedTools = @()
    
    # Method 1: Process detection
    $processes = Get-Process -ErrorAction SilentlyContinue
    foreach ($config in $MCPConfigs.GetEnumerator()) {
        $toolName = $config.Key
        $toolConfig = $config.Value
        
        # Check process names
        if ($toolConfig.ProcessNames) {
            foreach ($processName in $toolConfig.ProcessNames) {
                $matchingProcesses = $processes | Where-Object { $_.ProcessName -like "*$processName*" }
                if ($matchingProcesses) {
                    $detectedTools += @{
                        Tool = $toolName
                        Method = "Process"
                        Confidence = "High"
                        Details = "Process: $($matchingProcesses.Count) $processName instances"
                    }
                }
            }
        }
    }
    
    # Method 2: Recent config file modification
    foreach ($config in $MCPConfigs.GetEnumerator()) {
        $toolName = $config.Key
        $toolConfig = $config.Value
        
        if (Test-Path $toolConfig.ConfigPath) {
            $fileInfo = Get-Item $toolConfig.ConfigPath
            $currentTime = Get-Date
            
            # Fixed time calculation
            try {
                $timeDiff = $currentTime - $fileInfo.LastWriteTime
                if ($timeDiff.TotalHours -le 24) {
                    $detectedTools += @{
                        Tool = $toolName
                        Method = "Recent Config"
                        Confidence = "Medium"
                        Details = "Config modified $([math]::Round($timeDiff.TotalHours, 1)) hours ago"
                    }
                }
            }
            catch {
                # Ignore time calculation errors
            }
        }
    }
    
    return $detectedTools
}

function Show-CurrentAIToolDetails {
    $detectedTools = Get-CurrentAITool
    
    Write-Host "Detected current running AI tools:" -ForegroundColor Green
    Write-Host "==================================================" -ForegroundColor Green
    
    if ($detectedTools.Count -eq 0) {
        Write-Host "No AI tools currently detected as running." -ForegroundColor Yellow
        return
    }
    
    # Group by tool
    $groupedTools = $detectedTools | Group-Object Tool
    
    foreach ($group in $groupedTools) {
        $toolName = $group.Name
        
        # Check if tool name is empty
        if ([string]::IsNullOrEmpty($toolName)) {
            continue
        }
        
        # Check if tool exists in MCPConfigs
        if (-not $MCPConfigs.ContainsKey($toolName)) {
            Write-Host "$toolName" -ForegroundColor Red
            Write-Host "   Detection method: Unknown"
            Write-Host "   Confidence: Low"
            Write-Host "   Details: Tool not in configuration list"
            Write-Host ""
            continue
        }
        
        $toolInfo = $MCPConfigs[$toolName]
        
        Write-Host "$toolName" -ForegroundColor Cyan
        
        foreach ($detection in $group.Group) {
            Write-Host "   Detection method: $($detection.Method)"
            Write-Host "   Confidence: $($detection.Confidence)"
            Write-Host "   Details: $($detection.Details)"
        }
        Write-Host ""
    }
    
    # Show primary detection result
    $primaryTool = $detectedTools | Where-Object { $_.Confidence -eq "High" } | Select-Object -First 1
    if ($primaryTool) {
        Write-Host "Primary detection result: $($primaryTool.Tool)" -ForegroundColor Green
        Write-Host ""
        
        # Show MCP configuration details for this tool
        if ($MCPConfigs.ContainsKey($primaryTool.Tool)) {
            $configPath = $MCPConfigs[$primaryTool.Tool].ConfigPath
            if (Test-Path $configPath) {
                try {
                    $mcpConfig = Get-Content $configPath -Raw | ConvertFrom-Json
                    if ($mcpConfig.mcpServers) {
                        $serverCount = ($mcpConfig.mcpServers | Get-Member -MemberType NoteProperty).Count
                        $serverNames = ($mcpConfig.mcpServers | Get-Member -MemberType NoteProperty).Name -join ", "
                        
                        Write-Host "Current MCP configuration details:" -ForegroundColor Yellow
                        Write-Host "   Configured $serverCount MCP servers"
                        Write-Host "   Server list: $serverNames"
                        
                        # Analyze server types
                        $coreFeatures = @()
                        if ($serverNames -match "memory") { $coreFeatures += "Memory" }
                        if ($serverNames -match "github") { $coreFeatures += "GitHub" }
                        if ($serverNames -match "context7") { $coreFeatures += "Context7" }
                        if ($serverNames -match "playwright") { $coreFeatures += "Browser Automation" }
                        if ($serverNames -match "mysql|redis") { $coreFeatures += "Database" }
                        
                        if ($coreFeatures.Count -gt 0) {
                            Write-Host "   Core features: $($coreFeatures -join ", ")"
                        }
                    }
                    else {
                        Write-Host "Current MCP configuration: No MCP servers configured" -ForegroundColor Yellow
                    }
                }
                catch {
                    Write-Host "Current MCP configuration: Unable to read configuration" -ForegroundColor Red
                }
                
                Write-Host ""
                Write-Host "Configuration file path:" -ForegroundColor Gray
                Write-Host "   $configPath"
            }
        }
    }
}

# Detect installed AI tools
function Get-InstalledAITools {
    $installedTools = @()
    
    foreach ($tool in $MCPConfigs.Keys) {
        $configPath = $MCPConfigs[$tool].ConfigPath
        $configDir = Split-Path $configPath -Parent
        
        if (Test-Path $configDir) {
            $installedTools += $tool
            if ($Verbose) {
                Write-ColorOutput -Message "Found: $($MCPConfigs[$tool].Name)" -Color "Green"
            }
        }
    }
    
    return $installedTools
}

# Read MCP configuration
function Get-MCPConfig {
    param([string]$Platform)
    
    $configPath = $MCPConfigs[$Platform].ConfigPath
    
    if (-not (Test-Path $configPath)) {
        return $null
    }
    
    try {
        $content = Get-Content $configPath -Raw -Encoding UTF8
        $config = $content | ConvertFrom-Json
        return $config
    }
    catch {
        Write-ColorOutput -Message "Failed to read $Platform config: $($_.Exception.Message)" -Color "Red"
        return $null
    }
}

# Analyze MCP configuration
function Analyze-MCPConfig {
    param($Config, [string]$Platform)
    
    if (-not $Config -or -not $Config.mcpServers) {
        return @{
            ServerCount = 0
            Servers = @()
            HasFilesystem = $false
            HasMemory = $false
            HasGithub = $false
            HasContext7 = $false
            HasPlaywright = $false
            HasDatabase = $false
        }
    }
    
    $servers = $Config.mcpServers.PSObject.Properties.Name
    $analysis = @{
        ServerCount = $servers.Count
        Servers = $servers
        HasFilesystem = $servers -contains "filesystem" -or ($servers | Where-Object { $_ -like "*filesystem*" }).Count -gt 0
        HasMemory = $servers -contains "memory"
        HasGithub = $servers -contains "github"
        HasContext7 = $servers -contains "context7"
        HasPlaywright = $servers -contains "Playwright" -or $servers -contains "playwright"
        HasDatabase = ($servers | Where-Object { $_ -like "*mysql*" -or $_ -like "*redis*" }).Count -gt 0
    }
    
    return $analysis
}

# Detect all platforms MCP status
function Detect-AllMCPStatus {
    Write-ColorOutput "`nDetecting MCP configuration status for all AI tools..." -Color "Cyan"
    Write-ColorOutput -Message ("=" * 60) -Color "Gray"
    
    $installedTools = Get-InstalledAITools
    $allAnalysis = @{}
    
    if ($installedTools.Count -eq 0) {
        Write-ColorOutput "No supported AI tools detected" -Color "Red"
        return
    }
    
    Write-ColorOutput "`nInstalled AI Tools:" -Color "Yellow"
    foreach ($tool in $installedTools) {
        Write-ColorOutput "  * $($MCPConfigs[$tool].Name)" -Color "White"
    }
    
    Write-ColorOutput "`nMCP Configuration Analysis:" -Color "Yellow"
    
    foreach ($tool in $installedTools) {
        $config = Get-MCPConfig -Platform $tool
        $analysis = Analyze-MCPConfig -Config $config -Platform $tool
        $allAnalysis[$tool] = $analysis
        
        Write-ColorOutput "`n$($MCPConfigs[$tool].Name):" -Color "Cyan"
        
        if ($analysis.ServerCount -eq 0) {
            Write-ColorOutput "  No MCP servers configured" -Color "Red"
        } else {
            Write-ColorOutput "  Configured $($analysis.ServerCount) MCP servers" -Color "Green"
            Write-ColorOutput "  Servers: $($analysis.Servers -join ', ')" -Color "Gray"
            
            # Check key servers
            $keyServers = @()
            if ($analysis.HasFilesystem) { $keyServers += "Filesystem" }
            if ($analysis.HasMemory) { $keyServers += "Memory" }
            if ($analysis.HasGithub) { $keyServers += "GitHub" }
            if ($analysis.HasContext7) { $keyServers += "Context7" }
            if ($analysis.HasPlaywright) { $keyServers += "Playwright" }
            if ($analysis.HasDatabase) { $keyServers += "Database" }
            
            if ($keyServers.Count -gt 0) {
                Write-ColorOutput "  Key features: $($keyServers -join ', ')" -Color "Green"
            }
            
            # Memory is optional; absence should not be treated as a problem
            if (-not $analysis.HasMemory) {
                Write-ColorOutput "  Memory: Optional (not detected but does not affect usage; Recorder takes priority)" -Color "Yellow"
            }
        }
    }
    
    # Generate recommendations
    Write-ColorOutput -Message "`nSmart Recommendations:" -Color "Yellow"
    
    $bestConfig = $null
    $bestTool = $null
    $maxServers = 0
    
    foreach ($tool in $allAnalysis.Keys) {
        if ($allAnalysis[$tool].ServerCount -gt $maxServers) {
            $maxServers = $allAnalysis[$tool].ServerCount
            $bestTool = $tool
            $bestConfig = $allAnalysis[$tool]
        }
    }
    
    if ($bestTool) {
        $bestSummaryMessage = "  Best configuration: " + $MCPConfigs[$bestTool].Name + " - servers: " + $maxServers
        Write-ColorOutput -Message $bestSummaryMessage -Color "Green"
        
        # Check missing servers in other platforms
        foreach ($tool in $allAnalysis.Keys) {
            if ($tool -ne $bestTool -and $allAnalysis[$tool].ServerCount -lt $maxServers) {
                $missing = $maxServers - $allAnalysis[$tool].ServerCount
                Write-ColorOutput "  $($MCPConfigs[$tool].Name) can add $missing servers" -Color "Yellow"
            }
        }
        
        Write-ColorOutput -Message "`nSuggested Actions:" -Color "Cyan"
        Write-ColorOutput "  * Run: .\mcp-cross-platform-sync.ps1 -Action sync -SourcePlatform $bestTool" -Color "White"
        Write-ColorOutput "  * Or use AI command: 'Sync MCP Configuration'" -Color "White"
    } else {
        Write-ColorOutput "  No MCP servers configured on any platform" -Color "Red"
        Write-ColorOutput "  Suggestion: Configure MCP environment on one platform first" -Color "Yellow"
    }
    
    return $allAnalysis
}

# Main execution logic
function Main {
    Write-ColorOutput "MCP Cross-Platform Configuration Sync Tool" -Color "Cyan"
    Write-ColorOutput "Supports: Trae, Cursor, Claude and other AI tools" -Color "Gray"
    
    if ($DryRun) {
        Write-ColorOutput "DRY RUN MODE - No files will be modified" -Color "Yellow"
    }
    
    switch ($Action.ToLower()) {
        "detect" {
            # Using global Get-CacheFilePath
            
            function Save-StatusCache {
                param([string]$summary, $analysis)
                $cacheFile = Get-CacheFilePath
                $payload = @{
                    lastCheckAt = (Get-Date).ToString("s")
                    lastAction = "detect"
                    summary = $summary
                    analysis = $analysis
                }
                $json = $payload | ConvertTo-Json -Depth 6
                Set-Content -Path $cacheFile -Value $json -Encoding UTF8
            }
            
            function Load-StatusCache {
                $cacheFile = Get-CacheFilePath
                if (Test-Path $cacheFile) {
                    try { return Get-Content -Path $cacheFile -Raw | ConvertFrom-Json } catch { return $null }
                }
                return $null
            }
            if (-not $Force) {
                $cache = Load-StatusCache
                if ($cache -and $cache.lastAction -eq "detect") {
                    try {
                        $last = [datetime]::Parse($cache.lastCheckAt)
                        $age = (New-TimeSpan -Start $last -End (Get-Date)).TotalSeconds
                        if ($age -le $CacheTTLSeconds) {
                            Write-ColorOutput ("Reusing cached detection (age: " + [math]::Round($age) + "s). Use --Force to override") -Color "Yellow"
                            if ($cache.summary) { Write-ColorOutput ("Cached summary: " + $cache.summary) -Color "Gray" }
                            return
                        }
                    } catch {}
                }
            }
            $allAnalysis = Detect-AllMCPStatus
            # Compute summary for cache
            $bestTool = $null; $maxServers = 0
            foreach ($tool in $allAnalysis.Keys) {
                if ($allAnalysis[$tool].ServerCount -gt $maxServers) {
                    $maxServers = $allAnalysis[$tool].ServerCount
                    $bestTool = $tool
                }
            }
            if ($bestTool) {
                 $summary = "Best configuration: " + $MCPConfigs[$bestTool].Name + " - servers: " + $maxServers
             } else {
                 $summary = "No MCP servers configured on any platform"
             }
            Save-StatusCache -summary $summary -analysis $allAnalysis
        }
        "current" {
            Show-CurrentAIToolDetails
        }
        "sync" {
            Write-ColorOutput -Message "Sync functionality will be implemented in next version" -Color "Yellow"
        }
        "clearcache" {
            $cacheFile = Get-CacheFilePath
            if (Test-Path $cacheFile) {
                try {
                    Remove-Item -Path $cacheFile -Force
                    Write-ColorOutput -Message "Cache cleared: $cacheFile" -Color "Green"
                } catch {
                    Write-ColorOutput -Message "Failed to clear cache: $($_.Exception.Message)" -Color "Red"
                }
            } else {
                Write-ColorOutput -Message "No cache file found to clear." -Color "Yellow"
            }
        }
        default {
            Write-ColorOutput -Message "Unknown action: $Action" -Color "Red"
            Write-ColorOutput -Message "Supported actions: detect, current, sync, clearCache" -Color "Gray"
        }
    }
}

# Execute main function
Main