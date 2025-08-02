@echo off
chcp 65001 >nul
setlocal

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."

echo ========================================
echo  Claude Code Fullstack Rules Installer
echo ========================================

if "%~1"=="" (
    echo Usage: claude-fullstack.bat [project-path]
    echo.
    echo Examples:
    echo   claude-fullstack.bat ..\my-project
    echo   claude-fullstack.bat C:\projects\demo
    echo   claude-fullstack.bat .
    echo.
    goto :eof
)

set "PROJECT_PATH=%~1"

echo Installing Claude Code Fullstack Rules to: %PROJECT_PATH%
echo.

REM Create combined CLAUDE.md file for fullstack
echo Creating CLAUDE.md file...

echo # Claude Code Fullstack Rules > "%PROJECT_PATH%\CLAUDE.md"
echo. >> "%PROJECT_PATH%\CLAUDE.md"
echo This file contains both frontend and backend development rules. >> "%PROJECT_PATH%\CLAUDE.md"
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Add frontend section
echo # Frontend Development Rules >> "%PROJECT_PATH%\CLAUDE.md"
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\frontend-rules-2.1.md" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\frontend-dev.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Add backend section
echo. >> "%PROJECT_PATH%\CLAUDE.md"
echo # Backend Development Rules >> "%PROJECT_PATH%\CLAUDE.md"
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\backend-rules-2.1.md" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\backend-dev.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Add common project rules
echo. >> "%PROJECT_PATH%\CLAUDE.md"
echo # Common Project Rules >> "%PROJECT_PATH%\CLAUDE.md"
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\commit.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\code-review.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\bug-fix.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\analyze-issue.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\mermaid.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\create-docs.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\implement-task.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\feedback-enhanced.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append MCP intelligent strategy rules (CRITICAL FOR AI EFFICIENCY)
type "%RULES_DIR%\project-rules\mcp-intelligent-strategy.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)

echo.
echo Claude Code Fullstack Rules installed successfully!
echo.
echo Available commands:
echo   /frontend-dev, /backend-dev, /commit, /code-review, /bug-fix
echo   /analyze-issue, /mermaid, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules file location: %PROJECT_PATH%\CLAUDE.md
echo.

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%
