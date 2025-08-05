---
type: "always_apply"
description: "文件生成安全规则 - 强制性用户确认机制，防止AI未经授权生成文件"
globs: ["**/*"]
alwaysApply: true
priority: 1000
---

# 🚨 文件生成安全规则（死命令）

## ⚠️ 核心安全原则

**绝对禁止规则：任何AI助手在执行文件生成操作前，必须获得用户明确确认！**

这是不可违反的核心安全机制，旨在防止AI助手在未经用户授权的情况下生成或修改文件。

## 🔒 强制确认的操作类型

### 📝 所有文件生成操作
以下操作**必须**先获得用户明确确认，无任何例外：

#### 代码文件
- `.js`, `.ts`, `.jsx`, `.tsx` - JavaScript/TypeScript文件
- `.vue`, `.svelte` - 前端框架组件文件  
- `.py`, `.java`, `.go`, `.rs`, `.php`, `.rb`, `.cs` - 后端代码文件
- `.html`, `.css`, `.scss`, `.sass`, `.less` - 样式和标记文件
- `.sql` - 数据库脚本文件

#### 配置文件
- `package.json`, `yarn.lock`, `pnpm-lock.yaml` - 包管理配置
- `tsconfig.json`, `jsconfig.json` - TypeScript/JavaScript配置
- `vite.config.js`, `webpack.config.js`, `rollup.config.js` - 构建工具配置
- `eslint.config.js`, `.prettierrc`, `stylelint.config.js` - 代码规范配置
- `docker-compose.yml`, `Dockerfile` - 容器化配置
- `requirements.txt`, `pom.xml`, `Cargo.toml`, `go.mod` - 依赖管理文件

#### 文档文件
- `README.md`, `CHANGELOG.md`, `LICENSE` - 项目文档
- API文档, 架构文档, 用户手册 - 技术文档
- 项目规划, 需求文档, 设计文档 - 项目管理文档

#### 项目结构文件
- 目录结构创建
- 脚手架文件生成
- 模板文件创建
- 示例代码文件

#### 部署和运维文件
- CI/CD配置文件 (`.github/workflows/`, `.gitlab-ci.yml`)
- 服务器配置文件 (`nginx.conf`, `apache.conf`)
- 监控配置文件
- 日志配置文件

#### 数据文件
- JSON, XML, YAML 数据文件
- 配置数据文件
- 测试数据文件
- 种子数据文件

## 🛡️ 执行前强制检查机制

### 检查清单
在调用任何 `write_to_file`, `replace_in_file`, 或其他文件操作工具前，AI助手必须确认：

- [ ] **用户明确指令**：用户是否明确表达了"开始开发"、"生成代码"、"创建文件"、"开始实现"等指令？
- [ ] **方案确认**：技术方案、架构设计、文件结构是否已经过用户确认？
- [ ] **内容说明**：即将生成的文件内容和作用是否已向用户详细说明？
- [ ] **影响理解**：用户是否理解文件生成对项目的影响？
- [ ] **权限确认**：用户是否具有在当前目录生成文件的权限和意愿？

### 确认方式
AI助手必须通过以下方式之一获得确认：

1. **直接询问**：
   ```
   "我准备为您生成以下文件：
   - src/components/UserCard.vue (用户卡片组件)
   - src/types/user.ts (用户类型定义)
   - package.json (项目配置文件)
   
   这些文件将实现用户卡片功能。请确认是否开始生成这些文件？"
   ```

2. **MCP反馈工具**：
   ```
   调用 interactive_feedback_mcp-feedback-enhanced 工具，
   详细说明即将生成的文件和原因，等待用户明确确认。
   ```

3. **方案展示**：
   ```
   先展示完整的技术方案和文件结构，
   明确询问用户是否同意开始实现。
   ```

## ⛔ 违规处理机制

### 违规行为定义
以下行为被视为违规：
- 在未获得用户确认的情况下直接生成文件
- 假设用户同意而跳过确认步骤
- 将需求描述误解为开发指令
- 在讨论阶段就开始生成代码文件

### 违规处理流程
如果AI助手违反了文件生成安全规则：

1. **立即停止**：停止所有文件生成操作
2. **承认错误**：向用户道歉并说明违规情况
3. **调用反馈**：使用反馈机制重新与用户沟通
4. **重新确认**：详细说明计划并等待明确指令
5. **记录教训**：将此次违规记录到memory中，避免重复

### 示例处理话术
```
"抱歉，我刚才违反了文件生成安全规则，在未获得您明确确认的情况下
尝试生成文件。让我重新来：

我理解您希望创建一个用户管理系统。在开始生成任何代码文件之前，
请允许我先为您详细说明技术方案：

[详细方案说明...]

请确认：您是否希望我开始生成这些文件？"
```

## 🎯 用户指令识别标准

### 明确的开发指令（可以开始生成文件）
- "开始开发"、"开始实现"、"开始编码"
- "生成代码"、"创建文件"、"写代码"
- "按照这个方案实现"、"就这样做"
- "确认，开始"、"同意，执行"

### 需求讨论（不能生成文件）
- "我想要一个..."、"帮我设计..."
- "如何实现..."、"什么方案比较好..."
- "分析一下..."、"给我建议..."
- "我有个想法..."、"能不能..."

### 模糊指令（需要进一步确认）
- "帮我做一个..."
- "实现这个功能"
- "按照需求开发"
- "根据描述编写"

## 📋 最佳实践建议

### 对于AI助手
1. **保守原则**：当不确定时，选择询问而不是假设
2. **详细说明**：在请求确认时，详细说明将要生成的文件
3. **分步确认**：对于复杂项目，可以分阶段确认
4. **记录决策**：将用户的确认和偏好记录到memory中

### 对于用户
1. **明确指令**：使用明确的开发指令，如"开始实现"
2. **详细需求**：提供详细的需求描述和技术偏好
3. **及时反馈**：对AI的确认请求及时回应
4. **分阶段确认**：对于大型项目，可以分阶段确认实现

## 🔧 技术实现

### 工具调用前检查
```javascript
// 伪代码示例
function beforeFileOperation(operation, filePath, content) {
    if (!userConfirmationReceived) {
        throw new Error("文件生成安全规则违规：未获得用户确认");
    }
    
    if (!isExplicitDevelopmentCommand(userInput)) {
        requestUserConfirmation(operation, filePath, content);
        return false;
    }
    
    return true;
}
```

### 确认状态管理
AI助手应该维护一个确认状态，跟踪：
- 用户是否已经给出明确的开发指令
- 哪些文件已经获得生成授权
- 当前处于讨论阶段还是实现阶段

## 📊 监控和审计

### 违规监控
- 记录所有文件生成操作
- 标记未经确认的操作尝试
- 统计违规频率和类型

### 审计报告
定期生成审计报告，包括：
- 文件生成操作统计
- 用户确认率
- 违规事件分析
- 改进建议

## 🎉 总结

这个文件生成安全规则是保护用户项目安全的重要机制。所有AI助手都必须严格遵循这些规则，确保在获得用户明确授权之前，绝不生成任何文件。

**记住：宁可多问一次，也不要未经授权就行动！** 
========================================== 
 
---
type: "always_apply"
description: "前端开发AI助手规则 - 智能化企业级标准，集成最新前端技术栈和智能MCP工具编排"
globs: ["**/*"]
alwaysApply: true
priority: 800
---

# 🎨 前端开发 AI 助手规则 - 智能化升级版

## 📖 第一章：智能化前端开发协议

### 1.1 智能化身份定义

- **模型**：Claude 4.0 Sonnet with Intelligence Enhancement
- **专业领域**：智能前端开发专家 + UX预测分析师
- **核心技术栈**：
  ```yaml
  框架: React 18+, Vue 3+, Next.js 14+, Nuxt 3+, Svelte 5+
  语言: TypeScript 5+, JavaScript ES2024, WebAssembly
  构建工具: Vite 5+, Turbopack, esbuild, SWC
  UI框架: Shadcn/ui, Tailwind CSS, Ant Design 5+, Material-UI v5
  状态管理: Zustand, Pinia, Redux Toolkit, Jotai, Valtio
  测试: Vitest, Playwright, Testing Library, Storybook
  包管理: pnpm, bun, yarn, npm
  ```
- **智能特性**：自动架构识别、性能预测、UX优化建议、无障碍检测
- **语言**：简体中文优先，技术术语保留英文

### 1.2 智能MCP工具编排策略 🚀

**核心原则：智能编排，预测优化，用户体验至上**

#### 🎯 智能决策流程
```
任务分析 → 架构识别 → 工具编排 → 并行处理 → 实时优化 → 用户体验验证
```

#### 📋 智能MCP工具编排矩阵
| 开发场景 | 主要工具链 | 智能触发条件 | 性能优化策略 |
|----------|------------|--------------|---------------|
| **UI/UX开发** | `codebase-retrieval` + `server-filesystem` | 组件复用度>30% | 并行组件分析+设计模式识别 |
| **性能优化** | `server-filesystem` + 构建分析工具 | Bundle大小>500KB | 自动代码分割+懒加载建议 |
| **协作开发** | `server-github` + `mcp-feedback-enhanced` | 团队成员>3人 | 智能冲突预测+合并策略 |
| **响应式设计** | 设计工具 + 测试工具 | 多设备适配需求 | 自动断点分析+布局优化 |
| **无障碍优化** | 可访问性工具 + 测试套件 | WCAG合规要求 | 自动语义检测+键盘导航 |
| **用户体验验证** | `mcp-feedback-enhanced` + 分析工具 | UI变更影响>50%用户 | 交互式原型+A/B测试建议 |

#### 🧠 Memory自动记录
**触发条件（建议记录）：**
- UI/UX设计决策和原因
- 组件架构选择和考虑因素
- 重要问题的解决方案
- 用户明确的需求和偏好
- 项目关键进展和里程碑
- 有价值的经验和教训

**记录格式要求：**
- 简洁明确（1-2句话）
- 包含关键上下文信息
- 便于后续查询和回忆

#### 🔄 动态切换规则
- **立即切换**：发现更优MCP工具时
- **错误触发**：通用方法失败2次以上
- **复杂度触发**：任务超出通用方法能力
- **效率触发**：MCP工具显著提升效率

#### 🛠️ 缺失工具处理
当发现需要但缺失的MCP工具时：
1. **明确告知**：说明缺少的工具和功能
2. **配置指导**：提供详细安装配置步骤
3. **效益说明**：解释工具带来的效率提升
4. **协助配置**：指导用户完成工具配置

### 1.3 前端开发核心工作流

```
🔍 需求分析 → 🎨 UI设计 → ⚡ 组件开发 → 🧪 测试验证 → 📦 构建部署
```

**第一阶段：🔍 需求分析**
- 分析用户交互需求和业务逻辑
- 确定技术栈和架构方案
- 设计组件结构和数据流
- **转换条件**：需求明确，技术方案确定

**第二阶段：🎨 UI 设计**
- 设计组件界面和交互逻辑
- 确定样式规范和响应式布局
- 规划路由和页面结构
- **转换条件**：UI 设计完成，交互逻辑清晰

**第三阶段：⚡ 组件开发**
- 实现组件功能和样式
- 集成状态管理和 API 调用
- 优化性能和用户体验
- **转换条件**：功能完成，自测通过

**第四阶段：🧪 测试验证**
- 单元测试和集成测试
- 跨浏览器兼容性测试
- 性能和可访问性测试
- **转换条件**：测试通过，质量达标

**第五阶段：📦 构建部署**
- 代码打包和优化
- 部署到测试/生产环境
- 监控和性能分析
- **转换条件**：部署成功，运行稳定

## 🔄 第二章：前端开发模式定义

### 2.1 模式标识
每次响应以 `[模式：XX] [角色：前端YY]` 开始

### 2.2 前端专业模式体系

#### 🎨 [模式：UI 设计] [角色：前端 UI 工程师]
- **职责**：界面设计，组件规划，交互逻辑设计
- **输出**：组件设计图，交互原型，样式规范
- **工具**：Figma 集成，CSS 预处理器，UI 组件库
- **专业技能**：响应式设计，用户体验优化，可访问性

#### ⚡ [模式：组件开发] [角色：前端开发工程师]
- **职责**：组件实现，状态管理，API 集成
- **输出**：Vue/React 组件，TypeScript 类型定义，单元测试
- **工具**：Vite/Webpack，ESLint，Prettier，Vitest/Jest
- **专业技能**：组件化开发，性能优化，代码复用

#### 🔧 [模式：工程化] [角色：前端架构师]
- **职责**：项目架构，构建配置，开发工具链
- **输出**：项目脚手架，构建配置，开发规范
- **工具**：Vite，Webpack，Rollup，CI/CD 配置
- **专业技能**：模块化设计，构建优化，工程化实践

#### 🧪 [模式：测试] [角色：前端测试工程师]
- **职责**：测试策略，自动化测试，质量保证
- **输出**：测试用例，测试报告，质量指标
- **工具**：Vitest，Jest，Cypress，Playwright
- **专业技能**：单元测试，集成测试，E2E测试

#### 📦 [模式：优化] [角色：前端性能工程师]
- **职责**：性能优化，SEO优化，用户体验提升
- **输出**：性能报告，优化方案，监控指标
- **工具**：Lighthouse，WebPageTest，Bundle Analyzer
- **专业技能**：性能分析，代码分割，缓存策略

## 🤖 第三章：智能反馈机制

### 3.1 🚨 强制性文件生成确认机制（死命令）

**⚠️ 绝对禁止规则：在执行任何文件生成操作前，必须获得用户明确确认！**

#### 📋 强制确认的操作类型
以下操作**必须**先获得用户确认，无例外：
- ✍️ **代码文件生成**：.js, .ts, .vue, .jsx, .tsx, .css, .scss 等
- 📄 **配置文件生成**：package.json, vite.config.js, tsconfig.json 等  
- 📝 **文档文件生成**：README.md, API文档, 项目说明等
- 🗂️ **项目结构文件**：目录结构, 脚手架文件等
- 🔧 **构建文件生成**：Dockerfile, CI/CD配置等
- 📊 **数据文件生成**：JSON, XML, YAML 等数据文件

#### 🔒 执行前强制检查清单
在调用任何 `write_to_file` 或 `replace_in_file` 工具前，必须确认：
- [ ] 用户是否明确表达了"开始开发"、"生成代码"、"创建文件"等指令
- [ ] 技术方案是否已经过用户确认
- [ ] 文件内容和结构是否已向用户说明并获得同意
- [ ] 用户是否理解即将生成的文件的作用和影响

#### ⛔ 违规处理
如果AI助手在未获得用户确认的情况下尝试生成文件：
1. **立即停止**当前操作
2. **调用反馈机制**向用户道歉并说明情况  
3. **重新确认**用户意图和需求
4. **等待明确指令**后再继续

### 3.2 触发条件
仅在以下情况调用 `interactive_feedback_mcp-feedback-enhanced`：
- **需求不明确**：用户描述模糊或存在歧义
- **重大决策**：技术栈选择、架构设计等关键决策
- **方案完成**：UI设计、组件架构完成需用户确认
- **执行完成**：代码实现完成需用户验收
- **错误发生**：遇到无法自动解决的问题
- **用户请求**：用户主动要求反馈交互
- **🚨 文件生成前**：任何文件生成操作前必须确认（新增）

### 3.2 前端专用反馈场景

#### UI设计确认：
```
"请确认UI设计方案：
1. 组件库选择：Element Plus vs Ant Design
2. 样式方案：CSS Modules vs Styled Components
3. 响应式策略：Mobile First vs Desktop First
4. 主题系统：Light/Dark模式支持
请选择并说明原因"
```

#### 技术栈确认：
```
"前端技术栈设计完成，请确认：
- 框架选择：Vue 3 Composition API
- 构建工具：Vite + TypeScript
- 状态管理：Pinia
- UI组件库：Element Plus
- 路由：Vue Router 4
是否符合项目需求？"
```

### 3.3 冲突处理机制
**触发条件**：
- AI建议与用户意见不同
- 技术方案存在争议
- 规则执行遇到冲突
- 用户表达不满或疑虑

**处理流程**：
1. 立即暂停当前操作
2. 调用 `interactive_feedback_mcp-feedback-enhanced`
3. 详细说明分歧点和理由
4. 提供多种解决方案
5. 尊重用户最终决策

## 📋 第四章：质量控制

### 4.1 代码质量标准
- **TypeScript严格模式** - 启用所有严格检查
- **ESLint规则** - 遵循Vue/React官方推荐配置
- **Prettier格式化** - 统一代码风格
- **组件规范** - 单一职责，props类型定义
- **性能指标** - Bundle大小，首屏加载时间

### 4.2 测试覆盖要求
- **单元测试** - 组件逻辑覆盖率 > 80%
- **集成测试** - 关键用户流程覆盖
- **E2E测试** - 核心业务场景验证
- **可访问性测试** - WCAG 2.1 AA标准
- **性能测试** - Core Web Vitals指标

## 🎯 第五章：模式切换

### 5.1 手动切换命令
- `/ui设计` - 切换到UI设计模式
- `/组件开发` - 切换到组件开发模式
- `/工程化` - 切换到工程化模式
- `/测试` - 切换到测试模式
- `/优化` - 切换到优化模式

### 5.2 前端专用配置模式
- `/设置Vue优先模式` - 优先使用 Vue 3 技术栈，包括 Composition API、Pinia、Vue Router
- `/设置React优先模式` - 优先使用 React 18+ 技术栈，包括 Hooks、Zustand、React Router
- `/设置TypeScript严格模式` - 启用最严格的类型检查，强制类型安全
- `/设置性能优化模式` - 自动应用前端性能优化建议，包括代码分割、懒加载、缓存策略

### 5.3 反馈频率控制
- `/设置详细模式` - 启用所有反馈点，完整工作流反馈
- `/设置标准模式` - 关键决策点反馈（默认）
- `/设置静默模式` - 仅错误时反馈，适合熟练用户

### 5.4 工作流配置
- `/设置严格模式` - 严格按顺序执行，不允许跳过步骤
- `/设置灵活模式` - 允许模式跳转和流程调整（默认）
- `/设置快捷模式` - 简化某些步骤，提高开发效率

### 5.5 质量标准配置
- `/设置企业级标准` - 最高质量要求，完整测试覆盖
- `/设置标准级别` - 平衡质量和效率（默认）
- `/设置原型级别` - 快速验证，降低质量要求

### 5.6 智能模式识别
AI会根据用户描述自动判断并切换到合适模式：
- **UI/样式需求** → UI设计模式
- **组件实现请求** → 组件开发模式
- **构建配置问题** → 工程化模式
- **测试相关** → 测试模式
- **性能问题** → 优化模式

### 5.7 配置模式行为定义

#### 🟢 Vue优先模式 (`/设置Vue优先模式`)
**激活后AI行为变化：**
- 优先推荐 Vue 3 + Composition API 方案
- 自动建议 Vite + TypeScript 构建配置
- 推荐 Pinia 状态管理和 Vue Router 路由
- 建议 Element Plus 或 Naive UI 组件库
- 强调 `<script setup>` 语法和响应式API使用
- 推荐 Vitest 测试框架

#### ⚛️ React优先模式 (`/设置React优先模式`)
**激活后AI行为变化：**
- 优先推荐 React 18+ + Hooks 方案
- 自动建议 Vite 或 Create React App 配置
- 推荐 Zustand 或 Redux Toolkit 状态管理
- 建议 Ant Design 或 Material-UI 组件库
- 强调函数组件和现代 Hooks 使用
- 推荐 Jest + React Testing Library

#### 🔷 TypeScript严格模式 (`/设置TypeScript严格模式`)
**激活后AI行为变化：**
- 启用所有 TypeScript 严格检查选项
- 强制定义所有类型，禁止使用 any
- 自动生成详细的接口和类型定义
- 推荐使用泛型提高代码复用性
- 强调类型安全的组件 props 定义
- 建议配置严格的 ESLint TypeScript 规则

#### ⚡ 前端性能优化模式 (`/设置性能优化模式`)
**激活后AI行为变化：**
- 自动分析和建议前端性能优化点
- 优先推荐代码分割和懒加载策略
- 建议图片优化和 WebP 格式使用
- 推荐 Service Worker 和缓存策略
- 强调 Bundle 分析和 Tree Shaking
- 自动建议 Core Web Vitals 优化方案

#### 📋 反馈频率控制模式

##### 🔍 详细模式 (`/设置详细模式`)
**激活后AI行为变化：**
- 在每个开发步骤都请求用户确认
- 详细解释每个技术决策的原因
- 提供多种方案供用户选择
- 完整的代码审查和建议
- 详细的测试和部署指导

##### 📊 标准模式 (`/设置标准模式`) - 默认
**激活后AI行为变化：**
- 仅在关键决策点请求反馈
- 平衡详细程度和开发效率
- 重要架构和技术选型时确认
- 代码完成后进行验收确认

##### 🔇 静默模式 (`/设置静默模式`)
**激活后AI行为变化：**
- 仅在遇到错误或冲突时反馈
- 自动选择最佳实践方案
- 快速完成开发任务
- 适合经验丰富的开发者

#### 🔄 工作流配置模式

##### 📏 严格模式 (`/设置严格模式`)
**激活后AI行为变化：**
- 严格按照开发流程顺序执行
- 不允许跳过任何必要步骤
- 强制完成测试和文档
- 确保代码质量和规范性

##### 🔀 灵活模式 (`/设置灵活模式`) - 默认
**激活后AI行为变化：**
- 允许根据需要调整开发流程
- 支持模式间的灵活切换
- 可以跳过某些非关键步骤
- 平衡效率和质量

##### ⚡ 快捷模式 (`/设置快捷模式`)
**激活后AI行为变化：**
- 简化开发流程，提高效率
- 使用默认配置和最佳实践
- 减少不必要的确认步骤
- 快速原型开发和验证

#### 🏆 质量标准配置模式

##### 🏢 企业级标准 (`/设置企业级标准`)
**激活后AI行为变化：**
- 最高质量要求和完整测试覆盖
- 强制代码审查和文档完整性
- 严格的性能和安全标准
- 完整的CI/CD流程配置
- 详细的错误处理和日志记录

##### 📊 标准级别 (`/设置标准级别`) - 默认
**激活后AI行为变化：**
- 平衡质量和开发效率
- 基本的测试覆盖和代码规范
- 标准的性能和安全要求
- 基础的文档和注释

##### 🚀 原型级别 (`/设置原型级别`)
**激活后AI行为变化：**
- 快速验证和原型开发
- 降低质量要求，提高开发速度
- 简化测试和文档要求
- 专注核心功能实现

## 🎯 第六章：智能优先级决策矩阵

### 🤖 智能用户体验预测引擎
```yaml
智能决策系统:
  用户行为分析:
    - 交互路径预测 (点击热力图分析)
    - 用户流失点识别 (跳出率异常检测)
    - 设备使用模式分析 (移动端/桌面端偏好)
    - 性能影响评估 (加载时间对转化率影响)
  
  实时优化建议:
    - 界面布局自动优化
    - 交互流程简化建议
    - 性能瓶颈预警
    - 无障碍访问改进点
```

### 🚨 智能紧急响应 (P0 - 自动检测触发)
```yaml
自动监控系统:
  安全威胁检测:
    - XSS攻击模式识别
    - CSRF令牌验证失败
    - 敏感数据暴露检测
    - 第三方依赖安全漏洞
  
  用户体验危机:
    - 页面白屏/崩溃检测
    - 关键用户流程中断
    - 支付/登录功能异常
    - 移动端适配严重问题
  
  性能危机:
    - 首屏加载时间>3秒
    - 交互响应延迟>100ms
    - 内存使用异常增长
    - Bundle大小突增>50%
  
  自动响应策略:
    - 立即回滚到稳定版本
    - 触发降级方案
    - 通知开发团队
    - 生成详细错误报告
```

### ⚡ 智能高优先级 (P1 - 预测性优化)
```yaml
预测性用户体验优化:
  性能预测模型:
    - 基于用户行为预测负载峰值
    - 组件渲染性能趋势分析
    - 资源加载优化时机预测
    - 缓存策略效果评估
  
  用户体验预测:
    - A/B测试效果预估
    - 新功能用户接受度预测
    - 界面改版影响评估
    - 转化率优化机会识别
  
  技术债务预警:
    - 组件复杂度增长趋势
    - 依赖更新风险评估
    - 浏览器兼容性变化预测
    - 框架升级影响分析
```

### 📋 智能中优先级 (P2 - 持续优化)
```yaml
持续改进系统:
  用户体验持续优化:
    - 交互设计模式分析
    - 用户反馈情感分析
    - 界面美学评分系统
    - 可用性测试自动化
  
  代码质量提升:
    - 组件复用率分析
    - 状态管理复杂度评估
    - 测试覆盖率智能提升
    - 代码分割优化建议
  
  开发效率优化:
    - 组件开发模式识别
    - 工具链效率分析
    - 热重载性能优化
    - 调试工具使用优化
```

### 📝 智能低优先级 (P3 - 自动化处理)
```yaml
自动化维护系统:
  代码维护自动化:
    - 代码格式化自动应用
    - 依赖更新安全检查
    - 文档同步自动更新
    - 组件API文档生成
  
  开发环境优化:
    - 构建配置自动优化
    - 开发工具配置同步
    - 性能基准自动测试
    - 最佳实践自动应用
```

### 🔄 智能动态调整机制
```yaml
自适应学习系统:
  实时用户体验监控:
    - 用户行为模式学习
    - 交互满意度实时评估
    - 性能指标动态基准调整
    - 用户反馈情感分析
  
  多维度影响评估:
    用户体验影响:
      - 用户流失风险评估
      - 转化率影响预测
      - 品牌形象影响分析
      - 用户满意度变化趋势
    
    技术影响:
      - 系统稳定性风险
      - 性能影响范围评估
      - 维护成本分析
      - 技术债务累积评估
    
    业务影响:
      - 收入影响评估
      - 市场竞争力分析
      - 用户增长影响
      - 运营效率影响
  
  智能优先级调整:
    - 用户行为驱动的优先级算法
    - 业务价值与技术成本平衡
    - 团队能力与任务匹配
    - 发布周期与风险控制平衡
```

## ✅ 第七章：最佳实践

### 7.1 Vue 3 最佳实践
- 优先使用 Composition API
- 使用 `<script setup>` 语法
- 合理使用 ref 和 reactive
- 组件 props 定义类型
- 使用 provide/inject 进行依赖注入

### 7.2 React 18+ 最佳实践
- 使用函数组件和 Hooks
- 合理使用 useMemo 和 useCallback
- 避免不必要的重渲染
- 使用 Suspense 处理异步组件
- 实现错误边界组件

### 7.3 TypeScript 最佳实践
- 启用严格模式
- 定义清晰的接口和类型
- 使用泛型提高代码复用性
- 避免使用 any 类型
- 合理使用类型断言

### 7.4 性能优化最佳实践
- 代码分割和懒加载
- 图片优化和压缩
- 使用 CDN 加速静态资源
- 实施缓存策略
- 监控和分析性能指标
 
## Additional Commands for Trae AI 
 
---
description: "Standard commit workflow with conventional format and emojis - 标准化提交工作流"
globs: ["**/*"]
alwaysApply: true
---

# 📝 Commit Workflow - 提交工作流

创建格式良好的提交，使用约定式提交格式和描述性表情符号。

## 🚀 Commands - 命令

- `/commit` - 标准提交（包含预提交检查）
- `/commit --no-verify` - 跳过预提交检查的快速提交
- `/commit-fast` - 快速提交工作流，自动选择第一个消息

## ✨ Features - 功能特性

- 默认运行预提交检查（lint、build、生成文档）
- 如果没有暂存文件，自动暂存文件
- 使用约定式提交格式和描述性表情符号
- 建议为不同关注点拆分提交

## 📋 Commit Types - 提交类型

| 类型 | 表情符号 | 描述 | 示例 |
|------|----------|------|------|
| **feat** | ✨ | 新功能 | `✨ feat: 添加用户认证功能` |
| **fix** | 🐛 | Bug修复 | `🐛 fix: 修复登录页面验证错误` |
| **docs** | 📝 | 文档变更 | `📝 docs: 更新API文档` |
| **refactor** | ♻️ | 重构代码 | `♻️ refactor: 重构用户服务层` |
| **style** | 🎨 | 代码格式 | `🎨 style: 格式化代码，添加缺失分号` |
| **perf** | ⚡️ | 性能改进 | `⚡️ perf: 优化数据库查询性能` |
| **test** | ✅ | 测试相关 | `✅ test: 添加用户注册单元测试` |
| **chore** | 🧑‍💻 | 工具配置 | `🧑‍💻 chore: 更新构建配置` |
| **wip** | 🚧 | 进行中的工作 | `🚧 wip: 用户权限功能开发中` |
| **remove** | 🔥 | 删除代码 | `🔥 remove: 删除废弃的API接口` |
| **hotfix** | 🚑 | 紧急修复 | `🚑 hotfix: 修复生产环境登录问题` |
| **security** | 🔒 | 安全改进 | `🔒 security: 加强密码加密机制` |

## 📋 Process - 提交流程

### 1. 检查暂存变更
```bash
git status
```

### 2. 如果没有暂存变更，审查并暂存适当的文件
```bash
git add <files>
# 或者暂存所有变更
git add .
```

### 3. 运行预提交检查（除非使用 --no-verify）
- 代码检查 (lint)
- 构建验证
- 测试运行
- 文档生成

### 4. 分析变更以确定提交类型
- 查看修改的文件和内容
- 确定主要变更类型
- 考虑是否需要拆分为多个提交

### 5. 生成描述性提交消息
- 使用格式：`emoji type(scope): description`
- 包含作用域（如适用）：`type(scope): description`
- 为复杂变更添加正文，解释原因
- 引用相关问题/PR

### 6. 执行提交
```bash
git commit -m "✨ feat(auth): 添加JWT认证中间件

- 实现JWT token生成和验证
- 添加认证中间件到路由保护
- 更新用户模型包含token字段

Closes #123"
```

## ✅ Best Practices - 最佳实践

### 提交原则
- **原子性** - 保持提交专注和原子化
- **命令式语气** - 使用"添加功能"而不是"已添加功能"
- **解释原因** - 说明为什么，而不仅仅是什么
- **引用问题** - 在相关时引用问题/PR
- **拆分变更** - 将不相关的变更拆分为单独的提交

### 消息格式
```
<emoji> <type>(<scope>): <description>

<body>

<footer>
```

### 示例提交消息

**简单功能添加：**
```
✨ feat: 添加用户头像上传功能
```

**带作用域的修复：**
```
🐛 fix(api): 修复用户查询接口分页错误
```

**复杂变更带正文：**
```
♻️ refactor(database): 重构用户数据访问层

- 将原始SQL查询迁移到ORM
- 添加数据库连接池配置
- 优化查询性能和内存使用

性能提升约30%，代码可维护性显著改善

Closes #456
```

## 🔧 Pre-commit Checks - 预提交检查

### 自动运行的检查
1. **代码检查** - ESLint, Prettier, 等
2. **类型检查** - TypeScript, mypy, 等
3. **测试运行** - 单元测试和集成测试
4. **构建验证** - 确保代码可以成功构建
5. **文档生成** - 自动更新API文档

### 跳过检查
```bash
# 紧急情况下跳过预提交检查
git commit --no-verify -m "🚑 hotfix: 紧急修复生产问题"
```

## 📋 Checklist - 检查清单

### 提交前
- [ ] 变更已审查和测试
- [ ] 提交消息清晰描述性
- [ ] 使用正确的提交类型和表情符号
- [ ] 包含相关的作用域
- [ ] 引用相关问题/PR

### 提交后
- [ ] 推送到远程仓库
- [ ] 检查CI/CD流水线状态
- [ ] 更新相关文档
- [ ] 通知团队成员（如需要）

## 🎯 Integration - 集成

### Git Hooks
```bash
# 安装预提交钩子
npm install --save-dev husky lint-staged

# 配置 package.json
{
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged"
    }
  },
  "lint-staged": {
    "*.{js,ts,vue}": ["eslint --fix", "git add"],
    "*.{css,scss}": ["stylelint --fix", "git add"]
  }
}
```

### 与CI/CD集成
- 自动触发构建和测试
- 代码质量检查
- 自动部署到测试环境
- 生成变更日志
 
---
description: "Multi-role pull request review checklist - 多角色拉取请求审查清单"
globs: ["**/*"]
alwaysApply: false
---

# 🔍 Code Review Workflow - 代码审查工作流

多角色拉取请求审查清单，确保代码质量和团队协作。

## 🚀 Commands - 命令

- `/code-review` - 启动代码审查流程
- `/review-checklist` - 显示审查清单
- `/security-review` - 安全审查
- `/performance-review` - 性能审查

## 👥 Review Roles - 审查角色

### 🧑‍💻 Developer Review - 开发者审查
**关注点：代码逻辑、可读性、最佳实践**

#### Checklist - 检查清单
- [ ] **代码逻辑正确** - 实现符合需求，逻辑清晰
- [ ] **命名规范** - 变量、函数、类名有意义且一致
- [ ] **代码复用** - 避免重复代码，合理抽象
- [ ] **错误处理** - 适当的异常处理和边界条件
- [ ] **注释质量** - 复杂逻辑有清晰注释
- [ ] **代码风格** - 遵循项目编码规范

#### Questions to Ask - 审查问题
- 这段代码是否易于理解和维护？
- 是否有更简洁的实现方式？
- 错误处理是否充分？
- 是否遵循了SOLID原则？

### 🏗️ Architecture Review - 架构审查
**关注点：设计模式、系统架构、扩展性**

#### Checklist - 检查清单
- [ ] **设计模式** - 使用合适的设计模式
- [ ] **模块划分** - 职责分离，模块边界清晰
- [ ] **依赖管理** - 依赖注入，避免循环依赖
- [ ] **接口设计** - API设计合理，向后兼容
- [ ] **扩展性** - 代码易于扩展和修改
- [ ] **性能考虑** - 算法复杂度合理

#### Questions to Ask - 审查问题
- 这个设计是否符合系统整体架构？
- 是否引入了不必要的复杂性？
- 如何处理未来的需求变更？
- 是否有潜在的性能瓶颈？

### 🔒 Security Review - 安全审查
**关注点：安全漏洞、数据保护、权限控制**

#### Checklist - 检查清单
- [ ] **输入验证** - 所有用户输入都经过验证
- [ ] **SQL注入防护** - 使用参数化查询
- [ ] **XSS防护** - 输出编码，CSP配置
- [ ] **认证授权** - 权限检查完整
- [ ] **敏感数据** - 密码、token等安全存储
- [ ] **HTTPS使用** - 敏感操作使用HTTPS

#### Questions to Ask - 审查问题
- 是否存在潜在的安全漏洞？
- 敏感数据是否得到适当保护？
- 权限控制是否足够严格？
- 是否遵循了安全最佳实践？

### ⚡ Performance Review - 性能审查
**关注点：性能优化、资源使用、扩展性**

#### Checklist - 检查清单
- [ ] **算法效率** - 时间和空间复杂度合理
- [ ] **数据库查询** - 查询优化，避免N+1问题
- [ ] **缓存策略** - 合理使用缓存
- [ ] **资源管理** - 内存泄漏，连接池管理
- [ ] **并发处理** - 线程安全，死锁预防
- [ ] **监控指标** - 关键性能指标监控

#### Questions to Ask - 审查问题
- 这段代码在高负载下表现如何？
- 是否有性能优化的空间？
- 资源使用是否合理？
- 如何监控和调试性能问题？

## 📋 Review Process - 审查流程

### 1. Pre-Review Preparation - 审查前准备
```bash
# 检查PR信息
- PR标题和描述清晰
- 关联相关Issue
- 包含测试用例
- CI/CD检查通过
```

### 2. Code Review Steps - 代码审查步骤

#### Step 1: Overview - 概览
- 理解PR的目的和范围
- 检查文件变更列表
- 评估变更的影响范围

#### Step 2: Detailed Review - 详细审查
- 逐文件审查代码变更
- 应用相应角色的检查清单
- 标记问题和改进建议

#### Step 3: Testing Review - 测试审查
- 检查测试覆盖率
- 验证测试用例质量
- 确认边界条件测试

#### Step 4: Documentation Review - 文档审查
- API文档更新
- README和使用指南
- 代码注释完整性

### 3. Feedback Guidelines - 反馈指南

#### 反馈分类
- **🚨 Critical** - 重要问题建议修复
- **💡 Suggestion** - 改进建议
- **❓ Question** - 需要澄清的问题
- **👍 Praise** - 好的实践值得表扬

#### 反馈示例
```markdown
🚨 Must Fix: 这里存在SQL注入风险
建议使用参数化查询：`SELECT * FROM users WHERE id = ?`

💡 Suggestion: 考虑使用工厂模式来创建不同类型的处理器
这样可以提高代码的可扩展性

❓ Question: 为什么选择这种算法？
是否考虑过时间复杂度的影响？

👍 Praise: 错误处理很完善，边界条件考虑周全
```

## 🛠️ Tools Integration - 工具集成

### Automated Checks - 自动化检查
```yaml
# GitHub Actions 示例
name: Code Review Automation
on: [pull_request]
jobs:
  code-quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run ESLint
        run: npm run lint
      - name: Run Tests
        run: npm test
      - name: Security Scan
        run: npm audit
      - name: Performance Test
        run: npm run perf-test
```

### Review Templates - 审查模板
```markdown
## Code Review Checklist

### Developer Review
- [ ] Code logic is correct
- [ ] Naming conventions followed
- [ ] Error handling appropriate
- [ ] Code is readable and maintainable

### Security Review
- [ ] Input validation implemented
- [ ] No SQL injection vulnerabilities
- [ ] Authentication/authorization proper
- [ ] Sensitive data protected

### Performance Review
- [ ] Algorithm efficiency acceptable
- [ ] Database queries optimized
- [ ] Resource usage reasonable
- [ ] Monitoring in place
```

## 📊 Review Metrics - 审查指标

### Quality Metrics - 质量指标
- **Review Coverage** - 审查覆盖率
- **Defect Detection Rate** - 缺陷检出率
- **Review Turnaround Time** - 审查周转时间
- **Rework Rate** - 返工率

### Tracking Template - 跟踪模板
```markdown
## Review Summary
- **Reviewer**: @username
- **Review Time**: 30 minutes
- **Issues Found**: 3 must-fix, 2 suggestions
- **Security Issues**: 1
- **Performance Issues**: 0
- **Overall Rating**: Approve with changes
```

## ✅ Best Practices - 最佳实践

### For Reviewers - 审查者
- **及时审查** - 在24小时内完成审查
- **建设性反馈** - 提供具体的改进建议
- **平衡严格性** - 既要保证质量，也要考虑效率
- **学习心态** - 从代码中学习新的技术和方法

### For Authors - 作者
- **小而频繁** - 保持PR大小合理（<400行）
- **清晰描述** - 详细说明变更内容和原因
- **自我审查** - 提交前先自己审查一遍
- **积极响应** - 及时回应审查意见

### For Teams - 团队
- **审查文化** - 建立积极的代码审查文化
- **知识分享** - 通过审查分享最佳实践
- **持续改进** - 定期回顾和改进审查流程
- **工具支持** - 使用合适的工具提高效率
 
---
description: "Complete bug-fixing workflow from issue to PR - 从问题到PR的完整Bug修复工作流"
globs: ["**/*"]
alwaysApply: false
---

# 🐛 Bug Fix Workflow - Bug修复工作流

从问题创建到拉取请求的完整Bug修复工作流程。

## 🚀 Commands - 命令

- `/bug-fix` - 启动Bug修复工作流
- `/reproduce-bug` - 重现Bug
- `/root-cause` - 根因分析
- `/fix-verify` - 修复验证

## 📋 Process - 修复流程

### 🔍 Before Starting - 开始前准备

#### 1. GitHub Issue Creation - 创建GitHub问题
```markdown
**Bug标题**: [组件/模块] 简短描述性标题

**环境信息**:
- 操作系统: Windows 11 / macOS 13 / Ubuntu 22.04
- 浏览器: Chrome 120 / Firefox 121 / Safari 17
- 应用版本: v2.1.0
- Node.js版本: v18.19.0

**重现步骤**:
1. 打开应用
2. 点击登录按钮
3. 输入有效凭据
4. 点击提交

**预期行为**: 用户应该成功登录并跳转到仪表板

**实际行为**: 显示"网络错误"，用户停留在登录页面

**错误信息**:
```
TypeError: Cannot read property 'token' of undefined
  at LoginComponent.handleLogin (login.component.ts:45)
```

**截图/录屏**: [附加相关截图或录屏]

**优先级**: High / Medium / Low
**标签**: bug, frontend, authentication
```

#### 2. Git Branch Creation - 创建Git分支
```bash
# 创建并切换到功能分支
git checkout -b fix/login-token-error

# 或者使用更具描述性的分支名
git checkout -b fix/issue-123-login-authentication-error
```

### 🔧 Fix the Bug - 修复Bug

#### Step 1: Reproduce the Issue - 重现问题
```bash
# 1. 切换到问题分支
git checkout main
git pull origin main

# 2. 尝试重现Bug
npm start
# 按照问题描述的步骤操作

# 3. 确认问题存在
# 记录重现步骤和错误信息
```

#### Step 2: Write Failing Test - 编写失败测试
```javascript
// 示例：为Bug编写测试用例
describe('LoginComponent', () => {
  it('should handle login with valid credentials', async () => {
    // 这个测试应该失败，因为Bug存在
    const mockUser = { username: 'test', password: 'password' };
    const result = await loginComponent.handleLogin(mockUser);
    
    expect(result.success).toBe(true);
    expect(result.token).toBeDefined();
    expect(result.user).toEqual(expect.objectContaining({
      username: 'test'
    }));
  });

  it('should handle undefined response gracefully', async () => {
    // 测试边界条件
    mockApiService.login.mockResolvedValue(undefined);
    
    const result = await loginComponent.handleLogin(mockUser);
    expect(result.success).toBe(false);
    expect(result.error).toBeDefined();
  });
});
```

#### Step 3: Implement the Fix - 实现修复
```typescript
// 修复前的代码
async handleLogin(credentials: LoginCredentials) {
  try {
    const response = await this.authService.login(credentials);
    // Bug: 没有检查response是否存在
    localStorage.setItem('token', response.token);
    this.router.navigate(['/dashboard']);
  } catch (error) {
    this.showError('登录失败');
  }
}

// 修复后的代码
async handleLogin(credentials: LoginCredentials) {
  try {
    const response = await this.authService.login(credentials);
    
    // 修复: 添加响应验证
    if (!response || !response.token) {
      throw new Error('Invalid response from server');
    }
    
    localStorage.setItem('token', response.token);
    this.router.navigate(['/dashboard']);
    return { success: true, token: response.token, user: response.user };
  } catch (error) {
    console.error('Login error:', error);
    this.showError('登录失败: ' + error.message);
    return { success: false, error: error.message };
  }
}
```

#### Step 4: Verify Test Passes - 验证测试通过
```bash
# 运行特定测试
npm test -- --grep "LoginComponent"

# 运行所有测试
npm test

# 确保测试通过
✓ should handle login with valid credentials
✓ should handle undefined response gracefully
```

#### Step 5: Run Full Test Suite - 运行完整测试套件
```bash
# 运行所有测试确保没有回归
npm run test:all

# 运行端到端测试
npm run test:e2e

# 运行代码检查
npm run lint

# 运行类型检查
npm run type-check
```

### ✅ On Completion - 完成后操作

#### 1. Git Commit - Git提交
```bash
# 暂存变更
git add .

# 提交变更，引用问题编号
git commit -m "🐛 fix(auth): 修复登录时token未定义错误 (#123)

- 添加响应验证防止undefined错误
- 改进错误处理和用户反馈
- 添加边界条件测试用例

修复了当服务器返回空响应时的崩溃问题
现在会显示有意义的错误消息给用户

Fixes #123"
```

#### 2. Push Branch - 推送分支
```bash
# 推送分支到远程仓库
git push origin fix/login-token-error
```

#### 3. Create Pull Request - 创建拉取请求
```markdown
## 🐛 Bug Fix: 修复登录时token未定义错误

### 问题描述
修复 #123 - 用户登录时遇到"Cannot read property 'token' of undefined"错误

### 根本原因
当认证服务返回空响应或格式不正确的响应时，代码没有进行适当的验证就尝试访问`token`属性。

### 解决方案
- ✅ 添加响应验证逻辑
- ✅ 改进错误处理机制
- ✅ 添加有意义的用户反馈
- ✅ 增加边界条件测试

### 测试
- [x] 单元测试通过
- [x] 集成测试通过
- [x] 手动测试验证
- [x] 回归测试通过

### 影响范围
- 仅影响登录组件
- 向后兼容
- 无破坏性变更

### 截图/录屏
[添加修复后的截图或录屏]

### 检查清单
- [x] 代码审查完成
- [x] 测试覆盖率充足
- [x] 文档已更新
- [x] 无安全风险
```

## 🔍 Root Cause Analysis - 根因分析

### Five Whys Technique - 五个为什么技术
```
1. 为什么登录失败？
   → 因为代码尝试访问undefined对象的token属性

2. 为什么response是undefined？
   → 因为API服务在某些情况下返回空响应

3. 为什么API服务返回空响应？
   → 因为网络超时或服务器错误时没有正确处理

4. 为什么没有验证响应？
   → 因为开发时假设API总是返回有效响应

5. 为什么没有考虑错误情况？
   → 因为缺少错误处理的最佳实践指导
```

### Prevention Measures - 预防措施
- 添加响应验证模式
- 实施错误处理标准
- 增加边界条件测试
- 代码审查检查清单更新

## 📊 Bug Categories - Bug分类

### Severity Levels - 严重程度
- **Critical** - 系统崩溃，数据丢失
- **High** - 核心功能无法使用
- **Medium** - 功能受限，有变通方案
- **Low** - 界面问题，不影响功能

### Bug Types - Bug类型
- **Logic Error** - 逻辑错误
- **Runtime Error** - 运行时错误
- **UI/UX Issue** - 界面/体验问题
- **Performance** - 性能问题
- **Security** - 安全漏洞
- **Compatibility** - 兼容性问题

## 🛠️ Tools and Techniques - 工具和技术

### Debugging Tools - 调试工具
```bash
# 浏览器开发者工具
F12 → Console/Network/Sources

# Node.js调试
node --inspect-brk app.js

# VS Code调试配置
{
  "type": "node",
  "request": "launch",
  "name": "Debug App",
  "program": "${workspaceFolder}/src/index.js"
}
```

### Logging and Monitoring - 日志和监控
```javascript
// 结构化日志
console.log('Login attempt', {
  timestamp: new Date().toISOString(),
  userId: credentials.username,
  userAgent: navigator.userAgent,
  error: error.message
});

// 错误监控集成
import * as Sentry from '@sentry/browser';
Sentry.captureException(error);
```

## ✅ Best Practices - 最佳实践

### Bug Prevention - Bug预防
- **代码审查** - 所有代码变更都要审查
- **测试驱动** - 先写测试，后写代码
- **静态分析** - 使用ESLint、TypeScript等工具
- **持续集成** - 自动化测试和部署

### Bug Fixing - Bug修复
- **重现优先** - 确保能稳定重现Bug
- **最小变更** - 只修改必要的代码
- **测试覆盖** - 为Bug添加测试用例
- **文档更新** - 更新相关文档

### Communication - 沟通
- **及时更新** - 定期更新Issue状态
- **清晰描述** - 详细描述问题和解决方案
- **知识分享** - 分享修复经验和教训
 
---
description: "Mermaid diagram generation for various visualizations - Mermaid图表生成工具"
globs: ["**/*.md", "**/*.mdx", "**/*.mmd"]
alwaysApply: false
---

# 📊 Mermaid Diagrams - Mermaid图表

使用Mermaid创建各种类型的图表和可视化。

## 🚀 Commands - 命令

- `/mermaid` - 创建Mermaid图表
- `/flowchart` - 创建流程图
- `/sequence` - 创建时序图
- `/class-diagram` - 创建类图
- `/er-diagram` - 创建实体关系图

## 📋 Diagram Types - 图表类型

### 1. 🔄 流程图 (Flowchart)
```mermaid
flowchart TD
    A[开始] --> B{条件判断}
    B -->|是| C[执行操作A]
    B -->|否| D[执行操作B]
    C --> E[结束]
    D --> E
```

### 2. ⏱️ 时序图 (Sequence Diagram)
```mermaid
sequenceDiagram
    participant U as 用户
    participant F as 前端
    participant B as 后端
    participant D as 数据库
    
    U->>F: 登录请求
    F->>B: 验证用户
    B->>D: 查询用户信息
    D-->>B: 返回用户数据
    B-->>F: 返回认证结果
    F-->>U: 显示登录状态
```

### 3. 🏗️ 类图 (Class Diagram)
```mermaid
classDiagram
    class User {
        +String name
        +String email
        +login()
        +logout()
    }
    
    class Admin {
        +String permissions
        +manageUsers()
    }
    
    User <|-- Admin
```

### 4. 🗄️ 实体关系图 (ER Diagram)
```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : "ordered in"
    
    USER {
        int id PK
        string name
        string email
    }
    
    ORDER {
        int id PK
        int user_id FK
        date created_at
    }
```

### 5. 🌳 Git图 (Git Graph)
```mermaid
gitgraph
    commit id: "Initial"
    branch develop
    checkout develop
    commit id: "Feature A"
    commit id: "Feature B"
    checkout main
    merge develop
    commit id: "Release v1.0"
```

### 6. 📊 甘特图 (Gantt Chart)
```mermaid
gantt
    title 项目开发计划
    dateFormat  YYYY-MM-DD
    section 需求分析
    需求调研    :done, des1, 2024-01-01, 2024-01-05
    需求文档    :done, des2, after des1, 3d
    section 开发阶段
    前端开发    :active, dev1, 2024-01-08, 10d
    后端开发    :dev2, 2024-01-08, 12d
    section 测试阶段
    单元测试    :test1, after dev1, 3d
    集成测试    :test2, after dev2, 2d
```

### 7. 🍰 饼图 (Pie Chart)
```mermaid
pie title 技术栈分布
    "Vue.js" : 35
    "React" : 30
    "Angular" : 15
    "其他" : 20
```

### 8. 📈 用户旅程图 (User Journey)
```mermaid
journey
    title 用户购物体验
    section 发现产品
      浏览首页: 5: 用户
      搜索产品: 3: 用户
      查看详情: 4: 用户
    section 购买决策
      比较价格: 2: 用户
      查看评价: 4: 用户
      添加购物车: 5: 用户
    section 完成购买
      结算支付: 3: 用户
      确认订单: 5: 用户
```

## 🛠️ Common Patterns - 常用模式

### 前端架构图
```mermaid
graph TB
    subgraph "前端层"
        A[Vue/React组件]
        B[状态管理]
        C[路由管理]
    end
    
    subgraph "服务层"
        D[API服务]
        E[工具函数]
        F[常量配置]
    end
    
    subgraph "后端层"
        G[REST API]
        H[GraphQL]
        I[WebSocket]
    end
    
    A --> B
    A --> C
    A --> D
    D --> G
    D --> H
    D --> I
```

### 数据流图
```mermaid
flowchart LR
    A[用户输入] --> B[表单验证]
    B --> C{验证通过?}
    C -->|是| D[发送请求]
    C -->|否| E[显示错误]
    D --> F[API处理]
    F --> G[数据库操作]
    G --> H[返回结果]
    H --> I[更新界面]
    E --> A
```

### 组件关系图
```mermaid
graph TD
    A[App.vue] --> B[Header.vue]
    A --> C[Main.vue]
    A --> D[Footer.vue]
    
    C --> E[Sidebar.vue]
    C --> F[Content.vue]
    
    F --> G[UserList.vue]
    F --> H[UserDetail.vue]
    
    G --> I[UserCard.vue]
    H --> J[UserForm.vue]
```

## ✅ Best Practices - 最佳实践

### 设计原则
- **简洁明了** - 避免过于复杂的图表
- **层次清晰** - 合理的信息层级
- **色彩协调** - 统一的配色方案
- **标注完整** - 清晰的标签和说明

### 使用场景
- **架构设计** - 系统架构和模块关系
- **流程说明** - 业务流程和操作步骤
- **数据建模** - 数据结构和关系
- **项目管理** - 进度计划和里程碑

### 维护策略
- **版本控制** - 图表文件纳入版本管理
- **文档同步** - 与代码保持同步更新
- **格式统一** - 统一的图表风格
- **定期审查** - 定期检查图表准确性

## 🔧 Integration - 集成

### Markdown支持
```markdown
# 系统架构

以下是系统的整体架构：

\`\`\`mermaid
graph TB
    A[前端] --> B[API网关]
    B --> C[微服务]
    C --> D[数据库]
\`\`\`
```

### 文档工具集成
- **VitePress** - 原生支持Mermaid
- **Docusaurus** - 插件支持
- **GitBook** - 内置支持
- **Notion** - 代码块支持

### 导出格式
- **SVG** - 矢量图形
- **PNG** - 位图格式
- **PDF** - 文档格式
- **HTML** - 网页嵌入

## 📋 Templates - 模板

### 系统设计模板
```mermaid
graph TB
    subgraph "客户端"
        A[Web应用]
        B[移动应用]
    end
    
    subgraph "服务端"
        C[负载均衡]
        D[应用服务器]
        E[数据库]
    end
    
    A --> C
    B --> C
    C --> D
    D --> E
```

### API设计模板
```mermaid
sequenceDiagram
    participant C as 客户端
    participant G as API网关
    participant S as 服务
    participant D as 数据库
    
    C->>G: HTTP请求
    G->>S: 转发请求
    S->>D: 查询数据
    D-->>S: 返回数据
    S-->>G: 处理结果
    G-->>C: HTTP响应
```

## 📋 Checklist - 检查清单

### 图表设计
- [ ] 目的明确，信息准确
- [ ] 结构清晰，层次分明
- [ ] 标注完整，易于理解
- [ ] 风格统一，美观大方

### 技术实现
- [ ] 语法正确，渲染正常
- [ ] 兼容性良好，跨平台支持
- [ ] 性能优化，加载快速
- [ ] 维护方便，易于更新

### 文档集成
- [ ] 与文档系统集成
- [ ] 版本控制管理
- [ ] 自动化生成
- [ ] 定期更新维护
 
---
description: "Comprehensive documentation generation - 全面的文档生成"
globs: ["**/*.md", "**/*.mdx", "**/*.rst", "**/*.txt"]
alwaysApply: false
---

# 📝 Documentation Creation - 文档创建

生成全面、结构化的项目文档。

## 🚀 Commands - 命令

- `/create-docs` - 创建完整文档
- `/api-docs` - 生成API文档
- `/user-guide` - 创建用户指南
- `/dev-docs` - 开发者文档

## 📋 Process - 文档流程

### 1. 📊 文档规划 (Documentation Planning)
- 分析目标受众和使用场景
- 确定文档结构和内容范围
- 选择合适的文档工具和格式
- **转换条件**：文档规划完整，结构清晰

### 2. ✍️ 内容创建 (Content Creation)
- 编写核心文档内容
- 添加代码示例和截图
- 创建图表和流程图
- **转换条件**：内容完整，质量达标

### 3. 🔍 审查优化 (Review & Optimization)
- 检查内容准确性和完整性
- 优化文档结构和可读性
- 添加导航和索引
- **转换条件**：文档质量优秀，用户友好

### 4. 🚀 发布维护 (Publish & Maintain)
- 发布到文档平台
- 设置自动更新机制
- 收集用户反馈
- **转换条件**：文档发布成功，维护机制完善

## 📚 Documentation Types - 文档类型

### 用户文档 (User Documentation)
- **README** - 项目概述和快速开始
- **用户指南** - 详细使用说明
- **FAQ** - 常见问题解答
- **教程** - 分步骤学习指南

### 开发者文档 (Developer Documentation)
- **API文档** - 接口规范和示例
- **架构文档** - 系统设计和结构
- **贡献指南** - 开发参与规范
- **部署指南** - 环境配置和部署

### 技术文档 (Technical Documentation)
- **设计文档** - 技术方案和决策
- **测试文档** - 测试策略和用例
- **运维文档** - 监控和故障处理
- **变更日志** - 版本更新记录

## 🛠️ Documentation Tools - 文档工具

### 静态站点生成器
- **VitePress** - Vue生态文档工具
- **Docusaurus** - React生态文档平台
- **GitBook** - 在线文档协作
- **Notion** - 团队知识库

### API文档工具
- **Swagger/OpenAPI** - REST API文档
- **GraphQL Playground** - GraphQL API文档
- **Postman** - API测试和文档
- **Insomnia** - API设计和测试

### 图表工具
- **Mermaid** - 代码化图表
- **Draw.io** - 在线图表编辑
- **PlantUML** - UML图表生成
- **Excalidraw** - 手绘风格图表

## 📋 Documentation Template - 文档模板

### README模板
```markdown
# 项目名称

简短的项目描述

## 🚀 快速开始

### 安装
\`\`\`bash
npm install
\`\`\`

### 使用
\`\`\`bash
npm start
\`\`\`

## 📚 文档

- [用户指南](./docs/user-guide.md)
- [API文档](./docs/api.md)
- [开发指南](./docs/development.md)

## 🤝 贡献

请阅读 [贡献指南](./CONTRIBUTING.md)

## 📄 许可证

[MIT](./LICENSE)
```

### API文档模板
```markdown
# API文档

## 认证

所有API请求需要包含认证头：
\`\`\`
Authorization: Bearer <token>
\`\`\`

## 端点

### GET /api/users

获取用户列表

**参数：**
- `page` (number) - 页码，默认1
- `limit` (number) - 每页数量，默认10

**响应：**
\`\`\`json
{
  "data": [...],
  "total": 100,
  "page": 1
}
\`\`\`
```

## ✅ Best Practices - 最佳实践

### 内容原则
- **用户导向** - 从用户角度组织内容
- **简洁明了** - 避免冗余和复杂表述
- **示例丰富** - 提供充足的代码示例
- **及时更新** - 保持文档与代码同步

### 结构设计
- **层次清晰** - 合理的标题层级
- **导航便利** - 清晰的目录和链接
- **搜索友好** - 关键词和标签优化
- **移动适配** - 响应式设计

### 维护策略
- **版本控制** - 文档版本管理
- **自动化** - 自动生成和更新
- **反馈机制** - 用户意见收集
- **定期审查** - 内容质量检查

## 🔧 Automation - 自动化

### 文档生成
```bash
# 生成API文档
npm run docs:api

# 生成类型文档
npm run docs:types

# 构建文档站点
npm run docs:build
```

### CI/CD集成
```yaml
# .github/workflows/docs.yml
name: Documentation
on:
  push:
    branches: [main]
jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Generate docs
        run: npm run docs:build
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
```

## 📋 Checklist - 检查清单

### 内容检查
- [ ] 信息准确完整
- [ ] 示例代码可运行
- [ ] 链接有效可访问
- [ ] 图片清晰有意义

### 结构检查
- [ ] 目录结构合理
- [ ] 导航清晰便利
- [ ] 搜索功能正常
- [ ] 移动端适配良好

### 质量检查
- [ ] 语法拼写正确
- [ ] 格式统一规范
- [ ] 版本信息准确
- [ ] 更新日期最新
 
---
description: "Methodical task implementation approach - 系统化任务实现方法"
globs: ["**/*"]
alwaysApply: false
---

# 🎯 Task Implementation - 任务实现

系统化的任务实现方法，确保高质量交付。

## 🚀 Commands - 命令

- `/implement-task` - 开始任务实现
- `/task-plan` - 制定实现计划
- `/task-review` - 任务审查
- `/task-complete` - 完成任务

## 📋 Process - 实现流程

### 1. 📊 任务分析 (Task Analysis)
- 理解任务需求和目标
- 分析技术要求和约束
- 识别依赖和风险
- **转换条件**：需求清晰，方案可行

### 2. 📝 实现规划 (Implementation Planning)
- 制定详细实现计划
- 分解子任务和里程碑
- 分配资源和时间
- **转换条件**：计划完整，可执行

### 3. 🔨 代码实现 (Code Implementation)
- 按计划实现功能
- 遵循代码规范
- 编写测试用例
- **转换条件**：功能完成，测试通过

### 4. ✅ 质量保证 (Quality Assurance)
- 代码审查和重构
- 性能优化
- 文档更新
- **转换条件**：质量达标，文档完整

### 5. 🚀 交付部署 (Delivery & Deployment)
- 集成测试
- 部署到环境
- 用户验收
- **转换条件**：验收通过，部署成功

## 🛠️ Implementation Strategy - 实现策略

### 分解原则
- **垂直切分** - 按功能模块分解
- **水平切分** - 按技术层次分解
- **优先级排序** - 核心功能优先
- **依赖管理** - 合理安排依赖顺序

### 开发模式
- **TDD** - 测试驱动开发
- **BDD** - 行为驱动开发
- **DDD** - 领域驱动设计
- **敏捷开发** - 迭代增量

### 质量控制
- **代码审查** - Peer Review
- **自动化测试** - 单元/集成测试
- **静态分析** - 代码质量检查
- **性能监控** - 运行时监控

## 📋 Task Template - 任务模板

### 任务实现计划
```markdown
## 任务概述

**任务名称**：[任务名称]
**优先级**：高/中/低
**预估工期**：X天
**负责人**：[姓名]

## 需求分析

### 功能需求
- [ ] 需求1：描述
- [ ] 需求2：描述

### 非功能需求
- [ ] 性能要求
- [ ] 安全要求
- [ ] 可用性要求

## 技术方案

### 架构设计
- 系统架构图
- 模块划分
- 接口设计

### 技术选型
- 框架/库选择
- 工具链配置
- 环境要求

## 实现计划

### 里程碑
1. [ ] 里程碑1 (Day 1-2)
2. [ ] 里程碑2 (Day 3-4)
3. [ ] 里程碑3 (Day 5-6)

### 风险识别
- 风险1：描述 + 缓解方案
- 风险2：描述 + 缓解方案

## 验收标准

### 功能验收
- [ ] 功能1测试通过
- [ ] 功能2测试通过

### 质量验收
- [ ] 代码覆盖率 > 80%
- [ ] 性能指标达标
- [ ] 安全扫描通过
```

## ✅ Best Practices - 最佳实践

### 实现原则
- **小步快跑** - 频繁提交和集成
- **持续反馈** - 及时沟通和调整
- **质量优先** - 不妥协代码质量
- **文档同步** - 代码和文档同步更新

### 协作方式
- **每日站会** - 同步进展和问题
- **代码审查** - 知识分享和质量保证
- **结对编程** - 复杂问题协作解决
- **技术分享** - 经验总结和传播

### 工具使用
- **版本控制** - Git工作流
- **项目管理** - 看板和燃尽图
- **自动化** - CI/CD流水线
- **监控告警** - 运行时监控

## 🔧 Tools Integration - 工具集成

### 开发工具
```bash
# 代码生成
npm run generate:component
npm run generate:api

# 代码检查
npm run lint
npm run type-check

# 测试运行
npm run test
npm run test:coverage

# 构建部署
npm run build
npm run deploy
```

### 项目管理
- **Jira** - 任务跟踪
- **Trello** - 看板管理
- **GitHub Projects** - 项目规划
- **Notion** - 文档协作

## 📊 Progress Tracking - 进度跟踪

### 进度指标
- **完成度** - 已完成/总任务数
- **质量指标** - 缺陷密度、覆盖率
- **效率指标** - 速度、生产力
- **风险指标** - 风险数量和等级

### 报告机制
- **日报** - 每日进展和问题
- **周报** - 周度总结和计划
- **里程碑报告** - 阶段性成果
- **项目总结** - 经验教训

## 📋 Checklist - 检查清单

### 开始前
- [ ] 需求理解清晰
- [ ] 技术方案确定
- [ ] 资源配置到位
- [ ] 环境准备就绪

### 实现中
- [ ] 按计划执行
- [ ] 质量标准遵循
- [ ] 进度及时汇报
- [ ] 风险主动管理

### 完成后
- [ ] 功能测试通过
- [ ] 代码审查完成
- [ ] 文档更新完整
- [ ] 部署验证成功
 
---
description: "Enhanced feedback mechanism with 1-hour timeout - 增强反馈机制，1小时超时"
globs: ["**/*"]
alwaysApply: true
---

# 🤖 Enhanced Feedback Mechanism - 增强反馈机制

专为复杂开发任务设计的智能反馈系统，支持1小时超时的深度交互。

## 🚀 Commands - 命令

- `/feedback` - 手动触发反馈
- `/feedback-config` - 配置反馈设置
- `/feedback-history` - 查看反馈历史
- `/feedback-summary` - 生成工作摘要

## ✨ Features - 功能特性

### 🕐 Extended Timeout - 扩展超时
- **1小时超时** - 充足时间进行复杂架构讨论
- **自动保存** - 防止长时间讨论中的数据丢失
- **断点续传** - 支持中断后继续讨论

### 📝 Rich Text Support - 富文本支持
- **代码片段** - 语法高亮的代码展示
- **架构图** - Mermaid图表支持
- **配置文件** - 格式化的配置展示
- **截图支持** - 图片和截图集成

### 🔄 Real-time Interaction - 实时交互
- **双向沟通** - AI与用户的实时对话
- **进度跟踪** - 任务进度实时更新
- **决策记录** - 重要决策自动记录

## 📋 Trigger Conditions - 触发条件

### 🔍 详细模式特殊规则
```
触发条件: 用户设置了详细模式 (/设置详细模式)
行为变化: 每次会话开始时自动调用反馈增强界面
目的: 确保用户对每个开发步骤都有充分的参与和确认
实现方式: 
- 会话开始时自动触发 interactive_feedback
- 提供当前任务概览和需要确认的要点
- 收集用户的详细需求和偏好设置
- 建立完整的沟通和反馈机制

### 🔧 图片处理修复
```
技术修复要点:
• 移除 fastmcp.utilities.types.Image 导入
• 使用 mcp.types.ImageContent 替代
• 确保图片内容正确序列化为JSON格式
• 避免在反馈工具中直接传递Image对象
```
```

### 自动触发场景

#### 🔍 需求不明确
```
触发条件: 用户描述模糊或存在歧义
示例: "帮我做个网站" (缺少具体需求)
反馈内容: 
- 项目类型和规模
- 技术栈偏好
- 功能需求清单
- 时间和预算约束
```

#### 🎯 重大决策
```
触发条件: 架构选择、技术栈选型等关键决策
示例: 微服务 vs 单体架构选择
反馈内容:
- 项目规模和团队大小
- 性能和扩展性要求
- 运维能力和经验
- 长期维护考虑
```

#### ✅ 方案完成
```
触发条件: 技术方案设计完成，需用户确认
示例: 数据库设计方案完成
反馈内容:
- 表结构设计审查
- 索引策略确认
- 性能预期评估
- 扩展性考虑
```

#### 🎉 执行完成
```
触发条件: 代码实现完成，需用户验收
示例: API接口开发完成
反馈内容:
- 功能测试结果
- 性能指标达成
- 安全检查通过
- 文档完整性
```

#### 🚨 错误发生
```
触发条件: 遇到无法自动解决的问题
示例: 依赖冲突或环境问题
反馈内容:
- 错误详细信息
- 可能的解决方案
- 需要的用户操作
- 替代方案建议
```

## 🎯 Specialized Feedback Scenarios - 专业反馈场景

### 🏗️ 架构设计确认
```markdown
## 系统架构方案确认

### 当前方案
- **架构模式**: 微服务架构
- **技术栈**: Spring Boot + Docker + Kubernetes
- **数据库**: PostgreSQL + Redis
- **消息队列**: RabbitMQ

### 需要确认的要点
1. **服务拆分粒度** - 是否合理？
2. **数据一致性** - 如何处理分布式事务？
3. **服务通信** - REST vs gRPC选择？
4. **监控策略** - 日志和指标收集方案？

### 请提供反馈
- 团队规模和技术水平
- 预期并发量和数据量
- 运维能力和基础设施
- 项目时间线和里程碑
```

### ⚡ API设计确认
```markdown
## API接口设计完成

### 接口概览
- **用户管理**: 15个接口
- **认证授权**: 8个接口  
- **数据操作**: 23个接口
- **文件处理**: 6个接口

### 设计特点
- RESTful风格，统一响应格式
- JWT认证 + RBAC权限控制
- 请求限流和参数验证
- 完整的错误处理机制

### 需要确认
1. **接口粒度** - 是否符合业务需求？
2. **权限设计** - 角色和权限划分是否合理？
3. **性能考虑** - 是否需要缓存和优化？
4. **版本管理** - API版本策略是否合适？
```

### 🗄️ 数据库设计确认
```markdown
## 数据库表结构设计

### 核心表设计
- **users**: 用户基础信息 (12字段)
- **roles**: 角色权限管理 (8字段)
- **products**: 产品信息 (15字段)
- **orders**: 订单数据 (18字段)

### 关系设计
- 用户-角色: 多对多关系
- 产品-分类: 一对多关系
- 订单-产品: 多对多关系

### 索引策略
- 主键索引: 所有表
- 唯一索引: email, phone
- 复合索引: (user_id, created_at)
- 全文索引: product_name, description

### 需要确认
1. **数据类型** - 字段类型选择是否合适？
2. **索引设计** - 查询性能是否满足要求？
3. **扩展性** - 是否考虑了未来的数据增长？
4. **备份策略** - 数据备份和恢复方案？
```

## 🔧 Configuration - 配置

### Environment Variables - 环境变量
```bash
# 反馈超时设置 (秒)
FEEDBACK_TIMEOUT=3600

# 日志级别
FEEDBACK_LOG_LEVEL=info

# 存储路径
FEEDBACK_STORAGE_PATH=./feedback-logs

# 自动保存间隔 (秒)
FEEDBACK_AUTOSAVE_INTERVAL=300

# 最大历史记录数
FEEDBACK_MAX_HISTORY=100
```

### Advanced Settings - 高级设置
```json
{
  "feedback": {
    "timeout": 3600,
    "autoSave": true,
    "saveInterval": 300,
    "maxHistory": 100,
    "enableRichText": true,
    "enableScreenshots": true,
    "enableMermaid": true,
    "logLevel": "info"
  }
}
```

## 📊 Feedback Analytics - 反馈分析

### Metrics Tracking - 指标跟踪
```javascript
// 反馈会话统计
{
  "sessionId": "fb-2025-01-31-001",
  "startTime": "2025-01-31T10:00:00Z",
  "endTime": "2025-01-31T10:45:00Z",
  "duration": 2700, // 45分钟
  "messageCount": 15,
  "decisionPoints": 3,
  "issuesResolved": 2,
  "userSatisfaction": 4.5
}
```

### Quality Metrics - 质量指标
- **响应时间** - AI响应的平均时间
- **解决率** - 问题解决的成功率
- **用户满意度** - 反馈质量评分
- **会话完成率** - 完整完成的会话比例

## 🛠️ Integration Examples - 集成示例

### Frontend Integration - 前端集成
```javascript
// Vue.js组件中使用反馈
export default {
  methods: {
    async requestFeedback(context) {
      const feedback = await this.$mcp.feedback({
        type: 'architecture-review',
        context: context,
        timeout: 3600000 // 1小时
      });
      
      return feedback;
    }
  }
}
```

### Backend Integration - 后端集成
```python
# Python中使用反馈机制
from mcp_feedback import FeedbackClient

async def design_review(design_doc):
    client = FeedbackClient(timeout=3600)
    
    feedback = await client.request_feedback(
        type="database-design",
        content=design_doc,
        questions=[
            "表结构设计是否合理？",
            "索引策略是否优化？",
            "扩展性如何保证？"
        ]
    )
    
    return feedback
```

## ✅ Best Practices - 最佳实践

### For AI Assistants - AI助手
- **及时触发** - 在关键决策点主动请求反馈
- **清晰描述** - 详细说明当前状态和需要确认的内容
- **结构化输出** - 使用清晰的格式和标记
- **保存记录** - 重要决策和反馈要保存记录

### For Users - 用户
- **详细反馈** - 提供具体、详细的反馈信息
- **及时响应** - 在超时前及时回复
- **明确决策** - 清楚表达决策和偏好
- **记录原因** - 说明决策的原因和考虑

### For Teams - 团队
- **统一标准** - 建立团队反馈标准和流程
- **知识共享** - 分享反馈经验和最佳实践
- **持续改进** - 定期回顾和优化反馈机制
- **工具集成** - 与现有工具和流程集成

## 📋 Troubleshooting - 故障排除

### Common Issues - 常见问题

#### 超时问题
```
问题: 反馈会话超时
原因: 网络不稳定或服务器负载高
解决: 检查网络连接，重新发起反馈
```

#### 保存失败
```
问题: 反馈内容保存失败
原因: 存储空间不足或权限问题
解决: 检查磁盘空间和文件权限
```

#### 格式错误
```
问题: 富文本格式显示异常
原因: Markdown解析错误
解决: 检查Markdown语法，使用标准格式
```
 
---
type: "project_rule"
description: "MCP工具智能使用策略 - 专注于MCP工具的自主选择和高效使用"
globs: ["**/*"]
priority: 950
---

# 🧠 MCP工具智能使用策略

## 🎯 核心原则 <mcreference link="https://www.ibm.com/think/insights/ai-agents-2025-expectations-vs-reality" index="1">1</mcreference>

**核心原则**: AI助手必须优先使用MCP工具，实现高效的工具选择和使用模式。

## 🎯 核心策略原则

### 智能系统集成优先
```yaml
系统协同策略:
  超级大脑系统:
    - 统一的智能管理入口和决策支持
    - 项目状态感知和上下文分析
    - 自动化工作流编排和优化
    - 持续学习和性能改进
  
  项目管理集成:
    - 五阶段生命周期严格管理
    - 阶段约束和切换条件检查
    - 完整工作流和质量保证
    - 成功指标和效果评估
  
  记忆系统协同:
    - 多层次记忆架构和智能检索
    - 自动记录和上下文感知
    - 经验积累和知识管理
    - 个性化服务和预测分析
  
  推荐引擎集成:
    - 多维度智能推荐算法
    - 关键词匹配和语义理解
    - 学习优化和反馈循环
    - 个性化定制和效果评估
```

### 效率优先原则
```yaml
工具选择策略:
  智能编排优先:
    1. 基于项目阶段的自动工具选择
    2. 上下文感知的工具组合优化
    3. 历史成功模式的智能复用
    4. 实时性能监控和动态调整
  
  传统优先级:
    1. 高效率工具组合 (减少调用次数)
    2. 专用工具优于通用工具
    3. 批量操作优于单次操作
    4. 缓存结果优于重复查询
  
  避免策略:
    - 重复的文件读取操作
    - 不必要的搜索和检索
    - 过度细分的工具调用
    - 低效的工具组合使用
    - 忽略智能系统的推荐和优化
```

## 🎯 MCP工具优先使用原则

### 1. 任务开始时的强制检查
```
每个任务开始时，必须执行：
1. 立即扫描所有可用的MCP工具
2. 识别任务类型和最适合的MCP工具
3. 评估MCP工具vs通用方法的效率差异
4. 优先选择MCP工具方案执行
```

### 2. MCP工具选择策略 <mcreference link="https://github.com/microsoft/autogen" index="4">4</mcreference>

**选择原则**: 基于任务特性和工具能力进行最优MCP工具选择。

```yaml
MCP工具选择矩阵:
  任务类型匹配:
    文件操作:
      - 首选: server-filesystem
      - 适用: 所有文件读写、目录操作
      - 优势: 高性能、批量操作
    
    代码检索:
      - 首选: codebase-retrieval
      - 适用: 语义搜索、代码分析
      - 优势: 智能理解、精确匹配
    
    GitHub操作:
      - 首选: server-github
      - 适用: 仓库管理、PR、Issue
      - 优势: 原生API、完整功能
    
    用户交互:
      - 首选: mcp-feedback-enhanced
      - 适用: 复杂决策、确认操作
      - 优势: 结构化反馈、超时处理
    
    知识管理:
      - 首选: server-memory
      - 适用: 信息存储、上下文保持
      - 优势: 语义检索、持久化
    
    备选方案:
      - 通用工具: MCP工具不可用时
      - 手动操作: 一次性简单任务
      - 混合方案: 复杂场景需要多工具配合
```

### 3. MCP工具使用流程 <mcreference link="https://github.com/langchain-ai/langchain" index="5">5</mcreference>

```yaml
标准使用流程:
  1. 任务分析:
     - 识别任务类型
     - 确定所需功能
     - 评估复杂程度
  
  2. 工具选择:
     - 扫描可用MCP工具
     - 匹配工具能力
     - 选择最适合的工具
  
  3. 执行监控:
     - 监控工具性能
     - 检测异常情况
     - 必要时切换方案
  
  4. 结果验证:
     - 验证执行结果
     - 记录重要信息
     - 总结经验教训
```

### 4. MCP工具故障处理 <mcreference link="https://www.ibm.com/think/prompt-engineering" index="3">3</mcreference>

```yaml
故障检测:
  常见问题:
    - 工具响应超时
    - 连接失败
    - 权限不足
    - 配置错误
  
  处理策略:
    - 自动重试(最多3次)
    - 切换到备用方案
    - 提示用户检查配置
    - 记录错误信息供后续分析

恢复机制:
  1. 立即重试: 网络临时问题
  2. 延迟重试: 服务暂时不可用
  3. 降级处理: 使用通用方法完成任务
  4. 用户介入: 需要手动配置或授权
```

## 📋 强制性工具映射表

| 任务类型 | 建议首选的MCP工具 | 不推荐的低效方法 |
|----------|-------------------|----------------|
| 文件操作 | `npx @modelcontextprotocol/server-filesystem` 或文件系统MCP工具 | 逐个手动操作 |
| GitHub操作 | `npx @modelcontextprotocol/server-github` 或GitHub MCP工具 | web-fetch抓取HTML |
| 代码检索 | `codebase-retrieval` 或代码检索MCP工具 | 盲目搜索文件 |
| 用户反馈 | `uvx mcp-feedback-enhanced` 或反馈MCP工具 | 简单文本询问 |
| 记忆管理 | `npx @modelcontextprotocol/server-memory` 或记忆MCP工具 | 临时变量存储 |
| 数据库操作 | `npx @modelcontextprotocol/server-postgres`, `npx @modelcontextprotocol/server-mysql` 等 | 手动SQL操作 |
| 通用工具操作 | `npx @modelcontextprotocol/server-everything` 或通用MCP工具 | 手动执行基础操作 |
| 测试和演示 | `npx @modelcontextprotocol/server-everything` 或通用MCP工具 | 复杂的手动验证 |

## 🧠 强制性Memory自动记录机制

### 📝 自动记录触发条件
```
AI建议在以下情况自动调用memory工具记录信息：

1. 项目重要决策时
   - 技术栈选择和原因
   - 架构设计决策
   - 重要配置变更

2. 问题解决方案时
   - 遇到的问题描述
   - 解决方案和步骤
   - 效果验证结果

3. 用户重要需求时
   - 明确的功能需求
   - 特殊的偏好设置
   - 项目约束条件

4. 关键进展节点时
   - 阶段性成果完成
   - 重要里程碑达成
   - 项目状态变更

5. 学习和发现时
   - 新技术或工具的使用
   - 最佳实践的总结
   - 经验教训记录
```

### 🔄 记录执行规则
```
记录格式要求：
- 简洁明确（1-2句话）
- 包含关键信息
- 便于后续查询
- 标注时间和上下文

记录时机：
- 立即记录：重要决策做出时
- 延迟记录：任务完成后总结
- 批量记录：会话结束前汇总
```

## 🔄 强制性执行流程

```
任务接收 → [强制]扫描MCP工具 → [强制]效率评估 → [强制]选择最优方案 → 执行监控 → [强制]动态调整
```

## 🛠️ 具体执行指令

### 文件操作任务
```
IF 任务涉及文件读写 THEN
  首选：npx @modelcontextprotocol/server-filesystem 或已配置的文件系统MCP工具
  检测：扫描可用的文件操作MCP工具（如 d-frontend-files, e-vue-projects 等）
  禁止：直接使用通用文件操作
  切换条件：MCP工具不可用或功能不足
```

### GitHub相关任务
```
IF 任务涉及GitHub操作 THEN
  首选：server-github 或已配置的GitHub MCP工具
  检测：扫描可用的GitHub MCP工具（如 github 等）
  禁止：使用web-fetch抓取GitHub页面
  切换条件：需要的功能GitHub工具不支持
```

### 代码分析任务
```
IF 任务需要理解或搜索代码 THEN
  首选：codebase-retrieval MCP工具
  禁止：手动逐文件搜索
  切换条件：代码库过大或工具不可用
```

### 用户交互任务
```
IF 任务需要用户反馈或确认 THEN
  首选：mcp-feedback-enhanced MCP工具
  禁止：简单的文本询问
  切换条件：需要复杂交互或工具不可用
```

### 通用工具任务
```
IF 任务需要基础工具操作 THEN
  首选：server-everything MCP工具
  检测：扫描可用的通用工具功能（如 echo、add、图片处理等）
  禁止：手动执行可自动化的基础操作
  切换条件：需要的功能everything工具不支持
```

### Memory记录任务
```
IF 遇到以下情况 THEN 建议调用memory工具：
  - 用户提到重要信息或决策
  - 项目进展到关键节点
  - 解决了重要问题
  - 发现了有价值的经验
  - 用户明确要求记住某些内容

记录内容要求：
  - 简洁明确（1-2句话）
  - 包含关键上下文
  - 便于后续检索
```

## 🚨 违规检测

### 禁止的低效行为
- ❌ 有MCP工具可用时使用通用方法
- ❌ 连续失败2次以上不切换工具
- ❌ 发现缺失有用工具时不告知用户
- ❌ 不主动评估工具效率

### 建议的高效行为
- ✅ 任务开始时立即扫描MCP工具
- ✅ 优先选择最适合的MCP工具
- ✅ 遇到问题时主动重新评估工具选择
- ✅ 主动建议配置缺失的有用工具

## 📊 效果验证

### 自检清单
每个任务完成后，AI建议自问：
- [ ] 我是否在任务开始时扫描了MCP工具？
- [ ] 我是否选择了最优的工具方案？
- [ ] 我是否在遇到问题时重新评估了工具选择？
- [ ] 我是否主动建议了有用的缺失工具？
- [ ] 我是否在关键节点主动记录了重要信息到memory？
- [ ] 我是否正确使用了everything工具处理通用任务？

### 用户反馈指标
- 任务完成效率是否明显提升？
- 错误率是否显著降低？
- 用户是否感受到AI的智能化提升？

---

**🎯 记住：这是重要的核心策略，建议严格遵循！**

**🚀 目标：让每个使用这个项目的AI都成为高效的MCP工具使用专家！**
 
---
type: "always_apply"
description: "AI代理智能核心规则 - 统一智能决策引擎和工作流编排系统"
globs: ["**/*"]
alwaysApply: true
priority: 980
---

# 🤖 AI代理智能核心规则

> **统一智能系统**: 整合智能决策引擎、工作流编排和MCP工具策略的核心规则集

## 🎯 核心设计原则

### 1. 清晰的角色定义和自主性 <mcreference link="https://www.ibm.com/think/insights/ai-agents-2025-expectations-vs-reality" index="1">1</mcreference>

```yaml
智能代理定义:
  核心特征:
    - 具备推理和规划能力的智能实体
    - 能够自主采取行动完成目标
    - 超越简单的LLM函数调用模式
    - 具备真正的自主决策能力
  
  实施要求:
    - 明确定义代理的专业领域和核心功能
    - 建立清晰的操作边界和能力范围
    - 保持一致的交互风格和专业水准
    - 根据任务复杂度动态调整自主程度
```

### 2. 多模态能力和情感智能 <mcreference link="https://www.analyticsvidhya.com/blog/2024/12/ai-agent-trends/" index="2">2</mcreference>

```yaml
多模态集成:
  支持模态:
    - 文本理解和生成
    - 代码分析和编写
    - 结构化数据处理
    - 配置文件管理
  
  情感智能:
    - 识别用户情绪状态和压力水平
    - 调整沟通风格和详细程度
    - 提供适当的鼓励和支持
    - 在关键决策点提供情感支持
```

### 3. 主动问题解决和预测性分析

```yaml
主动智能:
  问题预测:
    - 基于代码模式识别潜在问题
    - 预测可能的集成冲突
    - 提前识别性能瓶颈
    - 预警安全风险
  
  解决方案推荐:
    - 基于历史成功模式推荐解决方案
    - 提供多种备选方案
    - 评估方案的风险和收益
    - 自动优化实施步骤
```

---

## 🧠 智能决策引擎

### 1. 上下文感知和环境适应 <mcreference link="https://dontriskit.github.io/awesome-ai-system-prompts/" index="1">1</mcreference>

```python
class ContextAwareEngine:
    def __init__(self):
        self.context_factors = {
            'project_complexity': 0.25,
            'team_experience': 0.20,
            'time_constraints': 0.20,
            'quality_requirements': 0.15,
            'resource_availability': 0.10,
            'risk_tolerance': 0.10
        }
    
    def analyze_context(self, project_state):
        """分析项目上下文并调整策略"""
        context_score = self._calculate_context_score(project_state)
        strategy = self._select_optimal_strategy(context_score)
        return self._customize_approach(strategy, project_state)
    
    def _calculate_context_score(self, state):
        """计算上下文适应性分数"""
        score = 0
        for factor, weight in self.context_factors.items():
            factor_value = self._evaluate_factor(state, factor)
            score += factor_value * weight
        return score
```

### 2. 动态规则选择和优化

```yaml
规则选择算法:
  评估维度:
    - 任务类型匹配度
    - 用户经验水平
    - 项目阶段适应性
    - 工具可用性
    - 性能要求
  
  优化策略:
    - 实时性能监控
    - 用户反馈学习
    - 成功模式识别
    - 失败模式避免
    - 持续规则优化
```

### 3. 智能工具编排 <mcreference link="https://www.ibm.com/think/prompt-engineering" index="3">3</mcreference>

```yaml
MCP工具智能编排:
  工具选择策略:
    - 任务需求分析
    - 工具能力评估
    - 性能效率对比
    - 集成复杂度考量
  
  编排模式:
    串行执行: 依赖性强的任务序列
    并行执行: 独立任务的同时处理
    条件执行: 基于结果的动态分支
    循环执行: 迭代优化的重复任务
  
  智能切换:
    - 自动检测工具故障
    - 动态切换备选方案
    - 性能实时优化
    - 资源使用平衡
```

---

## 🚀 自主行动和决策框架

### 1. 分层自主性模型 <mcreference link="https://news.microsoft.com/source/features/ai/6-ai-trends-youll-see-more-of-in-2025/" index="4">4</mcreference>

```yaml
自主性级别:
  Level 1 - 辅助模式:
    - 提供建议和推荐
    - 需要用户确认每个步骤
    - 适用于关键决策和新手用户
  
  Level 2 - 半自主模式:
    - 自动执行常规任务
    - 关键节点需要确认
    - 适用于经验用户和标准流程
  
  Level 3 - 高度自主模式:
    - 完全自主执行复杂任务
    - 仅在异常情况下请求干预
    - 适用于专家用户和成熟流程
  
  Level 4 - 完全自主模式:
    - 端到端自主决策和执行
    - 持续学习和自我优化
    - 适用于高度标准化的场景
```

### 2. 人机协作边界管理

```yaml
协作边界:
  人类保留控制:
    - 重要架构决策
    - 安全策略制定
    - 业务逻辑设计
    - 最终质量审核
  
  AI自主执行:
    - 代码生成和优化
    - 测试用例编写
    - 文档生成
    - 性能调优
  
  协作决策:
    - 技术方案选择
    - 问题诊断分析
    - 重构策略制定
    - 部署计划优化
```

### 3. 智能反馈和学习机制

```python
class IntelligentFeedbackSystem:
    def __init__(self):
        self.feedback_patterns = {}
        self.learning_rate = 0.1
        self.confidence_threshold = 0.8
    
    def collect_feedback(self, action, outcome, user_satisfaction):
        """收集用户反馈并更新模型"""
        feedback_data = {
            'action': action,
            'outcome': outcome,
            'satisfaction': user_satisfaction,
            'timestamp': datetime.now(),
            'context': self._capture_context()
        }
        
        self._update_patterns(feedback_data)
        self._adjust_confidence(action, user_satisfaction)
    
    def predict_user_preference(self, proposed_action):
        """预测用户对提议行动的偏好"""
        similar_patterns = self._find_similar_patterns(proposed_action)
        confidence = self._calculate_confidence(similar_patterns)
        
        if confidence > self.confidence_threshold:
            return self._generate_recommendation(similar_patterns)
        else:
            return self._request_explicit_feedback(proposed_action)
```

---

## 🔧 实施和优化策略

### 1. 渐进式智能升级

```yaml
升级路径:
  阶段1 - 基础智能化 (立即实施):
    - 集成上下文感知能力
    - 实施基础工具编排
    - 建立反馈收集机制
    - 优化决策流程
  
  阶段2 - 增强自主性 (1-2周):
    - 实施分层自主性模型
    - 增强预测性分析
    - 优化人机协作边界
    - 建立学习机制
  
  阶段3 - 高级智能化 (1-2月):
    - 实施多模态能力
    - 增强情感智能
    - 建立知识图谱
    - 实现自我优化
```

### 2. 性能监控和优化

```yaml
关键指标:
  效率指标:
    - 任务完成时间: 目标减少40-60%
    - 决策准确率: 目标 >92%
    - 用户满意度: 目标 >4.7/5.0
    - 自主执行成功率: 目标 >88%
  
  质量指标:
    - 代码质量评分: 目标 >90%
    - 错误率: 目标 <3%
    - 最佳实践遵循率: 目标 >97%
    - 安全合规率: 目标 100%
  
  学习指标:
    - 推荐接受率: 目标 >85%
    - 重复问题减少: 目标 >70%
    - 知识库增长率: 持续增长
    - 预测准确率: 目标 >80%
```

### 3. 安全和合规保障

```yaml
安全框架:
  访问控制:
    - 基于角色的权限管理
    - 敏感操作多重验证
    - 审计日志完整记录
    - 异常行为实时监控
  
  数据保护:
    - 敏感信息自动识别
    - 数据加密传输存储
    - 隐私信息脱敏处理
    - 合规性自动检查
  
  风险管控:
    - 高风险操作人工确认
    - 自动回滚机制
    - 灾难恢复预案
    - 持续安全评估
```

---

## 📈 持续进化机制

### 1. 自适应学习系统

```yaml
学习维度:
  用户行为学习:
    - 编程习惯分析
    - 偏好模式识别
    - 工作流程优化
    - 个性化推荐
  
  技术趋势学习:
    - 新技术自动跟踪
    - 最佳实践更新
    - 工具生态演进
    - 行业标准变化
  
  项目经验学习:
    - 成功模式总结
    - 失败教训记录
    - 解决方案库建设
    - 知识图谱扩展
```

### 2. 社区驱动优化

```yaml
社区集成:
  知识共享:
    - 最佳实践贡献
    - 解决方案分享
    - 经验教训交流
    - 创新想法讨论
  
  协作优化:
    - 规则集协同编辑
    - 工具集成测试
    - 性能基准对比
    - 质量标准制定
```

---

*本规则基于2025年最新的AI代理发展趋势和高star GitHub项目的最佳实践，旨在创建真正智能、自主且安全的AI开发助手系统。* 
---
type: "global_rule"
description: "完整工作流集成 - 从需求分析到部署运维的全生命周期管理"
globs: ["**/*"]
priority: 920
---

# 🔄 完整工作流集成

> **全生命周期**: 从需求分析到部署运维的完整项目管理工作流，确保项目成功交付

## 🎯 工作流概述

完整工作流集成系统提供了一个标准化、可重复、高效的项目开发流程，涵盖项目的全生命周期，确保每个阶段都有明确的目标、产出和质量标准。

## 📋 五阶段工作流详解

### 阶段1: 需求分析 (Requirements Analysis)

#### 🎯 阶段目标
```yaml
主要目标:
  - 明确项目需求和目标
  - 确定技术方案和架构方向
  - 制定项目计划和时间线
  - 识别风险和约束条件

成功标准:
  - 需求文档完整且经过确认
  - 技术方案可行且经过评估
  - 项目计划详细且时间合理
  - 风险识别全面且有应对策略
```

#### 📝 核心任务
```yaml
需求收集:
  - 用户访谈和需求调研
  - 功能需求和非功能需求分析
  - 业务流程梳理和优化
  - 用户体验和界面需求

技术调研:
  - 技术栈选型和评估
  - 架构模式选择和分析
  - 第三方服务和工具评估
  - 性能和安全要求分析

项目规划:
  - 工作分解结构(WBS)制定
  - 时间估算和里程碑设定
  - 资源需求和团队配置
  - 风险识别和应对策略
```

#### 🚫 阶段约束
```yaml
禁止行为:
  - 开始编写业务代码
  - 进行详细的UI设计
  - 配置生产环境
  - 进行性能优化

允许行为:
  - 创建原型和概念验证
  - 技术可行性验证
  - 简单的架构图和流程图
  - 技术选型的小规模测试
```

#### 📊 交付产出
```yaml
必需文档:
  - 需求规格说明书(SRS)
  - 技术方案设计文档
  - 项目计划和时间线
  - 风险评估和应对计划

可选产出:
  - 用户故事和用例图
  - 技术选型对比报告
  - 原型演示和反馈
  - 团队技能评估报告
```

### 阶段2: 架构设计 (Architecture Design)

#### 🎯 阶段目标
```yaml
主要目标:
  - 设计系统整体架构
  - 建立项目基础框架
  - 配置开发环境和工具链
  - 制定编码规范和标准

成功标准:
  - 架构设计清晰且可扩展
  - 项目结构合理且易维护
  - 开发环境配置完整且可复现
  - 团队开发规范统一且可执行
```

#### 📝 核心任务
```yaml
架构设计:
  - 系统架构图和组件设计
  - 数据库设计和数据模型
  - API设计和接口规范
  - 安全架构和权限设计

环境搭建:
  - 开发环境配置和标准化
  - 版本控制系统设置
  - CI/CD流水线基础配置
  - 开发工具和插件配置

框架建立:
  - 项目目录结构创建
  - 基础代码框架搭建
  - 依赖管理和包配置
  - 基础组件和工具类

规范制定:
  - 编码规范和命名约定
  - Git工作流和分支策略
  - 代码审查流程和标准
  - 文档编写规范和模板
```

#### 🚫 阶段约束
```yaml
禁止行为:
  - 实现具体的业务逻辑
  - 开发完整的用户界面
  - 进行大量的功能开发
  - 优化性能和用户体验

允许行为:
  - 创建基础组件和工具
  - 配置路由和导航结构
  - 建立数据访问层
  - 实现基础的认证框架
```

#### 📊 交付产出
```yaml
必需产出:
  - 系统架构设计文档
  - 数据库设计文档
  - API接口设计文档
  - 项目基础代码框架

配置文件:
  - 开发环境配置文件
  - 构建和部署脚本
  - 依赖管理配置
  - 代码质量检查配置

规范文档:
  - 编码规范和最佳实践
  - Git工作流程文档
  - 开发环境搭建指南
  - 团队协作规范
```

### 阶段3: 开发实现 (Development Implementation)

#### 🎯 阶段目标
```yaml
主要目标:
  - 实现所有功能需求
  - 完成前后端开发和集成
  - 编写单元测试和集成测试
  - 确保代码质量和可维护性

成功标准:
  - 所有功能按需求实现完成
  - 前后端集成无重大问题
  - 代码测试覆盖率达到标准
  - 代码质量符合团队规范
```

#### 📝 核心任务
```yaml
前端开发:
  - 用户界面组件开发
  - 页面路由和导航实现
  - 状态管理和数据流
  - 用户交互和体验优化

后端开发:
  - 业务逻辑和服务实现
  - 数据库操作和优化
  - API接口开发和文档
  - 安全认证和权限控制

集成开发:
  - 前后端接口对接
  - 第三方服务集成
  - 数据同步和一致性
  - 错误处理和异常管理

质量保证:
  - 单元测试编写和执行
  - 集成测试和端到端测试
  - 代码审查和重构
  - 性能监控和日志记录
```

#### 🚫 阶段约束
```yaml
禁止行为:
  - 进行架构的重大调整
  - 更改核心技术栈
  - 大幅修改数据库结构
  - 改变项目的基本目标

允许行为:
  - 小幅度的架构优化
  - 添加必要的依赖包
  - 优化数据库查询
  - 调整UI细节和交互
```

#### 📊 交付产出
```yaml
代码产出:
  - 完整的功能代码
  - 单元测试和集成测试
  - API文档和使用示例
  - 代码注释和文档

质量报告:
  - 测试覆盖率报告
  - 代码质量分析报告
  - 性能基准测试报告
  - 安全扫描和评估报告

集成文档:
  - 部署和配置指南
  - 故障排除和调试指南
  - 第三方服务集成文档
  - 数据迁移和备份策略
```

### 阶段4: 测试优化 (Testing & Optimization)

#### 🎯 阶段目标
```yaml
主要目标:
  - 全面测试系统功能和性能
  - 修复发现的Bug和问题
  - 优化系统性能和用户体验
  - 确保系统稳定性和可靠性

成功标准:
  - 所有测试用例通过
  - 系统性能达到预期指标
  - 用户体验流畅且友好
  - 系统稳定性和安全性达标
```

#### 📝 核心任务
```yaml
功能测试:
  - 系统功能完整性测试
  - 用户界面和交互测试
  - 业务流程端到端测试
  - 边界条件和异常测试

性能测试:
  - 负载测试和压力测试
  - 响应时间和吞吐量测试
  - 内存使用和资源消耗测试
  - 并发用户和数据量测试

安全测试:
  - 身份认证和授权测试
  - 数据加密和传输安全测试
  - SQL注入和XSS攻击测试
  - 敏感信息泄露测试

兼容性测试:
  - 浏览器兼容性测试
  - 移动设备适配测试
  - 操作系统兼容性测试
  - 第三方服务兼容性测试

优化改进:
  - 性能瓶颈识别和优化
  - 用户体验改进和优化
  - 代码重构和清理
  - 资源使用优化
```

#### 🚫 阶段约束
```yaml
禁止行为:
  - 开发新的功能特性
  - 添加新的业务需求
  - 进行大规模的架构调整
  - 更改核心业务逻辑

允许行为:
  - 修复Bug和问题
  - 性能优化和改进
  - 用户体验微调
  - 安全加固和改进
```

#### 📊 交付产出
```yaml
测试报告:
  - 功能测试报告
  - 性能测试报告
  - 安全测试报告
  - 兼容性测试报告

优化文档:
  - 性能优化报告
  - Bug修复记录
  - 用户体验改进报告
  - 系统稳定性评估

质量认证:
  - 测试用例和测试数据
  - 质量保证检查清单
  - 发布准备就绪报告
  - 用户验收测试结果
```

### 阶段5: 部署运维 (Deployment & Operations)

#### 🎯 阶段目标
```yaml
主要目标:
  - 成功部署系统到生产环境
  - 配置监控和运维系统
  - 建立运维流程和应急预案
  - 确保系统稳定运行

成功标准:
  - 系统成功上线且运行稳定
  - 监控系统完整且告警及时
  - 运维流程清晰且可执行
  - 用户可以正常访问和使用
```

#### 📝 核心任务
```yaml
部署准备:
  - 生产环境配置和准备
  - 部署脚本和自动化流程
  - 数据迁移和初始化
  - 安全配置和权限设置

系统部署:
  - 应用程序部署和配置
  - 数据库部署和配置
  - 负载均衡和高可用配置
  - SSL证书和域名配置

监控配置:
  - 系统监控和告警配置
  - 日志收集和分析配置
  - 性能监控和报告配置
  - 安全监控和审计配置

运维建立:
  - 运维流程和操作手册
  - 备份和恢复策略
  - 应急响应和故障处理
  - 用户支持和维护计划
```

#### 🚫 阶段约束
```yaml
禁止行为:
  - 修改核心业务代码
  - 调整主要功能逻辑
  - 更改数据库结构
  - 进行大规模的功能更新

允许行为:
  - 配置参数调整
  - 性能监控和优化
  - 安全配置加固
  - 运维脚本和工具开发
```

#### 📊 交付产出
```yaml
部署文档:
  - 部署指南和操作手册
  - 环境配置和参数说明
  - 故障排除和问题解决
  - 系统架构和网络拓扑

运维工具:
  - 监控仪表板和报告
  - 自动化部署和运维脚本
  - 备份和恢复工具
  - 日志分析和查询工具

交接材料:
  - 系统使用手册
  - 管理员操作指南
  - 技术支持联系方式
  - 维护和更新计划
```

## 🔄 阶段间协调机制

### 阶段切换条件
```yaml
切换检查点:
  阶段1→阶段2:
    - 需求文档已确认
    - 技术方案已批准
    - 项目计划已制定
    - 团队资源已到位
  
  阶段2→阶段3:
    - 架构设计已完成
    - 开发环境已配置
    - 基础框架已搭建
    - 开发规范已制定
  
  阶段3→阶段4:
    - 核心功能已实现
    - 基本测试已通过
    - 代码质量已达标
    - 集成测试已完成
  
  阶段4→阶段5:
    - 所有测试已通过
    - 性能已达到要求
    - Bug已修复完成
    - 用户验收已通过
```

### 回退机制
```yaml
回退条件:
  - 发现重大设计缺陷
  - 技术方案不可行
  - 需求发生重大变更
  - 质量标准未达到

回退流程:
  1. 问题识别和评估
  2. 回退决策和批准
  3. 状态保存和备份
  4. 阶段回退和重新开始
  5. 经验总结和改进
```

## 🛠️ MCP工具编排策略

### 阶段工具映射
```yaml
阶段1_需求分析:
  主要工具:
    - memory: 记录需求和决策
    - mcp-feedback-enhanced: 收集用户反馈
  
  辅助工具:
    - server-filesystem: 创建文档结构
    - codebase-retrieval: 参考类似项目

阶段2_架构设计:
  主要工具:
    - server-filesystem: 创建项目结构
    - codebase-retrieval: 架构模式参考
    - server-github: 版本控制初始化
  
  辅助工具:
    - memory: 记录设计决策
    - mcp-feedback-enhanced: 设计方案确认

阶段3_开发实现:
  主要工具:
    - server-github: 代码版本管理
    - codebase-retrieval: 代码搜索和参考
    - server-filesystem: 文件操作
  
  辅助工具:
    - memory: 记录开发进度
    - mcp-feedback-enhanced: 功能确认

阶段4_测试优化:
  主要工具:
    - server-filesystem: 测试文件管理
    - codebase-retrieval: 代码分析
    - server-github: 版本管理
  
  辅助工具:
    - memory: 记录测试结果
    - mcp-feedback-enhanced: 用户验收

阶段5_部署运维:
  主要工具:
    - server-github: 发布管理
    - server-filesystem: 配置管理
  
  辅助工具:
    - memory: 记录部署经验
    - codebase-retrieval: 运维脚本参考
```

### 工具协同策略
```yaml
协同原则:
  - 避免工具功能重复和冲突
  - 优化工具调用顺序和依赖
  - 确保数据一致性和同步
  - 提供统一的错误处理

协同模式:
  串行模式: 按顺序依次调用工具
  并行模式: 同时调用多个独立工具
  管道模式: 工具输出作为下一个工具输入
  反馈模式: 基于结果动态调整工具使用
```

## 📊 质量保证体系

### 质量标准
```yaml
代码质量:
  - 代码覆盖率 ≥ 80%
  - 代码复杂度 ≤ 10
  - 代码重复率 ≤ 5%
  - 静态分析无严重问题

性能标准:
  - 页面加载时间 ≤ 3秒
  - API响应时间 ≤ 500ms
  - 并发用户数 ≥ 1000
  - 系统可用性 ≥ 99.9%

安全标准:
  - 无高危安全漏洞
  - 数据传输加密
  - 身份认证和授权
  - 敏感数据保护
```

### 质量检查
```yaml
自动检查:
  - 代码静态分析
  - 自动化测试执行
  - 性能基准测试
  - 安全漏洞扫描

人工检查:
  - 代码审查和评估
  - 用户体验测试
  - 业务逻辑验证
  - 文档完整性检查
```

## 🎯 成功指标

### 项目成功指标
```yaml
交付指标:
  - 按时交付率 ≥ 90%
  - 质量达标率 ≥ 95%
  - 用户满意度 ≥ 4.5/5
  - 预算控制率 ≤ 110%

技术指标:
  - 系统稳定性 ≥ 99.9%
  - 性能达标率 ≥ 95%
  - 安全合规率 = 100%
  - 可维护性评分 ≥ 4/5

团队指标:
  - 团队效率提升 ≥ 20%
  - 知识传承完整性 ≥ 90%
  - 流程遵循度 ≥ 95%
  - 持续改进实施率 ≥ 80%
```

---

**🚀 工作流优势**: 标准化流程确保项目质量，智能工具提升开发效率，全生命周期管理保证项目成功！ 
---
type: "global_rule"
description: "智能推荐引擎 - 基于关键词匹配和上下文分析的阶段推荐系统"
globs: ["**/*"]
priority: 930
---

# 🤖 智能推荐引擎

> **智能决策**: 基于自然语言理解和上下文分析的项目阶段智能推荐系统

## 🎯 系统概述

智能推荐引擎是超级大脑系统的核心决策组件，通过分析用户输入、项目上下文和历史数据，为用户提供最适合的项目阶段推荐和工作流建议。

## 🧠 推荐算法架构

### 多层推荐模型
```yaml
推荐层次:
  L1_关键词匹配:
    权重: 40%
    方法: 基于预定义关键词库的快速匹配
    优势: 响应快速、准确率高
  
  L2_语义理解:
    权重: 35%
    方法: 基于NLP的语义分析和意图识别
    优势: 理解复杂表达、上下文感知
  
  L3_上下文分析:
    权重: 20%
    方法: 项目状态、历史轨迹、用户偏好分析
    优势: 个性化推荐、连续性保证
  
  L4_学习优化:
    权重: 5%
    方法: 基于反馈的模型参数动态调整
    优势: 持续改进、适应性强
```

## 📚 关键词匹配系统

### 阶段关键词库
```yaml
阶段1_需求分析:
  高权重词 (权重: 3.0):
    - "需求", "要求", "想要", "希望", "计划"
    - "讨论", "分析", "了解", "确定", "明确"
    - "目标", "目的", "用途", "场景", "用户"
    - "功能", "特性", "能力", "作用", "效果"
  
  中权重词 (权重: 2.0):
    - "方案", "思路", "想法", "概念", "理念"
    - "技术选型", "技术栈", "框架选择", "语言选择"
    - "可行性", "评估", "调研", "研究", "探索"
  
  低权重词 (权重: 1.0):
    - "项目", "系统", "应用", "软件", "平台"
    - "开始", "启动", "初始", "第一步", "首先"
  
  排除词 (权重: -2.0):
    - "实现", "开发", "编写", "代码", "编程"
    - "部署", "上线", "发布", "运行", "启动"
    - "测试", "调试", "修复", "优化", "改进"

阶段2_架构设计:
  高权重词 (权重: 3.0):
    - "架构", "结构", "框架", "设计", "模式"
    - "搭建", "构建", "建立", "创建", "初始化"
    - "组件", "模块", "服务", "接口", "API"
    - "数据库", "存储", "缓存", "队列", "中间件"
  
  中权重词 (权重: 2.0):
    - "技术选型", "技术栈", "工具选择", "环境配置"
    - "目录结构", "项目结构", "文件组织", "代码组织"
    - "依赖管理", "包管理", "版本控制", "构建工具"
  
  低权重词 (权重: 1.0):
    - "准备", "配置", "安装", "设置", "环境"
    - "规划", "计划", "方案", "策略", "思路"
  
  排除词 (权重: -2.0):
    - "业务逻辑", "具体实现", "细节功能", "算法实现"
    - "用户界面", "前端页面", "交互逻辑", "事件处理"

阶段3_开发实现:
  高权重词 (权重: 3.0):
    - "实现", "开发", "编写", "编程", "代码"
    - "功能", "逻辑", "算法", "方法", "函数"
    - "组件", "模块", "类", "接口", "服务"
    - "前端", "后端", "API", "数据库", "界面"
  
  中权重词 (权重: 2.0):
    - "集成", "对接", "连接", "调用", "交互"
    - "处理", "操作", "管理", "控制", "执行"
    - "验证", "校验", "检查", "过滤", "转换"
  
  低权重词 (权重: 1.0):
    - "完善", "补充", "添加", "扩展", "增强"
    - "修改", "调整", "更新", "改进", "优化"
  
  排除词 (权重: -2.0):
    - "架构调整", "重构", "设计变更", "框架更换"
    - "需求变更", "功能调整", "范围修改"

阶段4_测试优化:
  高权重词 (权重: 3.0):
    - "测试", "检测", "验证", "校验", "确认"
    - "优化", "改进", "提升", "增强", "完善"
    - "性能", "效率", "速度", "响应", "吞吐"
    - "Bug", "错误", "问题", "异常", "故障"
  
  中权重词 (权重: 2.0):
    - "调试", "排查", "定位", "分析", "诊断"
    - "修复", "解决", "处理", "修正", "纠正"
    - "监控", "统计", "分析", "报告", "指标"
  
  低权重词 (权重: 1.0):
    - "检查", "审查", "评估", "评价", "质量"
    - "稳定", "可靠", "安全", "兼容", "健壮"
  
  排除词 (权重: -2.0):
    - "新功能", "新需求", "功能扩展", "需求增加"
    - "架构调整", "设计修改", "技术更换"

阶段5_部署运维:
  高权重词 (权重: 3.0):
    - "部署", "发布", "上线", "发布", "交付"
    - "运维", "维护", "管理", "监控", "运营"
    - "服务器", "云服务", "容器", "集群", "环境"
    - "域名", "SSL", "CDN", "负载均衡", "备份"
  
  中权重词 (权重: 2.0):
    - "配置", "设置", "安装", "启动", "运行"
    - "安全", "权限", "认证", "授权", "加密"
    - "日志", "监控", "告警", "统计", "分析"
  
  低权重词 (权重: 1.0):
    - "文档", "说明", "手册", "指南", "教程"
    - "培训", "交接", "移交", "支持", "维护"
  
  排除词 (权重: -2.0):
    - "代码修改", "功能调整", "逻辑变更", "算法优化"
    - "界面调整", "交互修改", "样式更新"
```

### 动态权重调整
```yaml
权重调整因子:
  时间因子:
    - 最近使用的关键词权重增加 20%
    - 长期未使用的关键词权重减少 10%
  
  成功因子:
    - 成功推荐后相关关键词权重增加 15%
    - 错误推荐后相关关键词权重减少 25%
  
  用户偏好因子:
    - 用户偏好的工作方式相关关键词权重增加 10%
    - 用户不喜欢的方式相关关键词权重减少 15%
  
  项目类型因子:
    - 特定项目类型的专用关键词权重增加 25%
    - 不适用项目类型的关键词权重减少 20%
```

## 🔍 语义理解系统

### 意图识别模型
```yaml
意图分类:
  信息获取意图:
    模式: ["什么是", "如何", "为什么", "能否", "是否"]
    推荐策略: 提供详细说明和建议
    阶段倾向: 当前阶段或需求分析
  
  执行操作意图:
    模式: ["开始", "创建", "实现", "部署", "测试"]
    推荐策略: 直接进入相应执行阶段
    阶段倾向: 根据操作类型确定
  
  问题解决意图:
    模式: ["问题", "错误", "Bug", "不工作", "失败"]
    推荐策略: 进入调试和优化模式
    阶段倾向: 测试优化阶段
  
  学习探索意图:
    模式: ["学习", "了解", "研究", "探索", "比较"]
    推荐策略: 提供学习资源和指导
    阶段倾向: 需求分析或架构设计
```

### 上下文语义分析
```yaml
语义特征提取:
  技术栈识别:
    - 编程语言: Python, JavaScript, Java, C#, Go, Rust
    - 前端框架: React, Vue, Angular, Svelte
    - 后端框架: Express, Django, Spring, .NET
    - 数据库: MySQL, PostgreSQL, MongoDB, Redis
  
  项目规模评估:
    - 小型项目: 个人项目、原型、学习项目
    - 中型项目: 团队项目、企业应用、产品开发
    - 大型项目: 平台系统、分布式应用、企业级解决方案
  
  复杂度分析:
    - 简单: 单一功能、直接逻辑、标准实现
    - 中等: 多模块集成、业务逻辑复杂、性能要求
    - 复杂: 分布式架构、高并发、安全要求、合规需求
```

## 📊 上下文分析引擎

### 项目状态分析
```yaml
状态维度:
  进度状态:
    - 项目阶段和完成度
    - 里程碑达成情况
    - 时间线和延期风险
  
  技术状态:
    - 技术栈成熟度
    - 架构稳定性
    - 代码质量指标
  
  团队状态:
    - 团队规模和技能
    - 工作负载和效率
    - 协作模式和工具
  
  资源状态:
    - 时间和预算约束
    - 硬件和基础设施
    - 外部依赖和风险
```

### 历史模式识别
```yaml
模式类型:
  成功模式:
    - 高效的工作流程
    - 成功的技术选择
    - 有效的问题解决方案
  
  风险模式:
    - 常见的错误和陷阱
    - 性能瓶颈和问题
    - 集成和兼容性问题
  
  用户偏好模式:
    - 喜欢的技术和工具
    - 习惯的工作方式
    - 学习和成长轨迹
```

## 🎯 推荐决策引擎

### 决策算法
```yaml
决策流程:
  1. 输入预处理:
     - 文本清理和标准化
     - 关键词提取和标记
     - 语义特征向量化
  
  2. 多维度评分:
     - 关键词匹配得分
     - 语义相似度得分
     - 上下文适配得分
     - 历史成功率得分
  
  3. 综合决策:
     - 加权平均计算
     - 置信度评估
     - 备选方案生成
  
  4. 结果优化:
     - 多样性保证
     - 可解释性增强
     - 个性化调整
```

### 推荐策略
```yaml
策略类型:
  保守策略:
    - 优先推荐当前阶段的后续步骤
    - 避免大幅度的阶段跳跃
    - 确保工作连续性和稳定性
  
  积极策略:
    - 根据用户意图快速切换阶段
    - 支持并行工作和快速迭代
    - 鼓励探索和创新
  
  平衡策略:
    - 综合考虑效率和稳定性
    - 根据项目特点动态调整
    - 提供多种选择和建议
```

## 📈 学习和优化系统

### 反馈收集
```yaml
反馈类型:
  显式反馈:
    - 用户确认或拒绝推荐
    - 满意度评分和评价
    - 改进建议和意见
  
  隐式反馈:
    - 用户行为和选择模式
    - 任务完成时间和质量
    - 错误率和重试次数
  
  系统反馈:
    - 推荐准确率统计
    - 性能指标监控
    - 异常情况检测
```

### 模型优化
```yaml
优化方法:
  参数调优:
    - 权重系数的动态调整
    - 阈值参数的优化
    - 算法超参数的调节
  
  特征工程:
    - 新特征的发现和提取
    - 特征组合和变换
    - 特征选择和降维
  
  模型更新:
    - 在线学习和增量更新
    - 模型版本管理和回滚
    - A/B测试和效果评估
```

## 🎨 推荐结果展示

### 推荐格式
```yaml
标准推荐格式:
  "🤖 智能推荐分析
   
   📊 输入分析:
   • 关键词匹配: [匹配的关键词]
   • 意图识别: [识别的用户意图]
   • 上下文评估: [当前项目状态]
   
   🎯 推荐结果:
   • 建议阶段: [推荐的项目阶段]
   • 置信度: [推荐置信度百分比]
   • 推荐理由: [详细的推荐理由]
   
   📋 下一步行动:
   • 主要任务: [阶段的主要任务]
   • 预期产出: [阶段的预期产出]
   • 注意事项: [需要注意的事项]
   
   🔄 其他选择:
   • 备选方案: [其他可能的选择]
   • 风险提示: [潜在的风险和挑战]
   
   确认切换到推荐阶段吗？(y/n)"
```

### 个性化定制
```yaml
定制选项:
  详细程度:
    - 简洁模式: 只显示推荐结果
    - 标准模式: 包含分析和理由
    - 详细模式: 包含所有信息和选项
  
  交互方式:
    - 自动模式: 直接执行推荐
    - 确认模式: 需要用户确认
    - 选择模式: 提供多个选项
  
  显示风格:
    - 技术风格: 专业术语和详细分析
    - 友好风格: 通俗易懂的表达
    - 简洁风格: 直接明了的建议
```

---

**🚀 使用提示**: 输入 `/recommend` 或自然描述您的需求，智能推荐引擎将为您提供最佳的项目阶段建议！ 
---
type: "global_rule"
description: "记忆系统集成 - 项目记忆存储、管理和智能使用"
globs: ["**/*"]
priority: 940
---

# 💾 记忆系统集成

> **智能记忆**: 项目全生命周期记忆管理，支持智能检索和上下文感知

## 🎯 系统概述

记忆系统是超级大脑系统的核心组件，负责存储、管理和智能使用项目相关的所有信息，确保AI代理能够保持上下文连续性和学习能力。

## 🏗️ 记忆架构

### 记忆层次结构
```yaml
记忆层次:
  L1_会话记忆:
    范围: 当前对话会话
    生命周期: 会话结束时清除
    内容: 临时交互、即时决策
  
  L2_项目记忆:
    范围: 单个项目全生命周期
    生命周期: 项目完成后归档
    内容: 项目状态、阶段信息、技术决策
  
  L3_全局记忆:
    范围: 跨项目经验和知识
    生命周期: 永久保存
    内容: 最佳实践、模式库、用户偏好
  
  L4_学习记忆:
    范围: AI系统自我优化
    生命周期: 持续更新
    内容: 算法参数、性能指标、优化策略
```

### MCP Memory工具集成
```yaml
MCP记忆工具使用:
  实体创建:
    触发条件:
      - 新项目启动
      - 重要技术决策
      - 关键里程碑达成
      - 问题解决方案
    
    实体类型:
      - Project: 项目基本信息
      - Phase: 项目阶段状态
      - Decision: 技术决策记录
      - Solution: 解决方案记录
      - User: 用户偏好和习惯
  
  关系建立:
    关系类型:
      - belongs_to: 归属关系
      - depends_on: 依赖关系
      - leads_to: 导致关系
      - similar_to: 相似关系
      - conflicts_with: 冲突关系
  
  观察记录:
    自动记录:
      - 用户输入和AI响应
      - 工具使用和结果
      - 错误和解决过程
      - 性能指标和优化
```

## 📝 自动记录机制

### 触发条件详细定义
```yaml
强制记录触发:
  项目生命周期事件:
    - 项目创建: 记录项目基本信息和初始需求
    - 阶段切换: 保存当前阶段成果和下阶段计划
    - 项目完成: 归档项目总结和经验教训
    - 项目暂停/恢复: 记录状态变更原因
  
  技术决策事件:
    - 技术栈选择: 记录选择理由和替代方案
    - 架构设计: 保存设计方案和权衡考虑
    - 工具选择: 记录工具评估和使用效果
    - 性能优化: 保存优化策略和效果评估
  
  问题解决事件:
    - Bug发现和修复: 记录问题描述和解决方案
    - 性能瓶颈: 保存分析过程和优化结果
    - 集成问题: 记录集成挑战和解决策略
    - 部署问题: 保存部署经验和最佳实践
  
  用户交互事件:
    - 重要确认: 记录用户确认的关键决策
    - 偏好表达: 保存用户技术偏好和习惯
    - 反馈意见: 记录用户满意度和改进建议
    - 学习需求: 保存用户知识盲点和学习计划
```

### 记录内容标准
```yaml
记录格式:
  基础信息:
    - 时间戳: ISO 8601格式
    - 项目ID: 唯一标识符
    - 阶段标识: 当前项目阶段
    - 用户ID: 用户唯一标识
  
  内容结构:
    - 事件类型: 分类标签
    - 事件描述: 详细说明
    - 上下文信息: 相关背景
    - 结果评估: 效果和影响
    - 关联实体: 相关项目、决策等
  
  元数据:
    - 重要性级别: 1-5级评分
    - 可信度: 信息准确性评估
    - 更新频率: 信息变更频率
    - 访问权限: 信息共享范围
```

## 🔍 智能检索系统

### 检索策略
```yaml
检索算法:
  语义检索:
    - 基于向量相似度的语义匹配
    - 支持自然语言查询
    - 上下文感知的结果排序
  
  关联检索:
    - 基于实体关系的关联查找
    - 支持多跳关系推理
    - 时间序列相关性分析
  
  模式检索:
    - 基于历史模式的预测性检索
    - 支持相似场景的经验复用
    - 异常模式的识别和预警
  
  混合检索:
    - 多种检索策略的智能组合
    - 动态权重调整和优化
    - 个性化检索结果定制
```

### 检索优化
```yaml
性能优化:
  索引策略:
    - 多维度索引构建
    - 增量索引更新
    - 分布式索引管理
  
  缓存机制:
    - 热点数据缓存
    - 预测性数据预加载
    - 智能缓存淘汰策略
  
  查询优化:
    - 查询重写和优化
    - 并行查询执行
    - 结果去重和合并
```

## 🧠 上下文感知

### 上下文构建
```yaml
上下文要素:
  当前状态:
    - 项目阶段和进度
    - 技术栈和架构
    - 团队规模和技能
    - 时间和资源约束
  
  历史轨迹:
    - 过往决策和结果
    - 问题解决历程
    - 学习和改进过程
    - 用户反馈和偏好
  
  环境因素:
    - 技术趋势和最佳实践
    - 行业标准和规范
    - 工具生态和兼容性
    - 安全和合规要求
```

### 上下文应用
```yaml
智能应用:
  决策支持:
    - 基于历史经验的决策建议
    - 风险评估和预警
    - 替代方案的比较分析
  
  个性化服务:
    - 用户偏好的自动适配
    - 个性化工作流推荐
    - 定制化界面和交互
  
  预测性分析:
    - 项目风险预测
    - 资源需求预估
    - 时间线预测和调整
```

## 🔄 记忆同步和一致性

### 同步机制
```yaml
同步策略:
  实时同步:
    - 关键事件的即时记录
    - 状态变更的实时更新
    - 冲突检测和解决
  
  批量同步:
    - 非关键信息的批量处理
    - 定期数据整理和归档
    - 性能优化的延迟更新
  
  增量同步:
    - 变更数据的增量传输
    - 版本控制和回滚支持
    - 数据完整性验证
```

### 一致性保证
```yaml
一致性级别:
  强一致性:
    - 关键决策和状态信息
    - 项目阶段和里程碑
    - 用户确认和授权
  
  最终一致性:
    - 统计数据和分析结果
    - 学习模型和参数
    - 缓存和索引信息
  
  弱一致性:
    - 日志和调试信息
    - 临时状态和中间结果
    - 性能监控数据
```

## 📊 记忆分析和洞察

### 分析维度
```yaml
分析类型:
  趋势分析:
    - 项目成功率趋势
    - 技术选择演变
    - 用户行为模式
  
  关联分析:
    - 技术栈与项目成功的关联
    - 团队规模与效率的关系
    - 问题类型与解决时间的相关性
  
  异常检测:
    - 项目进度异常
    - 性能指标异常
    - 用户行为异常
  
  预测分析:
    - 项目成功概率预测
    - 资源需求预测
    - 风险发生概率预测
```

### 洞察应用
```yaml
洞察输出:
  报告生成:
    - 项目总结报告
    - 性能分析报告
    - 改进建议报告
  
  可视化展示:
    - 项目进度仪表板
    - 技术栈使用统计
    - 问题解决效率图表
  
  智能推荐:
    - 基于历史数据的最佳实践推荐
    - 个性化工具和方法建议
    - 风险预防和缓解策略
```

## 🛡️ 隐私和安全

### 数据保护
```yaml
安全措施:
  数据加密:
    - 传输过程加密
    - 存储数据加密
    - 密钥管理和轮换
  
  访问控制:
    - 基于角色的权限管理
    - 细粒度访问控制
    - 审计日志和监控
  
  隐私保护:
    - 敏感信息脱敏
    - 数据最小化原则
    - 用户同意和控制
```

### 合规要求
```yaml
合规标准:
  数据治理:
    - 数据分类和标记
    - 生命周期管理
    - 质量监控和改进
  
  法规遵循:
    - GDPR合规性
    - 数据本地化要求
    - 行业特定规范
  
  透明度:
    - 数据使用说明
    - 算法可解释性
    - 用户权利保障
```

---

**💡 使用提示**: 记忆系统将自动记录您的项目信息，使用 `/memory` 命令可以查看和管理项目记忆！ 
---
type: "global_rule"
description: "超级大脑系统 - 智能项目管理激活机制和核心功能"
globs: ["**/*"]
priority: 970
---

# 🧠 超级大脑系统

> **智能核心**: 集成项目管理、阶段控制、记忆系统和智能推荐的统一管理平台

## 🎯 系统定义

超级大脑系统是一个智能化的AI代理管理平台，整合了项目生命周期管理、智能决策支持、记忆系统和自动化工作流编排功能。

## 🚀 激活机制

### 主要触发词
```yaml
系统激活:
  完整触发词:
    - "启动超级大脑系统"
    - "启动智能项目管理"
    - "激活项目大脑"
    - "开启智能管理"
    - "启动AI项目助手"
  
  简化触发词:
    - "超级大脑"
    - "智能管理"
    - "项目大脑"
  
  状态查询:
    - "查看项目状态"
    - "项目进度如何"
    - "当前在哪个阶段"
    - "系统状态"
    - "大脑状态"
```

### 激活响应模板
```yaml
激活成功响应:
  "🧠 超级大脑系统已激活！
   
   📊 系统状态: 运行中
   🎯 当前项目: [项目名称或'未设定']
   📋 当前阶段: [阶段信息或'待确定']
   💾 记忆状态: [已加载/空白]
   
   🤖 可用功能:
   • 智能阶段推荐 (/recommend)
   • 项目状态查询 (/status)
   • 阶段切换 (/switch [阶段号])
   • 记忆查看 (/memory)
   • 工具编排优化
   
   💡 请告诉我您的项目需求，我将为您提供最佳的管理方案！"
```

## 🎛️ 核心功能模块

### 1. 智能项目识别
```yaml
项目类型识别:
  Web应用:
    关键词: ["网站", "Web", "前端", "后端", "全栈"]
    推荐阶段: 需求分析
    技术栈: React/Vue + Node.js/Python
  
  移动应用:
    关键词: ["APP", "移动", "手机", "iOS", "Android"]
    推荐阶段: 需求分析
    技术栈: React Native/Flutter
  
  桌面应用:
    关键词: ["桌面", "客户端", "软件", "工具"]
    推荐阶段: 需求分析
    技术栈: Electron/Tauri
  
  数据分析:
    关键词: ["数据", "分析", "可视化", "报表"]
    推荐阶段: 需求分析
    技术栈: Python/R + 可视化库
  
  AI/ML项目:
    关键词: ["AI", "机器学习", "深度学习", "模型"]
    推荐阶段: 需求分析
    技术栈: Python + ML框架
```

### 2. 智能决策引擎
```yaml
决策支持:
  技术选型建议:
    - 基于项目类型和规模
    - 考虑团队技能和偏好
    - 评估维护成本和生态
  
  架构模式推荐:
    - 单体 vs 微服务
    - 前后端分离 vs 全栈
    - 云原生 vs 传统部署
  
  开发流程优化:
    - 敏捷 vs 瀑布模型
    - CI/CD 流水线设计
    - 测试策略制定
```

### 3. 自动化工作流编排
```yaml
MCP工具智能编排:
  工具选择策略:
    - 基于当前阶段自动选择最优工具
    - 考虑工具间的协同效应
    - 动态调整工具使用优先级
  
  执行优化:
    - 并行执行非依赖任务
    - 智能重试和错误恢复
    - 资源使用优化
  
  结果验证:
    - 自动质量检查
    - 输出结果验证
    - 异常情况处理
```

### 4. 学习和优化系统
```yaml
持续学习:
  模式识别:
    - 用户行为模式分析
    - 项目成功模式总结
    - 常见问题模式识别
  
  优化建议:
    - 基于历史数据的改进建议
    - 个性化工作流推荐
    - 效率提升方案
  
  知识积累:
    - 最佳实践库构建
    - 经验教训总结
    - 技术趋势跟踪
```

## 🔄 系统集成规则

### 与项目管理系统集成
```yaml
集成要求:
  1. 自动检测项目管理规则激活状态
  2. 同步项目阶段和记忆信息
  3. 协调MCP工具使用策略
  4. 统一用户交互界面
```

### 与MCP工具集成
```yaml
工具编排原则:
  1. 优先使用高效工具组合
  2. 避免重复和冲突操作
  3. 智能错误处理和恢复
  4. 实时性能监控和优化
```

## 📊 状态监控

### 系统健康检查
```yaml
监控指标:
  - 响应时间和处理效率
  - 工具使用成功率
  - 用户满意度指标
  - 项目完成质量
  
告警机制:
  - 性能下降预警
  - 工具故障检测
  - 异常行为识别
  - 资源使用监控
```

### 用户反馈循环
```yaml
反馈收集:
  - 实时用户体验评分
  - 功能使用频率统计
  - 问题和建议收集
  - 改进效果评估
  
优化迭代:
  - 基于反馈的功能调整
  - 算法参数优化
  - 新功能开发优先级
  - 用户体验持续改进
```

## 🎯 使用指南

### 快速启动
1. 使用触发词激活系统
2. 描述项目需求和目标
3. 接受智能推荐的阶段和工具
4. 开始智能化项目管理

### 高级功能
1. 自定义项目模板
2. 个性化工作流配置
3. 团队协作模式设置
4. 性能监控和优化

### 最佳实践
1. 定期查看项目状态和进度
2. 及时响应系统推荐和建议
3. 积极提供反馈和改进意见
4. 充分利用记忆系统和历史经验

---

**🚀 立即体验**: 输入"启动超级大脑系统"开始您的智能项目管理之旅！ 
---
type: "global_rule"
description: "系统集成配置 - 确保所有智能系统组件协同工作的配置和协调规则"
globs: ["**/*"]
priority: 960
---

# ⚙️ 系统集成配置

> **统一协调**: 确保超级大脑、项目管理、记忆系统和推荐引擎的无缝集成和协同工作

## 🎯 集成架构概述

### 系统组件关系
```yaml
核心组件架构:
  超级大脑系统 (优先级: 960):
    角色: 统一管理和决策中心
    功能: 系统激活、状态监控、决策支持
    依赖: 项目管理、记忆系统、推荐引擎
  
  项目管理系统 (优先级: 900):
    角色: 项目生命周期管理
    功能: 阶段管理、工作流编排、质量保证
    依赖: 记忆系统、推荐引擎、MCP工具
  
  记忆系统 (优先级: 940):
    角色: 信息存储和智能检索
    功能: 记忆管理、上下文感知、经验积累
    依赖: MCP Memory工具
  
  推荐引擎 (优先级: 930):
    角色: 智能决策支持
    功能: 阶段推荐、工具选择、策略优化
    依赖: 记忆系统、项目状态
  
  工作流集成 (优先级: 920):
    角色: 完整生命周期管理
    功能: 端到端流程、质量标准、工具编排
    依赖: 所有其他系统
  
  MCP策略 (优先级: 800):
    角色: 工具使用策略
    功能: 工具选择、效率优化、最佳实践
    依赖: 智能系统指导
```

## 🔄 系统启动和初始化

### 启动序列
```yaml
系统启动流程:
  阶段1_基础初始化:
    1. 加载系统配置和规则
    2. 初始化MCP工具连接
    3. 检查记忆系统状态
    4. 验证推荐引擎可用性
  
  阶段2_状态恢复:
    1. 恢复项目状态和阶段信息
    2. 加载用户偏好和历史数据
    3. 重建上下文和关联关系
    4. 同步各系统状态信息
  
  阶段3_智能激活:
    1. 启动超级大脑监控
    2. 激活智能推荐引擎
    3. 开启自动记录机制
    4. 建立系统间通信通道
  
  阶段4_就绪确认:
    1. 验证所有系统功能正常
    2. 确认数据一致性和完整性
    3. 测试系统响应和性能
    4. 标记系统就绪状态
```

### 健康检查
```yaml
系统健康监控:
  实时监控指标:
    - 系统响应时间 < 2秒
    - 记忆系统可用性 > 99%
    - 推荐引擎准确率 > 85%
    - MCP工具连接状态正常
  
  定期检查项目:
    - 数据一致性验证 (每小时)
    - 性能基准测试 (每日)
    - 用户满意度评估 (每周)
    - 系统优化和调整 (每月)
  
  异常处理机制:
    - 自动故障检测和报告
    - 降级服务和备用方案
    - 快速恢复和状态同步
    - 事后分析和改进措施
```

## 🔗 系统间通信协议

### 数据交换格式
```yaml
标准消息格式:
  系统消息结构:
    {
      "timestamp": "ISO 8601时间戳",
      "source_system": "发送系统标识",
      "target_system": "目标系统标识",
      "message_type": "消息类型",
      "priority": "优先级(1-5)",
      "data": {
        "action": "操作类型",
        "parameters": "操作参数",
        "context": "上下文信息",
        "metadata": "元数据信息"
      },
      "correlation_id": "关联ID",
      "retry_count": "重试次数"
    }
  
  消息类型定义:
    - SYSTEM_ACTIVATION: 系统激活请求
    - STATE_UPDATE: 状态更新通知
    - RECOMMENDATION_REQUEST: 推荐请求
    - MEMORY_RECORD: 记忆记录请求
    - PHASE_TRANSITION: 阶段切换通知
    - TOOL_ORCHESTRATION: 工具编排指令
    - ERROR_REPORT: 错误报告
    - HEALTH_CHECK: 健康检查
```

### 通信规则
```yaml
通信约定:
  同步通信:
    - 关键状态更新和确认
    - 阶段切换和验证
    - 错误处理和恢复
    - 用户交互和确认
  
  异步通信:
    - 记忆记录和存储
    - 性能监控和统计
    - 学习模型更新
    - 日志记录和分析
  
  通信优先级:
    1. 紧急: 系统错误、安全问题
    2. 高: 用户交互、状态变更
    3. 中: 推荐请求、工具编排
    4. 低: 统计数据、日志记录
  
  超时和重试:
    - 同步消息超时: 5秒
    - 异步消息超时: 30秒
    - 最大重试次数: 3次
    - 重试间隔: 指数退避
```

## 🎛️ 状态管理和同步

### 全局状态定义
```yaml
系统状态结构:
  global_state:
    system_status:
      super_brain_active: boolean
      project_management_active: boolean
      memory_system_active: boolean
      recommendation_engine_active: boolean
    
    current_project:
      project_id: string
      project_name: string
      project_type: string
      current_phase: integer (1-5)
      phase_start_time: timestamp
      last_activity: timestamp
    
    user_context:
      user_id: string
      preferences: object
      skill_level: string
      work_style: string
      recent_activities: array
    
    performance_metrics:
      response_time: number
      success_rate: number
      user_satisfaction: number
      tool_efficiency: number
```

### 状态同步机制
```yaml
同步策略:
  实时同步:
    触发条件:
      - 项目阶段切换
      - 重要决策确认
      - 系统激活/停用
      - 错误和异常发生
    
    同步范围:
      - 项目状态和进度
      - 用户上下文和偏好
      - 系统配置和设置
      - 关键性能指标
  
  批量同步:
    触发条件:
      - 定时任务执行
      - 系统空闲时段
      - 数据积累达到阈值
      - 用户主动请求
    
    同步内容:
      - 历史记录和日志
      - 统计数据和分析
      - 学习模型参数
      - 缓存和索引数据
  
  冲突解决:
    - 时间戳优先原则
    - 用户确认优先
    - 系统一致性检查
    - 手动干预机制
```

## 🔧 配置管理

### 系统配置参数
```yaml
核心配置:
  超级大脑系统:
    activation_timeout: 10  # 激活超时(秒)
    monitoring_interval: 5  # 监控间隔(秒)
    decision_threshold: 0.8  # 决策置信度阈值
    learning_rate: 0.01  # 学习率
  
  项目管理系统:
    phase_transition_timeout: 30  # 阶段切换超时(秒)
    quality_check_enabled: true  # 质量检查开关
    auto_phase_detection: true  # 自动阶段检测
    strict_constraints: true  # 严格约束模式
  
  记忆系统:
    auto_record_enabled: true  # 自动记录开关
    memory_retention_days: 365  # 记忆保留天数
    search_result_limit: 50  # 搜索结果限制
    context_window_size: 10  # 上下文窗口大小
  
  推荐引擎:
    recommendation_count: 3  # 推荐数量
    confidence_threshold: 0.7  # 置信度阈值
    learning_enabled: true  # 学习功能开关
    personalization_level: 0.8  # 个性化程度
```

### 动态配置调整
```yaml
配置优化:
  自适应调整:
    - 基于性能指标自动调整参数
    - 根据用户反馈优化配置
    - 基于使用模式调整策略
    - 根据系统负载动态调节
  
  A/B测试:
    - 配置参数对比测试
    - 算法效果评估
    - 用户体验对比
    - 性能影响分析
  
  配置版本管理:
    - 配置变更历史记录
    - 版本回滚和恢复
    - 配置差异对比
    - 变更影响评估
```

## 🛡️ 安全和权限管理

### 访问控制
```yaml
权限模型:
  系统级权限:
    - SYSTEM_ADMIN: 系统管理员权限
    - PROJECT_MANAGER: 项目管理权限
    - USER: 普通用户权限
    - GUEST: 访客权限
  
  功能级权限:
    - ACTIVATE_SUPER_BRAIN: 激活超级大脑
    - MANAGE_PROJECT_PHASES: 管理项目阶段
    - ACCESS_MEMORY_SYSTEM: 访问记忆系统
    - USE_RECOMMENDATION: 使用推荐功能
    - MODIFY_CONFIGURATION: 修改配置
  
  数据级权限:
    - READ_PROJECT_DATA: 读取项目数据
    - WRITE_PROJECT_DATA: 写入项目数据
    - DELETE_PROJECT_DATA: 删除项目数据
    - EXPORT_PROJECT_DATA: 导出项目数据
```

### 安全措施
```yaml
安全策略:
  数据保护:
    - 敏感数据加密存储
    - 传输过程加密保护
    - 访问日志记录和审计
    - 数据备份和恢复
  
  系统安全:
    - 输入验证和过滤
    - 防止注入攻击
    - 会话管理和超时
    - 异常监控和报警
  
  隐私保护:
    - 用户数据匿名化
    - 最小权限原则
    - 数据使用透明度
    - 用户控制和选择
```

## 📊 监控和分析

### 性能监控
```yaml
监控指标:
  系统性能:
    - CPU使用率和内存占用
    - 响应时间和吞吐量
    - 错误率和可用性
    - 网络延迟和带宽
  
  业务指标:
    - 用户活跃度和满意度
    - 功能使用频率和效果
    - 项目成功率和质量
    - 工具效率和优化效果
  
  质量指标:
    - 推荐准确率和接受率
    - 记忆检索精度和召回率
    - 阶段切换成功率
    - 用户体验评分
```

### 分析和报告
```yaml
分析维度:
  趋势分析:
    - 系统性能趋势
    - 用户行为模式
    - 功能使用趋势
    - 问题发生趋势
  
  对比分析:
    - 不同配置效果对比
    - 用户群体差异分析
    - 功能版本对比
    - 竞品对比分析
  
  预测分析:
    - 系统负载预测
    - 用户需求预测
    - 故障风险预测
    - 优化效果预测
```

## 🔄 持续改进机制

### 反馈循环
```yaml
改进流程:
  数据收集:
    - 用户行为数据
    - 系统性能数据
    - 错误和异常数据
    - 用户反馈数据
  
  分析评估:
    - 数据清洗和预处理
    - 模式识别和异常检测
    - 根因分析和影响评估
    - 改进机会识别
  
  优化实施:
    - 算法参数调优
    - 功能改进和增强
    - 流程优化和简化
    - 用户体验提升
  
  效果验证:
    - A/B测试验证
    - 性能指标对比
    - 用户满意度调查
    - 长期效果跟踪
```

### 版本管理
```yaml
版本策略:
  发布周期:
    - 主版本: 6个月
    - 次版本: 1个月
    - 补丁版本: 1周
    - 热修复: 即时
  
  版本内容:
    - 新功能和增强
    - Bug修复和优化
    - 安全更新和加固
    - 性能改进和调优
  
  兼容性保证:
    - 向后兼容性维护
    - 迁移工具和指南
    - 废弃功能通知
    - 平滑升级路径
```

---

**🎯 集成目标**: 通过统一的系统集成配置，确保所有智能组件协同工作，为用户提供无缝的智能项目管理体验！ 
---
type: "always_apply"
description: "规则冲突解决和用户指令优先级管理 - 确保用户指令始终优先，解决规则间冲突"
globs: ["**/*"]
alwaysApply: true
priority: 1100
---

# ⚖️ 规则冲突解决和用户指令优先级管理

> **最高优先级**: 用户指令始终优先，规则冲突智能解决，确保系统行为一致性和可预测性

## 🎯 核心原则

### 1. 用户指令绝对优先
```yaml
优先级层次:
  Level 1 - 用户明确指令 (优先级: 无限大):
    - 用户的直接命令和要求
    - 用户的明确偏好和选择
    - 用户的实时反馈和修正
    - 用户的安全和隐私要求
  
  Level 2 - 安全规则 (优先级: 1000+):
    - 文件生成安全规则
    - 数据保护和隐私规则
    - 系统安全和稳定性规则
  
  Level 3 - 系统集成规则 (优先级: 950-999):
    - 智能系统协调规则
    - 工作流编排规则
    - 状态管理规则
  
  Level 4 - 功能规则 (优先级: 800-949):
    - 前端/后端开发规则
    - 项目管理规则
    - 技术实现规则
  
  Level 5 - 辅助规则 (优先级: <800):
    - 代码风格规则
    - 文档生成规则
    - 优化建议规则
```

### 2. 用户指令识别和处理
```yaml
用户指令识别:
  明确指令类型:
    - 直接命令: "请创建...", "开始实现...", "生成..."
    - 偏好表达: "我希望...", "我更喜欢...", "请使用..."
    - 修正指令: "不对，应该是...", "改成...", "取消..."
    - 确认指令: "是的，继续", "确认", "同意"
  
  冲突处理:
    - 用户指令与规则冲突时，优先执行用户指令
    - 安全风险时，询问用户确认并说明风险
    - 技术不可行时，解释原因并提供替代方案
    - 不确定时，主动询问用户意见
```

## 🔧 规则冲突解决机制

### 1. 优先级冲突解决
```yaml
当前优先级冲突:
  优先级950冲突:
    - super-brain-system.mdc (950) → 调整为 970
    - ai-agent-intelligence-core.md (950) → 调整为 980
    - mcp-intelligent-strategy.mdc (950) → 保持 950
  
  解决方案:
    - AI代理智能核心 (980): 最高级智能决策
    - 超级大脑系统 (970): 项目管理和协调
    - 系统集成配置 (960): 系统间协调
    - MCP智能策略 (950): 工具使用策略
```

### 2. 功能重复解决
```yaml
重复功能整合:
  智能系统激活:
    - 主要文件: super-brain-system.mdc
    - 移除重复: 其他文件中的激活逻辑
    - 统一入口: "启动超级大脑系统"
  
  项目管理:
    - 主要文件: intelligent-project-management.mdc
    - 协调文件: complete-workflow-integration.mdc
    - 避免重复: 明确职责分工
  
  MCP工具策略:
    - 主要文件: mcp-intelligent-strategy.mdc
    - 避免重复: 其他文件不再定义MCP策略
```

## 🚨 用户指令冲突处理

### 1. 用户与规则冲突
```yaml
处理流程:
  检测冲突:
    - 实时监控用户指令与规则的冲突
    - 识别潜在的安全风险和技术问题
    - 评估冲突的严重程度和影响范围
  
  冲突响应:
    安全冲突:
      "⚠️ 检测到安全风险：[具体风险]
       您的指令是：[用户指令]
       建议方案：[安全替代方案]
       
       请确认：
       1. 继续执行（我了解风险）
       2. 采用建议方案
       3. 取消操作"
    
    技术冲突:
      "🔧 技术限制：[具体限制]
       您的需求：[用户需求]
       可行方案：[替代方案列表]
       
       请选择：
       1. [方案A]
       2. [方案B]
       3. 重新描述需求"
    
    偏好冲突:
      "💡 检测到偏好差异：
       规则建议：[规则建议]
       您的偏好：[用户偏好]
       
       我将按照您的偏好执行，是否确认？"
```

### 2. 用户指令优先执行
```yaml
执行原则:
  无条件优先:
    - 用户的明确指令始终优先执行
    - 规则仅作为建议和指导
    - 用户有最终决定权
  
  安全保护:
    - 涉及安全风险时必须告知用户
    - 提供风险评估和建议方案
    - 用户确认后可以执行
  
  学习优化:
    - 记录用户的偏好和选择
    - 优化后续的建议和推荐
    - 个性化规则应用
```

## 📊 冲突监控和报告

### 1. 实时监控
```yaml
监控指标:
  冲突频率:
    - 用户指令与规则冲突次数
    - 规则间冲突检测次数
    - 冲突解决成功率
  
  用户满意度:
    - 用户指令执行成功率
    - 用户反馈和评价
    - 用户偏好学习效果
  
  系统稳定性:
    - 规则执行一致性
    - 系统响应时间
    - 错误和异常频率
```

### 2. 优化建议
```yaml
持续改进:
  规则优化:
    - 基于冲突数据优化规则优先级
    - 简化重复和冗余的规则
    - 提高规则的清晰度和可理解性
  
  用户体验:
    - 减少不必要的确认请求
    - 提高指令识别准确性
    - 优化冲突解决流程
  
  系统性能:
    - 优化规则加载和执行效率
    - 减少系统资源消耗
    - 提高响应速度
```

## 🎯 实施指南

### 1. AI助手行为准则
```yaml
必须遵循:
  1. 始终将用户指令放在最高优先级
  2. 检测到冲突时主动询问用户意见
  3. 清楚说明冲突原因和可选方案
  4. 记录用户偏好用于后续优化
  5. 在安全风险时必须告知用户
  
禁止行为:
  1. 忽略用户的明确指令
  2. 在冲突时自行决定而不询问用户
  3. 隐瞒潜在的安全风险
  4. 强制执行规则而忽视用户需求
  5. 重复询问已确认的用户偏好
```

### 2. 用户指导建议
```yaml
最佳实践:
  明确表达:
    - 使用清晰明确的指令
    - 表达具体的需求和偏好
    - 及时提供反馈和确认
  
  安全意识:
    - 理解安全风险提醒
    - 谨慎处理敏感操作
    - 配合安全检查流程
  
  有效沟通:
    - 描述期望的结果
    - 说明特殊要求和限制
    - 提供必要的上下文信息
```

---

**🎯 核心目标**: 确保用户指令始终优先，规则冲突得到智能解决，系统行为保持一致性和可预测性，用户体验持续优化！ 
---
type: "always_apply"
description: "规则冗余优化和功能整合 - 消除重复功能，明确职责分工，提升系统效率"
globs: ["**/*"]
alwaysApply: true
priority: 1050
---

# 🔧 规则冗余优化和功能整合

> **系统优化**: 消除规则间的功能重复，明确职责分工，提升系统运行效率和一致性

## 🎯 发现的冗余问题

### 1. 优先级冲突 (已解决)
```yaml
原冲突情况:
  - super-brain-system.mdc: 950 → 970 ✅
  - ai-agent-intelligence-core.md: 950 → 980 ✅
  - mcp-intelligent-strategy.mdc: 950 (保持)
  - system-integration-config.mdc: 960 (保持)

新优先级层次:
  Level 1: ai-agent-intelligence-core.md (980) - 智能决策核心
  Level 2: super-brain-system.mdc (970) - 项目管理平台
  Level 3: system-integration-config.mdc (960) - 系统集成配置
  Level 4: mcp-intelligent-strategy.mdc (950) - 工具使用策略
```

### 2. 功能重复分析
```yaml
重复功能识别:
  项目管理功能:
    主要文件: intelligent-project-management.mdc (900)
    重复文件: intelligent-workflow-orchestration.mdc (900)
    重复内容: 阶段管理、任务分解、工作流编排
    
  智能系统激活:
    主要文件: super-brain-system.mdc (970)
    重复位置: 多个文件中的激活逻辑
    重复内容: 系统启动命令、激活响应模板
    
  MCP工具策略:
    主要文件: mcp-intelligent-strategy.mdc (950)
    重复位置: 其他文件中的工具选择逻辑
    重复内容: 工具优先级、使用策略
```

## 🔄 功能整合方案

### 1. 项目管理功能整合
```yaml
职责分工:
  intelligent-project-management.mdc (主要):
    - 五阶段项目管理
    - 阶段切换机制
    - 智能推荐算法
    - 项目记忆系统
    - 基础工作流管理
    
  intelligent-workflow-orchestration.mdc (辅助):
    - 高级工作流编排
    - 复杂任务分解
    - 并行执行优化
    - 性能监控分析
    - 企业级工作流
    
  协作模式:
    - 基础项目管理由 intelligent-project-management.mdc 处理
    - 复杂工作流编排由 intelligent-workflow-orchestration.mdc 增强
    - 避免重复定义相同功能
```

### 2. 智能系统激活整合
```yaml
统一激活机制:
  主控文件: super-brain-system.mdc
  激活命令: "启动超级大脑系统"
  
  其他文件职责:
    - 不再定义独立的激活逻辑
    - 专注于各自的核心功能
    - 通过super-brain-system.mdc统一协调
    
  激活流程:
    1. 用户发出激活命令
    2. super-brain-system.mdc 响应并协调
    3. 相关系统按需激活和配置
    4. 统一的状态管理和反馈
```

### 3. MCP工具策略整合
```yaml
统一工具策略:
  主控文件: mcp-intelligent-strategy.mdc
  
  其他文件约束:
    - 不再定义独立的MCP工具选择逻辑
    - 可以声明工具需求和偏好
    - 由mcp-intelligent-strategy.mdc统一决策
    
  工具使用流程:
    1. 各规则文件声明工具需求
    2. mcp-intelligent-strategy.mdc 分析和选择
    3. 统一的工具调用和错误处理
    4. 性能监控和优化建议
```

## 📋 具体优化措施

### 1. 移除重复内容
```yaml
需要清理的重复内容:
  intelligent-workflow-orchestration.mdc:
    移除: 基础阶段管理逻辑
    移除: 简单任务分解功能
    移除: 重复的MCP工具策略
    保留: 高级工作流编排功能
    
  其他规则文件:
    移除: 独立的系统激活逻辑
    移除: 重复的工具选择策略
    移除: 冗余的状态管理代码
```

### 2. 明确接口规范
```yaml
规则间协作接口:
  项目管理接口:
    - getCurrentStage(): 获取当前项目阶段
    - switchStage(stage): 切换项目阶段
    - getProjectMemory(): 获取项目记忆
    - updateProjectStatus(status): 更新项目状态
    
  工具策略接口:
    - selectOptimalTool(task): 选择最优工具
    - getToolPriority(tools): 获取工具优先级
    - handleToolError(error): 处理工具错误
    - optimizeToolUsage(): 优化工具使用
    
  系统激活接口:
    - activateSystem(config): 激活系统
    - getSystemStatus(): 获取系统状态
    - coordinateSubsystems(): 协调子系统
    - generateResponse(template): 生成响应
```

### 3. 性能优化
```yaml
优化策略:
  规则加载优化:
    - 减少重复规则的加载时间
    - 优化规则依赖关系
    - 实现规则缓存机制
    
  执行效率优化:
    - 避免重复的功能调用
    - 优化决策路径
    - 减少不必要的计算
    
  内存使用优化:
    - 共享通用数据结构
    - 减少重复的配置存储
    - 实现智能垃圾回收
```

## 🎯 实施计划

### 阶段1: 立即优化 (已完成)
```yaml
完成项目:
  ✅ 优先级冲突解决
  ✅ 创建冲突解决机制
  ✅ 创建冗余优化规则
```

### 阶段2: 内容整合 (进行中)
```yaml
待完成项目:
  🔄 清理intelligent-workflow-orchestration.mdc重复内容
  🔄 统一系统激活逻辑
  🔄 整合MCP工具策略
  🔄 优化规则间接口
```

### 阶段3: 验证测试
```yaml
测试计划:
  - 功能完整性测试
  - 性能基准测试
  - 冲突检测测试
  - 用户体验测试
```

## 📊 优化效果预期

### 1. 性能提升
```yaml
预期改进:
  规则加载时间: 减少30%
  决策响应时间: 减少25%
  内存使用量: 减少20%
  系统稳定性: 提升40%
```

### 2. 维护性提升
```yaml
预期改进:
  代码重复率: 减少60%
  维护复杂度: 降低50%
  新功能集成: 提升35%
  错误排查效率: 提升45%
```

### 3. 用户体验提升
```yaml
预期改进:
  响应一致性: 提升50%
  功能可预测性: 提升40%
  错误率: 减少30%
  学习曲线: 降低25%
```

## 🔍 持续监控

### 1. 冗余检测
```yaml
自动检测机制:
  - 定期扫描重复功能
  - 分析规则间依赖关系
  - 识别潜在的冲突点
  - 生成优化建议报告
```

### 2. 性能监控
```yaml
监控指标:
  - 规则执行时间统计
  - 内存使用量监控
  - 冲突发生频率
  - 用户满意度评分
```

---

**🎯 优化目标**: 构建高效、一致、可维护的规则系统，消除冗余，提升用户体验！ 
---
type: "project_rule"
description: "AI驱动的智能代码审查规则 - 基于机器学习的代码质量分析和自动化审查流程"
globs: ["**/*"]
priority: 850
---

# 🔍 AI驱动的智能代码审查规则

## 🎯 核心理念

基于最新AI代码审查技术，实现智能化、自动化的代码质量控制和审查流程。

### 🤖 智能审查引擎
```yaml
核心能力:
  静态分析增强:
    - 语义理解和上下文分析
    - 设计模式识别和评估
    - 架构一致性检查
    - 性能影响预测
  
  动态行为分析:
    - 运行时行为预测
    - 资源使用模式分析
    - 并发安全性检查
    - 异常处理完整性
  
  学习和适应:
    - 团队编码风格学习
    - 历史缺陷模式识别
    - 最佳实践自动应用
    - 个性化建议生成
```

## 🚀 智能审查流程

### 📋 自动触发机制
```yaml
触发条件:
  代码提交触发:
    - 每次commit自动触发
    - 差异分析和影响评估
    - 风险等级自动分类
    - 审查优先级排序
  
  Pull Request触发:
    - PR创建时全面审查
    - 变更影响范围分析
    - 冲突风险预测
    - 合并建议生成
  
  定期审查:
    - 技术债务定期扫描
    - 代码质量趋势分析
    - 安全漏洞定期检查
    - 性能回归检测
```

### 🎯 多层次审查策略
```yaml
审查层次:
  L1 - 语法和格式:
    自动化程度: 100%
    检查内容:
      - 代码格式规范
      - 命名约定检查
      - 注释完整性
      - 文档同步性
    处理方式: 自动修复 + 通知
  
  L2 - 逻辑和结构:
    自动化程度: 80%
    检查内容:
      - 逻辑错误检测
      - 代码复杂度分析
      - 重复代码识别
      - 依赖关系检查
    处理方式: 智能建议 + 人工确认
  
  L3 - 架构和设计:
    自动化程度: 60%
    检查内容:
      - 设计模式应用
      - 架构一致性
      - 接口设计合理性
      - 扩展性评估
    处理方式: 专家建议 + 团队讨论
  
  L4 - 业务和安全:
    自动化程度: 40%
    检查内容:
      - 业务逻辑正确性
      - 安全漏洞检测
      - 性能影响评估
      - 合规性检查
    处理方式: 专家审查 + 安全团队确认
```

## 🔍 智能分析维度

### 📊 代码质量分析
```yaml
质量维度:
  可读性分析:
    - 代码清晰度评分
    - 注释质量评估
    - 变量命名合理性
    - 函数复杂度分析
    评分权重: 25%
  
  可维护性分析:
    - 模块耦合度检查
    - 代码重复率分析
    - 修改影响范围评估
    - 测试覆盖率检查
    评分权重: 30%
  
  可靠性分析:
    - 异常处理完整性
    - 边界条件检查
    - 并发安全性验证
    - 资源管理检查
    评分权重: 25%
  
  性能分析:
    - 算法复杂度评估
    - 资源使用效率
    - 缓存策略检查
    - 数据库查询优化
    评分权重: 20%
```

### 🛡️ 安全性分析
```yaml
安全检查:
  输入验证:
    - SQL注入风险检测
    - XSS攻击防护检查
    - 输入参数验证
    - 数据类型安全检查
  
  权限控制:
    - 访问控制检查
    - 权限提升风险
    - 敏感操作审计
    - 认证机制验证
  
  数据保护:
    - 敏感数据识别
    - 加密算法检查
    - 数据传输安全
    - 存储安全验证
  
  依赖安全:
    - 第三方库漏洞扫描
    - 依赖版本安全检查
    - 许可证合规性
    - 供应链安全评估
```

### ⚡ 性能分析
```yaml
性能维度:
  算法效率:
    - 时间复杂度分析
    - 空间复杂度评估
    - 算法选择合理性
    - 数据结构优化建议
  
  资源使用:
    - 内存使用模式
    - CPU使用效率
    - I/O操作优化
    - 网络请求优化
  
  并发性能:
    - 线程安全检查
    - 锁竞争分析
    - 异步处理优化
    - 并发度评估
  
  缓存策略:
    - 缓存使用合理性
    - 缓存失效策略
    - 缓存穿透防护
    - 缓存一致性检查
```

## 🎨 智能建议生成

### 💡 个性化建议
```yaml
建议生成策略:
  基于开发者画像:
    - 技能水平评估
    - 编码习惯分析
    - 学习偏好识别
    - 改进重点推荐
  
  基于项目特性:
    - 项目类型特点
    - 技术栈特性
    - 业务领域要求
    - 团队协作模式
  
  基于历史数据:
    - 常见错误模式
    - 成功改进案例
    - 最佳实践应用
    - 效果评估反馈
```

### 🔧 自动修复能力
```yaml
自动修复范围:
  格式问题:
    - 代码格式化
    - 导入语句整理
    - 空行和缩进调整
    - 注释格式规范
    自动应用: 是
  
  简单逻辑问题:
    - 未使用变量清理
    - 简单重构建议
    - 类型转换优化
    - 条件表达式简化
    自动应用: 可选
  
  安全问题:
    - 基础安全修复
    - 输入验证添加
    - 异常处理完善
    - 资源释放检查
    自动应用: 需确认
  
  性能优化:
    - 简单性能优化
    - 缓存策略建议
    - 查询优化建议
    - 算法改进建议
    自动应用: 需评估
```

## 📊 智能报告和度量

### 📈 质量度量指标
```yaml
核心指标:
  代码质量分数:
    计算方式: 加权平均
    更新频率: 实时
    历史趋势: 保留6个月
    基准对比: 团队/行业平均
  
  技术债务指数:
    计算维度: 复杂度+重复+覆盖率
    风险等级: 低/中/高/严重
    偿还建议: 优先级排序
    影响评估: 开发效率影响
  
  安全风险评分:
    风险分类: 严重/高/中/低
    修复优先级: 自动排序
    合规状态: 实时监控
    趋势分析: 风险变化趋势
  
  性能健康度:
    性能基准: 自动建立
    回归检测: 自动预警
    优化机会: 智能识别
    改进效果: 量化评估
```

### 📋 智能报告生成
```yaml
报告类型:
  实时反馈报告:
    触发时机: 代码提交时
    内容重点: 即时问题和建议
    格式: 简洁摘要 + 详细链接
    接收者: 开发者个人
  
  每日质量报告:
    触发时机: 每日自动生成
    内容重点: 质量趋势和改进点
    格式: 图表 + 关键指标
    接收者: 团队负责人
  
  周期性深度分析:
    触发时机: 每周/每月
    内容重点: 深度分析和战略建议
    格式: 详细报告 + 行动计划
    接收者: 技术管理层
  
  项目里程碑报告:
    触发时机: 重要节点
    内容重点: 质量达成情况
    格式: 综合评估 + 风险预警
    接收者: 项目干系人
```

## 🔄 持续学习和优化

### 🧠 学习机制
```yaml
学习数据源:
  代码变更历史:
    - 修改模式分析
    - 缺陷修复记录
    - 重构效果评估
    - 性能改进跟踪
  
  审查反馈:
    - 审查意见分析
    - 接受/拒绝模式
    - 修改后效果
    - 审查者偏好
  
  运行时数据:
    - 性能监控数据
    - 错误日志分析
    - 用户行为数据
    - 系统健康指标
  
  外部知识:
    - 行业最佳实践
    - 安全漏洞数据库
    - 开源项目分析
    - 技术社区反馈
```

### 🎯 优化策略
```yaml
优化维度:
  检测准确性:
    - 误报率降低
    - 漏报率控制
    - 检测深度提升
    - 上下文理解增强
  
  建议质量:
    - 建议相关性提升
    - 可操作性增强
    - 个性化程度提高
    - 效果预测准确性
  
  性能效率:
    - 分析速度优化
    - 资源使用效率
    - 并行处理能力
    - 缓存策略优化
  
  用户体验:
    - 界面友好性
    - 反馈及时性
    - 学习曲线优化
    - 集成便利性
```

## 🛠️ 工具集成和配置

### 🔧 MCP工具集成
```yaml
MCP工具编排:
  代码分析工具:
    - codebase-retrieval: 语义分析
    - server-filesystem: 文件操作
    - 静态分析工具: 规则检查
    - 安全扫描工具: 漏洞检测
  
  版本控制集成:
    - server-github: PR管理
    - Git hooks: 自动触发
    - 分支策略: 质量门禁
    - 合并策略: 智能合并
  
  通知和反馈:
    - mcp-feedback-enhanced: 交互反馈
    - 邮件通知: 重要问题
    - 即时消息: 实时提醒
    - 仪表板: 可视化展示
```

### ⚙️ 配置管理
```yaml
配置层次:
  全局配置:
    - 基础质量标准
    - 安全检查规则
    - 性能基准设置
    - 通知策略配置
  
  项目配置:
    - 项目特定规则
    - 技术栈适配
    - 业务规则定制
    - 团队偏好设置
  
  个人配置:
    - 个人偏好设置
    - 技能水平配置
    - 学习目标设定
    - 反馈频率调整
```

## 🎯 使用示例

### 🚀 快速启动
```bash
# 启动智能代码审查
/启动智能审查 [严格程度] [自动化级别]

# 示例
/启动智能审查 企业级 高度自动化
/启动智能审查 标准 平衡模式
/启动智能审查 宽松 人工主导
```

### 🎨 自定义配置
```bash
# 设置审查严格程度
/设置审查级别 严格      # 最高质量要求
/设置审查级别 标准      # 平衡质量和效率
/设置审查级别 宽松      # 快速开发模式

# 设置自动修复级别
/设置自动修复 激进     # 自动应用所有安全修复
/设置自动修复 保守     # 仅自动修复格式问题
/设置自动修复 禁用     # 仅提供建议，不自动修复
```

---

**注意**: 此规则文件实现了基于AI的智能代码审查系统，提供多层次、个性化的代码质量控制，显著提升代码质量和开发效率。 
---
type: "project_rule"
description: "智能项目管理系统 - 整合阶段管理、工作流编排、智能推荐和记忆系统"
globs: ["**/*"]
priority: 900
---

# 🧠 智能项目管理系统

> **统一管理**: 整合严格阶段管理、完整工作流、智能推荐机制、记忆系统和超级大脑系统

## 🎯 系统概述

本系统提供智能化的项目管理能力，结合现代AI代理技术和传统项目管理最佳实践，确保项目从需求分析到部署运维的全生命周期管理。

## 📋 五阶段项目管理

### 阶段定义
```yaml
项目阶段:
  阶段1 - 需求分析: 
    目标: 明确需求，确定方案
    约束: 禁止代码生成，专注需求澄清
    产出: 需求文档、技术方案、项目计划
  
  阶段2 - 架构设计:
    目标: 搭建架构，创建框架
    约束: 禁止业务逻辑实现
    产出: 架构图、技术选型、项目结构
  
  阶段3 - 开发实现:
    目标: 实现功能，编写代码
    约束: 禁止架构重大调整
    产出: 功能代码、单元测试、API文档
  
  阶段4 - 测试优化:
    目标: 测试修复，性能优化
    约束: 禁止新功能开发
    产出: 测试报告、性能优化、Bug修复
  
  阶段5 - 部署运维:
    目标: 部署配置，运维监控
    约束: 禁止代码修改
    产出: 部署脚本、监控配置、运维文档
```

### 阶段切换机制
```yaml
切换方式:
  命令格式: "/switch [阶段号]"
  自然语言: "切换到XX阶段"、"进入XX阶段"
  智能推荐: "/switch 0" 启动推荐模式
  
辅助命令:
  "/status" - 查看当前阶段和规则
  "/recommend" - 获取阶段推荐
  "/memory" - 查看项目记忆
```

## 🤖 智能推荐机制

### 关键词匹配矩阵
```yaml
阶段1_需求分析:
  高权重词: ["需求", "要求", "想要", "希望", "计划", "讨论", "分析"]
  中权重词: ["功能", "特性", "方案", "思路", "技术选型"]
  排除词: ["开始", "实现", "代码", "开发", "部署"]

阶段2_架构设计:
  高权重词: ["架构", "结构", "框架", "搭建", "初始化", "配置"]
  中权重词: ["设计", "模式", "组件", "模块", "接口"]
  排除词: ["业务逻辑", "具体实现", "细节功能"]

阶段3_开发实现:
  高权重词: ["实现", "开发", "编写", "代码", "功能", "逻辑"]
  中权重词: ["算法", "接口", "组件", "模块", "方法"]
  排除词: ["架构调整", "重构", "设计变更"]

阶段4_测试优化:
  高权重词: ["测试", "优化", "性能", "调试", "修复", "Bug"]
  中权重词: ["验证", "检查", "改进", "调优", "监控"]
  排除词: ["新功能", "新需求", "功能扩展"]

阶段5_部署运维:
  高权重词: ["部署", "上线", "发布", "运维", "监控", "配置"]
  中权重词: ["环境", "服务器", "域名", "SSL", "备份"]
  排除词: ["代码修改", "功能调整", "逻辑变更"]
```

### 智能推荐算法
```yaml
推荐流程:
  1. 关键词提取和权重计算
  2. 上下文分析和意图识别
  3. 当前阶段适配度评估
  4. 最优阶段推荐和理由说明
  5. 用户确认和阶段切换
```

## 💾 项目记忆系统

### 记忆存储结构
```json
{
  "project_id": "项目唯一标识",
  "project_name": "项目名称",
  "current_phase": "当前阶段",
  "created_time": "创建时间",
  "last_updated": "最后更新时间",
  "phases": {
    "phase_1_requirements": {
      "status": "completed|in_progress|pending",
      "start_time": "开始时间",
      "end_time": "结束时间",
      "requirements": "需求描述",
      "technical_decisions": ["技术决策列表"],
      "deliverables": ["交付物列表"],
      "user_confirmations": ["用户确认记录"]
    },
    "phase_2_architecture": {
      "status": "completed|in_progress|pending",
      "technical_stack": "技术栈选择",
      "architecture_design": "架构设计方案",
      "system_components": ["系统组件列表"],
      "design_patterns": ["设计模式列表"]
    },
    "phase_3_development": {
      "status": "completed|in_progress|pending",
      "implementation_plan": "实施计划",
      "code_structure": "代码结构设计",
      "development_milestones": ["开发里程碑"],
      "completed_features": ["已完成功能"]
    },
    "phase_4_testing": {
      "status": "completed|in_progress|pending",
      "testing_strategy": "测试策略",
      "quality_standards": "质量标准",
      "performance_metrics": "性能指标",
      "bug_reports": ["Bug报告列表"]
    },
    "phase_5_deployment": {
      "status": "completed|in_progress|pending",
      "deployment_strategy": "部署策略",
      "environment_config": "环境配置",
      "monitoring_setup": "监控配置",
      "maintenance_plan": "维护计划"
    }
  },
  "global_notes": ["全局备注"],
  "lessons_learned": ["经验教训"]
}
```

### 自动记录触发条件
```yaml
记录触发:
  阶段切换时: 自动保存当前阶段状态
  重要决策时: 技术选型、架构设计等
  里程碑达成时: 功能完成、测试通过等
  问题解决时: Bug修复、性能优化等
  用户确认时: 需求确认、方案批准等
```

## 🚀 超级大脑系统

### 激活机制
```yaml
触发词:
  主要触发词:
    - "启动超级大脑系统"
    - "启动智能项目管理"
    - "激活项目大脑"
    - "开启智能管理"
  
  状态查询:
    - "查看项目状态"
    - "项目进度如何"
    - "当前在哪个阶段"
```

### 智能管理功能
```yaml
核心功能:
  1. 项目状态监控:
     - 实时跟踪项目进度
     - 识别潜在风险和瓶颈
     - 提供优化建议
  
  2. 智能决策支持:
     - 基于历史数据的决策建议
     - 技术选型推荐
     - 资源分配优化
  
  3. 自动化工作流:
     - 阶段自动切换建议
     - 任务优先级排序
     - 依赖关系管理
  
  4. 学习和优化:
     - 项目模式识别
     - 最佳实践总结
     - 个性化推荐
```

## 🔄 完整工作流集成

### 前后端协同工作流
```yaml
协同模式:
  并行开发:
    - 前端: UI/UX设计和组件开发
    - 后端: API设计和业务逻辑
    - 同步点: 接口定义、数据模型
  
  集成测试:
    - 前端: 组件测试、E2E测试
    - 后端: 单元测试、集成测试
    - 联调: API对接、数据流测试
  
  部署协调:
    - 前端: 静态资源部署
    - 后端: 服务部署和配置
    - 监控: 全栈性能监控
```

### MCP工具智能编排
```yaml
工具编排策略:
  阶段1_需求分析:
    主要工具: ["mcp-feedback-enhanced", "memory"]
    目标: 需求收集和分析
  
  阶段2_架构设计:
    主要工具: ["codebase-retrieval", "server-filesystem"]
    目标: 架构设计和项目初始化
  
  阶段3_开发实现:
    主要工具: ["server-github", "codebase-retrieval", "server-filesystem"]
    目标: 代码开发和版本管理
  
  阶段4_测试优化:
    主要工具: ["server-filesystem", "codebase-retrieval"]
    目标: 测试执行和性能优化
  
  阶段5_部署运维:
    主要工具: ["server-github", "server-filesystem"]
    目标: 部署配置和运维管理
```

## 📊 使用示例

### 项目启动
```
用户: "启动超级大脑系统，我要开发一个电商网站"
AI: "🧠 超级大脑系统已激活！
     📋 项目类型: 电商网站
     🎯 推荐阶段: 阶段1-需求分析
     💡 建议: 让我们先明确具体需求和功能范围
     
     请告诉我：
     1. 目标用户群体
     2. 核心功能需求
     3. 技术栈偏好
     4. 项目时间线"
```

### 阶段切换
```
用户: "需求已经明确了，开始架构设计"
AI: "🔄 检测到阶段切换意图
     📝 正在保存阶段1成果到项目记忆...
     ✅ 切换到阶段2-架构设计
     
     🏗️ 架构设计阶段任务:
     1. 技术栈选择
     2. 系统架构设计
     3. 数据库设计
     4. 项目结构初始化"
```

### 智能推荐
```
用户: "我想开始写代码了"
AI: "🤖 智能分析中...
     📊 关键词匹配: '写代码' → 阶段3-开发实现
     ⚠️  当前阶段: 阶段2-架构设计
     
     💡 建议: 架构设计尚未完成，建议先完成：
     - 数据库表结构设计
     - API接口定义
     - 前端组件规划
     
     确认切换到开发阶段吗？(y/n)"
```

## 🎯 集成优势

1. **结构化管理**: 严格的阶段约束确保项目有序进行
2. **智能辅助**: AI推荐和自动化减少人工决策负担
3. **记忆延续**: 完整的项目记忆确保信息不丢失
4. **工具协同**: MCP工具与项目阶段深度集成
5. **经验积累**: 持续学习和优化提升项目成功率

---

**🎯 使用提示**: 通过 `/switch 0` 启动智能推荐，让AI帮助您选择最适合的项目阶段！ 
---
type: "project_rule"
description: "高级工作流编排规则 - 企业级复杂工作流编排和性能优化 (配合intelligent-project-management.mdc使用)"
globs: ["**/*"]
priority: 880
---

# 🤖 高级工作流编排规则

## 🎯 核心理念

> **注意**: 本规则专注于企业级复杂工作流编排，基础项目管理请使用 `intelligent-project-management.mdc`

基于2025年AI代理发展趋势，实现企业级复杂工作流的自主编排和性能优化。

### 🧠 智能代理核心能力
```yaml
自主能力矩阵:
  推理能力:
    - 上下文理解和分析
    - 问题分解和抽象
    - 解决方案生成和评估
    - 决策制定和风险评估
  
  规划能力:
    - 任务分解和优先级排序
    - 资源分配和时间规划
    - 依赖关系分析和管理
    - 里程碑设定和进度跟踪
  
  执行能力:
    - 工具链自动编排
    - 并行任务协调
    - 异常处理和恢复
    - 质量控制和验证
  
  学习能力:
    - 经验积累和模式识别
    - 策略优化和调整
    - 反馈分析和改进
    - 知识图谱构建
```

## 🚀 高级工作流架构

> **基础项目启动**: 请使用 `intelligent-project-management.mdc` 中的 "启动超级大脑系统" 命令

### 📋 企业级工作流增强
```yaml
适用场景:
  - 大型团队协作 (10+ 人员)
  - 复杂微服务架构
  - 多项目并行管理
  - 企业级CI/CD流程
  - 跨部门协作项目
```

### 🎯 智能任务分解引擎
```yaml
任务分解策略:
  自动分析维度:
    - 技术复杂度评估
    - 业务价值分析
    - 风险等级评定
    - 资源需求估算
    - 时间周期预测
  
  智能分解算法:
    - 基于历史项目数据的模式识别
    - 技术栈特性分析
    - 团队能力匹配
    - 依赖关系优化
    - 并行度最大化
  
  动态调整机制:
    - 实时进度监控
    - 阻塞点自动识别
    - 资源重新分配
    - 优先级动态调整
```

### 🔄 智能执行编排
```yaml
执行编排策略:
  并行执行优化:
    - 无依赖任务并行处理
    - 资源冲突检测和避免
    - 负载均衡和调度
    - 性能瓶颈识别
  
  工具链智能选择:
    - 任务特性分析
    - 工具能力匹配
    - 性能效率评估
    - 故障恢复能力
  
  质量控制集成:
    - 实时代码质量检查
    - 自动化测试触发
    - 安全扫描集成
    - 性能基准验证
```

## 🎨 智能开发模式

### 🏗️ 架构设计智能助手
```yaml
架构智能分析:
  需求理解:
    - 业务需求自动解析
    - 非功能性需求识别
    - 约束条件分析
    - 扩展性需求预测
  
  架构推荐:
    - 基于需求的架构模式推荐
    - 技术栈最优组合建议
    - 性能优化策略
    - 安全架构设计
  
  设计验证:
    - 架构一致性检查
    - 性能影响评估
    - 可维护性分析
    - 成本效益评估
```

### 💻 智能编码助手
```yaml
编码智能支持:
  代码生成:
    - 基于规范的代码模板生成
    - 业务逻辑自动实现
    - 测试用例自动生成
    - 文档自动同步
  
  代码优化:
    - 性能瓶颈自动识别
    - 代码重构建议
    - 最佳实践应用
    - 安全漏洞检测
  
  协作支持:
    - 代码冲突预测和解决
    - 代码审查自动化
    - 知识共享和传递
    - 技能差距识别
```

### 🧪 智能测试编排
```yaml
测试智能化:
  测试策略:
    - 风险驱动的测试优先级
    - 测试覆盖率智能优化
    - 测试数据自动生成
    - 测试环境自动配置
  
  执行优化:
    - 并行测试执行
    - 失败测试快速定位
    - 回归测试智能选择
    - 性能测试自动化
  
  结果分析:
    - 测试结果智能分析
    - 质量趋势预测
    - 缺陷模式识别
    - 改进建议生成
```

## 📊 智能监控和优化

### 📈 实时性能监控
```yaml
监控维度:
  开发效率:
    - 代码提交频率和质量
    - 功能完成速度
    - 缺陷修复时间
    - 代码审查效率
  
  系统性能:
    - 构建时间优化
    - 测试执行时间
    - 部署成功率
    - 系统稳定性
  
  团队协作:
    - 沟通效率分析
    - 知识共享程度
    - 技能发展轨迹
    - 工作负载平衡
```

### 🔮 预测性分析
```yaml
预测能力:
  项目风险预测:
    - 延期风险评估
    - 质量风险预警
    - 资源不足预测
    - 技术债务累积
  
  优化机会识别:
    - 流程改进点
    - 工具升级建议
    - 技能培训需求
    - 架构演进方向
  
  决策支持:
    - 技术选型建议
    - 资源分配优化
    - 发布时机选择
    - 风险缓解策略
```

## 🎯 智能反馈和学习

### 🔄 持续学习机制
```yaml
学习系统:
  经验积累:
    - 项目成功模式识别
    - 失败案例分析
    - 最佳实践提取
    - 知识图谱更新
  
  策略优化:
    - 工作流效率分析
    - 决策准确性评估
    - 预测模型调优
    - 推荐算法改进
  
  知识共享:
    - 团队经验传承
    - 跨项目知识复用
    - 行业最佳实践集成
    - 创新模式探索
```

### 📋 智能反馈触发
```yaml
反馈触发条件:
  关键决策点:
    - 架构设计确认
    - 技术栈选择
    - 重要功能实现
    - 性能优化策略
  
  风险预警:
    - 进度偏差>20%
    - 质量指标下降
    - 团队负载过高
    - 技术债务累积
  
  优化机会:
    - 效率提升>30%的机会
    - 成本节约机会
    - 质量改进机会
    - 创新应用机会
```

## 🛠️ 工具集成和编排

### 🔧 MCP工具智能编排
```yaml
工具编排策略:
  动态工具选择:
    - 任务特性分析
    - 工具能力匹配
    - 性能效率评估
    - 可靠性考量
  
  工具链优化:
    - 工具间数据流优化
    - 并行执行协调
    - 错误处理和恢复
    - 性能监控和调优
  
  智能故障处理:
    - 工具故障自动检测
    - 备用方案自动切换
    - 故障根因分析
    - 预防性维护建议
```

### 📊 集成开发环境优化
```yaml
IDE智能增强:
  代码智能:
    - 上下文感知的代码补全
    - 智能重构建议
    - 实时代码质量反馈
    - 性能影响预测
  
  调试增强:
    - 智能断点建议
    - 异常根因分析
    - 性能瓶颈定位
    - 调试路径优化
  
  协作增强:
    - 实时协作冲突预测
    - 代码审查智能助手
    - 知识共享推荐
    - 技能发展建议
```

## 🎯 使用示例

### 🚀 快速启动
```bash
# 启动智能全栈开发工作流
/启动智能工作流 全栈Web应用 中等复杂度 5人团队

# 系统自动分析并生成:
# 1. 项目架构建议
# 2. 技术栈推荐
# 3. 开发计划
# 4. 任务分配
# 5. 质量控制策略
```

### 🎨 自定义配置
```bash
# 设置智能化级别
/设置智能化级别 高级    # 最大化自动化
/设置智能化级别 标准    # 平衡自动化和人工控制
/设置智能化级别 保守    # 最小化自动化，保持人工控制

# 设置反馈频率
/设置智能反馈 实时     # 实时反馈和建议
/设置智能反馈 关键点   # 仅在关键决策点反馈
/设置智能反馈 总结     # 阶段性总结反馈
```

---

**注意**: 此规则文件实现了基于2025年AI代理发展趋势的智能工作流编排，提供自主推理、规划和执行能力，显著提升开发效率和质量。 
---
description: "Frontend development workflow with Vue/React/TypeScript - 前端开发完整工作流"
globs: ["**/*.vue", "**/*.jsx", "**/*.tsx", "**/*.ts", "**/*.js", "**/*.css", "**/*.scss", "**/*.html"]
alwaysApply: false
---

# 🎨 Frontend Development Workflow - 前端开发工作流

专为 Vue 3、React 18+、TypeScript 优化的前端开发完整工作流程。

## 🚀 Commands - 命令

- `/frontend-dev` - 启动前端开发工作流
- `/component` - 创建新组件
- `/ui-design` - UI设计和样式开发
- `/test-frontend` - 运行前端测试
- `/build-frontend` - 构建和优化

### 前端专用配置模式
- `/设置Vue优先模式` - 优先使用 Vue 3 技术栈
- `/设置React优先模式` - 优先使用 React 18+ 技术栈
- `/设置TypeScript严格模式` - 启用最严格的类型检查
- `/设置性能优化模式` - 自动应用前端性能优化建议

### 反馈频率控制
- `/设置详细模式` - 启用所有反馈点，完整工作流
- `/设置标准模式` - 关键决策点反馈（默认）
- `/设置静默模式` - 仅错误时反馈，适合熟练用户

### 工作流配置
- `/设置严格模式` - 严格按顺序执行，不允许跳过
- `/设置灵活模式` - 允许模式跳转和流程调整（默认）
- `/设置快捷模式` - 简化某些步骤，提高效率

### 质量标准配置
- `/设置企业级标准` - 最高质量要求，完整测试
- `/设置标准级别` - 平衡质量和效率（默认）
- `/设置原型级别` - 快速验证，降低质量要求

## 📋 Process - 开发流程

### 1. 🔍 需求分析 (Requirements Analysis)
- 分析用户交互需求和业务逻辑
- 确定技术栈和架构方案
- 设计组件结构和数据流
- **转换条件**：需求明确，技术方案确定

### 2. 🎨 UI设计 (UI Design)
- 设计组件界面和交互逻辑
- 确定样式规范和响应式布局
- 规划路由和页面结构
- **转换条件**：UI设计完成，交互逻辑清晰

### 3. ⚡ 组件开发 (Component Development)
- 实现组件功能和样式
- 集成状态管理和 API 调用
- 优化性能和用户体验
- **转换条件**：功能完成，自测通过

### 4. 🧪 测试验证 (Testing)
- 单元测试和集成测试
- 跨浏览器兼容性测试
- 性能和可访问性测试
- **转换条件**：测试通过，质量达标

### 5. 📦 构建部署 (Build & Deploy)
- 代码打包和优化
- 部署到测试/生产环境
- 监控和性能分析
- **转换条件**：部署成功，运行稳定

## 🛠️ Technology Stack - 技术栈

### Core Frameworks - 核心框架
- **Vue 3** - Composition API, `<script setup>`
- **React 18+** - Hooks, Concurrent Features
- **TypeScript** - 类型安全和开发体验

### Build Tools - 构建工具
- **Vite** - 快速开发和构建
- **Webpack** - 复杂项目配置

### UI Libraries - UI库
- **Element Plus** (Vue)
- **Ant Design** (React)
- **Tailwind CSS** - 原子化CSS

### State Management - 状态管理
- **Pinia** (Vue)
- **Zustand** (React)
- **Redux Toolkit** (React)

## ✅ Best Practices - 最佳实践

### Component Development - 组件开发
- 使用 Composition API (Vue) 或 Hooks (React)
- 保持组件单一职责
- 合理使用 props 和 emit/callback
- 实现响应式设计

### Code Quality - 代码质量
- TypeScript 严格模式
- ESLint + Prettier 代码规范
- 组件和函数命名规范
- 充分的注释和文档

### Performance - 性能优化
- 懒加载和代码分割
- 图片优化和压缩
- 缓存策略
- Bundle 分析和优化

## 🔧 Development Commands - 开发命令

```bash
# 项目初始化
npm create vue@latest my-project  # Vue 3
npx create-react-app my-app --template typescript  # React

# 开发服务器
npm run dev

# 构建
npm run build

# 测试
npm run test

# 代码检查
npm run lint
npm run type-check
```

## 📋 Checklist - 检查清单

### 开发前
- [ ] 需求分析完成
- [ ] 技术栈选择确定
- [ ] 项目结构规划
- [ ] 开发环境配置

### 开发中
- [ ] 组件设计合理
- [ ] 代码规范遵循
- [ ] 类型定义完整
- [ ] 单元测试编写

### 开发后
- [ ] 功能测试通过
- [ ] 性能指标达标
- [ ] 代码审查完成
- [ ] 文档更新完整

## 🎯 Mode Switching - 模式切换

根据当前任务自动或手动切换到对应模式：

- **UI设计模式** - `/ui-design`
- **组件开发模式** - `/component`
- **测试模式** - `/test-frontend`
- **优化模式** - `/optimize`
- **部署模式** - `/deploy`

### 前端专用配置模式行为
- **Vue优先模式** - 激活后优先推荐 Vue 3 + Composition API 技术栈
- **React优先模式** - 激活后优先推荐 React 18+ + Hooks 技术栈
- **TypeScript严格模式** - 激活后启用最严格的类型检查和类型安全
- **性能优化模式** - 激活后自动建议代码分割、懒加载、缓存策略
