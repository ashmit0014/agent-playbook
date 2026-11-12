# Changelog

Versions are `major.minor.patch`. **Major:** what the site adds to a prompt changes in a way that needs new evaluation evidence (a paragraph added, removed or reworded). **Minor:** advice, documentation or evaluation results change without changing what is added. **Patch:** fixes that change no wording a user sees in a prompt. The version lives in `additions.json`; the automated checks fail if `_config.yml` or this file disagree with it. Each release is tagged in git (`v2.0.0`, and `v1.0`, `v1.1`, `v1.2` for the archived version 1).

## 2.0.0 — 2026-11-12

A reset. Version 1 was tested against a plain, clear request for the first time, on ten tasks; see [Evaluation](EVALUATION.html). The result changed what the product is.

**What the site does now.** You write your request. If the work will continue in a later session, the site adds one tested paragraph asking the AI to record requirements, decisions, status and the next step. Otherwise it tells you to paste your request as it is. Two other situations (risky files, content from others) show advice for you and add nothing to the prompt.

**Removed from what the AI receives:** the nine-principle Core, the 4,000-word playbook download, the five prompt types, the required project files (`AGENTS.md`, `CLAUDE.md`, `STATE.md`, `DECISIONS.md`), numeric limits, review and sample-first procedures, and model guidance. In the evaluation they raised cost on eight of ten tasks without improving outcomes overall, and failed a creative task.

**Tested and not adopted:** paragraphs for direct verification, evidence handling, continuing existing work, protecting files, and planted instructions. Each either changed nothing measurable or traded quality for length. Their text is in `eval/tasks.py`.

**Moved:** the lessons that held up are in [Notes](NOTES.html), written for people, with their support. The version 1 documents are archived unchanged under [`v1/`](v1/), with a summary of what went wrong.

**Corrected:** v1's summaries of Xiang et al., Gloaguen et al. and CRBugBench (see the [v1 archive](v1/)). The trust model now distinguishes the tool's rules, your instructions, project instruction files you set up, documents you ask it to follow, and everything else.

**Engineering:** the site deploys only through a workflow that first checks that the scripts parse, every combination composes, the generated text matches a reviewed snapshot, removed v1 instructions cannot return, versions agree, the HTML is valid and internal links work. After deploying, it confirms that the live site shows the new commit. The footer shows the version and build commit.

**License:** code under MIT, documentation under CC BY 4.0, paste-able paragraphs under CC0. See `LICENSE`.

**Accessibility:** landmarks, a skip link, labelled navigation with the current page marked, real headings and a fieldset for the form, form borders at 3:1 contrast, keyboard-scrollable tables, and copy results announced to screen readers.

# Version 1 (archived)

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
