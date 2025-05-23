# 自建NPS Docker镜像指南

## 🎯 目标
构建自己的NPS Docker镜像并推送到Docker Hub，然后在run.claw.cloud上使用。

## 📋 前置条件

### 1. Docker Hub账号
- 访问 https://hub.docker.com/
- 注册账号（如果还没有）
- 记住您的用户名

### 2. 创建Docker Hub访问令牌
1. 登录Docker Hub
2. 点击右上角头像 → **Account Settings**
3. 点击 **Security** → **New Access Token**
4. Token名称：`github-actions`
5. 权限：**Read, Write, Delete**
6. 点击 **Generate**
7. **复制并保存**生成的令牌（只显示一次）

## 🔧 配置GitHub Secrets

1. 访问您的GitHub仓库：https://github.com/chouleilei/nps-server
2. 点击 **Settings** 标签
3. 左侧菜单点击 **Secrets and variables** → **Actions**
4. 点击 **New repository secret**

### 添加第一个Secret：
- **Name**: `DOCKERHUB_USERNAME`
- **Secret**: 您的Docker Hub用户名（例如：chouleilei）

### 添加第二个Secret：
- **Name**: `DOCKERHUB_TOKEN`
- **Secret**: 刚才复制的Docker Hub访问令牌

## 🚀 触发构建

我已经为您推送了触发构建的代码。现在：

1. 访问 https://github.com/chouleilei/nps-server/actions
2. 查看 **Build and Push Docker Image** 工作流
3. 等待构建完成（约5-10分钟）

## 📦 构建完成后

构建成功后，您的Docker镜像将可用：
```
chouleilei/nps-server:latest
```

## 🌐 在run.claw.cloud部署

### 配置信息：
- **Application Name**: `nps-server`
- **Image Name**: `chouleilei/nps-server:latest`

### 端口配置：
| Container Port | Public Access | 说明 |
|---------------|---------------|------|
| 8080 | ✅ 开启 | Web管理界面 |
| 8024 | ✅ 开启 | 客户端连接端口 |
| 80 | ✅ 开启 | HTTP代理（可选） |
| 443 | ✅ 开启 | HTTPS代理（可选） |

### 资源配置：
- **CPU**: 0.2 Core
- **Memory**: 256M

## 🔐 默认登录信息

- **Web界面地址**: `https://your-domain:8080`
- **用户名**: `admin`
- **密码**: `123`

⚠️ **重要**: 部署成功后立即修改默认密码！

## 🔍 故障排除

### 如果构建失败：
1. 检查GitHub Secrets是否正确设置
2. 检查Docker Hub用户名和令牌是否有效
3. 查看GitHub Actions日志获取详细错误信息

### 如果部署失败：
1. 确认镜像名称正确：`chouleilei/nps-server:latest`
2. 确认端口8080和8024已启用Public Access
3. 检查资源配置是否足够

## 📞 支持

如有问题，请检查：
- GitHub Actions构建日志
- run.claw.cloud部署日志
- NPS官方文档：https://ehang-io.github.io/nps/ 