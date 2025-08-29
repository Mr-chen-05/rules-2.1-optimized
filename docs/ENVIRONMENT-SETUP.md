# 🔧 环境配置指南

> **🎯 目标**: 为Rules系统配置完整的开发环境  
> **⏱️ 预计用时**: 10-15分钟  
> **✅ 适用范围**: 所有AI开发工具和项目类型
>
> **🗺️ 文档导航**: [完整导航索引](NAVIGATION-INDEX.md) | [返回主页](../README.md)  

## 📋 环境要求概览

| 组件 | 版本要求 | 必需性 | 用途 |
|------|----------|--------|------|
| **Node.js** | ≥ 16.0.0 | 🔴 必需 | MCP工具、前端开发、包管理 |
| **npm** | ≥ 8.0.0 | 🔴 必需 | 依赖包安装和管理 |
| **Python** | ≥ 3.8.0 | 🟡 推荐 | 后端开发、AI工具增强 |
| **pip** | 最新版 | 🟡 推荐 | Python包管理 |
| **Java** | ≥ 11 | 🟢 可选 | Java后端开发 |
| **Maven** | ≥ 3.6.0 | 🟢 可选 | Java项目管理 |
| **Git** | ≥ 2.20.0 | 🟡 推荐 | 版本控制 |

## 🚀 快速环境检查

### ✅ 一键检查脚本

**PowerShell版本**:
```powershell
# 复制粘贴到PowerShell中运行
Write-Host "🔍 检查开发环境..." -ForegroundColor Cyan

# 检查Node.js
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js: 未安装" -ForegroundColor Red
}

# 检查npm
try {
    $npmVersion = npm --version
    Write-Host "✅ npm: v$npmVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ npm: 未安装" -ForegroundColor Red
}

# 检查Python
try {
    $pythonVersion = python --version
    Write-Host "✅ Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "🟡 Python: 未安装 (可选)" -ForegroundColor Yellow
}

# 检查Git
try {
    $gitVersion = git --version
    Write-Host "✅ Git: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "🟡 Git: 未安装 (推荐)" -ForegroundColor Yellow
}

Write-Host "\n🎯 检查完成！" -ForegroundColor Cyan
```

**CMD版本**:
```cmd
@echo off
echo 🔍 检查开发环境...

node --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Node.js: 已安装
) else (
    echo ❌ Node.js: 未安装
)

npm --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ npm: 已安装
) else (
    echo ❌ npm: 未安装
)

python --version >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Python: 已安装
) else (
    echo 🟡 Python: 未安装 (可选)
)

echo 🎯 检查完成！
```

## 📦 详细安装指南

### 🟢 Node.js 安装 (必需)

#### 🎯 推荐方案：使用 nvm 管理 Node.js 版本

> **💡 为什么推荐 nvm？**
> - 可以安装和切换多个 Node.js 版本
> - 避免权限问题和版本冲突
> - 便于团队协作和项目维护
> - 支持快速切换不同项目的 Node.js 版本

> **⚠️ 重要提醒：安装 nvm 前的准备工作**
> 
> 如果你的电脑已经安装了 Node.js，**必须先完全卸载**，否则会导致版本冲突！
> 
> **🗑️ 卸载步骤：**
> 1. **控制面板卸载**：控制面板 → 程序和功能 → 找到 Node.js → 卸载
> 2. **删除残留文件夹**：
>    - `C:\Program Files\nodejs`
>    - `C:\Program Files (x86)\nodejs`
>    - `C:\Users\{用户名}\AppData\Roaming\npm`
>    - `C:\Users\{用户名}\AppData\Roaming\npm-cache`
> 3. **清理环境变量**：
>    - 系统属性 → 高级 → 环境变量
>    - 从 PATH 中删除所有包含 `nodejs` 或 `npm` 的路径
> 4. **重启电脑**（确保环境变量生效）
> 
> **✅ 验证卸载完成**：
> ```cmd
> node --version
> # 应该显示：'node' 不是内部或外部命令
> ```

**🔧 步骤1：安装 nvm-windows**

1. **下载 nvm-windows**
   - 访问：https://github.com/coreybutler/nvm-windows/releases
   - 下载最新版本的 `nvm-setup.exe`
   - 运行安装程序（需要管理员权限）

2. **验证安装**
   ```cmd
   # 重新打开命令行，输入：
   nvm version
   # 应该显示版本号，如：1.1.11
   ```

**🚀 步骤2：使用 nvm 安装 Node.js**

```cmd
# 查看可用的 Node.js 版本
nvm list available

# 安装最新的 LTS 版本（推荐）
nvm install lts

# 或者安装指定版本
nvm install 18.19.0

# 使用指定版本
nvm use 18.19.0

# 设置默认版本
nvm alias default 18.19.0
```

**📋 常用 nvm 命令**

| 命令 | 说明 | 示例 |
|------|------|------|
| `nvm list` | 查看已安装版本 | `nvm list` |
| `nvm install <version>` | 安装指定版本 | `nvm install 16.20.0` |
| `nvm use <version>` | 切换到指定版本 | `nvm use 18.19.0` |
| `nvm uninstall <version>` | 卸载指定版本 | `nvm uninstall 14.21.0` |
| `nvm current` | 查看当前使用版本 | `nvm current` |

#### 🔄 传统安装方法 (备选)

**方法1: 官方安装包**

1. **下载安装包**
   - 访问: https://nodejs.org/
   - 选择 **LTS版本** (长期支持版)
   - 下载Windows安装包 (.msi)

2. **安装步骤**
   ```
   ✅ 运行下载的.msi文件
   ✅ 选择"Add to PATH"选项
   ✅ 选择"Automatically install necessary tools"
   ✅ 完成安装
   ```

3. **验证安装**
   ```powershell
   node --version    # 应显示: v18.x.x 或更高
   npm --version     # 应显示: 9.x.x 或更高
   ```

**方法2: 包管理器安装**

```powershell
# 使用Chocolatey
choco install nodejs

# 使用Winget
winget install OpenJS.NodeJS
```

### 🟡 Python 安装 (推荐)

#### 方法1: 官方安装包

1. **下载**
   - 访问: https://www.python.org/downloads/
   - 下载Python 3.11或3.12版本

2. **安装**
   ```
   ✅ 勾选"Add Python to PATH"
   ✅ 选择"Install for all users"
   ✅ 自定义安装，确保包含pip
   ```

3. **验证**
   ```powershell
   python --version  # 应显示: Python 3.11.x
   pip --version     # 应显示pip版本信息
   ```

#### 方法2: Microsoft Store
```
1. 打开Microsoft Store
2. 搜索"Python 3.11"
3. 点击安装
```

### 🟢 Git 安装 (推荐)

#### 官方安装
1. **下载**: https://git-scm.com/download/win
2. **安装**: 使用默认设置即可
3. **验证**: `git --version`

#### 包管理器安装
```powershell
# Chocolatey
choco install git

# Winget
winget install Git.Git
```

### 🟢 Java 安装 (可选)

#### OpenJDK安装 (推荐)
```powershell
# 使用Chocolatey
choco install openjdk11

# 或下载安装包
# 访问: https://adoptium.net/
```

#### 验证Java安装
```powershell
java --version
javac --version
```

## 🔧 环境配置优化

### 📝 配置npm镜像 (提升下载速度)

> **🌟 小白必看**: npm镜像源就像是软件包的"下载服务器"，国外的服务器下载慢，国内镜像源下载快！

#### 🚀 推荐镜像源配置

**方法1: 一键配置脚本 (推荐)**
```powershell
# 复制粘贴到PowerShell中运行
Write-Host "🔧 正在配置npm镜像源..." -ForegroundColor Cyan

# 设置淘宝镜像（最稳定）
npm config set registry https://registry.npmmirror.com

# 验证配置
$currentRegistry = npm config get registry
Write-Host "✅ 当前镜像源: $currentRegistry" -ForegroundColor Green

# 测试下载速度
Write-Host "🚀 测试下载速度..." -ForegroundColor Yellow
npm info vue --registry https://registry.npmmirror.com

Write-Host "🎉 配置完成！" -ForegroundColor Green
```

**方法2: 手动配置**
```powershell
# 设置淘宝镜像
npm config set registry https://registry.npmmirror.com

# 验证配置
npm config get registry

# 测试安装速度
npm install -g @vue/cli --dry-run
```

#### 🌐 镜像源对比表

| 镜像源 | 地址 | 速度 | 稳定性 | 推荐度 |
|--------|------|------|--------|--------|
| **淘宝镜像** | `https://registry.npmmirror.com` | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 🔥 强烈推荐 |
| 腾讯云镜像 | `https://mirrors.cloud.tencent.com/npm/` | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ 推荐 |
| 华为云镜像 | `https://mirrors.huaweicloud.com/repository/npm/` | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ 推荐 |
| npm官方 | `https://registry.npmjs.org/` | ⭐⭐ | ⭐⭐⭐⭐⭐ | 🐌 较慢 |

#### 🔧 高级配置技巧

**临时使用其他镜像源**:
```powershell
# 临时使用官方源安装包
npm install package-name --registry https://registry.npmjs.org/

# 临时使用腾讯云镜像
npm install package-name --registry https://mirrors.cloud.tencent.com/npm/
```

**恢复官方镜像源**:
```powershell
# 恢复npm官方源
npm config set registry https://registry.npmjs.org/

# 或者删除自定义配置
npm config delete registry
```

**查看所有npm配置**:
```powershell
# 查看所有配置
npm config list

# 查看配置文件位置
npm config get userconfig
```

### 🔧 配置pip镜像

**Windows配置**:
```powershell
# 创建配置目录
mkdir $env:APPDATA\pip

# 创建配置文件
@"
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
"@ | Out-File -FilePath "$env:APPDATA\pip\pip.ini" -Encoding UTF8
```

### 🚀 性能优化设置

```powershell
# 增加npm缓存大小
npm config set cache-max 1024000000

# 设置npm并发安装数
npm config set maxsockets 20

# 启用npm进度条
npm config set progress true
```

## ⚠️ 常见问题解决

### 🔴 Node.js相关问题

#### 问题1: "node不是内部或外部命令"
**解决方案**:
```powershell
# 检查PATH环境变量
$env:PATH -split ';' | Where-Object { $_ -like '*node*' }

# 如果没有Node.js路径，手动添加
# 通常路径为: C:\Program Files\nodejs
```

#### 问题2: npm权限错误
**解决方案**:
```powershell
# 设置npm全局安装目录
npm config set prefix "$env:APPDATA\npm"

# 添加到PATH
$npmPath = "$env:APPDATA\npm"
[Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";$npmPath", "User")
```

### 🟡 Python相关问题

#### 问题1: "python不是内部或外部命令"
**解决方案**:
```powershell
# 检查Python安装
Get-Command python -ErrorAction SilentlyContinue

# 如果使用py启动器
py --version
py -m pip --version
```

#### 问题2: pip安装包失败
**解决方案**:
```powershell
# 升级pip
python -m pip install --upgrade pip

# 使用国内镜像
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple package_name
```

### 🔧 网络相关问题

#### 企业网络/代理设置
```powershell
# 设置npm代理
npm config set proxy http://proxy.company.com:8080
npm config set https-proxy http://proxy.company.com:8080

# 设置pip代理
pip install --proxy http://proxy.company.com:8080 package_name
```

## ✅ 环境验证清单

### 🎯 完整验证脚本

```powershell
# 保存为 verify-environment.ps1
Write-Host "🚀 Rules 环境验证" -ForegroundColor Cyan
Write-Host "=" * 50 -ForegroundColor Gray

$checks = @()

# Node.js检查
try {
    $nodeVersion = node --version
    $nodeMajor = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
    if ($nodeMajor -ge 16) {
        $checks += "✅ Node.js $nodeVersion (符合要求)"
    } else {
        $checks += "⚠️ Node.js $nodeVersion (版本过低，需要≥16.0.0)"
    }
} catch {
    $checks += "❌ Node.js 未安装"
}

# npm检查
try {
    $npmVersion = npm --version
    $checks += "✅ npm v$npmVersion"
    
    # 测试npm功能
    $testResult = npm list -g --depth=0 2>$null
    if ($LASTEXITCODE -eq 0) {
        $checks += "✅ npm 功能正常"
    } else {
        $checks += "⚠️ npm 可能存在配置问题"
    }
} catch {
    $checks += "❌ npm 未安装"
}

# Python检查
try {
    $pythonVersion = python --version
    $checks += "✅ $pythonVersion"
} catch {
    $checks += "🟡 Python 未安装 (可选)"
}

# Git检查
try {
    $gitVersion = git --version
    $checks += "✅ $gitVersion"
} catch {
    $checks += "🟡 Git 未安装 (推荐)"
}

# 显示结果
$checks | ForEach-Object { Write-Host $_ }

Write-Host "\n" -NoNewline
Write-Host "🎯 验证完成！" -ForegroundColor Cyan

# 检查是否满足最低要求
$nodeOk = $checks | Where-Object { $_ -like "*Node.js*符合要求*" }
$npmOk = $checks | Where-Object { $_ -like "*npm*功能正常*" }

if ($nodeOk -and $npmOk) {
    Write-Host "🎉 环境配置完美！可以开始使用Rules" -ForegroundColor Green
} else {
    Write-Host "⚠️ 环境配置不完整，请先安装必需组件" -ForegroundColor Yellow
}
```

### 🏃‍♂️ 快速验证命令

```powershell
# 一行命令验证核心环境
node --version; npm --version; Write-Host "🎯 核心环境检查完成"
```

## 🔗 下一步

环境配置完成后，你可以继续：

1. **🚀 快速安装**: 返回 [README.md](../README.md) 执行安装脚本
2. **🧠 智能系统**: 查看 [超级大脑系统指南](../tutorials/super-brain-system-usage-guide.md)
3. **🔧 MCP工具**: 阅读 [MCP快速入门指南](./MCP-QUICK-START-GUIDE.md)
4. **📚 详细教程**: 浏览 [使用指南](../USAGE.md)

---
