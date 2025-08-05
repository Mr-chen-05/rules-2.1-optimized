@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."

echo ========================================
echo  Claude Code Backend Rules Installer
echo ========================================

if "%~1"=="" (
    echo Usage: claude-backend.bat [project-path]
    echo.
    echo Examples:
    echo   claude-backend.bat ..\my-project
    echo   claude-backend.bat C:\projects\demo
    echo   claude-backend.bat .
    echo.
    goto :eof
)

set "PROJECT_PATH=%~1"

echo Installing Claude Code Backend Rules to: "%PROJECT_PATH%"
echo.

REM Create combined CLAUDE.md file for backend
echo Creating CLAUDE.md file...

REM Check if CLAUDE.md already exists (frontend rules might be there)
if exist "%PROJECT_PATH%\CLAUDE.md" (
    echo Existing CLAUDE.md found - merging with backend rules...
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
    echo # Backend Rules Section >> "%PROJECT_PATH%\CLAUDE.md"
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
) else (
    echo # Claude Code Backend Rules > "%PROJECT_PATH%\CLAUDE.md"
    if errorlevel 1 (
        echo ERROR: Failed to create CLAUDE.md file
        pause
        exit /b 1
    )
    echo. >> "%PROJECT_PATH%\CLAUDE.md"
    if errorlevel 1 (
        echo ERROR: Failed to write to CLAUDE.md file
        pause
        exit /b 1
    )
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

type "%RULES_DIR%\global-rules\backend-rules-2.1.md" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append backend-rules-2.1.md
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append backend rules
type "%RULES_DIR%\project-rules\backend-dev.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append backend-dev.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\commit.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append commit.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\code-review.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append code-review.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\bug-fix.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append bug-fix.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\analyze-issue.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append analyze-issue.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\create-docs.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append create-docs.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\implement-task.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append implement-task.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\feedback-enhanced.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append feedback-enhanced.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append MCP intelligent strategy rules (CRITICAL FOR AI EFFICIENCY)
type "%RULES_DIR%\project-rules\mcp-intelligent-strategy.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append mcp-intelligent-strategy.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append new global rules (AI Intelligence Core)
type "%RULES_DIR%\global-rules\ai-agent-intelligence-core.md" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append ai-agent-intelligence-core.md
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\complete-workflow-integration.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append complete-workflow-integration.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\intelligent-recommendation-engine.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append intelligent-recommendation-engine.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\memory-system-integration.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append memory-system-integration.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\super-brain-system.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append super-brain-system.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\system-integration-config.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append system-integration-config.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\rule-conflict-resolution.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append rule-conflict-resolution.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\global-rules\rule-redundancy-optimization.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append rule-redundancy-optimization.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

REM Append new project rules
type "%RULES_DIR%\project-rules\ai-powered-code-review.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append ai-powered-code-review.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\intelligent-project-management.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append intelligent-project-management.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

type "%RULES_DIR%\project-rules\intelligent-workflow-orchestration.mdc" >> "%PROJECT_PATH%\CLAUDE.md"
if errorlevel 1 (
    echo ERROR: Failed to append intelligent-workflow-orchestration.mdc
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\CLAUDE.md"

echo.
echo Claude Code Backend Rules installed successfully!
echo.
echo Available commands:
echo   /backend-dev, /commit, /code-review, /bug-fix
echo   /analyze-issue, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules file location: "%PROJECT_PATH%\CLAUDE.md"
echo.
echo Installation completed with enterprise-level error handling!

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%
