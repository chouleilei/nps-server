# NPS 内网穿透服务器

这是一个基于 [ehang-io/nps](https://github.com/ehang-io/nps) 的内网穿透代理服务器项目，已经配置好可以部署到 run.claw.cloud 平台。

## 项目简介

NPS 是一款轻量级、高性能、功能强大的内网穿透代理服务器，支持：
- TCP、UDP、HTTP(S)、SOCKS5 等多种协议
- 强大的 Web 管理界面
- 多客户端管理
- 流量统计和监控
- 域名解析和路由功能

## 在 run.claw.cloud 上部署

### 推荐方法：从源码构建部署

1. **登录 run.claw.cloud**
   - 访问 [run.claw.cloud](https://run.claw.cloud)
   - 注册并登录账户

2. **上传项目文件**
   - 将整个项目文件夹压缩上传到 run.claw.cloud
   - 或者通过 Git 仓库连接部署
   - 确保包含 `Dockerfile`、`nps` 可执行文件、`conf/` 和 `web/` 目录

3. **创建新应用**
   - 点击 "App Launchpad"
   - 选择 "Create App"
   - 选择 "Deploy from Docker" 或 "从代码构建"

4. **配置应用设置**
   - 应用名称：`nps-server`
   - 构建方式：平台会自动检测 Dockerfile

5. **网络配置**
   - 暴露端口：
     - `8080` - Web 管理界面（必须暴露）
     - `8024` - 客户端连接端口（必须暴露）
     - `80` - HTTP 代理端口（可选）
     - `443` - HTTPS 代理端口（可选）
   - 启用公网访问

6. **环境变量配置**（可选）
   ```
   TZ=Asia/Shanghai
   ```

### 备选方法：使用第三方 Docker 镜像

如果您不想从源码构建，可以尝试以下第三方镜像（请注意这些镜像的可用性可能会变化）：

1. **zhangsean/nps** (如果可用)
   ```bash
   # 在 run.claw.cloud 中使用镜像：zhangsean/nps:v0.26.10
   # 环境变量：
   NPS_MODE=server
   NPS_WEB_PASSWORD=your_secure_password
   NPS_PUBLIC_VKEY=your_secure_vkey
   ```

2. **自建镜像推送**
   - 本地构建镜像：`docker build -t your-registry/nps-server .`
   - 推送到 Docker Hub 或其他镜像仓库
   - 在 run.claw.cloud 中使用您的镜像

## 配置说明

### 默认配置

- Web 管理界面：`http://your-domain:8080`
- 默认用户名：`admin`
- 默认密码：`123`（**部署后请立即修改**）
- 客户端连接端口：`8024`

### 重要安全设置

部署完成后，请立即：

1. **修改管理员密码**
   - 登录 Web 界面
   - 进入系统设置
   - 修改默认密码

2. **修改公共密钥**
   - 在配置文件中修改 `public_vkey`
   - 或通过环境变量设置

3. **配置防火墙**
   - 确保只开放必要的端口
   - 考虑使用 HTTPS

## 客户端连接

1. **下载客户端**
   - 从 [NPS Releases](https://github.com/ehang-io/nps/releases) 下载对应平台的 `npc` 客户端

2. **获取连接信息**
   - 登录 Web 管理界面
   - 创建新客户端
   - 复制连接命令

3. **连接示例**
   ```bash
   ./npc -server=your-domain:8024 -vkey=your_client_vkey -type=tcp
   ```

## 使用场景

- **远程办公**：访问公司内网资源
- **开发调试**：本地服务外网访问
- **游戏联机**：内网游戏外网访问
- **文件共享**：内网文件服务器外网访问
- **监控系统**：内网设备远程监控

## 故障排除

### 常见问题

1. **无法访问 Web 界面**
   - 检查端口 8080 是否正确暴露
   - 确认防火墙设置
   - 查看应用日志

2. **客户端连接失败**
   - 检查端口 8024 是否正确暴露
   - 验证 vkey 是否正确
   - 检查网络连通性

3. **代理服务不工作**
   - 确认端口 80/443 已暴露
   - 检查客户端配置
   - 查看服务器日志

4. **构建失败**
   - 确保所有必要文件都已上传（nps 可执行文件、conf/、web/ 目录）
   - 检查 Dockerfile 语法
   - 查看构建日志

### 查看日志

在 run.claw.cloud 控制台中：
- 进入应用详情
- 查看 "Logs" 选项卡
- 检查错误信息

## 本地测试

在部署到 run.claw.cloud 之前，您可以本地测试：

```bash
# 构建镜像
docker build -t nps-server .

# 运行测试
docker run -d --name nps-test -p 8080:8080 -p 8024:8024 nps-server

# 访问 http://localhost:8080 测试
# 停止测试
docker stop nps-test && docker rm nps-test
```

## 高级配置

### 自定义配置文件

如需自定义配置，可以：

1. 修改 `conf/nps.conf` 文件
2. 重新构建 Docker 镜像
3. 或使用卷挂载自定义配置

### 域名配置

1. **设置自定义域名**
   - 在 run.claw.cloud 中配置自定义域名
   - 更新 DNS 记录指向分配的 IP

2. **HTTPS 配置**
   - 上传 SSL 证书
   - 修改配置文件中的证书路径

## 部署检查清单

部署前请确认：

- [ ] `nps` 可执行文件存在且有执行权限
- [ ] `conf/nps.conf` 配置文件存在
- [ ] `web/` 目录及其内容存在
- [ ] `Dockerfile` 文件正确
- [ ] 已规划好要暴露的端口
- [ ] 已准备好安全的密码和密钥

## 技术支持

- **官方文档**：[NPS 文档](https://ehang-io.github.io/nps/)
- **GitHub Issues**：[提交问题](https://github.com/ehang-io/nps/issues)
- **run.claw.cloud 支持**：[平台文档](https://docs.run.claw.cloud/)

## 许可证

本项目基于 GPL-3.0 许可证，详见 [LICENSE](LICENSE) 文件。 