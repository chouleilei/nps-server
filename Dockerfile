FROM alpine:latest

# 安装必要的依赖
RUN apk add --no-cache ca-certificates

# 创建nps用户和组
RUN addgroup -g 1000 nps && \
    adduser -D -s /bin/sh -u 1000 -G nps nps

# 创建工作目录和数据目录
WORKDIR /app
RUN mkdir -p /app/data /app/logs && \
    chown -R nps:nps /app

# 复制NPS可执行文件
COPY nps /app/nps

# 复制配置文件
COPY conf /app/conf

# 复制web静态文件
COPY web /app/web

# 设置可执行权限和目录权限
RUN chmod +x /app/nps && \
    chown -R nps:nps /app && \
    chmod -R 755 /app

# 暴露端口
# 8080: Web管理界面
# 8024: 客户端连接端口
# 80: HTTP代理端口
# 443: HTTPS代理端口
EXPOSE 8080 8024 80 443

# 切换到nps用户
USER nps

# 设置环境变量
ENV NPS_CONFIG_PATH=/app/conf/nps.conf

# 启动命令
CMD ["/app/nps"] 