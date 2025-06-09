
# 📘 场景总结：Flask 项目中使用 Mermaid 实现流程图可视化

* ✅ 完整的可运行 Mermaid + Flask 示例结构模板（包括前后端代码）
* ✅ 项目目录结构建议
* ✅ 模块职责划分与命名推荐
* ✅ 节后快速恢复开发提示块

---

## 🧭 场景背景与目标

### 📍 起因：
在实际项目中，我们需要向甲方或内部干系人展示一条流程（如 backfill hiring 流程），希望能 **通过网页上的可视化流程图**，更直观地说明流程步骤、责任人和节点说明。

### 🎯 目标：
- 支持后端传入结构化数据
- 最少依赖，快速上线
- 图表样式美观清晰
- 可扩展其他图类型（如状态图、时序图）

---

## 💡 为什么选择 Mermaid？

| 对比维度     | Mermaid                    | ECharts                        |
|--------------|-----------------------------|---------------------------------|
| 渲染模型     | 基于纯文本 DSL，HTML 插入     | JS 配置结构化图表，强交互         |
| 适配场景     | 简单流程图，文本主导页面       | 大型图、仪表板、数据可视化项目     |
| 自定义能力   | 一般，语法受限               | 强，节点样式可完全自定义           |
| 集成难度     | 低，CDN 一句引入              | 中，需手动构建图表配置             |
| 响应式支持   | 有限                         | 优秀                             |
| 交互能力     | 基本无交互                    | 拖拽、缩放、事件绑定强             |

### ✅ Mermaid 优势总结：
- 快速、轻量、纯文本生成流程图
- 使用语义化强的 DSL 语法，便于维护
- 适合 SOP 流程、审批流、文档嵌入图

---

## 🧱 代码结构与项目模板（可运行）

### 📁 项目目录结构建议：

```

flask\_mermaid\_demo/
├── app.py
├── templates/
│   ├── base.html
│   └── flowchart.html
├── static/
│   └── script.js

````

---

### ✅ 1. app.py

```python
from flask import Flask, render_template
import json

app = Flask(__name__)

@app.route("/flowchart")
def flowchart():
    # 模拟的流程步骤数据
    flowchart_data = {
        "steps": [
            {"name": "Backfill开始", "responsible": "Gerry", "description": "", "time_limit": ""},
            {"name": "申请SO", "responsible": "Owen", "description": "", "time_limit": ""},
            {"name": "OE Validation", "responsible": "OE TSC", "description": "", "time_limit": "2天"},
            {"name": "流程结束", "responsible": "", "description": "", "time_limit": ""}
        ]
    }
    return render_template("flowchart.html", workflow=flowchart_data)

if __name__ == "__main__":
    app.run(debug=True)
````

---

### ✅ 2. templates/base.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{% block title %}Flowchart{% endblock %}</title>
</head>
<body>
    {% block content %}{% endblock %}
</body>
</html>
```

---

### ✅ 3. templates/flowchart.html

```html
{% extends "base.html" %}
{% block title %}流程图展示{% endblock %}
{% block content %}
<h2>流程图展示</h2>
<div id="workflowChart"></div>

<script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';

    mermaid.initialize({ startOnLoad: false });

    const workflow = {{ workflow | tojson | safe }};

    // 生成 mermaid 流程图 DSL
    let diagram = "graph TD\n";
    workflow.steps.forEach((step, idx) => {
        diagram += `    step${idx}["${step.name}"]\n`;
        if (idx > 0) {
            diagram += `    step${idx - 1} --> step${idx}\n`;
        }
    });

    const { svg } = await mermaid.render("workflowChart", diagram);
    document.getElementById("workflowChart").innerHTML = svg;
</script>
{% endblock %}
```

---

## ⚠️ 调试指南与注意事项

### 🌐 浏览器调试工具：

* `Console`：查看错误信息（如 `undefined`, `mermaid.render` 调用失败）
* `Elements`：查看 Mermaid 图是否渲染进 DOM
* `Network`：确保 Mermaid CDN 成功加载

### 🧪 常见报错说明：

| 报错信息                        | 原因                 | 解决方法                                                                     |        |                             |
| --------------------------- | ------------------ | ------------------------------------------------------------------------ | ------ | --------------------------- |
| `createElementNS undefined` | Mermaid 渲染太早       | 使用 `await mermaid.render()` 并确保挂载节点存在                                    |        |                             |
| `No diagram type detected`  | DSL 内容非法或 HTML 被转义 | 不要在 `<pre>` 中写 DSL；调试 DSL 可用 [Mermaid Live Editor](https://mermaid.live) |        |                             |
| `workflow is undefined`     | Jinja 未渲染          | \`window\.workflow = {{ workflow                                         | tojson | safe }}\` **必须写在 HTML 文件中** |

---

## 🗂️ 节后继续开发的建议记录方式

为了节后快速恢复进度，建议如下标记开发状态：

### ✅ 在代码注释中标记：

```python
# 🔧 TODO: 下一步要做 —— 将流程图中的描述信息作为 tooltip 展示
# ✅ 当前完成 —— 已实现后端传数据渲染
```

### ✅ 使用 README 或 `dev_notes.md` 临时记录：

```md
# 当前进度
- [x] 后端传 JSON 到前端
- [x] 基本流程图渲染成功
- [ ] 加入步骤详情 hover 展示
- [ ] 美化页面（颜色、字体等）

# 遇到问题
- Mermaid 在模块化加载后不能使用 `startOnLoad`，必须手动调用 render()

# 节后提醒
- 从 diagram DSL 模板构建器着手，封装一个生成方法
```

---

## 🔄 后续扩展思路

* 将流程节点支持点击弹窗，展示详细说明
* 增加 Mermaid 其他图类型支持（如 Gantt、State）
* 使用 ECharts 绘制支持缩放、过滤的复杂流程图
* 引入版本控制支持流程图变更对比

---

## 🧠 知识点提醒（Mermaid 版本相关）

* Mermaid v10 默认使用 `ESM Module`，需配合 `<script type="module">` 使用
* CDN 地址建议使用：

  ```js
  https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs
  ```
* 不再自动渲染 DOM 内的图（需手动调用 `render()`）

---

## 🔗 参考资料

* [Mermaid 官方文档](https://mermaid.js.org/)
* [Mermaid Live Editor](https://mermaid.live)
* [ECharts 官网](https://echarts.apache.org/zh/index.html)

---

