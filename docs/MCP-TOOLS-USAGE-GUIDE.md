# MCP工具使用指南 (MCP Tools Usage Guide)

> **🎯 目标用户**: 开发者、AI工具用户、MCP配置管理员
> **📋 前置要求**: 已通过 `install-ultra.bat` 安装AgentRules，`mcp-tools/` 目录已创建

## 📖 概述

MCP工具集是AgentRules项目的重要组成部分，提供了一套完整的MCP（Model Context Protocol）配置管理和维护工具。这些工具帮助开发者更好地管理AI工具的配置，确保跨平台兼容性和最佳性能。

## 🛠️ 工具清单

| 工具名称 | 功能描述 | 使用频率 | 重要性 |
|----------|----------|----------|--------|
| `mcp-cross-platform-sync.ps1` | 跨平台MCP配置同步 | ⭐⭐⭐⭐ | 高 |
| `parse-check.ps1` | PowerShell语法和MCP配置验证 | ⭐⭐⭐⭐⭐ | 高 |
| `list-cache.ps1` | MCP缓存文件查看和管理 | ⭐⭐⭐ | 中 |

---

## 🔧 parse-check.ps1 详细使用指南

### 功能概述
`parse-check.ps1` 是一个强大的PowerShell语法和MCP配置验证器，能够：
- 验证PowerShell脚本的语法正确性
- 检查MCP配置文件的格式和完整性
- 提供详细的错误报告和修复建议
- 支持批量文件检查

### 基本用法

#### 1. 检查单个文件
```powershell
# 检查特定PowerShell脚本
.\mcp-tools\parse-check.ps1 "C:\path\to\script.ps1"

# 检查MCP配置文件
.\mcp-tools\parse-check.ps1 "C:\path\to\mcp-config.json"
```

#### 2. 检查当前目录
```powershell
# 检查当前目录下的所有PowerShell文件
.\mcp-tools\parse-check.ps1

# 或者直接运行（如果在mcp-tools目录中）
.\parse-check.ps1
```

#### 3. 检查指定目录
```powershell
# 检查指定目录下的所有相关文件
.\mcp-tools\parse-check.ps1 "C:\MyProject\scripts"
```

### 高级用法

#### 递归检查子目录
```powershell
# 检查目录及其所有子目录
.\mcp-tools\parse-check.ps1 -Path "C:\MyProject" -Recurse
```

#### 详细输出模式
```powershell
# 启用详细输出，显示更多诊断信息
.\mcp-tools\parse-check.ps1 -Verbose
```

#### 仅检查特定文件类型
```powershell
# 仅检查PowerShell文件
.\mcp-tools\parse-check.ps1 -FileType "ps1"

# 仅检查JSON配置文件
.\mcp-tools\parse-check.ps1 -FileType "json"
```

### 输出示例

#### 成功检查输出
```
========================================
PowerShell Syntax and MCP Config Validator
========================================
Checking: C:\MyProject\scripts\test.ps1
✅ PASS: Syntax validation successful
✅ PASS: No syntax errors found

Checking: C:\MyProject\mcp-config.json
✅ PASS: JSON format validation successful
✅ PASS: MCP configuration structure valid

========================================
Summary: 2 files checked, 0 errors found
========================================
```

#### 错误检查输出
```
========================================
PowerShell Syntax and MCP Config Validator
========================================
Checking: C:\MyProject\scripts\broken.ps1
❌ FAIL: Syntax error detected
   Line 15: Unexpected token 'if' in expression or statement
   Line 23: Missing closing brace '}'

Checking: C:\MyProject\invalid-config.json
❌ FAIL: JSON format error
   Line 8: Invalid JSON syntax - missing comma

========================================
Summary: 2 files checked, 2 errors found
Recommendation: Fix syntax errors before deployment
========================================
```

### 常见使用场景

1. **开发前检查**: 在提交代码前验证脚本语法
2. **部署前验证**: 确保生产环境脚本无语法错误
3. **MCP配置维护**: 验证MCP配置文件的正确性
4. **批量脚本审查**: 对整个项目进行语法检查

---

## 📋 list-cache.ps1 详细使用指南

### 功能概述
`list-cache.ps1` 是MCP缓存文件的查看器和管理器，提供：
- 查看MCP相关缓存文件的详细信息
- 清理过期或无效的缓存文件
- 分析缓存使用情况和性能影响
- 优化MCP工具的响应速度

### 基本用法

#### 1. 列出所有缓存文件
```powershell
# 显示所有MCP相关缓存文件
.\mcp-tools\list-cache.ps1
```

#### 2. 清理缓存文件
```powershell
# 清理所有缓存文件
.\mcp-tools\list-cache.ps1 clean

# 清理特定类型的缓存
.\mcp-tools\list-cache.ps1 clean -Type "temp"
```

#### 3. 查看缓存统计
```powershell
# 显示缓存使用统计信息
.\mcp-tools\list-cache.ps1 stats
```

### 高级用法

#### 按大小排序显示
```powershell
# 按文件大小排序显示缓存文件
.\mcp-tools\list-cache.ps1 -SortBy Size
```

#### 查看特定时间范围的缓存
```powershell
# 查看最近7天的缓存文件
.\mcp-tools\list-cache.ps1 -Days 7

# 查看特定日期之前的缓存
.\mcp-tools\list-cache.ps1 -Before "2024-01-01"
```

#### 详细信息模式
```powershell
# 显示每个缓存文件的详细信息
.\mcp-tools\list-cache.ps1 -Detailed
```

### 输出示例

#### 基本列表输出
```
========================================
MCP Cache File Viewer and Manager
========================================
Scanning MCP cache directories...

Found 15 cache files:
📁 C:\Users\User\AppData\Local\MCP\cache\
  📄 config_cache_20241201.json (2.3 KB) - 2 days ago
  📄 session_cache_20241203.tmp (1.8 KB) - Today
  📄 model_cache_20241130.dat (15.2 KB) - 3 days ago

📁 C:\MCP-Tools\cache\
  📄 sync_cache_20241203.log (0.8 KB) - Today
  📄 validation_cache_20241202.json (3.1 KB) - 1 day ago

========================================
Total: 15 files, 23.2 KB
Last updated: 2024-12-03 14:30:25
========================================
```

#### 清理操作输出
```
========================================
MCP Cache Cleanup Operation
========================================
Analyzing cache files...

Files to be cleaned:
❌ config_cache_20241125.json (expired - 8 days old)
❌ temp_session_20241120.tmp (expired - 13 days old)
❌ old_model_cache_20241115.dat (expired - 18 days old)

Cleaning 3 files... ✅ Done
Freed space: 8.7 KB

========================================
Cleanup completed successfully
Remaining cache files: 12
========================================
```

#### 统计信息输出
```
========================================
MCP Cache Statistics
========================================
📊 Cache Overview:
  Total files: 15
  Total size: 23.2 KB
  Average file age: 3.2 days
  
📈 File Types:
  JSON configs: 8 files (65.4%)
  Temporary files: 4 files (18.9%)
  Data files: 3 files (15.7%)
  
🕒 Age Distribution:
  < 1 day: 5 files
  1-7 days: 8 files
  > 7 days: 2 files
  
💡 Recommendations:
  - Consider cleaning files older than 7 days
  - Current cache usage is optimal
========================================
```

### 常见使用场景

1. **性能优化**: 定期清理缓存以提高MCP工具响应速度
2. **磁盘空间管理**: 监控和清理占用空间较大的缓存文件
3. **故障排除**: 通过查看缓存状态诊断MCP工具问题
4. **维护计划**: 建立定期缓存清理的维护流程

---

## 🔄 mcp-cross-platform-sync.ps1 详细使用指南

### 功能概述
`mcp-cross-platform-sync.ps1` 是一个强大的跨平台MCP配置同步工具，支持30+主流AI开发工具，包括：
- **主流AI编辑器**: Trae AI、Cursor IDE、Claude Desktop、Windsurf AI等
- **IDE集成AI助手**: Sourcegraph Cody、Continue.dev、VSCode Copilot、JetBrains AI等
- **云端AI平台**: Amazon Q、Google Gemini Code Assist、Qodo Gen等
- **开源AI工具**: Aider AI、CodeGeeX、TabbyML、Cline等

### 基本用法

#### 1. 检测已安装的AI平台
```powershell
# 扫描并检测所有已安装的AI开发平台
.\mcp-scripts\mcp-cross-platform-sync.ps1 detect

# 或者使用简化命令（detect是默认操作）
.\mcp-scripts\mcp-cross-platform-sync.ps1
```

#### 2. 同步MCP配置
```powershell
# 自动检测源平台并同步到所有目标平台
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync

# 指定源平台进行同步
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -SourcePlatform "Trae"

# 同步到特定目标平台
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -TargetPlatforms @("Cursor", "Claude")
```

#### 3. 清理缓存
```powershell
# 清理所有缓存文件
.\mcp-scripts\mcp-cross-platform-sync.ps1 clearcache
```

### 高级用法

#### 参数详解
```powershell
# 完整参数示例
.\mcp-scripts\mcp-cross-platform-sync.ps1 `
    -Action "sync" `
    -SourcePlatform "Trae" `
    -TargetPlatforms @("Cursor", "Claude", "Windsurf") `
    -DryRun `
    -Verbose `
    -Force `
    -CacheTTLSeconds 7200
```

**参数说明**:
- `-Action`: 操作类型 (`detect`, `sync`, `clearcache`)
- `-SourcePlatform`: 源平台 (`auto`, `Trae`, `Cursor`, `Claude`等)
- `-TargetPlatforms`: 目标平台数组 (`all`或具体平台名称)
- `-DryRun`: 预览模式，仅显示操作不执行
- `-Verbose`: 详细输出模式
- `-Force`: 强制执行，跳过确认
- `-CacheTTLSeconds`: 缓存生存时间（秒）

#### 预览模式（推荐）
```powershell
# 预览同步操作，不实际执行
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -DryRun -Verbose

# 预览从Trae同步到Cursor的操作
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -SourcePlatform "Trae" -TargetPlatforms @("Cursor") -DryRun
```

### 输出示例

#### 检测输出示例
```
=== MCP Platform Detection ===
Scanning for installed AI development platforms...

🔍 检测到的AI开发平台:

✅ Trae AI
   📁 配置路径: C:\Users\User\AppData\Roaming\Trae\User\mcp.json
   📊 MCP服务器: 5个已配置
   🔧 服务器列表: memory, feedback-enhanced, context7, everything, mcp-tools

✅ Cursor IDE  
   📁 配置路径: C:\Users\User\AppData\Roaming\Cursor\User\globalStorage\cursor.mcp\mcp_settings.json
   📊 MCP服务器: 3个已配置
   🔧 服务器列表: memory, context7, everything

❌ Claude Desktop
   📁 配置路径: C:\Users\User\.claude\mcp_settings.json
   ⚠️  状态: 配置文件不存在

📊 总结:
   - 已安装平台: 2个
   - 已配置MCP: 2个
   - 总MCP服务器: 8个（去重后5个）
   - 建议操作: 同步配置到Claude Desktop
```

#### 同步输出示例
```
=== MCP Configuration Sync ===
Source Platform: Trae AI
Target Platforms: Cursor IDE, Claude Desktop

📋 同步计划:
  ✅ memory → Cursor IDE (已存在，跳过)
  ✅ feedback-enhanced → Cursor IDE (新增)
  ✅ context7 → Cursor IDE (已存在，跳过)
  ✅ everything → Cursor IDE (已存在，跳过)
  ✅ mcp-tools → Cursor IDE (新增)
  
  ✅ memory → Claude Desktop (新增)
  ✅ feedback-enhanced → Claude Desktop (新增)
  ✅ context7 → Claude Desktop (新增)
  ✅ everything → Claude Desktop (新增)
  ✅ mcp-tools → Claude Desktop (新增)

🚀 执行同步...
✅ Cursor IDE: 2个新服务器已添加
✅ Claude Desktop: 5个新服务器已添加

🎉 同步完成！所有平台现在具有一致的MCP配置。
```

### 支持的AI平台列表

| 平台类别 | 支持的工具 | 配置路径 |
|----------|------------|----------|
| **主流AI编辑器** | Trae AI, Trae CN, Cursor, Claude, Windsurf, Replit | AppData/Roaming或用户目录 |
| **IDE集成助手** | Sourcegraph Cody, Continue.dev, VSCode Copilot, JetBrains AI, Tabnine | 各IDE的全局存储目录 |
| **云端AI平台** | Amazon Q, Gemini Code Assist, Qodo Gen | 用户配置目录 |
| **开源AI工具** | Aider, CodeGeeX, TabbyML, Cline | 用户主目录下的配置文件 |
| **新兴AI编辑器** | Qoder, Void, Warp | 各自的配置目录 |

### 常见使用场景

1. **新环境配置**: 在新机器上快速复制现有的MCP配置
2. **多平台开发**: 保持不同AI工具间的配置一致性
3. **团队协作**: 标准化团队的MCP工具配置
4. **配置备份**: 定期检测和备份MCP配置状态
5. **故障恢复**: 当某个平台配置丢失时快速恢复

> **📚 详细文档**: 关于 `mcp-cross-platform-sync.ps1` 的完整使用指南，请参考 [MCP跨平台同步工具文档](MCP-DETAILED-CONFIG-GUIDE.md)

---

## 🚀 最佳实践

### 1. 日常维护流程
```powershell
# 每日检查流程
.\mcp-scripts\parse-check.ps1          # 验证脚本语法
.\mcp-scripts\list-cache.ps1 stats     # 查看缓存状态
.\mcp-scripts\mcp-cross-platform-sync.ps1 detect  # 检测配置状态
```

### 2. 周期性清理
```powershell
# 每周清理流程
.\mcp-scripts\list-cache.ps1 clean     # 清理过期缓存
.\mcp-scripts\parse-check.ps1 -Recurse # 全面语法检查
.\mcp-scripts\mcp-cross-platform-sync.ps1 clearcache  # 清理MCP同步缓存
```

### 3. 故障排除流程
```powershell
# 当MCP工具出现问题时
.\mcp-scripts\parse-check.ps1 -Verbose # 详细语法检查
.\mcp-scripts\list-cache.ps1 clean     # 清理可能损坏的缓存
.\mcp-scripts\mcp-cross-platform-sync.ps1 clearcache  # 清理同步缓存
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -DryRun  # 预览同步操作
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync  # 重新同步配置
```

### 4. 新环境部署流程
```powershell
# 在新机器上设置MCP配置
.\mcp-scripts\mcp-cross-platform-sync.ps1 detect -Verbose  # 详细检测已安装平台
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -SourcePlatform "Trae" -DryRun  # 预览同步
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -SourcePlatform "Trae"  # 执行同步
```

### 5. 团队配置标准化
```powershell
# 确保团队成员使用一致的MCP配置
.\mcp-scripts\mcp-cross-platform-sync.ps1 detect  # 检测当前配置
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -TargetPlatforms @("Cursor", "Claude") -Force  # 强制同步到指定平台
```

### 6. 自动化脚本示例
```powershell
# 创建自动化维护脚本
# maintenance.ps1
Write-Host "Starting MCP tools maintenance..."

# 语法检查
Write-Host "1. Running syntax validation..."
.\mcp-scripts\parse-check.ps1

# 缓存清理
Write-Host "2. Cleaning cache files..."
.\mcp-scripts\list-cache.ps1 clean
.\mcp-scripts\mcp-cross-platform-sync.ps1 clearcache

# 配置检测和同步
Write-Host "3. Detecting and syncing configurations..."
.\mcp-scripts\mcp-cross-platform-sync.ps1 detect
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync -DryRun
Read-Host "Press Enter to continue with actual sync, or Ctrl+C to cancel"
.\mcp-scripts\mcp-cross-platform-sync.ps1 sync

Write-Host "Maintenance completed!"
```

---

## ❓ 常见问题解答

### Q1: 工具运行时提示权限不足怎么办？
**A**: 以管理员身份运行PowerShell，或者修改执行策略：
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Q2: parse-check.ps1 检查速度很慢怎么办？
**A**: 可以指定特定目录或文件类型来减少检查范围：
```powershell
.\parse-check.ps1 -Path "specific\directory" -FileType "ps1"
```

### Q3: list-cache.ps1 找不到缓存文件怎么办？
**A**: 确保MCP工具已正确安装并运行过，缓存文件会在首次使用时创建。

### Q4: 如何集成到CI/CD流程中？
**A**: 可以在构建脚本中添加语法检查步骤：
```yaml
# GitHub Actions 示例
- name: Validate PowerShell Scripts
  run: |
    .\mcp-scripts\parse-check.ps1 -Recurse
    if ($LASTEXITCODE -ne 0) { exit 1 }
```

### Q5: mcp-cross-platform-sync.ps1 支持哪些AI平台？
**A**: 支持30+主流AI开发工具，包括Trae AI、Cursor、Claude、Windsurf、VSCode Copilot、JetBrains AI等。使用 `detect` 命令可以查看当前环境中已安装的平台。

### Q6: 同步操作是否安全？
**A**: 是的，建议先使用 `-DryRun` 参数预览操作，确认无误后再执行实际同步。脚本会自动备份现有配置。

---

## 📚 相关文档

- [MCP工具介绍](MCP-TOOLS-INTRODUCTION.md) - 了解MCP工具的价值和作用
- [MCP详细配置指南](MCP-DETAILED-CONFIG-GUIDE.md) - 完整的MCP配置教程
- [MCP快速入门指南](MCP-QUICK-START-GUIDE.md) - 快速上手MCP工具
- [MCP故障排除指南](MCP-TROUBLESHOOTING-GUIDE.md) - 解决常见问题

---

## 🔄 更新记录

**2024年12月 (最新)**:
- 📝 创建详细的使用指南文档
- 🛠️ 添加 `parse-check.ps1` 和 `list-cache.ps1` 的完整使用说明
- 📋 提供最佳实践和故障排除指南
- 🎯 包含实际使用示例和输出演示

---

> **💡 提示**: 这些工具设计为AI友好，可以被AI助手直接调用来进行MCP配置管理和维护。建议将此文档加入AI工具的上下文中，以便获得更好的自动化支持。