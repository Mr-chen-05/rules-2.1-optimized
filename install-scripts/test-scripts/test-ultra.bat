@echo off
chcp 65001 >nul
setlocal

echo ========================================
echo  Ultra Rules Testing Tool
echo  Based on install-ultra.bat
echo ========================================

if "%~1"=="" (
    echo Usage: test-ultra.bat [test-project-path]
    echo.
    echo This tool will:
    echo   1. Test all 3 modes (frontend/backend/fullstack)
    echo   2. Verify file counts and structure
    echo   3. Generate comparison report
    echo.
    goto :eof
)

set "TEST_PROJECT=%~1"
set "SCRIPT_DIR=%~dp0.."

echo Creating test project directory: %TEST_PROJECT%
if not exist "%TEST_PROJECT%" mkdir "%TEST_PROJECT%" 2>nul

echo.
echo Testing Ultra Rules Generator...
echo.

REM Test all three modes
echo [1/3] Testing Frontend mode...
call "%SCRIPT_DIR%\install-ultra.bat" "%TEST_PROJECT%\test-frontend" frontend

echo [2/3] Testing Backend mode...
call "%SCRIPT_DIR%\install-ultra.bat" "%TEST_PROJECT%\test-backend" backend

echo [3/3] Testing Fullstack mode...
call "%SCRIPT_DIR%\install-ultra.bat" "%TEST_PROJECT%\test-fullstack" fullstack

echo.
echo ========================================
echo  Test Results Summary
echo ========================================

REM Count files in each mode
set /a FRONTEND_FILES=0
set /a BACKEND_FILES=0
set /a FULLSTACK_FILES=0

if exist "%TEST_PROJECT%\test-frontend" (
    for /r "%TEST_PROJECT%\test-frontend" %%f in (*.md *.mdc) do set /a FRONTEND_FILES+=1
)

if exist "%TEST_PROJECT%\test-backend" (
    for /r "%TEST_PROJECT%\test-backend" %%f in (*.md *.mdc) do set /a BACKEND_FILES+=1
)

if exist "%TEST_PROJECT%\test-fullstack" (
    for /r "%TEST_PROJECT%\test-fullstack" %%f in (*.md *.mdc) do set /a FULLSTACK_FILES+=1
)

echo Frontend mode: %FRONTEND_FILES% files
echo Backend mode: %BACKEND_FILES% files  
echo Fullstack mode: %FULLSTACK_FILES% files

echo.
echo Expected results:
echo - Frontend: ~25 files (no backend-specific files)
echo - Backend: ~24 files (no frontend-specific files)
echo - Fullstack: ~27 files (all files included)

echo.
echo ========================================
echo Verification:
if %FRONTEND_FILES% GEQ 24 if %FRONTEND_FILES% LEQ 26 (echo ✓ Frontend file count OK) else (echo ✗ Frontend file count unexpected)
if %BACKEND_FILES% GEQ 23 if %BACKEND_FILES% LEQ 25 (echo ✓ Backend file count OK) else (echo ✗ Backend file count unexpected)
if %FULLSTACK_FILES% GEQ 26 if %FULLSTACK_FILES% LEQ 28 (echo ✓ Fullstack file count OK) else (echo ✗ Fullstack file count unexpected)

echo.
echo Test directories created in: %TEST_PROJECT%
echo - test-frontend/
echo - test-backend/
echo - test-fullstack/
echo.
echo Manual verification recommended:
echo 1. Check that frontend mode excludes backend files
echo 2. Check that backend mode excludes frontend files  
echo 3. Check that fullstack mode includes all files
echo ========================================

pause