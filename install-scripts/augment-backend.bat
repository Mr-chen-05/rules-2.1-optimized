@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."

echo ========================================
echo  Augment Backend Rules Installer
echo ========================================

if "%~1"=="" (
    echo Usage: augment-backend.bat [project-path]
    echo.
    echo Examples:
    echo   augment-backend.bat ..\my-project
    echo   augment-backend.bat C:\projects\demo
    echo   augment-backend.bat .
    echo.
    goto :eof
)

set PROJECT_PATH=%~1

echo Installing Augment Backend Rules to: %PROJECT_PATH%
echo.

REM Create Augment directories
if not exist "%PROJECT_PATH%\.augment" mkdir "%PROJECT_PATH%\.augment"
if not exist "%PROJECT_PATH%\.augment\rules" mkdir "%PROJECT_PATH%\.augment\rules"

REM Copy file generation safety rules first (HIGHEST PRIORITY)
copy /Y "%RULES_DIR%\global-rules\file-generation-safety-rules.md" "%PROJECT_PATH%\.augment\rules\" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy file generation safety rules
    pause
    exit /b 1
)

echo Creating complete backend rules file...

REM Start with global backend rules
copy /Y "%RULES_DIR%\global-rules\backend-rules-2.1.md" "%PROJECT_PATH%\.augment\rules\backend-complete.md" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Append project-specific rules (only existing files)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
echo # Project-Specific Rules >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\backend-dev.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\analyze-issue.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\commit.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\code-review.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\bug-fix.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\create-docs.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\implement-task.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\feedback-enhanced.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Copy MCP intelligent strategy rules (CRITICAL FOR AI EFFICIENCY)
type "%RULES_DIR%\project-rules\mcp-intelligent-strategy.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append new global rules (AI Intelligence Core)
type "%RULES_DIR%\global-rules\ai-agent-intelligence-core.md" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\global-rules\complete-workflow-integration.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\global-rules\intelligent-recommendation-engine.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\global-rules\memory-system-integration.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\global-rules\super-brain-system.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\global-rules\system-integration-config.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\global-rules\rule-conflict-resolution.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\global-rules\rule-redundancy-optimization.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append new project rules
type "%RULES_DIR%\project-rules\ai-powered-code-review.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\intelligent-project-management.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

type "%RULES_DIR%\project-rules\intelligent-workflow-orchestration.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

echo.
echo Augment Backend Rules installed successfully
echo.
echo Available commands:
echo   /backend-dev, /analyze-issue, /commit, /code-review
echo   /bug-fix, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules file location: %PROJECT_PATH%\.augment\rules\backend-complete.md
echo.

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%