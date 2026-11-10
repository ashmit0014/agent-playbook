# Agent Playbook

**Operating rules for AI agents (Claude, Claude Code, Codex and others) doing real work with little supervision.** It covers software, research, analysis, writing, planning and audits. The rules are distilled from real projects that failed, were measured and were corrected, not from generic productivity advice.

Website: **https://ashmit0014.github.io/agent-playbook/**

## Start here

| You are… | Do this |
|---|---|
| **Starting a quick task** (one session, low stakes) | Give the agent the [Core](CORE.md): nine principles, about 340 words. After the one-time install below, Claude Code and Codex already have it. In a chat app, paste it, or use the copy button on the [web Core page](https://ashmit0014.github.io/agent-playbook/CORE.html). Nothing else is needed for a quick task. |
| **Starting a serious project** (multi-session, autonomous, irreversible stakes, or others depend on it) | Tell the agent: *"Use the agent playbook to set up this project. Goal: …"*. It reads the three playbook sections it needs, asks you one batch of questions, records a short operating model (three small files, or a notes block in a chat app) and starts on the riskiest part. |
| **Using Claude Code** | After install, type `/agent-playbook <your goal>`, or just describe a serious project and it is picked up automatically. |
| **Using Codex** | After install, type `$agent-playbook <your goal>`, or just describe a serious project. |
| **Using a chat app** (Claude.ai, ChatGPT) | Add [`CORE.md`](CORE.md), [`PLAYBOOK.md`](PLAYBOOK.md) and [`skill/SKILL.md`](skill/SKILL.md) as project files. Then say *"Follow SKILL.md to set up: <goal>"*. The agent cannot write files, so it gives you a "Project notes" block to save in the project instructions, and an updated "State" block at the end of each session to paste over the old one. |
| **Using any other agent** | Put `CORE.md` in its instruction file. For serious work, also give it `skill/SKILL.md`, which tells it when to read which part of `PLAYBOOK.md`. |
| **Wondering why a rule exists** | Read [REFERENCE.md](REFERENCE.md) for the reasoning, the rules it corrected and its limits, and [EVIDENCE.md](EVIDENCE.md) for what each rule rests on. |

## Install (once, Windows PowerShell)

```powershell
git clone https://github.com/ashmit0014/agent-playbook "$HOME\agent-playbook"
& "$HOME\agent-playbook\install.ps1"
```

What it does:
- Installs the `agent-playbook` skill for Claude Code (`~/.claude/skills`) and Codex (`~/.codex/skills`).
- Adds a marked block to `~/.claude/CLAUDE.md` (an import of the Core) and `~/.codex/AGENTS.md` (the Core text), so every new session starts with the Core. Nothing outside the block is touched.
- Adds one read-only permission to `~/.claude/settings.json`, `Read(~/.claude/skills/agent-playbook/**)`, so Claude Code can open the playbook sections without asking each time.
- Skips any tool whose folder (`~/.claude` or `~/.codex`) does not exist.
- Takes effect in new sessions. To check it worked, ask a new session to quote the first principle of the Agent Playbook Core.

Options:
- **Update:** `git pull`, then run `install.ps1` again.
- **Skill only, no always-on Core:** `install.ps1 -NoGlobalCore`.
- **Remove everything it added:** `install.ps1 -Uninstall`.
- **Install somewhere else** (testing, another profile): `install.ps1 -TargetHome <folder>`.

On macOS or Linux, copy the contents of `skill/`, plus `CORE.md` and `PLAYBOOK.md`, into `~/.claude/skills/agent-playbook/` and `~/.codex/skills/agent-playbook/`. Then:
- for Claude Code, add `@~/.claude/skills/agent-playbook/CORE.md` to `~/.claude/CLAUDE.md`;
- for Codex, paste the text of `CORE.md` into `~/.codex/AGENTS.md`.

## What it is, and what it is not

It is a small body of rules about the decisions that most often go wrong when an agent works on its own:
- what counts as evidence that something works;
- what to prove first;
- what to decide alone, and what to bring to the human;
- when to stop iterating;
- how to use other models without mistaking agreement for truth;
- how to keep context useful without rereading everything;
- where to spend expensive reasoning.

It is not a framework, an agent platform, a prompt library or a coding-style guide. Nothing has to be restructured to use it. It does not try to make agents fully autonomous; it tries to put the human exactly where human judgment or authority is needed.

## Layers

Each layer is loaded only when it is needed.

| Layer | Size | Loaded |
|---|---|---|
| [CORE.md](CORE.md) | about 340 words | Always (cheap) |
| [PLAYBOOK.md](PLAYBOOK.md): the operating layer, with decision rules, defaults and stop conditions | about 3,500 words | Three sections at a serious project's kickoff; the others only when their trigger fires |
| [skill/SKILL.md](skill/SKILL.md): when to read what; the project kickoff | about 950 words | When a serious project starts |
| [REFERENCE.md](REFERENCE.md): rationale, the rules it corrected, conditional rules, tests | about 4,700 words | By humans, when a rule is questioned |
| [EVIDENCE.md](EVIDENCE.md): what each rule rests on, measurements, external sources | about 1,500 words | By humans |

There is one source for each rule. The skill, the installer and the website all read these same files, so there are no per-tool copies to drift.

## How rules are labelled and changed

Every rule in the playbook carries a label:
- **Rule:** held across every kind of work in the evidence.
- **Default:** do it unless the situation clearly differs.
- **Current models:** an observation about today's models and tools, expected to go stale as they improve. These are the parts to recheck first when you switch models.
- **Provisional hypotheses** are not in the playbook at all; they are listed in [REFERENCE.md](REFERENCE.md) §7 until evidence promotes or drops them.

A rule changes only on evidence stronger than what supports it now. Each change gets a line in the [CHANGELOG](CHANGELOG.md) and a row in [EVIDENCE.md](EVIDENCE.md). If it overturns an earlier rule, it also gets a row in the corrections table in [REFERENCE.md](REFERENCE.md) §3. Versions are `major.minor`: minor for wording and evidence, major when a Rule changes.

## Provenance

The rules come from seven private projects over about five weeks: games, mobile apps, an image-generation workflow, a data-safety tool and a machine audit. They also draw on token telemetry from 387 agent sessions and on published research on agent instruction files and code review. The public files describe the evidence in anonymized and aggregate form. The underlying records are kept privately.
