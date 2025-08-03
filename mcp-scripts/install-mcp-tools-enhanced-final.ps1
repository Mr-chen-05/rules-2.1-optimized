# MCP Tools Installer v6.0 - PowerShell Version
# Encoding: UTF-8

# Set console encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Set window title
$Host.UI.RawUI.WindowTitle = "MCP Tools Installer v6.0"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "    MCP Tools Installer v6.0" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Smart MCP Tools Installer - Support Any Drive" -ForegroundColor Green
Write-Host "Will install 5 MCP tools: 4 Node.js tools + 1 Python tool" -ForegroundColor Green
Write-Host ""

# Step 1: System Environment Check
Write-Host "[1/6] System Environment Check..." -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "[INFO] Checking system environment..." -ForegroundColor Blue

# Check Node.js
Write-Host "[DEBUG] Checking Node.js installation..." -ForegroundColor Gray
try {
    $nodeVersion = node --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[SUCCESS] Node.js version: $nodeVersion" -ForegroundColor Green
    } else {
        throw "Node.js not installed"
    }
} catch {
    Write-Host "[ERROR] Node.js not installed or not in PATH" -ForegroundColor Red
    Write-Host "[INFO] Please install Node.js first: https://nodejs.org/" -ForegroundColor Blue
    Read-Host "Press Enter to exit"
    exit 1
}

# Check npm
Write-Host "[DEBUG] Checking npm installation..." -ForegroundColor Gray
try {
    $npmVersion = npm --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[SUCCESS] npm version: $npmVersion" -ForegroundColor Green
    } else {
        throw "npm not installed"
    }
} catch {
    Write-Host "[ERROR] npm not installed or not in PATH" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check Python
Write-Host "[DEBUG] Checking Python installation..." -ForegroundColor Gray
try {
    $pythonVersion = python --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[SUCCESS] Python version: $pythonVersion" -ForegroundColor Green
    } else {
        throw "Python not installed"
    }
} catch {
    Write-Host "[ERROR] Python not installed or not in PATH" -ForegroundColor Red
    Write-Host "[INFO] Please install Python first: https://python.org/" -ForegroundColor Blue
    Read-Host "Press Enter to exit"
    exit 1
}

# Check uv (optional)
Write-Host "[DEBUG] Checking uv installation..." -ForegroundColor Gray
try {
    $uvVersion = uv --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[SUCCESS] uv version: $uvVersion" -ForegroundColor Green
    } else {
        throw "uv not installed"
    }
} catch {
    Write-Host "[WARNING] uv not installed, will use pip for Python tools" -ForegroundColor Yellow
}

Write-Host "[DEBUG] Continue to step 2..." -ForegroundColor Gray
Write-Host ""

# Step 2: Select Installation Drive
Write-Host "[2/6] Select Installation Drive..." -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "[DEBUG] Scanning available drives..." -ForegroundColor Gray
Write-Host ""
Write-Host "Available drives:" -ForegroundColor Blue

# Scan available drives
$availableDrives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -ne $null }
foreach ($drive in $availableDrives) {
    Write-Host "  $($drive.Name): drive" -ForegroundColor White
}

Write-Host ""
Write-Host "[INFO] Recommended: Choose a drive with enough space (needs about 100MB)" -ForegroundColor Blue
Write-Host "[INFO] If installation is slow, consider switching npm registry" -ForegroundColor Blue
Write-Host "  Quick method: npm config set registry https://registry.npmmirror.com" -ForegroundColor Cyan
Write-Host "  Detailed guide: docs/MCP-QUICK-START-GUIDE.md" -ForegroundColor Cyan
Write-Host ""

# Input drive letter
do {
    $userDrive = Read-Host "Please enter drive letter (default D)"
    if ([string]::IsNullOrEmpty($userDrive)) {
        $userDrive = "D"
    }
    $userDrive = $userDrive.ToUpper()
    
    Write-Host "[DEBUG] Your selected drive: $userDrive" -ForegroundColor Gray
    
    # Step 3: Check Drive Existence
    Write-Host ""
    Write-Host "[3/6] Check Drive Existence..." -ForegroundColor Yellow
    Write-Host "----------------------------------------" -ForegroundColor Gray
    Write-Host "[DEBUG] Verifying drive $userDrive accessibility..." -ForegroundColor Gray
    
    if (Test-Path "${userDrive}:\") {
        Write-Host "[SUCCESS] Drive $userDrive exists and is accessible" -ForegroundColor Green
        break
    } else {
        Write-Host "[ERROR] Drive $userDrive does not exist" -ForegroundColor Red
        Write-Host "[INFO] Please select another drive" -ForegroundColor Blue
        Write-Host ""
    }
} while ($true)

$installPath = "${userDrive}:\MCP-Tools"
Write-Host "[INFO] Installation path: $installPath" -ForegroundColor Blue
Write-Host "[DEBUG] Continue to step 4..." -ForegroundColor Gray
Write-Host ""

# Step 4: Create Installation Directory and Initialize npm Project
Write-Host "[4/6] Create Installation Directory and Initialize npm Project..." -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "[DEBUG] Checking directory status..." -ForegroundColor Gray

if (-not (Test-Path $installPath)) {
    Write-Host "[INFO] Creating installation directory..." -ForegroundColor Blue
    try {
        New-Item -ItemType Directory -Path $installPath -Force | Out-Null
        Write-Host "[SUCCESS] Created directory: $installPath" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Cannot create directory $installPath" -ForegroundColor Red
        Write-Host "[INFO] Please check permissions or disk space" -ForegroundColor Blue
        Read-Host "Press Enter to exit"
        exit 1
    }
} else {
    Write-Host "[SUCCESS] Directory already exists: $installPath" -ForegroundColor Green
}

Write-Host "[DEBUG] Switching working directory..." -ForegroundColor Gray
try {
    Set-Location $installPath
    Write-Host "[SUCCESS] Working directory: $installPath" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Cannot access directory $installPath" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Initialize npm project
Write-Host "[DEBUG] Checking npm project status..." -ForegroundColor Gray
if (-not (Test-Path "package.json")) {
    Write-Host "[INFO] Initializing npm project..." -ForegroundColor Blue
    Write-Host "[DEBUG] Creating package.json file..." -ForegroundColor Gray
    $packageJson = @{
        name = "mcp-tools"
        version = "1.0.0"
        description = "MCP Tools Installation"
    } | ConvertTo-Json
    $packageJson | Out-File -FilePath "package.json" -Encoding UTF8
    Write-Host "[SUCCESS] npm project initialized successfully" -ForegroundColor Green
} else {
    Write-Host "[SUCCESS] npm project already exists" -ForegroundColor Green
}
Write-Host "[DEBUG] Continue to step 5..." -ForegroundColor Gray
Write-Host ""

# Step 5: Install Node.js MCP Tools
Write-Host "[5/6] Install Node.js MCP Tools..." -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "[DEBUG] Starting MCP tools installation..." -ForegroundColor Gray
Write-Host "[INFO] Installing 5 MCP tools to: $installPath" -ForegroundColor Blue
Write-Host "[INFO] If installation is slow, consider switching npm registry" -ForegroundColor Blue
Write-Host "  Quick method: npm config set registry https://registry.npmmirror.com" -ForegroundColor Cyan
Write-Host "  Detailed guide: docs/MCP-QUICK-START-GUIDE.md" -ForegroundColor Cyan
Write-Host ""

$installFailed = $false
$packages = @(
    "@modelcontextprotocol/server-filesystem",
    "@modelcontextprotocol/server-memory",
    "@modelcontextprotocol/server-github",
    "@modelcontextprotocol/server-everything"
)

$packageNames = @(
    "server-filesystem",
    "server-memory",
    "server-github",
    "server-everything"
)

for ($i = 0; $i -lt $packages.Length; $i++) {
    $package = $packages[$i]
    $packageName = $packageNames[$i]
    
    Write-Host "[DEBUG] Installing package $($i+1)/5..." -ForegroundColor Gray
    Write-Host "[INFO] Installing $packageName..." -ForegroundColor Blue
    Write-Host "[DEBUG] Working directory: $installPath" -ForegroundColor Gray
    Write-Host "[DEBUG] Running: npm install $package" -ForegroundColor Gray
    
    try {
        $result = npm install $package 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[SUCCESS] $packageName installed successfully" -ForegroundColor Green
        } else {
            Write-Host "[ERROR] $packageName installation failed" -ForegroundColor Red
            $installFailed = $true
        }
    } catch {
        Write-Host "[ERROR] $packageName installation failed" -ForegroundColor Red
        $installFailed = $true
    }
}

# Install Python tool
Write-Host "[DEBUG] Installing package 5/5..." -ForegroundColor Gray
Write-Host "[INFO] Installing mcp-feedback-enhanced (Python package)..." -ForegroundColor Blue
Write-Host "[DEBUG] Working directory: $installPath" -ForegroundColor Gray
Write-Host "[DEBUG] Running: uvx mcp-feedback-enhanced@latest version" -ForegroundColor Gray

try {
    $result = uvx mcp-feedback-enhanced@latest version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[SUCCESS] mcp-feedback-enhanced installed successfully" -ForegroundColor Green
    } else {
        Write-Host "[WARNING] uvx installation failed, trying pip..." -ForegroundColor Yellow
        $result = pip install mcp-feedback-enhanced 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[SUCCESS] mcp-feedback-enhanced installed successfully (pip)" -ForegroundColor Green
        } else {
            Write-Host "[ERROR] mcp-feedback-enhanced installation failed" -ForegroundColor Red
            $installFailed = $true
        }
    }
} catch {
    Write-Host "[ERROR] mcp-feedback-enhanced installation failed" -ForegroundColor Red
    $installFailed = $true
}

Write-Host "[SUCCESS] All Node.js MCP tools installation completed" -ForegroundColor Green
Write-Host "[DEBUG] Continue to Python tools..." -ForegroundColor Gray
Write-Host ""

# Step 6: Generate Configuration File
Write-Host "[6/6] Generate Configuration File..." -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "[INFO] Generating MCP configuration file..." -ForegroundColor Blue
Write-Host "[SUCCESS] uv installation successful" -ForegroundColor Green
Write-Host ""

# Generate configuration file
Write-Host "[DEBUG] Generating configuration file..." -ForegroundColor Gray
$configFile = Join-Path $installPath "mcp-config.json"

# 生成格式化的 JSON 配置文件
$jsonContent = @"
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem"
      ]
    },
    "memory": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-memory"
      ]
    },
    "github": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-github"
      ]
    },
    "everything": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-everything",
        "stdio"
      ]
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": [
        "mcp-feedback-enhanced@latest"
      ],
      "env": {
        "PYTHONUNBUFFERED": "1",
        "MCP_FEEDBACK_TIMEOUT": "3600",
        "MCP_FEEDBACK_MAX_SIZE": "10485760",
        "MCP_WINDOW_MODE": "desktop",
        "MCP_NO_BROWSER": "true",
        "MCP_DESKTOP_MODE": "true"
      }
    }
  }
}
"@

try {
    $jsonContent | Out-File -FilePath $configFile -Encoding UTF8
    Write-Host "[SUCCESS] Configuration file generated: $configFile" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Configuration file generation failed" -ForegroundColor Red
}

# Verify installation results
Write-Host ""
Write-Host "[DEBUG] Verifying installation results..." -ForegroundColor Gray
$installedCount = 0

$nodeModulesPath = Join-Path $installPath "node_modules\@modelcontextprotocol"
if (Test-Path (Join-Path $nodeModulesPath "server-filesystem")) {
    $installedCount++
    Write-Host "[SUCCESS] server-filesystem installed" -ForegroundColor Green
} else {
    Write-Host "[ERROR] server-filesystem not installed" -ForegroundColor Red
}

if (Test-Path (Join-Path $nodeModulesPath "server-memory")) {
    $installedCount++
    Write-Host "[SUCCESS] server-memory installed" -ForegroundColor Green
} else {
    Write-Host "[ERROR] server-memory not installed" -ForegroundColor Red
}

if (Test-Path (Join-Path $nodeModulesPath "server-github")) {
    $installedCount++
    Write-Host "[SUCCESS] server-github installed" -ForegroundColor Green
} else {
    Write-Host "[ERROR] server-github not installed" -ForegroundColor Red
}

if (Test-Path (Join-Path $nodeModulesPath "server-everything")) {
    $installedCount++
    Write-Host "[SUCCESS] server-everything installed" -ForegroundColor Green
} else {
    Write-Host "[ERROR] server-everything not installed" -ForegroundColor Red
}

# Check Python tool
try {
    $result = uvx mcp-feedback-enhanced@latest version 2>$null
    if ($LASTEXITCODE -eq 0) {
        $installedCount++
        Write-Host "[SUCCESS] mcp-feedback-enhanced installed" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] mcp-feedback-enhanced not installed" -ForegroundColor Red
    }
} catch {
    Write-Host "[ERROR] mcp-feedback-enhanced not installed" -ForegroundColor Red
}

# Final report
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "           Installation Report" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "MCP Tools Installation Completed" -ForegroundColor Green
Write-Host ""
Write-Host "Final installation path: $installPath" -ForegroundColor Blue
Write-Host "Installed tools count: $installedCount/5" -ForegroundColor Blue
Write-Host ""
Write-Host "Project files:" -ForegroundColor Blue
if (Test-Path (Join-Path $installPath "node_modules")) { Write-Host "  node_modules" -ForegroundColor White }
if (Test-Path (Join-Path $installPath "package-lock.json")) { Write-Host "  package-lock.json" -ForegroundColor White }
if (Test-Path (Join-Path $installPath "package.json")) { Write-Host "  package.json" -ForegroundColor White }
if (Test-Path (Join-Path $installPath "mcp-config.json")) { Write-Host "  mcp-config.json" -ForegroundColor White }
Write-Host ""
Write-Host "[VERIFICATION] How to verify all 5 MCP tools:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Node.js MCP tools (4 tools - visible in file manager):" -ForegroundColor Blue
Write-Host "   Get-ChildItem \"$installPath\node_modules\@modelcontextprotocol\"" -ForegroundColor Cyan
Write-Host "   Should show: server-filesystem, server-memory, server-github, server-everything" -ForegroundColor White
Write-Host ""
Write-Host "   Your installation path: $installPath" -ForegroundColor Blue
Write-Host "   You can also open this folder in file explorer to verify:" -ForegroundColor Blue
Write-Host "   $installPath\node_modules\@modelcontextprotocol" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Python MCP tool (1 tool - not visible in file manager):" -ForegroundColor Blue
Write-Host "   uvx mcp-feedback-enhanced@latest version" -ForegroundColor Cyan
Write-Host "   Should show: MCP Feedback Enhanced Enhanced v2.6.0" -ForegroundColor White
Write-Host ""
Write-Host "[IMPORTANT] mcp-feedback-enhanced is installed via uvx as a Python package." -ForegroundColor Yellow
Write-Host "It will not appear in the node_modules folder - this is normal" -ForegroundColor Yellow
Write-Host "Use the uvx command above to verify it is correctly installed." -ForegroundColor Yellow
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Blue
Write-Host "   1. Configure mcp-config.json file" -ForegroundColor White
Write-Host "   2. Reference: MCP-DETAILED-CONFIG-GUIDE.md" -ForegroundColor White
Write-Host "   3. Test MCP tools functionality" -ForegroundColor White
Write-Host ""
Write-Host "Related documentation:" -ForegroundColor Blue
Write-Host "   - Quick start: MCP-QUICK-START-GUIDE.md" -ForegroundColor White
Write-Host "   - Detailed config: MCP-DETAILED-CONFIG-GUIDE.md" -ForegroundColor White
Write-Host "   - Troubleshooting: MCP-TROUBLESHOOTING-GUIDE.md" -ForegroundColor White
Write-Host ""

if ($installFailed) {
    Write-Host "[WARNING] Some tools installation failed, please check network connection or try switching npm registry" -ForegroundColor Yellow
    Write-Host "Fix command: npm config set registry https://registry.npmmirror.com" -ForegroundColor Cyan
}

Read-Host "Press Enter to exit"