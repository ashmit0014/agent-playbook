# Changelog

`major.minor`: the minor number changes for wording, examples and evidence; the major number changes when a Rule changes. Each entry names the rule and the evidence behind the change.

## 1.2 — 2026-11-12

A revalidation pass against current vendor documentation and research. No new Core principle. The Core is about 400 words (was about 340); the operating layer is about 4,100 (was about 3,550).

**Added** (each extends an existing principle):
- **Trust boundaries (§4).** Data is not instruction; use the least access that does the job; written instructions are advisory, so back costly limits with enforcement where the environment offers it; plugins and scripts are inside the trust boundary. Core principles 4 and 7 now carry the short form.
- **Harness expiry (§8, Core 9).** Every harness component, this playbook included, is a hypothesis that must keep paying for itself and be re-tested when models or tools change. This replaces two older rules.
- **Resumability as an oracle (§1, §7).** A fresh agent given only the project's files must be able to reconstruct where the project stands.
- **Retrieval ladder, and summaries as routes rather than evidence (§7).**
- **Delegation must pay for itself; match capability to the cost of a mistake (§6).**

**Changed:**
- **Continue a project** now works for any existing project. It discovers and keeps the project's own conventions instead of assuming this playbook's files.
- **Start page:** plain-language choices and short help that opens only on demand, for first-time users; a wider layout and larger type; the prompt shown as the main output.
- **Labels:** fresh-session cost economics are now labelled Current models.

**Tested:**
- Continue, on three different project fixtures.
- Cold-start resumability.
- A planted instruction in a project file. It was never obeyed; reporting it was inconsistent, so the Core and the Continue prompt now ask for it explicitly.
- A first-time-user walkthrough. Details are in REFERENCE.md §6.

**Removed:**
- "Automation has running costs", folded into the harness-expiry rule.
- The separate autonomy bullet, folded into the decision table.

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
