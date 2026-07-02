# fix_codex_font.ps1
# Fix Codex desktop config.toml to use OPPO Sans 4.0 as UI font
# Run this script, then restart Codex for changes to take effect.

$ErrorActionPreference = "Continue"
$ConfigPath = "$env:USERPROFILE\.codex\config.toml"
$FontName   = "OPPO Sans 4.0"
$CodeFont   = "Jetbrains Mono"

Write-Host "=== Codex OPPO Sans Font Fix ===" -ForegroundColor Cyan
Write-Host ""

# ── 1. Check font availability ──────────────────────────────────
Write-Host "[1/4] Checking font availability..." -ForegroundColor Yellow

Add-Type -AssemblyName System.Drawing -ErrorAction SilentlyContinue
$fontAvailable = $false
try {
    foreach ($f in [System.Drawing.FontFamily]::Families) {
        if ($f.Name -eq $FontName) {
            $fontAvailable = $true
            Write-Host "  OK: '$FontName' is registered in Windows" -ForegroundColor Green
            break
        }
    }
}
catch {
    Write-Host "  WARN: Could not query font families via System.Drawing" -ForegroundColor Yellow
}

# Check system fonts directory
$systemFontPath = Join-Path $env:windir "Fonts\$FontName.ttf"
$userFontPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\$FontName.ttf"

if (Test-Path $systemFontPath) {
    Write-Host "  OK: Font file exists in C:\Windows\Fonts" -ForegroundColor Green
}
elseif (Test-Path $userFontPath) {
    Write-Host "  NOTE: Font is installed per-user but not in C:\Windows\Fonts" -ForegroundColor Yellow
    Write-Host "  Codex (Chromium) may not see per-user fonts. Attempting to copy to system fonts..." -ForegroundColor Yellow
    try {
        $shell = New-Object -ComObject Shell.Application
        $fontsFolder = $shell.Namespace(0x14)
        $fontsFolder.CopyHere($userFontPath, 0x0010)
        Write-Host "  OK: Copied font to system fonts directory" -ForegroundColor Green
    }
    catch {
        Write-Host "  WARN: Could not copy to system fonts. Run manually: right-click $FontName.ttf -> Install for all users" -ForegroundColor Yellow
    }
}
else {
    Write-Host "  WARN: $FontName.ttf not found in known locations" -ForegroundColor Red
}
Write-Host ""

# ── 2. Locate config.toml ───────────────────────────────────────
Write-Host "[2/4] Locating Codex config..." -ForegroundColor Yellow

if (-not (Test-Path $ConfigPath)) {
    Write-Host "  ERROR: config.toml not found at $ConfigPath" -ForegroundColor Red
    exit 1
}
Write-Host "  OK: Found $ConfigPath" -ForegroundColor Green
Write-Host ""

# ── 3. Read and analyze config ──────────────────────────────────
Write-Host "[3/4] Analyzing current config..." -ForegroundColor Yellow

$content = Get-Content $ConfigPath -Raw -Encoding UTF8
$changed = $false

# Determine active theme
$theme = "light"
if ($content -match 'appearanceTheme\s*=\s*"dark"') {
    $theme = "dark"
}

$uiTarget  = "'`"$FontName`"'"
$codeTarget = "'`"$CodeFont`"'"

# Helper: check if a section already has correct ui/code values
function Fix-FontSection {
    param([ref]$content, [string]$sectionName)

    $sectionHeader = "[desktop.$($sectionName).fonts]"
    Write-Host "  Checking $sectionHeader ..." -ForegroundColor Gray

    # Does the section exist?
    $sectionPattern = [regex]::Escape($sectionHeader) + '[\r\n]+([^\[]*(?=\[|$))'
    $match = [regex]::Match($content.Value, $sectionPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if (-not $match.Success) {
        Write-Host "    Section not found — will create it" -ForegroundColor Yellow
        # Find the semanticColors section for this theme to insert before
        $semanticHeader = "[desktop.$($sectionName).semanticColors]"
        $newSection = @"
$sectionHeader
code = $codeTarget
ui = $uiTarget

$semanticHeader
"@
        $content.Value = $content.Value.Replace($semanticHeader, $newSection)
        return $true
    }

    $sectionBody = $match.Groups[1].Value
    $originalBody = $sectionBody
    $modified = $false

    # Fix or add code line
    if ($sectionBody -match '^\s*code\s*=') {
        if ($sectionBody -notmatch 'code\s*=\s*''"Jetbrains Mono"''\s*$') {
            $sectionBody = $sectionBody -replace 'code\s*=\s*[^\r\n]*', "code = $codeTarget"
            $modified = $true
            Write-Host "    Fixed 'code' line" -ForegroundColor Green
        }
        else {
            Write-Host "    'code' is already correct" -ForegroundColor Gray
        }
    }
    else {
        # No code line — add it at start of section body
        $sectionBody = "code = $codeTarget`r`n" + $sectionBody
        $modified = $true
        Write-Host "    Added 'code' line" -ForegroundColor Green
    }

    # Fix or add ui line
    if ($sectionBody -match '^\s*ui\s*=') {
        if ($sectionBody -notmatch 'ui\s*=\s*''"OPPO Sans 4\.0"''\s*$') {
            $sectionBody = $sectionBody -replace 'ui\s*=\s*[^\r\n]*', "ui = $uiTarget"
            $modified = $true
            Write-Host "    Fixed 'ui' line" -ForegroundColor Green
        }
        else {
            Write-Host "    'ui' is already correct" -ForegroundColor Gray
        }
    }
    else {
        $sectionBody = $sectionBody.TrimEnd() + "`r`nui = $uiTarget`r`n"
        $modified = $true
        Write-Host "    Added 'ui' line" -ForegroundColor Green
    }

    if ($modified) {
        # Replace section body in full content
        $oldSection = "$sectionHeader`r`n$originalBody"
        $newSection = "$sectionHeader`r`n$sectionBody"
        $content.Value = $content.Value.Replace($oldSection, $newSection)
        return $true
    }

    return $false
}

$lightChanged = Fix-FontSection ([ref]$content) "appearanceLightChromeTheme"
$darkChanged  = Fix-FontSection ([ref]$content) "appearanceDarkChromeTheme"

if ($lightChanged) { $changed = $true }
if ($darkChanged) { $changed = $true }

Write-Host ""
# ── 4. Write changes ────────────────────────────────────────────
Write-Host "[4/4] Applying changes..." -ForegroundColor Yellow

if ($changed) {
    # Backup
    $backupPath = "$ConfigPath.bak"
    Copy-Item $ConfigPath $backupPath -Force
    Write-Host "  Backup saved to $backupPath" -ForegroundColor Gray

    # Write
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($ConfigPath, $content, $utf8NoBom)
    Write-Host "  OK: config.toml updated" -ForegroundColor Green
}
else {
    Write-Host "  OK: No changes needed — config is already correct" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Cyan
Write-Host "Active theme: $theme" -ForegroundColor White
Write-Host ""
Write-Host "IMPORTANT: Fully restart Codex for changes to take effect." -ForegroundColor Magenta
Write-Host "  Right-click taskbar icon -> Quit, then relaunch." -ForegroundColor Magenta
