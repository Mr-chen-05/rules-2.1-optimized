# MCP Server-Filesystem 项目隔离快速入门指南

## 🚀 5 分钟快速部署

### 前置要求

- ✅ Windows 10/11 或 Windows Server
- ✅ PowerShell 5.0 或更高版本
- ✅ 管理员权限（推荐）
- ✅ 至少 4GB 可用磁盘空间

### 第一步：安装 Docker Desktop

1. 下载 Docker Desktop：https://www.docker.com/products/docker-desktop
2. 运行安装程序并重启计算机
3. 启动 Docker Desktop 并等待服务启动
4. 验证安装：
   ```powershell
   docker --version
   docker run hello-world
   ```

### 第二步：自动化部署

1. **打开 PowerShell（以管理员身份运行）**

2. **导航到文档目录**

   ```powershell
   cd "E:\AgentRules\English\rules-2.1-optimized-2.2.1\docs"
   ```

3. **执行自动部署脚本**

   ```powershell
   # 完整部署
   .\setup-mcp-isolation.ps1

   # 或者先预览（不执行实际操作）
   .\setup-mcp-isolation.ps1 -DryRun
   ```

4. **等待部署完成**
   - 脚本会自动创建目录结构
   - 配置 Docker 网络
   - 拉取必要的镜像
   - 生成配置文件

### 第三步：启动服务

```powershell
# 启动所有 MCP 容器
docker-compose up -d

# 检查容器状态
docker ps --filter "name=mcp-*"

# 查看日志
docker logs mcp-project-a
```

### 第四步：验证隔离

```powershell
# 运行安全审计
.\security-audit.ps1

# 查看审计报告
Start-Process "E:\Logs\MCP\security-audit-*.html"
```

---

## 📁 目录结构说明

部署完成后，您将看到以下目录结构：

```
E:\
├── Projects\                 # 主项目目录
│   ├── ProjectA\             # 项目 A（前端）
│   │   ├── src\              # 源代码
│   │   ├── docs\             # 文档
│   │   └── .vscode\          # VS Code 配置
│   │       └── mcp.json      # MCP 项目配置
│   └── ProjectB\             # 项目 B（后端）
│       ├── src\              # 源代码
│       ├── docs\             # 文档
│       └── .vscode\          # VS Code 配置
│           └── mcp.json      # MCP 项目配置
├── Shared\                   # 共享资源（只读）
│   ├── Templates\            # 项目模板
│   ├── Libraries\            # 共享库
│   ├── APIs\                 # API 文档
│   ├── Database\             # 数据库脚本
│   ├── UI-Components\        # UI 组件
│   └── Assets\               # 静态资源
├── Clients\                  # 客户端项目
│   ├── ClientA\              # 客户端 A（生产）
│   └── ClientB\              # 客户端 B（测试）
├── Templates\                # 环境模板
│   ├── Production\           # 生产环境模板
│   └── Testing\              # 测试环境模板
├── Configs\                  # 配置文件
│   └── ClientA\              # 客户端 A 配置
├── TestData\                 # 测试数据
│   └── ClientB\              # 客户端 B 测试数据
└── Logs\                     # 日志目录
    └── MCP\                  # MCP 日志
```

---

## 🔧 基本操作命令

### 容器管理

```powershell
# 启动所有服务
docker-compose up -d

# 停止所有服务
docker-compose down

# 重启特定容器
docker restart mcp-project-a

# 查看容器状态
docker ps --filter "name=mcp-*"

# 查看容器资源使用
docker stats --filter "name=mcp-*"
```

### 日志查看

```powershell
# 查看特定容器日志
docker logs mcp-project-a

# 实时跟踪日志
docker logs -f mcp-project-a

# 查看最近 100 行日志
docker logs --tail 100 mcp-project-a
```

### 容器内操作

```powershell
# 进入容器
docker exec -it mcp-project-a /bin/sh

# 在容器内执行命令
docker exec mcp-project-a ls /projects

# 检查挂载点
docker exec mcp-project-a df -h
```

### 网络管理

```powershell
# 查看网络列表
docker network ls

# 检查网络详情
docker network inspect mcp-isolated

# 查看容器网络连接
docker inspect mcp-project-a | Select-String -Pattern "NetworkMode|IPAddress"
```

---

## 🛠️ 配置自定义

### 修改项目路径

1. **编辑配置文件**

   ```powershell
   notepad "$env:USERPROFILE\.config\mcp\config.json"
   ```

2. **更新路径**

   ```json
   {
     "mcpServers": {
       "project-a-filesystem": {
         "args": [
           "--mount",
           "type=bind,src=YOUR_NEW_PATH,dst=/projects/project-a"
         ]
       }
     }
   }
   ```

3. **重启服务**
   ```powershell
   docker-compose restart
   ```

### 添加新项目

1. **创建项目目录**

   ```powershell
   New-Item -ItemType Directory -Path "E:\Projects\ProjectC" -Force
   ```

2. **添加到 docker-compose.yml**

   ```yaml
   mcp-project-c:
     image: mcp/filesystem:latest
     container_name: mcp-project-c
     volumes:
       - "E:\\Projects\\ProjectC:/projects/project-c"
     # ... 其他配置
   ```

3. **重新部署**
   ```powershell
   docker-compose up -d
   ```

### 调整资源限制

```yaml
# 在 docker-compose.yml 中修改
mcp-project-a:
  mem_limit: 1g # 内存限制
  cpus: 1.0 # CPU 限制
  # ...
```

---

## 🔒 安全检查清单

### 每日检查

- [ ] 容器运行状态正常
- [ ] 资源使用在合理范围内
- [ ] 日志无异常错误
- [ ] 网络隔离有效

```powershell
# 快速状态检查
docker ps --filter "name=mcp-*" --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}"
```

### 每周检查

- [ ] 运行完整安全审计
- [ ] 检查配置文件变更
- [ ] 清理旧日志文件
- [ ] 更新容器镜像

```powershell
# 完整安全审计
.\security-audit.ps1 -Detailed -ExportJson

# 清理旧日志
Get-ChildItem "E:\Logs\MCP" -Filter "*.log" | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item

# 更新镜像
docker pull mcp/filesystem:latest
docker-compose up -d
```

### 每月检查

- [ ] 审查访问权限
- [ ] 检查磁盘空间使用
- [ ] 备份配置文件
- [ ] 性能优化评估

```powershell
# 备份配置
$backupPath = "E:\Backup\MCP-Config-$(Get-Date -Format 'yyyyMMdd')"
New-Item -ItemType Directory -Path $backupPath -Force
Copy-Item "$env:USERPROFILE\.config\mcp\*" $backupPath -Recurse
Copy-Item "E:\AgentRules\English\rules-2.1-optimized-2.2.1\docs\docker-compose.yml" $backupPath
```

---

## 🚨 故障排除

### 常见问题

#### 1. 容器启动失败

**症状**：`docker ps` 显示容器状态为 `Exited`

**解决方案**：

```powershell
# 查看错误日志
docker logs mcp-project-a

# 检查挂载路径是否存在
Test-Path "E:\Projects\ProjectA"

# 检查权限
Get-Acl "E:\Projects\ProjectA"

# 重新创建容器
docker-compose down
docker-compose up -d
```

#### 2. 无法访问项目文件

**症状**：容器内 `/projects` 目录为空

**解决方案**：

```powershell
# 检查挂载配置
docker inspect mcp-project-a | Select-String -Pattern "Mounts" -A 10

# 验证路径格式（Windows 路径需要双反斜杠）
# 正确："E:\\Projects\\ProjectA"
# 错误："E:\Projects\ProjectA"
```

#### 3. 网络连接问题

**症状**：容器间无法通信或外网访问异常

**解决方案**：

```powershell
# 检查网络配置
docker network ls
docker network inspect mcp-isolated

# 重建网络
docker-compose down
docker network rm mcp-isolated
docker network create --driver bridge --subnet=172.20.0.0/16 mcp-isolated
docker-compose up -d
```

#### 4. 性能问题

**症状**：容器响应缓慢或资源占用过高

**解决方案**：

```powershell
# 检查资源使用
docker stats --no-stream

# 调整资源限制
docker update --memory 1g --cpus 1.0 mcp-project-a

# 清理系统
docker system prune -f
```

### 紧急恢复

如果系统出现严重问题，可以使用以下命令快速恢复：

```powershell
# 停止所有 MCP 容器
docker stop $(docker ps --filter "name=mcp-*" -q)

# 删除所有 MCP 容器
docker rm $(docker ps -a --filter "name=mcp-*" -q)

# 重新部署
docker-compose up -d

# 验证恢复
.\security-audit.ps1
```

---

## 📞 获取帮助

### 文档资源

- 📖 [完整配置指南](./MCP-PROJECT-ISOLATION-COMPLETE-GUIDE.md)
- 🔧 [配置模板](./mcp-config-template.json)
- 🐳 [Docker Compose 配置](./docker-compose.yml)
- 🛡️ [安全审计脚本](./security-audit.ps1)

### 日志位置

- **MCP 日志**：`E:\Logs\MCP\`
- **Docker 日志**：`docker logs <container_name>`
- **系统日志**：Windows 事件查看器

### 检查命令

```powershell
# 系统状态概览
Write-Host "=== MCP 系统状态 ===" -ForegroundColor Cyan
Write-Host "Docker 版本: $(docker --version)"
Write-Host "运行中的容器: $(docker ps --filter 'name=mcp-*' --format '{{.Names}}' | Measure-Object -Line | Select-Object -ExpandProperty Lines)"
Write-Host "网络列表: $(docker network ls --filter 'name=mcp-*' --format '{{.Name}}' | Measure-Object -Line | Select-Object -ExpandProperty Lines)"
Write-Host "磁盘使用: $(docker system df --format 'table {{.Type}}\t{{.TotalCount}}\t{{.Size}}')"
```

---

## 🎯 下一步

完成基本部署后，建议：

1. **🔍 深入学习**：阅读[完整配置指南](./MCP-PROJECT-ISOLATION-COMPLETE-GUIDE.md)
2. **🛡️ 加强安全**：定期运行安全审计脚本
3. **📊 监控优化**：设置性能监控和告警
4. **🔄 自动化**：配置自动备份和更新流程
5. **👥 团队协作**：制定团队使用规范和最佳实践

---

**🎉 恭喜！您已成功部署 MCP Server-Filesystem 项目隔离环境！**

如有问题，请参考故障排除部分或查看详细文档。
