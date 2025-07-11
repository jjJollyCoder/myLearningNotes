# 本地开发环境搭建指南（macOS/Linux）

## ✅ 1. Git 安装与配置

### 安装 Git（macOS）

```bash
brew install git
````

### 基本配置

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### 可选：添加 alias 快捷命令

```bash
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm "commit -m"
git config --global alias.st status
```

### 检查版本

```bash
git --version
```

---

## 🐍 2. Python 安装与版本管理

推荐使用 [pyenv](https://github.com/pyenv/pyenv) 管理多版本 Python。

### 安装 pyenv（macOS）

```bash
brew install pyenv
```

添加到 shell 配置文件：

```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
source ~/.zshrc
```

### 安装指定版本 Python

```bash
pyenv install 3.11.8
pyenv global 3.11.8
```

---

## 🧪 3. Python 虚拟环境（venv）

推荐每个项目使用虚拟环境隔离依赖。

```bash
python3 -m venv venv         # 创建虚拟环境
source venv/bin/activate     # 激活虚拟环境
deactivate                   # 退出虚拟环境
```

激活后安装依赖：

```bash
pip install -r requirements.txt
```

---

## 🛠 4. VSCode 配置

### 安装 VSCode

* 官网下载：[https://code.visualstudio.com/](https://code.visualstudio.com/)

### 推荐插件（扩展）

* Python（Microsoft）
* Markdown All in One
* GitLens
* Docker
* Prettier
* Markdown Preview Enhanced

### 打开当前目录

```bash
code .
```

---

## 🔐 5. SSH 配置与 Git 多账户

### 生成 SSH 密钥

```bash
ssh-keygen -t rsa -C "your@email.com" -f ~/.ssh/id_rsa_personal
```

### 添加 SSH 配置文件（\~/.ssh/config）

```bash
Host github-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_personal

Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_work
```

### 测试连接

```bash
ssh -T git@github-personal
```

---

## 📦 6. 常用工具建议安装

| 工具名     | 安装方式                  | 用途说明          |
| ------- | --------------------- | ------------- |
| tree    | `brew install tree`   | 查看目录结构        |
| jq      | `brew install jq`     | JSON 解析利器     |
| httpie  | `brew install httpie` | 替代 curl 的测试工具 |
| Docker  | 官网下载                  | 容器化部署         |
| Node.js | `brew install node`   | JS/前端工具链支持    |

---

## 📁 目录结构示例

```bash
myLearningNotes/
├── venv/
├── requirements.txt
├── mkdocs.yml
└── docs/
    └── setup/
        └── environment.md
```

---

## 🧠 备注与习惯

* 每次新设备配置都从此文件开始复用
* 自己新增的 alias、PATH 设置建议写入 `.zshrc` 并在此记录
* 有条件可制作 `.dotfiles` 仓库存放个人配置


