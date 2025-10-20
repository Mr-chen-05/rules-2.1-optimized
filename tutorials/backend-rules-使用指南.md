# 🔧 后端开发 AI 助手规则使用指南 v2.6.0

## 📖 概述

本指南专门针对后端开发，**手把手教你**如何配置和使用后端开发 AI 助手规则。

### 🚀 **2.6.0 优化亮点**
- ✅ **54个智能规则（.mdc）** - 完整的AI智能化规则生态系统（31个全局规则+23个项目规则）
- ✅ **优化优先级分布** - 智能系统规则提升到P2层级
- ✅ **新增集成系统** - 大脑-记录员深度集成
- ✅ **100%AI驱动** - 所有规则集成智能分析和推荐
- ✅ **完美集成** - 100/100满分的集成测试验证

**🎯 适合人群：**
- ✅ **完全新手** - 从未接触过 MCP 工具的用户
- ✅ **后端开发者** - 想要 AI 助手帮助开发 Java/Python/Node.js 项目
- ✅ **全栈开发者** - 需要前后端 AI 助手支持
- ✅ **学习者** - 想要学习现代后端开发工具链

**📚 你将学会：**
- 🔧 如何安装和配置 Node.js、Java、Python 环境
- 📦 如何安装和配置 5 个 MCP 工具
- 🤖 如何使用智能反馈机制进行架构设计和 API 开发
- ⚙️ 如何让 AI 帮你开发后端项目

**⏱️ 预计时间：** 45-90 分钟（取决于需要安装的环境数量）

## 🎯 什么是后端规则？

**⚠️ 新手必读：** 在开始之前，请先了解这个项目能为你做什么！

### 🔥 **核心改进：统一规则创建逻辑**

**重大突破**：现在所有AI工具（Augment、Cursor、Claude Code、Trae AI）使用**完全相同的规则内容**！

- ✅ **功能完全一致** - 四个AI工具提供相同的后端开发功能
- ✅ **规则内容统一** - 所有工具使用相同的文件组合顺序（约184KB）
- ✅ **可互相复制** - 规则文件可以在不同AI工具间通用
- ✅ **一致性验证** - `comprehensive-test-report.bat`确保持续一致

### 📋 项目核心功能
本项目会为你的开发环境安装以下组件：

1. **🤖 AI助手规则** - 让AI更懂后端开发，提供专业的架构建议
2. **🔧 MCP工具链** - 5个强大的工具，让AI能够直接操作文件、记忆、GitHub等
3. **📚 智能反馈系统** - AI会主动询问需求，提供个性化建议
4. **🎯 多AI工具支持** - 同时支持Augment、Cursor、Claude Code、Trae AI
5. **🔄 统一规则创建** - 确保所有AI工具功能完全一致

### 🎯 你将获得什么能力？
后端规则是专门为 API/数据库/微服务开发优化的 AI 助手规则，包含：

- 🏗️ **架构设计模式** - 系统设计和技术选型
- ⚡ **API 开发模式** - RESTful API 和 GraphQL 实现
- 🗄️ **数据建模模式** - 数据库设计和优化
- 🔒 **安全开发模式** - 安全设计和漏洞检测
- 🚀 **运维部署模式** - 部署自动化和监控

## 📁 第一步：安装后端规则

> **💡 快速安装**: 参考 [README.md](../README.md) 的快速开始部分
>
> **📚 详细安装**: 参考 [傻瓜式安装指南](../install-scripts/INSTALL-GUIDE.md) | [中文版](../install-scripts/INSTALL-GUIDE-CN.md)
>
> **🎯 安装命令**: 
> ```cmd
> # 注意：如果规则目录在非C盘，需要先切换盘符
> E:                                    # 先切换到E盘（根据你的实际盘符）
> cd "你的rules-2.4.1-optimized目录路径"
> install-scripts\install-ultra.bat ..\你的项目目录 backend
> ```

## 🔧 第二步：环境要求检查

### **2.1 环境配置**

> **📋 环境要求**: 请先完成基础环境配置，确保开发环境已正确安装

**✅ 环境检查**
```bash
# 检查必需环境
node --version  # 应显示 ≥16.0.0
npm --version   # 应显示 ≥8.0.0
java --version  # 应显示 ≥11 (如使用Java)
python --version # 应显示 ≥3.8 (如使用Python)
```

**环境状态**:
- ✅ **已就绪**: 版本符合要求，可以继续后端开发配置
- ❌ **需要配置**: 请先完成 [环境配置指南](../docs/ENVIRONMENT-SETUP.md)

**📚 详细安装教程**: 如需安装或升级开发环境，请参考 [环境配置指南](../docs/ENVIRONMENT-SETUP.md)，包含：
- Node.js/NVM 安装配置
- Java JDK 安装配置  
- Python 安装配置
- npm/pip 镜像源配置
- 常见问题解决方案

## 🔧 第三步：MCP工具配置

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

**⚠️ 重要提示：** 根据最新测试，mcp-feedback-enhanced 是Python包，需要特殊安装方式！

```bash
# 创建MCP工具目录
mkdir C:\MCP-Tools
cd C:\MCP-Tools

# 初始化项目
npm init -y

# 安装Node.js MCP工具（本地安装，路径清晰；server-memory 可选）
npm install @modelcontextprotocol/server-filesystem
npm install @modelcontextprotocol/server-memory  # 可选（Recorder 优先）
npm install @modelcontextprotocol/server-github
npm install @modelcontextprotocol/server-everything

# 安装Python MCP工具
pip install uv
# mcp-feedback-enhanced 通过 uvx 运行，无需预安装
```

**✅ 验证安装：**
```bash
# 验证Node.js工具
npm list --depth=0 | findstr modelcontextprotocol

# 验证Python工具
uvx mcp-feedback-enhanced@latest version
```

### **3.2 创建配置文件**

**📝 完整MCP配置模板：**

**⚠️ 重要提醒：** 下面的配置文件是**模板**，你需要根据自己的实际情况修改，否则可能无法正常工作！

创建 `mcp-config.json`：
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-filesystem",
        "C:\\your-backend-projects"
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
1. **后端项目路径**：将 `C:\\your-backend-projects` 改为实际路径
2. **GitHub Token**：将 `your_github_token_here` 改为真实Token

**📂 后端项目路径示例：**
```json
// Java项目
"D:\\Java\\SpringBoot项目"

// Python项目
"E:\\Python\\FastAPI项目"

// Node.js项目
"C:\\Users\\用户名\\Desktop\\NodeJS"
```

**💡 配置说明：**
- **npx命令** - 自动使用最新版本的Node.js MCP工具
- **uvx命令** - 自动运行最新版本的Python MCP工具
- **timeout设置** - 反馈工具超时时间（600秒）
- **autoApprove** - 自动批准反馈交互功能

### **3.3 GitHub Token配置**
1. 访问：https://github.com/settings/tokens
2. 点击"Generate new token (classic)"
3. 选择权限：`repo`, `user`, `workflow`
4. 复制生成的token并替换配置文件中的占位符

## 🚀 第四步：开始使用

### **4.1 基本命令**
```bash
# 启动后端开发工作流
/backend-dev

# API接口设计
/api-design

# 数据库设计
/database-design

# 安全检查
/security-check

# 性能测试
/performance-test
```

### **4.2 模式切换**
```bash
# 手动切换模式
/架构设计    # 架构设计模式
/api开发     # API开发模式
/数据建模    # 数据建模模式
/安全开发    # 安全开发模式
/运维部署    # 运维部署模式
```

### **4.3 专用配置模式**
```bash
# 架构策略配置
/设置微服务模式    # 启用微服务架构优先策略
/设置单体模式      # 启用单体应用架构策略

# 性能优化配置
/设置性能优化模式  # 自动应用性能优化建议
```

### **4.4 反馈频率控制**
```bash
# 反馈频率控制
/设置详细模式    # 启用所有反馈点，完整工作流
/设置标准模式    # 关键决策点反馈（默认）
/设置静默模式    # 仅错误时反馈，适合熟练用户
```

### **4.5 工作流配置**
```bash
# 工作流配置
/设置严格模式    # 严格按顺序执行，不允许跳过
/设置灵活模式    # 允许模式跳转和流程调整（默认）
/设置快捷模式    # 简化某些步骤，提高效率
```

### **4.6 质量标准配置**
```bash
# 质量标准配置
/设置企业级标准  # 最高质量要求，完整测试
/设置标准级别    # 平衡质量和效率（默认）
/设置原型级别    # 快速验证，降低质量要求
```

### **4.7 智能反馈场景**
AI会在以下情况主动请求反馈：

#### **架构设计确认：**
```
"请确认系统架构方案：
1. 微服务架构 vs 单体架构
2. 数据库选择：MySQL vs PostgreSQL
3. 缓存方案：Redis vs Memcached
4. 消息队列：RabbitMQ vs Kafka
请选择并说明原因"
```

#### **API设计确认：**
```
"API接口设计完成，请确认：
- RESTful风格是否符合要求
- 响应格式是否统一
- 错误处理机制是否完善
- 认证授权方案是否合适"
```

## 📋 第五步：实际使用示例

### **示例1：Java Spring Boot项目**
```
用户：帮我创建一个Spring Boot的用户管理系统

AI响应：[模式：架构设计] [角色：后端架构师]
我来帮你设计Spring Boot用户管理系统...

[触发反馈机制，确认技术栈和架构方案]
```

### **示例2：Python FastAPI项目**
```
用户：/api开发 创建用户认证API

AI响应：[模式：API开发] [角色：后端开发工程师]
我来帮你创建FastAPI用户认证接口...

[自动生成API代码，包含认证和授权]
```

### **示例3：数据库设计**
```
用户：/数据建模 设计电商系统数据库

AI响应：[模式：数据建模] [角色：数据库工程师]
我来设计电商系统的数据库结构...

[生成表结构设计和关系图]
```

## 🛠️ 第六步：技术栈支持

### **6.1 Java技术栈**
- **Spring Boot** - 企业级Java框架
- **Spring Security** - 安全框架
- **Spring Data JPA** - 数据访问层
- **Maven/Gradle** - 依赖管理
- **JUnit** - 单元测试

### **6.2 Python技术栈**
- **FastAPI** - 现代Python框架
- **Django** - 全功能Web框架
- **SQLAlchemy** - ORM框架
- **Pydantic** - 数据验证
- **pytest** - 测试框架

### **6.3 Node.js技术栈**
- **Express** - 经典Node.js框架
- **Koa** - 轻量级框架
- **TypeScript** - 类型安全
- **Prisma** - 现代ORM
- **Jest** - 测试框架

## ✅ 第七步：验证配置

### **7.1 功能测试**
```bash
# 测试基本功能
/backend-dev

# 测试反馈机制
/feedback

# 测试模式切换
/架构设计
```

### **7.2 检查清单**
- [ ] 开发环境正确安装（Node.js/Java/Python）
- [ ] 规则文件正确放置
- [ ] MCP工具配置完成
- [ ] GitHub Token配置正确
- [ ] 基本命令可以正常使用
- [ ] 反馈机制正常工作
- [ ] 模式切换功能正常

## 🎉 完成！

恭喜！你已经成功配置了后端开发 AI 助手规则。现在可以享受高效的后端开发体验了！

## 📚 更多资源

- **详细文档**：查看 `docs/MCP-QUICK-START-GUIDE.md` 和 `docs/MCP-DETAILED-CONFIG-GUIDE.md`
- **项目规则**：浏览 `project-rules/` 目录
- **全局规则**：参考 `global-rules/` 目录
- **MCP配置**：详见 `docs/MCP-DETAILED-CONFIG-GUIDE.md`

## 📋 版本信息

- **当前版本**: Rules 2.6.0
- **发布日期**: 2025年10月19日

详细版本信息请参考 [README.md](../README.md)

### 🔥 **重大改进**
- ✅ **统一规则创建逻辑** - 所有AI工具使用相同的规则内容
- ✅ **规则一致性保证** - 四个AI工具功能完全一致
- ✅ **自动目录创建** - 解决路径不存在问题
- ✅ **验证工具** - `comprehensive-test-report.bat`确保一致性


### 👨‍💻 作者信息
- **博客ID**：m0_73635308
- **联系邮箱**：3553952458@qq.com
 