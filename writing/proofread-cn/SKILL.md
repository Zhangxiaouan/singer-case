---
name: "proofread-cn"
description: "中文文章校订：逐字校对错字、漏字、赘字，按一级标题分段，双轮核查防漏，生成带标记覆盖的 HTML。"
---

# 中文文章校订

## 任务
对中文文章进行逐字校对，找出错字、漏字、赘字，生成带颜色标记的 HTML 文件。

## 核心约束
- **只改错字、漏字、赘字**，不调整语序，不改写句子
- **保留原文全部换行和段落格式**
- **排比、重复修辞、口语化虚词（呢、啊、的、了、着）原则上不动**——这些是作者风格，除非明显是语法错误

---

## 处理流程

### 1. 获取北京时间
```bash
TZ='Asia/Shanghai' date '+%Y年%m月%d日 %H:%M'
```

### 2. 按一级标题分段
- 以一级标题（如「对"发心太多"的质疑」）为边界切分文章
- 若某段超过 2000 字，再按自然段做二级切分
- 每段处理时保留上一段的最后 1–2 句作为上下文衔接

### 3. 逐段双轮校对
- **第一轮（改稿）**：逐句找出所有错字、漏字、赘字，用标记语法标注
- **第二轮（审校）**：原文 vs 改后逐句对比，确认无遗漏、无多删、无误改

### 4. 输出变更清单（在对话中）
校对完成后列出表格：

| 位置 | 原文 | 校订 | 类型 |
|------|------|------|------|
| 第4段 | 使劲的想 | 使劲地想 | 错字 |

### 5. 生成 HTML
按下方模板生成 HTML 文件，保存到 outputs 目录，调用 present_files 展示。

---

## 标记语法

| 类型 | 写法 | 视觉效果 |
|------|------|----------|
| 错字/赘字 | `<del>原字</del>` | 删除线 + 红色 30% 底 |
| 替换字 | `<ins>正确字</ins>` | 绿色 30% 底 + 加粗 |
| 漏字 | `<span class="missing">漏字</span>` | 蓝色 30% 底 + 加粗 |

**替换字紧跟在删除字后面**，如：`<del>的</del><ins>地</ins>`

---

## 版本号规则
- 首次校订：v1.0
- 同一天内修改后重生成：v1.1 → v1.2 ...
- 跨天重新校订：v1.0 重新开始

---

## HTML 模板

以下模板中的 `{...}` 为占位变量，生成时替换为实际值。

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{文章标题} - 校订版</title>
<style>
  :root { color-scheme: light; }
  body {
    max-width: 700px;
    margin: 60px auto;
    padding: 0 24px;
    font-family: "PingFang SC", "Noto Serif SC", "Source Han Serif SC", "Songti SC", serif;
    font-size: 17px;
    line-height: 2;
    color: #222;
    background: #fdfcf9;
  }
  h1 {
    text-align: center;
    font-size: 24px;
    margin-bottom: 4px;
  }
  .meta {
    text-align: center;
    color: #999;
    font-size: 13px;
    margin-bottom: 36px;
  }
  .meta span { margin: 0 12px; }

  .legend {
    padding: 16px 20px;
    background: #f4f4f0;
    border-radius: 8px;
    margin-bottom: 40px;
    font-size: 14px;
    color: #555;
    line-height: 1.8;
  }
  .legend .count {
    font-size: 28px;
    font-weight: 800;
    color: #222;
    display: block;
    margin-bottom: 6px;
  }
  .legend .count em {
    font-style: normal;
    font-size: 15px;
    font-weight: 400;
    color: #999;
  }
  .legend .row {
    display: flex;
    align-items: center;
    gap: 6px;
    margin-top: 6px;
  }
  .legend .swatch {
    display: inline-block;
    width: 14px; height: 14px;
    border-radius: 3px;
    flex-shrink: 0;
  }

  p { margin: 0 0 1em 0; }
  .section-title { font-weight: bold; margin-top: 2em; }
  blockquote {
    margin: 1em 0;
    padding: 0 0 0 1em;
    border-left: 3px solid #ccc;
    color: #666;
  }
  del {
    text-decoration: line-through;
    background-color: rgba(192, 57, 43, 0.3);
    color: #222;
  }
  ins {
    text-decoration: none;
    background-color: rgba(39, 174, 96, 0.3);
    color: #222;
    font-weight: bold;
  }
  .missing {
    background-color: rgba(41, 128, 185, 0.3);
    color: #222;
    font-weight: bold;
  }
</style>
</head>
<body>

<h1>{文章标题}</h1>
<div class="meta">
  <span>校订版</span><span>{北京时间}</span><span>v{版本号}</span>
</div>

<div class="legend">
  <span class="count">共修正 {修正总数} 处<em>（错字/赘字/漏字）</em></span>
  <div class="row"><span class="swatch" style="background:rgba(192,57,43,0.3);"></span> 红色删除线 <strong>覆盖</strong> = 错字 / 赘字，应删除</div>
  <div class="row"><span class="swatch" style="background:rgba(39,174,96,0.3);"></span> 绿色 <strong>覆盖+加粗</strong> = 替换后的正确用字</div>
  <div class="row"><span class="swatch" style="background:rgba(41,128,185,0.3);"></span> 蓝色 <strong>覆盖+加粗</strong> = 原文遗漏，需补入的字</div>
</div>

{校订后的正文}

</body>
</html>
```

### 占位变量替换规则

| 变量 | 来源 |
|------|------|
| `{文章标题}` | 从原文第一行或用户指定提取 |
| `{北京时间}` | `date` 命令输出，如 `2026年6月10日 15:07（北京时间）` |
| `{v版本号}` | 按版本号规则确定 |
| `{修正总数}` | 校对完成后统计 |
| `{校订后的正文}` | 原文按段落转 `<p>`，标记处用对应标签包裹，段落间保留原文空行 |

