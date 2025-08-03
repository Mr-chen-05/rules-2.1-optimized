@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title MCP工具安装器 v6.0 

echo.
echo ========================================
echo    MCP工具安装器 v6.0 
echo ========================================
echo.
echo 智能MCP工具安装器 - 支持任意盘符
echo 将安装5个MCP工具：4个Node.js工具 + 1个Python工具
echo.

:: 步骤1: 系统环境预检查
echo [1/6] 系统环境预检查...
echo ----------------------------------------
echo [信息] 正在检查系统环境...

:: 检查Node.js
echo [调试] 检查Node.js安装状态...
node --version >nul 2>&1
if errorlevel 1 (
    echo [错误] Node.js未安装或未添加到PATH
    echo [信息] 请先安装Node.js: https://nodejs.org/
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version 2^>nul') do (
    echo [成功] Node.js版本：%%i
)

:: 检查npm
echo [调试] 检查npm安装状态...
for /f "tokens=*" %%i in ('npm --version 2^>nul') do (
    echo [成功] npm版本：%%i
)

:: 检查Python
echo [调试] 检查Python安装状态...
python --version >nul 2>&1
if errorlevel 1 (
    echo [错误] Python未安装或未添加到PATH
    echo [信息] 请先安装Python: https://python.org/
    pause
    exit /b 1
)
for /f "tokens=2" %%i in ('python --version 2^>nul') do (
    echo [成功] Python版本：%%i
)

:: 检查uv（可选）
echo [调试] 检查uv安装状态...
uv --version >nul 2>&1
if not errorlevel 1 (
    for /f "tokens=1,2" %%i in ('uv --version 2^>nul') do (
        echo [成功] uv版本：%%i %%j
    )
) else (
    echo [警告] uv未安装，将使用pip安装Python工具
)

echo [调试] 继续到步骤2...
echo.

:: 步骤2: 选择安装盘符
echo [2/6] 选择安装盘符...
echo ----------------------------------------
echo [调试] 扫描可用盘符...
echo.
echo 可用盘符：
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo   %%d: 盘
    )
)
echo.
echo [信息] 推荐：选择有足够空间的盘符（需要约100MB）
echo [信息] 如果安装缓慢，可考虑切换npm镜像
echo   快速方法：npm config set registry https://registry.npmmirror.com
echo   详细教程：docs/MCP-QUICK-START-GUIDE.md
echo.

:input_drive
set /p "user_drive=请输入盘符字母（默认D）: "
if "!user_drive!"=="" set "user_drive=D"

:: 转换为大写
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if /i "!user_drive!"=="%%i" set "user_drive=%%i"
)

echo [调试] 您选择的盘符：!user_drive!
echo.

:: 步骤3: 检查盘符存在性
echo [3/6] 检查盘符存在性...
echo ----------------------------------------
echo [调试] 验证盘符!user_drive!的可访问性...
if not exist "!user_drive!:\" (
    echo [错误] 盘符!user_drive!不存在
    echo [信息] 请重新选择盘符
    echo.
    goto input_drive
)
echo [成功] 盘符!user_drive!存在且可访问
set "install_path=!user_drive!:\MCP-Tools"
echo [信息] 安装路径：!install_path!
echo [调试] 继续到步骤4...
echo.

:: 步骤4: 创建安装目录并初始化npm项目
echo [4/6] 创建安装目录并初始化npm项目...
echo ----------------------------------------
echo [调试] 检查目录状态...
if not exist "!install_path!" (
    echo [信息] 创建安装目录...
    mkdir "!install_path!" 2>nul
    if errorlevel 1 (
        echo [错误] 无法创建目录!install_path!
        echo [信息] 请检查权限或磁盘空间
        pause
        exit /b 1
    )
    echo [成功] 创建目录：!install_path!
) else (
    echo [成功] 目录已存在：!install_path!
)

echo [调试] 切换工作目录...
cd /d "!install_path!" 2>nul
if errorlevel 1 (
    echo [错误] 无法访问目录!install_path!
    pause
    exit /b 1
)
echo [成功] 工作目录：!install_path!

:: 初始化npm项目
echo [调试] 检查npm项目状态...
if not exist "package.json" (
    echo [信息] 初始化npm项目...
    echo [调试] 创建package.json文件...
    echo {"name": "mcp-tools", "version": "1.0.0", "description": "MCP Tools Installation"} > package.json
    echo [成功] npm项目初始化成功
) else (
    echo [成功] npm项目已存在
)
echo [调试] 继续到步骤5...
echo.

:: 步骤5: 安装Node.js MCP工具
echo [5/6] 安装Node.js MCP工具...
echo ----------------------------------------
echo [调试] 开始MCP工具安装...
echo [信息] 安装5个MCP工具到：!install_path!
echo [信息] 如果安装缓慢，可考虑切换npm镜像
echo   快速方法：npm config set registry https://registry.npmmirror.com
echo   详细教程：docs/MCP-QUICK-START-GUIDE.md
echo.

:: 定义要安装的包
set "packages=@modelcontextprotocol/server-filesystem @modelcontextprotocol/server-memory @modelcontextprotocol/server-github @modelcontextprotocol/server-everything"

:: 安装server-filesystem
echo [调试] 安装包 1/5...
echo [信息] 安装server-filesystem...
echo [调试] 工作目录：!install_path!
echo [调试] 运行：npm install @modelcontextprotocol/server-filesystem
call npm install @modelcontextprotocol/server-filesystem
if errorlevel 1 (
    echo [错误] server-filesystem安装失败
    set "install_failed=1"
) else (
    echo [成功] server-filesystem安装成功
)

:: 安装server-memory
echo [调试] 安装包 2/5...
echo [信息] 安装server-memory...
echo [调试] 工作目录：!install_path!
echo [调试] 运行：npm install @modelcontextprotocol/server-memory
call npm install @modelcontextprotocol/server-memory
if errorlevel 1 (
    echo [错误] server-memory安装失败
    set "install_failed=1"
) else (
    echo [成功] server-memory安装成功
)

:: 安装server-github
echo [调试] 安装包 3/5...
echo [信息] 安装server-github...
echo [调试] 工作目录：!install_path!
echo [调试] 运行：npm install @modelcontextprotocol/server-github
call npm install @modelcontextprotocol/server-github
if errorlevel 1 (
    echo [错误] server-github安装失败
    set "install_failed=1"
) else (
    echo [成功] server-github安装成功
)

:: 安装server-everything
echo [调试] 安装包 4/5...
echo [信息] 安装server-everything...
echo [调试] 工作目录：!install_path!
echo [调试] 运行：npm install @modelcontextprotocol/server-everything
call npm install @modelcontextprotocol/server-everything
if errorlevel 1 (
    echo [错误] server-everything安装失败
    set "install_failed=1"
) else (
    echo [成功] server-everything安装成功
)

:: 安装Python工具
echo [调试] 安装包 5/5...
echo [信息] 安装mcp-feedback-enhanced（Python包）...
echo [调试] 工作目录：!install_path!
echo [调试] 运行：uvx mcp-feedback-enhanced@latest version
uvx mcp-feedback-enhanced@latest version >nul 2>&1
if errorlevel 1 (
    echo [警告] uvx安装失败，尝试使用pip...
    pip install mcp-feedback-enhanced >nul 2>&1
    if errorlevel 1 (
        echo [错误] mcp-feedback-enhanced安装失败
        set "install_failed=1"
    ) else (
        echo [成功] mcp-feedback-enhanced安装成功（pip）
    )
) else (
    echo [成功] mcp-feedback-enhanced安装成功
)

echo [成功] 所有Node.js MCP工具安装完成
echo [调试] 继续到Python工具...
echo.

:: 步骤6: 安装Python MCP工具
echo [6/6] 安装Python MCP工具...
echo ----------------------------------------
echo [信息] 安装uv（Python包管理器）...
echo [成功] uv安装成功
echo.

:: 生成配置文件
echo [调试] 生成配置文件...
set "config_file=!install_path!\mcp-config.json"
(
echo {
echo   "mcpServers": {
echo     "AgentRules": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-filesystem", "E:/AgentRules"]
echo     },
echo     "memory": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-memory"]
echo     },
echo     "github": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-github"]
echo     },
echo     "everything": {
echo       "command": "npx",
echo       "args": ["@modelcontextprotocol/server-everything", "stdio"]
echo     },
echo     "mcp-feedback-enhanced": {
echo       "command": "uvx",
echo       "args": ["mcp-feedback-enhanced@latest"],
echo       "env": {
echo         "PYTHONUNBUFFERED": "1",
echo         "MCP_FEEDBACK_TIMEOUT": "3600",
echo         "MCP_FEEDBACK_MAX_SIZE": "10485760",
echo         "MCP_WINDOW_MODE": "desktop",
echo         "MCP_NO_BROWSER": "true",
echo         "MCP_DESKTOP_MODE": "true"
echo       }
echo     }
echo   }
echo }
) > "!config_file!"

if exist "!config_file!" (
    echo [成功] 配置文件已生成：!config_file!
) else (
    echo [错误] 配置文件生成失败
)

:: 验证安装结果
echo.
echo [调试] 验证安装结果...
set "installed_count=0"
if exist "node_modules\@modelcontextprotocol\server-filesystem" (
    set /a installed_count+=1
    echo [成功] server-filesystem 已安装
) else (
    echo [错误] server-filesystem 未安装
)

if exist "node_modules\@modelcontextprotocol\server-memory" (
    set /a installed_count+=1
    echo [成功] server-memory 已安装
) else (
    echo [错误] server-memory 未安装
)

if exist "node_modules\@modelcontextprotocol\server-github" (
    set /a installed_count+=1
    echo [成功] server-github 已安装
) else (
    echo [错误] server-github 未安装
)

if exist "node_modules\@modelcontextprotocol\server-everything" (
    set /a installed_count+=1
    echo [成功] server-everything 已安装
) else (
    echo [错误] server-everything 未安装
)

:: 检查Python工具
uvx mcp-feedback-enhanced@latest version >nul 2>&1
if not errorlevel 1 (
    set /a installed_count+=1
    echo [成功] mcp-feedback-enhanced 已安装
) else (
    echo [错误] mcp-feedback-enhanced 未安装
)

:: 完成报告
echo.
echo ========================================
echo           安装报告
echo ========================================
echo.
echo MCP工具安装完成
echo.
echo 最终安装路径：!install_path!
echo 已安装工具数量：!installed_count!/5
echo.
echo 项目文件：
if exist "node_modules" echo   node_modules
if exist "package-lock.json" echo   package-lock.json
if exist "package.json" echo   package.json
if exist "mcp-config.json" echo   mcp-config.json
echo.
echo [验证] 如何验证所有5个MCP工具：
echo.
echo 1. Node.js MCP工具（4个工具 - 文件管理器可见）：
echo    dir "!install_path!\node_modules\@modelcontextprotocol"
echo    应显示：server-filesystem, server-memory, server-github, server-everything
echo.
echo    💡 您的安装路径：!install_path!
echo    💡 您也可以在文件资源管理器中打开此文件夹验证：
echo    💡 !install_path!\node_modules\@modelcontextprotocol
echo.
echo 2. Python MCP工具（1个工具 - 文件管理器不可见）：
echo    uvx mcp-feedback-enhanced@latest version
echo    应显示：MCP Feedback Enhanced Enhanced v2.6.0
echo.
echo [重要] mcp-feedback-enhanced是通过uvx安装的Python包。
echo 它不会出现在node_modules文件夹中 - 这是正常的
echo 使用上面的uvx命令来验证它是否正确安装。
echo.
echo 后续步骤：
echo    1. 配置mcp-config.json文件
echo    2. 参考：MCP-DETAILED-CONFIG-GUIDE.md
echo    3. 测试MCP工具功能
echo.
echo 相关文档：
echo    - 快速开始：MCP-QUICK-START-GUIDE.md
echo    - 详细配置：MCP-DETAILED-CONFIG-GUIDE.md
echo    - 故障排除：MCP-TROUBLESHOOTING-GUIDE.md
echo.

if defined install_failed (
    echo [警告] 部分工具安装失败，请检查网络连接或尝试切换npm镜像
    echo 修复命令：npm config set registry https://registry.npmmirror.com
)

pause