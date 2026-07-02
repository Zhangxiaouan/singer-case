---
name: codex-oppo-sans
description: This skill should be used when the user asks to "set Codex font to OPPO Sans", "configure Codex UI font", "change Codex font to OPPO Sans 4.0", "fix Codex font not applying", or "apply OPPO font to Codex". It ensures OPPO Sans 4.0 is correctly configured as the UI font in the Codex desktop application on Windows.
---

# Codex OPPO Sans Font Configuration

## Purpose

Fix and correctly configure OPPO Sans 4.0 as the UI font in the OpenAI Codex desktop application on Windows. Codex is a Chromium-based app, and its font settings in `config.toml` must use CSS-compatible quoting for font family names that contain spaces.

## Problem Background

Configuring a custom UI font in Codex fails silently when:

1. **CSS quoting bug** — `ui = "OPPO Sans 4.0"` is parsed by TOML as a bare string, and the space-separated font name breaks in CSS `font-family`. The correct value is `'"OPPO Sans 4.0"'`.
2. **Dark theme not configured** — Most users run Codex in dark mode (`appearanceTheme = "dark"`), but the dark theme's `fonts` section is often empty, leaving the UI font at the system default.
3. **Font not installed system-wide** — Codex's Chromium engine only discovers fonts from `C:\Windows\Fonts`, not user-level font directories like `%LocalAppData%\Microsoft\Windows\Fonts`.

## When to Use This Skill

Use this skill when:
- The user explicitly asks to configure Codex's font to OPPO Sans
- The user reports that the OPPO Sans font setting in Codex is not taking effect
- The user wants to verify or repair Codex font configuration

## Required Information

- Codex config file: `%USERPROFILE%\.codex\config.toml`
- Font file: `C:\Users\<user>\AppData\Local\Microsoft\Windows\Fonts\OPPO Sans 4.0.ttf`
- System fonts directory: `C:\Windows\Fonts`

## Procedure

### Step 1: Run the Fix Script

Execute the bundled PowerShell script to automatically diagnose and fix the configuration:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "<skill-dir>\scripts\fix_codex_font.ps1"
```

The script performs these checks and fixes in sequence:

1. **Verifies font availability** — Checks that OPPO Sans 4.0 is registered in Windows (user or system level)
2. **Checks system fonts directory** — Verifies the font exists in `C:\Windows\Fonts` or attempts to install it there
3. **Reads config.toml** — Locates and parses the Codex desktop configuration
4. **Fixes light theme fonts** — Ensures `[desktop.appearanceLightChromeTheme.fonts]` has:
   ```toml
   code = '"Jetbrains Mono"'
   ui = '"OPPO Sans 4.0"'
   ```
5. **Fixes dark theme fonts** — Ensures `[desktop.appearanceDarkChromeTheme.fonts]` has the same values
6. **Reports changes** — Shows which sections were modified

### Step 2: Verify Config Manually (if preferred)

If the script cannot be run, manually inspect and edit `%USERPROFILE%\.codex\config.toml`:

Check the active theme (`appearanceTheme` under `[desktop]`) and verify that the corresponding `fonts` section has the correct values:

```toml
[desktop.appearanceLightChromeTheme.fonts]
code = '"Jetbrains Mono"'
ui = '"OPPO Sans 4.0"'

[desktop.appearanceDarkChromeTheme.fonts]
code = '"Jetbrains Mono"'
ui = '"OPPO Sans 4.0"'
```

The critical detail: the TOML string value must itself contain double quotes around the font name, producing `"OPPO Sans 4.0"` in the rendered CSS. Without the inner quotes, the spaces in `OPPO Sans 4.0` cause the CSS `font-family` to parse it as three separate generic family names.

### Step 3: Restart Codex

Font configuration changes take effect only after a complete restart of the Codex application:

1. Fully exit Codex (right-click taskbar icon → Quit, or use the app menu)
2. Verify no Codex processes remain running
3. Launch Codex again

## Common Issues

| Symptom | Cause | Fix |
|---------|-------|-----|
| Font still shows as Microsoft YaHei / Source Han Sans | Dark theme fonts section is empty | Run fix script or manually add fonts to `[desktop.appearanceDarkChromeTheme.fonts]` |
| Font name shows but renders default | Missing CSS quotes around font name | Change `"OPPO Sans 4.0"` to `'"OPPO Sans 4.0"'` |
| Font not found | Font only installed per-user, not system-wide | Install font to `C:\Windows\Fonts` (run font file → "Install for all users") |
| Changes don't take effect | Codex not restarted | Fully quit and relaunch Codex |

## Script

The bundled script `scripts/fix_codex_font.ps1` performs all checks and fixes automatically. It is designed to be idempotent — running it multiple times is safe.
