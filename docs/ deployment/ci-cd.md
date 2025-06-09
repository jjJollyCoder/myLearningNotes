
# 使用 GitHub Actions 实现自动部署

## 创建 `.github/workflows/deploy.yml`

```yaml
name: Deploy Docs

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: 安装 Python
        uses: actions/setup-python@v4
        with:
          python-version: 3.10

      - name: 安装 MkDocs
        run: |
          pip install mkdocs mkdocs-material

      - name: 部署到 GitHub Pages
        run: mkdocs gh-deploy --force
````

## 自动部署说明

* 每次 `main` 分支代码更新，将自动重新构建并发布文档。

````

