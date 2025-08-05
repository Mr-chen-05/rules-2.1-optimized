@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."

echo ========================================
echo  Augment Frontend Rules Installer
echo ========================================

if "%~1"=="" (
    echo Usage: augment-frontend.bat [project-path]
    echo.
    echo Examples:
    echo   augment-frontend.bat ..\my-project
    echo   augment-frontend.bat C:\projects\demo
    echo   augment-frontend.bat .
    echo.
    goto :eof
)

REM Clean the project path to remove any Unicode control characters
set "PROJECT_PATH=%~1"
REM Remove Unicode control characters and quotes
for /f "delims=" %%i in ('echo %PROJECT_PATH%') do set "PROJECT_PATH=%%i"
set "PROJECT_PATH=%PROJECT_PATH:"=%"

echo Installing Augment Frontend Rules to: %PROJECT_PATH%
echo.

REM Validate and create project directory if needed
if not exist "%PROJECT_PATH%" (
    echo Creating project directory: %PROJECT_PATH%
    mkdir "%PROJECT_PATH%" 2>nul
)

REM Create Augment directories
if not exist "%PROJECT_PATH%\.augment" mkdir "%PROJECT_PATH%\.augment" 2>nul
if not exist "%PROJECT_PATH%\.augment\rules" mkdir "%PROJECT_PATH%\.augment\rules" 2>nul

REM Verify directories were created
if not exist "%PROJECT_PATH%\.augment\rules" (
    echo ERROR: Cannot create directory structure in: %PROJECT_PATH%
    echo Please check the path and permissions.
    pause
    exit /b 1
)

REM Create combined frontend rules file
echo Creating complete frontend rules file...

REM Start with file generation safety rules (HIGHEST PRIORITY)
copy /Y "%RULES_DIR%\global-rules\file-generation-safety-rules.md" "%PROJECT_PATH%\.augment\rules\frontend-complete.md" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy file generation safety rules
    pause
    exit /b 1
)

REM Append global frontend rules
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
echo ========================================== >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
type "%RULES_DIR%\global-rules\frontend-rules-2.1.md" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: Failed to append frontend rules
    pause
    exit /b 1
)

REM Append project rules
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
echo ## Additional Commands for Augment >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append commit rules
type "%RULES_DIR%\project-rules\commit.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append code review rules
type "%RULES_DIR%\project-rules\code-review.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append bug fix rules
type "%RULES_DIR%\project-rules\bug-fix.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append analyze issue rules
type "%RULES_DIR%\project-rules\analyze-issue.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append create docs rules
type "%RULES_DIR%\project-rules\create-docs.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append implement task rules
type "%RULES_DIR%\project-rules\implement-task.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append feedback enhanced rules
type "%RULES_DIR%\project-rules\feedback-enhanced.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append MCP intelligent strategy rules (CRITICAL FOR AI EFFICIENCY)
type "%RULES_DIR%\project-rules\mcp-intelligent-strategy.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append new AI intelligence rules (v2.3.1)
type "%RULES_DIR%\global-rules\ai-agent-intelligence-core.md" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append workflow integration rules
type "%RULES_DIR%\global-rules\complete-workflow-integration.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append intelligent recommendation engine
type "%RULES_DIR%\global-rules\intelligent-recommendation-engine.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append memory system integration
type "%RULES_DIR%\global-rules\memory-system-integration.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append super brain system
type "%RULES_DIR%\global-rules\super-brain-system.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append system integration config
type "%RULES_DIR%\global-rules\system-integration-config.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append rule conflict resolution
type "%RULES_DIR%\global-rules\rule-conflict-resolution.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append rule redundancy optimization
type "%RULES_DIR%\global-rules\rule-redundancy-optimization.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append new project rules (v2.3.1)
type "%RULES_DIR%\project-rules\ai-powered-code-review.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append intelligent project management
type "%RULES_DIR%\project-rules\intelligent-project-management.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append intelligent workflow orchestration
type "%RULES_DIR%\project-rules\intelligent-workflow-orchestration.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"

REM Append frontend development rules
type "%RULES_DIR%\project-rules\frontend-dev.mdc" >> "%PROJECT_PATH%\.augment\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)

echo.
echo Augment Frontend Rules installed successfully!
echo.
echo Available commands:
echo   /frontend-dev, /ui-design, /responsive-design
echo   /commit, /code-review, /bug-fix
echo   /analyze-issue, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules file location: %PROJECT_PATH%\.augment\rules\frontend-complete.md
echo.

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%