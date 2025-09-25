# MCP Cross-Platform Configuration Sync Script
# Supports Trae, Cursor, Claude and other AI tools

param(
    [string]$Action = "detect",  # detect, sync, backup, restore
    [string]$SourcePlatform = "auto",  # auto, trae, cursor, claude
    [string[]]$TargetPlatforms = @("all"),  # all, trae, cursor, claude
    [switch]$DryRun = $false,  # Show operations only, do not execute
    [switch]$Verbose = $false  # Verbose output
)

# MCP Configuration file paths
$MCPConfigs = @{
    "Trae" = @{
        "Path" = "$env:USERPROFILE\AppData\Roaming\Trae\User\mcp.json"
        "Name" = "Trae AI"
        "Format" = "JSON"
    }
    "TraeCN" = @{
        "Path" = "$env:USERPROFILE\AppData\Roaming\Trae CN\User\mcp.json"
        "Name" = "Trae AI (Chinese)"
        "Format" = "JSON"
    }
    "Cursor" = @{
        "Path" = "$env:USERPROFILE\AppData\Roaming\Cursor\User\globalStorage\cursor.mcp\mcp_settings.json"
        "Name" = "Cursor IDE"
        "Format" = "JSON"
    }
    "Claude" = @{
        "Path" = "$env:USERPROFILE\.claude\mcp_settings.json"
        "Name" = "Claude Desktop"
        "Format" = "JSON"
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

# Detect installed AI tools
function Get-InstalledAITools {
    $installedTools = @()
    
    foreach ($tool in $MCPConfigs.Keys) {
        $configPath = $MCPConfigs[$tool].Path
        $configDir = Split-Path $configPath -Parent
        
        if (Test-Path $configDir) {
            $installedTools += $tool
            if ($Verbose) {
                Write-ColorOutput "Found: $($MCPConfigs[$tool].Name)" "Green"
            }
        }
    }
    
    return $installedTools
}

# Read MCP configuration
function Get-MCPConfig {
    param([string]$Platform)
    
    $configPath = $MCPConfigs[$Platform].Path
    
    if (-not (Test-Path $configPath)) {
        return $null
    }
    
    try {
        $content = Get-Content $configPath -Raw -Encoding UTF8
        $config = $content | ConvertFrom-Json
        return $config
    }
    catch {
        Write-ColorOutput "Failed to read $Platform config: $($_.Exception.Message)" "Red"
        return $null
    }
}

# Analyze MCP configuration
function Analyze-MCPConfig {
    param($Config, [string]$Platform)
    
    if (-not $Config -or -not $Config.mcpServers) {
        return @{
            "ServerCount" = 0
            "Servers" = @()
            "HasFilesystem" = $false
            "HasMemory" = $false
            "HasGithub" = $false
        }
    }
    
    $servers = $Config.mcpServers.PSObject.Properties.Name
    $analysis = @{
        "ServerCount" = $servers.Count
        "Servers" = $servers
        "HasFilesystem" = $servers -contains "filesystem" -or ($servers | Where-Object { $_ -like "*filesystem*" }).Count -gt 0
        "HasMemory" = $servers -contains "memory"
        "HasGithub" = $servers -contains "github"
        "HasContext7" = $servers -contains "context7"
        "HasPlaywright" = $servers -contains "Playwright" -or $servers -contains "playwright"
        "HasDatabase" = ($servers | Where-Object { $_ -like "*mysql*" -or $_ -like "*redis*" }).Count -gt 0
    }
    
    return $analysis
}

# Detect all platforms MCP status
function Detect-AllMCPStatus {
    Write-ColorOutput "`nDetecting MCP configuration status for all AI tools..." "Cyan"
    Write-ColorOutput "=" * 60 "Gray"
    
    $installedTools = Get-InstalledAITools
    $allAnalysis = @{}
    
    if ($installedTools.Count -eq 0) {
        Write-ColorOutput "No supported AI tools detected" "Red"
        return
    }
    
    Write-ColorOutput "`nInstalled AI Tools:" "Yellow"
    foreach ($tool in $installedTools) {
        Write-ColorOutput "  • $($MCPConfigs[$tool].Name)" "White"
    }
    
    Write-ColorOutput "`nMCP Configuration Analysis:" "Yellow"
    
    foreach ($tool in $installedTools) {
        $config = Get-MCPConfig -Platform $tool
        $analysis = Analyze-MCPConfig -Config $config -Platform $tool
        $allAnalysis[$tool] = $analysis
        
        Write-ColorOutput "`n$($MCPConfigs[$tool].Name):" "Cyan"
        
        if ($analysis.ServerCount -eq 0) {
            Write-ColorOutput "  No MCP servers configured" "Red"
        } else {
            Write-ColorOutput "  Configured $($analysis.ServerCount) MCP servers" "Green"
            Write-ColorOutput "  Servers: $($analysis.Servers -join ', ')" "Gray"
            
            # Check key servers
            $keyServers = @()
            if ($analysis.HasFilesystem) { $keyServers += "Filesystem" }
            if ($analysis.HasMemory) { $keyServers += "Memory" }
            if ($analysis.HasGithub) { $keyServers += "GitHub" }
            if ($analysis.HasContext7) { $keyServers += "Context7" }
            if ($analysis.HasPlaywright) { $keyServers += "Playwright" }
            if ($analysis.HasDatabase) { $keyServers += "Database" }
            
            if ($keyServers.Count -gt 0) {
                Write-ColorOutput "  Key features: $($keyServers -join ', ')" "Green"
            }
        }
    }
    
    # Generate recommendations
    Write-ColorOutput "`nSmart Recommendations:" "Yellow"
    
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
        Write-ColorOutput "  Best configuration: $($MCPConfigs[$bestTool].Name) ($maxServers servers)" "Green"
        
        # Check missing servers in other platforms
        foreach ($tool in $allAnalysis.Keys) {
            if ($tool -ne $bestTool -and $allAnalysis[$tool].ServerCount -lt $maxServers) {
                $missing = $maxServers - $allAnalysis[$tool].ServerCount
                Write-ColorOutput "  $($MCPConfigs[$tool].Name) can add $missing servers" "Yellow"
            }
        }
        
        Write-ColorOutput "`nSuggested Actions:" "Cyan"
        Write-ColorOutput "  • Run: .\mcp-cross-platform-sync.ps1 -Action sync -SourcePlatform $bestTool" "White"
        Write-ColorOutput "  • Or use AI command: 'Sync MCP Configuration'" "White"
    } else {
        Write-ColorOutput "  No MCP servers configured on any platform" "Red"
        Write-ColorOutput "  Suggestion: Configure MCP environment on one platform first" "Yellow"
    }
    
    return $allAnalysis
}

# Main execution logic
function Main {
    Write-ColorOutput "MCP Cross-Platform Configuration Sync Tool" "Cyan"
    Write-ColorOutput "Supports: Trae, Cursor, Claude and other AI tools" "Gray"
    
    if ($DryRun) {
        Write-ColorOutput "DRY RUN MODE - No files will be modified" "Yellow"
    }
    
    switch ($Action.ToLower()) {
        "detect" {
            Detect-AllMCPStatus
        }
        "sync" {
            Write-ColorOutput "Sync functionality will be implemented in next version" "Yellow"
        }
        default {
            Write-ColorOutput "Unknown action: $Action" "Red"
            Write-ColorOutput "Supported actions: detect, sync" "Gray"
        }
    }
}

# Execute main function
Main