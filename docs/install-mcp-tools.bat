@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title MCP Tools Auto Installer v1.0
color 0A

echo.
echo ========================================
echo    MCP Tools Auto Installer v1.0
echo ========================================
echo.
echo 🚀 开始自动安装MCP工具...
echo.

echo [1/5] 检查环境...
echo ----------------------------------------
where node >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js 未安装！请先安装 Node.js
    echo 下载地址：https://nodejs.org
    pause
    exit /b 1
)

where python >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Python 未安装，将跳过 Python MCP 工具
    set "skip_python=1"
) else (
    set "skip_python=0"
)

for /f "tokens=*" %%i in ('node --version 2^>nul') do echo Node.js 版本: %%i
if not "%skip_python%"=="1" (
    for /f "tokens=*" %%i in ('python --version 2^>nul') do echo Python 版本: %%i
)
echo.

echo [2/5] 选择安装路径...
echo ----------------------------------------
echo 请选择MCP工具安装位置：
echo.
echo 1. C:\MCP-Tools (推荐，默认路径)
echo 2. D:\MCP-Tools
echo 3. 自定义路径
echo.
set /p choice="请输入选择 (1-3，直接回车选择默认): "

if "%choice%"=="" set choice=1
if "%choice%"=="1" set "install_path=C:\MCP-Tools"
if "%choice%"=="2" set "install_path=D:\MCP-Tools"
if "%choice%"=="3" (
    set /p install_path="请输入自定义路径 (例如: E:\MyTools\MCP): "
    if "!install_path!"=="" (
        echo [ERROR] 路径不能为空，使用默认路径
        set "install_path=C:\MCP-Tools"
    )
)

echo.
echo 📍 选择的安装路径：%install_path%
echo.

if not exist "%install_path%" (
    mkdir "%install_path%"
    echo ✅ 创建目录：%install_path%
) else (
    echo ℹ️  目录已存在：%install_path%
)

cd /d "%install_path%"
echo 📍 当前目录：%CD%
echo.

echo [3/5] 初始化npm项目...
echo ----------------------------------------
if not exist "package.json" (
    echo 正在初始化npm项目...
    npm init -y
    echo ✅ npm项目初始化完成
) else (
    echo ℹ️  package.json 已存在，跳过初始化
)
echo.

echo [4/5] 安装Node.js MCP工具...
echo ----------------------------------------
echo 正在安装 @modelcontextprotocol/server-filesystem...
npm install @modelcontextprotocol/server-filesystem
if errorlevel 1 (
    echo [ERROR] server-filesystem 安装失败
) else (
    echo ✅ server-filesystem 安装成功
)

echo 正在安装 @modelcontextprotocol/server-memory...
npm install @modelcontextprotocol/server-memory
if errorlevel 1 (
    echo [ERROR] server-memory 安装失败
) else (
    echo ✅ server-memory 安装成功
)

echo 正在安装 @modelcontextprotocol/server-github...
npm install @modelcontextprotocol/server-github
if errorlevel 1 (
    echo [ERROR] server-github 安装失败
) else (
    echo ✅ server-github 安装成功
)

echo 正在安装 @modelcontextprotocol/server-everything...
npm install @modelcontextprotocol/server-everything
if errorlevel 1 (
    echo [ERROR] server-everything 安装失败
) else (
    echo ✅ server-everything 安装成功
)
echo.

echo [5/5] 安装Python MCP工具...
echo ----------------------------------------
if "%skip_python%"=="1" (
    echo ⚠️  跳过Python工具安装（Python未安装）
) else (
    echo 正在安装 uv...
    pip install uv
    if errorlevel 1 (
        echo [ERROR] uv 安装失败
    ) else (
        echo ✅ uv 安装成功
    )
)
echo.

echo ========================================
echo           安装完成报告
echo ========================================
echo.
echo ✅ MCP工具安装完成！
echo.
echo 📍 最终安装位置：%install_path%
echo 📁 项目文件：
dir /b "%install_path%" 2>nul
echo.
echo 🔧 下一步操作：
echo    1. 配置 mcp-config.json 文件
echo    2. 参考文档：MCP-DETAILED-CONFIG-GUIDE.md
echo    3. 测试MCP工具是否正常工作
echo.
echo 📚 相关文档：
echo    - MCP快速入门：MCP-QUICK-START-GUIDE.md
echo    - 详细配置：MCP-DETAILED-CONFIG-GUIDE.md
echo    - 故障排除：MCP-TROUBLESHOOTING-GUIDE.md
echo.
pause
