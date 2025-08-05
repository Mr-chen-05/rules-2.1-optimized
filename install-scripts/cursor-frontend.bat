@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."

echo ========================================
echo  Cursor Frontend Rules Installer
echo ========================================

if "%~1"=="" (
    echo Usage: cursor-frontend.bat [project-path]
    echo.
    echo Examples:
    echo   cursor-frontend.bat ..\my-project
    echo   cursor-frontend.bat C:\projects\demo
    echo   cursor-frontend.bat .
    echo.
    goto :eof
)

set PROJECT_PATH=%~1

echo Installing Cursor Frontend Rules to: %PROJECT_PATH%
echo.

REM Create Cursor directories
if not exist "%PROJECT_PATH%\.cursor" mkdir "%PROJECT_PATH%\.cursor"
if not exist "%PROJECT_PATH%\.cursor\rules" mkdir "%PROJECT_PATH%\.cursor\rules"

REM Copy individual rule files for Cursor
echo Copying frontend rule files...

REM Copy file generation safety rules first (HIGHEST PRIORITY)
copy /Y "%RULES_DIR%\global-rules\file-generation-safety-rules.md" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy file generation safety rules
    pause
    exit /b 1
)

REM Copy global frontend rules
copy /Y "%RULES_DIR%\global-rules\frontend-rules-2.1.md" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy frontend rules
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\frontend-dev.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\commit.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\code-review.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\bug-fix.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\mermaid.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\create-docs.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\implement-task.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

copy /Y "%RULES_DIR%\project-rules\feedback-enhanced.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy MCP intelligent strategy rules (CRITICAL FOR AI EFFICIENCY)
copy /Y "%RULES_DIR%\project-rules\mcp-intelligent-strategy.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy new AI intelligence rules (v2.3.0)
copy /Y "%RULES_DIR%\global-rules\ai-agent-intelligence-core.md" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy workflow integration rules
copy /Y "%RULES_DIR%\global-rules\complete-workflow-integration.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy intelligent recommendation engine
copy /Y "%RULES_DIR%\global-rules\intelligent-recommendation-engine.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy memory system integration
copy /Y "%RULES_DIR%\global-rules\memory-system-integration.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy super brain system
copy /Y "%RULES_DIR%\global-rules\super-brain-system.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy system integration config
copy /Y "%RULES_DIR%\global-rules\system-integration-config.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy rule conflict resolution
copy /Y "%RULES_DIR%\global-rules\rule-conflict-resolution.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy rule redundancy optimization
copy /Y "%RULES_DIR%\global-rules\rule-redundancy-optimization.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy new project rules (v2.3.0)
copy /Y "%RULES_DIR%\project-rules\ai-powered-code-review.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy intelligent project management
copy /Y "%RULES_DIR%\project-rules\intelligent-project-management.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy intelligent workflow orchestration
copy /Y "%RULES_DIR%\project-rules\intelligent-workflow-orchestration.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Copy frontend development rules
copy /Y "%RULES_DIR%\project-rules\frontend-dev.mdc" "%PROJECT_PATH%\.cursor\rules\" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

echo.
echo Cursor Frontend Rules installed successfully!
echo.
echo Available commands:
echo   /frontend-dev, /commit, /code-review, /bug-fix
echo   /mermaid, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules files location: %PROJECT_PATH%\.cursor\rules\
echo.

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%