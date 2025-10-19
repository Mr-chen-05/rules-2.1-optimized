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
    echo See: README.md -> ?????????
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

REM P2 Level - Intelligent System Rules (required for all types)
echo Creating P2 Level - Intelligent System Rules...
mkdir "%RULES_DIR%\P2-intelligent-system" 2>nul
REM Files with priority 900-999 belong to P2
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
if exist "%GLOBAL_RULES_DIR%\system-integration-config.mdc" (
    copy "%GLOBAL_RULES_DIR%\system-integration-config.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy system-integration-config.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\system-integration-config.mdc
)
if exist "%GLOBAL_RULES_DIR%\permission-control-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\permission-control-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy permission-control-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\permission-control-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\system-diagnostics.mdc" (
    copy "%GLOBAL_RULES_DIR%\system-diagnostics.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy system-diagnostics.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\system-diagnostics.mdc
)
if exist "%GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc" (
    copy "%GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-recommendation-engine.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\intelligent-recommendation-engine.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-systems-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-systems-integration.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-systems-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-systems-integration.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-unified-management.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-unified-management.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-unified-management.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-unified-management.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-intelligent-strategy.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-intelligent-strategy.mdc
)
if exist "%PROJECT_RULES_DIR%\intelligent-project-management.mdc" (
    copy "%PROJECT_RULES_DIR%\intelligent-project-management.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-project-management.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\intelligent-project-management.mdc
)
if exist "%PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc" (
    copy "%PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy intelligent-workflow-orchestration.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\intelligent-workflow-orchestration.mdc
)
if exist "%PROJECT_RULES_DIR%\feedback-enhanced.mdc" (
    copy "%PROJECT_RULES_DIR%\feedback-enhanced.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy feedback-enhanced.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\feedback-enhanced.mdc
)
if exist "%GLOBAL_RULES_DIR%\super-brain-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\super-brain-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy super-brain-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\super-brain-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\context-recorder-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\context-recorder-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-recorder-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context-recorder-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\memory-system-integration.mdc" (
    copy "%GLOBAL_RULES_DIR%\memory-system-integration.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy memory-system-integration.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\memory-system-integration.mdc
)
echo - P2-intelligent-system/ (Priority: 900-999) >> "%MAIN_RULES%"
echo   - unified-rules-base.mdc >> "%MAIN_RULES%"
echo   - ai-agent-intelligence-core.mdc >> "%MAIN_RULES%"
echo   - system-integration-config.mdc >> "%MAIN_RULES%"
echo   - permission-control-system.mdc >> "%MAIN_RULES%"
echo   - system-diagnostics.mdc >> "%MAIN_RULES%"
echo   - intelligent-recommendation-engine.mdc >> "%MAIN_RULES%"
echo   - context-systems-integration.mdc >> "%MAIN_RULES%"
echo   - mcp-unified-management.mdc >> "%MAIN_RULES%"
echo   - mcp-intelligent-strategy.mdc >> "%MAIN_RULES%"
echo   - intelligent-project-management.mdc >> "%MAIN_RULES%"
echo   - intelligent-workflow-orchestration.mdc >> "%MAIN_RULES%"
echo   - feedback-enhanced.mdc >> "%MAIN_RULES%"
echo   - super-brain-system.mdc >> "%MAIN_RULES%"
echo   - context-recorder-system.mdc >> "%MAIN_RULES%"
echo   - memory-system-integration.mdc >> "%MAIN_RULES%"
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
REM frontend-rules.mdc moved to P5 due to priority (700)
echo - P3-professional-dev/ (Priority: 800-899) >> "%MAIN_RULES%"
REM No files in P3 for frontend mode
goto :p3_done

:backend_p3
echo DEBUG: Processing backend P3 rules
echo ## Backend Development Rules >> "%MAIN_RULES%"
REM backend-rules.mdc moved to P5 due to priority (700)
echo - P3-professional-dev/ (Priority: 800-899) >> "%MAIN_RULES%"
REM No files in P3 for backend mode
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

REM P4 Level - Project Workflow Rules (required for all types)
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
echo - P4-project-workflow/ (Priority: 700-799) >> "%MAIN_RULES%"
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
echo - P4-project-workflow/ (Priority: 700-799) >> "%MAIN_RULES%"
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
echo - P4-project-workflow/ (Priority: 700-799) >> "%MAIN_RULES%"
echo   - frontend-dev.mdc >> "%MAIN_RULES%"
echo   - backend-dev.mdc >> "%MAIN_RULES%"

:p4_common
REM Common project workflow rules
REM Files with priority 700-799 belong to P4
REM backend-rules.mdc moved to P3 level (priority 850)
REM frontend-rules.mdc moved to P3 level (priority 860)
if exist "%PROJECT_RULES_DIR%\commit.mdc" (
    copy "%PROJECT_RULES_DIR%\commit.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy commit.mdc
    echo   - commit.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\commit.mdc
)
REM (Compatibility) commit-fast.mdc kept at P5 (priority 680) - alias for /commit --fast; prefer commit.mdc
if exist "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" (
    copy "%PROJECT_RULES_DIR%\ai-powered-code-review.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy ai-powered-code-review.mdc
    echo   - ai-powered-code-review.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\ai-powered-code-review.mdc
)
if exist "%PROJECT_RULES_DIR%\code-review.mdc" (
    copy "%PROJECT_RULES_DIR%\code-review.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy code-review.mdc
    echo   - code-review.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\code-review.mdc
)
if exist "%PROJECT_RULES_DIR%\code-quality-check.mdc" (
    copy "%PROJECT_RULES_DIR%\code-quality-check.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy code-quality-check.mdc
    echo   - code-quality-check.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\code-quality-check.mdc
)
if exist "%PROJECT_RULES_DIR%\bug-fix.mdc" (
    copy "%PROJECT_RULES_DIR%\bug-fix.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy bug-fix.mdc
    echo   - bug-fix.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\bug-fix.mdc
)
if exist "%PROJECT_RULES_DIR%\changelog-management.mdc" (
    copy "%PROJECT_RULES_DIR%\changelog-management.mdc" "%RULES_DIR%\P4-project-workflow\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy changelog-management.mdc
    echo   - changelog-management.mdc >> "%MAIN_RULES%"
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\changelog-management.mdc
)
echo. >> "%MAIN_RULES%"

REM P5 Level - Advanced Feature Rules (required for all types)
echo Creating P5 Level - Advanced Feature Rules...
mkdir "%RULES_DIR%\P5-advanced-features" 2>nul
REM Files with priority 600-699 belong to P5
if exist "%PROJECT_RULES_DIR%\context-loader.mdc" (
    copy "%PROJECT_RULES_DIR%\context-loader.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context-loader.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\context-loader.mdc
)
REM custom-command-builder.mdc moved to P6 due to priority (500)
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
echo - P5-advanced-features/ (Priority: 600-699) >> "%MAIN_RULES%"
echo   - context-loader.mdc >> "%MAIN_RULES%"
echo   - mcp-debugging-enhanced.mdc >> "%MAIN_RULES%"
echo   - root-cause-analysis.mdc >> "%MAIN_RULES%"
echo   - systematic-debugging.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P6 Level - System Optimization Rules (required for all types)
echo Creating P6 Level - System Optimization Rules...
mkdir "%RULES_DIR%\P6-system-optimization" 2>nul
REM Files with priority 500-599 belong to P6
if exist "%PROJECT_RULES_DIR%\custom-command-builder.mdc" (
    copy "%PROJECT_RULES_DIR%\custom-command-builder.mdc" "%RULES_DIR%\P6-system-optimization\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy custom-command-builder.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\custom-command-builder.mdc
)
echo - P6-system-optimization/ (Priority: 500-599) >> "%MAIN_RULES%"
echo   - custom-command-builder.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P7 Level - Utility and Support Rules (include mermaid by mode)
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
if exist "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" (
    copy "%GLOBAL_RULES_DIR%\context7-preload-standard.mdc" "%RULES_DIR%\P7-utilities\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy context7-preload-standard.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\context7-preload-standard.mdc
)

echo - P7-utilities/ (Priority: 300-499) >> "%MAIN_RULES%"
echo   - analyze-issue.mdc >> "%MAIN_RULES%"
echo   - implement-task.mdc >> "%MAIN_RULES%"
echo   - create-docs.mdc >> "%MAIN_RULES%"
echo   - context7-preload-standard.mdc >> "%MAIN_RULES%"

REM Mermaid is included only in frontend and fullstack modes
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

REM Copy MCP utility scripts
if exist "%MCP_SCRIPTS_DIR%\parse-check.ps1" (
    copy "%MCP_SCRIPTS_DIR%\parse-check.ps1" "%MCP_TOOLS_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy parse-check.ps1
    ) else (
        echo   MCP syntax checker installed: parse-check.ps1
    )
) else (
    echo WARNING: Source file not found: %MCP_SCRIPTS_DIR%\parse-check.ps1
)

if exist "%MCP_SCRIPTS_DIR%\list-cache.ps1" (
    copy "%MCP_SCRIPTS_DIR%\list-cache.ps1" "%MCP_TOOLS_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy list-cache.ps1
    ) else (
        echo   MCP cache manager installed: list-cache.ps1
    )
) else (
    echo WARNING: Source file not found: %MCP_SCRIPTS_DIR%\list-cache.ps1
)

REM Create Scripts directory and copy validation script
set "SCRIPTS_TARGET_DIR=%TARGET_DIR%\scripts"
mkdir "%SCRIPTS_TARGET_DIR%" 2>nul
if exist "%BASE_DIR%\scripts\validate-rules-consistency.ps1" (
    copy "%BASE_DIR%\scripts\validate-rules-consistency.ps1" "%SCRIPTS_TARGET_DIR%\" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Failed to copy validate-rules-consistency.ps1
        set "COPY_ERRORS=1"
    ) else (
        echo   Validator script installed: scripts\validate-rules-consistency.ps1
    )
) else (
    echo WARNING: Source file not found: %BASE_DIR%\scripts\validate-rules-consistency.ps1
)

REM Add templates information to main.md
echo ## Templates Directory >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo The templates/ directory contains enhanced initialization templates for AI context recording: >> "%MAIN_RULES%"
echo - project-init-template.md - Enhanced template for creating project.context.md files (v2.0) >> "%MAIN_RULES%"
echo - archive-init-template.md - Enhanced template for creating context.archive.md files (v2.0) >> "%MAIN_RULES%"
echo - template-config.yaml - Intelligent configuration file for template system >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo Enhanced features include: intelligent metadata, dynamic blocks, quality scoring, >> "%MAIN_RULES%"
echo relationship management, and smart archiving strategies. >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo AI will automatically use these templates when initializing project context recording. >> "%MAIN_RULES%"
echo Templates support variable replacement: ${PROJECT_NAME}, ${TIMESTAMP}, etc. >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM Add MCP tools information to main.md
echo ## MCP Tools Directory >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo The mcp-tools/ directory contains management scripts for AI to use: >> "%MAIN_RULES%"
echo - mcp-cross-platform-sync.ps1 - Cross-platform MCP configuration sync >> "%MAIN_RULES%"
echo - parse-check.ps1 - PowerShell syntax and MCP configuration validator >> "%MAIN_RULES%"
echo - list-cache.ps1 - MCP cache file viewer and manager >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo AI can directly call these scripts for MCP management and orchestration. >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM Add Scripts information to main.md
echo ## Scripts Directory >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo The scripts/ directory contains maintenance and validation scripts: >> "%MAIN_RULES%"
echo - validate-rules-consistency.ps1 - Rule metadata consistency validator >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

echo ## Priority Levels 详细说明 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo ### 优先级数值映射表 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo ^| 级别 ^| 范围 ^| 说明 ^| 典型优先级 ^| 示例规则 ^| >> "%MAIN_RULES%"
echo ^|------^|------^|------^|------------^|----------^| >> "%MAIN_RULES%"
echo ^| P0 ^| 1100-1200 ^| 核心安全 - 最高优先级 ^| 1200, 1180, 1160, 1150, 1140, 1120, 1090 ^| file-generation-safety-rules (1200) ^| >> "%MAIN_RULES%"
echo ^| P1 ^| 1000-1099 ^| 核心身份 - 基础行为 ^| 1050 ^| mcp-zero-config-detection (1050) ^| >> "%MAIN_RULES%"
echo ^| P2 ^| 900-999 ^| 智能系统 - 高级能力 ^| 970, 960, 950, 940, 920 ^| super-brain-system (970) ^| >> "%MAIN_RULES%"
echo ^| P3 ^| 800-899 ^| 专业开发 - 领域专长 ^| 890, 860, 850, 820, 800 ^| frontend-rules (860) ^| >> "%MAIN_RULES%"
echo ^| P4 ^| 700-799 ^| 项目工作流 - 流程规范 ^| 700-799 ^| frontend-dev (700) ^| >> "%MAIN_RULES%"
echo ^| P5 ^| 600-699 ^| 高级功能 - 增强特性 ^| 680, 650 ^| context-loader (680) ^| >> "%MAIN_RULES%"
echo ^| P6 ^| 500-599 ^| 系统优化 - 性能调优 ^| 500-599 ^| (预留) ^| >> "%MAIN_RULES%"
echo ^| P7 ^| 300-499 ^| 实用工具 - 辅助功能 ^| 450, 300 ^| context7-preload-standard (450) ^| >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo ### 优先级分配原则 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo 数值分配策略: >> "%MAIN_RULES%"
echo   同级规则间隔: >> "%MAIN_RULES%"
echo     - 关键规则: 间隔10 (如 1200, 1190, 1180) >> "%MAIN_RULES%"
echo     - 普通规则: 间隔20 (如 900, 920, 940) >> "%MAIN_RULES%"
echo     - 工具规则: 间隔50 (如 300, 350, 400) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   预留空间: >> "%MAIN_RULES%"
echo     - 每个级别预留30%%空间用于未来扩展 >> "%MAIN_RULES%"
echo     - 重要级别(P0-P2)间隔更密集 >> "%MAIN_RULES%"
echo     - 工具级别(P6-P7)间隔可较大 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo ### 新规则优先级决策树 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo 规则类型判断: >> "%MAIN_RULES%"
echo   if 涉及安全/伦理/底线: >> "%MAIN_RULES%"
echo     → P0 级别 (1100-1200) >> "%MAIN_RULES%"
echo     → 参考: ai-ethical-boundaries (1090) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   elif 影响核心身份/MCP检测: >> "%MAIN_RULES%"
echo     → P1 级别 (1000-1099) >> "%MAIN_RULES%"
echo     → 参考: mcp-zero-config-detection (1050) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   elif 智能系统/推荐引擎/记录系统: >> "%MAIN_RULES%"
echo     → P2 级别 (900-999) >> "%MAIN_RULES%"
echo     → 参考: super-brain-system (970) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   elif 专业领域规则(前端/后端): >> "%MAIN_RULES%"
echo     → P3 级别 (800-899) >> "%MAIN_RULES%"
echo     → 参考: frontend-rules (860) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   elif 工作流程/开发流程: >> "%MAIN_RULES%"
echo     → P4 级别 (700-799) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   elif 高级特性/调试工具: >> "%MAIN_RULES%"
echo     → P5 级别 (600-699) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   elif 性能优化/系统调优: >> "%MAIN_RULES%"
echo     → P6 级别 (500-599) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   else: >> "%MAIN_RULES%"
echo     → P7 级别 (300-499) >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo ### 优先级冲突解决 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo 冲突检测规则: >> "%MAIN_RULES%"
echo   自动检测: >> "%MAIN_RULES%"
echo     - 运行 scripts/validate-rules-consistency.ps1 >> "%MAIN_RULES%"
echo     - 检查是否有两个规则使用相同优先级 >> "%MAIN_RULES%"
echo     - 检查规则优先级是否在正确范围内 >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo   冲突解决: >> "%MAIN_RULES%"
echo     1. 评估两个规则的重要性 >> "%MAIN_RULES%"
echo     2. 更重要的保持原优先级 >> "%MAIN_RULES%"
echo     3. 次要的调整为相邻优先级 >> "%MAIN_RULES%"
echo     4. 记录调整原因到 changelog >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM Count total .mdc files only
set /a TOTAL_FILES=0
for /r "%RULES_DIR%" %%f in (*.mdc) do set /a TOTAL_FILES+=1

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
echo Target location: %TARGET_DIR%
echo.
echo You can now use these rules with your AI development tools.
echo The rules are organized by priority for optimal AI understanding.
echo.
echo ========================================
echo Installation Summary:
echo ========================================
echo Rule Type: %RULE_TYPE%
echo Files Copied: %TOTAL_FILES%
echo Target Path: %TARGET_DIR%
echo Rules Path: %RULES_DIR%
if "%MISSING_FILES%"=="1" echo Status: WARNING - Missing critical files
if "%COPY_ERRORS%"=="1" echo Status: WARNING - Copy errors occurred
if "%MISSING_FILES%"=="0" if "%COPY_ERRORS%"=="0" echo Status: SUCCESS - All files installed correctly
echo ========================================
echo.
echo Happy coding with AgentRules Ultimate!
echo.
echo Press ENTER to exit...
pause >nul
echo.
echo Thank you for using AgentRules Ultimate!

REM Set exit code based on error status
if "%MISSING_FILES%"=="1" exit /b 2
if "%COPY_ERRORS%"=="1" exit /b 1
exit /b 0
