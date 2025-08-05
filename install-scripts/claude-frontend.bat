@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."

echo ========================================
echo  Claude Code Frontend Rules Installer
echo ========================================

if "%~1"=="" (
    echo Usage: claude-frontend.bat [project-path]
    echo.
    echo Examples:
    echo   claude-frontend.bat ..\my-project
    echo   claude-frontend.bat C:\projects\demo
    echo   claude-frontend.bat .
    echo.
    goto :eof
)

set "PROJECT_PATH=%~1"

echo Installing Claude Code Frontend Rules to: %PROJECT_PATH%
echo.

REM Create combined CLAUDE.md file for frontend
echo Creating CLAUDE.md file...

REM Check if CLAUDE.md already exists (backend rules might be there)
if exist "%PROJECT_PATH%\CLAUDE.md" (
    echo Existing CLAUDE.md found - merging with frontend rules...
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
    echo # Frontend Rules Section >> "%PROJECT_PATH%\CLAUDE.md"
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
) else (
    echo # Claude Code Frontend Rules > "%PROJECT_PATH%\CLAUDE.md"
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
)

REM Add file generation safety rules first (HIGHEST PRIORITY)
type "%RULES_DIR%\global-rules\file-generation-safety-rules.md" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to add file generation safety rules
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"
echo ========================================== >> "%PROJECT_PATH%\CLAUDE.md"
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\frontend-rules-2.1.md" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append frontend rules
type "%RULES_DIR%\project-rules\frontend-dev.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
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
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append new global rules (AI Intelligence Core)
type "%RULES_DIR%\global-rules\ai-agent-intelligence-core.md" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\complete-workflow-integration.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\intelligent-recommendation-engine.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\memory-system-integration.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\super-brain-system.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\system-integration-config.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\rule-conflict-resolution.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\rule-redundancy-optimization.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append new project rules
type "%RULES_DIR%\project-rules\ai-powered-code-review.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\intelligent-project-management.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\intelligent-workflow-orchestration.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

echo.
echo Claude Code Frontend Rules installed successfully!
echo.
echo Available commands:
echo   /frontend-dev, /commit, /code-review, /bug-fix
echo   /mermaid, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules file location: %PROJECT_PATH%\CLAUDE.md
echo.

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%