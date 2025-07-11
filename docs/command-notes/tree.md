# tree 等小工具命令

主要介绍 `tree` 命令的安装、常用参数、示例用法及常见技巧

## 📦 安装

### macOS

```bash
brew install tree
````

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install tree
```

### Windows

* 可以使用 [Git Bash](https://git-scm.com/downloads) 或者安装 [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) 来使用 `tree` 命令。
* 或者使用 PowerShell 自带的 `tree` 命令（功能较基础）。

---

## 🚀 常用命令示例

```bash
tree                          # 显示当前目录的树状结构
tree -L 2                     # 显示目录深度为 2 的树状结构
tree -d                       # 只显示目录，不显示文件
tree -a                       # 显示所有文件和目录，包括隐藏文件
tree -f                       # 显示完整路径
tree -h                       # 显示文件大小
tree -C                       # 使用颜色显示
tree --du                     # 显示文件夹大小（磁盘使用情况）
tree -I 'node_modules|venv'   # 忽略指定目录或文件（多个用 | 分隔）
```

---

## 🔧 常用组合示例

```bash
tree -L 3 -d -I 'node_modules|.git'  # 显示深度 3，且只显示目录，忽略 node_modules 和 .git
tree -L 2 -h                        # 显示深度 2，带文件大小
tree -a -f -C                      # 显示所有文件，包括隐藏，显示完整路径，带颜色
```

---

## 🧠 常见问题

* **显示中文乱码**
  尝试设置终端编码为 UTF-8，或者使用支持 UTF-8 的终端。

* **命令不支持某些参数**
  可能是版本过低，可以尝试升级 `tree`。

---

## 🧩 待补充内容

* 使用 `tree` 输出结果保存为文件

  ```bash
  tree -L 2 > tree_output.txt
  ```

* 结合 `grep` 过滤输出内容

* 使用 `tree` 生成 JSON/HTML 格式（需额外工具）

