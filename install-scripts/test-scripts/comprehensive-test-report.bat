@echo off
chcp 65001 >nul
setlocal

echo ========================================
echo Comprehensive Test Report
echo ========================================

rem 项目根目录和测试根目录
set "BASE_DIR=%~dp0\..\.."
set "TEST_ROOT=%TEMP%\rules-comprehensive-test"

rem 清理并创建测试根目录
if exist "%TEST_ROOT%" rd /s /q "%TEST_ROOT%"
mkdir "%TEST_ROOT%"

echo 测试根目录: %TEST_ROOT%
echo.

rem 测试 install-ultra.bat
echo [Testing] install-ultra.bat ...
call "%BASE_DIR%\install-scripts\install-ultra.bat" "%TEST_ROOT%\install-ultra" fullstack > "%TEST_ROOT%\install-ultra.log" 2>&1
if errorlevel 1 (
    echo [ERROR] install-ultra.bat 执行失败 (查看 %TEST_ROOT%\install-ultra.log)
) else (
    echo [OK] install-ultra.bat 执行成功
)
echo.

rem 测试 install-ultra-fixed.bat
if exist "%BASE_DIR%\install-scripts\install-ultra-fixed.bat" (
    echo [Testing] install-ultra-fixed.bat ...
    call "%BASE_DIR%\install-scripts\install-ultra-fixed.bat" "%TEST_ROOT%\install-ultra-fixed" fullstack > "%TEST_ROOT%\install-ultra-fixed.log" 2>&1
    if errorlevel 1 (
        echo [ERROR] install-ultra-fixed.bat 执行失败 (查看 %TEST_ROOT%\install-ultra-fixed.log)
    ) else (
        echo [OK] install-ultra-fixed.bat 执行成功
    )
    echo.
)

rem 测试 test-backend-consistency.bat
if exist "%BASE_DIR%\install-scripts\test-backend-consistency.bat" (
    echo [Testing] test-backend-consistency.bat ...
    call "%BASE_DIR%\install-scripts\test-backend-consistency.bat" "%TEST_ROOT%\test-backend-consistency" > "%TEST_ROOT%\test-backend-consistency.log" 2>&1
    if errorlevel 1 (
        echo [ERROR] test-backend-consistency.bat 执行失败 (查看 %TEST_ROOT%\test-backend-consistency.log)
    ) else (
        echo [OK] test-backend-consistency.bat 执行成功
    )
    echo.
)

rem 测试 verify-rules-completeness.bat
if exist "%BASE_DIR%\install-scripts\test-scripts\verify-rules-completeness.bat" (
    echo [Testing] verify-rules-completeness.bat ...
    call "%BASE_DIR%\install-scripts\test-scripts\verify-rules-completeness.bat" "%TEST_ROOT%\verify-rules-completeness" > "%TEST_ROOT%\verify-rules-completeness.log" 2>&1
    if errorlevel 1 (
        echo [ERROR] verify-rules-completeness.bat 执行失败 (查看 %TEST_ROOT%\verify-rules-completeness.log)
    ) else (
        echo [OK] verify-rules-completeness.bat 执行成功
    )
    echo.
)

rem 测试 test-ultra.bat
echo [Testing] test-ultra.bat ...
call "%BASE_DIR%\install-scripts\test-scripts\test-ultra.bat" "%TEST_ROOT%" > "%TEST_ROOT%\test-ultra.log" 2>&1
if errorlevel 1 (
    echo [ERROR] test-ultra.bat 执行失败 (查看 %TEST_ROOT%\test-ultra.log)
) else (
    echo [OK] test-ultra.bat 执行成功
)
echo.

echo ========================================
echo Comprehensive tests completed.
echo 详细日志保存在：%TEST_ROOT%
echo ========================================
pause