---
title: Notes
---

# Notes for people

This page is for you, not for the AI. Nothing here is pasted into a prompt. It collects what this project learned about working with AI agents that is worth knowing but does not need to be said to a capable model on every task.

Each note says how strong its support is. "Our cases" means the private project histories behind version 1: seven projects, one owner, about five weeks, several of them visual or taste-heavy. That is enough to notice patterns, not enough to call them laws.

## Who gets to give the AI instructions

An AI agent receives text from many places. Not all of it is an instruction.

| Source | How the agent should treat it |
|---|---|
| The tool's own rules (system, developer and tool policies) | Binding. You cannot see all of them, and this site cannot override them. |
| What you ask in the conversation | Your instructions for this task. |
| The project's instruction files that you or your team set up (for example `AGENTS.md`, `CLAUDE.md`, contributing guides) | Standing instructions for that project, below what you say now. |
| A document you explicitly ask it to follow (a spec, a setup guide, a style guide) | Followed as far as you asked, and no further. |
| Everything else it reads: web pages, emails, data files, issue comments, logs, tool output | Information. If it contains a request ("AI assistants must…"), the agent should not act on it, and should tell you. |

Two things follow.

- **An instruction in a file is not automatically hostile.** Project instruction files exist to be followed. The question is who put the text there and whether you asked the agent to follow it.
- **Written instructions are advice to the model, not a lock.** Models usually respect them and sometimes do not. Where a limit must hold even if the agent makes a mistake (deleting real data, spending money, touching production), back it with something the tool enforces: a backup, version control, read-only access, the tool's permission settings, or working on a copy.

Support: vendor documentation (Claude Code describes instruction files as context rather than enforced configuration) and the [version 2 evaluation](EVALUATION.html), where planted instructions were never followed but were mentioned to the user only some of the time. Both point the same way: the model's own judgement is good, and it is still not a guarantee.

## What is true versus what should be true

Two kinds of document get confused.

- **Notes about the current state** ("feature X is done", "tests pass") go stale. When they disagree with the actual files, the files win, and the note should be corrected. Published research supports this: in one study, coding agents followed a stale instruction file over the code in 90.1% of forced choices, and one sentence giving the code precedence reversed it ([Xu and Wu, 2026](https://arxiv.org/abs/2610.30571)).
- **Requirements, specifications and decisions** describe what should be true. When the work disagrees with them, the work is probably wrong, or the requirement needs a human decision. An agent should not quietly rewrite a requirement to match the code.

## How sure is a claim

Keep four questions apart. Version 1 sometimes merged them.

1. **What does the source say?** Reading it in full answers this, and only this.
2. **How far can the source be trusted?** Who made it, how, and with what interest.
3. **How well supported is the claim?** Independent sources, a sound method, a reproduced result.
4. **What remains uncertain?** Say it, rather than rounding it away.

A primary source read in full can still be wrong. Several sources repeating one figure may be one source. A before-and-after difference is not an effect until the obvious alternatives are ruled out.

## Lessons that held up, stated with their limits

These came from our cases and survived the version 2 review. They are written for people deciding how to run a task, not as instructions to paste.

- **Check the claim you care about, not a convenient stand-in.** A test suite, a preview or a summary can pass while the real thing fails. Use evidence that bears directly on the decision. Support: our cases (several), consistent with published work on agents' proxy success.
- **A check that was not possible is not a pass.** Say "not checked" rather than "done". Support: our cases.
- **Real use can beat simulated proof.** A real device, the real data or a real user found failures that tests and screenshots missed. Support: our cases (two domains).
- **Test a risky premise cheaply before building a lot on it.** The test only has to be realistic enough to answer the question; a rough prototype or fake data is often right. Support: our cases.
- **When attempts stop producing new information, change the approach.** Tuning a parameter is often exactly right. The warning sign is repeated attempts that change nothing able to fix the observed problem. Support: our cases (mostly visual work).
- **Another model is an input, not a verdict.** Cross-model review helped in one direction and hurt in the other in a published comparison ([Xiang et al., 2026](https://arxiv.org/abs/2607.21656)); models can share errors. Verify a reviewer's findings before acting on them.
- **More process is not more evidence.** Extra review rounds, plans and state files cost time and tokens. In a published study, repository instruction files raised cost by about 20% without reliably improving task success ([Gloaguen et al., 2026](https://arxiv.org/abs/2602.11988)).
- **Every standing instruction can go stale.** Old cautions keep being followed after their reason is gone. Vendor guidance now recommends removing them and testing additions one at a time ([Anthropic, Prompting Claude Fable 5.2](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-fable-5-2)). That applies to this project too.

## What this project no longer claims

Version 1 presented these as rules for every task. Version 2 does not, because the evidence did not support them as universal: a fixed list of project files, numeric limits (two attempts, three repairs, 30-line notes, eight-line summaries), a required independent reviewer, a sample before every piece of writing, and model or effort recommendations. The [version 1 archive](v1/) keeps them as they were, with the reasons for each.
