# Test Scripts 测试脚本

本目录包含用于测试和验证AgentRules安装的脚本。

## 可用脚本

### 1. comprehensive-test-report.bat
**综合规则检测工具** ✅ **已全面优化编码兼容性**

- **功能**: 全面检测已安装规则的模式、完整性和健康度
- **用法**: `comprehensive-test-report.bat [project-path]`
- **示例**: `comprehensive-test-report.bat C:\Users\luo20\Desktop\demo-project`
- **功能特性**:
  - 🔍 智能模式检测 (Frontend/Backend/Fullstack)
  - 📊 文件数量统计和结构验证
  - 🏥 规则健康度评估 (0-100分)
  - 📂 目录结构完整性检查
  - 🎯 关键文件存在性验证
  - 💡 智能修复建议
  - 🌐 **增强编码检测**: 自动检测系统编码 (CP936/950/932/949/437/65001)
  - ✅ **ASCII安全输出**: 完全ASCII英文输出，支持所有Windows环境
  - 🔧 **PowerShell清理**: 使用PowerShell方法处理Unicode字符

**成功测试输出示例**:
```
========================================
AgentRules Comprehensive Detection Tool
========================================
Detecting project path: C:\Users\luo20\Desktop\demo-project
Rules directory path: C:\Users\luo20\Desktop\demo-project\rules

Rules directory exists, starting comprehensive detection...

Directory Structure Detection:
  OK P0-core-safety
  OK P1-core-identity
  OK P2-intelligent-system
  OK P3-professional-dev
  OK P4-project-workflow
  OK P5-advanced-features
  OK P6-system-optimization
  OK P7-utilities
  OK All 8 priority directories complete

File Statistics:
  Total files: 27
  .md files: 6
  .mdc files: 21

Key File Detection:
  OK main.md - Rules directory guide
  OK mermaid.mdc - Chart support
  OK frontend-dev.mdc - Frontend workflow
  OK backend-dev.mdc - Backend workflow
  OK frontend-rules.mdc - Frontend rules
  OK backend-rules.mdc - Backend rules

Mode Detection Results:
  Detected: FULLSTACK mode (Full-stack development)
  File count: 27 (expected: 27)
  OK Contains frontend, backend and chart support

Rules Health Assessment:
  EXCELLENT (100/100) - Rules complete and configured correctly

Recommendations:
  (No recommendations - Perfect configuration)

========================================
Comprehensive Detection Complete
Detection Mode: FULLSTACK
Confidence: HIGH
Health Score: 100/100
========================================
```

**中英文对照说明**:
- **Detecting project path** = 检测项目路径
- **Rules directory exists** = 规则目录存在
- **Directory Structure Detection** = 目录结构检测
- **File Statistics** = 文件统计
- **Key File Detection** = 关键文件检测
- **Mode Detection Results** = 模式检测结果
- **Rules Health Assessment** = 规则健康度评估
- **EXCELLENT** = 优秀
- **Comprehensive Detection Complete** = 综合检测完成

## 使用说明

**基本用法**:
```cmd
cd install-scripts\test-scripts
comprehensive-test-report.bat C:\path\to\your\project
```

**健康度评分标准**:
- 💚 **90-100分**: 优秀 - 规则完整且配置正确
- 💛 **70-89分**: 良好 - 规则基本完整，有小问题  
- 🧡 **50-69分**: 一般 - 规则不完整或配置有误
- ❤️ **0-49分**: 差 - 规则严重不完整

**模式检测标准**:
- **Frontend模式**: 31个文件 (包含mermaid.mdc + frontend-dev.mdc)
- **Backend模式**: 30个文件 (包含backend-dev.mdc，无mermaid.mdc)  
- **Fullstack模式**: 33个文件 (包含所有关键文件)

## 更新记录

**2025年9月25日 (最新)**:
- 🌐 **增强编码检测**: 自动检测系统编码，支持中文、日文、韩文、西方语言
- ✅ **ASCII安全输出**: 完全转换为ASCII英文输出，避免编码问题
- 🔧 **PowerShell清理**: 使用PowerShell方法替代Unicode清理逻辑
- 📝 **注释英文化**: 所有代码注释转换为英文，提升维护性
- 🚀 **跨区域兼容**: 与install-ultra.bat保持一致的编码处理策略

**2025年8月29日**: 
- ✅ 修复了Unicode编码问题，支持所有Windows环境
- 🔧 合并了 `test-ultra.bat` 功能，删除重复脚本
- 📋 更新了输出格式，提供中英文对照
