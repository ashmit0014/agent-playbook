---
name: agent-playbook
description: Operating playbook for substantial or autonomous AI work of any kind (software, research, analysis, writing, planning, audits). Use when the user starts or sets up a new project or long task, says "use the playbook" or "set up the operating model", or when the work needs it mid-task — a review, a failure-to-converge loop, an irreversible operation, grading evidence. Not needed for small one-step tasks; the Core principles cover those.
---

# Agent Playbook

This skill gives you the Agent Playbook without loading all of it up front.

**Files in this folder**

| File | What it is | When to read it |
|---|---|---|
| `CORE.md` | Nine principles, about 340 words | Now, unless your instructions already contain a block starting "Agent Playbook — Core" |
| `PLAYBOOK.md` | The operating detail, about 3,500 words in nine sections | §1, §2 and §4 at a serious project's kickoff. Any other section only when its trigger fires (§3 below) |
| `templates/` | Project files | At kickoff only |

The rationale and evidence are not bundled. If the user asks why a rule exists, point them to https://ashmit0014.github.io/agent-playbook/REFERENCE.html.

## 1. Size the task

**Quick task.** One session, reversible, nobody else depends on the result. Apply the Core and do the work. Do not create files and do not read `PLAYBOOK.md`. Stop reading this skill here.

**Serious project.** Any one of these is enough:
- it will span several sessions;
- it will run autonomously for hours;
- it touches irreversible things such as real data, money, publishing or production;
- its result matters to people other than the user;
- the user says it is serious, or asks you to set up a project with the playbook.

Do the kickoff below.

If you are unsure, treat it as quick and upgrade when one of the conditions appears.

## 2. Kickoff, for serious projects only

1. Read `PLAYBOOK.md` §1 (the promise and its oracle), §2 (sequencing) and §4 (deciding versus asking).
2. From the user's goal, draft the operating model. Keep each item short, and use plain words if the user is not technical. For example, say "how we will check the answer is right" rather than "oracle".
   - **Promise:** what must be true at the end, in the user's terms.
   - **Oracle:** what will show the promise is true, for each part. Note the proxies to distrust.
   - **Load-bearing risk:** the single thing that, if it fails, makes the rest worthless. What is its smallest real proof?
   - **Ownership:** what you decide alone. What the human owns: taste, real-world use, authority, criteria. Where the human gates are.
   - **Irreversible operations,** and how each will be rehearsed.
   - **Stop triggers** specific to this work, written as changes of source, not as more attempts.
3. Ask the human **one batch** of questions, and only for facts they alone hold: constraints, thresholds, risk appetite, references, access, budget, how often they want check-ins. Put your proposed default next to each question. Do not ask what you can find out yourself.
4. In the same turn, record the operating model, with `TODO(human)` wherever you need an answer.
   - **If you can write files** (Claude Code, Codex, other coding agents), use the files in `templates/`:
     - `AGENTS.md`: the project's operating file.
     - `STATE.md`: current state, kept to about 30 lines and overwritten.
     - `DECISIONS.md`: one line per decision, plus abandoned approaches.
     - Only if you are Claude Code, also create `CLAUDE.md` whose only line is `@AGENTS.md`.
     - If the project already has these files, add a short "Operating model" section instead of replacing them.
     - For non-code work, keep the files beside the work.
   - **If you cannot write files** (a chat app):
     - put the same content in your reply as one block of text headed "Project notes", and ask the user to save it in the project's instructions or a pinned note;
     - at the end of each session, print an updated "State" block for them to paste over the old one;
     - never mention CLAUDE.md.
5. Start on the load-bearing risk, with any work that does not depend on the answers. Stop before work that does.

Do not copy the playbook into the project. The project files hold only what is specific to this project.

## 3. During the work: open the section the moment its trigger fires

| Trigger | Read |
|---|---|
| Deciding whether something counts as done or verified | `PLAYBOOK.md` §1 |
| Before a destructive or irreversible step | §2 |
| A taste, naming or preference decision; producing creative work | §3 |
| Unsure whether to ask the human or decide yourself | §4 |
| A second attempt has failed, or progress shows up only in metrics or explanations | §5 |
| Before asking another model or agent to review, research or work in parallel | §6 |
| State is getting long, or a session keeps regrowing its context | §7 |
| Choosing a model, effort level or tool; tempted to build process | §8 |
| Writing up research, analysis or a report; labelling how sure a claim is; a causal "why" or "how much is due to" question | §9 |

## 4. Every session of a serious project

- **At the start:** read `STATE.md`, or the notes the user pasted, including the human's latest verdict. If there are none, ask for them. Trust the artifact over the document when they disagree.
- **At the end:** update `STATE.md`, or print the updated State block, covering what is done, what is verified and how, what is not verified, what is next, and what you need from the human. Add any decision a later session might otherwise reopen to `DECISIONS.md`.
