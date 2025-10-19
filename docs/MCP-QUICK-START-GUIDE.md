# 🚀 MCP工具快速入门指南 v2.5.1

> **🎯 5分钟上手**: 从零开始配置MCP智能工具，解锁AI驱动的下一代开发体验
> 
> **🆕 2.6.0优化**: 50个智能规则（27个全局规则+23个项目规则）、v1.0+v2.0新增7个规则、优化优先级分布、新增大脑-记录员集成、100%集成测试通过
>
> **🗺️ 文档导航**: [完整导航索引](NAVIGATION-INDEX.md) | [返回主页](../README.md)

## ⚙️ 环境依赖检查

> **🔴 重要**: MCP工具需要Node.js环境支持

### 快速环境检查脚本

```bash
# Windows PowerShell
Write-Host "=== MCP 环境检查 ===" -ForegroundColor Green
Write-Host "Node.js 版本:" -NoNewline; node --version
Write-Host "npm 版本:" -NoNewline; npm --version
Write-Host "Python 版本:" -NoNewline; python --version
Write-Host "Git 版本:" -NoNewline; git --version
```

### 详细版本要求

| 组件 | 最低版本 | 推荐版本 | 检查命令 | 说明 |
|------|----------|----------|----------|------|
| Node.js | 18.0.0+ | 20.0.0+ | `node --version` | 支持ES2022特性 |
| npm | 9.0.0+ | 10.0.0+ | `npm --version` | 包管理器 |
| Python | 3.8+ | 3.11+ | `python --version` | MCP服务器运行时 |
| Git | 2.30+ | 2.40+ | `git --version` | 版本控制 |

### 常见问题解决

**Node.js 版本过低**
```bash
# 使用 nvm 升级 Node.js (推荐)
nvm install 20
nvm use 20

# 或直接从官网下载: https://nodejs.org/
```

**Python 未安装或版本过低**
```bash
# Windows: 从 Microsoft Store 安装
# 或访问: https://www.python.org/downloads/
```

**权限问题**
```bash
# Windows: 以管理员身份运行 PowerShell
# 设置执行策略
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**状态检查**:
- ✅ **环境就绪**: 可以继续MCP工具配置
- ❌ **需要配置**: 请先完成 [环境配置](./ENVIRONMENT-SETUP.md)

> 💡 检测复用与跳过要点：
> - 系统级启动阶段（如“启动超级大脑系统”）不主动触发项目级检测，由统一管理流程协调。
> - 最近300秒内已有检测结果，或存在“检测响应/ MCP平台报告”时，复用并跳过重复检测。
> - 如需覆盖缓存，使用“重新检测”指令或在命令中添加 --force。
>
> 这个策略的作用：
> - 加快启动与响应：避免重复检测，减少冷启动开销。
> - 保持流程一致：由统一管理流程在合适时机触发项目级检测，避免并发/冲突。
> - 提升可控性：用户可随时强制重检，确保在关键节点获取最新结果。
> - 透明可追溯：复用时标注结果来源（缓存/报告）与时间戳，便于审计与定位。
> - 降低资源消耗：减少磁盘/网络IO与外部API调用频率。
>
> 典型场景示例：
> - 第一次启动：无缓存 → 进行检测 → 生成“检测响应 / MCP平台报告” → 记录缓存。
> - 300秒内再次启动：跳过检测 → 复用上次报告 → 如指定 --force，则重新检测。
> - 系统激活阶段：不触发项目级检测 → 统一管理模块在需要时再触发。
## 📖 什么是MCP工具？

MCP (Model Context Protocol) 工具是Rules的**智能核心**，为AI开发提供：

| 核心功能 | 具体作用 | 使用场景 | 环境要求 |
|---------|----------|----------|----------|
| 🧠 **智能分析** | 自动理解代码结构和业务逻辑 | 代码重构、架构优化 | Node.js |
| 🔍 **上下文感知** | 基于项目历史提供精准建议 | 功能开发、问题排查 | Node.js |
| 🚀 **效率提升** | 减少重复工作，加速开发流程 | 日常编码、项目管理 | Node.js |
| 🎯 **智能推荐** | 基于最佳实践提供解决方案 | 技术选型、代码优化 | Node.js |

## 🚀 MCP 工具概述

### 🚀 核心功能详解

**智能反馈系统 (mcp-feedback-enhanced)**
- 实时收集用户反馈，优化AI响应质量
- 支持多种反馈模式：文本、评分、建议
- 自动学习用户偏好，个性化AI行为
- 提供反馈统计和分析报告

**GitHub集成 (server-github)**
- 无缝连接GitHub仓库，支持完整的代码管理流程
- 自动化Pull Request创建和管理
- 智能代码审查和问题跟踪
- 支持多仓库协作和分支管理

**内存管理系统 (server-memory)（可选）**
- 智能存储和检索对话历史
- 上下文感知的信息关联
- 支持长期记忆和短期记忆管理
- 自动清理和优化存储空间
  - 默认建议：Recorder 优先；Memory 按需使用（模糊语义检索或跨项目/跨时间聚合时）

**多功能工具集 (server-everything)**
- 提供丰富的开发辅助功能
- 支持文件操作、系统信息获取
- 集成常用开发工具和命令
- 可扩展的插件架构

### 🎯 适用场景

| 场景类型 | 具体应用 | 推荐工具组合 |
|----------|----------|-------------|
| **前端开发** | React/Vue项目开发、组件设计 | feedback + github + memory |
| **后端开发** | API设计、数据库操作 | github + everything + memory |
| **代码审查** | Pull Request审查、代码质量检查 | github + feedback |
| **项目管理** | 文档管理、任务跟踪 | everything + memory + github |
| **团队协作** | 知识共享、经验传承 | memory + feedback + github |

### 🔧 环境要求

**基础环境**
- Node.js 18.0.0+ (推荐 20.0.0+)
- npm 9.0.0+ (推荐 10.0.0+)
- Python 3.8+ (部分MCP服务器需要)

**支持的AI工具**
- ✅ Augment (完全支持)
- ✅ Cursor (完全支持)
- ✅ Claude Code (完全支持)
- ✅ Trae AI (完全支持)
- ✅ 其他支持MCP协议的AI工具

**操作系统兼容性**
- Windows 10/11 (推荐)
- macOS 10.15+
- Linux (Ubuntu 20.04+)

## 🎯 适用人群

- 🎨 **前端开发者**: React/Vue/Angular项目智能辅助
- 🔧 **后端开发者**: API设计、数据库优化建议
- 🌟 **全栈工程师**: 端到端项目管理和优化
- 👥 **开发团队**: 统一开发标准和最佳实践

## ⏱️ 安装时间预估

| 安装方式 | 预计时间 | 难度等级 | 推荐程度 |
|---------|----------|----------|----------|
| 🚀 **自动安装** | 3-5分钟 | ⭐ 简单 | ⭐⭐⭐⭐⭐ 强烈推荐 |
| 🔧 **手动安装** | 8-15分钟 | ⭐⭐⭐ 中等 | ⭐⭐⭐ 高级用户 |

## 🚀 安装方法

### 🎯 方式一：自动安装（强烈推荐）

> **💡 最佳选择**: 适合所有用户，自动处理复杂配置

#### 🔥 一键安装
```cmd
# 🎯 方式1：双击运行（最简单）
双击 → run-powershell-installer.bat

# 🎯 方式2：命令行运行
run-powershell-installer.bat
```

#### ✨ 自动安装优势

| 优势特点 | 具体说明 | 用户受益 |
|---------|----------|----------|
| ✅ **智能检测** | 自动识别系统环境和配置 | 无需手动判断系统类型 |
| ✅ **一键完成** | 全自动安装，无需人工干预 | 节省时间，避免错误 |
| ✅ **权限处理** | 自动申请和配置必要权限 | 避免权限相关问题 |
| ✅ **详细日志** | 提供完整的安装过程记录 | 便于问题排查和验证 |
| ✅ **错误恢复** | 自动处理常见安装问题 | 提高安装成功率 |

#### 🔧 安装脚本功能详解

我们的安装脚本会自动执行以下操作：

| 功能 | 描述 | 状态检查 |
|------|------|----------|
| **环境检测** | 检查Node.js、npm、Python版本 | ✅ 自动验证 |
| **权限设置** | 配置PowerShell执行策略 | ✅ 自动处理 |
| **依赖安装** | 安装所有MCP工具包 | ✅ 错误重试 |
| **配置生成** | 创建mcp-config.json模板 | ✅ 智能生成 |
| **路径配置** | 设置工具路径和环境变量 | ✅ 自动配置 |
| **功能测试** | 验证工具是否正常工作 | ✅ 完整测试 |

#### ⚡ 安装前准备

**获取安装脚本**
```bash
# 方式1: 克隆完整仓库
git clone https://github.com/your-repo/AgentRules.git
cd AgentRules/mcp-scripts

# 方式2: 仅下载安装脚本
curl -O https://raw.githubusercontent.com/your-repo/AgentRules/main/mcp-scripts/install-mcp-tools-enhanced-final.ps1
```

**环境预检查**
```bash
# 检查必要环境
node --version    # 应显示 v18.0.0 或更高
npm --version     # 应显示 9.0.0 或更高
python --version  # 应显示 3.8.0 或更高
```

> **⚠️ 重要提醒**：使用脚本安装前，建议先阅读 **[📋 安装脚本使用说明](../mcp-scripts/安装脚本使用说明.md)**，了解详细的安装方法和注意事项。

### 📋 推荐安装方法

我们提供了经过优化的安装脚本，完美解决了编码问题和执行策略问题：

| 安装方法 | 文件 | 特点 | 推荐程度 |
|---------|------|------|----------|
| **方法一（推荐）** | `run-powershell-installer.bat` | 双击运行，自动处理所有问题 | ⭐⭐⭐⭐⭐ |
| **方法二（高级）** | 手动PowerShell执行 | 完全控制安装过程 | ⭐⭐⭐⭐ |

> **💡 重要说明**：
> - **方法一**最简单：双击 `run-powershell-installer.bat` 即可完成安装，会自动在MCP-Tools文件夹下生成 `mcp-config.json` 配置文件
> - **方法二**适合高级用户：手动在PowerShell中执行脚本
> - 详细步骤请查看 **[📋 安装脚本使用说明](../mcp-scripts/安装脚本使用说明.md)**

### 步骤1：选择安装方法并执行

#### 🎯 方法1：双击运行（最简单，推荐）

**详细步骤：**
1. 按 `Win + E` 打开文件资源管理器
2. 导航到 `mcp-scripts` 文件夹路径
3. 找到 `run-powershell-installer.bat` 文件
4. **直接双击**该文件执行（不要右键，直接双击）
5. 如果出现安全提示，选择「运行」或「是」

#### 🎯 方法2：命令行运行（高级用户）

```bash
# PowerShell方式（推荐）
cd "你的项目路径\mcp-scripts"
.\run-powershell-installer.bat

# CMD方式（需要切换盘符）
# 注意：如果项目在非C盘，需要先切换盘符
E:                                    # 先切换到E盘（根据你的实际盘符）
cd E:\AgentRules\English\rules-2.4.2-optimized\mcp-scripts
.\run-powershell-installer.bat
```

#### 🛠️ 故障排除

**常见问题及解决方案：**

| 问题 | 解决方案 |
|------|----------|
| **执行策略错误** | 以管理员身份运行PowerShell，执行 `Set-ExecutionPolicy RemoteSigned` |
| **权限不足** | 右键PowerShell选择「以管理员身份运行」 |
| **脚本无法运行** | 检查文件路径是否包含中文或特殊字符 |
| **网络连接问题** | 检查网络连接，或使用VPN |

> **⚠️ 重要提示**：
> - 在Windows命令行中执行.bat脚本时，建议加上 `.\ ` 前缀，以确保正确执行
> - **Web界面默认关闭**：生成的配置文件中 `MCP_NO_BROWSER=true`，如需启用Web反馈界面，请手动修改为 `false`
> - **首次运行可能较慢**：需要下载和安装多个包，请耐心等待

### 步骤2：选择安装选项
脚本会自动检测你的系统环境，并提供以下选项：

```
=== MCP Tools Enhanced Installer v3.2 ===

🔍 系统环境检测:
✅ Node.js: v20.10.0 (满足要求)
✅ npm: v10.2.3 (满足要求)
✅ Python: v3.11.5 (满足要求)
✅ PowerShell: v5.1 (满足要求)

📁 检测到的可用驱动器:
1. C:\ (系统盘) - 可用空间: 45.2 GB
2. D:\ (数据盘) - 可用空间: 128.7 GB
3. E:\ (扩展盘) - 可用空间: 256.1 GB

请选择安装驱动器 [1-3]: 1

📍 安装路径将为: C:\MCP-Tools
💾 预计占用空间: ~150 MB
是否确认? [Y/N]: Y

🚀 开始安装...
```

### 步骤3：监控安装进度
脚本会显示详细的安装进度：

```
[1/6] 🔧 准备安装环境...
[2/6] 📦 安装 @modelcontextprotocol/server-filesystem... ✅
[3/6] 📦 安装 @modelcontextprotocol/server-memory... ✅
[4/6] 📦 安装 @modelcontextprotocol/server-github... ✅
[5/6] 📦 安装 @modelcontextprotocol/server-everything... ✅
[6/6] 🐍 安装 mcp-feedback-enhanced (Python)... ✅

📝 生成配置文件模板... ✅
🧪 运行安装验证测试... ✅

🎉 安装完成！配置文件已生成: C:\MCP-Tools\mcp-config.json

💡 提示：如不需要 Memory（server-memory），可在安装脚本中跳过该步骤；后续配置文件中也可以移除 memory 条目，不影响系统使用（Recorder 优先）。
```

### 步骤4：安装完成验证
脚本会自动完成以下操作并显示结果：

| 安装步骤 | 描述 | 预计时间 |
|----------|------|----------|
| ✅ **环境检查** | 检查Node.js和Python环境 | 10秒 |
| ✅ **目录创建** | 创建MCP工具目录 | 5秒 |
| ✅ **Node.js工具** | 安装3-4个Node.js MCP工具（server-memory 可选） | 60-120秒 |
| ✅ **Python工具** | 安装1个Python MCP工具 | 30-60秒 |
| ✅ **配置生成** | 生成配置文件模板 | 5秒 |
| ✅ **功能测试** | 验证所有工具正常工作 | 15秒 |

## 📋 安装验证

### 🔍 自动验证（推荐）
安装脚本会自动运行验证测试，如果看到以下输出说明安装成功：

```
🧪 运行安装验证测试...

✅ Node.js MCP工具验证:
  ├── @modelcontextprotocol/server-filesystem ✅
  ├── @modelcontextprotocol/server-memory ✅
  ├── @modelcontextprotocol/server-github ✅
  └── @modelcontextprotocol/server-everything ✅

✅ Python MCP工具验证:
  └── mcp-feedback-enhanced v2.6.0 ✅

✅ 配置文件验证:
  └── mcp-config.json 格式正确 ✅

🎉 所有验证通过！MCP工具已准备就绪。
```

### 🔧 手动验证（可选）

**验证Node.js工具（3-4个，server-memory 可选）**
```bash
# 方法1: 检查全局安装
npm list -g --depth=0 | findstr modelcontextprotocol

# 方法2: 检查安装目录（根据你选择的路径）
dir "C:\MCP-Tools\node_modules\@modelcontextprotocol"

# 应该看到以下3-4个工具（server-memory 可选）：
# ├── server-filesystem@1.0.0
# ├── server-github@1.0.0
# ├── server-everything@1.0.0
# └── server-memory@1.0.0（如已安装）
```

**验证Python工具（1个）**
```bash
# 验证mcp-feedback-enhanced（这是Python包，不在文件夹中）
uvx mcp-feedback-enhanced@latest version

# 应该显示：MCP Feedback Enhanced v2.6.0

# 或者测试运行
uvx mcp-feedback-enhanced@latest --help
```

**验证配置文件**
```bash
# 检查配置文件是否存在
dir "C:\MCP-Tools\mcp-config.json"

# 查看配置文件内容
type "C:\MCP-Tools\mcp-config.json"
```

### ❌ 验证失败处理

如果验证失败，请检查以下项目：

| 问题类型 | 检查项目 | 解决方案 |
|----------|----------|----------|
| **Node.js工具缺失** | npm全局包列表 | 重新运行安装脚本 |
| **Python工具缺失** | uvx是否安装 | 安装uv: `pip install uv` |
| **配置文件错误** | JSON格式是否正确 | 重新生成配置文件 |
| **权限问题** | 是否以管理员运行 | 以管理员身份重新运行 |

## ⚙️ 配置文件设置

### 步骤1：复制配置模板
安装完成后，脚本会在安装目录生成 `mcp-config-template.json` 文件。

### 步骤2：修改配置文件
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "你的项目路径"
      ]
    },
    "memory": {
      "command": "npx", 
      "args": ["@modelcontextprotocol/server-memory"]
    },
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "你的GitHub令牌"
      }
    },
    "everything": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-everything"]
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "timeout": 600,
      "env": {
        "MCP_WEB_PORT": "8765",
        "MCP_DESKTOP_MODE": "false"
      }
    }
  }
}
```

### 步骤3：需要修改的内容
1. **项目路径**: 将 `"你的项目路径"` 改为实际项目目录
2. **GitHub令牌**: 将 `"你的GitHub令牌"` 改为真实Token（可选）

## 🔧 方式二：手动配置（高级用户）

> **🎯 特点**：手动安装MCP工具并自定义配置，完全控制配置过程
>
> **⏱️ 时间**：10-15分钟
>
> **💡 适合**：高级用户、自定义需求、企业级部署

### 手动安装MCP工具

**步骤1：安装Node.js工具**
```bash
# 安装3-4个Node.js MCP工具（server-memory 可选）
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-everything
```

**步骤2：安装Python工具**
```bash
# 安装Python MCP工具
uvx install mcp-feedback-enhanced@latest
```

### 手动创建配置文件

**步骤3：创建配置文件**
在合适的位置创建 `mcp-config.json` 文件：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "你的项目路径"]
    },
    "memory": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-memory"]
    },

    // 提示：如不需要 Memory，可删除该条目，系统仍可正常工作（Recorder 优先）。
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "你的GitHub令牌"
      }
    },
    "everything": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-everything"]
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "env": {
        "MCP_NO_BROWSER": "true"
      }
    }
  }
}
```

### AI工具配置

**步骤4：配置AI工具**

### Augment配置
1. 打开Augment设置
2. 找到MCP配置选项
3. 导入或粘贴配置文件内容

### Cursor配置
1. 打开Cursor设置（Ctrl+,）
2. 搜索"MCP"
3. 在settings.json中添加配置

### Claude Code配置
1. 在项目根目录创建 `.claude_config` 文件
2. 添加MCP配置内容

### Trae AI配置
1. 打开Trae AI设置
2. 找到MCP集成选项
3. 导入配置文件

> **📚 详细手动配置教程**：查看 [MCP详细配置指南](MCP-DETAILED-CONFIG-GUIDE.md) 获取完整的手动配置步骤

## ✅ 配置完成后的使用步骤

### 第一步：让AI读取规则
**重要：完成MCP配置后，需要让AI读取项目规则**

在AI工具中输入以下任一命令：
```
请读取项目规则
```
或使用具体的工作流命令：
```
/frontend-dev    # 前端开发工作流
/backend-dev     # 后端开发工作流
/feedback        # 智能反馈功能
```

### 第二步：测试MCP功能

**测试反馈功能：**
```
请使用反馈功能询问我的项目需求
```

如果配置正确，应该会：
1. 弹出反馈界面（网页或桌面应用）
2. 显示AI的问题和选项
3. 可以进行交互式对话

**测试文件操作：**
```
请列出我的项目目录结构
```

如果配置正确，AI应该能够：
1. 读取你指定的项目目录
2. 显示文件和文件夹列表
3. 提供文件操作建议

> **💡 重要提示**：如果AI没有自动读取规则或MCP工具不工作，请：
> 1. 重启AI工具
> 2. 主动要求AI读取项目规则文件
> 3. 检查MCP配置文件路径是否正确

## ⚡ 前端测试与调试快速开始（Playwright & Chrome DevTools）

### Playwright：3步跑通端到端测试
1. 安装依赖（如未安装）：
   - `npm i -D @playwright/test`
   - `npx playwright install`
2. 运行测试：
   - 基础：`npx playwright test`
   - 指定浏览器：`npx playwright test --project=chromium`
   - 带界面：`npx playwright test --project=chromium --headed`
   - 过滤标签：`npx playwright test --grep "@critical"`
   - 报告：`npx playwright test --reporter=html`
3. 与系统集成：
   - 若已运行安装脚本（install-mcp-tools-enhanced-final.ps1），系统会在前端/全栈项目或用户提出“测试/自动化/E2E/回归”需求时，自动推荐并提供一键执行参数。

### Chrome DevTools（CDP）：3步开启浏览器调试
1. 启动远程调试端口：`chrome --remote-debugging-port=9222`
   - 如未配置 PATH，可通过快捷方式或完整路径启动，并在目标后附加该参数。
2. 获取 WebSocket 端点：访问 `http://localhost:9222/json/version`，复制 `webSocketDebuggerUrl`（形如 `ws://127.0.0.1:9222/devtools/browser/<id>`）。
3. 开始调试：
   - 网络错误与重试、控制台异常堆栈、DOM/资源加载、性能采样与火焰图、内存泄漏与快照对比。
   - 若已运行安装脚本，系统会在检测到“前端调试/性能问题/浏览器错误/白屏/卡顿”等意图或前端/全栈项目类型时，自动建议开启 CDP 并协助连接。

### 推荐工作流（问题到回归）
1. 复现问题 → 使用 CDP 收集证据（网络/控制台/性能/内存）
2. 修复代码 → 运行 Playwright 回归测试（关键路径与冒烟场景）
3. 生成报告 → 归档到 Recorder/知识库，复用诊断与修复策略

> 一键安装/自动检测：请参考 `mcp-scripts/安装脚本使用说明.md`，使用 `run-powershell-installer.bat` 或 `install-mcp-tools-enhanced-final.ps1`。

## ⚨ 常见问题快速解决

### 问题1：找不到mcp-feedback-enhanced
**现象**: 在文件夹中找不到mcp-feedback-enhanced
**解决方案**: 这是正常现象，Python包不会显示在文件夹中
```bash
# 验证是否安装成功
uvx mcp-feedback-enhanced@latest version

# 如果提示uvx未找到，先安装uv
pip install uv

# 然后重新验证
uvx mcp-feedback-enhanced@latest version
```

### 问题2：PowerShell执行策略错误
**现象**: 提示"无法加载文件，因为在此系统上禁止运行脚本"
**解决方案**: 修改PowerShell执行策略
```bash
# 以管理员身份运行PowerShell，然后执行：
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 确认更改
Y

# 验证策略已更改
Get-ExecutionPolicy
```

### 问题3：反馈界面打不开
**现象**: 使用反馈功能时界面无法打开
**解决方案**: 检查端口占用和配置
```bash
# 检查8765端口是否被占用
netstat -an | findstr :8765

# 如果被占用，修改配置中的端口号
"MCP_WEB_PORT": "8766"

# 或者关闭占用端口的程序
taskkill /F /PID <进程ID>
```

### 问题4：GitHub功能不工作
**现象**: GitHub相关功能无法使用
**解决方案**: 检查Token权限和配置
1. 访问 [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
2. 创建新Token，勾选以下权限：
   - ✅ `repo` (完整仓库访问)
   - ✅ `user` (用户信息读取)
   - ✅ `workflow` (GitHub Actions)
   - ✅ `read:org` (组织信息)
3. 复制Token到配置文件中
4. 重启AI工具使配置生效

### 问题5：npm安装失败
**现象**: npm install过程中出现错误
**解决方案**: 清理缓存并重试
```bash
# 清理npm缓存
npm cache clean --force

# 更新npm到最新版本
npm install -g npm@latest

# 重新运行安装脚本
.\run-powershell-installer.bat
```

### 问题6：网络连接问题
**现象**: 下载包时网络超时或连接失败
**解决方案**: 配置npm镜像源
```bash
# 使用淘宝镜像源
npm config set registry https://registry.npmmirror.com/

# 验证配置
npm config get registry

# 重新运行安装
.\run-powershell-installer.bat
```

## 📚 下一步

配置完成后，建议阅读：
- 🧠 [MCP智能使用策略](MCP-INTELLIGENT-USAGE-STRATEGY.md) - 学习高效使用技巧
- 🔧 [MCP故障排除指南](MCP-TROUBLESHOOTING-GUIDE.md) - 解决使用中的问题

## 🎯 记住

- ✅ **安装简单**: 一键脚本，自动完成
- ✅ **配置清晰**: 只需修改2-3个关键参数
- ✅ **验证容易**: 简单命令即可确认
- ✅ **问题好解决**: 大部分问题都有标准解决方案

**🚀 开始享受智能AI助手带来的高效开发体验吧！**