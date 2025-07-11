# Python 命令 + 虚拟环境 + pip配置

## 📦 安装与版本管理（pyenv）

```bash
# 安装 pyenv（macOS 通过 Homebrew）
brew install pyenv

# 查看可用版本
pyenv install --list

# 安装指定版本
pyenv install 3.11.8

# 查看已安装版本
pyenv versions

# 设置全局 Python 版本
pyenv global 3.11.8

# 设置当前项目的本地版本
pyenv local 3.11.8
````

---

## 🧪 虚拟环境管理（venv）

```bash
# 创建虚拟环境（项目根目录）
python3 -m venv venv

# 激活虚拟环境（macOS/Linux）
source venv/bin/activate

# 激活虚拟环境（Windows PowerShell）
.\venv\Scripts\Activate.ps1

# 退出虚拟环境
deactivate
```

---

## 🛠 常用命令速查

```bash
python --version                # 查看 Python 版本
pip install package_name       # 安装包
pip uninstall package_name     # 卸载包
pip list                      # 查看已安装包
pip show package_name         # 显示包信息
pip freeze > requirements.txt # 导出依赖
pip install -r requirements.txt # 安装依赖列表
```

---

## 🗂 pip 包管理与配置

### 配置国内镜像源（加速）

在 `~/.pip/pip.conf`（Linux/macOS）或 `%APPDATA%\pip\pip.ini`（Windows）添加：

```ini
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
```

### 常用 pip 参数

* `--upgrade`：升级包
* `--force-reinstall`：强制重新安装
* `--no-cache-dir`：不使用缓存安装

---

## 📁 Python 项目结构示例

```bash
my-python-project/
├── src/
│   └── main.py
├── tests/
│   └── test_main.py
├── venv/
├── requirements.txt
├── README.md
└── pyproject.toml / setup.py
```

---

## 🔍 常用开发工具链

* `ipython`：交互式 Python shell
* `jupyter notebook`：交互式文档和代码
* 代码格式化：`black`
* 代码检查：`pylint`、`flake8`
* 类型检查：`mypy`

安装示例：

```bash
pip install ipython jupyter black pylint mypy
```

---

## 🧠 常见问题与解决方案

* **虚拟环境无法激活**
  检查是否使用正确命令及路径，Windows 可能需执行 `Set-ExecutionPolicy RemoteSigned` 放宽 PowerShell 权限。

* **pip 安装失败**
  尝试升级 pip：

  ```bash
  python -m pip install --upgrade pip
  ```

* **UnicodeDecodeError**
  确认文件编码，尽量统一用 UTF-8。

* **依赖冲突**
  建议新建虚拟环境，避免全局包干扰。

---

## 🧩 待扩展内容

* Poetry 和 Pipenv 使用简介
* Python 包发布流程
* `setup.py`、`pyproject.toml` 基础示范
* Docker 容器中的 Python 环境配置

