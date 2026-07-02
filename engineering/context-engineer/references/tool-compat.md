# Tool Compatibility Guide

This guide explains how to make a Context repo work across different AI coding tools. The central premise: all AI coding tools look for special files in your project to understand context — file names vary but content structure remains consistent.

## Key Points

- **Claude Code** uses `CLAUDE.md` at root and in subdirectories, with auto-loading on navigation. It uniquely supports slash commands via `.claude/commands/`. Root files should stay under 200 lines since content beyond that risks being truncated.

- **Cursor** relies on `.cursorrules` at root for auto-loading. Its AI can read `CLAUDE.md` files but won't auto-load them. There's a character limit for rules files (roughly ~6000 chars), so root configs should be concise, acting as pointers to detailed `CLAUDE.md` indexes.

- **Windsurf** mirrors Cursor's pattern, reading `.windsurfrules` at root with similar length constraints.

- **OpenClaw** is treated like Claude Code for now — using `CLAUDE.md` everywhere — but its behavior may vary by version.

- **Generic/Unknown** tools should default to `CLAUDE.md` as the most portable format.

## Multi-Tool Strategy

For teams using different tools, generate `CLAUDE.md` files everywhere plus a condensed `.cursorrules` at root. The key principle: **Don't duplicate content across config files.** Tool-specific root files should be a concise pointer directing the AI to detailed context files.

## Detection Order

1. Check for `.claude/`
2. Check for `.cursor/`
3. Check for `.windsurfrules`
4. Check for `.cursorrules`
5. Ask the user if nothing is detected

When multiple signals exist, ask for the primary tool but generate compatible files for all detected tools.

## Compatibility Matrix

| Tool | Root Index | Directory Indexes | Config File |
|---|---|---|---|
| Claude Code | `CLAUDE.md` | `CLAUDE.md` in each dir | `.claude/settings.json` |
| Cursor | `.cursorrules` | `CLAUDE.md` (readable by Cursor too) | `.cursor/rules` |
| Windsurf | `.windsurfrules` | `CLAUDE.md` | — |
| OpenClaw | `CLAUDE.md` | `CLAUDE.md` | — |
| Generic | `CLAUDE.md` | `CLAUDE.md` | — |
