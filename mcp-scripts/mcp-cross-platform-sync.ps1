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
    # 涓绘祦AI缂栬緫鍣?
Trae = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Trae\User\mcp.json"
        Name = "Trae AI"
        Format = "JSON"
        ProcessNames = @("Trae")
        WindowTitle = "*Trae*"
    };
    
    TraeCN = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Trae CN\User\mcp.json"
        Name = "Trae AI (Chinese)"
        Format = "JSON"
        ProcessNames = @("Trae CN")
        WindowTitle = "*Trae CN*"
    };
    Cursor = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Cursor\User\globalStorage\cursor.mcp\mcp_settings.json"
        Name = "Cursor IDE"
        Format = "JSON"
        ProcessNames = @("Cursor")
        WindowTitle = "*Cursor*"
    };
    Claude = @{
        ConfigPath = "$env:USERPROFILE\.claude\mcp_settings.json"
        Name = "Claude Desktop"
        Format = "JSON"
        ProcessNames = @("Claude")
        WindowTitle = "*Claude*"
    };
    Windsurf = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Windsurf\User\mcp.json"
        Name = "Windsurf AI"
        Format = "JSON"
        ProcessNames = @("Windsurf")
        WindowTitle = "*Windsurf*"
    };
    Replit = @{
        ConfigPath = "$env:USERPROFILE\.replit\mcp_config.json"
        Name = "Replit AI"
        Format = "JSON"
        ProcessNames = @("replit")
        WindowTitle = "*Replit*"
    };
    
    # IDE闆嗘垚AI鍔╂墜
SourcegraphCody = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Code\User\globalStorage\sourcegraph.cody-ai\mcp_settings.json"
        Name = "Sourcegraph Cody"
        Format = "JSON"
        ProcessNames = @("Code")
        WindowTitle = "*Visual Studio Code*"
    };
    ContinueDev = @{
        ConfigPath = "$env:USERPROFILE\.continue\mcpServers\mcp.json"
        Name = "Continue.dev"
        Format = "JSON"
        ProcessNames = @("Code")
        WindowTitle = "*Continue*"
    };
    VSCodeCopilot = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Code\User\mcp.json"
        Name = "VSCode GitHub Copilot"
        Format = "JSON"
        ProcessNames = @("Code")
        WindowTitle = "*Visual Studio Code*"
    };
    JetBrainsAI = @{
        ConfigPath = "$env:USERPROFILE\.jetbrains\mcp_settings.json"
        Name = "JetBrains AI Assistant"
        Format = "JSON"
        ProcessNames = @("idea64", "webstorm64", "pycharm64")
        WindowTitle = "*IntelliJ*,*WebStorm*,*PyCharm*"
    };
    Tabnine = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\TabNine\mcp_config.json"
        Name = "Tabnine AI"
        Format = "JSON"
        ProcessNames = @("TabNine")
        WindowTitle = "*Tabnine*"
    };
    
    # 浜戠AI骞冲彴
AmazonQ = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\AmazonQ\settings.json"
        Name = "Amazon Q Developer"
        Format = "JSON"
        ProcessNames = @("amazon-q")
        WindowTitle = "*Amazon Q*"
    };
    GeminiCodeAssist = @{
        ConfigPath = "$env:USERPROFILE\.google\gemini-code-assist\mcp.json"
        Name = "Google Gemini Code Assist"
        Format = "JSON"
        ProcessNames = @("gemini-code")
        WindowTitle = "*Gemini*"
    };
    QodoGen = @{
        ConfigPath = "$env:USERPROFILE\.qodo\mcp_config.json"
        Name = "Qodo Gen (CodiumAI)"
        Format = "JSON"
        ProcessNames = @("qodo", "codium")
        WindowTitle = "*Qodo*,*Codium*"
    };
    
    # 寮€婧怉I宸ュ叿
Aider = @{
        ConfigPath = "$env:USERPROFILE\.aider\mcp_settings.json"
        Name = "Aider AI"
        Format = "JSON"
        ProcessNames = @("aider")
        WindowTitle = "*Aider*"
    };
    CodeGeeX = @{
        ConfigPath = "$env:USERPROFILE\.codegeex\mcp_config.json"
        Name = "CodeGeeX"
        Format = "JSON"
        ProcessNames = @("codegeex")
        WindowTitle = "*CodeGeeX*"
    };
    TabbyML = @{
        ConfigPath = "$env:USERPROFILE\.tabby\mcp_settings.json"
        Name = "Tabby ML"
        Format = "JSON"
        ProcessNames = @("tabby")
        WindowTitle = "*Tabby*"
    };
    Cline = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Code\User\globalStorage\saoudrizwan.claude-dev\settings\cline_mcp_settings.json"
        Name = "Cline (Claude Dev)"
        Format = "JSON"
        ProcessNames = @("Code")
        WindowTitle = "*Cline*"
    };
    
    # OpenAI绯诲垪宸ュ叿
OpenAICodex = @{
        ConfigPath = "$env:USERPROFILE\.openai\codex\mcp_config.json"
        Name = "OpenAI Codex"
        Format = "JSON"
        ProcessNames = @("codex")
        WindowTitle = "*Codex*"
    };
    OpenAICodexCLI = @{
        ConfigPath = "$env:USERPROFILE\.openai\codex-cli\mcp_settings.json"
        Name = "OpenAI Codex CLI"
        Format = "JSON"
        ProcessNames = @("codex-cli")
        WindowTitle = "*Codex CLI*"
    };
    
    # 鑵捐AI宸ュ叿
CodeBuddy = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\CodeBuddy\mcp_settings.json"
        Name = "Tencent CodeBuddy"
        Format = "JSON"
        ProcessNames = @("CodeBuddy", "codebuddy")
        WindowTitle = "*CodeBuddy*"
    };
    CodeBuddyCLI = @{
        ConfigPath = "$env:USERPROFILE\.tencent\codebuddy-cli\mcp_settings.json"
        Name = "Tencent CodeBuddy CLI"
        Format = "JSON"
        ProcessNames = @("codebuddy-cli")
        WindowTitle = "*CodeBuddy CLI*"
    };
    
    # 新兴AI编辑器
Qoder = @{
        ConfigPath = "$env:USERPROFILE\AppData\Roaming\Qoder\SharedClientCache\mcp.json"
        Name = "Qoder AI Editor"
        Format = "JSON"
        ProcessNames = @("Qoder", "qoder")
        WindowTitle = "*Qoder*"
    };
    Void = @{
        ConfigPath = "$env:USERPROFILE\.void\mcp_config.json"
        Name = "Void Editor"
        Format = "JSON"
        ProcessNames = @("void")
        WindowTitle = "*Void*"
    };
    Warp = @{
        ConfigPath = "$env:USERPROFILE\.warp\mcp_settings.json"
        Name = "Warp Terminal"
        Format = "JSON"
        ProcessNames = @("warp")
        WindowTitle = "*Warp*"
    };
    Zed = @{
        ConfigPath = "$env:USERPROFILE\.zed\mcp_config.json"
        Name = "Zed Editor"
        Format = "JSON"
        ProcessNames = @("zed")
        WindowTitle = "*Zed*"
    };
    
    # 楂樼骇AI鍔╂墜
RefactAI = @{
        ConfigPath = "$env:USERPROFILE\.refact\mcp_config.json"
        Name = "Refact.ai"
        Format = "JSON"
        ProcessNames = @("refact")
        WindowTitle = "*Refact*"
    };
    Jules = @{
        ConfigPath = "$env:USERPROFILE\.jules\mcp_settings.json"
        Name = "Jules (Google)"
        Format = "JSON"
        ProcessNames = @("jules")
        WindowTitle = "*Jules*"
    };
    Junie = @{
        ConfigPath = "$env:USERPROFILE\.junie\mcp_config.json"
        Name = "Junie (JetBrains)"
        Format = "JSON"
        ProcessNames = @("junie")
        WindowTitle = "*Junie*"
    };
    KiloCode = @{
        ConfigPath = "$env:USERPROFILE\.kilocode\mcp_settings.json"
        Name = "Kilo Code"
        Format = "JSON"
        ProcessNames = @("kilocode")
        WindowTitle = "*Kilo*"
    };
    Kodu = @{
        ConfigPath = "$env:USERPROFILE\.kodu\mcp_config.json"
        Name = "Kodu AI"
        Format = "JSON"
        ProcessNames = @("kodu")
        WindowTitle = "*Kodu*"
    };
    MarsCode = @{
        ConfigPath = "$env:USERPROFILE\.marscode\mcp_settings.json"
        Name = "MarsCode"
        Format = "JSON"
        ProcessNames = @("marscode")
        WindowTitle = "*MarsCode*"
    };
    Melty = @{
        ConfigPath = "$env:USERPROFILE\.melty\mcp_config.json"
        Name = "Melty AI"
        Format = "JSON"
        ProcessNames = @("melty")
        WindowTitle = "*Melty*"
    };
    Memex = @{
        ConfigPath = "$env:USERPROFILE\.memex\mcp_settings.json"
        Name = "Memex AI"
        Format = "JSON"
        ProcessNames = @("memex")
        WindowTitle = "*Memex*"
    };
    Mentat = @{
        ConfigPath = "$env:USERPROFILE\.mentat\mcp_config.json"
        Name = "Mentat AI"
        Format = "JSON"
        ProcessNames = @("mentat")
        WindowTitle = "*Mentat*"
    };
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
    param(
        [string]$CacheType = "detection"
    )
    # Determine cache base directory with priority:
    # 1) MCP_CACHE_DIR env override
    # 2) Project root .cache (parent of script directory)
    # 3) Fallback to %TEMP%\MCPSync
    $targetDir = $env:MCP_CACHE_DIR
    if ([string]::IsNullOrWhiteSpace($targetDir)) {
        if ($PSScriptRoot) {
            $projectRoot = Split-Path -Parent $PSScriptRoot
            $targetDir = Join-Path $projectRoot ".cache"
        } else {
            $targetDir = Join-Path (Get-Location) ".cache"
        }
    }
    try {
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
    } catch {
        # Fallback to TEMP if creation fails
        $targetDir = Join-Path $env:TEMP "MCPSync"
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
    }

    # Map cache type to filename
    $fileName = switch ($CacheType.ToLower()) {
        "detection" { "detection-cache.json" }
        "report"    { "mcp-status-cache.json" }
        default      { "$CacheType-cache.json" }
    }
    return Join-Path $targetDir $fileName
}

# Cache management functions
function Get-CachedData {
    param(
        [string]$CacheType = "detection",
        [int]$TTLSeconds = 3600
    )
    
    $cacheFile = Get-CacheFilePath -CacheType $CacheType
    if (-not (Test-Path $cacheFile)) {
        return $null
    }
    
    try {
        $cacheData = Get-Content $cacheFile -Raw | ConvertFrom-Json
        $cacheTime = [DateTime]::Parse($cacheData.Timestamp)
        $currentTime = Get-Date
        
        if (($currentTime - $cacheTime).TotalSeconds -lt $TTLSeconds) {
            if ($Verbose) {
                Write-ColorOutput "Using cached data from $($cacheData.Timestamp)" "Yellow"
            }
            return $cacheData.Data
        } else {
            if ($Verbose) {
                Write-ColorOutput "Cache expired, refreshing..." "Yellow"
            }
            Remove-Item $cacheFile -Force
            return $null
        }
    } catch {
        if ($Verbose) {
            Write-ColorOutput "Cache file corrupted, removing..." "Red"
        }
        Remove-Item $cacheFile -Force -ErrorAction SilentlyContinue
        return $null
    }
}

function Set-CachedData {
    param(
        [object]$Data,
        [string]$CacheType = "detection"
    )
    
    $cacheFile = Get-CacheFilePath -CacheType $CacheType
    $toWrite = $null
    if ($CacheType.ToLower() -eq "report") {
        # 写入顶层结构（lastAction/lastCheckAt/summary/analysis）
        $toWrite = $Data
    } else {
        # 通用检测缓存结构
        $toWrite = @{
            Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            Data = $Data
        }
    }
    
    try {
        $toWrite | ConvertTo-Json -Depth 10 | Set-Content $cacheFile -Encoding UTF8
        if ($Verbose) {
            Write-ColorOutput "Data cached to $cacheFile" "Green"
        }
    } catch {
        Write-ColorOutput "Failed to cache data: $($_.Exception.Message)" "Red"
    }
}

function Clear-AllCaches {
    # Clear project cache (.cache) and TEMP fallback
    $dirsToClear = @()
    $envDir = $env:MCP_CACHE_DIR
    if (-not [string]::IsNullOrWhiteSpace($envDir)) {
        $dirsToClear += $envDir
    } else {
        if ($PSScriptRoot) {
            $projectRoot = Split-Path -Parent $PSScriptRoot
        } else {
            $projectRoot = (Get-Location).Path
        }
        $dirsToClear += (Join-Path $projectRoot ".cache")
    }
    # Always include TEMP fallback
    $dirsToClear += (Join-Path $env:TEMP "MCPSync")

    $clearedAny = $false
    foreach ($dir in $dirsToClear | Select-Object -Unique) {
        if (Test-Path $dir) {
            try {
                Remove-Item $dir -Recurse -Force -ErrorAction Stop
                Write-ColorOutput "Cleared cache directory: $dir" "Green"
                $clearedAny = $true
            } catch {
                Write-ColorOutput "Failed to clear '$dir': $($_.Exception.Message)" "Red"
            }
        }
    }
    if (-not $clearedAny) {
        Write-ColorOutput "No cache directories found to clear." "Yellow"
    }
}

# Enhanced detection function with caching
function Get-InstalledPlatforms {
    # Try to get cached data first
    if (-not $Force) {
        $cachedData = Get-CachedData -CacheType "detection" -TTLSeconds $CacheTTLSeconds
        if ($cachedData) {
            return $cachedData
        }
    }
    
    $detectedPlatforms = @()
    
    foreach ($platform in $MCPConfigs.Keys) {
        $config = $MCPConfigs[$platform]
        $detected = $false
        $detectionMethod = "None"
        
        # Method 1: Check if config file exists
        if (Test-Path $config.ConfigPath) {
            $detected = $true
            $detectionMethod = "ConfigFile"
        }
        
        # Method 2: Check running processes
        if (-not $detected -and $config.ProcessNames) {
            foreach ($processName in $config.ProcessNames) {
                $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
                if ($processes) {
                    $detected = $true
                    $detectionMethod = "Process"
                    break
                }
            }
        }
        
        # Method 3: Check window titles (Windows only)
        if (-not $detected -and $config.WindowTitle -and $IsWindows) {
            try {
                Add-Type -TypeDefinition @"
                    using System;
                    using System.Runtime.InteropServices;
                    using System.Text;
                    public class WindowHelper {
                        [DllImport("user32.dll")]
                        public static extern bool EnumWindows(EnumWindowsProc enumProc, IntPtr lParam);
                        [DllImport("user32.dll")]
                        public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);
                        public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
                    }
"@ -ErrorAction SilentlyContinue
                
                $windowTitles = @()
                $enumProc = {
                    param($hWnd, $lParam)
                    $title = New-Object System.Text.StringBuilder 256
                    [WindowHelper]::GetWindowText($hWnd, $title, 256)
                    if ($title.ToString().Trim() -ne "") {
                        $script:windowTitles += $title.ToString()
                    }
                    return $true
                }
                
                [WindowHelper]::EnumWindows($enumProc, [IntPtr]::Zero)
                
                foreach ($titlePattern in $config.WindowTitle.Split(',')) {
                    $pattern = $titlePattern.Trim().Replace('*', '.*')
                    foreach ($title in $windowTitles) {
                        if ($title -match $pattern) {
                            $detected = $true
                            $detectionMethod = "WindowTitle"
                            break
                        }
                    }
                    if ($detected) { break }
                }
            } catch {
                # Silently continue if window detection fails
            }
        }
        
        if ($detected) {
            $detectedPlatforms += @{
                Name = $platform
                DisplayName = $config.Name
                ConfigPath = $config.ConfigPath
                Format = $config.Format
                DetectionMethod = $detectionMethod
                ConfigExists = (Test-Path $config.ConfigPath)
            }
        }
    }
    
    # Cache the results
    Set-CachedData -Data $detectedPlatforms -CacheType "detection"
    
    return $detectedPlatforms
}

# Report building functions
function Extract-ServersFromConfig {
    param(
        [string]$ConfigPath,
        [string]$Format = "JSON"
    )
    $servers = @()
    if (-not (Test-Path $ConfigPath)) { return $servers }
    try {
        $raw = Get-Content $ConfigPath -Raw
        if ($Format -eq "JSON") {
            $obj = $raw | ConvertFrom-Json
            $queue = New-Object System.Collections.Queue
            $queue.Enqueue($obj)
            while ($queue.Count -gt 0) {
                $node = $queue.Dequeue()
                if ($null -eq $node) { continue }
                if ($node.PSObject) {
                    $props = $node.PSObject.Properties
                    foreach ($p in $props) {
                        $nameLower = $p.Name.ToLower()
                        $val = $p.Value
                        if ($nameLower -in @("servers","mcpservers","serverlist")) {
                            if ($val -is [System.Collections.IEnumerable] -and -not ($val -is [string])) {
                                foreach ($item in $val) {
                                    if ($item -is [string]) {
                                        $servers += $item
                                    } elseif ($item.PSObject -and $item.PSObject.Properties["name"]) {
                                        $servers += $item.name
                                    } elseif ($item -is [System.Collections.IDictionary]) {
                                        if ($item.ContainsKey("name")) { $servers += $item["name"] }
                                    }
                                }
                            } elseif ($val.PSObject -or ($val -is [System.Collections.IDictionary])) {
                                # Handle object-based server configurations (like Trae AI)
                                if ($val.PSObject) {
                                    foreach ($serverProp in $val.PSObject.Properties) {
                                        $servers += $serverProp.Name
                                    }
                                } elseif ($val -is [System.Collections.IDictionary]) {
                                    foreach ($key in $val.Keys) {
                                        $servers += $key
                                    }
                                }
                            }
                        } else {
                            if ($val -is [System.Collections.IEnumerable] -and -not ($val -is [string])) {
                                foreach ($elem in $val) { $queue.Enqueue($elem) }
                            } elseif ($val.PSObject -or ($val -is [System.Collections.IDictionary])) {
                                $queue.Enqueue($val)
                            }
                        }
                    }
                } elseif ($node -is [System.Collections.IEnumerable] -and -not ($node -is [string])) {
                    foreach ($elem in $node) { $queue.Enqueue($elem) }
                }
            }
        } else {
            # Best-effort extraction for non-JSON formats
            $matches = Select-String -InputObject $raw -Pattern '"servers"\s*:\s*\[(.*?)\]' -AllMatches
            foreach ($m in $matches) {
                if ($m.Matches.Count -gt 0) {
                    $content = $m.Matches[0].Groups[1].Value
                    $names = ($content -split ',') | ForEach-Object { $_.Trim('" ').Trim() }
                    $servers += $names
                }
            }
        }
    } catch {
        # Ignore parse errors
    }
    $servers = $servers | Where-Object { $_ -and $_.ToString().Trim() -ne "" } | ForEach-Object { $_.ToString().Trim() } | Select-Object -Unique
    return $servers
}

function Build-PlatformAnalysis {
    param(
        [array]$Platforms
    )
    $analysis = @{}
    # Only analyze installed platforms
    $targets = $Platforms | ForEach-Object { $_.Name }
    foreach ($t in $targets) {
        $plat = $Platforms | Where-Object { $_.Name -eq $t }
        $servers = @()
        if ($plat -and $plat.ConfigPath -and (Test-Path $plat.ConfigPath)) {
            $servers = Extract-ServersFromConfig -ConfigPath $plat.ConfigPath -Format $plat.Format
        }
        $namesCI = $servers | ForEach-Object { $_.ToLower() }
        $hasGithub = $namesCI -contains "github"
        $hasContext7 = $namesCI -contains "context7"
        $hasPlaywright = $namesCI -contains "playwright"
        $hasMemory = $namesCI -contains "memory"
        $hasDatabase = ($namesCI -contains "redis") -or ($namesCI -contains "mysql server") -or ($namesCI -contains "postgres") -or ($namesCI -contains "sqlite")
        $hasFilesystem = ($namesCI -contains "filesystem") -or ($namesCI -contains "fs") -or ($namesCI -contains "everything")
        $analysis[$t] = @{
            HasGithub = [bool]$hasGithub
            HasFilesystem = [bool]$hasFilesystem
            HasPlaywright = [bool]$hasPlaywright
            HasDatabase = [bool]$hasDatabase
            Servers = $servers
            HasContext7 = [bool]$hasContext7
            ServerCount = [int]$servers.Count
            HasMemory = [bool]$hasMemory
        }
    }
    $bestName = $null; $bestCount = -1; $bestDisplay = $null
    foreach ($plat in $Platforms) {
        $name = $plat.Name
        if ($analysis.ContainsKey($name)) {
            $count = $analysis[$name].ServerCount
            if ($count -gt $bestCount) {
                $bestCount = $count
                $bestName = $name
                $bestDisplay = $plat.DisplayName
            }
        }
    }
    $summary = "No MCP servers configured"
    if ($bestDisplay) {
        $summary = "Best configuration: $bestDisplay - servers: $bestCount"
    }
    return @{ Analysis = $analysis; Summary = $summary }
}

function Print-DetailedReport {
    param(
        [array]$Platforms,
        [hashtable]$AnalysisMap,
        [string]$Summary,
        [array]$MissingPlatforms = @()
    )
    Write-ColorOutput " MCP Cross-Platform Configuration Sync Tool " "Cyan"
    Write-ColorOutput " Supports: Trae, Cursor, Claude and other AI tools " "White"
    Write-ColorOutput "" "White"
    Write-ColorOutput " Detecting MCP configuration status for all AI tools... " "White"
    Write-ColorOutput " ============================================================ " "Gray"

    foreach ($plat in $Platforms) {
        Write-ColorOutput " Found: $($plat.DisplayName)" "Green"
    }

    Write-ColorOutput "" "White"
    Write-ColorOutput " Installed AI Tools: " "White"
    foreach ($plat in $Platforms) {
        Write-ColorOutput "   * $($plat.DisplayName)" "White"
    }

    if ($MissingPlatforms -and $MissingPlatforms.Count -gt 0) {
        Write-ColorOutput "" "White"
        Write-ColorOutput " 未安装或未检测到的 AI 工具：" "Yellow"
        $displayCount = [Math]::Min(4, $MissingPlatforms.Count)
        for ($i = 0; $i -lt $displayCount; $i++) {
            Write-ColorOutput "   - $($MissingPlatforms[$i])" "Yellow"
        }
        if ($MissingPlatforms.Count -gt 4) {
            $remainingCount = $MissingPlatforms.Count - 4
            Write-ColorOutput "   ... 还有 $remainingCount 个未检测到的工具" "Gray"
        }
    }

    Write-ColorOutput "" "White"
    Write-ColorOutput " MCP Configuration Analysis: " "White"
    foreach ($key in $AnalysisMap.Keys) {
        $entry = $AnalysisMap[$key]
        $dispPlat = $Platforms | Where-Object { $_.Name -eq $key }
        $dispName = $key
        if ($dispPlat) { $dispName = $dispPlat.DisplayName }
        Write-ColorOutput "" "White"
        Write-ColorOutput " ${dispName}: " "White"
        if ($entry.ServerCount -gt 0) {
            Write-ColorOutput "   Configured $($entry.ServerCount) MCP servers" "Green"
            $serverList = [string]::Join(', ', $entry.Servers)
            Write-ColorOutput "   Servers: $serverList" "Gray"
            $features = @()
            if ($entry.HasMemory) { $features += "Memory" }
            if ($entry.HasGithub) { $features += "GitHub" }
            if ($entry.HasContext7) { $features += "Context7" }
            if ($entry.HasPlaywright) { $features += "Playwright" }
            if ($entry.HasDatabase) { $features += "Database" }
            if ($entry.HasFilesystem) { $features += "Filesystem" }
            if ($features.Count -gt 0) {
                $featureList = [string]::Join(', ', $features)
                Write-ColorOutput "   Key features: $featureList" "Gray"
            }
        } else {
            Write-ColorOutput "   No MCP servers configured" "Yellow"
        }
    }

    Write-ColorOutput "" "White"
    Write-ColorOutput " Smart Recommendations: " "White"
    Write-ColorOutput "   $Summary" "Green"

    $bestKey = $null
    foreach ($k in $AnalysisMap.Keys) {
        if (-not $bestKey -or $AnalysisMap[$k].ServerCount -gt $AnalysisMap[$bestKey].ServerCount) { $bestKey = $k }
    }
    if ($bestKey) {
        foreach ($k in $AnalysisMap.Keys) {
            if ($k -ne $bestKey) {
                $dispPlat = $Platforms | Where-Object { $_.Name -eq $k }
                $dispName = $k
                if ($dispPlat) { $dispName = $dispPlat.DisplayName }
                Write-ColorOutput "   $dispName can add $($AnalysisMap[$bestKey].ServerCount) servers" "Gray"
            }
        }
    }

    Write-ColorOutput "" "White"
    Write-ColorOutput " Suggested Actions: " "White"
    Write-ColorOutput "   * Run: .\\mcp-cross-platform-sync.ps1 -Action sync -SourcePlatform Trae" "White"
    Write-ColorOutput "   * Or use AI command: 'Sync MCP Configuration'" "White"
}

# Sync configuration function
function Sync-MCPConfiguration {
    param(
        [string]$SourcePlatform,
        [array]$TargetPlatforms,
        [bool]$DryRun = $false
    )
    
    Write-ColorOutput "=== MCP Configuration Sync ===" "Cyan"
    
    # Get installed platforms
    $platforms = Get-InstalledPlatforms
    
    # Determine source platform
    $selectedPlatform = $null
    if ($SourcePlatform -eq "auto") {
        # Find platform with most servers
        $analysisResult = Build-PlatformAnalysis -Platforms $platforms
        $analysisMap = $analysisResult.Analysis
        $bestCount = -1
        foreach ($key in $analysisMap.Keys) {
            if ($analysisMap[$key].ServerCount -gt $bestCount) {
                $bestCount = $analysisMap[$key].ServerCount
                $selectedPlatform = $platforms | Where-Object { $_.Name -eq $key }
            }
        }
    } else {
        $selectedPlatform = $platforms | Where-Object { $_.Name -eq $SourcePlatform }
    }
    
    if (-not $selectedPlatform) {
        Write-ColorOutput "Source platform not found or not installed: $SourcePlatform" "Red"
        return
    }
    
    # Get source configuration
    if (-not (Test-Path $selectedPlatform.ConfigPath)) {
        Write-ColorOutput "Source configuration file not found: $($selectedPlatform.ConfigPath)" "Red"
        return
    }
    
    try {
        $sourceConfig = Get-Content $selectedPlatform.ConfigPath -Raw | ConvertFrom-Json
        Write-ColorOutput "Source: $($selectedPlatform.DisplayName)" "Green"
        Write-ColorOutput "Config file: $($selectedPlatform.ConfigPath)" "Gray"
        
        # Extract servers from source
        $sourceServers = Extract-ServersFromConfig -ConfigPath $selectedPlatform.ConfigPath -Format $selectedPlatform.Format
        Write-ColorOutput "Found $($sourceServers.Count) servers in source configuration" "Green"
        
        if ($sourceServers.Count -eq 0) {
            Write-ColorOutput "No servers found in source configuration" "Yellow"
            return
        }
        
        # Determine target platforms
        $targetPlatformList = @()
        if ($TargetPlatforms -contains "all") {
            $targetPlatformList = $platforms | Where-Object { $_.Name -ne $selectedPlatform.Name }
        } else {
            foreach ($target in $TargetPlatforms) {
                $targetPlatform = $platforms | Where-Object { $_.Name -eq $target }
                if ($targetPlatform) {
                    $targetPlatformList += $targetPlatform
                }
            }
        }
        
        if ($targetPlatformList.Count -eq 0) {
            Write-ColorOutput "No valid target platforms found" "Yellow"
            return
        }
        
        # Sync to each target platform
        foreach ($targetPlatform in $targetPlatformList) {
            Write-ColorOutput "" "White"
            Write-ColorOutput "Syncing to: $($targetPlatform.DisplayName)" "Cyan"
            
            # Create target directory if it doesn't exist
            $targetDir = Split-Path $targetPlatform.ConfigPath -Parent
            if (-not (Test-Path $targetDir)) {
                if ($DryRun) {
                    Write-ColorOutput "[DRY RUN] Would create directory: $targetDir" "Yellow"
                } else {
                    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
                    Write-ColorOutput "Created directory: $targetDir" "Green"
                }
            }
            
            # Create or update target configuration
            if (Test-Path $targetPlatform.ConfigPath) {
                # Backup existing configuration
                $backupPath = "$($targetPlatform.ConfigPath).backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
                if ($DryRun) {
                    Write-ColorOutput "[DRY RUN] Would backup existing config to: $backupPath" "Yellow"
                } else {
                    Copy-Item $targetPlatform.ConfigPath $backupPath
                    Write-ColorOutput "Backed up existing config to: $backupPath" "Green"
                }
            }
            
            # Create new configuration based on source
            if ($DryRun) {
                Write-ColorOutput "[DRY RUN] Would sync $($sourceServers.Count) servers to $($targetPlatform.ConfigPath)" "Yellow"
                Write-ColorOutput "[DRY RUN] Servers: $($sourceServers -join ', ')" "Gray"
            } else {
                # Copy the source configuration structure
                $targetConfig = $sourceConfig | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                $targetConfig | ConvertTo-Json -Depth 10 | Set-Content $targetPlatform.ConfigPath -Encoding UTF8
                Write-ColorOutput "Synced $($sourceServers.Count) servers to $($targetPlatform.DisplayName)" "Green"
                Write-ColorOutput "Config saved to: $($targetPlatform.ConfigPath)" "Gray"
            }
        }
        
        if (-not $DryRun) {
            Write-ColorOutput "" "White"
            Write-ColorOutput "Sync completed successfully!" "Green"
            Write-ColorOutput "Run detection again to verify: .\mcp-cross-platform-sync.ps1 -Action detect" "White"
        }
        
    } catch {
        Write-ColorOutput "Error during sync: $($_.Exception.Message)" "Red"
    }
}

# Main execution logic
switch ($Action.ToLower()) {
    "detect" {
        Write-ColorOutput "=== MCP Platform Detection ===" "Cyan"
        Write-ColorOutput "Scanning for installed AI development platforms..." "White"
        
        $platforms = Get-InstalledPlatforms
        
        if ($platforms.Count -eq 0) {
            Write-ColorOutput "未检测到已安装的 AI 编辑器。" "Yellow"
            Write-ColorOutput "支持的平台：$($MCPConfigs.Keys -join ', ')" "Gray"
            # 写入空的状态报告
            $emptyReport = @{ lastAction = "detect"; lastCheckAt = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss"); summary = "No MCP servers configured"; analysis = @{} }
            Set-CachedData -Data $emptyReport -CacheType "report"
        } else {
            # 计算未安装/未检测到平台列表（按显示名）
            $installedNames = $platforms | ForEach-Object { $_.Name }
            $missingNames = $MCPConfigs.Keys | Where-Object { $installedNames -notcontains $_ }
            $missingDisplay = @()
            foreach ($mn in $missingNames) { $missingDisplay += $MCPConfigs[$mn].Name }
            
            # 构建分析与打印详细报告（仅针对已安装平台）
            $analysisResult = Build-PlatformAnalysis -Platforms $platforms
            $analysisMap = $analysisResult.Analysis
            $summaryText = $analysisResult.Summary
            Print-DetailedReport -Platforms $platforms -AnalysisMap $analysisMap -Summary $summaryText -MissingPlatforms $missingDisplay
            
            # 写入状态报告（顶层键：lastAction/lastCheckAt/summary/analysis）
            $statusReport = @{ 
                lastAction = "detect"
                lastCheckAt = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss")
                summary = $summaryText
                analysis = $analysisMap
            }
            Set-CachedData -Data $statusReport -CacheType "report"
        }
    }
    
    "sync" {
        Sync-MCPConfiguration -SourcePlatform $SourcePlatform -TargetPlatforms $TargetPlatforms -DryRun $DryRun
    }
    
    "clearcache" {
        Write-ColorOutput "=== Clear All Caches ===" "Cyan"
        Clear-AllCaches
    }
    
    default {
        Write-ColorOutput "Invalid action: $Action" "Red"
        Write-ColorOutput "Available actions: detect, sync, clearcache" "Yellow"
        exit 1
    }
}

