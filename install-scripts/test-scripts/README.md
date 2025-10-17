# Test Scripts 测试脚本

本目录包含用于测试和验证Rules 2.5.1安装的脚本。

## 可用脚本

### 1. comprehensive-test-report.bat
**综合规则检测工具** ✅ **已全面优化编码兼容性**

- **功能**: 全面检测已安装规则的模式、完整性和健康度
- **用法**: `comprehensive-test-report.bat [project-path]`
- **示例**: `comprehensive-test-report.bat C:\Users\luo20\Desktop\demo-project`
- **功能特性**:
  - 🔍 智能模式检测 (Frontend/Backend/Fullstack)
  - 📊 文件数量统计和结构验证
  - 🏥 规则健康度评估 (0-100分)
  - 📂 目录结构完整性检查
  - 🎯 关键文件存在性验证
  - 💡 智能修复建议
  - 🌐 **增强编码检测**: 自动检测系统编码 (CP936/950/932/949/437/65001)
  - ✅ **ASCII安全输出**: 完全ASCII英文输出，支持所有Windows环境
  - 🔧 **PowerShell清理**: 使用PowerShell方法处理Unicode字符

**最新测试输出示例 (2025年10月)** ✅:
```
========================================
Rules 2.5.1 Comprehensive Detection Tool
========================================
Detecting project path: e:\temp-test-rules
Rules directory path: e:\temp-test-rules\.rules

Rules directory exists, starting comprehensive detection...

Directory Structure Detection:
  OK P0-core-safety
  OK P1-core-identity
  OK P2-intelligent-system
  OK P3-professional-dev
  OK P4-project-workflow
  OK P5-advanced-features
  OK P6-system-optimization
  OK P7-utilities
  OK All 8 priority directories complete

File Statistics:
  Rule files (.mdc): 43
  Index files (.md): 1
  Total rule count: 43 (based on .mdc files)

Key File Detection:
  OK main.md - Rules directory guide
  OK mermaid.mdc - Chart support
  OK frontend-dev.mdc - Frontend workflow
  OK backend-dev.mdc - Backend workflow
  OK frontend-rules.mdc - Frontend rules
  OK backend-rules.mdc - Backend rules

Mode Detection Results:
  Detected: FULLSTACK mode (Full-stack development)
  File count: 43 (expected: 43 .mdc files)
  OK Contains frontend, backend and chart support

Rules Health Assessment:
  EXCELLENT (100/100) - Rules complete and configured correctly

Recommendations:

========================================
Comprehensive Detection Complete
Detection Mode: FULLSTACK
Confidence: HIGH
Health Score: 100/100
========================================
```

**历史测试输出示例 (参考)**:
```
========================================
Rules 2.5.1 Comprehensive Detection Tool
========================================
Detecting project path: C:\Users\luo20\Desktop\demo-project
Rules directory path: C:\Users\luo20\Desktop\demo-project\rules

Rules directory exists, starting comprehensive detection...

Directory Structure Detection:
  OK P0-core-safety
  OK P1-core-identity
  OK P2-intelligent-system
  OK P3-professional-dev
  OK P4-project-workflow
  OK P5-advanced-features
  OK P6-system-optimization
  OK P7-utilities
  OK All 8 priority directories complete

File Statistics:
  Total files: 27
  .md files: 6
  .mdc files: 21

Key File Detection:
  OK main.md - Rules directory guide
  OK mermaid.mdc - Chart support
  OK frontend-dev.mdc - Frontend workflow
  OK backend-dev.mdc - Backend workflow
  OK frontend-rules.mdc - Frontend rules
  OK backend-rules.mdc - Backend rules

Mode Detection Results:
  Detected: FULLSTACK mode (Full-stack development)
  File count: 27 (expected: 27)
  OK Contains frontend, backend and chart support

Rules Health Assessment:
  EXCELLENT (100/100) - Rules complete and configured correctly

Recommendations:
  (No recommendations - Perfect configuration)

========================================
Comprehensive Detection Complete
Detection Mode: FULLSTACK
Confidence: HIGH
Health Score: 100/100
========================================
```

**中英文对照说明**:
- **Detecting project path** = 检测项目路径
- **Rules directory exists** = 规则目录存在
- **Directory Structure Detection** = 目录结构检测
- **File Statistics** = 文件统计
- **Key File Detection** = 关键文件检测
- **Mode Detection Results** = 模式检测结果
- **Rules Health Assessment** = 规则健康度评估
- **EXCELLENT** = 优秀
- **Comprehensive Detection Complete** = 综合检测完成

### 2. validate-rules-consistency.ps1
**规则元数据一致性校验**（type: `"always_apply"` 与 `alwaysApply:true`）

- 功能：扫描 `global-rules/` 与 `project-rules/` 下所有 `.mdc` 文件，强制校验以下规则：
  - 若存在 `type: "always_apply"`，则必须包含 `alwaysApply: true`
  - 可选语义警告（默认关闭）：若 `alwaysApply:true` 存在但 `type` ≠ `"always_apply"`，给出警告
- 适用场景：本地开发预检、CI 流水线校验、发布前一致性检查
- 与安装脚本集成：`install-ultra.bat` 会在开始阶段自动运行该脚本，如发现不一致将**中止安装**并提示修复指引
- 退出码：
  - `0` → 校验通过（无错误）
  - 非零 → 存在违反强制一致性的错误

**用法**:
```bash
# 基本校验（推荐）
pwsh ./scripts/validate-rules-consistency.ps1

# 启用语义一致性警告（非强制）
pwsh ./scripts/validate-rules-consistency.ps1 -WarnOnSemanticInconsistency
```

**示例输出（通过）**:
```
[validate] RepoRoot: E:\AgentRules\English\rules-2.1-optimized
[validate] Scanning rule directories: E:\AgentRules\English\rules-2.1-optimized\global-rules, E:\AgentRules\English\rules-2.1-optimized\project-rules
[summary] Errors: 0; Warnings: 0; Files scanned: 43
```

## 使用说明

**基本用法**:
```cmd
cd install-scripts\test-scripts
comprehensive-test-report.bat C:\path\to\your\project
```

**健康度评分标准**:
- 💚 **90-100分**: 优秀 - 规则完整且配置正确
- 💛 **70-89分**: 良好 - 规则基本完整，有小问题  
- 🧡 **50-69分**: 一般 - 规则不完整或配置有误
- ❤️ **0-49分**: 差 - 规则严重不完整

**模式检测标准 (2025年10月更新 - 基于.mdc文件统计)**:
- **Frontend模式**: 42个.mdc文件 (包含mermaid.mdc + frontend-dev.mdc + 新增8个规则文件)
- **Backend模式**: 41个.mdc文件 (包含backend-dev.mdc，无mermaid.mdc + 新增8个规则文件)
- **Fullstack模式**: 43个.mdc文件 (包含所有关键文件 + 优化后的规则分布)

**新增规则文件 (8个)**:
- `commit.mdc` - 统一提交工作流（支持快速模式 --fast；`/commit-fast` 为别名）
- `code-quality-check.mdc` - 代码质量检查
- `changelog-management.mdc` - 变更日志管理
- `mcp-debugging-enhanced.mdc` - 增强MCP调试
- `systematic-debugging.mdc` - 系统化调试
- `root-cause-analysis.mdc` - 根因分析
- `context-loader.mdc` - 上下文加载器
- `custom-command-builder.mdc` - 自定义命令构建器

## 更新记录

**2025年10月 (最新)**:
- 🔧 **脚本修复**: 修复install-ultra.bat和comprehensive-test-report.bat脚本
- 📁 **新增规则文件支持**: 添加8个新规则文件的安装和检测逻辑
- 📊 **文件数量更新 (基于.mdc文件统计)**: 
  - Frontend: 31→42个.mdc文件
  - Backend: 30→41个.mdc文件  
  - Fullstack: 33→43个.mdc文件
- ✅ **测试验证**: 
  - install-ultra.bat: 成功安装43个.mdc文件
  - comprehensive-test-report.bat: 正确检测FULLSTACK模式，健康评分100/100
- 🎯 **完整性保证**: 所有新增规则文件正确集成到安装和检测流程

**2025年9月27日**:
- 🌐 **增强编码检测**: 自动检测系统编码，支持中文、日文、韩文、西方语言
- ✅ **ASCII安全输出**: 完全转换为ASCII英文输出，避免编码问题
- 🔧 **PowerShell清理**: 使用PowerShell方法替代Unicode清理逻辑
- 📝 **注释英文化**: 所有代码注释转换为英文，提升维护性
- 🚀 **跨区域兼容**: 与install-ultra.bat保持一致的编码处理策略

**2025年8月29日**: 
- ✅ 修复了Unicode编码问题，支持所有Windows环境
- 🔧 合并了 `test-ultra.bat` 功能，删除重复脚本
- 📋 更新了输出格式，提供中英文对照
