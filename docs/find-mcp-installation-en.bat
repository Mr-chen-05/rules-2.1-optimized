@echo off
setlocal enabledelayedexpansion

echo ========================================
echo      MCP Tools Installation Finder
echo ========================================
echo.
echo Searching for MCP tools installation...
echo.

set "found_path="
set "found_count=0"

echo [INFO] Checking common installation paths...
echo.

:: Check all possible drive letters for common MCP installation paths
for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    :: Check MCP-Tools directory
    if exist "%%d:\MCP-Tools\node_modules\@modelcontextprotocol" (
        echo [FOUND] MCP Tools found at: %%d:\MCP-Tools\node_modules
        echo   Available MCP tools:
        for /d %%f in ("%%d:\MCP-Tools\node_modules\@modelcontextprotocol\*") do (
            echo     - %%~nf
        )
        echo.
        set "found_path=%%d:\MCP-Tools\node_modules\@modelcontextprotocol"
        set /a found_count+=1
    )

    :: Check ALLMCP directory
    if exist "%%d:\ALLMCP\node_modules\@modelcontextprotocol" (
        echo [FOUND] ALLMCP installation found at: %%d:\ALLMCP\node_modules
        echo   Available MCP tools:
        for /d %%f in ("%%d:\ALLMCP\node_modules\@modelcontextprotocol\*") do (
            echo     - %%~nf
        )
        echo.
        set "found_path=%%d:\ALLMCP\node_modules\@modelcontextprotocol"
        set /a found_count+=1
    )
)

:: Check Node.js global installation
echo [INFO] Checking Node.js global installation...
for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\develop\NodeJS\node_modules\@modelcontextprotocol" (
        echo [FOUND] Node.js global installation: %%d:\develop\NodeJS\node_modules
        echo   Available MCP tools:
        for /d %%f in ("%%d:\develop\NodeJS\node_modules\@modelcontextprotocol\*") do (
            echo     - %%~nf
        )
        echo.
        set "found_path=%%d:\develop\NodeJS\node_modules\@modelcontextprotocol"
        set /a found_count+=1
    )
)

:: Check npm global modules
echo [INFO] Checking npm global modules...
for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\Users\%USERNAME%\AppData\Roaming\npm\node_modules\@modelcontextprotocol" (
        echo [FOUND] npm global modules: %%d:\Users\%USERNAME%\AppData\Roaming\npm\node_modules
        echo   Available MCP tools:
        for /d %%f in ("%%d:\Users\%USERNAME%\AppData\Roaming\npm\node_modules\@modelcontextprotocol\*") do (
            echo     - %%~nf
        )
        echo.
        set "found_path=%%d:\Users\%USERNAME%\AppData\Roaming\npm\node_modules\@modelcontextprotocol"
        set /a found_count+=1
    )
)

echo ========================================
echo          Search Results
echo ========================================
echo.

if !found_count! gtr 0 (
    echo [SUCCESS] Found !found_count! MCP installation(s)
    echo.
    echo To verify installation:
    echo   dir "!found_path!"
    echo.
    echo To check Python MCP tools:
    echo   uvx mcp-feedback-enhanced@latest version
    echo.
    echo Note: Use the paths above in your AI tool configuration
) else (
    echo [WARNING] No MCP tools found in standard locations
    echo.
    echo Possible reasons:
    echo   1. MCP tools not installed yet
    echo   2. Installed in non-standard location
    echo   3. Installation incomplete
    echo.
    echo Recommended actions:
    echo   1. Run the MCP installation script first
    echo   2. Check if Node.js is properly installed
    echo   3. Verify npm global installation path
)

echo.
echo [INFO] Checking Python MCP tools...
echo ----------------------------------------
uvx mcp-feedback-enhanced@latest --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] mcp-feedback-enhanced not found
    echo Install with: uvx mcp-feedback-enhanced@latest
) else (
    echo [SUCCESS] mcp-feedback-enhanced is available
    echo Install path: uvx managed installation
)

echo.
echo ========================================
echo.
echo Summary:
echo   - Node.js MCP tools: filesystem, github, everything; server-memory is optional
echo   - Python MCP tools: Managed by uvx (mcp-feedback-enhanced), check with "uvx list"
echo   - Total expected: 4-5 tools (3-4 Node.js + 1 Python)
echo   - Note: If server-memory is not installed, finding 3 Node.js tools is expected
echo.
pause
