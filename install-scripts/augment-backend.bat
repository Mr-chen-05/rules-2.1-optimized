@echo off
chcp 65001 >nul
setlocal

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

REM Create combined backend rules file
echo Creating complete backend rules file...

REM Start with global backend rules
copy /Y "%RULES_DIR%\global-rules\backend-rules-2.1.md" "%PROJECT_PATH%\.augment\rules\backend-complete.md" >nul
if errorlevel 1 (
    echo ERROR: Operation failed
    pause
    exit /b 1
)

REM Append project rules
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
echo ## Additional Commands for Augment >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append commit rules
type "%RULES_DIR%\project-rules\commit.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append code review rules
type "%RULES_DIR%\project-rules\code-review.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append bug fix rules
type "%RULES_DIR%\project-rules\bug-fix.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append analyze issue rules
type "%RULES_DIR%\project-rules\analyze-issue.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append create docs rules
type "%RULES_DIR%\project-rules\create-docs.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append implement task rules
type "%RULES_DIR%\project-rules\implement-task.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"



REM Append feedback enhanced rules
type "%RULES_DIR%\project-rules\feedback-enhanced.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)
echo. >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"

REM Append MCP intelligent strategy rules (CRITICAL FOR AI EFFICIENCY)
type "%RULES_DIR%\project-rules\mcp-intelligent-strategy.mdc" >> "%PROJECT_PATH%\.augment\rules\backend-complete.md"
if errorlevel 1 (
    echo ERROR: File operation failed
    pause
    exit /b 1
)

echo.
echo Augment Backend Rules installed successfully!
echo.
echo Available commands:
echo   /backend-dev, /api-design, /database-design
echo   /commit, /code-review, /bug-fix
echo   /analyze-issue, /create-docs, /implement-task
echo   /feedback
echo.
echo Rules file location: %PROJECT_PATH%\.augment\rules\backend-complete.md
echo.

REM Standard exit code handling for && || compatibility
cmd /c exit %ERRORLEVEL%
