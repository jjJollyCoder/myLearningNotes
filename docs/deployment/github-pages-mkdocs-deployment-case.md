非常好，以下是根据我们完整排查部署失败到成功的过程，整理而成的一份场景题案例（Markdown 格式 `.md`），你可以直接保存进你的 repo，便于后续复用和面试展示。

---

### 2025-06-06 📘 文件名建议：`github-pages-mkdocs-deployment-case.md`

```markdown
# GitHub Pages + MkDocs 自动部署失败排查案例（面试/回顾场景题）

## 🧩 场景背景

你是某文档项目的维护者，使用 MkDocs + GitHub Actions 实现文档站点自动部署到 GitHub Pages。你在本地使用 `git push` 成功提交了代码，但 GitHub Actions 中部署总是失败，页面提示：

```

There isn't a GitHub Pages site here.

```

最终，你成功解决问题并顺利展示页面。以下为整个排查与处理过程。

---

## 🧪 问题初现：GitHub Actions 部署失败

### ✅ 表现

- 本地 push 正常
- GitHub Actions 日志报错：

```

The process '/usr/bin/git' failed with exit code 128
fatal: credential url cannot be parsed

````

---

## 🧠 排查与思考路径

### 🔍 1. 确认触发条件和分支设置

```yaml
on:
  push:
    branches:
      - main  # 确保是主分支名
````

### 🔍 2. 检查 `.yml` 配置是否正确构建并部署到 `gh-pages` 分支

关键字段必须包含：

```yaml
- name: Deploy to GitHub Pages
  uses: peaceiris/actions-gh-pages@v4
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./site
    publish_branch: gh-pages  # 显式指定目标部署分支
```

---

### 🔍 3. SSH Key 配置错误导致 push 失败

#### 错误行为：

* 仓库配置的是 **私钥**
* 本地生成的是 **公钥**

解决方案：

* 正确生成一对 SSH 密钥（如 `gh-pages-key` 和 `gh-pages-key.pub`）
* **私钥粘贴进 repo Settings > Secrets 中**
* **公钥添加到个人 GitHub 账户 > SSH keys 中**

⚠️ 注意：私钥必须包含 `-----BEGIN OPENSSH PRIVATE KEY-----` 到 `-----END OPENSSH PRIVATE KEY-----` 的完整内容。

---

### 🔍 4. GitHub Pages 设置未识别分支

排查方向：

* `gh-pages` 分支是否成功创建？
* GitHub Pages 设置中是否选择了正确的分支和目录？

设置路径：

```
Settings > Pages > Source:
Branch: gh-pages
Folder: / (root)
```

---

## 🛠️ 临时方案思考：是否手动创建 gh-pages 分支？

讨论中曾考虑是否应该手动部署：

```bash
mkdocs build
git checkout --orphan gh-pages
cp -r site/* .
git commit -m "manual deploy"
git push origin gh-pages
```

> 结论：建议保留 GitHub Actions 自动部署机制，便于 CI/CD 管理和团队协作。

---

## ✅ 最终解决方案

1. 修正 SSH key 配置
2. 明确 `publish_branch` 为 `gh-pages`
3. 将仓库设为 `public`
4. GitHub Pages 页面成功显示

---

## ✅ 页面访问路径

> 默认格式如下：

```
https://你的用户名.github.io/你的仓库名/
```

示例：

```
https://zhangsan.github.io/myLearningNotes/
```

---

## 💬 可用于面试复盘或工作分享

**问题描述：** GitHub Pages 自动部署失败
**解决步骤：** SSH 配置 + 分支校验 + Pages 设置修正
**个人贡献：** 独立排查所有配置错误并最终上线部署页面
**总结：** 理解了 GitHub Actions + Pages 的完整工作原理，熟悉 CI/CD 流程关键点。


# 场景题：本地和远程 main 分支不同步导致推送失败问题排查与解决

---

## 场景背景

- 开发者在本地修改了代码并提交到 `main` 分支。  
- 尝试执行 `git push origin main` 推送到远程仓库时，遇到权限错误提示：  
```

[git@github.com](mailto:git@github.com): Permission denied (publickey).
fatal: Could not read from remote repository.

````
- 但发现 GitHub Pages 上内容已有最新更新，怀疑推送是否成功。  
- 需要确认本地和远程分支是否同步，定位问题原因，并最终解决推送失败的问题。

---

## 发现问题步骤

1. **检查本地和远程 `main` 分支的最新提交差异**

 通过以下命令查看本地和远程 `main` 分支的最新提交时间和提交记录是否一致：

 ```bash
 git log main -1
 git log origin/main -1
````

* 发现本地 `main` 分支的最新提交时间为“今天”，
* 远程 `origin/main` 的最新提交时间为“昨天”，说明两者不同步。

2. **确认推送失败的权限问题**

   本地执行 `git push` 时提示 `Permission denied (publickey)`，说明 SSH 认证失败，导致推送未成功。

---

## 问题排查及解决方案

### 1. 检查 SSH 配置

* 查看本地 `.ssh/config`，确认是否为不同账号配置了不同的 Host，比如：

  ```ssh
  Host github.com-personal
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_rsa_personal
  ```

* 查看远程仓库地址：

  ```bash
  git remote -v
  ```

  确认远程地址是否使用了自定义 Host，如：

  ```
  git@github.com-personal:username/repo.git
  ```

### 2. 测试 SSH 连接是否正常

* 根据远程地址中的 Host，执行对应的测试命令：

  ```bash
  ssh -T git@github.com-personal
  ```

* 正常连接会显示：

  ```
  Hi username! You've successfully authenticated, but GitHub does not provide shell access.
  ```

* 如果显示权限错误，需检查 SSH key 是否已添加到 GitHub，或者本地配置是否正确。

### 3. 修改远程地址（如果需要）

* 若远程地址与 `.ssh/config` 中 Host 不对应，执行：

  ```bash
  git remote set-url origin git@github.com-personal:username/repo.git
  ```

* 确保 `git remote -v` 中显示的地址正确。

### 4. 确认本地与远程分支合并状态

* 拉取远程最新代码，合并到本地：

  ```bash
  git fetch origin
  git merge origin/main
  ```

  或者：

  ```bash
  git pull --rebase origin main
  ```

### 5. 推送本地代码

* 执行推送命令：

  ```bash
  git push origin main
  ```

* 若仍遇到权限问题，可开启详细 SSH 日志：

  ```bash
  GIT_SSH_COMMAND="ssh -v" git push origin main
  ```

  通过日志进一步定位问题。

---

## 验证结果

* 推送成功后，再次执行：

  ```bash
  git log origin/main -1
  git log main -1
  ```

* 确认本地和远程 `main` 分支的提交一致，完成同步。

---

## 总结

* 本地和远程分支不同步可能导致代码无法推送成功。
* 权限拒绝多半与 SSH key 配置或远程地址 Host 设置不匹配有关。
* 通过查看远程地址、自定义 SSH Host 配置、测试 SSH 连接等方式排查问题。
* 确保远程地址与 SSH 配置匹配，推送时才能正常认证和上传代码。
* 合理使用 `git fetch`、`git merge` 保持本地分支与远程分支同步，避免冲突。

---

*以上为实际问题排查和解决的总结记录*



