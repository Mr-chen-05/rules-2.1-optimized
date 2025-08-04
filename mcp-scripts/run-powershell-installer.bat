@echo off
:: PowerShell 脚本执行器 - 强制在PowerShell中运行
:: 编码: UTF-8
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo    MCP Tools PowerShell 安装器启动器
echo ========================================
echo.
echo [检查] 正在检查PowerShell环境...
echo.

:: 第一步：检查PowerShell是否可用
echo [1/3] 检查PowerShell可用性...
powershell.exe -Command "Write-Host 'PowerShell检查完成'" >nul 2>&1
if errorlevel 1 (
    echo [错误] PowerShell未安装或不可用！
    echo.
    echo 解决方案：
    echo 1. Windows 10/11用户：PowerShell应该已预装
    echo 2. 如果PowerShell不可用，请安装PowerShell：
    echo    - 下载地址：https://github.com/PowerShell/PowerShell/releases
    echo    - 或者使用Windows PowerShell（预装版本）
    echo 3. 确保PowerShell在系统PATH中
    echo.
    echo 请安装PowerShell后重新运行此脚本。
    echo.
    pause
    exit /b 1
) else (
    echo [成功] PowerShell可用
)

:: 第二步：检查PowerShell版本
echo [2/3] 检查PowerShell版本...
for /f "tokens=*" %%i in ('powershell.exe -Command "$PSVersionTable.PSVersion.Major" 2^>nul') do set PS_VERSION=%%i
if "%PS_VERSION%"=="" (
    echo [警告] 无法获取PowerShell版本，但将继续执行
    set PS_VERSION=未知
) else (
    echo [信息] PowerShell版本: %PS_VERSION%
    if %PS_VERSION% LSS 3 (
        echo [警告] PowerShell版本较低，建议升级到5.0或更高版本
        echo 下载地址：https://github.com/PowerShell/PowerShell/releases
        echo.
    )
)

:: 第三步：检查PowerShell脚本文件
echo [3/3] 检查PowerShell脚本文件...
set "SCRIPT_DIR=%~dp0"
set "PS_SCRIPT=%SCRIPT_DIR%install-mcp-tools-enhanced-final.ps1"

if not exist "%PS_SCRIPT%" (
    echo [错误] 找不到PowerShell脚本文件:
    echo %PS_SCRIPT%
    echo.
    echo 请确保以下文件存在：
    echo - install-mcp-tools-enhanced-final.ps1
    echo.
    pause
    exit /b 1
) else (
    echo [成功] PowerShell脚本文件存在
)

echo.
echo [信息] 环境检查完成，准备启动PowerShell安装脚本...
echo [信息] PowerShell脚本路径: %PS_SCRIPT%
echo [信息] 将在新的PowerShell窗口中运行以避免编码问题
echo.

:: 强制在新的PowerShell窗口中运行，避免CMD乱码问题
echo [启动] 正在新PowerShell窗口中启动安装脚本...
echo [提示] 如果没有弹出PowerShell窗口，请检查是否被安全软件拦截
echo.

:: 使用start命令在新的PowerShell窗口中运行，确保UTF-8编码
start "MCP Tools Installer" powershell.exe -NoExit -ExecutionPolicy Bypass -Command "& { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; $OutputEncoding = [System.Text.Encoding]::UTF8; & '%PS_SCRIPT%' }"

:: 检查start命令是否成功
if errorlevel 1 (
    echo [错误] 无法启动PowerShell窗口
    echo.
    echo 备用方案：尝试在当前窗口运行...
    echo [警告] 可能会出现中文显示问题
    echo.
    powershell.exe -ExecutionPolicy Bypass -Command "& { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; $OutputEncoding = [System.Text.Encoding]::UTF8; & '%PS_SCRIPT%' }"
    
    if errorlevel 1 (
        echo.
        echo [错误] PowerShell脚本执行失败
        echo 错误代码: %ERRORLEVEL%
        echo.
        echo 故障排除建议:
        echo 1. 确保以管理员权限运行
        echo 2. 检查PowerShell执行策略
        echo 3. 检查网络连接
        echo 4. 参考 docs/MCP-TROUBLESHOOTING-GUIDE.md
        echo.
        echo 手动执行方法:
        echo 1. 打开PowerShell（以管理员身份）
        echo 2. 执行: Set-ExecutionPolicy Bypass -Scope Process
        echo 3. 执行: ^& '%PS_SCRIPT%'
        echo.
    )
) else (
    echo [成功] PowerShell窗口已启动
    echo [提示] 请在新打开的PowerShell窗口中查看安装进度
    echo [提示] 安装完成后PowerShell窗口会保持打开状态
)

echo.
echo 按任意键关闭此窗口...
pause >nul
