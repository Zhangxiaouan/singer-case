---
name: "ui-ux-pro-max"
description: "UI/UX design intelligence for web and mobile — searchable database of 50+ styles, 161 color palettes, 57 font pairings, 10 stacks. Use when designing pages, components, choosing colors/fonts, reviewing UX, or any UI work."
---

---
name: ui-ux-pro-max
description: "UI/UX design intelligence for web and mobile. Includes 50+ styles, 161 color palettes, 57 font pairings, 161 product types, 99 UX guidelines, and 25 chart types across 10 stacks (React, Next.js, Vue, Svelte, SwiftUI, React Native, Flutter, Tailwind, shadcn/ui, and HTML/CSS). Actions: plan, build, create, design, implement, review, fix, improve, optimize, enhance, refactor, and check UI/UX code. Projects: website, landing page, dashboard, admin panel, e-commerce, SaaS, portfolio, blog, and mobile app. Elements: button, modal, navbar, sidebar, card, table, form, and chart. Styles: glassmorphism, claymorphism, minimalism, brutalism, neumorphism, bento grid, dark mode, responsive, skeuomorphism, and flat design. Topics: color systems, accessibility, animation, layout, typography, font pairing, spacing, interaction states, shadow, and gradient."
---

# UI/UX Pro Max - Design Intelligence

Comprehensive design guide for web and mobile applications. Contains 50+ styles, 161 color palettes, 57 font pairings, 161 product types with reasoning rules, 99 UX guidelines, and 25 chart types across 10 technology stacks. Searchable database with priority-based recommendations.

## When to Apply

This Skill should be used when the task involves **UI structure, visual design decisions, interaction patterns, or user experience quality control**.

### Must Use

This Skill must be invoked in the following situations:

- Designing new pages (Landing Page, Dashboard, Admin, SaaS, Mobile App)
- Creating or refactoring UI components (buttons, modals, forms, tables, charts, etc.)
- Choosing color schemes, typography systems, spacing standards, or layout systems
- Reviewing UI code for user experience, accessibility, or visual consistency
- Implementing navigation structures, animations, or responsive behavior
- Making product-level design decisions (style, information hierarchy, brand expression)
- Improving perceived quality, clarity, or usability of interfaces

### Recommended

This Skill is recommended in the following situations:

- UI looks "not professional enough" but the reason is unclear
- Receiving feedback on usability or experience
- Pre-launch UI quality optimization
- Aligning cross-platform design (Web / iOS / Android)
- Building design systems or reusable component libraries

### Skip

This Skill is not needed in the following situations:

- Pure backend logic development
- Only involving API or database design
- Performance optimization unrelated to the interface
- Infrastructure or DevOps work
- Non-visual scripts or automation tasks

**Decision criteria**: If the task will change how a feature **looks, feels, moves, or is interacted with**, this Skill should be used.

## Rule Categories by Priority

| Priority | Category | Impact | Domain | Key Checks |
|----------|----------|--------|--------|------------|
| 1 | Accessibility | CRITICAL | `ux` | Contrast 4.5:1, Alt text, Keyboard nav, Aria-labels |
| 2 | Touch & Interaction | CRITICAL | `ux` | Min size 44×44px, 8px+ spacing, Loading feedback |
| 3 | Performance | HIGH | `ux` | WebP/AVIF, Lazy loading, Reserve space (CLS < 0.1) |
| 4 | Style Selection | HIGH | `style`, `product` | Match product type, Consistency, SVG icons |
| 5 | Layout & Responsive | HIGH | `ux` | Mobile-first, Viewport meta, No horizontal scroll |
| 6 | Typography & Color | MEDIUM | `typography`, `color` | Base 16px, Line-height 1.5, Semantic color tokens |
| 7 | Animation | MEDIUM | `ux` | Duration 150–300ms, Motion conveys meaning |
| 8 | Forms & Feedback | MEDIUM | `ux` | Visible labels, Error near field, Progressive disclosure |
| 9 | Navigation Patterns | HIGH | `ux` | Predictable back, Bottom nav ≤5, Deep linking |
| 10 | Charts & Data | LOW | `chart` | Legends, Tooltips, Accessible colors |

## How to Use

### Step 1: Analyze User Requirements

Extract: Product type, Target audience, Style keywords, Stack

### Step 2: Generate Design System (REQUIRED)

```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system [-p "Project Name"]
```

This command searches domains in parallel (product, style, color, landing, typography), applies reasoning rules, and returns a complete design system.

### Step 2b: Persist Design System (Master + Overrides Pattern)

```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system --persist -p "Project Name"
```

Creates `design-system/MASTER.md` and optional page-specific overrides.

### Step 3: Supplement with Detailed Searches

```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<keyword>" --domain <domain>
```

Available domains: product, style, typography, color, landing, chart, ux, google-fonts, react, web, prompt

### Step 4: Stack Guidelines

```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<keyword>" --stack <stack>
```

Available stacks: react, nextjs, vue, svelte, swiftui, react-native, flutter, tailwind, shadcn-ui, html-css

## Example Workflow

**User request:** "Make an AI search homepage."

1. Analyze: Product=Tool, Audience=C-end, Style=modern/minimal/dark, Stack=React
2. Design System: `search.py "AI search tool modern minimal" --design-system -p "AI Search"`
3. Detail: `--domain style "minimalism dark mode"`, `--domain ux "search loading animation"`
4. Stack: `--stack react "list performance navigation"`
5. Implement + Pre-delivery checklist

## Quick Reference

Full detailed rules for all 10 categories covering accessibility, touch interaction, performance, style selection, layout, typography, animation, forms, navigation, and charts/data visualization.

## Output Formats

- `--design-system` supports `-f ascii` (terminal) or `-f markdown` (documentation)
- `--persist` saves design system hierarchically

## Pre-Delivery Checklist

Checks for visual quality, interaction, light/dark mode, layout, and accessibility. Scope: App UI (iOS/Android/React Native/Flutter).

