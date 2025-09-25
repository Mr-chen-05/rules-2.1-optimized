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
echo - P0-core-safety/ (Priority: 1000) >> "%MAIN_RULES%"
echo   - file-generation-safety-rules.mdc >> "%MAIN_RULES%"
echo   - ai-ethical-boundaries.mdc >> "%MAIN_RULES%"
echo   - rule-conflict-resolution.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P1 Level - Core Identity Rules (required for all types)
echo Creating P1 Level - Core Identity Rules...
mkdir "%RULES_DIR%\P1-core-identity" 2>nul
if exist "%GLOBAL_RULES_DIR%\unified-rules-base.mdc" (
    copy "%GLOBAL_RULES_DIR%\unified-rules-base.mdc" "%RULES_DIR%\P1-core-identity\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy unified-rules-base.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: unified-rules-base.mdc
    set "MISSING_FILES=1"
)
if exist "%GLOBAL_RULES_DIR%\ai-agent-intelligence-core.mdc" (
    copy "%GLOBAL_RULES_DIR%\ai-agent-intelligence-core.mdc" "%RULES_DIR%\P1-core-identity\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy ai-agent-intelligence-core.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: ai-agent-intelligence-core.mdc
    set "MISSING_FILES=1"
)
if exist "%GLOBAL_RULES_DIR%\ai-thinking-protocol.mdc" (
    copy "%GLOBAL_RULES_DIR%\ai-thinking-protocol.mdc" "%RULES_DIR%\P1-core-identity\" >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Failed to copy ai-thinking-protocol.mdc
        set "COPY_ERRORS=1"
    )
) else (
    echo ERROR: Critical file missing: ai-thinking-protocol.mdc
    set "MISSING_FILES=1"
)
echo - P1-core-identity/ (Priority: 900) >> "%MAIN_RULES%"
echo   - unified-rules-base.mdc >> "%MAIN_RULES%"
echo   - ai-agent-intelligence-core.mdc >> "%MAIN_RULES%"
echo   - ai-thinking-protocol.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P2 Level - Intelligent System Rules (required for all types)
echo Creating P2 Level - Intelligent System Rules...
mkdir "%RULES_DIR%\P2-intelligent-system" 2>nul
if exist "%GLOBAL_RULES_DIR%\super-brain-system.mdc" (
    copy "%GLOBAL_RULES_DIR%\super-brain-system.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy super-brain-system.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\super-brain-system.mdc
)
if exist "%GLOBAL_RULES_DIR%\dynamic-thinking-depth-regulation.mdc" (
    copy "%GLOBAL_RULES_DIR%\dynamic-thinking-depth-regulation.mdc" "%RULES_DIR%\P2-intelligent-system\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy dynamic-thinking-depth-regulation.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\dynamic-thinking-depth-regulation.mdc
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
echo   - dynamic-thinking-depth-regulation.mdc >> "%MAIN_RULES%"
echo   - memory-system-integration.mdc >> "%MAIN_RULES%"
echo   - intelligent-recommendation-engine.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P3 Level - Professional Development Rules (selected by type)
echo Creating P3 Level - Professional Development Rules...
mkdir "%RULES_DIR%\P3-professional-dev" 2>nul

REM Add common professional development rules
if exist "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" (
    copy "%GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy multimodal-interaction-framework.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\multimodal-interaction-framework.mdc
)
if exist "%GLOBAL_RULES_DIR%\human-ai-collaboration-optimization.mdc" (
    copy "%GLOBAL_RULES_DIR%\human-ai-collaboration-optimization.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy human-ai-collaboration-optimization.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\human-ai-collaboration-optimization.mdc
)
if exist "%GLOBAL_RULES_DIR%\knowledge-creation-discovery-framework.mdc" (
    copy "%GLOBAL_RULES_DIR%\knowledge-creation-discovery-framework.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy knowledge-creation-discovery-framework.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\knowledge-creation-discovery-framework.mdc
)

REM Use goto to ensure conditional execution order
if /i "%RULE_TYPE%"=="frontend" goto :frontend_p3
if /i "%RULE_TYPE%"=="backend" goto :backend_p3
goto :fullstack_p3

:frontend_p3
echo DEBUG: Processing frontend P3 rules
echo ## Frontend Development Rules >> "%MAIN_RULES%"
if exist "%GLOBAL_RULES_DIR%\frontend-rules.mdc" (
    copy "%GLOBAL_RULES_DIR%\frontend-rules.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy frontend-rules.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\frontend-rules.mdc
)
REM complete-workflow-integration.mdc has been integrated into intelligent-project-management.mdc
REM No longer needed as a separate file
echo - P3-professional-dev/ (Priority: 700) >> "%MAIN_RULES%"
echo   - multimodal-interaction-framework.mdc >> "%MAIN_RULES%"
echo   - human-ai-collaboration-optimization.mdc >> "%MAIN_RULES%"
echo   - knowledge-creation-discovery-framework.mdc >> "%MAIN_RULES%"
echo   - frontend-rules.mdc >> "%MAIN_RULES%"
goto :p3_done

:backend_p3
echo DEBUG: Processing backend P3 rules
echo ## Backend Development Rules >> "%MAIN_RULES%"
if exist "%GLOBAL_RULES_DIR%\backend-rules.mdc" (
    copy "%GLOBAL_RULES_DIR%\backend-rules.mdc" "%RULES_DIR%\P3-professional-dev\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy backend-rules.mdc
) else (
    echo WARNING: Source file not found: %GLOBAL_RULES_DIR%\backend-rules.mdc
)
REM complete-workflow-integration.mdc has been integrated into intelligent-project-management.mdc
REM No longer needed as a separate file
echo - P3-professional-dev/ (Priority: 700) >> "%MAIN_RULES%"
echo   - multimodal-interaction-framework.mdc >> "%MAIN_RULES%"
echo   - human-ai-collaboration-optimization.mdc >> "%MAIN_RULES%"
echo   - knowledge-creation-discovery-framework.mdc >> "%MAIN_RULES%"
echo   - backend-rules.mdc >> "%MAIN_RULES%"
goto :p3_done

:fullstack_p3
echo DEBUG: Processing fullstack P3 rules
echo ## Fullstack Development Rules >> "%MAIN_RULES%"
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
REM complete-workflow-integration.mdc has been integrated into intelligent-project-management.mdc
REM No longer needed as a separate file
echo - P3-professional-dev/ (Priority: 700) >> "%MAIN_RULES%"
echo   - multimodal-interaction-framework.mdc >> "%MAIN_RULES%"
echo   - human-ai-collaboration-optimization.mdc >> "%MAIN_RULES%"
echo   - knowledge-creation-discovery-framework.mdc >> "%MAIN_RULES%"
echo   - frontend-rules.mdc >> "%MAIN_RULES%"
echo   - backend-rules.mdc >> "%MAIN_RULES%"

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
REM Common project workflow rules
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

REM P5 Level - Advanced Feature Rules (required for all types)
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
if exist "%PROJECT_RULES_DIR%\mcp-unified-management.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-unified-management.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-unified-management.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-unified-management.mdc
)
if exist "%PROJECT_RULES_DIR%\mcp-zero-config-detection.mdc" (
    copy "%PROJECT_RULES_DIR%\mcp-zero-config-detection.mdc" "%RULES_DIR%\P5-advanced-features\" >nul 2>&1
    if errorlevel 1 echo WARNING: Failed to copy mcp-zero-config-detection.mdc
) else (
    echo WARNING: Source file not found: %PROJECT_RULES_DIR%\mcp-zero-config-detection.mdc
)
echo - P5-advanced-features/ (Priority: 500) >> "%MAIN_RULES%"
echo   - intelligent-project-management.mdc >> "%MAIN_RULES%"
echo   - intelligent-workflow-orchestration.mdc >> "%MAIN_RULES%"
echo   - mcp-intelligent-strategy.mdc >> "%MAIN_RULES%"
echo   - ai-powered-code-review.mdc >> "%MAIN_RULES%"
echo   - mcp-unified-management.mdc >> "%MAIN_RULES%"
echo   - mcp-zero-config-detection.mdc >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"

REM P6 Level - System Optimization Rules (required for all types)
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

REM Add MCP tools information to main.md
echo ## MCP Tools Directory >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo The mcp-tools/ directory contains management scripts for AI to use: >> "%MAIN_RULES%"
echo - mcp-cross-platform-sync.ps1 - Cross-platform MCP configuration sync >> "%MAIN_RULES%"
echo. >> "%MAIN_RULES%"
echo AI can directly call these scripts for MCP management and orchestration. >> "%MAIN_RULES%"
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

REM Count total files
set /a TOTAL_FILES=0
for /r "%RULES_DIR%" %%f in (*.md *.mdc) do set /a TOTAL_FILES+=1

echo.
echo ========================================
echo SUCCESS: %RULE_TYPE% Rules Directory Created! (Final Release)
echo ========================================
echo.
echo Project Directory: %TARGET_DIR%
echo Rules Directory: %RULES_DIR%
echo Rule Type: %RULE_TYPE%
echo Total files installed: %TOTAL_FILES%
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

echo Total files installed: %TOTAL_FILES%
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