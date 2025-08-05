# 🚀 MCP工具快速入门指南

> **🎯 5分钟上手**: 从零开始配置MCP智能工具，提升AI开发体验

## ⚙️ 环境依赖检查

> **🔴 重要**: MCP工具需要Node.js环境支持

### ✅ 快速验证

```powershell
# 检查MCP工具依赖
node --version  # 必需: ≥16.0.0
npm --version   # 必需: ≥8.0.0
```

**状态检查**:
- ✅ **环境就绪**: 可以继续MCP工具配置
- ❌ **需要配置**: 请先完成 [环境配置](./ENVIRONMENT-SETUP.md)

## 📖 什么是MCP工具？

MCP (Model Context Protocol) 工具是Rules的**智能核心**，为AI开发提供：

| 核心功能 | 具体作用 | 使用场景 | 环境要求 |
|---------|----------|----------|----------|
| 🧠 **智能分析** | 自动理解代码结构和业务逻辑 | 代码重构、架构优化 | Node.js |
| 🔍 **上下文感知** | 基于项目历史提供精准建议 | 功能开发、问题排查 | Node.js |
| 🚀 **效率提升** | 减少重复工作，加速开发流程 | 日常编码、项目管理 | Node.js |
| 🎯 **智能推荐** | 基于最佳实践提供解决方案 | 技术选型、代码优化 | Node.js |

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

**选择英文版本：**
```bash
# 方法1：双击运行（最简单）
# 详细步骤：
# 1. 按 Win + E 打开文件资源管理器
# 2. 导航到 mcp-scripts 文件夹路径
# 3. 找到 run-powershell-installer.bat 文件
# 4. 双击该文件执行（不要右键，直接双击）

# 方法2：命令行运行
# 注意：如果项目在非C盘，需要先切换盘符
E:                                    # 先切换到E盘（根据你的实际盘符）
cd E:\AgentRules\English\rules-2.2.3-optimized\mcp-scripts
.\run-powershell-installer.bat
```

**选择中文版本：**
```bash
# 方法1：双击运行（最简单）
# 详细步骤：
# 1. 按 Win + E 打开文件资源管理器
# 2. 导航到 mcp-scripts 文件夹路径
# 3. 找到 install-mcp-tools-enhanced-final.bat 文件
# 4. 双击该文件执行（不要右键，直接双击）

# 方法2：命令行运行
# 注意：如果项目在非C盘，需要先切换盘符
E:                                    # 先切换到E盘（根据你的实际盘符）
cd E:\AgentRules\English\rules-2.2.3-optimized\mcp-scripts
.\install-mcp-tools-enhanced-final.bat
```

> **⚠️ 重要提示**：
> - 在Windows命令行中执行.bat脚本时，建议加上 `.\` 前缀，以确保正确执行
> - **Web界面默认关闭**：生成的配置文件中 `MCP_NO_BROWSER=true`，如需启用Web反馈界面，请手动修改为 `false`

### 步骤2：选择安装选项
脚本会自动检测你的系统环境，并提供以下选项：

```
=== MCP Tools Enhanced Installer v3.2 ===

检测到的可用驱动器:
1. C:\ (系统盘)
2. D:\ (数据盘)
3. E:\ (扩展盘)

请选择安装驱动器 [1-3]: 1

安装路径将为: C:\MCP-Tools
是否确认? [Y/N]: Y
```

### 步骤3：等待安装完成
脚本会自动完成以下操作：
- ✅ 检查Node.js和Python环境
- ✅ 创建MCP工具目录
- ✅ 安装4个Node.js MCP工具
- ✅ 安装1个Python MCP工具
- ✅ 生成配置文件模板

## 📋 安装验证

### 验证Node.js工具（4个）
```bash
# 检查安装目录（根据你选择的路径）
dir "C:\MCP-Tools\node_modules\@modelcontextprotocol"

# 应该看到以下4个工具：
# - server-filesystem
# - server-memory  
# - server-github
# - server-everything
```

### 验证Python工具（1个）
```bash
# 验证mcp-feedback-enhanced（这是Python包，不在文件夹中）
uvx mcp-feedback-enhanced@latest version

# 应该显示：MCP Feedback Enhanced v2.6.0
```

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
# 安装4个Node.js MCP工具
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

## 🚨 常见问题快速解决

### 问题1：找不到mcp-feedback-enhanced
**解决方案**: 这是正常现象，Python包不会显示在文件夹中
```bash
# 验证是否安装成功
uvx mcp-feedback-enhanced@latest version
```

### 问题2：反馈界面打不开
**解决方案**: 检查端口占用
```bash
# 检查8765端口
netstat -an | findstr :8765

# 如果被占用，修改配置中的端口号
"MCP_WEB_PORT": "8766"
```

### 问题3：GitHub功能不工作
**解决方案**: 检查Token权限
1. 访问 GitHub Settings > Developer settings > Personal access tokens
2. 创建新Token，勾选 `repo`, `user`, `workflow` 权限
3. 复制Token到配置文件中

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