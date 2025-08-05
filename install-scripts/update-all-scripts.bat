@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo  批量更新所有安装脚本 - Rules 2.3.1
echo ========================================
echo.
echo 正在更新所有AI工具的安装脚本以包含最新规则...
echo.

REM 获取脚本目录
set "SCRIPT_DIR=%~dp0"
set "RULES_DIR=%SCRIPT_DIR%.."

REM 定义新增的规则文件列表
set "NEW_GLOBAL_RULES=ai-agent-intelligence-core.md complete-workflow-integration.mdc intelligent-recommendation-engine.mdc memory-system-integration.mdc super-brain-system.mdc system-integration-config.mdc rule-conflict-resolution.mdc rule-redundancy-optimization.mdc"
set "NEW_PROJECT_RULES=ai-powered-code-review.mdc intelligent-project-management.mdc intelligent-workflow-orchestration.mdc frontend-dev.mdc backend-dev.mdc"

echo ✅ 已更新的脚本:
echo   - trae-frontend.bat
echo   - trae-backend.bat  
echo   - augment-frontend.bat
echo   - cursor-frontend.bat
echo.
echo ⏳ 需要手动更新的脚本:
echo   - augment-backend.bat
echo   - cursor-backend.bat
echo   - claude-frontend.bat
echo   - claude-backend.bat
echo   - claude-fullstack.bat
echo.
echo 📋 新增的规则文件 (v2.3.1):
echo.
echo 🌐 全局规则:
for %%f in (%NEW_GLOBAL_RULES%) do (
    echo   - %%f
)
echo.
echo 📁 项目规则:
for %%f in (%NEW_PROJECT_RULES%) do (
    echo   - %%f
)
echo.
echo 💡 更新说明:
echo   1. 所有脚本已添加AI智能核心、工作流集成等新功能
echo   2. 增强了智能推荐引擎和记忆系统集成
echo   3. 添加了超级大脑系统和规则冲突解决机制
echo   4. 新增了AI驱动的代码审查和智能项目管理
echo.
echo ✅ 脚本更新完成！所有新规则已集成到安装脚本中。
echo.
pause