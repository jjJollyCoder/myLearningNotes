
# 🧩 Git 多账号配置指南（工作账号 + 个人账号，含 SSH key 与 hook 设置）

> 本指南用于实现在本地分离管理多个 Git 身份（如工作 / 个人），防止提交混用账号或签名失败。

---

## ✅ 总览任务清单

| 步骤 | 目标                          | 状态 |
| -- | --------------------------- | -- |
| 1  | 取消所有 Git 全局配置（慎重）           | ✅  |
| 2  | 设置每个项目的 Git 用户名和邮箱          | ✅  |
| 3  | SSH key 分离管理（工作 & 个人）       | ✅  |
| 4  | 设置 SSH config 支持多个 Host     | ✅  |
| 5  | 修改 Git remote 使用不同 Host     | ✅  |
| 6  | 工作项目启用 ac-sign hook，个人项目不启用 | ✅  |
| 7  | 验证项目身份、远程连接、hook 是否生效       | ✅  |

---

## 🔧 第一步：清除全局 Git 配置（可选）

> 防止全局配置污染项目设置，推荐仅在有明确需求时进行。

### 查看全局配置

```bash
git config --global --list
```

### 清除方式

**方式一（慎重）**：删除 `.gitconfig`

```bash
rm ~/.gitconfig
```

**方式二（推荐）**：逐项取消

```bash
git config --global --unset user.name
git config --global --unset user.email
git config --global --unset core.hooksPath
```

---

## 👤 第二步：设置每个项目的用户名和邮箱

在每个项目根目录执行：

```bash
# 工作项目
git config user.name "Your Work Name"
git config user.email "yourname@company.com"

# 个人项目
git config user.name "Your Personal Name"
git config user.email "you@gmail.com"
```

验证：

```bash
git config user.name
git config user.email
```

---

## 🔑 第三步：生成两套 SSH Key

```bash
# 工作账户
ssh-keygen -t ed25519 -C "yourname@company.com" -f ~/.ssh/id_ed25519_work

# 个人账户
ssh-keygen -t ed25519 -C "you@gmail.com" -f ~/.ssh/id_ed25519_personal
```

---

## 🗂️ 第四步：编辑 SSH config 文件

```bash
nano ~/.ssh/config
```

配置示例：

```ssh
# 工作账号
Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
  IdentitiesOnly yes

# 个人账号
Host github.com-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
  IdentitiesOnly yes
```

---

## 🌐 第五步：修改项目 remote 地址

进入项目目录，设置为对应 host：

```bash
# 工作项目
git remote set-url origin git@github.com-work:yourcompany/repo.git

# 个人项目
git remote set-url origin git@github.com-personal:yourusername/yourrepo.git
```

---

## 🔐 第六步：配置 hook（如 ac-sign）

### 工作项目启用：

```bash
git config core.hooksPath ~/.git-hooks/ac-sign
```

### 个人项目禁用：

```bash
# 方式一
git config --unset core.hooksPath

# 方式二（推荐）
mkdir -p ~/.git-hooks/empty
git config core.hooksPath ~/.git-hooks/empty
```

---

## ✅ 第七步：验证所有配置是否生效

| 验证内容            | 指令                                                              |
| --------------- | --------------------------------------------------------------- |
| 当前项目用户名与邮箱      | `git config user.name && git config user.email`                 |
| 是否启用 hook       | `git config core.hooksPath`                                     |
| 当前使用的 SSH Host  | `git remote -v`                                                 |
| SSH 是否连接成功      | `ssh -T git@github.com-work` 和 `ssh -T git@github.com-personal` |
| 提交是否触发 hook（工作） | 正常提交一次，查看是否触发签名                                                 |

---

## 🔍 快捷脚本查看当前 Git 状态

```bash
echo "Remote URL:"
git remote -v

echo "User Info:"
git config user.name
git config user.email

echo "Hook Path:"
git config core.hooksPath

echo "SSH Host Match:"
grep Host ~/.ssh/config | grep $(git remote -v | head -1 | awk '{print $2}' | cut -d: -f1)
```

---

## 🧪 提交测试

```bash
git add .
git commit -m "Test commit"
git push origin main
```

> 工作项目应触发 `ac-sign`，个人项目不应有 hook 执行。

---

## 💡 Bonus 建议

* 编写 shell 脚本一键切换账号
* 使用 `.git/info/exclude` 屏蔽非版本文件
* 使用 SSH `IdentitiesOnly yes` 避免 agent 自动选择错误 key

---
## 💡 查看本地.ssh/config

* cat ~/.ssh/config
# 工作账号
Host github.com-work
  HostName github.siri.apple.com
  User git
  IdentityFile ~/.ssh/id_rsa
  IdentitiesOnly yes

# 个人账号
Host github.com-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
  IdentitiesOnly yes
