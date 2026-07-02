# 二向箔盒 · 操作指南

> 面向所有 AI Agent（Claude Code / Codex / 其他）的本仓库操作规范。

---

## 仓库用途

这是一个按 **使用场景** 分类的 AI Skill 收集与维护仓库。每个 skill 是一个独立文件夹。

## 目录结构

```
dual-vector-case/
├── writing/          # 写作：校订、叙事、风格化写作
├── design/           # 设计：UI、视觉、前端组件
├── engineering/      # 工程：开发、Agent、提示词、Hook、Skill
├── research/         # 研究：分析、调研、筛选
├── tools/            # 工具：系统配置、字体、环境安装
├── knowledge/        # 知识管理（待添加）
├── AGENTS.md         # 本文件
└── README.md         # 人类可读说明
```

## 分类规则

新增 skill 时，按以下标准选择目标目录：

| 场景 | 目录 | 关键词匹配 |
|------|------|-----------|
| 写作 | `writing/` | 写作、校对、文章、随笔、叙事、SCQA、笔记整理 |
| 设计 | `design/` | 设计、界面、配色、字体、组件、UI、UX、前端 |
| 工程 | `engineering/` | 开发、Agent、Hook、Skill、提示词、Bug、Context |
| 研究 | `research/` | 研究、分析、调研、筛选、竞品、横纵分析 |
| 工具 | `tools/` | 配置、安装、字体、环境、MCP、系统设置 |

> 如果一个 skill 跨多个场景，选它最核心的场景分类。

## 支持的操作

### 1. 添加新 Skill

**步骤：**

1. 根据 skill 的主要用途，匹配上述分类规则，确定目标目录
2. 从源位置拷贝 skill 到目标目录：

```bash
# Skill 来自 Claude Code CLI（~/.claude/skills/）
cp -r /c/Users/Zhangqian/.claude/skills/<skill-name> <目标目录>/

# Skill 来自 Claude 桌面端内置
cp -r "/c/Users/Zhangqian/AppData/Local/Claude-3p/.../skills/<skill-name>" <目标目录>/

# 全新 skill：在目标目录下新建文件夹
mkdir -p <目标目录>/<skill-name>
```

3. 确保 skill 文件夹包含核心文件（SKILL.md）
4. 在 README.md 对应分类的 skill 清单表格中追加一行
5. 提交：

```bash
cd /c/Users/Zhangqian/Desktop/dual-vector-case
git add .
git commit -m "feat: 添加 <skill-name>"
```

### 2. 更新已有 Skill

1. 直接编辑目标目录下对应 skill 文件夹内的文件
2. 如需同步更新 README 中的描述，一并修改
3. 提交：

```bash
cd /c/Users/Zhangqian/Desktop/dual-vector-case
git add .
git commit -m "refactor: 更新 <skill-name> — <简述>"
```

## Skill 文件格式

每个 skill 文件夹包含一个 `SKILL.md`：

```markdown
---
name: <skill-name>
description: <描述>
---

# <Skill 标题>

<指令内容>
```

## 禁止的操作

- **不要删除 skill**，除非用户明确要求
- **不要改变分类体系**，保持五大场景目录不变
- **不要跨分类移动 skill**，放入时的分类即为最终分类
- **不要修改其他 skill 的内容**，除非用户要求

## 提交规范

使用 Conventional Commits：

```
feat: 添加 <skill-name>
refactor: 更新 <skill-name> — <简述>
docs: 更新 README
```
