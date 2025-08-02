# 🔧 MCP工具故障排除指南

> **🎯 目标**: 解决MCP工具使用中的所有常见问题  
> **📱 适用**: 所有AI开发工具和操作系统  
> **⏱️ 解决时间**: 大部分问题1-3分钟内解决  

## 🚨 紧急问题快速解决

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
2. 文件名必须是 `.claude_config` 或 `CLAUDE.md`
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
- 📚 [MCP快速入门指南](MCP-QUICK-START-GUIDE.md)
- 🔧 [MCP详细配置指南](MCP-DETAILED-CONFIG-GUIDE.md)
- 📖 [项目说明](../README.md)

### 社区支持
- 💬 GitHub Issues: [提交问题](https://github.com/Mr-chen-05/rules-2.1-optimized/issues)
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
