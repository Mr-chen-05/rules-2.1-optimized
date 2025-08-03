@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo      MCP Tools Installation Finder
echo ========================================
echo.
echo 正在搜索MCP工具安装位置...
echo.

set "found_path="
set "found_count=0"

echo [INFO] 检查常见安装路径...
echo.

:: 检查所有可能的盘符
for %%d in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\MCP-Tools\node_modules\@modelcontextprotocol" (
        echo ✅ 找到安装路径: %%d:\MCP-Tools
        set "found_path=%%d:\MCP-Tools"
        set /a found_count+=1
        call :show_tools "%%d:\MCP-Tools"
    )
)

:: 检查npm全局安装路径
for /f "tokens=*" %%i in ('npm root -g 2^>nul') do (
    if exist "%%i\@modelcontextprotocol" (
        echo ✅ 找到全局安装路径: %%i
        set "found_path=%%i"
        set /a found_count+=1
        call :show_tools_global "%%i"
    )
)

echo.
echo ========================================
echo           搜索结果总结
echo ========================================
echo.

if !found_count! equ 0 (
    echo ❌ 未找到MCP工具安装！
    echo.
    echo 🔧 解决方案:
    echo   1. 运行安装脚本: mcp-scripts\install-mcp-tools-enhanced.bat
    echo   2. 检查是否安装在其他自定义路径
    echo   3. 手动搜索包含 @modelcontextprotocol 的文件夹
    echo.
    echo 💡 手动搜索命令:
    echo   dir /s /b C:\ ^| findstr "modelcontextprotocol" 2^>nul
) else if !found_count! equ 1 (
    echo ✅ 找到1个MCP工具安装位置
    echo.
    echo 📋 验证命令:
    if defined found_path (
        if "!found_path:~-1!"=="\" (
            echo   dir "!found_path!node_modules\@modelcontextprotocol"
        ) else (
            echo   dir "!found_path!\node_modules\@modelcontextprotocol"
        )
    )
    echo.
    echo 🐍 Python MCP工具验证:
    echo   uvx mcp-feedback-enhanced@latest version
) else (
    echo ⚠️  找到多个MCP工具安装位置 (!found_count!个)
    echo.
    echo 💡 建议: 使用最新的安装位置，或清理旧的安装
)

echo.
echo 🐍 检查Python MCP工具...
echo ----------------------------------------
uvx mcp-feedback-enhanced@latest version >nul 2>&1
if errorlevel 1 (
    echo ❌ mcp-feedback-enhanced 未安装
    echo 💡 安装命令: uvx mcp-feedback-enhanced@latest
) else (
    echo ✅ mcp-feedback-enhanced 已安装
    echo 📋 版本信息:
    uvx mcp-feedback-enhanced@latest version 2>nul | findstr "v"
)

echo.
echo ========================================
echo.
echo 💡 重要提醒:
echo   - Node.js MCP工具: 在 盘符:\MCP-Tools\node_modules\@modelcontextprotocol 文件夹中
echo   - Python MCP工具: 通过 uvx 命令验证，不在文件夹中
echo   - 总共5个工具: 4个Node.js + 1个Python
echo.
echo Press any key to exit...
pause >nul
goto :eof

:show_tools
set "path=%~1"
echo   📦 Node.js MCP工具:
for /d %%d in ("%path%\node_modules\@modelcontextprotocol\*") do (
    echo     - %%~nd
)
echo.
goto :eof

:show_tools_global
set "path=%~1"
echo   📦 全局安装的MCP工具:
for /d %%d in ("%path%\@modelcontextprotocol\*") do (
    echo     - %%~nd
)
echo.
goto :eof
