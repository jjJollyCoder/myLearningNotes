
# Python 虚拟环境配置指南

为了保持项目依赖隔离，推荐为每个项目使用独立的虚拟环境。

## 创建虚拟环境

```bash
python3 -m venv venv
````

## 激活虚拟环境

* macOS / Linux:

```bash
source venv/bin/activate
```

* Windows:

```bash
venv\Scripts\activate
```

## 安装依赖

```bash
pip install -r requirements.txt
```

## 退出虚拟环境

```bash
deactivate
```

## 提示

* 建议使用 `.gitignore` 忽略虚拟环境文件夹：

  ```
  venv/
  ```
