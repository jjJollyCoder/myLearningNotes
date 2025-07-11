# Git 命令 + 配置

## 📌 常用命令速查

```bash
git init                        # 初始化仓库
git clone <url>                # 克隆远程仓库
git status                     # 查看当前状态
git add .                      # 添加所有更改
git commit -m "message"        # 提交更改
git pull                       # 拉取远程更改
git push                       # 推送本地更改
````

---

## 🛠️ 全局配置与别名

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global core.editor "code --wait"        # 使用 VSCode 打开 commit 编辑器
git config --global color.ui auto                    # 启用颜色

# 添加常用 alias
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm "commit -m"
git config --global alias.st status
```

---

## 🔐 Git 与 SSH 多账户配置

```bash
# 生成两个 ssh key
ssh-keygen -t rsa -C "personal@email.com" -f ~/.ssh/id_rsa_personal
ssh-keygen -t rsa -C "work@email.com" -f ~/.ssh/id_rsa_work

# ~/.ssh/config 示例
Host github-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_personal

Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_work
```

```bash
# 设置不同项目使用不同账户
git remote set-url origin git@github-work:yourname/repo.git
```

---

## 🌱 分支管理

```bash
git branch                        # 查看本地分支
git branch -r                     # 查看远程分支
git checkout -b new-feature       # 新建并切换分支
git switch main                   # 切换分支（新命令）
git branch -d feature             # 删除本地分支
git push origin --delete feature # 删除远程分支
```

---

## 🚚 提交管理与回滚

```bash
git add -A                            # 添加所有修改（包括删除）
git commit --amend                    # 修改上一次 commit
git reset --soft HEAD~1              # 撤销 commit 保留修改
git reset --hard HEAD~1              # 强制撤销 commit 且不保留修改
git checkout -- <file>               # 丢弃本地文件修改
git revert <commit_id>               # 撤销某次提交（生成一个新提交）
```

---

## 🚀 本地与远程

```bash
git remote -v
git remote add origin git@github.com:user/repo.git
git push -u origin main         # 第一次 push 设置 upstream
git fetch                      # 拉取但不 merge
git pull --rebase              # 拉取后采用 rebase 模式（推荐）
```

---

## 🔍 查看日志和历史

```bash
git log --oneline --graph --decorate --all
git log -p filename             # 查看文件改动历史
git diff                       # 查看尚未提交的改动
git blame filename             # 追踪每行的作者
git reflog                     # 查看 HEAD 的历史（误删时可找回）
```

---

## 🧹 忽略与清理

```bash
# .gitignore 示例
__pycache__/
*.log
.env

git clean -fd                  # 删除未追踪的文件和文件夹（慎用）
git clean -n                   # 先预览再执行
```

---

## 🧠 常见问题记录

* ❌ 拉取代码报错：`Permission denied (publickey)`
  🔧 检查 `.ssh/config` 是否正确绑定对应仓库域名

* ❌ `.gitignore` 无效
  🔧 文件已被追踪，需执行：

  ```bash
  git rm -r --cached .
  git add .
  git commit -m "fix .gitignore"
  ```

* ❌ 多账户切换时总是用错 ssh key
  🔧 确保你用了正确的 Host，比如：`git@github-work:xxx.git`

---

