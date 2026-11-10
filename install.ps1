<#
.SYNOPSIS
  Installs the Agent Playbook for Claude Code and Codex. Run it again after `git pull` to update.

.DESCRIPTION
  Copies the playbook skill (SKILL.md, CORE.md, PLAYBOOK.md, templates) to:
    ~/.claude/skills/agent-playbook   (Claude Code: /agent-playbook)
    ~/.codex/skills/agent-playbook    (Codex: $agent-playbook)
  and, unless -NoGlobalCore is given, makes the ~340-word Core always available:
    ~/.claude/CLAUDE.md  gets one import line inside a marked block
    ~/.codex/AGENTS.md   gets the Core text inside a marked block
  For Claude Code it also adds one read-only permission to ~/.claude/settings.json,
    Read(~/.claude/skills/agent-playbook/**), so sessions can open PLAYBOOK.md without a prompt.
  Everything outside the marked blocks is left untouched. -Uninstall removes exactly what this script added.

.EXAMPLE
  ./install.ps1
  ./install.ps1 -NoGlobalCore
  ./install.ps1 -Uninstall
#>
param(
  [switch]$NoGlobalCore,
  [switch]$Uninstall,
  [string]$TargetHome = [Environment]::GetFolderPath('UserProfile')
)
$ErrorActionPreference = 'Stop'
$src = $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)
$begin = '<!-- agent-playbook:begin (managed by agent-playbook/install.ps1; edit outside this block) -->'
$end = '<!-- agent-playbook:end -->'

function Set-Block([string]$file, [string]$body) {
  $text = if (Test-Path $file) { [IO.File]::ReadAllText($file) } else { '' }
  $pattern = '(?s)\r?\n?' + [regex]::Escape('<!-- agent-playbook:begin') + '.*?' + [regex]::Escape($end) + '\r?\n?'
  $text = [regex]::Replace($text, $pattern, "`n").TrimEnd()
  if ($body) {
    $block = "$begin`n$body`n$end"
    $text = if ($text) { "$text`n`n$block" } else { $block }
  }
  if (-not $text -and -not $body) { if (Test-Path $file) { Remove-Item $file }; return }
  $dir = Split-Path $file
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  [IO.File]::WriteAllText($file, $(if ($text) { "$text`n" } else { '' }), $utf8)
}

# Claude Code asks permission to read files outside the project; allow reading this skill's own folder only.
$readRule = 'Read(~/.claude/skills/agent-playbook/**)'
function Set-ReadAllow([string]$file, [bool]$add) {
  if (-not (Test-Path $file)) { if (-not $add) { return }; [IO.File]::WriteAllText($file, '{}', $utf8) }
  $json = [IO.File]::ReadAllText($file)
  $s = if ($json.Trim()) { $json | ConvertFrom-Json } else { New-Object psobject }
  if (-not $s.PSObject.Properties['permissions']) { $s | Add-Member permissions (New-Object psobject) }
  $p = $s.permissions
  $allow = @(); if ($p.PSObject.Properties['allow']) { $allow = @($p.allow) }
  $allow = @($allow | Where-Object { $_ -ne $readRule })
  if ($add) { $allow += $readRule }
  if ($p.PSObject.Properties['allow']) { $p.allow = $allow } else { $p | Add-Member allow $allow }
  if (-not $add -and $allow.Count -eq 0) { $p.PSObject.Properties.Remove('allow') }
  if (-not $add -and @($p.PSObject.Properties).Count -eq 0) { $s.PSObject.Properties.Remove('permissions') }
  [IO.File]::WriteAllText($file, ($s | ConvertTo-Json -Depth 32), $utf8)
}

$tools = @(
  @{ Name = 'Claude Code'; Root = Join-Path $TargetHome '.claude'; Global = 'CLAUDE.md' },
  @{ Name = 'Codex';       Root = Join-Path $TargetHome '.codex';  Global = 'AGENTS.md' }
)
$core = [IO.File]::ReadAllText((Join-Path $src 'CORE.md')).Trim()

foreach ($t in $tools) {
  $skillDir = Join-Path $t.Root 'skills/agent-playbook'
  $globalFile = Join-Path $t.Root $t.Global
  if ($Uninstall) {
    if (Test-Path $skillDir) { Remove-Item -Recurse -Force $skillDir }
    if (Test-Path $globalFile) { Set-Block $globalFile '' }
    if ($t.Name -eq 'Claude Code') { Set-ReadAllow (Join-Path $t.Root 'settings.json') $false }
    Write-Host "Removed from $($t.Name)."
    continue
  }
  if (-not (Test-Path $t.Root)) { Write-Host "Skipped $($t.Name): $($t.Root) not found."; continue }

  if (Test-Path $skillDir) { Remove-Item -Recurse -Force $skillDir }
  New-Item -ItemType Directory -Force $skillDir | Out-Null
  Copy-Item (Join-Path $src 'skill/SKILL.md') $skillDir
  Copy-Item -Recurse (Join-Path $src 'skill/templates') $skillDir
  Copy-Item (Join-Path $src 'CORE.md'), (Join-Path $src 'PLAYBOOK.md') $skillDir
  $rev = ''
  try { $rev = (git -C $src rev-parse --short HEAD 2>$null) } catch {}
  if ($t.Name -eq 'Claude Code') { Set-ReadAllow (Join-Path $t.Root 'settings.json') $true }
  [IO.File]::WriteAllText((Join-Path $skillDir 'VERSION'), "installed $(Get-Date -Format yyyy-MM-dd) from $src $rev`n", $utf8)

  if ($NoGlobalCore) {
    if (Test-Path $globalFile) { Set-Block $globalFile '' }
  } elseif ($t.Name -eq 'Claude Code') {
    Set-Block $globalFile "@~/.claude/skills/agent-playbook/CORE.md`nFor substantial or multi-session work, use the agent-playbook skill."
  } else {
    Set-Block $globalFile "$core`n`nFor substantial or multi-session work, use the agent-playbook skill (`$agent-playbook)."
  }
  Write-Host "Installed for $($t.Name): $skillDir$(if (-not $NoGlobalCore) { " (+ Core in $globalFile)" })"
}
$global:LASTEXITCODE = 0
