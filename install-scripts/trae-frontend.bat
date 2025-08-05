@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."


echo ========================================
echo  Trae AI Frontend Rules Installer
echo ========================================

if "%~1"=="" (
    echo Usage: trae-frontend.bat [project-path]
    echo.
    echo Examples:
    echo   trae-frontend.bat ..\my-project
    echo   trae-frontend.bat C:\projects\demo
    echo   trae-frontend.bat .
    echo.
    goto :eof
)

set PROJECT_PATH=%~1

echo Installing Trae AI Frontend Rules to: %PROJECT_PATH%
echo.

REM Create Trae AI directories
if not exist "%PROJECT_PATH%\.trae" mkdir "%PROJECT_PATH%\.trae"
if not exist "%PROJECT_PATH%\.trae\rules" mkdir "%PROJECT_PATH%\.trae\rules"

REM Create combined frontend rules file
echo Creating complete frontend rules file...

REM Start with file generation safety rules (HIGHEST PRIORITY)
copy /Y "%RULES_DIR%\global-rules\file-generation-safety-rules.md" "%PROJECT_PATH%\.trae\rules\frontend-complete.md" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy file generation safety rules
    pause
    exit /b 1
)

REM Append global frontend rules
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
echo ========================================== >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
type "%RULES_DIR%\global-rules\frontend-rules-2.1.md" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: Failed to append frontend rules
    pause
    exit /b 1
)

REM Append project rules
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
echo ## Additional Commands for Trae AI >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append commit rules
type "%RULES_DIR%\project-rules\commit.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append code review rules
type "%RULES_DIR%\project-rules\code-review.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append bug fix rules
type "%RULES_DIR%\project-rules\bug-fix.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append mermaid rules
type "%RULES_DIR%\project-rules\mermaid.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append create docs rules
type "%RULES_DIR%\project-rules\create-docs.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append implement task rules
type "%RULES_DIR%\project-rules\implement-task.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append feedback enhanced rules
type "%RULES_DIR%\project-rules\feedback-enhanced.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append MCP intelligent strategy rules (CRITICAL FOR AI EFFICIENCY)
type "%RULES_DIR%\project-rules\mcp-intelligent-strategy.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append new AI intelligence rules
type "%RULES_DIR%\global-rules\ai-agent-intelligence-core.md" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append workflow integration rules
type "%RULES_DIR%\global-rules\complete-workflow-integration.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append intelligent recommendation engine
type "%RULES_DIR%\global-rules\intelligent-recommendation-engine.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append memory system integration
type "%RULES_DIR%\global-rules\memory-system-integration.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append super brain system
type "%RULES_DIR%\global-rules\super-brain-system.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append system integration config
type "%RULES_DIR%\global-rules\system-integration-config.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append rule conflict resolution
type "%RULES_DIR%\global-rules\rule-conflict-resolution.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append rule redundancy optimization
type "%RULES_DIR%\global-rules\rule-redundancy-optimization.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append new project rules
type "%RULES_DIR%\project-rules\ai-powered-code-review.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append intelligent project management
type "%RULES_DIR%\project-rules\intelligent-project-management.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append intelligent workflow orchestration
type "%RULES_DIR%\project-rules\intelligent-workflow-orchestration.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"

REM Append frontend development rules
type "%RULES_DIR%\project-rules\frontend-dev.mdc" >> "%PROJECT_PATH%\.trae\rules\frontend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)

echo.
echo Trae AI Frontend Rules installed successfully!
echo.
echo Available commands:
echo   /frontend-dev, /component, /ui-design
echo   /commit, /code-review, /bug-fix
echo   /mermaid, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules file location: %PROJECT_PATH%\.trae\rules\frontend-complete.md
echo.

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%
