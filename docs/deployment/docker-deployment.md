
# 使用 Docker 部署 Flask 项目

## 创建 `Dockerfile`

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]
````

## 构建镜像

```bash
docker build -t flask-app .
```

## 启动容器

```bash
docker run -d -p 5000:5000 flask-app
```

## 多文件结构时注意事项

确保 `app.py`、模块和配置路径正确挂载进容器中。

````

