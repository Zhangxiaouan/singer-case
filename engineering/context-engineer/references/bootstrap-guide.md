# Bootstrap Guide

This guide outlines how to take a user from zero to a functioning Context repo in one session, structured across six phases.

## Environment Detection

The first step involves checking for existing tool directories (`.claude/`, `.cursor/`, `.windsurfrules`) to identify the user's AI coding environment. Also determine whether the directory is a git repo, empty, or contains existing content that could be organized instead of starting fresh.

### Detection Checklist

1. Check for `.claude/` directory → Claude Code
2. Check for `.cursor/` directory or `.cursorrules` file → Cursor
3. Check for `.windsurfrules` file → Windsurf
4. Check if directory is a git repo (`git status`)
5. Check if directory is empty or has existing content

If multiple signals detected, ask the user which is their primary tool. Generate compatible files for all detected tools.

## The Interview

The interview extracts business knowledge through a conversational approach. Ask questions one at a time, adapting follow-ups based on responses.

### Core Questions (5 required)

1. **"What do you do?"** — Role, team, company type. Gets the broad picture first.
2. **"What does your product/company do?"** — Core business, value proposition, customers.
3. **"What terminology do you use that an outsider wouldn't know?"** — Domain-specific terms, acronyms, internal jargon.
4. **"What are you working on right now?"** — Current projects, priorities, active decisions.
5. **"What do you find yourself explaining to AI (or new colleagues) repeatedly?"** — The most valuable context — things the user already knows are knowledge bottlenecks.

### Adaptive Follow-ups (2-3 max, pick by relevance)

- **If they have a team**: "Who are the key people and what do they own?"
- **If they mention competitors**: "Who are your main competitors and how are you different?"
- **If regulated**: "What regulations or standards apply to your work?"
- **If they have customers**: "Describe your typical customer — what do they care about?"
- **If technical product**: "What's your tech stack and architecture at a high level?"

**Limit: 8 questions maximum.** The goal is extracting what the user already knows, not conducting a full consulting engagement.

### Interview Principles

- Use the user's actual words and examples — don't paraphrase into consultant-speak.
- If the user gives a vague answer, ask for one concrete example.
- Don't push for answers the user doesn't have — mark as `[TODO]` instead.

## Directory Scaffolding

### Minimal Viable Structure

```
repo-root/
├── CLAUDE.md              # Root index
├── context/               # Confirmed knowledge
├── workspace/             # Active projects
└── drafts/                # Ideas and raw material
```

### When to Add Sub-directories

Only add sub-directories when a directory accumulates **7+ files on similar topics**. Premature nesting creates navigation friction.

### Common Sub-directory Patterns

**Product Teams:**
```
context/
├── product/              # Product architecture, features
├── customers/            # Customer profiles, segments
├── competitors/          # Competitive analysis
└── terminology.md        # Team glossary
```

**Marketing/Ops Teams:**
```
context/
├── brand/                # Brand guidelines, messaging
├── channels/             # Distribution channels
├── metrics/              # KPIs, analytics definitions
└── processes/            # Standard operating procedures
```

**Solo Founders:**
```
context/
├── business-model.md     # Revenue, pricing, strategy
├── product.md            # Product overview and roadmap
├── customers.md          # Customer discovery notes
└── decisions.md          # Key decisions and rationale
```

## Seed Content Generation

### Quality Standards

- Each seed document should be **30-100 lines** of substantive content
- Use the user's own language and examples
- Mark gaps with `[TODO: fill in details about X]` — never fabricate
- Cold content (company background, terminology) first — highest ROI

### Document Priority Order

1. **Product/Company Overview** — What this business is (required, always first)
2. **Terminology** — Domain glossary (required, high reuse)
3. **Team & Roles** — If team size > 1
4. **Current Projects** — Workspace items for active work
5. **Competitors** — If the market is competitive
6. **Customer Profiles** — If they have customers
7. **Technical Architecture** — If building software

## Index Generation

### Root Index Requirements

A root CLAUDE.md must include:
1. **One-line repo description** — What this repo is for
2. **Directory map** — Table showing what each directory contains
3. **Three-layer explanation** — How drafts/workspace/context differ
4. **File summaries** — One line per file with a brief description

### Root Index Template

```markdown
# {Repo Name} — Context Repository

{One sentence describing purpose.}

## Structure

| Directory | What's Here |
|-----------|-------------|
| `context/` | Confirmed knowledge |
| `workspace/` | Active projects |
| `drafts/` | Ideas and raw material |

## Workflow

- New idea → `drafts/`
- Active project → `workspace/`
- Shipped/confirmed → distill into `context/`
- When in doubt, put it in `drafts/` first

## Contents

### context/
- **product-overview.md** — {one-line summary}
- **terminology.md** — {one-line summary}

### workspace/
- **{project}.md** — {one-line summary}

### drafts/
{list or "Empty — nothing drafted yet"}
```

### Directory Index Template

```markdown
# {Directory Name}

## Purpose
{One sentence — what this directory contains and why}

## Files
- **{filename}.md** — {one-line summary}

## When to Add Here
{Brief guidance on what qualifies for this directory}
```

## Handoff

### What to Tell the User

After bootstrapping, explain:
1. **What was created** — A quick tour of the directory structure and files
2. **Next 2-3 documents to write** — Highest-value gaps identified during the interview
3. **Day-to-day usage**:
   - **Adding context**: "Just tell me 'record this' and paste what you want saved"
   - **Starting new work**: "Say 'create a workspace doc for X' when beginning a project"
   - **Shipping work**: "Say 'distill X into context' when a project wraps up"
4. **How to use the repo**: "When you start a new AI session, the repo loads automatically. You can reference anything in it — the AI already knows what's here."

### First Week Checklist

Suggest the user do these in the first week:
- [ ] Add 3-5 terminology entries discovered during real work
- [ ] Record one meeting using "record this"
- [ ] Review the product overview — does it still feel accurate?
- [ ] Mark one completed project for distillation into context
