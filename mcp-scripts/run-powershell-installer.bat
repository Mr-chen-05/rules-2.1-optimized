@echo off
:: PowerShell 脚本执行器 - 自动处理执行策略
:: 编码: UTF-8
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo    MCP Tools PowerShell 安装器启动器
echo ========================================
echo.
echo 正在启动 PowerShell 安装脚本...
echo 此脚本将自动处理执行策略问题
echo.

:: 获取当前脚本所在目录
set "SCRIPT_DIR=%~dp0"
set "PS_SCRIPT=%SCRIPT_DIR%install-mcp-tools-enhanced-final.ps1"

:: 检查 PowerShell 脚本是否存在
if not exist "%PS_SCRIPT%" (
    echo [错误] 找不到 PowerShell 脚本文件:
    echo %PS_SCRIPT%
    echo.
    pause
    exit /b 1
)

echo [信息] PowerShell 脚本路径: %PS_SCRIPT%
echo [信息] 正在以 Bypass 执行策略运行...
echo.

:: 使用 PowerShell 执行脚本，绕过执行策略
powershell.exe -ExecutionPolicy Bypass -File "%PS_SCRIPT%"

:: 检查执行结果
if errorlevel 1 (
    echo.
    echo [错误] PowerShell 脚本执行失败
    echo 错误代码: %ERRORLEVEL%
    echo.
    echo 故障排除建议:
    echo 1. 确保以管理员权限运行
    echo 2. 检查网络连接
    echo 3. 参考 docs/MCP-TROUBLESHOOTING-GUIDE.md
    echo.
) else (
    echo.
    echo [成功] PowerShell 脚本执行完成
    echo.
)

pause