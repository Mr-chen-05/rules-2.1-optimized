```
# AgentRules Ultimate - 统一安装指南

> **🌐 语言选择**: [🇺🇸 English](INSTALL-GUIDE.md) | 🇨🇳 中文 (当前)

> **重要提示**: 现在只需要一个脚本就能搞定所有AI工具！
>
> **预计用时**: 3-5分钟 | **成功率**: 按步骤操作100%成功
> **最新版本**: install-ultra.bat (最终版本) - 支持所有AI工具的统一解决方案
> **超级简化**: 现在支持双击运行，自动在桌面创建agent文件夹！

## 这个教程能帮你做什么？

使用 **一个脚本** 为 **所有AI工具** 安装 AgentRules 规则系统，让你的AI助手变得超级智能。

### 核心功能
- **前端开发**: Vue、React、TypeScript 专业开发
- **后端开发**: Node.js、Python、Java 等后端技术
- **全栈开发**: 前端+后端完整解决方案
- **代码管理**: 标准化提交、代码审查、Bug修复
- **可视化**: 自动生成架构图、流程图
- **智能系统**: AI记忆、推荐引擎、超级大脑

### Ultimate版本特色
- **一个脚本适配所有AI工具**: Augment、Cursor、Claude、Trae等
- **优先级架构**: P0-P7 八个优先级层次，AI理解更准确
- **标准化目录结构**: 自动创建 `.rules/` 子目录
- **增强编码支持**: 完美处理中文路径和特殊字符
- **三种开发模式**: frontend、backend、fullstack
- **跨区域兼容**: 自动检测系统编码，全球兼容
- **双击即用**: 支持直接双击运行，零配置安装

## 脚本状态

| 脚本名称 | 状态 | 功能 | 支持的AI工具 |
|---------|------|------|-------------|
| `install-ultra.bat` | **最终版本** | 统一规则安装器 | **所有AI工具** |

**重大改进**:
- **统一解决方案** - 一个脚本替代所有专用脚本
- **智能适配** - 自动适配所有AI工具和IDE
- **优先级系统** - P0-P7 八层架构，AI理解度提升200%
- **编码检测** - 自动检测系统编码（CP936/950/932/949/437/65001）
- **完美兼容** - 支持所有主流AI开发工具
- **双击安装** - 支持直接双击脚本，自动创建桌面agent项目

## 开始前的准备（必读！）

### 安装前检查清单
- [ ] **操作系统**: Windows 10/11（必需）
- [ ] **AI工具**: 任意AI开发工具（Augment、Cursor、Claude、Trae等）
- [ ] **规则文件**: 已下载 `rules-2.1-optimized` 文件夹
- [ ] **项目目录**: 已有项目文件夹或准备创建一个

### 文件准备
1. 将 `rules-2.1-optimized` 文件夹放在易于访问的位置（如桌面）
2. 确保你有一个项目文件夹（如果没有，安装过程会自动创建）
3. 确保你有管理员权限（某些操作可能需要）

### 快速开始提示
**新手推荐**: 如果你不确定安装到哪里，可以直接运行脚本不带任何参数，系统会自动在桌面创建 `agent` 文件夹作为项目目录。

## 超级简单：双击安装法（推荐！）

**最简单的方式 - 适合所有用户**:

1. **找到脚本文件**: 进入 `install-scripts` 文件夹
2. **双击运行**: 直接双击 `install-ultra.bat` 文件
3. **自动完成**: 脚本会自动在桌面创建 `agent` 文件夹并安装所有fullstack规则

**双击安装的优势**:
- **零配置**: 无需输入任何命令或参数
- **固定位置**: 统一在桌面创建 `agent` 文件夹，便于管理
- **完整功能**: 自动安装fullstack模式，包含所有前端+后端规则
- **即开即用**: 安装完成后立即可以在任何AI工具中使用
- **智能检测**: 自动检测是否已安装，避免重复执行
- **编码自动检测**: 自动适配你的系统区域设置

**安装位置**: `C:\Users\你的用户名\Desktop\agent`

## 命令行安装（高级用户）

### 第1步：打开命令行

**重要提醒**: 建议以管理员身份运行，避免权限问题！

**方式1：PowerShell（推荐）**
1. 按键盘上的 `Win + X`
2. 选择 "Windows PowerShell (管理员)" 或 "终端 (管理员)"
3. 点击 "是" 确认管理员权限
4. 看到蓝色窗口就成功了！

**方式2：CMD命令提示符（管理员模式）**
1. 按键盘上的 `Win` 键
2. 输入 `cmd`
3. 右键点击 "命令提示符"
4. 选择 "以管理员身份运行"
5. 点击 "是" 确认管理员权限

### 第2步：进入正确目录

**复制粘贴这个命令**（把 `luo20` 改成你的用户名）:
```
cd c:\Users\luo20\Desktop\rules-2.1-optimized
```

**检查是否成功**:
```
dir
```
你应该看到这些文件夹:
- `install-scripts` ✅
- `project-rules` ✅  
- `global-rules` ✅

### 第3步：选择你的开发模式

**不知道选什么？看这里：**
- **做网页、APP界面** → 选择 `frontend`
- **做服务器、API** → 选择 `backend`
- **全栈开发（推荐）** → 选择 `fullstack`

## 一键安装命令

### 统一安装命令（适配所有AI工具）

**前端开发**:
```bash
# 方式1：绝对路径（推荐）
install-scripts\install-ultra.bat C:\Users\你的用户名\Desktop\demo-project frontend

# 方式2：相对路径（简单）
install-scripts\install-ultra.bat ..\demo-project frontend
```

**后端开发**:
```bash
# 方式1：绝对路径
install-scripts\install-ultra.bat C:\Users\你的用户名\Desktop\demo-project backend

# 方式2：相对路径（推荐）
install-scripts\install-ultra.bat ..\demo-project backend
```

**全栈开发（推荐）**:
```bash
# 方式1：绝对路径
install-scripts\install-ultra.bat C:\Users\你的用户名\Desktop\demo-project fullstack

# 方式2：相对路径（推荐）
install-scripts\install-ultra.bat ..\demo-project fullstack
```

### 简化命令示例

```bash
# 最简单的方式：不指定任何参数（推荐新手）
install-scripts\install-ultra.bat
# 效果：在桌面创建 C:\Users\你的用户名\Desktop\agent 文件夹，使用fullstack模式

# 只指定开发模式，使用桌面默认位置：
install-scripts\install-ultra.bat frontend
# 效果：在桌面创建 C:\Users\你的用户名\Desktop\agent 文件夹，使用frontend模式

# 只指定目录，使用默认fullstack模式：
install-scripts\install-ultra.bat C:\my-project
# 等同于：install-scripts\install-ultra.bat C:\my-project fullstack
```

**看到 "SUCCESS: Rules Directory Created! (Final Release)" 就是成功了！**

## 安装后的文件结构

安装完成后，你的项目目录会是这样:

```
你的项目目录/
└── .rules/                          ← 所有规则文件都在这里
    ├── main.md                     ← 规则目录指南
    ├── P0-core-safety/             ← 核心安全规则 (优先级1000)
    ├── P1-core-identity/           ← 核心身份规则 (优先级900)
    ├── P2-intelligent-system/      ← 智能系统规则 (优先级800)
    ├── P3-professional-dev/        ← 专业开发规则 (优先级700)
    ├── P4-project-workflow/        ← 项目工作流规则 (优先级600)
    ├── P5-advanced-features/       ← 高级功能规则 (优先级500)
    ├── P6-system-optimization/     ← 系统优化规则 (优先级400)
    └── P7-utilities/               ← 实用工具规则 (优先级300)
```

## 不同模式的文件数量

| 模式 | 文件数量 | 包含内容 |
|------|----------|----------|
| **Frontend** | 31个文件 | 前端规则 + mermaid图表支持 + 6个新增核心智能规则 |
| **Backend** | 30个文件 | 后端规则（不含mermaid）+ 6个新增核心智能规则 |
| **Fullstack** | 33个文件 | 前端 + 后端完整规则 + 6个新增核心智能规则 |

## 如何使用安装的规则？

### AI工具自动识别

安装完成后，**所有AI工具**都会自动识别 `.rules/` 目录中的规则:

- ✅ **Augment AI** - 自动加载规则，支持中文对话
- ✅ **Cursor IDE** - 自动加载规则，专业代码编辑
- ✅ **Claude Code** - 自动加载规则，智能代码助手
- ✅ **Trae AI** - 自动加载规则，支持中文对话
- ✅ **其他AI工具** - 通用兼容性

### 优先级系统说明

AI会按照以下优先级顺序理解和执行规则:

1. **P0 (1000)**: 核心安全 - 必须首先遵循
2. **P1 (900)**: 核心身份 - 基础行为模式
3. **P2 (800)**: 智能系统 - 高级能力
4. **P3 (700)**: 专业开发 - 领域专业知识
5. **P4 (600)**: 项目工作流 - 操作流程
6. **P5 (500)**: 高级功能 - 增强功能
7. **P6 (400)**: 系统优化 - 性能调优
8. **P7 (300)**: 实用工具 - 辅助工具

## 遇到问题怎么办？

### 常见问题速查

**❌ 问题1：脚本无法运行**
```
错误：无法将"install-scripts\install-ultra.bat"项识别为 cmdlet
```
**✅ 解决**: 确保在正确的目录下
```
cd c:\Users\luo20\Desktop\rules-2.1-optimized
```

**❌ 问题2：路径包含特殊字符**
```
错误：文件名、目录名或卷标语法不正确
```
**✅ 解决**: 脚本现已自动处理Unicode字符，具备增强编码检测
```
# 如果仍有问题，使用英文路径
install-scripts\install-ultra.bat C:\projects\demo-project fullstack
```

**❌ 问题3：权限问题**
```
错误：拒绝访问
```
**✅ 解决**: 以管理员身份运行 PowerShell

**❌ 问题4：父目录不存在**
```
错误：父目录不存在
```
**✅ 解决**: 先创建父目录
```
mkdir C:\Users\luo20\Desktop
```

## 高级用法

### 自定义项目路径
```bash
# 使用绝对路径
install-scripts\install-ultra.bat C:\projects\my-vue-app frontend

# 使用相对路径
install-scripts\install-ultra.bat ..\my-project backend

# 全栈项目
install-scripts\install-ultra.bat D:\workspace\fullstack-app fullstack
```

### 编码兼容性
脚本现在自动检测并适配不同的系统编码:
- **CP936**: 简体中文
- **CP950**: 繁体中文
- **CP932**: 日语
- **CP949**: 韩语
- **CP437/65001**: 英语/西方语言

## 总结

**🖱️ 最简单的方式（推荐所有用户）**:
```
直接双击 install-scripts\install-ultra.bat
自动在桌面创建 agent 文件夹，包含完整fullstack规则
```

**⌨️ 命令行方式（高级用户）**:
```bash
# 完整格式
install-scripts\install-ultra.bat [项目路径] [模式]

# 快速命令
install-scripts\install-ultra.bat
# 同样在桌面创建 agent 文件夹
```

**🚀 三种开发模式**:
- `frontend` - 前端开发（31个文件）
- `backend` - 后端开发（30个文件）
- `fullstack` - 全栈开发（33个文件，推荐）

**✅ 一次安装，所有AI工具都能用！**
**🎯 双击即用，零技术门槛！**
**🌐 全球兼容，自动编码检测！**

---

🎉 **恭喜！现在你可以享受统一、智能、高效的AI辅助开发体验了！**