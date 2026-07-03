# 二向箔盒 · dual-vector-case

> 歌者从腰间掏出一个二向箔盒，里面整整齐齐地码着几十片箔。每一片都是一次降维打击。
>
> 这里是 AI Skill 的盒子。每个 skill 是一片二向箔——拿出来，丢出去，问题降维。

---

## 这是什么

一个 AI Skill 收集与维护仓库。按照使用场景分类，收纳 Claude Code 和 Claude 桌面端中用到的自定义 skill。

每个 skill 是一个独立文件夹，内含触发条件、指令逻辑和相关资源。

## 目录结构

```
dual-vector-case/
├── writing/          # 写作
├── design/           # 设计
├── engineering/      # 工程 & 提示词
├── research/         # 研究分析
├── tools/            # 工具配置
└── knowledge/        # 知识管理（待添加）
```

## Skill 清单

### ✍️ 写作 · writing

| Skill | 用途 |
|-------|------|
| wangxiaobo-perspective | 以王小波视角、黑色幽默与理性精神进行写作 |
| scqa-writing-coach | SCQA 结构化商业写作教练 |
| raw-note-organizer | 口述记录与碎片感想整理为连贯初稿 |
| proofread-cn | 中文文章逐字校订——错字、漏字、赘字 |

### 🎨 设计 · design

| Skill | 用途 |
|-------|------|
| ui-ux-pro-max | UI/UX 设计智库——50+ 风格、161 配色、57 字体组合 |
| frontend-design | 高设计质量的前端界面代码生成 |

### ⚙️ 工程 · engineering

| Skill | 用途 |
|-------|------|
| bug-manager | Bug 生命周期管理，记录在 `docs/bugs.md` |
| prompt-architect | 提示词架构与优化 |
| context-engineer | 结构化 Context 仓库构建与维护 |
| conversation-organizer | 长对话与 AI 协作过程整理为带证据状态的可确认材料 |
| context-doc-rules | 求职工具链 Context 仓库文档命名、头部与更新记录规则 |

新增说明：

- `conversation-organizer`：面向 AI 产品经理与 AI 的长对话 / Vibe Coding 场景，使用简化 Gioia + 轻量 IBIS 提取用户信号，包括方向判断、问题与痛点、想法与假设、决策与理由、疑问与不确定性、偏好与边界、情绪与强度和未分类信息；输出带证据状态的整理稿，写入前必须等待用户确认。
- `context-doc-rules`：面向求职工具链 Context 仓库的文档规则 Skill，按文档类型路由到通用规则、PRD 规则、工作记录规则、草稿与参考资料规则、已确认上下文文档规则和最低检查清单；只处理文件命名、一级标题、头部信息和更新记录，不决定目录分层。

### 🔬 研究 · research

| Skill | 用途 |
|-------|------|
| company-screening | 企业初筛研究，帮助 AI PM 求职者快速筛选目标公司 |

### 🔧 工具 · tools

| Skill | 用途 |
|-------|------|
| codex-oppo-sans | Codex 桌面端 OPPO Sans 字体配置 |

---

## 分类规则

新增 skill 时，按以下标准选择目录：

| 场景 | 目录 | 典型关键词 |
|------|------|-----------|
| 写作、校订、叙事 | `writing/` | 写作、校对、文章、随笔、叙事 |
| UI、视觉、前端 | `design/` | 设计、界面、配色、字体、组件、前端 |
| 开发、提示词、Agent | `engineering/` | 开发、Agent、Hook、Skill、提示词、Bug、Context、文档规则 |
| 分析、调研、研究 | `research/` | 研究、分析、调研、筛选、竞品 |
| 系统配置、工具安装 | `tools/` | 配置、安装、字体、环境、MCP |

---

## 维护

详见 [AGENTS.md](./AGENTS.md)。
