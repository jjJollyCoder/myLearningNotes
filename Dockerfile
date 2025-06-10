# 使用官方 Python 镜像
FROM python:3.11-slim

# 安装必要依赖
RUN pip install --no-cache-dir mkdocs

# 可选：安装你使用的插件（按需）
RUN pip install mkdocs-material

# 设置工作目录
WORKDIR /docs

# 暴露 mkdocs 默认端口
EXPOSE 8000

# 默认命令：启动 mkdocs 本地服务器
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]