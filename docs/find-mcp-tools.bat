@echo off
chcp 65001 >nul
title MCP Tools Location Finder
color 0A

echo.
echo ========================================
echo    MCP Tools Location Finder v1.0
echo ========================================
echo.

echo Systematically searching for MCP tools installation location...
echo.

echo [1/6] Checking npm global packages...
echo ----------------------------------------
npm list -g --depth=0 2>nul | findstr "modelcontextprotocol"
if errorlevel 1 (
    echo [ERROR] MCP tools not found in npm global packages
) else (
    echo [OK] MCP tools found in npm global packages
)
echo.

echo [2/6] Checking npm global installation path...
echo ----------------------------------------
for /f "tokens=*" %%i in ('npm root -g 2^>nul') do (
    echo npm global path: %%i
    if exist "%%i\@modelcontextprotocol" (
        echo [OK] Found MCP tools: %%i\@modelcontextprotocol
        dir "%%i\@modelcontextprotocol" /b
    )
)
echo.

echo [3/6] Checking common installation locations...
echo ----------------------------------------
set "found=0"

if exist "%APPDATA%\npm\node_modules\@modelcontextprotocol" (
    echo [OK] Found: %APPDATA%\npm\node_modules\@modelcontextprotocol
    set "found=1"
)

if exist "C:\Program Files\nodejs\node_modules\@modelcontextprotocol" (
    echo [OK] Found: C:\Program Files\nodejs\node_modules\@modelcontextprotocol
    set "found=1"
)

if exist "C:\MCP-Tools\node_modules\@modelcontextprotocol" (
    echo [OK] Found: C:\MCP-Tools\node_modules\@modelcontextprotocol
    set "found=1"
)

if exist "C:\tools\node_modules\@modelcontextprotocol" (
    echo [OK] Found: C:\tools\node_modules\@modelcontextprotocol
    set "found=1"
)

if "%found%"=="0" (
    echo [ERROR] MCP tools not found in common locations
)
echo.

echo [4/6] Checking Node.js and npm locations...
echo ----------------------------------------
where node 2>nul
where npm 2>nul
echo.

echo [5/6] Checking Python packages...
echo ----------------------------------------
echo Checking Python MCP packages...
pip list 2>nul | findstr "mcp"
if errorlevel 1 (
    echo [INFO] MCP tools not found in Python packages
) else (
    echo [OK] Found MCP-related Python packages above
)

echo.
echo [6/6] Checking Python package locations...
echo ----------------------------------------
echo Checking mcp-feedback-enhanced location...
pip show mcp-feedback-enhanced 2>nul | findstr "Location:"
echo.
echo Checking fastmcp location...
pip show fastmcp 2>nul | findstr "Location:"
echo.
echo Checking core mcp location...
pip show mcp 2>nul | findstr "Location:"
echo.

echo ========================================
echo Search Complete!
echo ========================================
echo.
echo If MCP tools location is shown above, please record it for configuration.
echo If not found, you may need to reinstall MCP tools.
echo.
echo Reinstall commands:
echo    npm install -g @modelcontextprotocol/server-filesystem
echo    npm install -g @modelcontextprotocol/server-memory
echo    npm install -g @modelcontextprotocol/server-github
echo    npm install -g @modelcontextprotocol/server-everything
echo.

pause 