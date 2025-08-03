@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title MCP Tools Enhanced Installer v3.3 (Fixed)

echo.
echo ================================================
echo    MCP Tools Enhanced Installer v3.3 (Fixed)
echo ================================================
echo    Installing 5 MCP Tools (4 Node.js + 1 Python)
echo ================================================
echo.

:: Step 1: System Environment Check
echo [Step 1] System Environment Check
echo ----------------------------------------
echo [INFO] Checking system environment...

:: Check Node.js
echo [DEBUG] Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js not installed or not in PATH
    echo [INFO] Please install Node.js: https://nodejs.org/
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version 2^>nul') do (
    echo [OK] Node.js: %%i
)

:: Check npm
echo [DEBUG] Checking npm installation...
for /f "tokens=*" %%i in ('npm --version 2^>nul') do (
    echo [OK] npm: %%i
)

:: Check Python
echo [DEBUG] Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not installed or not in PATH
    echo [INFO] Please install Python: https://python.org/
    pause
    exit /b 1
)
for /f "tokens=2" %%i in ('python --version 2^>nul') do (
    echo [OK] Python: %%i
)

echo [DEBUG] Continuing to step 2...
echo.

:: Step 2: Scan existing MCP installations
echo [Step 2] Scanning existing MCP installations...
echo ----------------------------------------
echo [DEBUG] Scanning all drives for existing MCP installations...
echo.
echo Available drives:
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo   %%d: drive
        if exist "%%d:\MCP-Tools" (
            echo     [FOUND] Existing MCP installation at %%d:\MCP-Tools
        )
    )
)
echo.

:: Step 3: Choose installation drive
echo [Step 3] Choose installation drive...
echo ----------------------------------------
echo [INFO] Recommended: Choose a drive with sufficient space (about 100MB needed)
echo [INFO] If installation is slow, consider switching npm registry
echo   Quick method: npm config set registry https://registry.npmmirror.com
echo   Detailed tutorial: docs/MCP-QUICK-START-GUIDE.md
echo.

:input_drive
set /p "user_drive=Please enter drive letter (default D): "
if "!user_drive!"=="" set "user_drive=D"

:: Convert to uppercase
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if /i "!user_drive!"=="%%i" set "user_drive=%%i"
)

echo [DEBUG] You selected drive: !user_drive!
echo.

:: Step 4: Check drive existence
echo [Step 4] Checking drive existence...
echo ----------------------------------------
echo [DEBUG] Verifying accessibility of drive !user_drive!...
if not exist "!user_drive!:\" (
    echo [ERROR] Drive !user_drive! does not exist
    echo [INFO] Please choose another drive
    echo.
    goto input_drive
)
echo [OK] Drive !user_drive! exists and is accessible
set "install_path=!user_drive!:\MCP-Tools"
echo [INFO] Installation path: !install_path!
echo [DEBUG] Continuing to step 5...
echo.

:: Step 5: Create installation directory and initialize npm project
echo [Step 5] Creating installation directory and initializing npm project...
echo ----------------------------------------
echo [DEBUG] Checking directory status...

:: 如果目录存在，先清理
if exist "!install_path!" (
    echo [INFO] Directory already exists, cleaning...
    rd /s /q "!install_path!" 2>nul
    timeout /t 1 /nobreak >nul
)

:: 创建新目录
echo [INFO] Creating installation directory...
mkdir "!install_path!" 2>nul
if errorlevel 1 (
    echo [ERROR] Cannot create directory !install_path!
    echo [INFO] Please check permissions or disk space
    echo [DEBUG] Trying alternative method...
    
    :: 尝试使用md命令
    md "!install_path!" 2>nul
    if errorlevel 1 (
        echo [ERROR] Alternative method also failed
        pause
        exit /b 1
    )
)

:: 验证目录是否真的创建成功
timeout /t 1 /nobreak >nul
if not exist "!install_path!" (
    echo [ERROR] Directory creation verification failed
    echo [DEBUG] Path: !install_path!
    pause
    exit /b 1
)
echo [OK] Created directory: !install_path!

echo [DEBUG] Switching working directory...
cd /d "!install_path!" 2>nul
if errorlevel 1 (
    echo [ERROR] Cannot access directory !install_path!
    echo [DEBUG] Current directory: %CD%
    echo [DEBUG] Target directory: !install_path!
    dir "!user_drive!:\" 2>nul
    pause
    exit /b 1
)
echo [OK] Working directory: !install_path!

:: Initialize npm project
echo [DEBUG] Checking npm project status...
if not exist "package.json" (
    echo [INFO] Initializing npm project...
    echo [DEBUG] Creating package.json file...
    echo {"name": "mcp-tools", "version": "1.0.0", "description": "MCP Tools Installation"} > package.json
    echo [OK] npm project initialized successfully
) else (
    echo [OK] npm project already exists
)
echo [DEBUG] Continuing to step 6...
echo.

:: Step 6: Install MCP tools
echo [Step 6] Installing MCP tools...
echo ----------------------------------------
echo [DEBUG] Starting MCP tools installation...
echo [INFO] Installing 5 MCP tools to: !install_path!
echo [INFO] If installation is slow, consider switching npm registry
echo   Quick method: npm config set registry https://registry.npmmirror.com
echo   Detailed tutorial: docs/MCP-QUICK-START-GUIDE.md
echo.

set "install_failed="

:: Install server-filesystem
echo [DEBUG] Installing package 1/5...
echo [INFO] Installing server-filesystem...
echo [DEBUG] Working directory: !install_path!
echo [DEBUG] Running: npm install @modelcontextprotocol/server-filesystem
call npm install @modelcontextprotocol/server-filesystem
if errorlevel 1 (
    echo [ERROR] server-filesystem installation failed
    set "install_failed=1"
) else (
    echo [OK] server-filesystem installed successfully
)

:: Install server-memory
echo [DEBUG] Installing package 2/5...
echo [INFO] Installing server-memory...
echo [DEBUG] Working directory: !install_path!
echo [DEBUG] Running: npm install @modelcontextprotocol/server-memory
call npm install @modelcontextprotocol/server-memory
if errorlevel 1 (
    echo [ERROR] server-memory installation failed
    set "install_failed=1"
) else (
    echo [OK] server-memory installed successfully
)

:: Install server-github
echo [DEBUG] Installing package 3/5...
echo [INFO] Installing server-github...
echo [DEBUG] Working directory: !install_path!
echo [DEBUG] Running: npm install @modelcontextprotocol/server-github
call npm install @modelcontextprotocol/server-github
if errorlevel 1 (
    echo [ERROR] server-github installation failed
    set "install_failed=1"
) else (
    echo [OK] server-github installed successfully
)

:: Install server-everything
echo [DEBUG] Installing package 4/5...
echo [INFO] Installing server-everything...
echo [DEBUG] Working directory: !install_path!
echo [DEBUG] Running: npm install @modelcontextprotocol/server-everything
call npm install @modelcontextprotocol/server-everything
if errorlevel 1 (
    echo [ERROR] server-everything installation failed
    set "install_failed=1"
) else (
    echo [OK] server-everything installed successfully
)

:: Install Python tool
echo [DEBUG] Installing package 5/5...
echo [INFO] Installing mcp-feedback-enhanced (Python package)...
echo [DEBUG] Working directory: !install_path!
echo [DEBUG] Running: uvx mcp-feedback-enhanced@latest version
uvx mcp-feedback-enhanced@latest version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] uvx installation failed, trying pip...
    pip install mcp-feedback-enhanced >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] mcp-feedback-enhanced installation failed
        set "install_failed=1"
    ) else (
        echo [OK] mcp-feedback-enhanced installed successfully (pip)
    )
) else (
    echo [OK] mcp-feedback-enhanced installed successfully
)

echo [OK] All MCP tools installation completed
echo.

:: Generate configuration file
echo [DEBUG] Generating configuration file...
set "config_file=!install_path!\mcp-config.json"
(
echo {
echo   "mcpServers": {
echo     "AgentRules": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-filesystem", "E:/AgentRules"]
echo     },
echo     "memory": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-memory"]
echo     },
echo     "github": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-github"]
echo     },
echo     "everything": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-everything", "stdio"]
echo     },
echo     "mcp-feedback-enhanced": {
echo       "command": "uvx",
echo       "args": ["mcp-feedback-enhanced@latest"],
echo       "env": {
echo         "PYTHONUNBUFFERED": "1",
echo         "MCP_FEEDBACK_TIMEOUT": "3600",
echo         "MCP_FEEDBACK_MAX_SIZE": "10485760",
echo         "MCP_WINDOW_MODE": "desktop",
echo         "MCP_NO_BROWSER": "true",
echo         "MCP_DESKTOP_MODE": "true"
echo       }
echo     }
echo   }
echo }
) > "!config_file!"

if exist "!config_file!" (
    echo [OK] Configuration file generated: !config_file!
) else (
    echo [ERROR] Configuration file generation failed
)

:: Verify installation results
echo.
echo [DEBUG] Verifying installation results...
set "installed_count=0"
if exist "node_modules\@modelcontextprotocol\server-filesystem" (
    set /a installed_count+=1
    echo [OK] server-filesystem installed
) else (
    echo [ERROR] server-filesystem not installed
)

if exist "node_modules\@modelcontextprotocol\server-memory" (
    set /a installed_count+=1
    echo [OK] server-memory installed
) else (
    echo [ERROR] server-memory not installed
)

if exist "node_modules\@modelcontextprotocol\server-github" (
    set /a installed_count+=1
    echo [OK] server-github installed
) else (
    echo [ERROR] server-github not installed
)

if exist "node_modules\@modelcontextprotocol\server-everything" (
    set /a installed_count+=1
    echo [OK] server-everything installed
) else (
    echo [ERROR] server-everything not installed
)

:: Check Python tool
uvx mcp-feedback-enhanced@latest version >nul 2>&1
if not errorlevel 1 (
    set /a installed_count+=1
    echo [OK] mcp-feedback-enhanced installed
) else (
    echo [ERROR] mcp-feedback-enhanced not installed
)

:: Final report
echo.
echo ================================================
echo                Installation Report
echo ================================================
echo.
echo MCP Tools installation completed
echo.
echo Final installation path: !install_path!
echo Installed tools count: !installed_count!/5
echo.
echo Project files:
if exist "node_modules" echo   node_modules
if exist "package-lock.json" echo   package-lock.json
if exist "package.json" echo   package.json
if exist "mcp-config.json" echo   mcp-config.json
echo.
echo [Verification] How to verify all 5 MCP tools:
echo.
echo 1. Node.js MCP tools (4 tools - visible in file manager):
echo    dir "!install_path!\node_modules\@modelcontextprotocol"
echo    Should show: server-filesystem, server-memory, server-github, server-everything
echo.
echo    💡 Your installation path: !install_path!
echo    💡 You can also open this folder in file explorer to verify:
echo    💡 !install_path!\node_modules\@modelcontextprotocol
echo.
echo 2. Python MCP tool (1 tool - not visible in file manager):
echo    uvx mcp-feedback-enhanced@latest version
echo    Should show: MCP Feedback Enhanced Enhanced v2.6.0
echo.
echo [IMPORTANT] mcp-feedback-enhanced is a Python package installed via uvx.
echo It will NOT appear in the node_modules folder - this is normal
echo Use the uvx command above to verify it's properly installed.
echo.
echo Next steps:
echo    1. Configure mcp-config.json file
echo    2. Reference: MCP-DETAILED-CONFIG-GUIDE.md
echo    3. Test MCP tools functionality
echo.
echo Related documentation:
echo    - Quick start: MCP-QUICK-START-GUIDE.md
echo    - Detailed config: MCP-DETAILED-CONFIG-GUIDE.md
echo    - Troubleshooting: MCP-TROUBLESHOOTING-GUIDE.md
echo.

if defined install_failed (
    echo [WARNING] Some tools failed to install, please check network connection or try switching npm registry
    echo Fix command: npm config set registry https://registry.npmmirror.com
)

pause