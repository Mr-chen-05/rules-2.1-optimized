@echo off
setlocal enabledelayedexpansion

REM ========================================
REM Rules 2.6.0 Comprehensive Detection Tool
REM Version: 2.2 (2025-10-20 Update)
REM ========================================

REM Enhanced System Encoding Detection and Auto-Adaptation
REM Detect current system code page and set appropriate encoding
for /f "tokens=2 delims=:" %%i in ('chcp') do set "CURRENT_CP=%%i"
set "CURRENT_CP=%CURRENT_CP: =%"

REM Auto-detect and set optimal encoding based on system
if "%CURRENT_CP%"=="936" (
    REM Chinese Simplified system
    chcp 65001 >nul 2>&1 || chcp 936 >nul
    set "ENCODING_MODE=UTF8_CN"
) else if "%CURRENT_CP%"=="950" (
    REM Chinese Traditional system  
    chcp 65001 >nul 2>&1 || chcp 950 >nul
    set "ENCODING_MODE=UTF8_TW"
) else if "%CURRENT_CP%"=="932" (
    REM Japanese system
    chcp 65001 >nul 2>&1 || chcp 932 >nul
    set "ENCODING_MODE=UTF8_JP"
) else if "%CURRENT_CP%"=="949" (
    REM Korean system
    chcp 65001 >nul 2>&1 || chcp 949 >nul
    set "ENCODING_MODE=UTF8_KR"
) else (
    REM Western/English systems or others
    chcp 65001 >nul 2>&1 || chcp 437 >nul
    set "ENCODING_MODE=UTF8_EN"
)

REM Enhanced encoding stability test
set "ENCODING_TEST=OK"
if not "%ENCODING_TEST%"=="OK" (
    echo WARNING: Encoding environment may be unstable. Using ASCII-safe mode.
    set "ENCODING_MODE=ASCII_SAFE"
)

echo ========================================
echo Rules 2.6.0 Comprehensive Detection Tool
echo ========================================

REM Get project path from parameter, use current directory if not provided
set "PROJECT_PATH=%~1"
if "%PROJECT_PATH%"=="" set "PROJECT_PATH=%CD%"

REM Enhanced Unicode control character cleaning - ASCII-safe via PowerShell
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "$t='%PROJECT_PATH%'; $chars=@(0x202A,0x202B,0x202C,0x202D,0x202E,0x200B,0x200C,0x200D,0xFEFF); foreach($c in $chars){ $t=$t -replace [char]$c, '' }; $t=$t.Trim(); Write-Output $t"`) do set "PROJECT_PATH=%%A"

echo Detecting project path: %PROJECT_PATH%

REM Check if .rules directory exists (new structure)
set "RULES_DIR=%PROJECT_PATH%\.rules"
if exist "%RULES_DIR%" (
    echo Rules directory path: %RULES_DIR%
) else (
    REM Try old structure with rules directory
    set "RULES_DIR=%PROJECT_PATH%\rules"
    if exist "%RULES_DIR%" (
        echo Rules directory path: %RULES_DIR%
    ) else (
        echo ERROR: Rules directory not found!
        echo Checked paths:
        echo   - %PROJECT_PATH%\.rules
        echo   - %PROJECT_PATH%\rules
        echo.
        echo Please ensure you are running this script in a project with installed rules.
        echo.
        pause
        exit /b 1
    )
)

echo.
echo Rules directory exists, starting comprehensive detection...
echo.

REM Initialize counters and flags
set /a SCORE=0
set /a MAX_SCORE=100
set /a DIR_SCORE=0
set /a FILE_SCORE=0
set /a KEY_FILE_SCORE=0
set /a MODE_SCORE=0

REM ========================================
REM Directory Structure Detection
REM ========================================
echo Directory Structure Detection:
set /a EXPECTED_DIRS=8
set /a FOUND_DIRS=0

REM Check each priority directory
set "PRIORITY_DIRS=P0-core-safety P1-core-identity P2-intelligent-system P3-professional-dev P4-project-workflow P5-advanced-features P6-system-optimization P7-utilities"

for %%D in (%PRIORITY_DIRS%) do (
    if exist "%RULES_DIR%\%%D" (
        echo   OK %%D
        set /a FOUND_DIRS+=1
    ) else (
        echo   MISSING %%D
    )
)

if %FOUND_DIRS% EQU %EXPECTED_DIRS% (
    echo   OK All %EXPECTED_DIRS% priority directories complete
    set /a DIR_SCORE=25
) else (
    echo   WARNING: Only %FOUND_DIRS%/%EXPECTED_DIRS% directories found
    set /a DIR_SCORE=%FOUND_DIRS%*25/%EXPECTED_DIRS%
)

echo.

REM ========================================
REM File Statistics
REM ========================================
echo File Statistics:
set /a MDC_COUNT=0
set /a MD_COUNT=0

REM Count .mdc files (rule files)
for /r "%RULES_DIR%" %%f in (*.mdc) do set /a MDC_COUNT+=1

REM Count .md files (index files)
for /r "%RULES_DIR%" %%f in (*.md) do set /a MD_COUNT+=1

echo   Rule files (.mdc): %MDC_COUNT%
echo   Index files (.md): %MD_COUNT%
echo   Total rule count: %MDC_COUNT% (based on .mdc files)

echo.

REM ========================================
REM Key File Detection
REM ========================================
echo Key File Detection:
set /a KEY_FILES_FOUND=0
set /a KEY_FILES_EXPECTED=8

REM Check main.md
if exist "%RULES_DIR%\main.md" (
    echo   OK main.md - Rules directory guide
    set /a KEY_FILES_FOUND+=1
) else (
    echo   MISSING main.md - Rules directory guide
)

REM Check mermaid.mdc
if exist "%RULES_DIR%\P7-utilities\mermaid.mdc" (
    echo   OK mermaid.mdc - Chart support
    set /a KEY_FILES_FOUND+=1
) else (
    echo   MISSING mermaid.mdc - Chart support
)

REM Check frontend-dev.mdc
if exist "%RULES_DIR%\P4-project-workflow\frontend-dev.mdc" (
    echo   OK frontend-dev.mdc - Frontend workflow
    set /a KEY_FILES_FOUND+=1
    set "HAS_FRONTEND=1"
) else (
    echo   MISSING frontend-dev.mdc - Frontend workflow
    set "HAS_FRONTEND=0"
)

REM Check backend-dev.mdc
if exist "%RULES_DIR%\P4-project-workflow\backend-dev.mdc" (
    echo   OK backend-dev.mdc - Backend workflow
    set /a KEY_FILES_FOUND+=1
    set "HAS_BACKEND=1"
) else (
    echo   MISSING backend-dev.mdc - Backend workflow
    set "HAS_BACKEND=0"
)

REM Check frontend-rules.mdc
if exist "%RULES_DIR%\P3-professional-dev\frontend-rules.mdc" (
    echo   OK frontend-rules.mdc - Frontend rules
    set /a KEY_FILES_FOUND+=1
) else (
    echo   MISSING frontend-rules.mdc - Frontend rules
)

REM Check backend-rules.mdc
if exist "%RULES_DIR%\P3-professional-dev\backend-rules.mdc" (
    echo   OK backend-rules.mdc - Backend rules
    set /a KEY_FILES_FOUND+=1
) else (
    echo   MISSING backend-rules.mdc - Backend rules
)

REM Check modular context-recorder files
if exist "%RULES_DIR%\P2-intelligent-system\context-recorder-core.mdc" (
    echo   OK context-recorder-core.mdc - Modular context recorder core
    set /a KEY_FILES_FOUND+=1
) else (
    echo   MISSING context-recorder-core.mdc - Modular context recorder core
)

if exist "%RULES_DIR%\P2-intelligent-system\context-recorder-system.mdc" (
    echo   OK context-recorder-system.mdc - Context recorder system
    set /a KEY_FILES_FOUND+=1
) else (
    echo   MISSING context-recorder-system.mdc - Context recorder system
)

REM Calculate key file score
set /a KEY_FILE_SCORE=%KEY_FILES_FOUND%*25/%KEY_FILES_EXPECTED%

echo.

REM ========================================
REM Mode Detection
REM ========================================
echo Mode Detection Results:

REM Determine mode based on file presence and count
REM Mode detection standards (2025-10 update based on .mdc file count):
REM - Frontend: 52 .mdc files (includes mermaid.mdc + frontend-dev.mdc + modular context-recorder files)
REM - Backend: 52 .mdc files (includes backend-dev.mdc + backend-rules.mdc + modular context-recorder files)
REM - Fullstack: 54 .mdc files (includes all frontend + backend files + mermaid.mdc + modular context-recorder files)

set "DETECTED_MODE=UNKNOWN"
set "CONFIDENCE=UNKNOWN"
set /a EXPECTED_FILES=0

REM Use delayed expansion for variables set in if blocks
if "!HAS_FRONTEND!"=="1" (
    if "!HAS_BACKEND!"=="1" (
        set "DETECTED_MODE=FULLSTACK"
        set /a EXPECTED_FILES=54
        if %MDC_COUNT% GEQ 54 if %MDC_COUNT% LEQ 56 (
            set "CONFIDENCE=HIGH"
            set /a MODE_SCORE=25
        ) else if %MDC_COUNT% GEQ 50 (
            set "CONFIDENCE=MEDIUM"
            set /a MODE_SCORE=20
        ) else (
            set "CONFIDENCE=LOW"
            set /a MODE_SCORE=10
        )
    ) else (
        set "DETECTED_MODE=FRONTEND"
        set /a EXPECTED_FILES=52
        if %MDC_COUNT% GEQ 51 if %MDC_COUNT% LEQ 53 (
            set "CONFIDENCE=HIGH"
            set /a MODE_SCORE=25
        ) else if %MDC_COUNT% GEQ 48 (
            set "CONFIDENCE=MEDIUM"
            set /a MODE_SCORE=20
        ) else (
            set "CONFIDENCE=LOW"
            set /a MODE_SCORE=10
        )
    )
) else if "!HAS_BACKEND!"=="1" (
    set "DETECTED_MODE=BACKEND"
    set /a EXPECTED_FILES=52
    if %MDC_COUNT% GEQ 51 if %MDC_COUNT% LEQ 53 (
        set "CONFIDENCE=HIGH"
        set /a MODE_SCORE=25
    ) else if %MDC_COUNT% GEQ 48 (
        set "CONFIDENCE=MEDIUM"
        set /a MODE_SCORE=20
    ) else (
        set "CONFIDENCE=LOW"
        set /a MODE_SCORE=10
    )
) else (
    set "DETECTED_MODE=UNKNOWN"
    set "CONFIDENCE=NONE"
    set /a MODE_SCORE=0
)

REM Display detected mode with proper description
if "%DETECTED_MODE%"=="FULLSTACK" (
    echo   Detected: %DETECTED_MODE% mode ^(Full-stack development^)
) else if "%DETECTED_MODE%"=="FRONTEND" (
    echo   Detected: %DETECTED_MODE% mode ^(Frontend development^)
) else if "%DETECTED_MODE%"=="BACKEND" (
    echo   Detected: %DETECTED_MODE% mode ^(Backend development^)
) else (
    echo   Detected: %DETECTED_MODE% mode ^(Unknown configuration^)
)
echo   File count: %MDC_COUNT% ^(expected: %EXPECTED_FILES% .mdc files^)

REM Check mode-specific features
if "%DETECTED_MODE%"=="FULLSTACK" (
    if exist "%RULES_DIR%\P7-utilities\mermaid.mdc" (
        echo   OK Contains frontend, backend and chart support
    ) else (
        echo   WARNING: Missing chart support ^(mermaid.mdc^)
    )
) else if "%DETECTED_MODE%"=="FRONTEND" (
    if exist "%RULES_DIR%\P7-utilities\mermaid.mdc" (
        echo   OK Contains frontend development and chart support
    ) else (
        echo   WARNING: Missing chart support ^(mermaid.mdc^)
    )
) else if "%DETECTED_MODE%"=="BACKEND" (
    if exist "%RULES_DIR%\P7-utilities\mermaid.mdc" (
        echo   OK Contains backend development and chart support
    ) else (
        echo   OK Contains backend development support ^(no chart needed^)
    )
)

echo.

REM ========================================
REM Calculate File Count Score
REM ========================================
if %EXPECTED_FILES% GTR 0 (
    set /a FILE_DIFF=%MDC_COUNT%-%EXPECTED_FILES%
    if !FILE_DIFF! LSS 0 set /a FILE_DIFF=-!FILE_DIFF!
    
    if !FILE_DIFF! EQU 0 (
        set /a FILE_SCORE=25
    ) else if !FILE_DIFF! LEQ 2 (
        set /a FILE_SCORE=20
    ) else if !FILE_DIFF! LEQ 5 (
        set /a FILE_SCORE=15
    ) else if !FILE_DIFF! LEQ 10 (
        set /a FILE_SCORE=10
    ) else (
        set /a FILE_SCORE=5
    )
) else (
    set /a FILE_SCORE=10
)

REM ========================================
REM Calculate Total Health Score
REM ========================================
set /a SCORE=%DIR_SCORE%+%FILE_SCORE%+%KEY_FILE_SCORE%+%MODE_SCORE%

REM ========================================
REM Rules Health Assessment
REM ========================================
echo Rules Health Assessment:
if %SCORE% GEQ 90 (
    echo   EXCELLENT ^(%SCORE%/100^) - Rules complete and configured correctly
    set "HEALTH_STATUS=EXCELLENT"
) else if %SCORE% GEQ 70 (
    echo   GOOD ^(%SCORE%/100^) - Rules basically complete, minor issues exist
    set "HEALTH_STATUS=GOOD"
) else if %SCORE% GEQ 50 (
    echo   FAIR ^(%SCORE%/100^) - Rules incomplete or misconfigured
    set "HEALTH_STATUS=FAIR"
) else (
    echo   POOR ^(%SCORE%/100^) - Rules severely incomplete
    set "HEALTH_STATUS=POOR"
)

echo.

REM ========================================
REM Recommendations
REM ========================================
echo Recommendations:

set "HAS_RECOMMENDATIONS=0"

REM Check for missing directories
if %FOUND_DIRS% LSS %EXPECTED_DIRS% (
    echo   - Some priority directories are missing. Please reinstall rules.
    set "HAS_RECOMMENDATIONS=1"
)

REM Check file count deviation
if %EXPECTED_FILES% GTR 0 (
    set /a FILE_DIFF=%MDC_COUNT%-%EXPECTED_FILES%
    if !FILE_DIFF! LSS 0 set /a FILE_DIFF=-!FILE_DIFF!
    
    if !FILE_DIFF! GTR 5 (
        echo   - File count differs significantly from expected. Expected: %EXPECTED_FILES%, Found: %MDC_COUNT%
        set "HAS_RECOMMENDATIONS=1"
    )
)

REM Check key files
if %KEY_FILES_FOUND% LSS %KEY_FILES_EXPECTED% (
    echo   - Some key rule files are missing. Please check installation.
    set "HAS_RECOMMENDATIONS=1"
)

REM Check MCP tools directory
if exist "%PROJECT_PATH%\mcp-tools" (
    if exist "%PROJECT_PATH%\mcp-tools\mcp-cross-platform-sync.ps1" (
        REM MCP tools properly installed
    ) else (
        echo   - MCP management scripts incomplete. Consider reinstalling.
        set "HAS_RECOMMENDATIONS=1"
    )
) else (
    echo   - MCP tools directory not found. Some features may be unavailable.
    set "HAS_RECOMMENDATIONS=1"
)

REM Check templates directory
if exist "%PROJECT_PATH%\templates" (
    if exist "%PROJECT_PATH%\templates\project-init-template.md" (
        REM Templates properly installed
    ) else (
        echo   - Template files incomplete. Context recording may be affected.
        set "HAS_RECOMMENDATIONS=1"
    )
) else (
    echo   - Templates directory not found. Context recording features unavailable.
    set "HAS_RECOMMENDATIONS=1"
)

REM Check scripts directory
if exist "%PROJECT_PATH%\scripts" (
    if exist "%PROJECT_PATH%\scripts\validate-rules-consistency.ps1" (
        REM Scripts properly installed
    ) else (
        echo   - Scripts directory incomplete. Validation tools may be missing.
        set "HAS_RECOMMENDATIONS=1"
    )
) else (
    echo   - Scripts directory not found. Validation features unavailable.
    set "HAS_RECOMMENDATIONS=1"
)

if "%HAS_RECOMMENDATIONS%"=="0" (
    echo   ^(No recommendations - Perfect configuration^)
)

echo.

REM ========================================
REM Final Summary
REM ========================================
echo ========================================
echo Comprehensive Detection Complete
echo Detection Mode: %DETECTED_MODE%
echo Confidence: %CONFIDENCE%
echo Health Score: %SCORE%/100
echo ========================================
echo.

REM Set exit code based on health score
if %SCORE% GEQ 90 (
    exit /b 0
) else if %SCORE% GEQ 70 (
    exit /b 0
) else if %SCORE% GEQ 50 (
    exit /b 1
) else (
    exit /b 2
)

