# ⚡ Rules 2.2.2 - 命令快速参考

> **🎯 适用对象**: 已完成基础配置，需要查找特定命令的用户
>
> **💡 新手提示**: 建议先完成基础配置和教程，熟悉基本使用后再查看完整命令列表
>
> **📚 前置步骤**: [README快速开始](README.md) → [选择教程](tutorials/) → [MCP配置](docs/MCP-QUICK-START-GUIDE.md) → **命令参考**

## 📋 完整命令参考表

| 命令 | 功能 | 适用场景 | 对应文件 |
|------|------|----------|----------|
| `/frontend-dev` | 前端开发工作流 | Vue/React项目开发 | `frontend-dev.mdc` |
| `/backend-dev` | 后端开发工作流 | API/服务器开发 | `backend-dev.mdc` |
| `/component` | 组件创建 | 创建UI组件 | `component.mdc` |
| `/ui-design` | UI设计 | 界面设计和样式 | `ui-design.mdc` |
| `/commit` | 提交规范 | 标准化Git提交 | `commit.mdc` |
| `/code-review` | 代码审查 | PR审查和质量检查 | `code-review.mdc` |
| `/bug-fix` | Bug修复 | 问题诊断和修复 | `bug-fix.mdc` |
| `/mermaid` | 图表生成 | 架构图和流程图 | `mermaid.mdc` |
| `/feedback` | 智能反馈 | 交互式用户反馈 | `feedback-enhanced.mdc` |
| `/analyze-issue` | 问题分析 | GitHub问题分析 | `analyze-issue.mdc` |
| `/create-docs` | 文档创建 | 自动生成文档 | `create-docs.mdc` |
| `/implement-task` | 任务实现 | 功能开发实现 | `implement-task.mdc` |

## 🧠 v2.2.1新增功能

### MCP智能策略（自动应用）
- **文件**: `mcp-intelligent-strategy.mdc`
- **功能**: AI自动优先使用MCP工具，效率提升50%+
- **特点**: 无需手动调用，自动在后台工作

### 新增配置命令
```bash
# 反馈频率控制
/设置详细模式    # 完整工作流反馈
/设置标准模式    # 关键决策点反馈  
/设置静默模式    # 最小化反馈

# 工作流配置
/设置严格模式    # 严格按顺序执行
/设置灵活模式    # 允许流程调整
/设置快捷模式    # 简化开发步骤

# 质量标准配置
/设置企业级标准  # 最高质量要求
/设置标准级别    # 平衡质量效率
/设置原型级别    # 快速验证开发

# 前端专用配置
/设置Vue优先模式        # Vue 3技术栈优先
/设置React优先模式      # React 18+技术栈优先
/设置TypeScript严格模式 # 最严格类型检查

# 后端专用配置
/设置微服务模式    # 微服务架构优先
/设置单体模式      # 单体应用架构优先
/设置性能优化模式  # 自动性能优化建议
```

## 🎯 按场景分类

### 🎨 前端开发
```bash
/frontend-dev     # 启动前端开发工作流
/component        # 创建新组件
/ui-design        # UI设计和样式开发
/设置Vue优先模式   # Vue技术栈优先
/设置React优先模式 # React技术栈优先
```

### ⚙️ 后端开发
```bash
/backend-dev      # 启动后端开发工作流
/api-design       # API接口设计
/database-design  # 数据库设计
/设置微服务模式    # 微服务架构优先
/设置性能优化模式  # 性能优化建议
```

### 🔧 代码管理
```bash
/commit           # 标准化提交
/code-review      # 代码审查
/bug-fix          # Bug修复
/analyze-issue    # 问题分析
```

### 📚 文档和图表
```bash
/create-docs      # 文档创建
/mermaid          # 架构图和流程图
```

### 🤖 智能交互
```bash
/feedback         # 智能反馈
/implement-task   # 任务实现
```

### 🌏 中文智能模式
```bash
/理解             # 理解需求和问题
/方案             # 提供解决方案
/执行             # 执行具体任务
/验证             # 验证结果正确性
/纠错             # 错误诊断和修复
/辅助             # 提供开发辅助
```

## 📖 使用说明

### 基本用法
1. 在AI工具中直接输入命令（如 `/frontend-dev`）
2. AI会自动加载对应的规则和工作流
3. 按照AI的引导完成开发任务

### 组合使用
```bash
# 示例：完整的前端开发流程
/frontend-dev     # 启动前端开发
/component        # 创建组件
/ui-design        # 设计界面
/commit           # 提交代码
/code-review      # 代码审查
```

### 配置优化
```bash
# 示例：Vue项目优化配置
/设置Vue优先模式
/设置TypeScript严格模式
/设置企业级标准
/设置详细模式
```

## 🔗 相关文档

- **详细使用指南**: [USAGE.md](USAGE.md)
- **安装指南**: [install-scripts/INSTALL-GUIDE.md](install-scripts/INSTALL-GUIDE.md)
- **前端开发指南**: [tutorials/frontend-rules-2.1-使用指南.md](tutorials/frontend-rules-2.1-使用指南.md)
- **后端开发指南**: [tutorials/backend-rules-2.1-使用指南.md](tutorials/backend-rules-2.1-使用指南.md)
- **MCP智能策略**: [docs/MCP-INTELLIGENT-USAGE-STRATEGY.md](docs/MCP-INTELLIGENT-USAGE-STRATEGY.md)

---

**💡 提示**: 将此文件加入书签，开发时随时查阅！
