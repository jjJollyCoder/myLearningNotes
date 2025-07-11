# Nginx 配置命令
包含常用命令、配置文件结构、反向代理、负载均衡、常见配置示例及排查技巧。直接复制使用，方便快速查阅

## 📦 安装与版本查看

```bash
nginx -v                  # 查看安装版本
sudo apt update
sudo apt install nginx    # Debian/Ubuntu 安装命令
brew install nginx        # macOS 使用 Homebrew 安装
````

---

## 🚀 常用管理命令

```bash
sudo nginx                # 启动 nginx
sudo nginx -s stop        # 停止 nginx
sudo nginx -s reload      # 重新加载配置文件（无停机）
sudo nginx -s quit        # 优雅退出
ps aux | grep nginx       # 查看 nginx 进程
```

---

## 🗂 Nginx 配置文件结构简介

* 主配置文件通常在 `/etc/nginx/nginx.conf`
* 其他站点配置文件在 `/etc/nginx/sites-available/` 和 `/etc/nginx/sites-enabled/`
* 主要配置块：

  * `events`：连接数和工作模式
  * `http`：HTTP 服务器配置
  * `server`：虚拟主机配置
  * `location`：请求路径匹配

---

## 🌐 反向代理示例

```nginx
server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

---

## ⚖️ 负载均衡配置示例

```nginx
upstream backend {
    server 192.168.0.101;
    server 192.168.0.102;
}

server {
    listen 80;

    location / {
        proxy_pass http://backend;
    }
}
```

---

## 🔧 常用配置示例

* **设置访问日志和错误日志**

```nginx
access_log /var/log/nginx/access.log;
error_log /var/log/nginx/error.log warn;
```

* **配置静态文件路径**

```nginx
location /static/ {
    alias /var/www/static/;
}
```

* **开启 gzip 压缩**

```nginx
gzip on;
gzip_types text/plain application/json application/javascript text/css;
```

---

## 🧰 排查与调试

* 查看配置语法是否正确：

```bash
sudo nginx -t
```

* 重新加载配置：

```bash
sudo nginx -s reload
```

* 查看日志文件：

```bash
tail -f /var/log/nginx/error.log
tail -f /var/log/nginx/access.log
```

---

## 🧠 常见问题与解决方案

* **配置修改后无效**
  检查配置语法 `nginx -t`，重载配置 `nginx -s reload`

* **端口冲突导致启动失败**
  确认端口未被占用，`sudo lsof -i:80`

* **代理后客户端 IP 显示错误**
  需配置 `proxy_set_header X-Real-IP` 和 `X-Forwarded-For`

---

## 🧩 待扩展内容

* SSL/TLS 配置与 Let's Encrypt 证书自动化
* HTTP2 配置示例
* Nginx 性能调优参数详解
* 配置缓存与限流策略
* Nginx 反代 WebSocket 配置

