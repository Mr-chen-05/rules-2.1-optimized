# MCP工具安装错误解决指南

## 🚨 常见错误及解决方案

### 1. Node.js 未安装错误

**错误信息：**
```
[ERROR] Node.js not installed! Please install Node.js first
```

**中文说明：** Node.js 未安装！请先安装 Node.js

**解决方案：**
1. 访问 https://nodejs.org
2. 下载 LTS 版本（推荐）
3. 运行安装程序
4. 重新启动命令提示符
5. 重新运行 MCP 安装脚本

---

### 2. Python 未安装警告

**错误信息：**
```
[WARNING] Python not installed, will skip Python MCP tools
```

**中文说明：** Python 未安装，将跳过 Python MCP 工具

**解决方案：**
- 如果不需要 Python MCP 工具，可以忽略此警告
- 如果需要 Python 工具：
  1. 访问 https://python.org
  2. 下载 Python 3.8+ 版本
  3. 安装时勾选 "Add Python to PATH"
  4. 重新运行安装脚本

---

### 3. 目录创建失败

**错误信息：**
```
[ERROR] Failed to create directory: C:\MCP-Tools
[ERROR] Please check permissions or choose a different path
```

**中文说明：** 创建目录失败，请检查权限或选择其他路径

**解决方案：**
1. **以管理员身份运行**：
   - 右键点击命令提示符
   - 选择"以管理员身份运行"
   - 重新运行脚本

2. **选择其他安装路径**：
   - 重新运行脚本
   - 选择选项 3（自定义路径）
   - 输入如：`D:\MCP-Tools` 或 `E:\Tools\MCP`

---

### 4. npm 安装超时错误

**错误信息：**
```
[ERROR] Installation timeout after 90 seconds
[ERROR] This is likely due to slow npm registry
```

**中文说明：** 安装超时（90秒），这可能是由于 npm 镜像源速度慢

**解决方案（重要）：**

#### 🔥 推荐方案：使用小满zs工具包切换镜像源

1. **安装小满zs工具包：**
   ```bash
   npm i xmzs -g
   ```

2. **运行镜像源管理工具：**
   ```bash
   mmp
   ```

3. **选择淘宝镜像：**
   - 使用方向键选择 `taobao`
   - 按回车确认

4. **验证切换成功：**
   ```bash
   npm config get registry
   # 应该显示：https://registry.npmmirror.com/
   ```

5. **重新运行 MCP 安装脚本**

#### 🔧 备选方案：手动切换镜像源

```bash
# 切换到淘宝镜像
npm config set registry https://registry.npmmirror.com

# 验证切换
npm config get registry

# 重新运行安装脚本
```

---

### 5. npm 项目初始化失败

**错误信息：**
```
[ERROR] Failed to initialize npm project
[ERROR] Please check npm installation
```

**中文说明：** npm 项目初始化失败，请检查 npm 安装

**解决方案：**
1. **检查 npm 版本：**
   ```bash
   npm --version
   ```

2. **如果 npm 不存在，重新安装 Node.js**

3. **清理 npm 缓存：**
   ```bash
   npm cache clean --force
   ```

4. **重新运行安装脚本**

---

### 6. MCP 工具包安装失败

**错误信息：**
```
[ERROR] Failed to install server-filesystem
[ERROR] npm install failed - likely due to slow registry
```

**中文说明：** MCP 工具包安装失败，可能是镜像源速度慢

**解决方案：**
1. **首先切换镜像源**（参考上面第4点的解决方案）

2. **手动安装测试：**
   ```bash
   cd C:\MCP-Tools
   npm install @modelcontextprotocol/server-filesystem
   ```

3. **如果手动安装成功，重新运行自动安装脚本**

---

## 🎯 镜像源选择建议

| 使用场景 | 推荐镜像源 | 原因 |
|---------|-----------|------|
| 🏠 **家庭网络** | 淘宝镜像 | 速度快，稳定 |
| 🏢 **公司网络** | 华为镜像 | 企业级稳定性 |
| 🚀 **生产环境** | 官方镜像 | 最新版本 |
| 🛠️ **开发测试** | 淘宝镜像 | 下载速度快 |

---

## 📞 获取更多帮助

1. **查看详细教程：**
   - 前端开发：`tutorials/frontend-rules-2.1-使用指南.md`
   - 后端开发：`tutorials/backend-rules-2.1-使用指南.md`
   - MCP快速入门：`docs/MCP-QUICK-START-GUIDE.md`

2. **常见问题：**
   - 检查网络连接
   - 确保有足够的磁盘空间
   - 关闭防火墙或杀毒软件的拦截

3. **联系支持：**
   - 查看项目文档
   - 提交 GitHub Issue
   - 参考社区讨论

---

## ✅ 安装成功标志

当看到以下信息时，说明安装成功：

```
[SUCCESS] All Node.js MCP tools installed successfully!
[SUCCESS] uv installed successfully
========================================
           Installation Report
========================================
MCP tools installation completed!
```

**中文说明：** 所有 MCP 工具安装成功！
