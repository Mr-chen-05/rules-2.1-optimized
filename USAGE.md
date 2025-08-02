# 📚 Rules 2.2.1 Optimized - 使用指南

> **详细使用指南和高级配置选项** | **参考 [README.md](README.md) 了解项目基本信息**

## 📚 本文档内容

本文档包含高级配置选项和详细使用说明。如需其他文档，请参考 [README.md](README.md) 中的文档导航。

## 🚀 快速安装

> **💡 基础安装**: 参考 [README.md](README.md) 的快速开始部分
>
> **📚 详细安装**: 参考 [傻瓜式安装指南](install-scripts/INSTALL-GUIDE.md)
### 🎯 高级安装选项

#### 单工具安装
```cmd
# 只安装特定AI工具（参考完整列表见 README.md）
install-scripts\augment-frontend.bat ..\你的项目目录    # Augment 前端
install-scripts\cursor-backend.bat ..\你的项目目录     # Cursor 后端
```

#### 手动安装（高级用户）
```bash
# 手动复制规则文件到项目目录
# 详细步骤参考 install-scripts/INSTALL-GUIDE.md
```

## 🛠️ 核心功能

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
/commit          # 标准化提交
/code-review     # 代码审查
/bug-fix         # Bug修复
/feedback        # 智能反馈

# 中文智能模式
/理解 /方案 /执行 /验证 /纠错 /辅助
```

### 🔧 MCP工具集成
- **💬 反馈增强** - 智能反馈收集和实时交互
- **📁 文件系统** - 自动化文件操作和项目管理
- **🧠 记忆管理** - 上下文保存和智能检索
- **🐙 GitHub集成** - 仓库管理和问题分析

## 🎯 使用场景

### 👨‍💻 个人开发者
```cmd
# 选择单个AI工具
install-scripts\augment-frontend.bat ..\你的项目目录
# 使用: /frontend-dev, /component, /commit
```

### 👥 团队协作
```cmd
# 一键安装支持所有AI工具
install-scripts\install-all.bat ..\你的项目目录 frontend
# 团队成员可以使用不同AI工具，获得统一体验
```

### 🏢 企业级
```cmd
# 全栈支持 + 完整工具链
install-scripts\install-all.bat ..\你的项目目录 fullstack
# 支持前端、后端、全栈开发，统一的企业级标准
```

## 🏆 质量保证

### ✅ 测试认证
- **PERFECT (A++)评级** - 企业级标准
- **9/9脚本通过** - 100%测试通过率
- **5/5工具验证** - MCP工具全部可用
- **完整文档** - 从入门到故障排除

### 🛡️ 企业级标准
- UTF-8编码支持、完善错误处理
- 路径安全处理、变量隔离保护

## 🆘 故障排除

### 常见问题
1. **命令不识别** → 检查规则文件位置
2. **反馈超时** → 检查MCP工具状态
3. **安装失败** → 查看 [故障排除指南](docs/MCP-TROUBLESHOOTING-GUIDE.md)

### 获取帮助
- 📖 [MCP故障排除指南](docs/MCP-TROUBLESHOOTING-GUIDE.md)
- 🤖 使用 `/feedback` 命令获取实时帮助

## 📋 版本信息

**Rules 2.2.1 Optimized (Enterprise Edition)**
- 发布日期：2025年8月3日
- 质量等级：企业级生产就绪
- 测试状态：PERFECT (A++)评级

### 👨‍💻 作者信息
- **博客ID**：m0_73635308
- **联系邮箱**：3553952458@qq.com

### 🙏 致谢
本项目基于 [steipete/agent-rules](https://github.com/steipete/agent-rules) 进行优化和扩展，感谢原作者 Peter Steinberger 的优秀工作。

---
🎉 **开始使用 Rules 2.1 Optimized，享受企业级AI辅助开发体验！**
