# 🔧 MCP工具故障排除指南 v2.6.0

> **🎯 目标**: 解决MCP工具使用中的所有常见问题  
> **📱 适用**: 所有AI开发工具和操作系统  
> **⏱️ 解决时间**: 大部分问题1-3分钟内解决
> 
> **🚀 Phase 3升级**: 新增MCP专业调试工具，使用`/mcp-debug`命令进行智能故障诊断  

> **⚠️ 安装问题？** 如果您遇到MCP工具安装问题，请先查看 **[📋 安装脚本使用说明](../mcp-scripts/安装脚本使用说明.md)** 获取详细的安装指导。

## 🚨 紧急问题快速解决

### 问题0: MCP工具安装失败或找不到工具

**症状**: 
- 安装脚本报错
- 找不到已安装的MCP工具
- 在文件夹中看不到mcp-feedback-enhanced

**🔥 推荐解决方案**:

> **📋 完整安装教程**: 请查看 **[安装脚本使用说明](../mcp-scripts/安装脚本使用说明.md)** 获取详细的安装方法

**快速重新安装**:
1. 双击运行 `mcp-scripts/run-powershell-installer.bat`
   - 详细步骤：按Win+E打开文件管理器 → 导航到mcp-scripts文件夹 → 找到run-powershell-installer.bat → 双击执行
   - 自动生成：脚本会在MCP-Tools文件夹下自动生成 `mcp-config.json` 配置文件
2. 按提示完成安装
3. 验证安装结果

**验证安装是否成功**:
```powershell
# 验证mcp-feedback-enhanced是否安装（这是正确的验证方式）
uvx mcp-feedback-enhanced@latest version
```

**⚠️ 重要说明**:
- **mcp-feedback-enhanced是Python包，不会出现在node_modules文件夹中！**
- **这是正常现象，不是安装失败！**
- **只能通过uvx命令验证，无法在文件管理器中看到**

**详细验证方法**:
```powershell
# 1. 验证Node.js MCP工具（3-4个，server-memory 可选）- 应该在文件夹中可见
# 根据你在安装时选择的路径：
dir "C:\MCP-Tools\node_modules\@modelcontextprotocol"  # 默认路径（选项1）
dir "D:\MCP-Tools\node_modules\@modelcontextprotocol"  # D盘路径（选项2）
dir "你的安装路径\node_modules\@modelcontextprotocol"    # 自定义路径（选项3）
# 应该显示: server-filesystem, server-github, server-everything（server-memory 如已安装）

# 2. 验证Python MCP工具（1个）- 不在文件夹中，用命令验证
uvx mcp-feedback-enhanced@latest version
# 应该显示: MCP Feedback Enhanced Enhanced v2.6.0

# 3. 测试功能（可选）
uvx mcp-feedback-enhanced@latest test --web
```

### 问题1: MCP工具完全无法启动
**症状**: AI工具显示MCP连接失败或无响应

**🔥 一键解决方案**:
```powershell
# 1. 重启AI工具
# 2. 检查配置文件语法
# 3. 运行诊断命令
uvx mcp-feedback-enhanced@latest version
```

**详细排查**:
1. **检查Node.js**: `node --version` (需要v16+)
2. **检查Python**: `python --version` (需要3.8+)
3. **检查uv**: `uv --version`
4. **重新安装uv**: `pip install --upgrade uv`

### 问题2: 反馈界面打不开
**症状**: AI调用MCP但界面不出现

**🔥 一键解决方案**:
```powershell
# 检查端口占用
netstat -an | findstr :8765
# 如果被占用，修改配置中的端口号
```

**详细排查**:
1. **检查防火墙**: 确保8765端口未被阻止
2. **检查浏览器**: 手动访问 `http://localhost:8765`
3. **更换端口**: 在配置中修改 `MCP_WEB_PORT`
4. **检查权限**: 以管理员身份运行AI工具

### 问题3: GitHub集成不工作
**症状**: GitHub相关功能报错或无响应

**🔥 一键解决方案**:
```powershell
# 测试GitHub连接
npm view @modelcontextprotocol/server-github version
```

**详细排查**:
1. **检查Token**: 确保GitHub Token有正确权限
2. **检查网络**: 确保能访问GitHub API
3. **更新Token**: 重新生成GitHub Personal Access Token
4. **检查权限**: Token需要 `repo`, `user`, `workflow` 权限

## 🌐 环境特定问题

### SSH远程开发环境

#### 问题: 远程服务器上无法打开界面
**解决方案**:
```json
{
  "env": {
    "MCP_WEB_HOST": "0.0.0.0",
    "MCP_WEB_PORT": "8765"
  }
}
```
然后在本地访问: `http://远程IP:8765`

#### 问题: VS Code Remote SSH端口转发
**解决方案**:
1. 按 `Ctrl+Shift+P`
2. 输入 "Forward a Port"
3. 输入端口号 `8765`
4. 在本地访问 `http://localhost:8765`

### WSL (Windows Subsystem for Linux)

#### 问题: WSL中界面无法访问
**解决方案**:
```json
{
  "env": {
    "MCP_WEB_HOST": "0.0.0.0",
    "MCP_WEB_PORT": "8765",
    "MCP_DESKTOP_MODE": "false"
  }
}
```

#### 问题: WSL2网络访问问题
**解决方案**:
```powershell
# 在Windows中查找WSL IP
wsl hostname -I
# 然后访问 http://WSL_IP:8765
```

### 多屏幕环境

#### 问题: 桌面应用在错误屏幕显示
**解决方案**:
```json
{
  "env": {
    "MCP_DESKTOP_MODE": "true",
    "MCP_WEB_PORT": "8765"
  }
}
```
桌面应用会自动居中显示在主屏幕。

## 🔧 配置问题诊断

### JSON配置语法错误

#### 常见错误1: 缺少逗号
```json
// ❌ 错误
{
  "mcpServers": {
    "filesystem": {
      "command": "npx"
      "args": ["@modelcontextprotocol/server-filesystem"]
    }
  }
}

// ✅ 正确
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem"]
    }
  }
}
```

#### 常见错误2: 路径格式错误
```json
// ❌ 错误 (Windows路径)
"args": ["@modelcontextprotocol/server-filesystem", "C:\projects"]

// ✅ 正确 (转义反斜杠)
"args": ["@modelcontextprotocol/server-filesystem", "C:\\projects"]

// ✅ 也正确 (使用正斜杠)
"args": ["@modelcontextprotocol/server-filesystem", "C:/projects"]
```

#### 常见错误3: 环境变量格式错误
```json
// ❌ 错误
{
  "env": {
    "MCP_WEB_PORT": 8765
  }
}

// ✅ 正确 (字符串格式)
{
  "env": {
    "MCP_WEB_PORT": "8765"
  }
}
```

### 配置验证工具

**在线JSON验证器**: https://jsonlint.com/

**命令行验证**:
```powershell
# 使用Python验证JSON
python -m json.tool your-config.json
```

## 🐛 特定AI工具问题

### Augment问题

#### 问题: Augment无法加载MCP配置
**解决方案**:
1. 完全关闭Augment
2. 清除缓存: 删除 `%APPDATA%\Augment\` 目录
3. 重新启动Augment
4. 重新导入配置

#### 问题: Augment MCP连接超时
**解决方案**:
```json
{
  "timeout": 600,
  "autoApprove": ["interactive_feedback"]
}
```

### Cursor问题

#### 问题: Cursor不识别MCP配置
**解决方案**:
1. 确保配置在正确的settings.json文件中
2. 重启Cursor
3. 检查Cursor版本是否支持MCP

#### 问题: Cursor MCP工具显示离线
**解决方案**:
1. 按 `Ctrl+Shift+P`
2. 输入 "Developer: Reload Window"
3. 等待MCP工具重新连接

### Claude Code问题

#### 问题: Claude Code找不到配置文件
**解决方案**:
1. 确保配置文件在项目根目录
2. 文件名应该是 `.claude_config` 或 `CLAUDE.md`
3. 检查文件权限

### Trae AI问题

#### 问题: Trae AI MCP功能不可用
**解决方案**:
1. 更新Trae AI到最新版本
2. 检查MCP功能是否在你的订阅计划中
3. 联系Trae AI支持

## 🔍 高级诊断工具

### MCP连接测试脚本
```powershell
# 创建测试脚本
@"
Write-Host "MCP工具诊断开始..." -ForegroundColor Green

# 检查环境
Write-Host "检查Node.js..." -ForegroundColor Blue
node --version

Write-Host "检查Python..." -ForegroundColor Blue  
python --version

Write-Host "检查uv..." -ForegroundColor Blue
uv --version

# 测试MCP工具
Write-Host "测试mcp-feedback-enhanced..." -ForegroundColor Blue
uvx mcp-feedback-enhanced@latest version

Write-Host "测试Node.js MCP工具..." -ForegroundColor Blue
npm view @modelcontextprotocol/server-filesystem version

Write-Host "诊断完成!" -ForegroundColor Green
"@ | Out-File -FilePath "mcp-diagnostic.ps1" -Encoding UTF8

# 运行诊断
powershell -ExecutionPolicy Bypass -File mcp-diagnostic.ps1
```

### 网络连接测试
```powershell
# 测试npm registry连接
npm ping

# 测试PyPI连接
pip install --dry-run uv

# 测试GitHub连接
curl -I https://api.github.com
```

### 端口占用检查
```powershell
# 检查8765端口
netstat -an | findstr :8765

# 查找占用进程
netstat -ano | findstr :8765

# 结束占用进程 (替换PID)
taskkill /PID 1234 /F
```

## 📞 获取帮助

### 自助资源
- 🚀 [MCP快速入门指南](MCP-QUICK-START-GUIDE.md)
- 🔧 [MCP详细配置指南](MCP-DETAILED-CONFIG-GUIDE.md)
- 🧠 [MCP智能使用策略](MCP-INTELLIGENT-USAGE-STRATEGY.md)
- 📖 [快速开始指南](../README.md)

### 社区支持
- 💬 GitHub Issues: [提交问题](https://github.com/Mr-chen-05/rules-2.4.2-optimized/issues)
- 📧 邮箱联系: 3553952458@qq.com

### 紧急联系
如果遇到严重问题，请提供以下信息：
1. 操作系统版本
2. AI工具名称和版本
3. 完整的错误信息
4. MCP配置文件内容
5. 诊断脚本输出结果

## ✅ 预防措施

### 定期维护
```powershell
# 每月执行一次
uv cache clean
npm cache clean --force
pip cache purge
```

### 配置备份
```powershell
# 备份MCP配置
copy "your-mcp-config.json" "your-mcp-config-backup.json"
```

### 版本锁定
```json
{
  "args": ["mcp-feedback-enhanced@2.6.0"]
}
```

记住：大部分MCP问题都是配置问题，仔细检查JSON语法和路径格式通常能解决90%的问题！

### 问题4: 检测行为异常（重复执行或未触发）
**症状**:
- 每次启动都重复进行项目级检测，影响速度
- 系统级启动后未触发项目级检测

**原因分析**:
- 已启用“检测复用与跳过”策略：
  - 系统级启动阶段不主动触发项目级检测（由统一管理流程协调）
  - 300秒内复用最近检测结果或已有 “检测响应 / MCP平台报告”

**解决方案**:
1. 需要强制重新检测：发送“重新检测”指令或在命令中添加 `--force`
2. 想避免重复检测：确保最近有检测结果，或将检测流程交由统一管理模块发起
3. 等待缓存过期：超过300秒后系统会自动进行新一轮检测
4. 验证是否已复用：检查是否存在最近的“检测响应 / MCP平台报告”记录
