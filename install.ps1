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
