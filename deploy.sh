#!/bin/bash

# NPS 部署脚本 for run.claw.cloud
# 使用方法: ./deploy.sh

set -e

echo "🚀 NPS 部署脚本 for run.claw.cloud"
echo "=================================="

# 检查必要文件
echo "📋 检查必要文件..."
required_files=("nps" "conf/nps.conf" "web" "Dockerfile")
for file in "${required_files[@]}"; do
    if [ ! -e "$file" ]; then
        echo "❌ 错误: 缺少必要文件 $file"
        exit 1
    fi
done
echo "✅ 所有必要文件检查完成"

# 检查 Docker 是否安装（本地测试用）
if command -v docker &> /dev/null; then
    echo "🐳 Docker 已安装，可以进行本地测试"
    
    read -p "是否要进行本地测试？(y/N): " test_local
    if [[ $test_local =~ ^[Yy]$ ]]; then
        echo "🔨 构建 Docker 镜像..."
        docker build -t nps-server .
        
        echo "🚀 启动本地测试..."
        docker run -d --name nps-test -p 8080:8080 -p 8024:8024 nps-server
        
        echo "✅ 本地测试启动完成"
        echo "📱 Web 管理界面: http://localhost:8080"
        echo "🔑 默认用户名: admin"
        echo "🔑 默认密码: 123"
        echo ""
        echo "停止测试: docker stop nps-test && docker rm nps-test"
        echo ""
    fi
else
    echo "ℹ️  Docker 未安装，跳过本地测试"
fi

# 生成部署信息
echo "📝 生成部署信息..."
cat > deployment-info.txt << EOF
NPS 部署信息
============

项目类型: 内网穿透代理服务器
基础镜像: Alpine Linux
应用端口: 8080 (Web管理), 8024 (客户端连接), 80 (HTTP), 443 (HTTPS)

run.claw.cloud 部署步骤:
1. 登录 https://run.claw.cloud
2. 将整个项目文件夹压缩上传，或通过 Git 仓库连接
3. 点击 "App Launchpad" -> "Create App"
4. 选择 "Deploy from Docker" 或 "从代码构建"
5. 配置以下端口:
   - 8080: Web管理界面 (必须暴露)
   - 8024: 客户端连接端口 (必须暴露)
   - 80: HTTP代理端口 (可选)
   - 443: HTTPS代理端口 (可选)
6. 启用公网访问
7. 部署完成后访问 Web 界面修改默认密码

默认配置:
- 用户名: admin
- 密码: 123 (请立即修改!)
- 客户端连接端口: 8024

安全建议:
- 立即修改默认密码
- 修改 public_vkey
- 配置 HTTPS
- 限制访问 IP (如需要)

部署检查清单:
- [x] nps 可执行文件存在
- [x] conf/nps.conf 配置文件存在
- [x] web/ 目录及其内容存在
- [x] Dockerfile 文件正确

注意事项:
- 推荐使用从源码构建的方式部署
- 如果使用第三方镜像，请确认镜像的可用性
- 部署前可以先进行本地测试

EOF

echo "✅ 部署信息已保存到 deployment-info.txt"

# 检查配置文件安全性
echo "🔒 检查配置安全性..."
if grep -q "web_password=123" conf/nps.conf; then
    echo "⚠️  警告: 检测到默认密码，部署后请立即修改!"
fi

if grep -q "public_vkey=123" conf/nps.conf; then
    echo "⚠️  警告: 检测到默认公共密钥，建议修改!"
fi

# 检查文件权限
echo "🔍 检查文件权限..."
if [ ! -x "nps" ]; then
    echo "⚠️  警告: nps 可执行文件没有执行权限"
    echo "   建议运行: chmod +x nps"
fi

echo ""
echo "🎉 准备工作完成!"
echo "📁 项目文件已准备就绪，可以上传到 run.claw.cloud"
echo "📖 详细部署说明请查看 README.md"
echo "📋 部署信息请查看 deployment-info.txt"
echo ""
echo "🌐 run.claw.cloud: https://run.claw.cloud"
echo "📚 平台文档: https://docs.run.claw.cloud"
echo ""
echo "💡 部署建议:"
echo "   1. 推荐使用从源码构建的方式"
echo "   2. 确保所有必要文件都已包含"
echo "   3. 部署后立即修改默认密码"
echo "   4. 配置适当的安全设置" 