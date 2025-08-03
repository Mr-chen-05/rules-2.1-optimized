@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo    MCP Tools Enhanced Installer v3.2
echo ========================================
echo.
echo Smart MCP Tools Installer - Support Any Drive
echo Will install 5 MCP tools: 4 Node.js + 1 Python
echo.

echo [1/9] Pre-check system environment...
echo ----------------------------------------

:: Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not installed or not in PATH
    echo Please install Node.js first: https://nodejs.org/
    goto :error_exit
)

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not installed or not in PATH
    echo Please install Python first: https://python.org/
    goto :error_exit
)

:: Check uv tool
uv --version >nul 2>&1
if errorlevel 1 (
    echo WARNING: uv tool not installed, will auto-install
    echo Installing uv tool...
    pip install uv >nul 2>&1
    if errorlevel 1 (
        echo ERROR: uv installation failed
        goto :error_exit
    )
    echo SUCCESS: uv tool installed
)

:: Show version info
for /f "tokens=*" %%i in ('node --version 2^>nul') do echo SUCCESS: Node.js version: %%i
for /f "tokens=*" %%i in ('python --version 2^>nul') do echo SUCCESS: Python version: %%i
for /f "tokens=*" %%i in ('uv --version 2^>nul') do echo SUCCESS: uv version: %%i

echo.
echo [2/9] Full disk scan for existing MCP installations...
echo ----------------------------------------

echo Scanning all drives for MCP tools installation...
set "existing_installations=0"
set "scan_results="

for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\MCP-Tools\node_modules\@modelcontextprotocol" (
        echo FOUND: Installation at %%d:\MCP-Tools
        set "scan_results=!scan_results! %%d"
        set /a existing_installations+=1
        call :quick_verify "%%d:\MCP-Tools"
    )
)

if !existing_installations! gtr 0 (
    echo.
    echo Scan result: Found !existing_installations! existing installation(s)
    echo Found locations:!scan_results!
    echo.
    echo Please choose action:
    echo   1. Use existing installation (recommended)
    echo   2. Install to new location
    echo   3. Repair existing installation
    echo.
    set /p "action_choice=Please choose (1-3): "

    if "!action_choice!"=="1" (
        echo SUCCESS: Using existing installation
        for %%d in (!scan_results!) do (
            set "install_path=%%d:\MCP-Tools"
            set "drive_letter=%%d"
            goto :generate_config
        )
    ) else if "!action_choice!"=="3" (
        echo REPAIR: Repairing existing installation
        for %%d in (!scan_results!) do (
            set "install_path=%%d:\MCP-Tools"
            set "drive_letter=%%d"
            goto :repair_installation
        )
    )
)

echo.
echo [3/9] Choose installation drive...
echo ----------------------------------------
echo.
echo Please choose MCP tools installation drive:
echo Available drives: C D E F G H
echo.

:choose_drive
set "drive_input="
set /p "drive_input=Enter drive letter (default: C): "

:: Handle default choice
if "!drive_input!"=="" set "drive_input=C"

echo You entered: !drive_input!

:: Convert to uppercase and validate
set "drive_letter="
if /i "!drive_input!"=="C" set "drive_letter=C"
if /i "!drive_input!"=="D" set "drive_letter=D"
if /i "!drive_input!"=="E" set "drive_letter=E"
if /i "!drive_input!"=="F" set "drive_letter=F"
if /i "!drive_input!"=="G" set "drive_letter=G"
if /i "!drive_input!"=="H" set "drive_letter=H"

:: Validate input
if "!drive_letter!"=="" (
    echo.
    echo ERROR: Please enter valid drive letter (C, D, E, F, G, H)
    echo You entered: !drive_input!
    goto :choose_drive
)

echo SUCCESS: Selected drive: !drive_letter!

echo.
echo [4/9] Check drive existence...
echo ----------------------------------------

:: Check if drive exists
if not exist "!drive_letter!:\" (
    echo ERROR: Drive !drive_letter! does not exist or cannot be accessed
    echo Please choose another drive
    goto :choose_drive
)

echo SUCCESS: Drive !drive_letter! exists and accessible

set "install_path=!drive_letter!:\MCP-Tools"
echo Installation path: !install_path!

:: Continue to next step
goto :continue_installation

:continue_installation

echo.
echo [5/9] Detailed check of target location...
echo ----------------------------------------

set "skip_nodejs=false"
set "skip_python=false"
set "existing_tools=0"

:: Check Node.js MCP tools
if exist "!install_path!\node_modules\@modelcontextprotocol" (
    echo FOUND: Existing Node.js MCP tools installation
    
    set "nodejs_tools=0"
    if exist "!install_path!\node_modules\@modelcontextprotocol\server-filesystem" set /a nodejs_tools+=1
    if exist "!install_path!\node_modules\@modelcontextprotocol\server-memory" set /a nodejs_tools+=1
    if exist "!install_path!\node_modules\@modelcontextprotocol\server-github" set /a nodejs_tools+=1
    if exist "!install_path!\node_modules\@modelcontextprotocol\server-everything" set /a nodejs_tools+=1
    
    echo   Installed Node.js tools count: !nodejs_tools!/4
    
    if !nodejs_tools! equ 4 (
        echo   SUCCESS: All Node.js MCP tools are completely installed
        set "skip_nodejs=true"
        set /a existing_tools+=4
    ) else (
        echo   WARNING: Node.js MCP tools installation incomplete, will reinstall
    )
) else (
    echo INFO: No Node.js MCP tools detected, will perform fresh installation
)

:: Check Python MCP tools
echo Checking mcp-feedback-enhanced installation status...
uvx mcp-feedback-enhanced@latest version >nul 2>&1
if errorlevel 1 (
    echo INFO: mcp-feedback-enhanced not installed, will install
) else (
    echo SUCCESS: mcp-feedback-enhanced installed
    set "skip_python=true"
    set /a existing_tools+=1
)

:: Show check results
echo.
echo Installation status summary:
echo   - Installed tools: !existing_tools!/5
if "!skip_nodejs!"=="true" echo   - Node.js tools: SUCCESS Skip (complete)
if "!skip_nodejs!"=="false" echo   - Node.js tools: NEED Install
if "!skip_python!"=="true" echo   - Python tools: SUCCESS Skip (installed)
if "!skip_python!"=="false" echo   - Python tools: NEED Install

if !existing_tools! equ 5 (
    echo.
    echo SUCCESS: All MCP tools are completely installed!
    echo Installation location: !install_path!
    echo.
    echo Do you need to regenerate config file? (Y/N)
    set /p "regen_config=Please choose: "
    if /i "!regen_config!"=="Y" (
        goto :generate_config
    ) else (
        echo SUCCESS: Installation check complete, no action needed
        goto :success_exit
    )
)

echo.
echo [6/9] Create installation directory...
echo ----------------------------------------

if not exist "!install_path!" (
    mkdir "!install_path!" 2>nul
    if errorlevel 1 (
        echo ERROR: Cannot create directory: !install_path!
        echo Please check disk space and permissions
        goto :error_exit
    )
    echo SUCCESS: Created directory: !install_path!
) else (
    echo SUCCESS: Directory already exists: !install_path!
)

cd /d "!install_path!" 2>nul
if errorlevel 1 (
    echo ERROR: Cannot access directory: !install_path!
    goto :error_exit
)

echo SUCCESS: Working directory: !install_path!

echo.
echo [7/9] Install Node.js MCP tools...
echo ----------------------------------------

if "!skip_nodejs!"=="false" (
    echo Initializing npm project...
    if not exist "package.json" (
        echo {"name": "mcp-tools", "version": "1.0.0"} > package.json
        echo SUCCESS: Created package.json
    )
    
    echo Installing 4 Node.js MCP tools...
    
    call :install_nodejs_package "@modelcontextprotocol/server-filesystem" "server-filesystem"
    if errorlevel 1 goto :error_exit
    
    call :install_nodejs_package "@modelcontextprotocol/server-memory" "server-memory"
    if errorlevel 1 goto :error_exit
    
    call :install_nodejs_package "@modelcontextprotocol/server-github" "server-github"
    if errorlevel 1 goto :error_exit
    
    call :install_nodejs_package "@modelcontextprotocol/server-everything" "server-everything"
    if errorlevel 1 goto :error_exit
    
    echo SUCCESS: All Node.js MCP tools installation complete
) else (
    echo SKIP: Node.js tools installation (already exists)
)

echo.
echo [8/9] Install Python MCP tools...
echo ----------------------------------------

if "!skip_python!"=="false" (
    echo Installing mcp-feedback-enhanced...
    echo INFO: This is Python package, installed via uvx, will not appear in node_modules
    
    uvx mcp-feedback-enhanced@latest version >nul 2>&1
    if errorlevel 1 (
        echo ERROR: mcp-feedback-enhanced installation failed
        goto :error_exit
    ) else (
        echo SUCCESS: mcp-feedback-enhanced installation complete
    )
) else (
    echo SKIP: Python tools installation (already exists)
)

:generate_config
echo.
echo [9/9] Generate configuration file...
echo ----------------------------------------

echo Generating mcp-config.json configuration file...
call :create_config_file "!install_path!" "!drive_letter!"

echo.
echo ========================================
echo           Installation Complete Report
echo ========================================
echo.
echo SUCCESS: MCP tools installation complete!
echo.
echo Installation location: !install_path!
echo Installation content:
echo   SUCCESS: Node.js MCP tools (4):
echo      - server-filesystem
echo      - server-memory  
echo      - server-github
echo      - server-everything
echo   SUCCESS: Python MCP tools (1):
echo      - mcp-feedback-enhanced
echo.
echo Configuration file: !install_path!\mcp-config.json
echo.
echo Verify installation:
echo   Node.js tools: dir "!install_path!\node_modules\@modelcontextprotocol"
echo   Python tools: uvx mcp-feedback-enhanced@latest version
echo.
echo Next steps:
echo   1. Copy config file to AI tool configuration directory
echo   2. Modify GitHub Token and other settings as needed
echo   3. Restart AI tool to load MCP functionality

goto :success_exit

:: ========================================
:: Function definitions
:: ========================================

:install_nodejs_package
set "package=%~1"
set "name=%~2"

echo Installing %name%...
npm install %package% --timeout=30000 >nul 2>&1
if errorlevel 1 (
    echo ERROR: %name% installation failed
    echo Trying cache clean and retry...
    npm cache clean --force >nul 2>&1
    npm install %package% --timeout=30000 >nul 2>&1
    if errorlevel 1 (
        echo ERROR: %name% installation still failed
        exit /b 1
    )
)
echo SUCCESS: %name% installation complete
exit /b 0

:create_config_file
set "config_path=%~1"
set "drive=%~2"

set "config_file=%config_path%\mcp-config.json"

echo {> "%config_file%"
echo   "mcpServers": {>> "%config_file%"
echo     "filesystem": {>> "%config_file%"
echo       "command": "node",>> "%config_file%"
echo       "args": [>> "%config_file%"
echo         "%drive%:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",>> "%config_file%"
echo         "%drive%:\\YourProjectPath">> "%config_file%"
echo       ],>> "%config_file%"
echo       "env": {}>> "%config_file%"
echo     },>> "%config_file%"
echo     "memory": {>> "%config_file%"
echo       "command": "node",>> "%config_file%"
echo       "args": [>> "%config_file%"
echo         "%drive%:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-memory\\dist\\index.js">> "%config_file%"
echo       ],>> "%config_file%"
echo       "env": {}>> "%config_file%"
echo     },>> "%config_file%"
echo     "github": {>> "%config_file%"
echo       "command": "node",>> "%config_file%"
echo       "args": [>> "%config_file%"
echo         "%drive%:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js">> "%config_file%"
echo       ],>> "%config_file%"
echo       "env": {>> "%config_file%"
echo         "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_YourGitHubToken">> "%config_file%"
echo       }>> "%config_file%"
echo     },>> "%config_file%"
echo     "everything": {>> "%config_file%"
echo       "command": "node",>> "%config_file%"
echo       "args": [>> "%config_file%"
echo         "%drive%:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-everything\\dist\\index.js">> "%config_file%"
echo       ],>> "%config_file%"
echo       "env": {}>> "%config_file%"
echo     },>> "%config_file%"
echo     "mcp-feedback-enhanced": {>> "%config_file%"
echo       "command": "uvx",>> "%config_file%"
echo       "args": ["mcp-feedback-enhanced@latest"],>> "%config_file%"
echo       "timeout": 600,>> "%config_file%"
echo       "env": {>> "%config_file%"
echo         "MCP_WEB_PORT": "8765",>> "%config_file%"
echo         "MCP_DESKTOP_MODE": "true",>> "%config_file%"
echo         "MCP_DEBUG": "true",>> "%config_file%"
echo         "MCP_WINDOW_MODE": "desktop",>> "%config_file%"
echo         "MCP_NO_BROWSER": "true",>> "%config_file%"
echo         "MCP_DESKTOP_MODE": "true">> "%config_file%"
echo       },>> "%config_file%"
echo       "autoApprove": ["interactive_feedback"]>> "%config_file%"
echo     }>> "%config_file%"
echo   }>> "%config_file%"
echo }>> "%config_file%"

echo SUCCESS: Configuration file generated: %config_file%
exit /b 0

:quick_verify
set "path=%~1"
set "tools_count=0"
if exist "%path%\node_modules\@modelcontextprotocol\server-filesystem" set /a tools_count+=1
if exist "%path%\node_modules\@modelcontextprotocol\server-memory" set /a tools_count+=1
if exist "%path%\node_modules\@modelcontextprotocol\server-github" set /a tools_count+=1
if exist "%path%\node_modules\@modelcontextprotocol\server-everything" set /a tools_count+=1
echo   Node.js tools: %tools_count%/4
uvx mcp-feedback-enhanced@latest version >nul 2>&1
if errorlevel 1 (
    echo   Python tools: 0/1 (not installed)
) else (
    echo   Python tools: 1/1 (installed)
)
exit /b 0

:repair_installation
echo REPAIR: 修复安装模式
echo 详细检查现有安装...

set "missing_tools="
if not exist "!install_path!\node_modules\@modelcontextprotocol\server-filesystem" set "missing_tools=!missing_tools! server-filesystem"
if not exist "!install_path!\node_modules\@modelcontextprotocol\server-memory" set "missing_tools=!missing_tools! server-memory"
if not exist "!install_path!\node_modules\@modelcontextprotocol\server-github" set "missing_tools=!missing_tools! server-github"
if not exist "!install_path!\node_modules\@modelcontextprotocol\server-everything" set "missing_tools=!missing_tools! server-everything"

if defined missing_tools (
    echo WARNING: 缺失工具:!missing_tools!
    set "skip_nodejs=false"
) else (
    echo SUCCESS: 所有Node.js工具完整
    set "skip_nodejs=true"
)

uvx mcp-feedback-enhanced@latest version >nul 2>&1
if errorlevel 1 (
    echo INFO: mcp-feedback-enhanced 未安装，将进行安装
    set "skip_python=false"
) else (
    echo SUCCESS: mcp-feedback-enhanced 已安装
    set "skip_python=true"
)

:: 直接跳转到安装目录创建步骤
goto :continue_installation

:success_exit
echo.
echo SUCCESS: Installation program execution complete
echo Press any key to exit...
pause >nul
exit /b 0

:error_exit
echo.
echo ERROR: Installation program encountered error, terminated
echo Press any key to exit...
pause >nul
exit /b 1
