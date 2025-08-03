# MCP工具完整安装指南 v4.1

> **更新日期**: 2024年8月3日
> **适用系统**: Windows 10/11
> **依赖环境**: Node.js 18+, Python 3.8+

## 📋 概述

MCP Tools Enhanced Installer 是一个自动化安装脚本，用于安装5个MCP（Model Context Protocol）工具：

## 🎯 安装脚本选择

项目提供两个安装脚本版本，功能完全相同，仅界面语言不同：

### 📝 版本对比

| 特性 | 英文版 | 中文版 |
|------|--------|--------|
| **文件名** | `install-mcp-tools-enhanced.bat` | `install-mcp-tools-enhanced-final.bat` |
| **界面提示语言** | **纯英文提示** | **中文提示** |
| **安装过程显示** | 英文状态信息 | 中文状态信息 |
| **错误提示** | 英文错误信息 | 中文错误信息 |
| **适用用户** | 开发者、英文用户 | 中文用户、新手 |
| **功能和安装内容** | **完全相同** | **完全相同** |

### 💡 选择建议
- **英文版**：适合习惯英文界面的开发者，提示简洁专业
- **中文版**：适合中文用户和新手，提示友好易懂

> **⚠️ 重要说明**：两个脚本的**核心功能完全相同**，都会：
> - 自动安装5个MCP工具（4个Node.js + 1个Python）
> - 自动生成配置文件模板
> - 自动检测系统环境和依赖
>
> **唯一区别**：安装过程中的提示信息语言不同

### 🔧 安装的工具清单
- **Node.js工具（4个）**：
  - `@modelcontextprotocol/server-filesystem` - 文件系统操作
  - `@modelcontextprotocol/server-memory` - 内存知识图谱
  - `@modelcontextprotocol/server-github` - GitHub集成
  - `@modelcontextprotocol/server-everything` - 综合功能测试
- **Python工具（1个）**：
  - `mcp-feedback-enhanced` - 交互式反馈收集

## ⚙️ 系统要求

### 必需环境
- **Node.js**: ≥ v18.0.0（推荐 v22.15.1+）
- **npm**: ≥ v8.0.0（推荐 v10.9.2+）
- **Python**: ≥ v3.8.0（推荐 v3.12.10+）
- **磁盘空间**: 至少150MB可用空间
- **网络**: 稳定的互联网连接

### 环境验证命令
```bash
# 检查Node.js版本
node --version

# 检查npm版本
npm --version

# 检查Python版本
python --version
```

## 🚀 安装步骤

### 步骤1：准备工作
```powershell
# 1. 打开PowerShell（推荐以管理员身份运行）
# 2. 导航到脚本目录
cd mcp-scripts

# 3. 验证脚本文件存在
dir .\install-mcp-tools-enhanced*.bat
```

### 步骤2：网络优化（可选但推荐）
```bash
# 切换到国内镜像源以提高下载速度
npm config set registry https://registry.npmmirror.com

# 设置超时时间
npm config set timeout 60000
```

### 步骤3：选择并执行安装脚本

**选择英文版本：**
```powershell
.\install-mcp-tools-enhanced.bat
```

**选择中文版本：**
```powershell
.\install-mcp-tools-enhanced-final.bat
```

> **⚠️ 执行提示**：
> - 必须使用 `.\` 前缀执行.bat脚本
> - 确保当前目录在 `mcp-scripts` 文件夹中
> - 如果直接输入脚本名称可能导致"命令未找到"错误

> **🌐 Web界面配置**：
> - 默认配置：`MCP_NO_BROWSER=true`（不自动打开浏览器）
> - 如需启用Web反馈界面，安装完成后手动修改配置文件中的 `MCP_NO_BROWSER=false`
> - Web界面地址：http://localhost:3000

**重要提示**：如果遇到执行策略错误，请运行：
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 📊 安装过程详解

### 阶段1：系统环境检查
脚本自动检测系统环境：
```
[Step 1] System Environment Check
----------------------------------------
[OK] Node.js: v22.15.1
[OK] npm: 10.9.2
[OK] Python: 3.12.10
```

### 阶段2：驱动器扫描
脚本扫描所有可用驱动器：
```
[Step 2] Scanning existing MCP installations...
Available drives:
  C: drive
  D: drive
  E: drive
```

### 阶段3：选择安装位置
```
[Step 3] Choose installation drive...
Please enter drive letter (default D): E
[DEBUG] You selected drive: E
```

**选择建议**：
- 选择有足够空间的驱动器（需要150MB+）
- 避免选择系统盘（C盘）以防权限问题
- 推荐选择：D盘或E盘

### 阶段4：目录创建与初始化
```
[Step 5] Creating installation directory...
[OK] Created directory: E:\MCP-Tools
[OK] Working directory: E:\MCP-Tools
[OK] npm project initialized successfully
```

### 阶段5：工具安装过程
按顺序安装5个工具：

1. **server-filesystem** (1/5)
   ```
   [INFO] Installing server-filesystem...
   added 128 packages in 3s
   [OK] server-filesystem installed successfully
   ```

2. **server-memory** (2/5)
   ```
   [INFO] Installing server-memory...
   added 2 packages in 842ms
   [OK] server-memory installed successfully
   ```

3. **server-github** (3/5)
   ```
   [INFO] Installing server-github...
   added 20 packages in 2s
   [OK] server-github installed successfully
   ```

4. **server-everything** (4/5)
   ```
   [INFO] Installing server-everything...
   added 30 packages in 1s
   [OK] server-everything installed successfully
   ```

5. **mcp-feedback-enhanced** (5/5)
   ```
   [INFO] Installing mcp-feedback-enhanced (Python package)...
   [OK] mcp-feedback-enhanced installed successfully
   ```

## 安装结果验证

### 最终报告
```
================================================
               Installation Report
================================================

MCP Tools installation completed

Final installation path: E:\MCP-Tools
Installed tools count: 5/5

Project files:
  node_modules
  package-lock.json
  package.json
  mcp-config.json
```

### 验证方法

#### 1. Node.js工具验证（4个工具）
在文件管理器中查看：
```
E:\MCP-Tools\node_modules\@modelcontextprotocol\
```
应该包含：
- server-filesystem
- server-memory
- server-github
- server-everything

#### 2. Python工具验证（1个工具）
在命令行中执行：
```bash
uvx mcp-feedback-enhanced@latest version
```
应该显示：`MCP Feedback Enhanced Enhanced v2.6.0`

**重要提示**：mcp-feedback-enhanced是Python包，不会出现在node_modules文件夹中，这是正常的。

## 故障排除

### 如果安装卡住不动
1. **检查网络连接**
2. **切换npm镜像源**：
   ```bash
   npm config set registry https://registry.npmmirror.com
   ```
3. **重新运行脚本**

### 如果某个工具安装失败
1. 检查错误信息
2. 确保网络连接稳定
3. 尝试手动安装失败的工具：
   ```bash
   cd E:\MCP-Tools
   npm install @modelcontextprotocol/server-filesystem
   ```

### 常见问题
- **权限问题**：以管理员身份运行PowerShell
- **磁盘空间不足**：选择有足够空间的驱动器
- **网络超时**：切换npm镜像源或检查网络连接

## 下一步操作

1. **配置mcp-config.json文件**
2. **参考文档**：
   - 快速开始：MCP-QUICK-START-GUIDE.md
   - 详细配置：MCP-DETAILED-CONFIG-GUIDE.md
   - 故障排除：MCP-TROUBLESHOOTING-GUIDE.md
3. **测试MCP工具功能**

## 边看边执行建议

### 执行前
- 打开此文档
- 准备好PowerShell窗口
- 确保网络连接稳定

### 执行中
- 对照文档检查每个步骤的输出
- 如果某步骤卡住超过30秒，按Ctrl+C中断并重试
- 记录任何错误信息以便排查

### 执行后
- 验证所有5个工具都已成功安装
- 检查生成的配置文件
- 保存安装路径信息

## 重要提醒

⚠️ **不要删除ALLMCP目录** - 这是重要的安装目录，删除可能导致功能异常

✅ **安装成功标志**：看到"Installed tools count: 5/5"表示安装完成

📁 **安装位置**：默认在所选驱动器的MCP-Tools目录下

🔧 **配置文件**：安装完成后会自动生成mcp-config.json配置文件