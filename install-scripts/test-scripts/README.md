# Test Scripts 测试脚本

本目录包含用于测试和验证Rules 2.6.0安装的脚本。

## 可用脚本

### 1. comprehensive-test-report.bat
**综合规则检测工具** ✅ **已全面优化编码兼容性** ✅ **Backend模式识别修复完成** ✅ **v2.2新增Scripts目录检测**

- **功能**: 全面检测已安装规则的模式、完整性和健康度
- **版本**: v2.2 (2025-10-20)
- **用法**: `comprehensive-test-report.bat [project-path]`
- **示例**: `comprehensive-test-report.bat C:\Users\luo20\Desktop\demo-project`
- **功能特性**:
  - 🔍 智能模式检测 (Frontend/Backend/Fullstack)
  - 📊 文件数量统计和结构验证
  - 🏥 规则健康度评估 (0-100分)
  - 📂 目录结构完整性检查
  - 🎯 关键文件存在性验证
  - 💡 智能修复建议
  - 🛠️ **额外目录检测**: MCP Tools, Templates, Scripts (v2.2新增)
  - 🌐 **增强编码检测**: 自动检测系统编码 (CP936/950/932/949/437/65001)
  - ✅ **ASCII安全输出**: 完全ASCII英文输出，支持所有Windows环境
  - 🔧 **PowerShell清理**: 使用PowerShell方法处理Unicode字符

#### 🔍 检测场景快速参考表

| 场景编号 | 问题描述 | 检测提示 | 健康度影响 | 跳转 |
|---------|---------|---------|-----------|------|
| **场景1** | ✅ 完整安装 | `(No recommendations - Perfect configuration)` | 100/100 | [详情](#场景1-完整安装---无任何问题-) |
| **场景2** | ⚠️ 缺失Scripts | `Scripts directory not found. Validation features unavailable.` | 100/100* | [详情](#场景2-缺失-scripts-目录-️) |
| **场景3** | ⚠️ 缺失Templates | `Templates directory not found. Context recording features unavailable.` | 100/100* | [详情](#场景3-缺失-templates-目录-️) |
| **场景4** | ⚠️ 缺失MCP Tools | `MCP tools directory not found. Some features may be unavailable.` | 100/100* | [详情](#场景4-缺失-mcp-tools-目录-️) |
| **场景5** | ⚠️⚠️⚠️ 缺失全部3个附加目录 | 3条提示信息 | 100/100* | [详情](#场景5-缺失多个附加目录-️️️) |
| **场景6** | ⚠️ 缺失关键规则文件 | `Some key rule files are missing. Please check installation.` | <90/100 | [详情](#场景6-缺失部分规则文件-️) |
| **场景7** | ⚠️ 文件数量异常 | `File count differs significantly from expected. Expected: X, Found: Y` | 50-89/100 | [详情](#场景7-文件数量异常-️) |

**说明**：
- ✅ = 完美配置
- ⚠️ = 有警告但不影响核心功能
- * = 附加目录缺失不影响核心规则健康度评分，但会在Recommendations中提示

**最新测试输出示例 (2025年10月)** ✅:

#### 场景0: 规则目录不存在 ❌
```
========================================
Rules 2.6.0 Comprehensive Detection Tool
========================================
Detecting project path: E:\AgentRules\English\rules-2.1-optimized\test-frontend
ERROR: Rules directory not found!
Checked paths:
  - E:\AgentRules\English\rules-2.1-optimized\test-frontend\.rules
  - E:\AgentRules\English\rules-2.1-optimized\test-frontend\rules

Please ensure you are running this script in a project with installed rules.

Press any key to continue . . .
```
**中文说明**：
```
# 错误类型：致命错误 - 规则目录完全不存在
# 可能原因：
#   1. 从未运行过 install-ultra.bat 安装规则
#   2. 指定的项目路径不正确
#   3. 规则目录被手动删除
#   4. 路径中包含特殊字符或权限问题
# 
# 检测逻辑：
#   - 首先检查 [项目路径]\.rules 目录
#   - 如果不存在，再检查 [项目路径]\rules 目录（兼容旧版）
#   - 如果两个都不存在，报错并退出（exit code: 1）
#
# 解决方案：
#   方案1（推荐）：运行 install-ultra.bat 安装规则
#     cd E:\AgentRules\English\rules-2.1-optimized\install-scripts
#     install-ultra.bat [目标路径] [模式]
#     例如: install-ultra.bat E:\MyProject fullstack
#
#   方案2：检查路径是否正确
#     确保指定的路径是正确的项目根目录
#
#   方案3：检查是否有权限问题
#     确保对目标目录有读取权限
#
# 影响：无法进行任何检测，脚本立即退出
# 严重程度：❌ 致命 - 必须先安装规则才能使用检测工具
```

#### 场景1: 完整安装 - 无任何问题 ✅
```
========================================
Rules 2.6.0 Comprehensive Detection Tool
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
  Rule files (.mdc): 54
  Index files (.md): 1
  Total rule count: 54 (based on .mdc files)

Key File Detection:
  OK main.md - Rules directory guide
  OK mermaid.mdc - Chart support
  OK frontend-dev.mdc - Frontend workflow
  OK backend-dev.mdc - Backend workflow
  OK frontend-rules.mdc - Frontend rules
  OK backend-rules.mdc - Backend rules
  OK context-recorder-core.mdc - Modular context recorder core
  OK context-recorder-system.mdc - Context recorder system

Mode Detection Results:
  Detected: FULLSTACK mode (Full-stack development)
  File count: 54 (expected: 54 .mdc files)
  OK Contains frontend, backend and chart support

Rules Health Assessment:
  EXCELLENT (100/100) - Rules complete and configured correctly

Recommendations:
  (No recommendations - Perfect configuration)
  # 说明：完美配置，无任何问题

========================================
Comprehensive Detection Complete
Detection Mode: FULLSTACK
Confidence: HIGH
Health Score: 100/100
========================================
```

#### 场景2: 缺失 Scripts 目录 ⚠️
```
Recommendations:
  - Scripts directory not found. Validation features unavailable.
  # 说明：缺少 scripts/ 目录，validate-rules-consistency.ps1 验证脚本不可用
  # 影响：无法进行规则元数据一致性校验
  # 解决：重新运行 install-ultra.bat 或手动复制 scripts/ 目录
```

#### 场景3: 缺失 Templates 目录 ⚠️
```
Recommendations:
  - Templates directory not found. Context recording features unavailable.
  # 说明：缺少 templates/ 目录，上下文记录模板不可用
  # 影响：无法使用 project-init-template.md、archive-init-template.md 等模板
  # 解决：重新运行 install-ultra.bat 或手动复制 templates/ 目录
```

#### 场景4: 缺失 MCP Tools 目录 ⚠️
```
Recommendations:
  - MCP tools directory not found. Some features may be unavailable.
  # 说明：缺少 mcp-tools/ 目录，MCP管理工具不可用
  # 影响：无法使用 mcp-cross-platform-sync.ps1、parse-check.ps1、list-cache.ps1
  # 解决：重新运行 install-ultra.bat 或手动复制 mcp-tools/ 目录
```

#### 场景5: 缺失多个附加目录 ⚠️⚠️⚠️
```
Recommendations:
  - MCP tools directory not found. Some features may be unavailable.
  - Templates directory not found. Context recording features unavailable.
  - Scripts directory not found. Validation features unavailable.
  # 说明：缺少所有3个附加资源目录
  # 影响：MCP工具、模板系统、验证脚本全部不可用
  # 解决：强烈建议重新运行 install-ultra.bat 完整安装
```

#### 场景6: 缺失部分规则文件 ⚠️
```
Key File Detection:
  OK main.md - Rules directory guide
  OK mermaid.mdc - Chart support
  MISSING frontend-dev.mdc - Frontend workflow
  # 说明：缺少前端工作流规则文件
  
Recommendations:
  - Some key rule files are missing. Please check installation.
  # 说明：关键规则文件缺失，可能影响AI理解项目工作流
  # 解决：重新运行 install-ultra.bat 对应模式（frontend/backend/fullstack）
```

#### 场景7: 文件数量异常 ⚠️
```
File Statistics:
  Rule files (.mdc): 48
  # 说明：实际文件数(48) 与预期(54)相差较大

Mode Detection Results:
  Detected: FULLSTACK mode (Full-stack development)
  File count: 48 (expected: 54 .mdc files)
  # 说明：缺少6个.mdc文件

Rules Health Assessment:
  GOOD (75/100) - Rules basically complete, minor issues exist
  # 说明：健康度下降，规则不完整

Recommendations:
  - File count differs significantly from expected. Expected: 54, Found: 48
  # 说明：文件数量与预期不符，可能部分规则被意外删除
  # 解决：建议重新安装或检查是否手动删除了某些规则文件
```

---

### 📊 检测场景详细说明表（中文）

| 场景 | 问题类型 | 影响范围 | 严重程度 | 解决方案 | 备注 |
|-----|---------|---------|---------|---------|------|
| **场景0** | 规则目录不存在 | 完全无法使用 | ❌ 致命 | **必须**运行`install-ultra.bat`安装规则 | 脚本立即退出，无法进行任何检测 |
| **场景1** | 无问题 | 无 | ✅ 无影响 | 无需处理 | 完美配置，所有功能正常 |
| **场景2** | 缺失Scripts目录 | 验证功能 | ⚠️ 轻微 | 重新运行`install-ultra.bat`或手动复制 | 无法使用`validate-rules-consistency.ps1`验证脚本 |
| **场景3** | 缺失Templates目录 | 模板系统 | ⚠️ 轻微 | 重新运行`install-ultra.bat`或手动复制 | 无法使用项目初始化和归档模板 |
| **场景4** | 缺失MCP Tools目录 | MCP工具 | ⚠️ 轻微 | 重新运行`install-ultra.bat`或手动复制 | 无法使用MCP同步、解析检查、缓存列表工具 |
| **场景5** | 缺失全部附加目录 | 所有附加功能 | ⚠️ 中等 | **强烈建议**重新完整安装 | 所有附加工具和模板功能不可用 |
| **场景6** | 缺失关键规则文件 | AI理解能力 | ⚠️ 中等 | 重新运行对应模式的安装 | 可能影响AI对项目的理解和工作流执行 |
| **场景7** | 文件数量异常 | 规则完整性 | ⚠️ 严重 | 重新完整安装 | 规则严重不完整，影响AI核心功能 |

### 🎯 健康度评分说明（中文）

| 分数范围 | 评级 | 状态标识 | 说明 | 建议操作 |
|---------|------|---------|------|---------|
| **90-100分** | EXCELLENT（优秀） | 💚 | 规则完整且配置正确，所有功能可用 | 无需操作，保持现状 |
| **70-89分** | GOOD（良好） | 💛 | 规则基本完整，存在小问题 | 建议检查并修复提示的问题 |
| **50-69分** | FAIR（一般） | 🧡 | 规则不完整或配置有误 | **需要**重新安装或修复 |
| **0-49分** | POOR（差） | ❤️ | 规则严重不完整 | **必须**重新完整安装 |

### 🔧 常见问题快速诊断（中文）

**Q1: 为什么附加目录缺失时健康度仍然是100分？**  
A: 附加目录（Templates、MCP Tools、Scripts）是辅助功能，不影响核心规则系统的完整性。健康度评分主要基于：
- ✅ 8个优先级目录（P0-P7）完整性
- ✅ 关键规则文件存在性
- ✅ 文件数量准确性
- ✅ 模式识别准确性

**Q2: 如何判断是否需要重新安装？**  
A: 参考以下决策树：
```
运行检测脚本
├── 提示"ERROR: Rules directory not found!" → ❌ 场景0：必须立即安装
├── 能够检测，查看健康度评分：
│   ├── 100分 + 无Recommendations → ✅ 场景1：无需操作
│   ├── 100分 + 有Recommendations → ⚠️ 场景2-5：建议修复（非必须）
│   ├── 70-89分 → ⚠️ 场景6-7：建议重新安装
│   └── <70分 → ❌ 必须重新安装
└── 其他错误 → 检查路径和权限
```

**Q3: 缺失的目录可以手动复制吗？**  
A: 可以，但建议使用`install-ultra.bat`重新安装：
- **手动复制**：适用于单个目录缺失且源文件可用
- **重新安装**：适用于多个问题或不确定源文件版本（推荐）

**Q4: 不同模式的文件数量标准是什么？**  
A: 
- **Frontend**: 52个.mdc文件（包含前端规则、图表支持、模块化context-recorder）
- **Backend**: 52个.mdc文件（包含后端规则、模块化context-recorder）
- **Fullstack**: 54个.mdc文件（包含前端+后端规则、图表支持、模块化context-recorder）

**Q5: 遇到"ERROR: Rules directory not found!"怎么办？**  
A: 这是场景0，说明项目中完全没有规则目录，需要：
1. **确认项目路径**：检查指定的路径是否正确
   ```cmd
   REM 错误示例：指向了不存在的目录
   comprehensive-test-report.bat C:\NonExistent\Project
   
   REM 正确示例：指向实际项目目录
   comprehensive-test-report.bat E:\MyProject
   ```

2. **运行安装脚本**（推荐）：
   ```cmd
   cd E:\AgentRules\English\rules-2.1-optimized\install-scripts
   install-ultra.bat E:\MyProject fullstack
   ```
   安装模式选择：
   - `frontend` - 仅前端开发
   - `backend` - 仅后端开发  
   - `fullstack` - 全栈开发（推荐）

3. **验证安装**：
   ```cmd
   comprehensive-test-report.bat E:\MyProject
   ```
   应该看到健康度评分，而不是错误信息

4. **检查权限**：确保对目标目录有读写权限

**历史测试输出示例 (参考)**:
```
========================================
Rules 2.6.0 Comprehensive Detection Tool
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


### 4. validate-rules-consistency.ps1
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
- **Frontend模式**: 52个.mdc文件 (包含mermaid.mdc + frontend-dev.mdc + 模块化context-recorder文件)
- **Backend模式**: 52个.mdc文件 (包含backend-dev.mdc + backend-rules.mdc + 模块化context-recorder文件)
- **Fullstack模式**: 54个.mdc文件 (包含所有frontend + backend文件 + mermaid.mdc + 模块化context-recorder文件)

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

**2025年10月20日 v2.2 (最新)**:
- 🛠️ **Scripts目录检测**: 新增 `scripts/` 目录完整性检测
  - 检测 `validate-rules-consistency.ps1` 验证脚本
  - 提供缺失时的智能建议
  - 与 install-ultra.bat 的动态统计保持一致
- 📝 **版本更新**: comprehensive-test-report.bat 升级到 v2.2
- 📊 **完整资源检测**: 现在检测所有三个额外目录
  - ✅ Templates 目录 (3个模板文件)
  - ✅ MCP Tools 目录 (3个管理脚本)
  - ✅ Scripts 目录 (1个验证脚本) 🆕

**2025年10月20日 v2.1**:
- 🎉 **Backend模式识别修复**: 修复 Backend 模式被误识别为 UNKNOWN 的问题
  - 使用延迟变量扩展 (`!HAS_BACKEND!`) 解决批处理变量作用域问题
  - 优化 if 语句嵌套结构，提升判断准确性
  - 三种模式（Fullstack/Frontend/Backend）现已100%准确识别
- ✅ **新增批量测试脚本**: 创建 `run-all-tests.bat` 一键测试所有模式
- 📄 **完整测试报告**: 创建 `TEST-REPORT.md` 详细记录所有测试结果
- 🔧 **模式描述优化**: 动态显示正确的模式描述（Full-stack/Frontend/Backend development）
- ✅ **完整测试验证**: 
  - Fullstack: 54个.mdc文件, 100/100分, HIGH置信度 ✅
  - Frontend: 52个.mdc文件, 93/100分, HIGH置信度 ✅
  - Backend: 52个.mdc文件, 93/100分, HIGH置信度 ✅

**2025年10月 (早期)**:
- 🔧 **脚本修复**: 修复install-ultra.bat和comprehensive-test-report.bat脚本
- 📁 **新增规则文件支持**: 添加8个新规则文件的安装和检测逻辑
- 🛠️ **MCP工具集成**: 新增MCP管理工具检测功能
  - 检测 `mcp-tools/` 目录存在性
  - 验证 `mcp-cross-platform-sync.ps1`、`parse-check.ps1`、`list-cache.ps1` 脚本
  - 评估MCP工具配置完整性
- 📊 **文件数量更新 (基于.mdc文件统计)**: 
  - Frontend: 42→52个.mdc文件 (新增模块化context-recorder文件)
  - Backend: 41→52个.mdc文件 (新增模块化context-recorder文件)
  - Fullstack: 43→54个.mdc文件 (新增模块化context-recorder文件)
- 🔧 **模块化重构**: 
  - context-recorder-system.mdc 拆分为5个模块化文件
  - context-recorder-core.mdc: 核心功能模块 (10,128字节)
  - context-recorder-advanced.mdc: 高级功能模块 (8,828字节)
  - context-recorder-templates.mdc: 模板系统模块 (11,060字节)
  - context-recorder-edge-cases.mdc: 边缘情况处理模块 (8,044字节)
  - context-recorder-system.mdc: 系统集成模块 (7,998字节)
- ✅ **测试验证**: 
  - install-ultra.bat: 成功安装54个.mdc文件 (fullstack), 52个.mdc文件 (frontend/backend)
  - comprehensive-test-report.bat: 正确检测所有模式，健康评分100/100
  - 所有三种安装模式都包含完整的模块化context-recorder文件
- 🎯 **完整性保证**: 所有模块化文件正确集成到安装和检测流程，文件同步一致性验证通过

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

**最后更新**: 2025年10月20日  
**comprehensive-test-report.bat 版本**: v2.2  
**Rules 版本**: 2.6.0  
**状态**: ✅ 生产就绪
