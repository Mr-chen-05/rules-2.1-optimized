# 🎨 前端开发 AI 助手规则使用指南

## 📖 概述

本指南专门针对前端开发，**手把手教你**如何配置和使用前端开发 AI 助手规则。

**🎯 适合人群：**
- ✅ **完全新手** - 从未接触过 MCP 工具的用户
- ✅ **前端开发者** - 想要 AI 助手帮助开发 Vue/React 项目
- ✅ **学习者** - 想要学习现代前端开发工具链

**📚 你将学会：**
- 🔧 如何安装和配置 Node.js（包括 NVM 版本管理）
- 📦 如何安装和配置 5 个 MCP 工具
- 🤖 如何使用智能反馈机制与 AI 深度交互
- 🎨 如何让 AI 帮你开发前端项目

**⏱️ 预计时间：** 30-60 分钟（取决于网络速度和电脑配置）

## 🎯 什么是前端规则？

**⚠️ 新手必读：** 在开始之前，请先了解这个项目能为你做什么！

### 🔥 **核心改进：统一规则创建逻辑**

**重大突破**：现在所有AI工具（Augment、Cursor、Claude Code、Trae AI）使用**完全相同的规则内容**！

- ✅ **功能完全一致** - 四个AI工具提供相同的前端开发功能
- ✅ **规则内容统一** - 所有工具使用相同的文件组合顺序（约184KB）
- ✅ **可互相复制** - 规则文件可以在不同AI工具间通用
- ✅ **一致性验证** - `comprehensive-test-report.bat`确保持续一致

### 📋 项目核心功能
本项目会为你的开发环境安装以下组件：

1. **🤖 AI助手规则** - 让AI更懂前端开发，提供专业的UI/UX建议
2. **🔧 MCP工具链** - 5个强大的工具，让AI能够直接操作文件、记忆、GitHub等
3. **📚 智能反馈系统** - AI会主动询问需求，提供个性化建议
4. **🎯 多AI工具支持** - 同时支持Augment、Cursor、Claude Code、Trae AI
5. **🔄 统一规则创建** - 确保所有AI工具功能完全一致

### 🎯 你将获得什么能力？
前端规则是专门为 Vue/React/TypeScript 开发优化的 AI 助手规则，包含：

- 🎨 **UI 设计模式** - 界面和交互设计
- ⚡ **组件开发模式** - Vue/React 组件实现
- 🔧 **工程化模式** - 构建配置和工具链
- 🧪 **测试模式** - 单元测试和 E2E 测试
- 🚀 **优化模式** - 性能和 SEO 优化

## 📁 第一步：安装前端规则

> **💡 快速安装**: 参考 [README.md](../README.md) 的快速开始部分
>
> **📚 详细安装**: 参考 [傻瓜式安装指南](../install-scripts/INSTALL-GUIDE.md)
>
> **🎯 安装命令**: 
> ```cmd
> # 注意：如果规则目录在非C盘，需要先切换盘符
> E:                                    # 先切换到E盘（根据你的实际盘符）
> cd "你的rules-2.3.3-optimized目录路径"
> install-scripts\install-ultra.bat ..\你的项目目录 frontend
> ```

**💡 单工具安装**: 如需安装特定AI工具，请参考 [USAGE.md](../USAGE.md) 中的单工具安装选项。

## 🔧 第二步：环境配置

> **📋 环境要求**: 请先完成基础环境配置，确保Node.js和npm已正确安装

### ✅ 环境检查

```bash
# 检查必需环境
node --version  # 应显示 ≥16.0.0
npm --version   # 应显示 ≥8.0.0
```

**环境状态**:
- ✅ **已就绪**: 版本符合要求，可以继续前端开发配置
- ❌ **需要配置**: 请先完成 [环境配置指南](../docs/ENVIRONMENT-SETUP.md)

### 🛠️ 前端专用工具配置

#### VS Code（推荐）
1. 下载：https://code.visualstudio.com/
2. 安装推荐插件：
   - Vue Language Features (Volar)
   - TypeScript Vue Plugin (Volar)
   - ESLint
   - Prettier
   - Auto Rename Tag
   - Bracket Pair Colorizer

#### WebStorm
- 专业的JavaScript IDE
- 内置Vue、React支持
- 强大的调试功能

### 📦 包管理器优化

#### npm镜像配置（提升下载速度）
```bash
# 设置淘宝镜像
npm config set registry https://registry.npmmirror.com

# 验证配置
npm config get registry
```

#### yarn（推荐用于大型项目）
```bash
# 安装yarn
npm install -g yarn

# 验证安装
yarn --version
```

#### pnpm（高性能选择）
```bash
# 安装pnpm
npm install -g pnpm

# 验证安装
pnpm --version
```

## 🔧 第三步：MCP工具配置（可选）

如果你想使用完整的智能反馈功能，需要配置MCP工具：

### **3.1 一键自动安装（推荐）**

> **⚠️ 重要提醒**：使用MCP工具安装脚本前，建议先阅读 **[📋 安装脚本使用说明](../mcp-scripts/安装脚本使用说明.md)** 了解详细的安装方法和注意事项。

**使用自动安装脚本：**
```bash
# 推荐方法：双击运行（最简单）
双击运行: mcp-scripts/run-powershell-installer.bat

# 或者手动在PowerShell中执行
powershell -ExecutionPolicy Bypass -File "install-mcp-tools-enhanced-final.ps1的绝对路径"
```

**📚 详细配置指南**：如需更详细的MCP配置说明，请参考 [MCP快速入门指南](../docs/MCP-QUICK-START-GUIDE.md) 或 [MCP详细配置指南](../docs/MCP-DETAILED-CONFIG-GUIDE.md)

> **🚨 安装后重要**：执行MCP安装脚本后，会在MCP-Tools文件夹下自动生成 `mcp-config.json` 配置文件，然后**强烈建议**完整阅读 **[📋 MCP工具详细配置指南](../docs/MCP-DETAILED-CONFIG-GUIDE.md)** 以确保MCP功能正常使用！生成的配置文件是模板，需要根据你的实际情况修改！

**脚本功能：**
- ✅ 自动检测系统环境
- ✅ 自动安装5个核心MCP工具
- ✅ 生成基础配置文件（**注意：是模板，需要修改**）
- ✅ 验证安装结果
- ✅ 提供详细的安装进度和结果报告

### **3.2 手动安装（备选）**

如果自动脚本无法使用，可以手动安装：

```bash
# 创建MCP工具目录
mkdir C:\MCP-Tools
cd C:\MCP-Tools

# 初始化项目
npm init -y

# 安装Node.js MCP工具（本地安装，路径清晰）
npm install @modelcontextprotocol/server-filesystem
npm install @modelcontextprotocol/server-memory
npm install @modelcontextprotocol/server-github
npm install @modelcontextprotocol/server-everything

# 安装Python MCP工具
pip install uv
# mcp-feedback-enhanced 通过 uvx 运行，无需预安装
```

### **3.3 配置文件**

**⚠️ 重要提醒：** 下面的配置文件是**模板**，你需要根据自己的实际情况修改，否则可能无法正常工作！

创建 `mcp-config.json`：
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "C:\\your-frontend-projects"
      ],
      "env": {}
    },
    "memory": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-memory"
      ],
      "env": {}
    },
    "github": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_github_token_here"
      }
    },
    "everything": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-everything"
      ],
      "env": {}
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": [
        "mcp-feedback-enhanced@latest"
      ],
      "env": {
        "PYTHONUNBUFFERED": "1",
        "MCP_FEEDBACK_TIMEOUT": "3600",
        "MCP_FEEDBACK_MAX_SIZE": "10485760",
        "MCP_WINDOW_MODE": "desktop",
        "MCP_NO_BROWSER": "true",
        "MCP_DESKTOP_MODE": "true"
      },
      "autoApprove": ["interactive_feedback"]
    }
  }
}
```

**🚨 需要修改的内容：**
1. **前端项目路径**：将 `C:\\your-frontend-projects` 改为实际路径
2. **GitHub Token**：将 `your_github_token_here` 改为真实Token

**📂 前端项目路径示例：**
```json
// Vue项目
"D:\\前端\\Vue3项目"

// React项目
"E:\\React\\我的应用"

// 学习项目
"C:\\Users\\用户名\\Desktop\\前端学习"

// 工作项目
"F:\\work\\frontend-projects"
```

**📝 如何修改配置文件：**

**步骤 1：创建配置文件**
1. 在你的MCP工具安装目录下创建新文件
2. 文件名：`mcp-config.json`
3. 复制上面的模板内容到文件中

**步骤 2：修改前端项目路径**
1. 找到 `"C:\\your-frontend-projects"` 这一行
2. 替换为你的实际前端项目路径
3. 注意使用双反斜杠：`"D:\\前端\\项目"`

**步骤 3：修改 GitHub Token**
1. 找到 `"your_github_token_here"` 这一行
2. 替换为你的实际 GitHub Token
3. 保持双引号格式

**✅ 配置完成检查清单：**
- [ ] 前端项目路径已改为实际项目路径
- [ ] GitHub Token 已替换为真实 Token
- [ ] 所有路径使用双反斜杠格式
- [ ] JSON 格式正确（逗号、括号完整）
- [ ] 文件已保存为 `mcp-config.json`

## 🚀 第四步：开始使用

### **4.1 基本命令**
```bash
# 启动前端开发工作流
/frontend-dev

# 创建新组件
/component

# UI设计和样式开发
/ui-design

# 运行测试
/test-frontend

# 构建优化
/build-frontend
```

### **4.2 模式切换**
```bash
# 手动切换模式
/ui设计      # UI设计模式
/组件开发    # 组件开发模式
/工程化      # 工程化模式
/测试        # 测试模式
/优化        # 优化模式
```

### **4.3 前端专用配置模式**
```bash
# 框架优先配置
/设置Vue优先模式        # 优先使用 Vue 3 技术栈
/设置React优先模式      # 优先使用 React 18+ 技术栈

# 开发配置
/设置TypeScript严格模式 # 启用最严格的类型检查
/设置性能优化模式       # 自动应用前端性能优化建议
```

### **4.4 智能反馈**
当遇到以下情况时，AI会自动请求反馈：
- 🔍 **需求不明确** - 描述模糊时
- 🎯 **重大决策** - 技术栈选择时
- ✅ **方案完成** - 设计完成需确认时
- 🎉 **执行完成** - 代码完成需验收时

## 📋 第五步：实际使用示例

### **示例1：创建Vue 3项目**
```
用户：帮我创建一个Vue 3的博客项目

AI响应：[模式：理解] [角色：需求分析师]
我来帮你创建Vue 3博客项目。让我先了解一些细节...

[触发反馈机制，询问具体需求]
```

### **示例2：组件开发**
```
用户：/component 创建一个用户卡片组件

AI响应：[模式：组件开发] [角色：前端开发工程师]
我来帮你创建用户卡片组件...

[自动生成Vue 3组件代码，包含TypeScript类型定义]
```

### **示例3：性能优化**
```
用户：/优化 我的应用加载很慢

AI响应：[模式：优化] [角色：前端性能工程师]
我来分析和优化你的应用性能...

[分析bundle大小，提供优化建议]
```

## 🛠️ 第六步：高级配置

### **6.1 反馈频率控制**
```bash
# 反馈频率控制
/设置详细模式    # 启用所有反馈点，完整工作流
/设置标准模式    # 关键决策点反馈（默认）
/设置静默模式    # 仅错误时反馈，适合熟练用户
```

### **6.2 工作流配置**
```bash
# 工作流配置
/设置严格模式    # 严格按顺序执行，不允许跳过
/设置灵活模式    # 允许模式跳转和流程调整（默认）
/设置快捷模式    # 简化某些步骤，提高效率
```

### **6.3 质量标准配置**
```bash
# 质量标准配置
/设置企业级标准  # 最高质量要求，完整测试
/设置标准级别    # 平衡质量和效率（默认）
/设置原型级别    # 快速验证，降低质量要求
```

### **6.2 项目特定配置**
在项目根目录创建 `.augment-config.json`：
```json
{
  "frontend": {
    "framework": "vue3",
    "ui": "element-plus",
    "state": "pinia",
    "build": "vite"
  },
  "feedback": {
    "timeout": 3600,
    "autoSave": true
  }
}
```

## ✅ 第七步：验证配置

### **7.1 功能测试**
```bash
# 测试基本功能
/frontend-dev

# 测试反馈机制
/feedback

# 测试模式切换
/ui设计
```

### **7.2 检查清单**
- [ ] Node.js环境正确安装
- [ ] 规则文件正确放置
- [ ] MCP工具配置完成（如使用）
- [ ] 基本命令可以正常使用
- [ ] 反馈机制正常工作
- [ ] 模式切换功能正常

## 🎉 完成！

恭喜！你已经成功配置了前端开发 AI 助手规则。现在可以享受高效的前端开发体验了！

## 📚 更多资源

- **详细文档**：查看 `docs/MCP-QUICK-START-GUIDE.md` 和 `docs/MCP-DETAILED-CONFIG-GUIDE.md`
- **项目规则**：浏览 `project-rules/` 目录
- **全局规则**：参考 `global-rules/` 目录
- **问题反馈**：遇到问题请及时反馈

## 📋 版本信息

详细版本信息请参考 [README.md](../README.md)

### 🔥 **重大改进**
- ✅ **统一规则创建逻辑** - 所有AI工具使用相同的规则内容
- ✅ **规则一致性保证** - 四个AI工具功能完全一致
- ✅ **自动目录创建** - 解决路径不存在问题
- ✅ **验证工具** - `comprehensive-test-report.bat`确保一致性

### 👨‍💻 作者信息
- **博客ID**：m0_73635308
- **联系邮箱**：3553952458@qq.com

