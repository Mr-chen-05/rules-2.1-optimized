# 🚀 MCP工具快速入门指南 - 5分钟上手

> **🎯 目标**: 让完全新手在5分钟内成功配置并使用MCP工具  
> **📱 适用**: Augment、Cursor、Claude Code、Trae AI等AI开发工具  
> **⏱️ 预计时间**: 5-10分钟  

## 📖 什么是MCP？

**MCP (Model Context Protocol)** 是连接AI助手与外部工具的标准协议，让AI能够：
- 📁 操作文件系统（读写文件、创建目录）
- 🧠 管理记忆（保存和检索信息）
- 🐙 集成GitHub（创建仓库、提交代码）
- 💬 获取用户反馈（交互式确认和输入）
- 🔧 执行各种工具命令

> **📚 详细了解**: 查看 [MCP工具详细功能参考](MCP-TOOLS-REFERENCE.md) 了解每个工具的具体功能、使用场景和最佳实践
>
> **💡 新手建议**: 建议先完成本快速入门指南，成功配置MCP工具后再深入学习详细功能

## 🎯 一键配置（推荐方式）

### 步骤1：检查和配置环境

#### 🔍 环境检查
```powershell
# 检查Node.js（必需）
node --version
# 应该显示 v16.0.0 或更高版本

# 检查Python（必需）
python --version
# 应该显示 Python 3.8 或更高版本
```

#### 📦 Node.js 安装选项

**方式1：直接安装（推荐新手）**
- 🔗 **下载地址**：https://nodejs.org
- 📝 **选择版本**：点击左侧绿色按钮下载 LTS 版本

**方式2：使用 NVM 管理（推荐开发者）**
- ✅ **优点**：可以安装和切换多个 Node.js 版本
- 🎯 **适合人群**：需要在不同项目间切换 Node.js 版本的开发者

<details>
<summary>🚀 <strong>NVM 详细安装教程</strong>（点击展开）</summary>

**⚠️ 重要：安装 NVM 前必须先卸载已有 Node.js！**

**🗑️ 卸载已有 Node.js：**
1. **检查是否已安装**：
   ```bash
   node --version
   ```
   - ✅ 显示"不是内部或外部命令" = 没安装，可直接安装 NVM
   - ❌ 显示版本号 = 已安装，需要先卸载

2. **卸载步骤**：
   - 按`Win + R`，输入`appwiz.cpl`，按回车
   - 找到"Node.js" → 右键 → 卸载
   - 清理残留：删除 `C:\Users\%USERNAME%\AppData\Roaming\npm` 目录

**🔽 NVM 安装步骤：**
1. **下载**：访问 https://github.com/coreybutler/nvm-windows/releases
2. **安装**：右键以管理员身份运行 `nvm-setup.exe`
3. **验证**：打开新的命令提示符，输入 `nvm version`
4. **安装Node.js**：
   ```bash
   # 安装最新LTS版本
   nvm install 18.19.0
   nvm use 18.19.0

   # 验证安装
   node --version
   npm --version
   ```

**🎯 NVM 常用命令：**
```bash
nvm list              # 查看已安装版本
nvm list available    # 查看可安装版本
nvm install 18.19.0   # 安装指定版本
nvm use 18.19.0       # 切换到指定版本
```

</details>

#### 🚀 npm 镜像源配置（解决安装慢问题）

如果你在中国大陆，强烈建议配置npm镜像源以提高MCP工具安装速度：

<details>
<summary>📦 <strong>npm镜像源配置教程</strong>（点击展开）</summary>

**🔥 方法 1：使用小满 zs 工具包（推荐）**

感谢：本教程基于哔哩哔哩小满 zs 的工具包，原创教程来源于小满 zs。

**步骤 1：安装小满 zs 工具包**
```bash
# 全局安装小满zs工具包
npm i xmzs -g
```

**步骤 2：使用 mmp 命令管理镜像源**
```bash
# 安装完成后，会生成一个mmp命令
mmp
```

**步骤 3：选择淘宝镜像源**
运行 `mmp` 命令后，会显示镜像源列表：

- 使用方向键选择 **taobao（淘宝镜像）**
- 按回车键确认选择

**步骤 4：验证切换成功**
```bash
# 查看当前镜像源
npm config get registry

# 应该显示：https://registry.npmmirror.com/
```

**🔧 方法 2：手动切换镜像源**

**切换到淘宝镜像：**
```bash
npm config set registry https://registry.npmmirror.com
```

**恢复官方镜像：**
```bash
npm config set registry https://registry.npmjs.org/
```

</details>

### 步骤2：安装MCP工具

#### 🚀 一键安装脚本（推荐）

我们为您准备了自动安装脚本：

```bash
# 创建MCP工具目录
mkdir C:\MCP-Tools
cd C:\MCP-Tools

# 初始化项目
npm init -y

# 安装所有MCP工具
npm install @modelcontextprotocol/server-filesystem
npm install @modelcontextprotocol/server-memory
npm install @modelcontextprotocol/server-github
npm install @modelcontextprotocol/server-everything

# 安装Python MCP工具
pip install uv
```

#### 🔧 手动安装（备选）

**安装Node.js MCP工具：**
```bash
# 全局安装（推荐）
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-everything

# 或者安装到指定目录
mkdir C:\MCP-Tools
cd C:\MCP-Tools
npm init -y
npm install @modelcontextprotocol/server-filesystem
npm install @modelcontextprotocol/server-memory
npm install @modelcontextprotocol/server-github
npm install @modelcontextprotocol/server-everything
```

**安装Python MCP工具：**
```bash
# 安装uv工具
pip install uv

# 安装反馈增强工具
uvx mcp-feedback-enhanced@latest
```

### 步骤3：创建配置文件

#### 📁 找到MCP工具安装路径

**🚀 使用自动查找脚本（推荐）：**
```bash
# 运行自动查找脚本
.\find-mcp-tools.bat
```

**🔧 手动查找：**
```bash
# 查看npm全局安装路径
npm root -g

# 或者检查常见位置
dir "C:\MCP-Tools\node_modules\@modelcontextprotocol" 2>nul
dir "%APPDATA%\npm\node_modules\@modelcontextprotocol" 2>nul
```

#### 📝 创建配置文件

**创建文件：** 在MCP工具目录下创建 `mcp-config.json`

**🔥 完整配置模板（推荐）：**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "node",
      "args": [
        "C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\server-filesystem\\dist\\index.js",
        "D:\\你的项目路径"
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

#### 🔧 必须修改的配置项

**1. MCP工具路径：**
```json
// 将 C:\\MCP-Tools 替换为你的实际安装路径
"C:\\MCP-Tools\\node_modules\\@modelcontextprotocol\\..."
```

**2. 项目路径：**
```json
// 将 D:\\你的项目路径 替换为你的实际项目路径
"D:\\你的项目路径"
```

**3. GitHub Token：**
```json
// 将 ghp_xxxxxxxxxxxxxxxxxxxx 替换为你的GitHub Token
"GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
```

### 步骤4：配置AI工具

#### 🔧 Cursor 配置

1. **打开Cursor设置**
   - 按 `Ctrl + ,` 打开设置
   - 搜索 "MCP" 或 "Model Context Protocol"

2. **添加配置文件路径**
   - 找到 "MCP Config Path" 设置项
   - 输入你的配置文件路径：`C:\MCP-Tools\mcp-config.json`

3. **重启Cursor**
   - 完全关闭Cursor
   - 重新打开Cursor

#### 🔧 Claude Code 配置

1. **打开Claude Code设置**
   - 点击左下角设置图标
   - 选择 "Preferences"

2. **配置MCP**
   - 找到 "MCP Configuration" 部分
   - 输入配置文件路径：`C:\MCP-Tools\mcp-config.json`

3. **重启Claude Code**
   - 关闭并重新打开Claude Code

#### 🔧 Augment 配置

1. **打开Augment设置**
   - 点击右上角设置图标
   - 选择 "Settings"

2. **配置MCP**
   - 找到 "MCP Tools" 设置
   - 输入配置文件路径：`C:\MCP-Tools\mcp-config.json`

3. **重启Augment**
   - 关闭并重新打开Augment

### 步骤5：验证配置

#### ✅ 验证清单

**环境检查：**
- [ ] Node.js 版本 ≥ 16.0.0
- [ ] Python 版本 ≥ 3.8
- [ ] MCP工具已正确安装

**配置文件检查：**
- [ ] 配置文件路径正确
- [ ] JSON格式正确
- [ ] 所有路径已修改为实际路径

**AI工具检查：**
- [ ] AI工具已重启
- [ ] 配置文件路径已设置
- [ ] 没有MCP相关错误

#### 🧪 功能测试

**测试文件系统功能：**
1. 在AI工具中询问："请查看我的项目结构"
2. AI应该能够列出你的项目文件

**测试记忆功能：**
1. 告诉AI："请记住这个信息：测试MCP记忆功能"
2. 稍后询问："你还记得我之前说的什么吗？"
3. AI应该能够回忆起之前的信息

**测试GitHub功能：**
1. 询问："请查看我的GitHub仓库"
2. AI应该能够访问你的GitHub信息

## 🐛 常见问题解决

### 问题1：找不到MCP工具

**解决方案：**
```bash
# 使用自动查找脚本
.\find-mcp-tools.bat

# 或者重新安装
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-github
npm install -g @modelcontextprotocol/server-everything
```

### 问题2：配置文件路径错误

**解决方案：**
1. 确认配置文件路径正确
2. 检查JSON格式是否正确
3. 确保所有路径都已修改为实际路径

### 问题3：AI工具无法加载MCP

**解决方案：**
1. 重启AI工具
2. 检查配置文件路径设置
3. 查看AI工具的错误日志

### 问题4：GitHub功能无法使用

**解决方案：**
1. 检查GitHub Token是否正确
2. 确认Token权限包含：`repo`, `user`, `workflow`
3. 重新生成Token

## 📚 下一步

配置完成后，你可以：

1. **查看详细配置指南**：[MCP详细配置指南](MCP-DETAILED-CONFIG-GUIDE.md)
2. **学习智能使用策略**：[MCP智能使用策略](MCP-INTELLIGENT-USAGE-STRATEGY.md)
3. **解决常见问题**：[MCP故障排除指南](MCP-TROUBLESHOOTING-GUIDE.md)

---

**🎉 恭喜！** 你已经成功配置了MCP工具，现在可以享受更强大的AI助手功能了！
