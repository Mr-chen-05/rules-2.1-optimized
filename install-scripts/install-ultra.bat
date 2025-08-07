@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ========================================
echo AgentRules Ultimate Rules Creator (最终版本)
echo Priority-Based Rules Directory Generation
echo ========================================
echo.

set "BASE_DIR=%~dp0.."
set "GLOBAL_RULES_DIR=%BASE_DIR%\global-rules"
set "PROJECT_RULES_DIR=%BASE_DIR%\project-rules"

REM 获取原始参数并清理Unicode字符
set "RAW_TARGET=%~1"
set "RULE_TYPE=%~2"

REM 清理路径中的不可见Unicode字符 (U+202A等)
set "TARGET_DIR=%RAW_TARGET%"
set "TARGET_DIR=%TARGET_DIR:‪=%"
set "TARGET_DIR=%TARGET_DIR:‫=%"
set "TARGET_DIR=%TARGET_DIR:‬=%"
set "TARGET_DIR=%TARGET_DIR:‭=%"
set "TARGET_DIR=%TARGET_DIR:‮=%"

if "%TARGET_DIR%"=="" set "TARGET_DIR=demo-project"
if "%RULE_TYPE%"=="" set "RULE_TYPE=fullstack"

echo Creating %RULE_TYPE% rules directory: %TARGET_DIR%
echo Including rules with priority levels for %RULE_TYPE% development...
echo DEBUG: Rule type is: [%RULE_TYPE%]
echo DEBUG: Original path: [%RAW_TARGET%]
echo DEBUG: Cleaned path: [%TARGET_DIR%]
echo.

REM 创建目标目录的父目录路径进行验证
for %%i in ("%TARGET_DIR%") do set "PARENT_DIR=%%~dpi"
set "PARENT_DIR=%PARENT_DIR:~0,-1%"

echo DEBUG: Parent directory: [%PARENT_DIR%]

REM 验证父目录是否存在
if not exist "%PARENT_DIR%" (
    echo ERROR: Parent directory does not exist: %PARENT_DIR%
    echo Please ensure the target directory path is correct.
    echo.
    echo Usage: install-ultra.bat [target-directory] [rule-type]
    echo Example: install-ultra.bat C:\Users\username\Desktop\demo-project fullstack
    echo.
    pause
    exit /b 1
)

REM 创建项目目录
echo Creating target directory: %TARGET_DIR%
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%" 2>nul
    if errorlevel 1 (
        echo ERROR: Failed to create directory: %TARGET_DIR%
        echo Please check the path and permissions.
        pause
        exit /b 1
    )
)

REM 创建rules子目录
set "RULES_DIR=%TARGET_DIR%\rules"
echo Creating rules directory: %RULES_DIR%
if not exist "%RULES_DIR%" (
    mkdir "%RULES_DIR%" 2>nul
    if errorlevel 1 (
        echo ERROR: Failed to create rules directory: %RULES_DIR%
        echo Please check the path and permissions.
        pause
        exit /b 1
    )
)

REM 创建主规则文件
set "MAIN_RULES=%RULES_DIR%\main.md"

echo # AgentRules %RULE_TYPE% Rules > "%MAIN_RULES%"
if errorlevel 1 (
    echo ERROR: Failed to create main.md file
    echo Please check write permissions for: %RULES_DIR%
    pause
    exit /b 1
)

echo ## Priority-Based Rule System - AI Can Understand Rule Levels >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo This directory contains rules for %RULE_TYPE% development, >> "%MAIN_RULES%"
echo organized by priority levels that AI can understand and follow. >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo ## Rules Directory Structure >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P0 Level - Core Safety Rules (所有类型都需要)
echo Creating P0 Level - Core Safety Rules...
mkdir "%RULES_DIR%\P0-core-safety" 2>nul
if exist "%GLOBAL_RULES_DIR%\file-generation-safety-rules.md" (
    copy "%GLOBAL_RULES_DIR%\file-generation-safety-rules.md" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy file-generation-safety-rules.md
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\file-generation-safety-rules.md
)
if exist "%GLOBAL_RULES_DIR%\rule-conflict-resolution.mdc" (
    copy "%GLOBAL_RULES_DIR%\rule-conflict-resolution.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy rule-conflict-resolution.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\rule-conflict-resolution.mdc
)
echo - P0-core-safety/ (Priority: 1000) >> "%MAIN_RULES%"
echo   - file-generation-safety-rules.md >> "%MAIN_RULES%"
echo   - rule-conflict-resolution.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P1 Level - Core Identity Rules (所有类型都需要)
echo Creating P1 Level - Core Identity Rules...
mkdir "%RULES_DIR%\P1-core-identity" 2>nul
if exist "%GLOBAL_RULES_DIR%\unified-rules-base.md" (
    copy "%GLOBAL_RULES_DIR%\unified-rules-base.md" "%RULES_DIR%\P1-core-identity\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy unified-rules-base.md
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\unified-rules-base.md
)
if exist "%GLOBAL_RULES_DIR%\ai-agent-intelligence-core.md" (
    copy "%GLOBAL_RULES_DIR%\ai-agent-intelligence-core.md" "%RULES_DIR%\P1-core-identity\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy ai-agent-intelligence-core.md
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\ai-agent-intelligence-core.md
)
echo - P1-core-identity/ (Priority: 900) >> "%MAIN_RULES%"
echo   - unified-rules-base.md >> "%MAIN_RULES%"
echo   - ai-agent-intelligence-core.md >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P2 Level - Intelligent System Rules (所有类型都需要)
echo Creating P2 Level - Intelligent System Rules...
mkdir "%RULES_DIR%\P2-intelligent-system" 2>nul
if exist "%GLOBAL_RULES_DIR%\super-brain-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\super-brain-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy super-brain-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\super-brain-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\memory-system-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\memory-system-integration.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy memory-system-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\memory-system-integration.mdc
)
if exist "%GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc" (
    copy "%GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-recommendation-engine.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc
)
echo - P2-intelligent-system/ (Priority: 800) >> "%MAIN_RULES%"
echo   - super-brain-system.mdc >> "%MAIN_RULES%"
echo   - memory-system-integration.mdc >> "%MAIN_RULES%"
echo   - intelligent-recommendation-engine.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P3 Level - Professional Development Rules (根据类型选择)
echo Creating P3 Level - Professional Development Rules...
mkdir "%RULES_DIR%\P3-professional-dev" 2>nul

REM 使用goto来确保条件判断正确执行
if /i "%RULE_TYPE%"=="frontend" goto :frontend_p3
if /i "%RULE_TYPE%"=="backend" goto :backend_p3
goto :fullstack_p3

:frontend_p3
echo DEBUG: Processing frontend P3 rules
echo ## Frontend Development Rules >> "%MAIN_RULES%"
if exist "%GLOBAL_RULES_DIR%\frontend-rules-2.1.md" (
    copy "%GLOBAL_RULES_DIR%\frontend-rules-2.1.md" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-rules-2.1.md
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\frontend-rules-2.1.md
)
if exist "%GLOBAL_RULES_DIR%\complete-workflow-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\complete-workflow-integration.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy complete-workflow-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\complete-workflow-integration.mdc
)
echo - P3-professional-dev/ (Priority: 700) >> "%MAIN_RULES%"
echo   - frontend-rules-2.1.md >> "%MAIN_RULES%"
echo   - complete-workflow-integration.mdc >> "%MAIN_RULES%"
goto :p3_done

:backend_p3
echo DEBUG: Processing backend P3 rules
echo ## Backend Development Rules >> "%MAIN_RULES%"
if exist "%GLOBAL_RULES_DIR%\backend-rules-2.1.md" (
    copy "%GLOBAL_RULES_DIR%\backend-rules-2.1.md" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-rules-2.1.md
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\backend-rules-2.1.md
)
if exist "%GLOBAL_RULES_DIR%\complete-workflow-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\complete-workflow-integration.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy complete-workflow-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\complete-workflow-integration.mdc
)
echo - P3-professional-dev/ (Priority: 700) >> "%MAIN_RULES%"
echo   - backend-rules-2.1.md >> "%MAIN_RULES%"
echo   - complete-workflow-integration.mdc >> "%MAIN_RULES%"
goto :p3_done

:fullstack_p3
echo DEBUG: Processing fullstack P3 rules
echo ## Fullstack Development Rules >> "%MAIN_RULES%"
if exist "%GLOBAL_RULES_DIR%\frontend-rules-2.1.md" (
    copy "%GLOBAL_RULES_DIR%\frontend-rules-2.1.md" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-rules-2.1.md
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\frontend-rules-2.1.md
)
if exist "%GLOBAL_RULES_DIR%\backend-rules-2.1.md" (
    copy "%GLOBAL_RULES_DIR%\backend-rules-2.1.md" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-rules-2.1.md
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\backend-rules-2.1.md
)
if exist "%GLOBAL_RULES_DIR%\complete-workflow-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\complete-workflow-integration.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy complete-workflow-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\complete-workflow-integration.mdc
)
echo - P3-professional-dev/ (Priority: 700) >> "%MAIN_RULES%"
echo   - frontend-rules-2.1.md >> "%MAIN_RULES%"
echo   - backend-rules-2.1.md >> "%MAIN_RULES%"
echo   - complete-workflow-integration.mdc >> "%MAIN_RULES%"

:p3_done
echo. >> "%MAIN_RULES%"

REM P4 Level - Project Workflow Rules (根据类型选择)
echo Creating P4 Level - Project Workflow Rules...
mkdir "%RULES_DIR%\P4-project-workflow" 2>nul

REM 使用goto来确保条件判断正确执行
if /i "%RULE_TYPE%"=="frontend" goto :frontend_p4
if /i "%RULE_TYPE%"=="backend" goto :backend_p4
goto :fullstack_p4

:frontend_p4
echo DEBUG: Processing frontend P4 rules
if exist "%PROJECT_RULES_DIR%\frontend-dev.mdc" (
    copy "%PROJECT_RULES_DIR%\frontend-dev.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-dev.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\frontend-dev.mdc
)
echo - P4-project-workflow/ (Priority: 600) >> "%MAIN_RULES%"
echo   - frontend-dev.mdc >> "%MAIN_RULES%"
goto :p4_common

:backend_p4
echo DEBUG: Processing backend P4 rules
if exist "%PROJECT_RULES_DIR%\backend-dev.mdc" (
    copy "%PROJECT_RULES_DIR%\backend-dev.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-dev.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\backend-dev.mdc
)
echo - P4-project-workflow/ (Priority: 600) >> "%MAIN_RULES%"
echo   - backend-dev.mdc >> "%MAIN_RULES%"
goto :p4_common

:fullstack_p4
echo DEBUG: Processing fullstack P4 rules
if exist "%PROJECT_RULES_DIR%\frontend-dev.mdc" (
    copy "%PROJECT_RULES_DIR%\frontend-dev.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-dev.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\frontend-dev.mdc
)
if exist "%PROJECT_RULES_DIR%\backend-dev.mdc" (
    copy "%PROJECT_RULES_DIR%\backend-dev.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-dev.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\backend-dev.mdc
)
echo - P4-project-workflow/ (Priority: 600) >> "%MAIN_RULES%"
echo   - frontend-dev.mdc >> "%MAIN_RULES%"
echo   - backend-dev.mdc >> "%MAIN_RULES%"

:p4_common
REM 通用项目工作流规则
if exist "%PROJECT_RULES_DIR%\commit.mdc" (
    copy "%PROJECT_RULES_DIR%\commit.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy commit.mdc
    echo   - commit.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\commit.mdc
)
if exist "%PROJECT_RULES_DIR%\code-review.mdc" (
    copy "%PROJECT_RULES_DIR%\code-review.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy code-review.mdc
    echo   - code-review.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\code-review.mdc
)
if exist "%PROJECT_RULES_DIR%\bug-fix.mdc" (
    copy "%PROJECT_RULES_DIR%\bug-fix.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy bug-fix.mdc
    echo   - bug-fix.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\bug-fix.mdc
)
echo. >> "%MAIN_RULES%"

REM P5 Level - Advanced Feature Rules (所有类型都需要)
echo Creating P5 Level - Advanced Feature Rules...
mkdir "%RULES_DIR%\P5-advanced-features" 2>nul
if exist "%PROJECT_RULES_DIR%\intelligent-project-management.mdc" (
    copy "%PROJECT_RULES_DIR%\intelligent-project-management.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-project-management.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\intelligent-project-management.mdc
)
if exist "%PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc" (
    copy "%PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-workflow-orchestration.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-intelligent-strategy.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc
)
if exist "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" (
    copy "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy ai-powered-code-review.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\ai-powered-code-review.mdc
)
echo - P5-advanced-features/ (Priority: 500) >> "%MAIN_RULES%"
echo   - intelligent-project-management.mdc >> "%MAIN_RULES%"
echo   - intelligent-workflow-orchestration.mdc >> "%MAIN_RULES%"
echo   - mcp-intelligent-strategy.mdc >> "%MAIN_RULES%"
echo   - ai-powered-code-review.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P6 Level - System Optimization Rules (所有类型都需要)
echo Creating P6 Level - System Optimization Rules...
mkdir "%RULES_DIR%\P6-system-optimization" 2>nul
if exist "%GLOBAL_RULES_DIR%\system-integration-config.mdc" (
    copy "%GLOBAL_RULES_DIR%\system-integration-config.mdc" "%RULES_DIR%\P6-system-optimization\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy system-integration-config.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\system-integration-config.mdc
)
if exist "%GLOBAL_RULES_DIR%\rule-redundancy-optimization.mdc" (
    copy "%GLOBAL_RULES_DIR%\rule-redundancy-optimization.mdc" "%RULES_DIR%\P6-system-optimization\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy rule-redundancy-optimization.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\rule-redundancy-optimization.mdc
)
echo - P6-system-optimization/ (Priority: 400) >> "%MAIN_RULES%"
echo   - system-integration-config.mdc >> "%MAIN_RULES%"
echo   - rule-redundancy-optimization.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P7 Level - Utility and Support Rules (根据类型选择mermaid)
echo Creating P7 Level - Utility and Support Rules...
mkdir "%RULES_DIR%\P7-utilities" 2>nul
if exist "%PROJECT_RULES_DIR%\analyze-issue.mdc" (
    copy "%PROJECT_RULES_DIR%\analyze-issue.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy analyze-issue.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\analyze-issue.mdc
)
if exist "%PROJECT_RULES_DIR%\implement-task.mdc" (
    copy "%PROJECT_RULES_DIR%\implement-task.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy implement-task.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\implement-task.mdc
)
if exist "%PROJECT_RULES_DIR%\create-docs.mdc" (
    copy "%PROJECT_RULES_DIR%\create-docs.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy create-docs.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\create-docs.mdc
)
if exist "%PROJECT_RULES_DIR%\feedback-enhanced.mdc" (
    copy "%PROJECT_RULES_DIR%\feedback-enhanced.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy feedback-enhanced.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\feedback-enhanced.mdc
)

echo - P7-utilities/ (Priority: 300) >> "%MAIN_RULES%"
echo   - analyze-issue.mdc >> "%MAIN_RULES%"
echo   - implement-task.mdc >> "%MAIN_RULES%"
echo   - create-docs.mdc >> "%MAIN_RULES%"
echo   - feedback-enhanced.mdc >> "%MAIN_RULES%"

REM mermaid只在frontend和fullstack模式中包含
if /i "%RULE_TYPE%"=="frontend" goto :add_mermaid
if /i "%RULE_TYPE%"=="fullstack" goto :add_mermaid
goto :skip_mermaid

:add_mermaid
echo DEBUG: Adding mermaid for %RULE_TYPE% mode
if exist "%PROJECT_RULES_DIR%\mermaid.mdc" (
    copy "%PROJECT_RULES_DIR%\mermaid.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mermaid.mdc
    echo   - mermaid.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mermaid.mdc
)

:skip_mermaid
echo. >> "%MAIN_RULES%"

echo ## Priority Levels for AI Understanding >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo **AI should follow rules in this priority order:** >> "%MAIN_RULES%"
echo - P0 (1000): Core Safety - MUST follow first >> "%MAIN_RULES%"
echo - P1 (900): Core Identity - Fundamental behavior >> "%MAIN_RULES%"
echo - P2 (800): Intelligent Systems - Advanced capabilities >> "%MAIN_RULES%"
echo - P3 (700): Professional Development - Domain expertise >> "%MAIN_RULES%"
echo - P4 (600): Project Workflows - Operational procedures >> "%MAIN_RULES%"
echo - P5 (500): Advanced Features - Enhanced functionality >> "%MAIN_RULES%"
echo - P6 (400): System Optimization - Performance tuning >> "%MAIN_RULES%"
echo - P7 (300): Utilities - Supporting tools >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM 统计文件数量
set /a TOTAL_FILES=0
for /r "%RULES_DIR%" %%f in (*.md *.mdc) do set /a TOTAL_FILES+=1

echo.
echo ========================================
echo SUCCESS: %RULE_TYPE% Rules Directory Created! (最终版本)
echo ========================================
echo.
echo Project Directory: %TARGET_DIR%
echo Rules Directory: %RULES_DIR%
echo Rule Type: %RULE_TYPE%
echo Total Files: %TOTAL_FILES%
echo Priority Levels: P0-P7 (8 levels)
echo AI Understanding: Priority-based directory structure
echo.
echo Directory Structure:
echo   %TARGET_DIR%/
echo   └── rules/
echo       ├── main.md (Directory guide)
echo       ├── P0-core-safety/
echo       ├── P1-core-identity/
echo       ├── P2-intelligent-system/
echo       ├── P3-professional-dev/
echo       ├── P4-project-workflow/
echo       ├── P5-advanced-features/
echo       ├── P6-system-optimization/
echo       └── P7-utilities/
echo.
echo 最终版本: 增强的错误处理和路径验证功能!
echo.

if %TOTAL_FILES% EQU 0 (
    echo WARNING: No files were copied! Please check:
    echo 1. Source directories exist: %GLOBAL_RULES_DIR% and %PROJECT_RULES_DIR%
    echo 2. Target directory permissions: %RULES_DIR%
    echo 3. Path contains no invalid characters
    pause
)