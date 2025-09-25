@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Enhanced encoding detection - Auto-detect system encoding
for /f "tokens=2 delims=:" %%i in ('chcp') do set "CURRENT_CP=%%i"
set "CURRENT_CP=%CURRENT_CP: =%"
if "%CURRENT_CP%"=="936" set "ENCODING_MODE=Chinese_Simplified"
if "%CURRENT_CP%"=="950" set "ENCODING_MODE=Chinese_Traditional"
if "%CURRENT_CP%"=="932" set "ENCODING_MODE=Japanese"
if "%CURRENT_CP%"=="949" set "ENCODING_MODE=Korean"
if "%CURRENT_CP%"=="437" set "ENCODING_MODE=Western"
if "%CURRENT_CP%"=="65001" set "ENCODING_MODE=UTF8"
if not defined ENCODING_MODE set "ENCODING_MODE=Unknown"

REM ASCII-safe path cleaning using PowerShell
set "RAW_TARGET=%~1"
if defined RAW_TARGET (
    for /f "delims=" %%i in ('powershell -Command "[System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::UTF8.GetBytes('%RAW_TARGET%')) -replace '[\u200B-\u200D\uFEFF\u202A-\u202E]', '' | ForEach-Object { $_.Trim() }"') do set "TARGET_DIR=%%i"
) else (
    set "TARGET_DIR="
)

echo ========================================
echo AgentRules Comprehensive Detection Tool
echo ========================================

if "%~1"=="" (
    echo Usage: comprehensive-test-report.bat [project-path]
    echo.
    echo This tool will:
    echo   1. Detect installed rules mode type
    echo   2. Verify file count and structure integrity
    echo   3. Generate detailed detection report
    echo   4. Check rules directory structure
    echo.
    echo Example: comprehensive-test-report.bat C:\Users\luo20\Desktop\demo-project
    goto :eof
)

set "PROJECT_PATH=%TARGET_DIR%"
set "RULES_PATH=%PROJECT_PATH%\.rules"

echo Detecting project path: %PROJECT_PATH%
echo Rules directory path: %RULES_PATH%
echo.

REM Check if rules directory exists
if not exist "%RULES_PATH%" (
    echo ERROR: Rules directory does not exist - %RULES_PATH%
    echo Please install rules first using install-ultra.bat
    pause
    goto :eof
)

echo Rules directory exists, starting comprehensive detection...
echo.

REM Check directory structure
echo Directory Structure Detection:
set "MISSING_DIRS=0"
for %%d in (P0-core-safety P1-core-identity P2-intelligent-system P3-professional-dev P4-project-workflow P5-advanced-features P6-system-optimization P7-utilities) do (
    if exist "%RULES_PATH%\%%d" (
        echo   OK %%d
    ) else (
        echo   MISSING %%d
        set /a MISSING_DIRS+=1
    )
)

if %MISSING_DIRS% GTR 0 (
    echo   WARNING: Found %MISSING_DIRS% missing priority directories
) else (
    echo   OK All 8 priority directories complete
)
echo.

REM Count files
set /a TOTAL_FILES=0
set /a MD_FILES=0
set /a MDC_FILES=0

echo File Statistics:
for /r "%RULES_PATH%" %%f in (*.md *.mdc) do (
    set /a TOTAL_FILES+=1
    if /i "%%~xf"==".md" set /a MD_FILES+=1
    if /i "%%~xf"==".mdc" set /a MDC_FILES+=1
)

echo   Total files: %TOTAL_FILES%
echo   .md files: %MD_FILES%
echo   .mdc files: %MDC_FILES%
echo.

REM Detect key files
echo Key File Detection:
set "HAS_MERMAID=0"
set "HAS_FRONTEND_DEV=0"
set "HAS_BACKEND_DEV=0"
set "HAS_FRONTEND_RULES=0"
set "HAS_BACKEND_RULES=0"
set "HAS_MAIN_MD=0"

if exist "%RULES_PATH%\main.md" (
    set "HAS_MAIN_MD=1"
    echo   OK main.md - Rules directory guide
) else (
    echo   MISSING main.md - Directory guide missing
)

if exist "%RULES_PATH%\P7-utilities\mermaid.mdc" (
    set "HAS_MERMAID=1"
    echo   OK mermaid.mdc - Chart support
) else (
    echo   MISSING mermaid.mdc - No chart support
)

if exist "%RULES_PATH%\P4-project-workflow\frontend-dev.mdc" (
    set "HAS_FRONTEND_DEV=1"
    echo   OK frontend-dev.mdc - Frontend workflow
) else (
    echo   MISSING frontend-dev.mdc - No frontend workflow
)

if exist "%RULES_PATH%\P4-project-workflow\backend-dev.mdc" (
    set "HAS_BACKEND_DEV=1"
    echo   OK backend-dev.mdc - Backend workflow
) else (
    echo   MISSING backend-dev.mdc - No backend workflow
)

if exist "%RULES_PATH%\P3-professional-dev\frontend-rules.mdc" (
    set "HAS_FRONTEND_RULES=1"
    echo   OK frontend-rules.mdc - Frontend rules
) else (
    echo   MISSING frontend-rules.mdc - No frontend rules
)

if exist "%RULES_PATH%\P3-professional-dev\backend-rules.mdc" (
    set "HAS_BACKEND_RULES=1"
    echo   OK backend-rules.mdc - Backend rules
) else (
    echo   MISSING backend-rules.mdc - No backend rules
)

echo.

REM Intelligent mode detection
echo Mode Detection Results:
set "DETECTED_MODE=UNKNOWN"
set "MODE_CONFIDENCE=LOW"

if %TOTAL_FILES% GEQ 32 if %TOTAL_FILES% LEQ 34 (
    if %HAS_MERMAID%==1 if %HAS_FRONTEND_DEV%==1 if %HAS_BACKEND_DEV%==1 (
        set "DETECTED_MODE=FULLSTACK"
        set "MODE_CONFIDENCE=HIGH"
        echo   Detected: FULLSTACK mode (Full-stack development)
        echo   File count: %TOTAL_FILES% (expected: 33)
        echo   OK Contains frontend, backend and chart support
        goto :mode_detected
    ) else (
        set "MODE_CONFIDENCE=MEDIUM"
        echo   WARNING File count matches fullstack but missing key files
        goto :mode_detected
    )
)

if %TOTAL_FILES% GEQ 30 if %TOTAL_FILES% LEQ 32 (
    if %HAS_MERMAID%==1 if %HAS_FRONTEND_DEV%==1 if %HAS_BACKEND_DEV%==0 (
        set "DETECTED_MODE=FRONTEND"
        set "MODE_CONFIDENCE=HIGH"
        echo   Detected: FRONTEND mode (Frontend development)
        echo   File count: %TOTAL_FILES% (expected: 31)
        echo   OK Contains frontend development and chart support
        goto :mode_detected
    ) else (
        set "MODE_CONFIDENCE=MEDIUM"
        echo   WARNING File count matches frontend but configuration abnormal
        goto :mode_detected
    )
)

if %TOTAL_FILES% GEQ 29 if %TOTAL_FILES% LEQ 31 (
    if %HAS_MERMAID%==0 if %HAS_BACKEND_DEV%==1 if %HAS_FRONTEND_DEV%==0 (
        set "DETECTED_MODE=BACKEND"
        set "MODE_CONFIDENCE=HIGH"
        echo   Detected: BACKEND mode (Backend development)
        echo   File count: %TOTAL_FILES% (expected: 30)
        echo   OK Contains backend development, no chart support
        goto :mode_detected
    ) else (
        set "MODE_CONFIDENCE=MEDIUM"
        echo   WARNING File count matches backend but configuration abnormal
        goto :mode_detected
    )
)

echo   Unknown mode or incomplete files
echo   File count: %TOTAL_FILES%
echo   Expected count: Frontend(31), Backend(30), Fullstack(33)

:mode_detected
echo.

REM Health assessment
echo Rules Health Assessment:
set /a HEALTH_SCORE=0

if %MISSING_DIRS%==0 set /a HEALTH_SCORE+=20
if %HAS_MAIN_MD%==1 set /a HEALTH_SCORE+=10
if %TOTAL_FILES% GEQ 29 set /a HEALTH_SCORE+=30
if "%MODE_CONFIDENCE%"=="HIGH" set /a HEALTH_SCORE+=40

if %HEALTH_SCORE% GEQ 90 (
    echo   EXCELLENT ^(%HEALTH_SCORE%/100^) - Rules complete and configured correctly
) else (
    if %HEALTH_SCORE% GEQ 70 (
        echo   GOOD ^(%HEALTH_SCORE%/100^) - Rules basically complete with minor issues
    ) else (
        if %HEALTH_SCORE% GEQ 50 (
            echo   FAIR ^(%HEALTH_SCORE%/100^) - Rules incomplete or misconfigured
        ) else (
            echo   POOR ^(%HEALTH_SCORE%/100^) - Rules seriously incomplete
        )
    )
)

echo.

REM Recommendations
echo Recommendations:
if %MISSING_DIRS% GTR 0 echo   Re-run install-ultra.bat to fix missing directories
if %HAS_MAIN_MD%==0 echo   Missing main.md file may affect AI understanding
if "%MODE_CONFIDENCE%"=="LOW" echo   File configuration abnormal, recommend reinstalling rules
if %TOTAL_FILES% LSS 29 echo   Too few files, check installation process

echo.
echo ========================================
echo Comprehensive Detection Complete
echo Detection Mode: %DETECTED_MODE%
echo Confidence: %MODE_CONFIDENCE%
echo Health Score: %HEALTH_SCORE%/100
echo ========================================
pause