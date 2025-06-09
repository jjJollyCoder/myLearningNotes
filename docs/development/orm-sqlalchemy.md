
# 使用 SQLAlchemy 进行数据库建模

SQLAlchemy 是 Flask 项目中常用的 ORM 工具，用于简化数据库操作。

## 安装依赖

```bash
pip install flask-sqlalchemy
````

## 配置 Flask 应用

```python
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///app.db"
db = SQLAlchemy(app)
```

## 定义模型

```python
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
```

## 创建数据库表

```bash
flask shell
>>> from app import db
>>> db.create_all()
```

## 查询数据

```python
User.query.filter_by(username="alice").first()
```

## 推荐使用 Flask-Migrate 管理数据迁移

