# 📋 MCP工具详细配置指南 v2.5.1

> **🎯 新手必读**: 如果您还不了解MCP工具的价值和作用，请先阅读 **[🎯 什么是MCP工具？为什么要使用它们？](MCP-TOOLS-INTRODUCTION.md)**
>
> **🎯 目标**：手把手教你正确配置MCP工具，避免常见错误，确保100%可用
>
> **🚀 Phase 3升级**: 新增8个AI智能规则，完整的智能化规则生态系统
>
> **📅 更新日期**: 2025年9月27日

## 📖 概述

本指南专门解决MCP配置中的常见问题，提供详细的配置步骤和故障排除方案。

**🎯 适合人群：**
- ✅ **自动配置失败用户** - 脚本安装失败，需要手动配置
- ✅ **高级用户** - 需要自定义配置和企业级部署
- ✅ **多项目用户** - 需要管理多个项目的不同配置
- ✅ **故障排除用户** - MCP工具无法正常工作，需要诊断

**📋 配置方式对比：**

| 配置方式 | 适用人群 | 时间 | 难度 | 自定义程度 |
|----------|----------|------|------|------------|
| **自动配置** | 新手、快速体验 | 3-5分钟 | ⭐ 简单 | 🔧 标准配置 |
| **手动配置** | 高级用户、企业级 | 10-15分钟 | ⭐⭐⭐ 复杂 | 🔧🔧🔧 完全自定义 |

> **💡 建议**：
> - 新手用户建议先尝试 [MCP快速入门指南](MCP-QUICK-START-GUIDE.md) 中的自动配置方式
> - **使用脚本安装前，建议先阅读** **[📋 安装脚本使用说明](../mcp-scripts/安装脚本使用说明.md)**

**🚀 快速开始：**
- 📝 **自动生成配置：** 使用MCP安装脚本会在MCP-Tools文件夹下自动生成 `mcp-config.json` 配置文件
- 🔧 **配置失败？** 跳转到 [故障排除部分](#第五步常见问题解决)
- 💡 **使用npx：** 现在使用npx命令，无需复杂的路径配置

## 🚨 重要提醒

**配置文件是模板，需要修改！**
- ❌ 直接复制粘贴模板 → 无法正常工作
- ✅ 根据实际情况修改项目路径和Token → 100%成功
- 💡 **好消息**：使用npx后，无需配置复杂的MCP工具路径

## 📁 第一步：确认MCP工具安装

### **1.1 使用npx简化配置**

**🎉 好消息！** 现在使用npx命令，无需复杂的路径配置：

- ✅ **npx自动查找**：npx会自动找到已安装的MCP工具
- ✅ **无需路径配置**：不用手动指定复杂的node_modules路径
- ✅ **简化维护**：工具更新时配置无需修改

**验证MCP工具是否已安装：**
```bash
# 检查Node.js MCP工具（应该显示版本信息）
npx @modelcontextprotocol/server-filesystem --version
npx @modelcontextprotocol/server-memory --version
npx @modelcontextprotocol/server-github --version
npx @modelcontextprotocol/server-everything --version

# 检查Python MCP工具
uvx mcp-feedback-enhanced@latest version
```
提示：server-memory 为可选工具。若未安装或不需要，可跳过其版本检查（Recorder 优先）。

**如果MCP工具未安装，请先安装：**
```bash
# 使用自动安装脚本（推荐）
.\mcp-scripts\run-powershell-installer.bat

# 或手动安装
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-memory  # 可选
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-everything
pip install uv  # 用于Python工具
```

### **1.2 项目路径配置**

**💡 重要说明**：使用npx后，只需要配置项目路径，无需复杂的MCP工具路径配置。

### **1.2 找到你的项目路径**

**🎯 为什么需要项目路径？**
项目路径是告诉MCP工具你的代码文件在哪里，这样AI助手就能：
- 📁 **读取你的代码文件** - 了解项目结构和现有代码
- ✏️ **修改和创建文件** - 帮你写代码、修复bug、创建新文件
- 🔍 **分析项目结构** - 理解你的项目架构，提供更准确的建议
- 🚀 **执行项目操作** - 运行测试、构建项目等

**⚠️ 重要提醒：**
- 这个路径应该是**你实际项目的根目录**
- 不是随便一个文件夹，而是包含你代码的文件夹
- 比如包含 `package.json`、`src/`、`README.md` 等文件的文件夹

---

#### **🔍 保姆级找路径教程**

**方法1：文件资源管理器（最简单，推荐新手）**

**步骤详解：**
1. **打开你的项目文件夹**
   - 双击桌面上的项目文件夹图标
   - 或者从"此电脑"一层层点击进入项目文件夹

2. **找到地址栏**
   - 地址栏就是窗口顶部显示路径的地方
   - 看起来像这样：`> 此电脑 > D盘 > 前端项目 > 我的Vue项目`

3. **点击地址栏**
   - 用鼠标点击地址栏的任意位置
   - 地址栏会变成可编辑的文本框
   - 显示完整路径，如：`D:\前端项目\我的Vue项目`

4. **复制路径**
   - 按 `Ctrl + A` 全选路径
   - 按 `Ctrl + C` 复制路径
   - 现在路径已经复制到剪贴板了

**📸 视觉提示：**
```
正确的项目文件夹应该包含这些文件：
📁 我的Vue项目/
  ├── 📄 package.json      ← 有这个文件说明是正确的项目根目录
  ├── 📁 src/              ← 源代码文件夹
  ├── 📁 public/           ← 公共资源文件夹
  ├── 📄 README.md         ← 项目说明文件
  └── 📄 vite.config.js    ← 配置文件
```

---

**方法2：右键菜单（适合桌面有项目文件夹的情况）**

**步骤详解：**
1. **找到项目文件夹**
   - 在桌面或文件管理器中找到你的项目文件夹
   - 注意：是文件夹本身，不是文件夹里面的文件

2. **右键点击文件夹**
   - 在项目文件夹图标上点击鼠标右键
   - 会弹出一个菜单

3. **选择"属性"**
   - 在弹出的菜单中点击"属性"（通常在菜单最底部）
   - 会打开一个属性对话框

4. **查看位置**
   - 在属性对话框中找到"位置"或"路径"
   - 完整路径就显示在那里
   - 选中路径文本，按 `Ctrl + C` 复制

---

**方法3：命令行（适合熟悉命令行的用户）**

**步骤详解：**
1. **打开命令提示符**
   - 按 `Win + R`，输入 `cmd`，按回车
   - 或者按 `Win + X`，选择"命令提示符"

2. **进入项目目录**
   ```bash
   # 如果项目在D盘，先切换到D盘
   D:

   # 然后进入项目文件夹（替换为你的实际路径）
   cd "前端项目\我的Vue项目"
   ```

3. **显示当前路径**
   ```bash
   # 显示当前完整路径
   echo %cd%

   # 或者使用这个命令
   cd
   ```

4. **复制路径**
   - 选中显示的路径文本
   - 按 `Ctrl + C` 复制

---

**方法4：从IDE/编辑器获取（最准确）**

如果你已经在VSCode、WebStorm等编辑器中打开了项目：

**VSCode：**
1. 在VSCode中打开你的项目
2. 右键点击左侧文件树的根文件夹
3. 选择"复制路径"或"Copy Path"

**WebStorm/IntelliJ：**
1. 右键点击项目根目录
2. 选择"Copy Path/Reference"
3. 选择"Absolute Path"

---

#### **🚨 常见错误和解决方案**

**❌ 错误1：路径包含中文但显示乱码**
```bash
# 错误示例
D:\????\????

# 解决方案：使用英文路径或确保编码正确
D:\Projects\MyVueApp  # 推荐使用英文路径
```

**❌ 错误2：选择了错误的文件夹**
```bash
# 错误：选择了src文件夹
D:\前端项目\我的Vue项目\src

# 正确：应该选择项目根目录
D:\前端项目\我的Vue项目
```

**❌ 错误3：路径格式不正确**
```bash
# 错误：使用了正斜杠
D:/前端项目/我的Vue项目

# 正确：Windows使用反斜杠，且在JSON中需要双反斜杠
D:\\前端项目\\我的Vue项目
```

#### **✅ 验证路径是否正确**

拿到路径后，验证一下是否正确：

1. **打开文件管理器**
2. **粘贴路径到地址栏**（按 `Ctrl + V`）
3. **按回车**
4. **检查是否能看到项目文件**
   - 应该能看到 `package.json`、`src/` 等项目文件
   - 如果看不到，说明路径不对

#### **📋 路径示例参考**

**常见的正确项目路径格式：**
```bash
# Vue项目
D:\前端项目\my-vue-app

# React项目
C:\Users\用户名\Desktop\react-project

# Node.js后端项目
E:\后端开发\api-server

# 学习项目
C:\学习\前端练习\todo-app

# 工作项目
F:\work\company-website
```

**🎯 记住：** 找到的路径稍后会用在MCP配置文件中，让AI助手能够访问和操作你的项目文件！

## 📝 第二步：创建配置文件

### **2.1 单项目配置（推荐新手）**

**适用场景：** 只有一个主要项目需要AI助手

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "D:\\我的项目"
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
    // 提示：Memory（server-memory）为可选，如不需要可删除该条目（Recorder 优先）。
    "github": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
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
      }
    }
  }
}
```

**🔧 需要修改的地方：**
1. `D:\\我的项目` → 你的实际项目路径
2. `ghp_xxxxxxxxxxxxxxxxxxxx` → 你的GitHub Personal Access Token

**💡 重要说明：**
- 使用 `npx` 命令会自动查找全局安装的MCP工具，无需指定完整路径
- 这与自动化安装脚本生成的配置文件格式完全一致
- 如果你使用了自动化脚本安装，生成的配置文件就是这种格式

### **2.2 多项目配置（推荐高级用户）**

**适用场景：** 有多个项目需要分别管理

```json
{
  "mcpServers": {
    "前端项目": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "D:\\前端\\Vue项目"
      ],
      "env": {}
    },
    "后端项目": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "E:\\后端\\SpringBoot"
      ],
      "env": {}
    },
    "学习项目": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "C:\\Users\\用户名\\Desktop\\学习"
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
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
      }
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
      }
    }
  }
}
```

## 🔧 第三步：修改配置文件

### **3.1 修改步骤详解**

**步骤1：创建文件**
1. 在MCP工具目录下创建 `mcp-config.json`
2. 复制上面的模板内容

**步骤2：修改项目路径**
```json
// 找到这样的行：
"C:\\your-frontend-projects"

// 替换为你的实际项目路径：
"D:\\我的前端项目"
```

**步骤3：修改项目路径**
```json
// 单项目：
"D:\\我的项目"

// 多项目：
"D:\\前端\\Vue项目"
"E:\\后端\\SpringBoot"
```

**步骤4：修改GitHub Token**
```json
// 替换这一行：
"GITHUB_PERSONAL_ACCESS_TOKEN": "your_github_token_here"

// 改为：
"GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
```

### **3.2 路径格式规范**

**✅ 正确格式：**
```json
"C:\\Users\\张三\\Desktop\\项目"    // 双反斜杠
"D:/前端/Vue项目"                  // 正斜杠
"E:\\work\\frontend"              // 双反斜杠
```

**❌ 错误格式：**
```json
"C:\Users\张三\Desktop\项目"       // 单反斜杠（会出错）
"D:\前端\Vue项目"                  // 单反斜杠（会出错）
```

## ✅ 第四步：验证配置

### **4.1 配置检查清单**

**文件检查：**
- [ ] 文件名是 `mcp-config.json`
- [ ] 文件位置在MCP工具目录下
- [ ] JSON格式正确（括号、逗号完整）

**路径检查：**
- [ ] 项目路径存在且可访问
- [ ] 所有路径使用正确格式

**Token检查：**
- [ ] GitHub Token已替换
- [ ] Token格式正确（ghp_开头）
- [ ] Token权限包含repo、user、workflow

### **4.2 测试配置**

**方法1：启动AI工具**
1. 重启你的AI工具（Claude、Cursor等）
2. 查看是否能正常加载MCP工具
3. 测试文件读写功能

**方法2：检查日志**
1. 查看AI工具的错误日志
2. 确认没有MCP相关错误
3. 验证所有工具正常加载

## 🐛 第五步：常见问题解决

### **5.0 MCP工具未安装？**

**问题：** MCP工具未正确安装或无法找到
**解决方案：**
```bash
# 🚀 使用自动安装脚本（推荐）
.\mcp-scripts\run-powershell-installer.bat

# 或验证现有安装
npx @modelcontextprotocol/server-filesystem --version
uvx mcp-feedback-enhanced@latest version
```

**使用npx的优势：**
- ✅ 自动查找已安装的工具
- ✅ 无需配置复杂路径
- ✅ 简化维护和更新

### **5.0.1 mcp-feedback-enhanced 安装卡住问题**

**🚨 常见问题：** 脚本在安装 `mcp-feedback-enhanced` 时卡住，其他3-4个MCP工具已安装成功（server-memory 可选）

**问题现象：**
- 前3-4个MCP工具（filesystem、github、everything；server-memory 如已安装）安装成功
- 脚本在最后一个 `mcp-feedback-enhanced` 处卡住不动
- 脚本暂停导致 `mcp-config.json` 配置文件未生成

**🔧 解决方案：**

**步骤1：手动安装 mcp-feedback-enhanced**
```bash
# 暂停脚本（Ctrl+C），然后执行以下命令
uvx --index-url https://pypi.tuna.tsinghua.edu.cn/simple mcp-feedback-enhanced@latest
```

**步骤2：手动创建配置文件**
由于脚本暂停，需要手动创建 `mcp-config.json` 配置文件。

1. **找到MCP工具目录**（通常在用户目录下的 `MCP-Tools` 文件夹）
2. **创建 `mcp-config.json` 文件**
3. **复制以下配置内容**：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "你的项目路径"
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
        "GITHUB_PERSONAL_ACCESS_TOKEN": "你的GitHub_Token"
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
      }
    }
  }
}
```

**步骤3：修改配置文件**
- 将 `"你的项目路径"` 替换为实际项目路径（如：`"D:\\我的项目"`）
- 将 `"你的GitHub_Token"` 替换为实际的GitHub Personal Access Token

**💡 为什么会卡住？**
- 网络连接问题导致Python包下载缓慢
- 使用清华大学镜像源可以显著提高下载速度
- `uvx --index-url https://pypi.tuna.tsinghua.edu.cn/simple` 指定使用国内镜像源

**✅ 验证安装成功：**
```bash
# 验证所有MCP工具是否正常工作（server-memory 如已安装）
npx @modelcontextprotocol/server-filesystem --version
npx @modelcontextprotocol/server-memory --version
npx @modelcontextprotocol/server-github --version
npx @modelcontextprotocol/server-everything --version
uvx mcp-feedback-enhanced@latest version
```

### **5.1 路径问题**

**问题：** `cannot find module` 或路径相关错误
**解决方案：**
- 确保项目路径中没有中文字符（如果可能）
- 使用双反斜杠：`"C:\\your-projects\\..."`
- 或使用正斜杠：`"C:/your-projects/..."`
- 检查项目路径是否真实存在

### **5.2 JSON格式错误**

**问题：** `Unexpected token` 或 `JSON parse error`
**解决方案：**
- 检查所有括号是否匹配
- 确保每个配置项后有逗号（最后一项除外）
- 使用在线JSON验证器检查格式
- 注意中文引号和英文引号的区别

### **5.3 GitHub Token问题**

**问题：** GitHub相关功能无法使用
**解决方案：**
- 重新生成GitHub Personal Access Token
- 确保Token权限包含：`repo`, `user`, `workflow`
- 检查Token格式（应该以ghp_开头）
- 确认Token没有过期

## 📚 附录：完整示例

### **A.1 通用开发者配置示例**
```json
{
  "mcpServers": {
    "vue项目": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "D:\\前端\\Vue3项目"
      ],
      "env": {}
    },
    "react项目": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "D:\\前端\\React项目"
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
    // 提示：Memory（server-memory）为可选，如不需要可删除该条目（Recorder 优先）。
    "github": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
      }
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
      }
    }
  }
}
```

---

**🎉 配置完成！** 现在你的MCP工具应该可以正常工作了。如果还有问题，请查看 [MCP故障排除指南](MCP-TROUBLESHOOTING-GUIDE.md)。
