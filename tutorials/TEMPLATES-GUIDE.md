# 📋 AgentRules 模板系统使用指南

## 🎯 概述

AgentRules 模板系统是一个智能化的项目初始化和配置管理系统，通过模板文件和变量替换机制，实现项目的快速启动和标准化配置。

## 🏗️ 系统架构

### 模板文件结构
```
templates/
├── project-init-template.md      # 项目初始化模板
├── archive-init-template.md      # 归档项目模板
├── custom-template.md            # 自定义项目模板
├── web-template.md               # Web项目模板
├── api-template.md               # API项目模板
└── [其他自定义模板文件]          # 用户自定义模板
```

### 分发机制
1. **全局模板库**: `e:\AgentRules\English\rules-2.1-optimized\templates\`
2. **项目本地模板**: `[项目目录]\templates\`
3. **自动分发**: 通过 `install-ultra.bat` 脚本自动复制到项目目录

## 🔧 模板变量系统

### 支持的变量

| 变量名 | 描述 | 示例值 |
|--------|------|--------|
| `{{PROJECT_NAME}}` | 项目名称 | "my-awesome-project" |
| `{{TIMESTAMP}}` | 当前时间戳 | "2024-01-15 14:30:25" |
| `{{DATE}}` | 当前日期 | "2024-01-15" |
| `{{TIME}}` | 当前时间 | "14:30:25" |
| `{{USER_NAME}}` | 用户名 | "developer" |
| `{{PROJECT_PATH}}` | 项目路径 | "C:\Projects\my-project" |
| `{{RULES_VERSION}}` | 规则版本 | "2.1-optimized" |

### 变量替换机制

```yaml
替换优先级:
  1. 动态检测项目信息 (项目名称、路径等)
  2. 系统环境变量 (用户名、时间等)
  3. 默认值 (如果无法获取)

替换时机:
  - AI 读取模板文件时自动替换
  - 项目初始化时批量替换
  - 用户请求时实时替换
```

## 🚀 使用方法

### 1. 自动激活

模板系统会在以下情况自动激活：

- 检测到新项目目录
- 用户请求项目初始化
- AI 识别到项目配置需求
- 超级大脑系统推荐

### 2. 手动激活

```bash
# 激活模板系统
/template-init

# 指定模板类型
/template-init --type=project

# 自定义项目名称
/template-init --name="我的项目"
```

### 3. AI 智能识别

AI 会根据以下优先级自动选择模板：

1. **项目目录模板**: `[项目目录]\templates\`
2. **全局模板库**: `e:\AgentRules\English\rules-2.1-optimized\templates\`
3. **内置默认模板**: AI 内置的标准模板

## 📝 模板文件格式

### 基础结构

```markdown
---
template_type: "project_init"
version: "2.1"
variables:
  - PROJECT_NAME
  - TIMESTAMP
  - USER_NAME
---

# {{PROJECT_NAME}} 项目

## 项目信息
- **创建时间**: {{TIMESTAMP}}
- **创建者**: {{USER_NAME}}
- **项目路径**: {{PROJECT_PATH}}

## 项目结构
[项目结构描述]

## 开发指南
[开发指南内容]
```

### 高级功能

```markdown
# 条件渲染
{{#if PROJECT_TYPE === "web"}}
## Web 项目配置
[Web 项目特定配置]
{{/if}}

# 循环渲染
{{#each DEPENDENCIES}}
- {{name}}: {{version}}
{{/each}}

# 包含其他模板
{{> shared/common-config.md}}
```

## 🎨 自定义模板

### 创建自定义模板

1. **在项目目录创建模板文件**:
   ```
   [项目目录]\.rules\templates\my-custom-template.md
   ```

2. **定义模板内容**:
   ```markdown
   ---
   template_type: "custom"
   description: "我的自定义模板"
   variables:
     - PROJECT_NAME
     - CUSTOM_VAR
   ---
   
   # {{PROJECT_NAME}} 自定义配置
   
   自定义变量: {{CUSTOM_VAR}}
   ```

3. **使用自定义模板**:
   ```bash
   /template-init --template=my-custom-template
   ```

### 模板继承

```markdown
---
extends: "project-init-template.md"
override:
  - project_structure
  - development_guide
---

# 继承基础模板并覆盖特定部分

这个模板继承了基础项目模板，但覆盖了项目结构和开发指南部分。
```

## 🔄 与其他系统集成

### Context Loader 集成

```yaml
集成点:
  - 项目类型识别 → 模板选择
  - 配置缺失检测 → 模板推荐
  - 最佳实践建议 → 模板内容

工作流:
  1. Context Loader 分析项目
  2. 识别配置需求
  3. 推荐合适模板
  4. 自动应用模板
```

### 记录员系统集成

```yaml
集成点:
  - 模板使用记录 → 自动记录
  - 项目配置变更 → 持续跟踪
  - 最佳实践积累 → 模板优化

记录内容:
  - 模板使用频率
  - 变量替换结果
  - 用户自定义内容
  - 项目成功指标
```

### 超级大脑系统集成

```yaml
智能功能:
  - 项目类型智能识别
  - 模板智能推荐
  - 配置智能优化
  - 最佳实践智能应用

触发条件:
  - "启动超级大脑系统"
  - "智能项目初始化"
  - "模板智能推荐"
```

## 📊 最佳实践

### 1. 模板设计原则

- **简洁明了**: 模板内容清晰易懂
- **灵活可扩展**: 支持多种项目类型
- **标准化**: 遵循团队开发规范
- **可维护**: 易于更新和修改

### 2. 变量命名规范

- 使用大写字母和下划线
- 语义明确，避免歧义
- 保持一致性
- 添加注释说明

### 3. 模板组织结构

```
templates/
├── base/                    # 基础模板
│   ├── project-init.md
│   └── common-config.md
├── frontend/               # 前端模板
│   ├── react-template.md
│   └── vue-template.md
├── backend/                # 后端模板
│   ├── node-template.md
│   └── python-template.md
└── custom/                 # 自定义模板
    └── team-specific.md
```

### 4. 版本管理

- 模板文件版本控制
- 变更日志记录
- 向后兼容性保证
- 升级路径规划

## 🛠️ 故障排除

### 常见问题

1. **模板文件未找到**
   - 检查文件路径是否正确
   - 确认 `install-ultra.bat` 是否正确执行
   - 验证文件权限设置

2. **变量替换失败**
   - 检查变量名称拼写
   - 确认变量值是否可获取
   - 查看 AI 日志输出

3. **模板格式错误**
   - 验证 YAML 前置元数据格式
   - 检查 Markdown 语法
   - 确认模板继承关系

### 调试方法

```bash
# 查看模板系统状态
/template-status

# 测试变量替换
/template-test --template=project-init-template.md

# 查看详细日志
/template-debug --verbose
```

## 📈 性能优化

### 缓存机制

- 模板文件内容缓存
- 变量值计算缓存
- 渲染结果缓存

### 延迟加载

- 按需加载模板文件
- 异步变量值获取
- 增量渲染更新

## 🔮 未来规划

### 计划功能

- [ ] 可视化模板编辑器
- [ ] 模板市场和分享
- [ ] 多语言模板支持
- [ ] 实时协作编辑
- [ ] AI 智能模板生成

### 技术演进

- 模板引擎升级
- 性能优化改进
- 安全性增强
- 用户体验提升

---

## 📞 支持与反馈

如有问题或建议，请：

1. 查看本指南的故障排除部分
2. 检查 `README.md` 和 `USAGE.md` 文档
3. 使用 `/feedback` 命令提供反馈
4. 联系技术支持团队

**模板系统让项目初始化更智能、更高效！** 🚀