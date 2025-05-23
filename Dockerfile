FROM alpine:latest

# 安装必要的依赖
RUN apk add --no-cache ca-certificates

# 创建工作目录
WORKDIR /app

# 复制NPS可执行文件
COPY nps /app/nps

# 复制配置文件
COPY conf /app/conf

# 复制web静态文件
COPY web /app/web

# 设置可执行权限
RUN chmod +x /app/nps

# 暴露端口
# 8080: Web管理界面
# 8024: 客户端连接端口
# 80: HTTP代理端口
# 443: HTTPS代理端口
EXPOSE 8080 8024 80 443

# 设置环境变量
ENV NPS_CONFIG_PATH=/app/conf/nps.conf

# 启动命令
CMD ["/app/nps"] 