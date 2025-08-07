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