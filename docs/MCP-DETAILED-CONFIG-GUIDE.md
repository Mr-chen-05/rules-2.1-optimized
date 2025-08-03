# 📋 MCP工具详细配置指南

> **🎯 目标**：手把手教你正确配置MCP工具，避免常见错误，确保100%可用
>
> **📅 更新日期**: 2024年8月3日

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

> **💡 建议**：新手用户建议先尝试 [MCP快速入门指南](MCP-QUICK-START-GUIDE.md) 中的自动配置方式

**🚀 快速开始：**
- 📁 **找不到MCP工具？** 运行 `.\docs\find-mcp-installation-en.bat` 自动查找
- 📋 **配置模板在哪？** 查看 `project-rules/mcp-intelligent-strategy.mdc` 文件获取MCP配置模板
- 🔧 **配置失败？** 跳转到 [故障排除部分](#第五步常见问题解决)

## 🚨 重要提醒

**配置文件是模板，必须修改！**
- ❌ 直接复制粘贴模板 → 100%失败
- ✅ 根据实际情况修改 → 100%成功

## 📁 第一步：确定你的安装路径

### **1.1 找到MCP工具安装路径**

#### **🚀 推荐方法：使用自动查找脚本（最简单）**

我们为您准备了一个自动查找脚本，一键找到所有MCP工具的安装位置：

```bash
# 运行MCP工具查找脚本
.\docs\find-mcp-installation-en.bat
```

**脚本功能：**
- 🔍 自动搜索npm全局包中的MCP工具
- 🔍 检查常见安装位置
- 🔍 查找Python版本的MCP工具
- 📍 显示具体的安装路径
- 💡 提供重新安装建议

---

#### **🔧 手动查找方法（备选）**

**方法1：检查安装目录**
```bash
# 如果你按照教程安装，通常在：
C:\MCP-Tools\

# 检查是否存在以下文件夹：
C:\MCP-Tools\node_modules\@modelcontextprotocol\
```

**方法2：使用命令查找**
```bash
# 在命令行中执行
where node
# 查看Node.js安装路径，MCP工具通常在附近
```

**方法3：全局搜索**
```bash
# 搜索MCP相关文件夹
dir /s /b C:\ | findstr "modelcontextprotocol"
```

#### **🚨 找不到MCP工具？完整解决方案**

<details>
<summary>🔍 <strong>系统性查找MCP工具位置</strong>（点击展开）</summary>

**如果上面的方法都找不到MCP工具，按以下步骤系统性查找：**

**步骤1：全面搜索**
```powershell
# 在PowerShell中执行以下命令
Write-Host "正在搜索MCP工具..." -ForegroundColor Yellow

# 搜索MCP相关文件夹
Write-Host "搜索MCP文件夹..." -ForegroundColor Green
Get-ChildItem -Path C:\ -Recurse -Directory -Name "*modelcontextprotocol*" -ErrorAction SilentlyContinue

# 搜索MCP服务器文件
Write-Host "搜索MCP服务器文件..." -ForegroundColor Green
Get-ChildItem -Path C:\ -Recurse -Name "*server-filesystem*" -ErrorAction SilentlyContinue

# 搜索包含MCP的所有文件夹
Write-Host "搜索包含MCP的文件夹..." -ForegroundColor Green
Get-ChildItem -Path C:\ -Recurse -Directory -Name "*mcp*" -ErrorAction SilentlyContinue
```

**步骤2：检查npm全局包**
```bash
# 查看所有全局安装的包
npm list -g --depth=0

# 查看npm全局安装路径
npm root -g

# 如果看到@modelcontextprotocol相关包，记下路径！
```

**步骤3：检查常见安装位置**
```bash
# 检查用户目录下的npm包
dir "%APPDATA%\npm\node_modules" | findstr "modelcontextprotocol"

# 检查Program Files下的Node.js
dir "C:\Program Files\nodejs\node_modules" | findstr "modelcontextprotocol"

# 检查可能的自定义安装路径
dir "C:\MCP-Tools" 2>nul
dir "C:\tools" | findstr "mcp" 2>nul
```

**步骤4：通过Node.js路径推断**
```bash
# 查看Node.js安装位置
where node
# 输出示例：C:\Program Files\nodejs\node.exe

# 基于Node.js位置查找MCP工具
# 通常在：C:\Program Files\nodejs\node_modules\@modelcontextprotocol\
```

**步骤5：检查其他包管理器**
```bash
# 检查yarn全局包
yarn global list

# 检查pnpm全局包
pnpm list -g

# 检查Python包（某些MCP工具是Python包）
pip list | findstr mcp
```

</details>

<details>
<summary>🔧 <strong>如果完全找不到，重新安装MCP工具</strong>（点击展开）</summary>

**可能的情况：MCP工具没有正确安装**

**重新安装所有MCP工具：**
```bash
# 安装核心MCP服务器
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-everything

# 安装Python MCP工具
pip install uv
# 或者
uvx mcp-feedback-enhanced@latest
```

**验证安装：**

⚠️ **重要说明：** MCP工具分为两种类型，验证方式不同！

**Node.js MCP工具（4个）- 可在文件夹中看到：**
```bash
# 检查安装是否成功
npm list -g --depth=0 | findstr "modelcontextprotocol"

# 查看安装路径
npm root -g

# 检查本地安装（根据你选择的安装路径）
# 默认路径（选项1）
dir "C:\MCP-Tools\node_modules\@modelcontextprotocol"
# D盘路径（选项2）
dir "D:\MCP-Tools\node_modules\@modelcontextprotocol"
# 自定义路径（选项3，替换为你的实际路径）
dir "你的安装路径\node_modules\@modelcontextprotocol"
```

**Python MCP工具（1个）- 无法在文件夹中看到：**
```bash
# 验证mcp-feedback-enhanced（Python包）
uvx mcp-feedback-enhanced@latest version

# 应该显示类似：
# MCP Feedback Enhanced Enhanced v2.6.0
# 作者: Minidoracat
# GitHub: https://github.com/Minidoracat/mcp-feedback-enhanced
```

**📋 完整验证清单：**
- ✅ **4个Node.js包** - 在node_modules文件夹中可见
- ✅ **1个Python包** - 通过uvx命令验证，不在文件夹中
- ✅ **总计5个MCP工具** - 全部安装成功

**安装到指定目录（推荐）：**
```bash
# 创建专门的MCP工具目录
mkdir C:\MCP-Tools
cd C:\MCP-Tools

# 初始化npm项目
npm init -y

# 安装MCP工具到当前目录
npm install @modelcontextprotocol/server-filesystem
npm install @modelcontextprotocol/server-memory
npm install @modelcontextprotocol/server-github
npm install @modelcontextprotocol/server-everything

# 这样MCP工具就安装在：C:\MCP-Tools\node_modules\@modelcontextprotocol\
```

</details>

<details>
<summary>🎯 <strong>一键查找脚本</strong>（点击展开）</summary>

**创建自动查找脚本：**

1. **创建文件** `find-mcp.bat`：
```batch
@echo off
chcp 65001 >nul
echo 🔍 正在查找MCP工具安装位置...
echo.

echo [1/5] 检查npm全局包...
npm list -g --depth=0 | findstr "modelcontextprotocol"
echo.

echo [2/5] 查看npm全局路径...
npm root -g
echo.

echo [3/5] 搜索MCP文件夹...
dir /s /b C:\ | findstr "modelcontextprotocol" 2>nul
echo.

echo [4/5] 检查常见位置...
if exist "%APPDATA%\npm\node_modules\@modelcontextprotocol" (
    echo ✅ 找到：%APPDATA%\npm\node_modules\@modelcontextprotocol
)
if exist "C:\Program Files\nodejs\node_modules\@modelcontextprotocol" (
    echo ✅ 找到：C:\Program Files\nodejs\node_modules\@modelcontextprotocol
)
if exist "C:\MCP-Tools\node_modules\@modelcontextprotocol" (
    echo ✅ 找到：C:\MCP-Tools\node_modules\@modelcontextprotocol
)

echo [5/5] 检查Node.js位置...
where node

echo.
echo 🎉 查找完成！请查看上面的输出结果。
pause
```

2. **运行脚本**：
   - 双击 `find-mcp.bat` 文件
   - 脚本会自动搜索所有可能的MCP工具位置

</details>

### **1.2 找到你的项目路径**

**🎯 为什么需要项目路径？**
项目路径是告诉MCP工具你的代码文件在哪里，这样AI助手就能：
- 📁 **读取你的代码文件** - 了解项目结构和现有代码
- ✏️ **修改和创建文件** - 帮你写代码、修复bug、创建新文件
- 🔍 **分析项目结构** - 理解你的项目架构，提供更准确的建议
- 🚀 **执行项目操作** - 运行测试、构建项目等

**⚠️ 重要提醒：**
- 这个路径必须是**你实际项目的根目录**
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
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "D:\\我的项目"
      ],
      "env": {}
    },
    "memory": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-memory\\dist\\index.js"
      ],
      "env": {}
    },
    "github": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
      }
    },
    "everything": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-everything\\dist\\index.js"
      ],
      "env": {}
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "timeout": 600,
      "env": {
        "MCP_WEB_PORT": "8765",
        "MCP_DESKTOP_MODE": "false",
        "MCP_DEBUG": "false"
      },
      "autoApprove": ["interactive_feedback"]
    }
  }
}
```

**🔧 必须修改的地方：**
1. `C:\\MCP-Tools` → 你的MCP安装路径
2. `D:\\我的项目` → 你的项目路径
3. `ghp_xxxxxxxxxxxxxxxxxxxx` → 你的GitHub Token

### **2.2 多项目配置（推荐高级用户）**

**适用场景：** 有多个项目需要分别管理

```json
{
  "mcpServers": {
    "前端项目": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "D:\\前端\\Vue项目"
      ],
      "env": {}
    },
    "后端项目": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "E:\\后端\\SpringBoot"
      ],
      "env": {}
    },
    "学习项目": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "C:\\Users\\用户名\\Desktop\\学习"
      ],
      "env": {}
    },
    "memory": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-memory\\dist\\index.js"
      ],
      "env": {}
    },
    "github": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
      }
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "timeout": 600,
      "env": {
        "MCP_WEB_PORT": "8765",
        "MCP_DESKTOP_MODE": "false"
      },
      "autoApprove": ["interactive_feedback"]
    }
  }
}
```

## 🔧 第三步：修改配置文件

### **3.1 修改步骤详解**

**步骤1：创建文件**
1. 在MCP工具目录下创建 `mcp-config.json`
2. 复制上面的模板内容

**步骤2：修改MCP工具路径**
```json
// 找到这样的行：
"C:\\MCP-Tools\\node_modules\\..."

// 替换为你的实际路径：
"D:\\MyMCP\\node_modules\\..."
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
- [ ] MCP工具路径存在且正确
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

### **5.0 找不到MCP工具？**

**问题：** 不知道MCP工具安装在哪里，配置路径时无从下手
**解决方案：**
```bash
# 🚀 使用自动查找脚本（推荐）
.\docs\find-mcp-installation-en.bat
```

**脚本会自动：**
- 🔍 搜索npm全局包中的MCP工具
- 🔍 检查Python版本的MCP工具
- 📍 显示具体的安装路径
- 💡 提供重新安装建议

### **5.1 路径问题**

**问题：** `cannot find module` 或路径相关错误
**解决方案：**
- 🚀 **首先运行** `.\docs\find-mcp-installation-en.bat` 确认MCP工具位置
- 确保路径中没有中文字符（如果可能）
- 使用双反斜杠：`"C:\\MCP-Tools\\..."`
- 或使用正斜杠：`"C:/MCP-Tools/..."`
- 检查路径是否真实存在

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

### **A.1 前端开发者配置示例**
```json
{
  "mcpServers": {
    "vue项目": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "D:\\前端\\Vue3项目"
      ],
      "env": {}
    },
    "react项目": {
      "command": "node", 
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "D:\\前端\\React项目"
      ],
      "env": {}
    },
    "memory": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-memory\\dist\\index.js"
      ],
      "env": {}
    },
    "github": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
      }
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "timeout": 600,
      "env": {
        "MCP_WEB_PORT": "8765",
        "MCP_DESKTOP_MODE": "false"
      },
      "autoApprove": ["interactive_feedback"]
    }
  }
}
```

### **A.2 后端开发者配置示例**
```json
{
  "mcpServers": {
    "java项目": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "E:\\Java\\SpringBoot项目"
      ],
      "env": {}
    },
    "python项目": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "E:\\Python\\FastAPI项目"
      ],
      "env": {}
    },
    "memory": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-memory\\dist\\index.js"
      ],
      "env": {}
    },
    "github": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
      }
    },
    "mcp-feedback-enhanced": {
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "timeout": 600,
      "env": {
        "MCP_WEB_PORT": "8765",
        "MCP_DESKTOP_MODE": "false"
      },
      "autoApprove": ["interactive_feedback"]
    }
  }
}
```

---

**🎉 配置完成！** 现在你的MCP工具应该可以正常工作了。如果还有问题，请查看 [MCP故障排除指南](MCP-TROUBLESHOOTING-GUIDE.md)。
