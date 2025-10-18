# 🚀 Rules 2.5.1 - 高级使用指南

> **📢 重要通知**: 本文档内容已整合到主文档中，请访问 [README.md](README.md) 获取完整信息
>
> **🎯 快速导航**: 以下链接将直接跳转到 README.md 中的相应章节

## 📖 快速导航

### 🔧 高级配置
- [🔧 高级配置和使用](README.md#-高级配置和使用) - 自定义路径、批量部署、环境变量
- [📁 自定义路径配置](README.md#-自定义路径配置) - 相对路径、绝对路径、网络路径
- [🚀 批量部署方案](README.md#-批量部署方案) - 企业级部署解决方案
- [⚙️ 环境变量配置](README.md#️-环境变量配置) - 系统环境配置

### 📚 命令参考
- [📚 完整命令参考](README.md#-完整命令参考) - 所有可用命令的详细说明
- [🔧 核心开发命令](README.md#-核心开发命令) - 项目创建、环境配置
- [💻 代码生成与优化](README.md#-代码生成与优化) - 组件生成、代码优化
- [🛡️ 质量保证命令](README.md#️-质量保证命令) - 代码审查、提交规范
- [📊 项目管理命令](README.md#-项目管理命令) - 项目分析、任务管理
- [🧠 智能系统命令](README.md#-智能系统命令) - AI增强功能

### 🧾 规则元数据
- [🧾 规则元数据字段说明](README.md#-规则元数据字段说明) - alwaysApply 字段语义与用法

### 🔍 故障排除
- [🔍 故障排除](README.md#-故障排除) - 常见问题解决方案
- [🆘 技术支持](README.md#-技术支持) - 获取帮助的方式

## 📋 文档整合说明

为了提供更好的用户体验和避免信息重复，我们已将所有使用指南整合到主文档中：

### ✅ 已整合的内容
- ✅ **高级安装选项** → [README.md - 高级配置和使用](README.md#-高级配置和使用)
- ✅ **自定义路径配置** → [README.md - 自定义路径配置](README.md#-自定义路径配置)
- ✅ **批量部署方案** → [README.md - 批量部署方案](README.md#-批量部署方案)
- ✅ **环境变量配置** → [README.md - 环境变量配置](README.md#️-环境变量配置)
- ✅ **故障排除指南** → [README.md - 故障排除](README.md#-故障排除)
- ✅ **完整命令参考** → [README.md - 完整命令参考](README.md#-完整命令参考)

### 📚 其他重要文档
- 📖 **详细安装教程** → [install-scripts/INSTALL-GUIDE.md](install-scripts/INSTALL-GUIDE.md)
- 🎓 **完整学习指南** → [README.md](README.md)
- 🔧 **MCP工具配置** → [docs/MCP-QUICK-START-GUIDE.md](docs/MCP-QUICK-START-GUIDE.md)
- 🆘 **故障排除详解** → [docs/MCP-TROUBLESHOOTING-GUIDE.md](docs/MCP-TROUBLESHOOTING-GUIDE.md)

## 🔧 高级安装选项

> **📖 完整安装教程**: 详细的安装脚本使用方法请参考 👉 **[📋 完整安装指南](install-scripts/INSTALL-GUIDE.md)** | **[中文版](install-scripts/INSTALL-GUIDE-CN.md)**
>
> **🔥 核心特性**: 所有安装脚本现在使用**统一规则创建逻辑**，确保四个AI工具（Augment、Cursor、Claude、Trae）功能完全一致

### 🎯 快速参考

| AI 工具类型  | 推荐场景         | 快速命令                                               | 核心特性 |
| ------------ | ---------------- | ------------------------------------------------------ | ---------- |
| **前端专用** | React/Vue 项目   | `install-scripts\[工具名]-frontend.bat "项目路径"`     | ✅ 统一规则创建 |
| **后端专用** | API 开发、数据库 | `install-scripts\[工具名]-backend.bat "项目路径"`      | ✅ 统一规则创建 |
| **全栈支持** | 复杂业务逻辑     | `install-scripts\install-ultra.bat "项目路径" fullstack` | ✅ 统一规则创建 |

### 🔥 **核心改进：统一规则创建逻辑**

**重大突破**：现在所有AI工具使用**完全相同的规则内容**！

- ✅ **功能完全一致** - Augment、Cursor、Claude、Trae四个工具功能完全相同
- ✅ **规则内容统一** - 所有工具使用相同的文件组合顺序和内容
- ✅ **可互相复制** - 规则文件可以在不同AI工具间通用
- ✅ **一致性验证** - 通过`comprehensive-test-report.bat`工具确认规则一致性

**核心统一规则创建逻辑**：
- `install-ultra.bat` - 安装脚本

## 📁 自定义路径配置

> **📖 详细路径配置**: 完整的路径配置方法请参考 👉 **[📋 完整安装指南](install-scripts/INSTALL-GUIDE.md)** | **[中文版](install-scripts/INSTALL-GUIDE-CN.md)**

### 🎯 路径类型概览

| 路径类型     | 使用场景                   | 格式示例                    |
| ------------ | -------------------------- | --------------------------- |
| **相对路径** | rules 目录和项目在同一磁盘 | `..\my-project`             |
| **绝对路径** | 跨磁盘或固定位置           | `"C:\Dev\MyApp"`            |
| **网络路径** | 企业共享环境               | `"\\server\shared\project"` |

> **💡 提示**: 路径包含空格时必须使用双引号

## 🚀 批量部署方案

> **🏢 企业场景**: 适合团队统一配置、多项目管理

### 📖 详细安装教程

**完整的批量安装脚本和企业级部署方案，请参考：**

👉 **[📋 完整安装指南](install-scripts/INSTALL-GUIDE.md)** | **[中文版](install-scripts/INSTALL-GUIDE-CN.md)**

该指南包含：

- 🔧 **傻瓜式安装教程** - 3分钟完成安装
- 🏢 **企业级批量部署** - 多项目统一配置
- 🛡️ **安全检查脚本** - 自动检测项目类型
- ✅ **实测验证结果** - 所有脚本 100%通过测试
- 🎯 **43个规则文件（.mdc）** - 完整的规则体系覆盖
- 🎯 **按项目类型分类安装** - 前端/后端/全栈自动识别

### 🚀 快速批量安装

```cmd
# 一键安装到单个项目
install-scripts\install-ultra.bat "你的项目路径" fullstack

# 批量安装到多个项目（详细脚本见完整指南）
# 支持自动检测项目类型和智能配置
```

## ⚙️ 环境变量配置

> **🔧 高级配置**: 通过环境变量自定义 AI 规则行为和性能

### 🎯 核心环境变量

| 变量名           | 默认值      | 说明             | 示例                              |
| ---------------- | ----------- | ---------------- | --------------------------------- |
| `AI_RULES_PATH`  | `.ai-rules` | 规则文件存储路径 | `D:\MyRules`                      |
| `AI_RULES_LANG`  | `zh-CN`     | 默认语言设置     | `en-US`, `zh-CN`                  |
| `AI_RULES_MODE`  | `standard`  | 运行模式         | `debug`, `standard`, `enterprise` |
| `AI_RULES_CACHE` | `true`      | 启用缓存加速     | `true`, `false`                   |

### 🔧 配置方法

> **📖 详细配置教程**: 完整的环境变量配置方法请参考 👉 **[🔧 环境配置指南](docs/ENVIRONMENT-SETUP.md)**

| 配置方式            | 适用场景     | 快速示例                                     |
| ------------------- | ------------ | -------------------------------------------- |
| **PowerShell 临时** | 当前会话测试 | `$env:AI_RULES_PATH = "路径"`                |
| **PowerShell 永久** | 用户级配置   | `[Environment]::SetEnvironmentVariable(...)` |
| **CMD 方式**        | 传统命令行   | `setx AI_RULES_PATH "路径"`                  |

### ✅ 快速验证

```powershell
# 检查当前配置
echo $env:AI_RULES_PATH
```

## 🛠️ 核心功能

### 🎨 智能模板系统

> **📖 详细模板指南**: 查看 [TEMPLATES-GUIDE.md](tutorials/TEMPLATES-GUIDE.md) 获取完整的模板系统使用说明

#### 🚀 快速开始

```bash
# 初始化新项目模板
/init-project [项目类型]    # 自动创建项目结构和配置

# 归档项目模板
/archive-project           # 智能归档项目文件和文档

# 自定义模板
/create-template [名称]    # 创建自定义项目模板
```

#### 🎯 模板类型

| 模板类型 | 适用场景 | 包含内容 |
|---------|---------|----------|
| **项目初始化** | 新项目创建 | 目录结构、配置文件、README |
| **项目归档** | 项目完成后 | 文档整理、代码清理、部署配置 |
| **自定义模板** | 特定需求 | 用户定义的项目结构和配置 |

#### ✨ 核心特性

- 🎯 **智能变量替换** - 自动替换项目名称、作者、日期等
- 🔧 **条件逻辑** - 根据项目类型生成不同内容
- 📁 **目录结构** - 自动创建标准化项目结构
- 🔄 **可扩展性** - 支持自定义模板和变量

### ⚡ 主要命令

#### 📋 完整命令参考

> **📚 详细命令列表**: 查看 [COMMANDS-REFERENCE.md](COMMANDS-REFERENCE.md) 获取所有命令的完整说明 (建议先完成基础配置)

#### 🎯 快速命令

```bash
# 开发工作流
/frontend-dev    # 前端开发
/backend-dev     # 后端开发
/component       # 创建组件
/api-design      # API设计

# 代码管理
/commit          # 标准化提交（支持快速模式 --fast；`/commit-fast` 为别名）
/code-review     # 代码审查
/bug-fix         # Bug修复
/feedback        # 智能反馈

# 中文智能模式
/理解 /方案 /执行 /验证 /纠错 /辅助
```

### 🔧 MCP 工具集成配置

**配置方式选择：**

- **自动配置**：使用安装脚本（推荐新手）

  > **⚠️ 重要提醒**：使用 MCP 工具安装脚本前，建议先阅读 **[📋 安装脚本使用说明](mcp-scripts/安装脚本使用说明.md)** 了解详细的安装方法和注意事项。

  - 推荐方法：双击运行 `mcp-scripts/run-powershell-installer.bat`
    - 详细步骤：1) 按 Win+E 打开文件管理器 → 2) 导航到 mcp-scripts 文件夹 → 3) 找到 run-powershell-installer.bat → 4) 双击执行
    - 自动生成：脚本会在 MCP-Tools 文件夹下自动生成 `mcp-config.json` 配置文件
  - 手动执行：在 PowerShell 中运行 `install-mcp-tools-enhanced-final.ps1`

  > **🚨 安装后重要**：执行 MCP 安装脚本后，**强烈建议完整阅读** [📋 MCP 工具详细配置指南](docs/MCP-DETAILED-CONFIG-GUIDE.md) 以确保 MCP 功能正常使用！

- **手动配置**：完全自定义（适合高级用户）
  - 参考：[MCP 详细配置指南](docs/MCP-DETAILED-CONFIG-GUIDE.md)

**MCP 工具功能：**

- **💬 反馈增强** - 智能反馈收集和实时交互
- **📁 文件系统** - 自动化文件操作和项目管理
- **🧠 记忆管理** - 上下文保存和智能检索
- **🐙 GitHub 集成** - 仓库管理和问题分析

### 🔄 MCP 跨平台同步功能

**功能概述：**
MCP跨平台同步工具 (`mcp-cross-platform-sync.ps1`) 可以在不同AI开发平台之间同步MCP服务器配置，确保所有平台使用一致的配置。

**支持的平台：**
- ✅ **Trae AI** - 智能代码助手
- ✅ **Cursor IDE** - AI驱动的代码编辑器  
- ✅ **OpenAI Codex** - OpenAI的代码生成平台

**核心功能：**
- 🔍 **自动检测** - 发现已安装的AI平台及其配置状态
- 🔄 **配置同步** - 在多个平台间同步MCP服务器配置
- 🛡️ **安全备份** - 同步前自动备份原有配置
- 📊 **状态监控** - 实时查看各平台的配置状态

**快速使用：**
```powershell
# 检测所有已安装的AI平台
.\mcp-cross-platform-sync.ps1 detect

# 从Trae AI同步配置到OpenAI Codex
.\mcp-cross-platform-sync.ps1 sync -SourcePlatform "Trae" -TargetPlatforms "OpenAICodex"

# 预览同步操作（推荐）
.\mcp-cross-platform-sync.ps1 sync -SourcePlatform "Trae" -TargetPlatforms "OpenAICodex" -DryRun
```

**使用场景：**
- 🆕 **新平台配置** - 快速为新安装的AI平台配置MCP工具
- 🔄 **配置标准化** - 确保所有平台使用相同的MCP配置
- 🔧 **配置迁移** - 在不同AI平台间迁移MCP配置

> **💡 提示**: 详细的跨平台同步使用方法请参考 [📋 安装脚本使用说明](mcp-scripts/安装脚本使用说明.md) 中的"MCP跨平台同步功能"部分。

## 🎯 使用场景

### 👨‍💻 个人开发者

```cmd
# 选择单个AI工具
install-scripts\install-ultra.bat "..\你的项目目录" frontend
# 使用: /frontend-dev, /component, /commit
```

### 👥 团队协作

```cmd
# 一键安装支持所有AI工具
install-scripts\install-ultra.bat ..\你的项目目录 frontend
# 团队成员可以使用不同AI工具，获得统一体验
```

### 🏢 企业级

```cmd
# 全栈支持 + 完整工具链
install-scripts\install-ultra.bat ..\你的项目目录 fullstack
# 支持前端、后端、全栈开发，统一的企业级标准
```

## 💡 最佳实践建议

### 🎯 项目组织最佳实践

**📁 目录结构建议**

```
项目根目录/
├── .ai-rules/          # AI规则配置
├── docs/              # 项目文档
├── src/               # 源代码
├── tests/             # 测试文件
└── package.json       # 项目配置
```

**🔧 开发工作流建议**

- 使用 `/commit` 命令生成规范的提交信息
- 定期使用 `/review` 进行代码审查
- 项目启动前运行环境检查脚本

**👥 团队协作建议**

- 统一使用相同的 AI 规则版本
- 建立代码规范和最佳实践文档
- 定期同步规则更新

### 🚀 性能优化建议

**⚡ 提升响应速度**

- 使用本地 npm 镜像源
- 配置合适的 Node.js 版本
- 定期清理 npm 缓存

**💾 资源管理**

- 避免在大型项目根目录安装
- 使用项目特定的配置文件
- 定期备份重要配置

## 🏆 质量保证

### ✅ 测试认证

- **PERFECT (A++)评级** - 企业级标准
- **5/5 脚本通过** - 100%测试通过率
- **3-5/5 工具验证** - Node.js MCP 工具为 3-4 个（server-memory 可选），Python 工具 1 个；整体可用性验证通过
- **完整文档** - 从入门到故障排除

### 🛡️ 企业级标准

- UTF-8 编码支持、完善错误处理
- 路径安全处理、变量隔离保护

## 🔍 故障排除指南

### 常见问题

1. **命令不识别** → 检查规则文件位置
2. **反馈超时** → 检查 MCP 工具状态
3. **安装失败** → 查看 [故障排除指南](docs/MCP-TROUBLESHOOTING-GUIDE.md)

### 获取帮助

- 🚀 [MCP 快速入门指南](docs/MCP-QUICK-START-GUIDE.md)
- 🔧 [MCP 详细配置指南](docs/MCP-DETAILED-CONFIG-GUIDE.md)
- 📖 [MCP 故障排除指南](docs/MCP-TROUBLESHOOTING-GUIDE.md)
- 🤖 使用 `/feedback` 命令获取实时帮助

---

**💡 提示**: 更多信息请参考 [README.md](README.md) 中的项目信息部分
