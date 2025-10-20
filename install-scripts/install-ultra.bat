@echo off
setlocal enabledelayedexpansion

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
echo AgentRules Ultimate Rules Creator (Final Release)
echo Priority-Based Rules Directory Generation
echo ========================================
echo.

set "BASE_DIR=%~dp0.."
set "GLOBAL_RULES_DIR=%BASE_DIR%\global-rules"
set "PROJECT_RULES_DIR=%BASE_DIR%\project-rules"

echo.
echo [Step] Validating rules consistency...
powershell -NoProfile -ExecutionPolicy Bypass -File "%BASE_DIR%\scripts\validate-rules-consistency.ps1"
if errorlevel 1 (
    echo ERROR: Rules consistency validation failed. Please fix rule metadata per README.md.
    echo See: README.md -> 规则元数据字段说明
    echo.
    pause
    exit /b 1
)
echo [OK] Rules consistency validation passed.

REM Get original arguments and clean Unicode characters
set "RAW_TARGET=%~1"
set "RULE_TYPE=%~2"

REM Enhanced Unicode control character cleaning - ASCII-safe via PowerShell (removes BiDi and zero-width)
set "TARGET_DIR=%RAW_TARGET%"
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command "$t=$env:RAW_TARGET; $chars=@(0x202A,0x202B,0x202C,0x202D,0x202E,0x200B,0x200C,0x200D,0xFEFF); foreach($c in $chars){ $t=$t -replace [char]$c, '' }; $t=$t.Trim(); Write-Output $t"` ) do set "TARGET_DIR=%%A"
REM Trim leading and trailing spaces
for /f "tokens=* delims= " %%a in ("%TARGET_DIR%") do set "TARGET_DIR=%%a"

REM Check cleaned directory is empty or invalid
if "%TARGET_DIR%"=="" goto :use_default
if "%TARGET_DIR%"=="=" goto :use_default
goto :target_dir_ok

:use_default
REM If no valid target directory or contains invalid characters, default to Desktop\agent
set "DESKTOP_PATH=%USERPROFILE%\Desktop"
set "TARGET_DIR=%DESKTOP_PATH%\agent"
echo INFO: No valid target directory specified, using default desktop location: !TARGET_DIR!

:target_dir_ok
if "%RULE_TYPE%"=="" set "RULE_TYPE=fullstack"

echo Creating %RULE_TYPE% rules directory: %TARGET_DIR%
echo Including rules with priority levels for %RULE_TYPE% development...
echo DEBUG: Rule type is: [%RULE_TYPE%]
echo DEBUG: Original path: [%RAW_TARGET%]
echo DEBUG: Cleaned path: [%TARGET_DIR%]
echo.

REM Create target directory's parent directory path and validate
for %%i in ("%TARGET_DIR%") do set "PARENT_DIR=%%~dpi"
set "PARENT_DIR=%PARENT_DIR:~0,-1%"

echo DEBUG: Parent directory: [%PARENT_DIR%]

REM Validate parent directory existence
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

REM Check target directory exists rules file, avoid duplicate execution
set "RULES_DIR=%TARGET_DIR%\.rules"
if exist "%RULES_DIR%\main.md" (
    echo.
    echo ========================================
    echo NOTICE: Rules already exist in target directory!
    echo ========================================
    echo Target directory: %TARGET_DIR%
    echo Rules directory: %RULES_DIR%
    echo.
    echo The AgentRules have already been installed in this location.
    echo To avoid duplicate installation, the script will exit.
    echo.
    echo If you want to reinstall, please:
    echo 1. Delete the existing .rules folder
    echo 2. Run this script again
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 0
)

REM Create project directory
echo Creating target directory: %TARGET_DIR%
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%" 2>nul
    if errorlevel 1 (
        echo ERROR: Failed to create directory: %TARGET_DIR%
        echo Please check the path and permissions.
        echo.
        echo Press any key to exit...
        pause >nul
        exit /b 1
    )
)

REM Create rules subdirectory
echo Creating rules directory: %RULES_DIR%
if not exist "%RULES_DIR%" (
    mkdir "%RULES_DIR%" 2>nul
    if errorlevel 1 (
        echo ERROR: Failed to create rules directory: %RULES_DIR%
        echo Please check the path and permissions.
        echo.
        echo Press any key to exit...
        pause >nul
        exit /b 1
    )
)

REM Initialize error state variables
set "COPY_ERRORS=0"
set "MISSING_FILES=0"

REM Create main rules file
set "MAIN_RULES=%RULES_DIR%\main.md"

echo # AgentRules %RULE_TYPE% Rules > "%MAIN_RULES%"
if errorlevel 1 (
    echo ERROR: Failed to create main.md file
    echo Please check write permissions for: %RULES_DIR%
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

echo ## Priority-Based Rule System - AI Can Understand Rule Levels >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo This directory contains rules for %RULE_TYPE% development, >> "%MAIN_RULES%"
echo organized by priority levels that AI can understand and follow. >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo ## Rules Directory Structure >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P0 Level - Core Safety Rules (required for all types)
echo Creating P0 Level - Core Safety Rules...
mkdir "%RULES_DIR%\P0-core-safety" 2>nul
if exist "%GLOBAL_RULES_DIR%\file-generation-safety-rules.mdc" (
    copy "%GLOBAL_RULES_DIR%\file-generation-safety-rules.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy file-generation-safety-rules.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: file-generation-safety-rules.mdc
    set "MISSING_FILES=1"
)
if exist "%GLOBAL_RULES_DIR%\ai-ethical-boundaries.mdc" (
    copy "%GLOBAL_RULES_DIR%\ai-ethical-boundaries.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy ai-ethical-boundaries.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: ai-ethical-boundaries.mdc
    set "MISSING_FILES=1"
)
if exist "%GLOBAL_RULES_DIR%\rule-conflict-resolution.mdc" (
    copy "%GLOBAL_RULES_DIR%\rule-conflict-resolution.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy rule-conflict-resolution.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: rule-conflict-resolution.mdc
    set "MISSING_FILES=1"
)
REM multimodal-interaction-framework.mdc moved to P3 level (priority 800)
if exist "%GLOBAL_RULES_DIR%\dynamic-thinking-depth-regulation.mdc" (
    copy "%GLOBAL_RULES_DIR%\dynamic-thinking-depth-regulation.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy dynamic-thinking-depth-regulation.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: dynamic-thinking-depth-regulation.mdc
    set "MISSING_FILES=1"
)
if exist "%GLOBAL_RULES_DIR%\ai-thinking-protocol.mdc" (
    copy "%GLOBAL_RULES_DIR%\ai-thinking-protocol.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy ai-thinking-protocol.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: ai-thinking-protocol.mdc
    set "MISSING_FILES=1"
)
if exist "%GLOBAL_RULES_DIR%\human-ai-collaboration-optimization.mdc" (
    copy "%GLOBAL_RULES_DIR%\human-ai-collaboration-optimization.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy human-ai-collaboration-optimization.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: human-ai-collaboration-optimization.mdc
    set "MISSING_FILES=1"
)
if exist "%GLOBAL_RULES_DIR%\knowledge-creation-discovery-framework.mdc" (
    copy "%GLOBAL_RULES_DIR%\knowledge-creation-discovery-framework.mdc" "%RULES_DIR%\P0-core-safety\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy knowledge-creation-discovery-framework.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: knowledge-creation-discovery-framework.mdc
    set "MISSING_FILES=1"
)
echo - P0-core-safety/ (Priority: 1100-1200) >> "%MAIN_RULES%"
echo   - file-generation-safety-rules.mdc >> "%MAIN_RULES%"
echo   - ai-ethical-boundaries.mdc >> "%MAIN_RULES%"
echo   - rule-conflict-resolution.mdc >> "%MAIN_RULES%"
REM   - multimodal-interaction-framework.mdc moved to P3
echo   - dynamic-thinking-depth-regulation.mdc >> "%MAIN_RULES%"
echo   - ai-thinking-protocol.mdc >> "%MAIN_RULES%"
echo   - human-ai-collaboration-optimization.mdc >> "%MAIN_RULES%"
echo   - knowledge-creation-discovery-framework.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P1 Level - Core Identity Rules (required for all types)
echo Creating P1 Level - Core Identity Rules...
mkdir "%RULES_DIR%\P1-core-identity" 2>nul
REM Files with priority 1000-1099 belong to P1
if exist "%PROJECT_RULES_DIR%\mcp-zero-config-detection.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-zero-config-detection.mdc" "%RULES_DIR%\P1-core-identity\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy mcp-zero-config-detection.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: mcp-zero-config-detection.mdc
    set "MISSING_FILES=1"
)
echo - P1-core-identity/ (Priority: 1000-1099) >> "%MAIN_RULES%"
echo   - mcp-zero-config-detection.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P2 Level - Intelligent System Rules (required for all types) - 20 files
echo Creating P2 Level - Intelligent System Rules...
mkdir "%RULES_DIR%\P2-intelligent-system" 2>nul
REM Files with priority 900-999 belong to P2 - Enhanced with all 20 files
if exist "%GLOBAL_RULES_DIR%\unified-rules-base.mdc" (
    copy "%GLOBAL_RULES_DIR%\unified-rules-base.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy unified-rules-base.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\unified-rules-base.mdc
)
if exist "%GLOBAL_RULES_DIR%\ai-agent-intelligence-core.mdc" (
    copy "%GLOBAL_RULES_DIR%\ai-agent-intelligence-core.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy ai-agent-intelligence-core.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\ai-agent-intelligence-core.mdc
)
if exist "%GLOBAL_RULES_DIR%\audit-logging-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\audit-logging-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy audit-logging-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\audit-logging-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-recorder-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-recorder-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-recorder-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-recorder-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-recorder-core.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-recorder-core.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-recorder-core.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-recorder-core.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-recorder-templates.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-recorder-templates.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-recorder-templates.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-recorder-templates.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-recorder-advanced.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-recorder-advanced.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-recorder-advanced.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-recorder-advanced.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-recorder-edge-cases.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-recorder-edge-cases.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-recorder-edge-cases.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-recorder-edge-cases.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-systems-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-systems-integration.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-systems-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-systems-integration.mdc
)
if exist "%GLOBAL_RULES_DIR%\disaster-recovery-plan.mdc" (
    copy "%GLOBAL_RULES_DIR%\disaster-recovery-plan.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy disaster-recovery-plan.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\disaster-recovery-plan.mdc
)
if exist "%GLOBAL_RULES_DIR%\error-recovery-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\error-recovery-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy error-recovery-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\error-recovery-system.mdc
)
if exist "%PROJECT_RULES_DIR%\feedback-enhanced.mdc" (
    copy "%PROJECT_RULES_DIR%\feedback-enhanced.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy feedback-enhanced.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\feedback-enhanced.mdc
)
if exist "%PROJECT_RULES_DIR%\intelligent-project-management.mdc" (
    copy "%PROJECT_RULES_DIR%\intelligent-project-management.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-project-management.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\intelligent-project-management.mdc
)
if exist "%GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc" (
    copy "%GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-recommendation-engine.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc
)
if exist "%PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc" (
    copy "%PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-workflow-orchestration.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-intelligent-strategy.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-unified-management.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-unified-management.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-unified-management.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-unified-management.mdc
)
if exist "%GLOBAL_RULES_DIR%\memory-system-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\memory-system-integration.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy memory-system-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\memory-system-integration.mdc
)
if exist "%GLOBAL_RULES_DIR%\performance-monitoring-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\performance-monitoring-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy performance-monitoring-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\performance-monitoring-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\permission-control-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\permission-control-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy permission-control-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\permission-control-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\rule-hot-reload-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\rule-hot-reload-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy rule-hot-reload-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\rule-hot-reload-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\super-brain-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\super-brain-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy super-brain-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\super-brain-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\system-diagnostics.mdc" (
    copy "%GLOBAL_RULES_DIR%\system-diagnostics.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy system-diagnostics.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\system-diagnostics.mdc
)
if exist "%GLOBAL_RULES_DIR%\system-integration-config.mdc" (
    copy "%GLOBAL_RULES_DIR%\system-integration-config.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy system-integration-config.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\system-integration-config.mdc
)
echo - P2-intelligent-system/ (Priority: 900-999) - 24 files >> "%MAIN_RULES%"
echo   - unified-rules-base.mdc >> "%MAIN_RULES%"
echo   - ai-agent-intelligence-core.mdc >> "%MAIN_RULES%"
echo   - audit-logging-system.mdc >> "%MAIN_RULES%"
echo   - context-recorder-system.mdc (模块化架构索引) >> "%MAIN_RULES%"
echo   - context-recorder-core.mdc (核心功能模块) >> "%MAIN_RULES%"
echo   - context-recorder-templates.mdc (模板定义模块) >> "%MAIN_RULES%"
echo   - context-recorder-advanced.mdc (高级功能模块) >> "%MAIN_RULES%"
echo   - context-recorder-edge-cases.mdc (边界处理模块) >> "%MAIN_RULES%"
echo   - context-systems-integration.mdc (系统集成配置) >> "%MAIN_RULES%"
echo   - disaster-recovery-plan.mdc >> "%MAIN_RULES%"
echo   - error-recovery-system.mdc >> "%MAIN_RULES%"
echo   - feedback-enhanced.mdc >> "%MAIN_RULES%"
echo   - intelligent-project-management.mdc >> "%MAIN_RULES%"
echo   - intelligent-recommendation-engine.mdc >> "%MAIN_RULES%"
echo   - intelligent-workflow-orchestration.mdc >> "%MAIN_RULES%"
echo   - mcp-intelligent-strategy.mdc >> "%MAIN_RULES%"
echo   - mcp-unified-management.mdc >> "%MAIN_RULES%"
echo   - memory-system-integration.mdc >> "%MAIN_RULES%"
echo   - performance-monitoring-system.mdc >> "%MAIN_RULES%"
echo   - permission-control-system.mdc >> "%MAIN_RULES%"
echo   - rule-hot-reload-system.mdc >> "%MAIN_RULES%"
echo   - super-brain-system.mdc >> "%MAIN_RULES%"
echo   - system-diagnostics.mdc >> "%MAIN_RULES%"
echo   - system-integration-config.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"



REM P3 Level - Professional Development Rules (selected by type)
echo Creating P3 Level - Professional Development Rules...
mkdir "%RULES_DIR%\P3-professional-dev" 2>nul

REM Common professional development rules (high priority files moved to P1)

REM Use goto to ensure conditional execution order
if /i "%RULE_TYPE%"=="frontend" goto :frontend_p3
if /i "%RULE_TYPE%"=="backend" goto :backend_p3
goto :fullstack_p3

:frontend_p3
echo DEBUG: Processing frontend P3 rules
echo ## Frontend Development Rules >> "%MAIN_RULES%"
REM Copy frontend-specific rules only
if exist "%GLOBAL_RULES_DIR%\frontend-rules.mdc" (
    copy "%GLOBAL_RULES_DIR%\frontend-rules.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-rules.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\frontend-rules.mdc
)
REM Copy common professional development files
if exist "%GLOBAL_RULES_DIR%\brain-recorder-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\brain-recorder-integration.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy brain-recorder-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\brain-recorder-integration.mdc
)
if exist "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" (
    copy "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy multimodal-interaction-framework.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc
)
echo - P3-professional-dev/ (Priority: 800-899) >> "%MAIN_RULES%"
echo   - frontend-rules.mdc >> "%MAIN_RULES%"
echo   - brain-recorder-integration.mdc >> "%MAIN_RULES%"
echo   - multimodal-interaction-framework.mdc >> "%MAIN_RULES%"
goto :p3_done

:backend_p3
echo DEBUG: Processing backend P3 rules
echo ## Backend Development Rules >> "%MAIN_RULES%"
REM Copy backend-specific rules only
if exist "%GLOBAL_RULES_DIR%\backend-rules.mdc" (
    copy "%GLOBAL_RULES_DIR%\backend-rules.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-rules.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\backend-rules.mdc
)
REM Copy common professional development files
if exist "%GLOBAL_RULES_DIR%\brain-recorder-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\brain-recorder-integration.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy brain-recorder-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\brain-recorder-integration.mdc
)
if exist "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" (
    copy "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy multimodal-interaction-framework.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc
)
echo - P3-professional-dev/ (Priority: 800-899) >> "%MAIN_RULES%"
echo   - backend-rules.mdc >> "%MAIN_RULES%"
echo   - brain-recorder-integration.mdc >> "%MAIN_RULES%"
echo   - multimodal-interaction-framework.mdc >> "%MAIN_RULES%"
goto :p3_done

:fullstack_p3
echo DEBUG: Processing fullstack P3 rules
echo ## Fullstack Development Rules >> "%MAIN_RULES%"
REM Files with priority 800-899 belong to P3
REM Add promoted frontend/backend rules (priority 850-860)
if exist "%GLOBAL_RULES_DIR%\frontend-rules.mdc" (
    copy "%GLOBAL_RULES_DIR%\frontend-rules.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-rules.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\frontend-rules.mdc
)
if exist "%GLOBAL_RULES_DIR%\backend-rules.mdc" (
    copy "%GLOBAL_RULES_DIR%\backend-rules.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-rules.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\backend-rules.mdc
)
REM Keep brain-recorder-integration at P3 level (priority 890)
if exist "%GLOBAL_RULES_DIR%\brain-recorder-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\brain-recorder-integration.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy brain-recorder-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\brain-recorder-integration.mdc
)
REM Add multimodal-interaction-framework from P0 (priority 800)
if exist "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" (
    copy "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy multimodal-interaction-framework.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc
)
echo - P3-professional-dev/ (Priority: 800-899) >> "%MAIN_RULES%"
echo   - frontend-rules.mdc >> "%MAIN_RULES%"
echo   - backend-rules.mdc >> "%MAIN_RULES%"
echo   - brain-recorder-integration.mdc >> "%MAIN_RULES%"
echo   - multimodal-interaction-framework.mdc >> "%MAIN_RULES%"

:p3_done
echo. >> "%MAIN_RULES%"

REM P4 Level - Project Workflow Rules (required for all types) - 8 files
echo Creating P4 Level - Project Workflow Rules...
mkdir "%RULES_DIR%\P4-project-workflow" 2>nul

REM Use goto to ensure conditional execution order
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
echo - P4-project-workflow/ (Priority: 700-799) - 8 files >> "%MAIN_RULES%"
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
echo - P4-project-workflow/ (Priority: 700-799) - 8 files >> "%MAIN_RULES%"
echo   - backend-dev.mdc >> "%MAIN_RULES%"
goto :p4_common

:fullstack_p4
echo DEBUG: Processing fullstack P4 rules
if exist "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" (
    copy "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy ai-powered-code-review.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\ai-powered-code-review.mdc
)
if exist "%PROJECT_RULES_DIR%\backend-dev.mdc" (
    copy "%PROJECT_RULES_DIR%\backend-dev.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-dev.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\backend-dev.mdc
)
if exist "%PROJECT_RULES_DIR%\bug-fix.mdc" (
    copy "%PROJECT_RULES_DIR%\bug-fix.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy bug-fix.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\bug-fix.mdc
)
if exist "%PROJECT_RULES_DIR%\changelog-management.mdc" (
    copy "%PROJECT_RULES_DIR%\changelog-management.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy changelog-management.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\changelog-management.mdc
)
if exist "%PROJECT_RULES_DIR%\code-quality-check.mdc" (
    copy "%PROJECT_RULES_DIR%\code-quality-check.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy code-quality-check.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\code-quality-check.mdc
)
if exist "%PROJECT_RULES_DIR%\code-review.mdc" (
    copy "%PROJECT_RULES_DIR%\code-review.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy code-review.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\code-review.mdc
)
if exist "%PROJECT_RULES_DIR%\commit.mdc" (
    copy "%PROJECT_RULES_DIR%\commit.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy commit.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\commit.mdc
)
if exist "%PROJECT_RULES_DIR%\frontend-dev.mdc" (
    copy "%PROJECT_RULES_DIR%\frontend-dev.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-dev.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\frontend-dev.mdc
)
echo - P4-project-workflow/ (Priority: 700-799) - 8 files >> "%MAIN_RULES%"
echo   - ai-powered-code-review.mdc >> "%MAIN_RULES%"
echo   - backend-dev.mdc >> "%MAIN_RULES%"
echo   - bug-fix.mdc >> "%MAIN_RULES%"
echo   - changelog-management.mdc >> "%MAIN_RULES%"
echo   - code-quality-check.mdc >> "%MAIN_RULES%"
echo   - code-review.mdc >> "%MAIN_RULES%"
echo   - commit.mdc >> "%MAIN_RULES%"
echo   - frontend-dev.mdc >> "%MAIN_RULES%"

:p4_common
REM Common P4 files already included in fullstack mode above
REM For frontend/backend modes, add the common files
if /i not "%RULE_TYPE%"=="fullstack" (
    if exist "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" (
        copy "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
        if errorlevel 1 echo WARNING: Failed to copy ai-powered-code-review.mdc
    ) else (
        echo WARNING: Source file not found: %PROJECT_RULES_DIR%\ai-powered-code-review.mdc
    )
    if exist "%PROJECT_RULES_DIR%\bug-fix.mdc" (
        copy "%PROJECT_RULES_DIR%\bug-fix.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
        if errorlevel 1 echo WARNING: Failed to copy bug-fix.mdc
    ) else (
        echo WARNING: Source file not found: %PROJECT_RULES_DIR%\bug-fix.mdc
    )
    if exist "%PROJECT_RULES_DIR%\changelog-management.mdc" (
        copy "%PROJECT_RULES_DIR%\changelog-management.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
        if errorlevel 1 echo WARNING: Failed to copy changelog-management.mdc
    ) else (
        echo WARNING: Source file not found: %PROJECT_RULES_DIR%\changelog-management.mdc
    )
    if exist "%PROJECT_RULES_DIR%\code-quality-check.mdc" (
        copy "%PROJECT_RULES_DIR%\code-quality-check.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
        if errorlevel 1 echo WARNING: Failed to copy code-quality-check.mdc
    ) else (
        echo WARNING: Source file not found: %PROJECT_RULES_DIR%\code-quality-check.mdc
    )
    if exist "%PROJECT_RULES_DIR%\code-review.mdc" (
        copy "%PROJECT_RULES_DIR%\code-review.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
        if errorlevel 1 echo WARNING: Failed to copy code-review.mdc
    ) else (
        echo WARNING: Source file not found: %PROJECT_RULES_DIR%\code-review.mdc
    )
    if exist "%PROJECT_RULES_DIR%\commit.mdc" (
        copy "%PROJECT_RULES_DIR%\commit.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
        if errorlevel 1 echo WARNING: Failed to copy commit.mdc
    ) else (
        echo WARNING: Source file not found: %PROJECT_RULES_DIR%\commit.mdc
    )
    echo   - ai-powered-code-review.mdc >> "%MAIN_RULES%"
    echo   - bug-fix.mdc >> "%MAIN_RULES%"
    echo   - changelog-management.mdc >> "%MAIN_RULES%"
    echo   - code-quality-check.mdc >> "%MAIN_RULES%"
    echo   - code-review.mdc >> "%MAIN_RULES%"
    echo   - commit.mdc >> "%MAIN_RULES%"
)
echo. >> "%MAIN_RULES%"

REM P5 Level - Advanced Feature Rules (mode-specific)
echo Creating P5 Level - Advanced Feature Rules...
mkdir "%RULES_DIR%\P5-advanced-features" 2>nul

REM Use goto to ensure conditional execution order for P5
if /i "%RULE_TYPE%"=="frontend" goto :frontend_p5
if /i "%RULE_TYPE%"=="backend" goto :backend_p5
goto :fullstack_p5

:frontend_p5
echo DEBUG: Processing frontend P5 rules
REM Frontend needs context-loader and debugging tools
if exist "%PROJECT_RULES_DIR%\context-loader.mdc" (
    copy "%PROJECT_RULES_DIR%\context-loader.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-loader.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\context-loader.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-debugging-enhanced.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc
)
if exist "%PROJECT_RULES_DIR%\root-cause-analysis.mdc" (
    copy "%PROJECT_RULES_DIR%\root-cause-analysis.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy root-cause-analysis.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\root-cause-analysis.mdc
)
if exist "%PROJECT_RULES_DIR%\systematic-debugging.mdc" (
    copy "%PROJECT_RULES_DIR%\systematic-debugging.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy systematic-debugging.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\systematic-debugging.mdc
)
echo - P5-advanced-features/ (Priority: 600-699) - 4 files >> "%MAIN_RULES%"
echo   - context-loader.mdc >> "%MAIN_RULES%"
echo   - mcp-debugging-enhanced.mdc >> "%MAIN_RULES%"
echo   - root-cause-analysis.mdc >> "%MAIN_RULES%"
echo   - systematic-debugging.mdc >> "%MAIN_RULES%"
goto :p5_done

:backend_p5
echo DEBUG: Processing backend P5 rules
REM Backend needs context-loader and all debugging tools
if exist "%PROJECT_RULES_DIR%\context-loader.mdc" (
    copy "%PROJECT_RULES_DIR%\context-loader.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-loader.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\context-loader.mdc
)
if exist "%PROJECT_RULES_DIR%\systematic-debugging.mdc" (
    copy "%PROJECT_RULES_DIR%\systematic-debugging.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy systematic-debugging.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\systematic-debugging.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-debugging-enhanced.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc
)
if exist "%PROJECT_RULES_DIR%\root-cause-analysis.mdc" (
    copy "%PROJECT_RULES_DIR%\root-cause-analysis.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy root-cause-analysis.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\root-cause-analysis.mdc
)
echo - P5-advanced-features/ (Priority: 600-699) - 4 files >> "%MAIN_RULES%"
echo   - context-loader.mdc >> "%MAIN_RULES%"
echo   - systematic-debugging.mdc >> "%MAIN_RULES%"
echo   - mcp-debugging-enhanced.mdc >> "%MAIN_RULES%"
echo   - root-cause-analysis.mdc >> "%MAIN_RULES%"
goto :p5_done

:fullstack_p5
echo DEBUG: Processing fullstack P5 rules
REM Fullstack gets all P5 files
if exist "%PROJECT_RULES_DIR%\context-loader.mdc" (
    copy "%PROJECT_RULES_DIR%\context-loader.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-loader.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\context-loader.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-debugging-enhanced.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-debugging-enhanced.mdc
)
if exist "%PROJECT_RULES_DIR%\root-cause-analysis.mdc" (
    copy "%PROJECT_RULES_DIR%\root-cause-analysis.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy root-cause-analysis.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\root-cause-analysis.mdc
)
if exist "%PROJECT_RULES_DIR%\systematic-debugging.mdc" (
    copy "%PROJECT_RULES_DIR%\systematic-debugging.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy systematic-debugging.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\systematic-debugging.mdc
)
echo - P5-advanced-features/ (Priority: 600-699) - 4 files >> "%MAIN_RULES%"
echo   - context-loader.mdc >> "%MAIN_RULES%"
echo   - mcp-debugging-enhanced.mdc >> "%MAIN_RULES%"
echo   - root-cause-analysis.mdc >> "%MAIN_RULES%"
echo   - systematic-debugging.mdc >> "%MAIN_RULES%"

:p5_done
echo. >> "%MAIN_RULES%"

REM P6 Level - System Optimization Rules (mode-specific)
echo Creating P6 Level - System Optimization Rules...
mkdir "%RULES_DIR%\P6-system-optimization" 2>nul

REM Use goto to ensure conditional execution order for P6
if /i "%RULE_TYPE%"=="frontend" goto :frontend_p6
if /i "%RULE_TYPE%"=="backend" goto :backend_p6
goto :fullstack_p6

:frontend_p6
echo DEBUG: Processing frontend P6 rules
REM Frontend needs custom-command-builder for tool development
if exist "%PROJECT_RULES_DIR%\custom-command-builder.mdc" (
    copy "%PROJECT_RULES_DIR%\custom-command-builder.mdc" "%RULES_DIR%\P6-system-optimization\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy custom-command-builder.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\custom-command-builder.mdc
)
echo - P6-system-optimization/ (Priority: 500-599) - 1 file >> "%MAIN_RULES%"
echo   - custom-command-builder.mdc >> "%MAIN_RULES%"
goto :p6_done

:backend_p6
echo DEBUG: Processing backend P6 rules
REM Backend needs custom-command-builder
if exist "%PROJECT_RULES_DIR%\custom-command-builder.mdc" (
    copy "%PROJECT_RULES_DIR%\custom-command-builder.mdc" "%RULES_DIR%\P6-system-optimization\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy custom-command-builder.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\custom-command-builder.mdc
)
echo - P6-system-optimization/ (Priority: 500-599) - 1 file >> "%MAIN_RULES%"
echo   - custom-command-builder.mdc >> "%MAIN_RULES%"
goto :p6_done

:fullstack_p6
echo DEBUG: Processing fullstack P6 rules
REM Fullstack gets all P6 files
if exist "%PROJECT_RULES_DIR%\custom-command-builder.mdc" (
    copy "%PROJECT_RULES_DIR%\custom-command-builder.mdc" "%RULES_DIR%\P6-system-optimization\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy custom-command-builder.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\custom-command-builder.mdc
)
echo - P6-system-optimization/ (Priority: 500-599) - 1 file >> "%MAIN_RULES%"
echo   - custom-command-builder.mdc >> "%MAIN_RULES%"

:p6_done
echo. >> "%MAIN_RULES%"

REM P7 Level - Utility and Support Rules (mode-specific)
echo Creating P7 Level - Utility and Support Rules...
mkdir "%RULES_DIR%\P7-utilities" 2>nul

REM Use goto to ensure conditional execution order for P7
if /i "%RULE_TYPE%"=="frontend" goto :frontend_p7
if /i "%RULE_TYPE%"=="backend" goto :backend_p7
goto :fullstack_p7

:frontend_p7
echo DEBUG: Processing frontend P7 rules
REM Frontend needs analyze-issue, implement-task, create-docs, and mermaid
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
if exist "%PROJECT_RULES_DIR%\mermaid.mdc" (
    copy "%PROJECT_RULES_DIR%\mermaid.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mermaid.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mermaid.mdc
)
if exist "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" (
    copy "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context7-preload-standard.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context7-preload-standard.mdc
)
echo - P7-utilities/ (Priority: 400-499) - 5 files >> "%MAIN_RULES%"
echo   - analyze-issue.mdc >> "%MAIN_RULES%"
echo   - implement-task.mdc >> "%MAIN_RULES%"
echo   - create-docs.mdc >> "%MAIN_RULES%"
echo   - mermaid.mdc >> "%MAIN_RULES%"
echo   - context7-preload-standard.mdc >> "%MAIN_RULES%"
goto :p7_done

:backend_p7
echo DEBUG: Processing backend P7 rules
REM Backend needs analyze-issue, implement-task, create-docs (no mermaid)
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
if exist "%PROJECT_RULES_DIR%\mermaid.mdc" (
    copy "%PROJECT_RULES_DIR%\mermaid.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mermaid.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mermaid.mdc
)
if exist "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" (
    copy "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context7-preload-standard.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context7-preload-standard.mdc
)
echo - P7-utilities/ (Priority: 400-499) - 5 files >> "%MAIN_RULES%"
echo   - analyze-issue.mdc >> "%MAIN_RULES%"
echo   - implement-task.mdc >> "%MAIN_RULES%"
echo   - create-docs.mdc >> "%MAIN_RULES%"
echo   - mermaid.mdc >> "%MAIN_RULES%"
echo   - context7-preload-standard.mdc >> "%MAIN_RULES%"
goto :p7_done

:fullstack_p7
echo DEBUG: Processing fullstack P7 rules
REM Fullstack gets all P7 files including context7-preload-standard and mermaid
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
if exist "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" (
    copy "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context7-preload-standard.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context7-preload-standard.mdc
)
if exist "%PROJECT_RULES_DIR%\mermaid.mdc" (
    copy "%PROJECT_RULES_DIR%\mermaid.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mermaid.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mermaid.mdc
)
echo - P7-utilities/ (Priority: 300-499) - 5 files >> "%MAIN_RULES%"
echo   - analyze-issue.mdc >> "%MAIN_RULES%"
echo   - implement-task.mdc >> "%MAIN_RULES%"
echo   - create-docs.mdc >> "%MAIN_RULES%"
echo   - context7-preload-standard.mdc >> "%MAIN_RULES%"
echo   - mermaid.mdc >> "%MAIN_RULES%"

:p7_done
echo. >> "%MAIN_RULES%"

:create_templates
REM Create Templates directory and copy template files for AI context recording
echo Creating Templates directory and copying template files...
set "TEMPLATES_DIR=%TARGET_DIR%\templates"
mkdir "%TEMPLATES_DIR%" 2>nul

REM Copy template files for AI to use in context recording
set "SOURCE_TEMPLATES_DIR=%BASE_DIR%\templates"
if exist "%SOURCE_TEMPLATES_DIR%\project-init-template.md" (
    copy "%SOURCE_TEMPLATES_DIR%\project-init-template.md" "%TEMPLATES_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy project-init-template.md
    ) else (
        echo   Project initialization template installed: project-init-template.md
    )
) else (
    echo WARNING: Source file not found: %SOURCE_TEMPLATES_DIR%\project-init-template.md
)

if exist "%SOURCE_TEMPLATES_DIR%\archive-init-template.md" (
    copy "%SOURCE_TEMPLATES_DIR%\archive-init-template.md" "%TEMPLATES_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy archive-init-template.md
    ) else (
        echo   Archive initialization template installed: archive-init-template.md
    )
) else (
    echo WARNING: Source file not found: %SOURCE_TEMPLATES_DIR%\archive-init-template.md
)

REM Copy template configuration file for AI to use
if exist "%SOURCE_TEMPLATES_DIR%\template-config.yaml" (
    copy "%SOURCE_TEMPLATES_DIR%\template-config.yaml" "%TEMPLATES_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy template-config.yaml
    ) else (
        echo   Template configuration file installed: template-config.yaml
    )
) else (
    echo WARNING: Source file not found: %SOURCE_TEMPLATES_DIR%\template-config.yaml
)

REM Create MCP Tools directory and copy management scripts
echo Creating MCP Tools directory and copying management scripts...
set "MCP_TOOLS_DIR=%TARGET_DIR%\mcp-tools"
mkdir "%MCP_TOOLS_DIR%" 2>nul

REM Copy MCP cross-platform sync script for AI to use
set "MCP_SCRIPTS_DIR=%BASE_DIR%\mcp-scripts"
if exist "%MCP_SCRIPTS_DIR%\mcp-cross-platform-sync.ps1" (
    copy "%MCP_SCRIPTS_DIR%\mcp-cross-platform-sync.ps1" "%MCP_TOOLS_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy mcp-cross-platform-sync.ps1
    ) else (
        echo   MCP management script installed: mcp-cross-platform-sync.ps1
    )
) else (
    echo WARNING: Source file not found: %MCP_SCRIPTS_DIR%\mcp-cross-platform-sync.ps1
)

REM Copy list-cache.ps1 script for AI to use
if exist "%MCP_SCRIPTS_DIR%\list-cache.ps1" (
    copy "%MCP_SCRIPTS_DIR%\list-cache.ps1" "%MCP_TOOLS_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy list-cache.ps1
    ) else (
        echo   MCP cache listing script installed: list-cache.ps1
    )
) else (
    echo WARNING: Source file not found: %MCP_SCRIPTS_DIR%\list-cache.ps1
)

REM Copy parse-check.ps1 script for AI to use
if exist "%MCP_SCRIPTS_DIR%\parse-check.ps1" (
    copy "%MCP_SCRIPTS_DIR%\parse-check.ps1" "%MCP_TOOLS_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy parse-check.ps1
    ) else (
        echo   MCP parse validation script installed: parse-check.ps1
    )
) else (
    echo WARNING: Source file not found: %MCP_SCRIPTS_DIR%\parse-check.ps1
)

REM Create Scripts directory and copy validation script
set "SCRIPTS_TARGET_DIR=%TARGET_DIR%\scripts"
mkdir "%SCRIPTS_TARGET_DIR%" 2>nul
if exist "%BASE_DIR%\scripts\validate-rules-consistency.ps1" (
    copy "%BASE_DIR%\scripts\validate-rules-consistency.ps1" "%SCRIPTS_TARGET_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy validate-rules-consistency.ps1
    ) else (
        echo   Rules validation script installed: validate-rules-consistency.ps1
    )
) else (
    echo WARNING: Source file not found: %BASE_DIR%\scripts\validate-rules-consistency.ps1
)

REM Add templates information to main.md
echo ## Templates Directory >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo The templates/ directory contains initialization templates for AI context recording: >> "%MAIN_RULES%"
echo - project-init-template.md - Template for creating project.context.md files >> "%MAIN_RULES%"
echo - archive-init-template.md - Template for creating context.archive.md files >> "%MAIN_RULES%"
echo - template-config.yaml - Configuration file for template system v2.0 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo AI will automatically use these templates when initializing project context recording. >> "%MAIN_RULES%"
echo Templates support variable replacement: {{PROJECT_NAME}}, {{TIMESTAMP}}, etc. >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM Add MCP tools information to main.md
echo ## MCP Tools Directory >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo The mcp-tools/ directory contains management scripts for AI to use: >> "%MAIN_RULES%"
echo - mcp-cross-platform-sync.ps1 - Cross-platform MCP configuration sync >> "%MAIN_RULES%"
echo - list-cache.ps1 - MCP cache files listing and management >> "%MAIN_RULES%"
echo - parse-check.ps1 - PowerShell script syntax validation >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo AI can directly call these scripts for MCP management and orchestration. >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM Add Scripts information to main.md
echo ## Scripts Directory >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo The scripts/ directory contains maintenance and validation scripts: >> "%MAIN_RULES%"
echo - validate-rules-consistency.ps1 - Rule metadata consistency validator >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

echo ## Priority Levels for AI Understanding >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo **AI should follow rules in this priority order:** >> "%MAIN_RULES%"
echo - P0 (1100-1200): Core Safety - MUST follow first >> "%MAIN_RULES%"
echo - P1 (1000-1099): Core Identity - Fundamental behavior >> "%MAIN_RULES%"
echo - P2 (900-999): Intelligent Systems - Advanced capabilities >> "%MAIN_RULES%"
echo - P3 (800-899): Professional Development - Domain expertise >> "%MAIN_RULES%"
echo - P4 (700-799): Project Workflows - Operational procedures >> "%MAIN_RULES%"
echo - P5 (600-699): Advanced Features - Enhanced functionality >> "%MAIN_RULES%"
echo - P6 (500-599): System Optimization - Performance tuning >> "%MAIN_RULES%"
echo - P7 (300-499): Utilities - Supporting tools >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM Count total .mdc files only
set /a TOTAL_FILES=0
for /r "%RULES_DIR%" %%f in (*.mdc) do set /a TOTAL_FILES+=1

REM Count additional resource files
set /a TEMPLATE_COUNT=0
set /a MCP_TOOLS_COUNT=0
set /a SCRIPTS_COUNT=0

if exist "%TARGET_DIR%\templates" (
    for %%f in ("%TARGET_DIR%\templates\*.*") do set /a TEMPLATE_COUNT+=1
)

if exist "%TARGET_DIR%\mcp-tools" (
    for %%f in ("%TARGET_DIR%\mcp-tools\*.*") do set /a MCP_TOOLS_COUNT+=1
)

if exist "%TARGET_DIR%\scripts" (
    for %%f in ("%TARGET_DIR%\scripts\*.*") do set /a SCRIPTS_COUNT+=1
)

echo.
echo ========================================
echo SUCCESS: %RULE_TYPE% Rules Directory Created! (Final Release)
echo ========================================
echo.
echo Project Directory: %TARGET_DIR%
echo Rules Directory: %RULES_DIR%
echo Rule Type: %RULE_TYPE%
echo Total .mdc files installed: %TOTAL_FILES%
echo Priority levels: P0-P7 (8 levels)
echo.
echo Additional Directories:
echo   - templates/ (%TEMPLATE_COUNT% files for context recording)
echo   - mcp-tools/ (%MCP_TOOLS_COUNT% management scripts)
echo   - scripts/ (%SCRIPTS_COUNT% validation scripts)
echo.
echo Target location: %TARGET_DIR%
echo.
echo You can now navigate to the above path to access your AgentRules!
echo.

if %TOTAL_FILES% EQU 0 (
    echo.
    echo ========================================
    echo WARNING: Installation Issue Detected!
    echo ========================================
    echo.
    echo No files were copied! Please check:
    echo 1. Source directories exist: %GLOBAL_RULES_DIR% and %PROJECT_RULES_DIR%
    echo 2. Target directory permissions: %RULES_DIR%
    echo 3. Path contains no invalid characters
    echo.
    echo Press ENTER to exit...
    pause >nul
    exit /b 1
)

echo.
echo ========================================
echo AgentRules %RULE_TYPE% Installation Complete!
echo ========================================
echo.

REM Check installation status
if "%MISSING_FILES%"=="1" (
    echo WARNING: Some critical files were missing during installation
    echo    This may affect system functionality. Please check source files.
) else if "%COPY_ERRORS%"=="1" (
    echo WARNING: Some files failed to copy during installation
    echo    Installation completed with errors. Please check permissions.
) else (
    echo Installation completed successfully!
)

echo Total .mdc files installed: %TOTAL_FILES%
echo Priority levels: P0-P7 (8 levels)
echo.
echo Additional Resources:
echo   - Templates: %TEMPLATE_COUNT% files
echo   - MCP Tools: %MCP_TOOLS_COUNT% scripts
echo   - Scripts: %SCRIPTS_COUNT% validation scripts
echo.
echo Target location: %TARGET_DIR%
echo.
echo You can now use these rules with your AI development tools.
echo The rules are organized by priority for optimal AI understanding.
echo.
echo ========================================
echo Installation Summary:
echo ========================================
echo Rule Type: %RULE_TYPE%
echo Rule Files (.mdc): %TOTAL_FILES%
echo Target Path: %TARGET_DIR%
echo Rules Path: %RULES_DIR%
echo Templates: %TARGET_DIR%\templates
echo MCP Tools: %TARGET_DIR%\mcp-tools
echo Scripts: %TARGET_DIR%\scripts
if "%MISSING_FILES%"=="1" echo Status: WARNING - Missing critical files
if "%COPY_ERRORS%"=="1" echo Status: WARNING - Copy errors occurred
if "%MISSING_FILES%"=="0" if "%COPY_ERRORS%"=="0" echo Status: SUCCESS - All files installed correctly
echo ========================================
echo.
echo Happy coding with AgentRules Ultimate!
echo.
echo Press ENTER to exit...
pause >nul
goto :installation_complete

:installation_complete
echo.
echo Thank you for using AgentRules Ultimate!

REM Set exit code based on error status
if "%MISSING_FILES%"=="1" exit /b 2
if "%COPY_ERRORS%"=="1" exit /b 1
exit /b 0