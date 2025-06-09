
# 📘 场景题总结：如何在现有 Flask 项目中新增 Stakeholder 模块（以真实外包项目为例）

---

## 🧩 场景背景

你是一名外包项目的项目负责人，负责一个由四个不同小组组成的跨地区项目。项目主要服务于美国客户，客户方有多个联系人和层级，包括美国运营经理、项目总监、客户经理、Recruiter、Academy 等不同角色。

你已有的 Flask 项目用于展示人员信息和自动化流程图，但你现在需要新增一项功能：**对所有 Stakeholders 进行分类、管理和展示**。

---

## 🚪 引入新模块的契机

**为什么要引入 Stakeholder 模块？**
- 项目涉及的干系人众多、角色复杂，需要分类管理和展示，避免信息混乱；
- 沟通频繁时，经常混淆对接人职责或忽略重要角色，影响效率；
- 有利于内部团队成员快速熟悉干系人结构，提升协作效率。

---

## 📊 Stakeholders List 的业务需求分析

| 需求点                        | 目标/原因                                                                 |
|-----------------------------|--------------------------------------------------------------------------|
| **角色分类展示**              | 明确每位干系人的职责、角色，方便项目成员按需联系                          |
| **支持地区划分（如：上海、美国）** | 支持跨地域项目对接结构的展示，便于分区管理                                 |
| **优先级标识（Primary/Secondary）** | 强调关键联系人，防止遗漏重要沟通对象                                       |
| **备注信息字段**              | 记录沟通历史、注意事项、人事变更等背景信息                                  |
| **结构化列表展示**            | 比非结构化笔记或Word文档更易于维护与查询                                    |
| **后期数据可维护（编辑/新增）**    | 允许后续运营人员持续维护联系人信息，保持数据长期有效                        |
| **可扩展导出**                | 数据可用于项目汇报、交接资料、审计需求                                      |

---

## 🧱 结构设计：是否复用原项目？如何区分？

### ✅ 选择方案：
**在原项目基础上扩展一个独立模块，而非新建一个完全独立的项目。**

### ✅ 原因：
- 原项目已有登录、页面框架，便于继承；
- 避免维护多个项目、重复代码；
- 使用 Flask Blueprint 分离逻辑，清晰、易维护；
- 数据和逻辑层隔离，支持后续独立开发或重构。

---

## 🧭 如何进行结构分离与集成？

### 🗂️ 路由逻辑分离
使用 Flask Blueprint，将 Stakeholder 路由独立出来：

```python
# routes/stakeholder_routes.py
stakeholder_bp = Blueprint("stakeholder", __name__)
@stakeholder_bp.route("/stakeholders")
def show_stakeholders(): ...
````

在 `app.py` 中注册蓝图：

```python
from routes.stakeholder_routes import stakeholder_bp
app.register_blueprint(stakeholder_bp)
```

---

## 🧩 数据模型与设计

### 🧱 数据模型类

```python
# stakeholders/models.py
class Stakeholder:
    def __init__(self, name, role, organization, department, location, priority, notes):
        ...
```

### 📄 数据初始化：使用 JSON 文件存储初始数据

```json
// data/stakeholders.json
[
  {
    "name": "Alice Wang",
    "role": "Account Manager",
    "organization": "Outsourcing Team",
    ...
  }
]
```

### 🧪 数据加载

在路由函数中读取 JSON 并生成模型对象列表：

```python
with open("data/stakeholders.json") as f:
    raw_data = json.load(f)
stakeholders = [Stakeholder(**s) for s in raw_data]
```

---

## 🖥️ 页面展示：使用 Bootstrap 美化表格

```html
<!-- templates/stakeholder.html -->
{% extends "base.html" %}
{% block content %}
<table class="table table-bordered">
  <thead><tr><th>Name</th> ... </tr></thead>
  <tbody>
    {% for s in stakeholders %}
    <tr>
      <td>{{ s.name }}</td> ...
    </tr>
    {% endfor %}
  </tbody>
</table>
{% endblock %}
```

---

## 🚀 可扩展性设计与后续方向

### ✅ 可扩展内容

* ✔️ 筛选和分类展示（如按部门/地区筛选）
* ✔️ 搜索框支持模糊匹配
* ✔️ 后台可编辑、增删数据（通过表单）
* ✔️ 引入 SQLite/PostgreSQL 作为数据库替代 JSON 文件
* ✔️ 权限控制：不同角色展示不同数据
* ✔️ 导出功能（CSV/PDF）
* ✔️ 集成图谱展示（干系人关系网）

---

## 🗂️ 当前项目结构（简化）

```plaintext
project_root/
├── app.py
├── data/
│   ├── members.json
│   └── stakeholders.json          # 🔹新增
├── routes/
│   ├── stakeholder_routes.py      # 🔹新增
├── stakeholders/                  # 🔹新增模块
│   ├── models.py
├── templates/
│   ├── base.html
│   └── stakeholder.html           # 🔹新增页面
├── static/
│   ├── css/
│   ├── images/
│   └── js/
├── venv/
└── requirements.txt
```

---

## 💡 结语

本模块的设计初衷是 **最小侵入、最大复用**。借助 Flask 的模块化能力（Blueprint）与模板继承机制（base.html），你实现了：

* 原项目结构的平稳扩展；
* 逻辑与数据的清晰划分；
* 对未来演化的可持续支持；
* 对实际业务需求的精准响应。


