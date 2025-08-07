# Test Scripts Directory

这个目录包含用于测试和验证AgentRules系统的核心测试工具。

## 📁 当前工具

### 🧪 test-ultra.bat
**核心测试工具** - 基于 `install-ultra.bat` (最终版本) 的综合测试脚本

**功能**:
- ✅ 测试所有3种模式 (frontend/backend/fullstack)
- ✅ 验证文件数量和结构完整性
- ✅ 自动生成测试目录和对比报告
- ✅ 验证Unicode字符处理和路径清理
- ✅ 检查rules子目录结构是否正确

**使用方法**:
```bash
test-ultra.bat [测试项目路径]
```

**示例**:
```bash
test-ultra.bat test-validation
```

**预期结果**:
- Frontend: ~25 files (包含mermaid.mdc，不包含backend文件)
- Backend: ~24 files (不包含frontend文件和mermaid.mdc)
- Fullstack: ~27 files (包含所有文件)

## 🗑️ 已清理的过时文件

以下文件已被删除，因为它们基于过时的安装脚本或功能重复：
- ~~verify-rules-completeness.bat~~ (已删除 - 功能重复)
- ~~analyze-rule-redundancy.bat~~ (已删除 - 基于过时脚本)
- ~~comprehensive-test-report.bat~~ (已删除 - 基于过时脚本)
- ~~verify-rules-consistency.bat~~ (已删除 - 基于旧脚本)

## 🎯 使用流程

1. **开发测试**: 修改规则后运行 `test-ultra.bat` 验证
2. **发布前验证**: 确保所有三种模式都能正确生成规则
3. **问题排查**: 通过测试输出的DEBUG信息定位问题

## 📊 测试验证要点

### ✅ 目录结构验证
```
项目目录/
└── rules/                    ← 必须在rules子目录下
    ├── main.md              ← 目录指南文件
    ├── P0-core-safety/      ← 8个优先级目录
    ├── P1-core-identity/
    ├── P2-intelligent-system/
    ├── P3-professional-dev/
    ├── P4-project-workflow/
    ├── P5-advanced-features/
    ├── P6-system-optimization/
    └── P7-utilities/
```

### ✅ 文件数量验证
- **Frontend**: 25个文件 (1+7+2+4+6+5 = 25)
- **Backend**: 24个文件 (1+7+2+4+6+4 = 24)
- **Fullstack**: 27个文件 (1+7+3+5+6+5 = 27)

### ✅ 模式差异验证
- Frontend包含 `mermaid.mdc`，Backend不包含
- Fullstack包含所有frontend和backend特定文件
- 所有模式都包含相同的核心规则文件

## 📝 注意事项

- 测试脚本基于最新的 `install-ultra.bat` (最终版本)
- 测试结果会在指定的测试目录中生成完整的规则结构
- 建议在修改规则文件后运行测试确保系统稳定性
- 支持Unicode字符路径处理和错误恢复

## 🔄 更新历史

- **2025-01-07**: 创建 `test-ultra.bat` 核心测试工具
- **2025-01-07**: 清理过时和重复的测试脚本
- **2025-01-07**: 更新README反映简化后的工具结构
- **2025-01-07**: 验证与 `install-ultra.bat` (最终版本) 的完全兼容性
