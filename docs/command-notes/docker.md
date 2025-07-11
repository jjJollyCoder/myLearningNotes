# Docker 常用命令
## 📦 安装与版本查看

```bash
docker --version
docker compose version    # Docker Compose 版本（如果安装了）
````

---

## 🚀 镜像管理

```bash
docker pull image_name           # 拉取镜像
docker images                   # 列出本地镜像
docker rmi image_id/image_name  # 删除镜像
docker build -t myimage:tag .   # 当前目录构建镜像，打标签
```

---

## 📦 容器管理

```bash
docker run -it --name mycontainer ubuntu /bin/bash  # 交互式启动容器
docker ps                        # 查看正在运行的容器
docker ps -a                     # 查看所有容器（含已停止）
docker stop container_id/name   # 停止容器
docker start container_id/name  # 启动已停止容器
docker restart container_id/name# 重启容器
docker rm container_id/name     # 删除容器（容器停止状态下）
docker logs -f container_id     # 实时查看日志
```

---

## 📁 数据卷管理（持久化数据）

```bash
docker volume ls                 # 查看数据卷
docker volume create mydata     # 创建数据卷
docker volume rm mydata         # 删除数据卷
docker run -v mydata:/data ...  # 挂载数据卷
```

---

## 🌐 网络管理

```bash
docker network ls               # 查看网络
docker network create mynet    # 创建网络
docker network rm mynet        # 删除网络
docker run --network mynet ... # 指定网络启动容器
```

---

## 🧱 Dockerfile 基础示例

```dockerfile
# 基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY requirements.txt .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目代码
COPY . .

# 暴露端口
EXPOSE 8000

# 启动命令
CMD ["python", "app.py"]
```

---

## 🧰 常用 Docker Compose 命令

```bash
docker compose up -d          # 后台启动服务
docker compose down           # 停止并删除容器、网络
docker compose logs -f        # 查看日志
docker compose build          # 重新构建镜像
```

---

## 🧠 常见问题与解决方案

* **容器端口无法访问**
  检查 `docker run` 是否正确映射端口，例如 `-p 8080:80`

* **镜像构建失败**
  注意 Dockerfile 中的路径、缓存问题，可尝试加 `--no-cache`

* **数据丢失**
  使用数据卷持久化重要数据

* **网络互通问题**
  容器间不同网络时无法访问，考虑创建自定义网络

---

## 🧩 待扩展内容

* 多阶段构建（Multi-stage Build）
* 镜像优化技巧
* 私有仓库推送与拉取
* Dockerfile 复杂指令详解
* 容器安全最佳实践

