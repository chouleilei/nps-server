# NPS 快速部署指南 - run.claw.cloud

## 🚀 快速开始

### 第一步：准备文件
确保您的项目包含以下文件：
- ✅ `nps` - 可执行文件
- ✅ `conf/nps.conf` - 配置文件
- ✅ `web/` - Web界面文件夹
- ✅ `Dockerfile` - Docker配置文件

### 第二步：上传到 run.claw.cloud

1. **登录平台**
   - 访问 https://run.claw.cloud
   - 注册/登录账户

2. **创建应用**
   - 点击 "App Launchpad"
   - 选择 "Create App"
   - 选择 "从代码构建" 或 "Deploy from Docker"

3. **上传项目**
   - 将整个项目文件夹压缩上传
   - 或连接 Git 仓库

### 第三步：配置应用

**必须配置的端口：**
- `8080` - Web管理界面（必须暴露）
- `8024` - 客户端连接端口（必须暴露）

**可选端口：**
- `80` - HTTP代理
- `443` - HTTPS代理

**环境变量（可选）：**
```
TZ=Asia/Shanghai
```

### 第四步：部署和访问

1. 点击部署按钮
2. 等待构建完成
3. 访问分配的域名:8080
4. 使用默认账户登录：
   - 用户名：`admin`
   - 密码：`123`

### 第五步：安全设置（重要！）

⚠️ **部署后立即执行：**

1. **修改管理员密码**
   - 登录后进入系统设置
   - 修改默认密码

2. **修改公共密钥**
   - 在配置中修改 `public_vkey`

3. **创建客户端**
   - 在Web界面创建新客户端
   - 获取专用的 vkey

## 🔧 客户端连接

1. **下载客户端**
   - 从 [NPS Releases](https://github.com/ehang-io/nps/releases) 下载 `npc`

2. **连接命令**
   ```bash
   ./npc -server=your-domain:8024 -vkey=your_client_vkey -type=tcp
   ```

## 🐛 常见问题

**Q: 无法访问Web界面？**
- 检查端口8080是否正确暴露
- 确认应用状态为运行中

**Q: 客户端连接失败？**
- 检查端口8024是否暴露
- 验证vkey是否正确

**Q: 构建失败？**
- 确保所有必要文件都已上传
- 检查Dockerfile语法

## 📞 获取帮助

- 查看完整文档：`README.md`
- 运行部署脚本：`./deploy.sh`
- 平台文档：https://docs.run.claw.cloud

---

**提示：** 建议先在本地测试，确认无误后再部署到云端。 