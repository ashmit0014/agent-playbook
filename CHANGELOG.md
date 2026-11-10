# Changelog

`major.minor`: the minor number changes for wording, examples and evidence; the major number changes when a Rule changes. Each entry names the rule and the evidence behind the change.

## 1.1 — 2026-11-11

The playbook is now used through explicit, copyable prompts. Nothing is installed.
- The website's front page is a prompt builder. Pick the kind of work (quick task, new project, research or analysis, writing or creative, continue a project) and where you will paste it (an agent working in a folder, or a chat app), optionally type the goal, and copy the prompt. Any file the prompt needs is listed with a download button.
- Removed the Claude Code and Codex skill and the global installer. Hidden background loading made it unclear what the agent actually had, and debugging it cost more than it saved.
- No rule in the playbook changed.

## 1.0 — 2026-11-11

First public version.
- **Synthesized** from seven projects, token telemetry and external research. See [REFERENCE.md](REFERENCE.md) §1.
- **Tested before release:**
  - a blind usability review across four unrelated tasks, which added generative-task, unreachable-oracle, contested-claim, irreversible-operation and short-task handling;
  - a 20-claim fact-check against the primary records;
  - live checks that Claude Code and Codex load the Core and find the skill;
  - fresh-agent onboarding tests of three paths: a quick task, a serious software project in Codex, and an analysis task in a chat app. These added the no-files chat mode, section-by-section loading at kickoff, guidance for causal questions, and fixes to the install docs.
