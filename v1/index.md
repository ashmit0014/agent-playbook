---
title: Version 1 archive
---

# Version 1, and why version 2 replaced it

Version 1 (1.0 to 1.2, November 2026) was a set of operating rules for AI agents, drawn from seven real projects where agents went wrong. It had a nine-principle Core pasted into every prompt, a 4,000-word playbook, five kinds of prompt, and a set of project files the agent was told to create.

The documents are kept exactly as published:

- [Core](CORE.html): the nine principles included in every v1 prompt
- [Playbook](PLAYBOOK.html): the operating detail
- [Reference](REFERENCE.html): why each rule existed, and the corrections made along the way
- [Evidence](EVIDENCE.html): what each rule rested on

The exact files, including the v1 prompt builder, are in the git tags [`v1.0`](https://github.com/ashmit0014/agent-playbook/tree/v1.0), [`v1.1`](https://github.com/ashmit0014/agent-playbook/tree/v1.1) and [`v1.2`](https://github.com/ashmit0014/agent-playbook/tree/v1.2).

## What went wrong

Two independent reviews in November 2026 listed about 300 problems. Most came from a few causes.

1. **The product was the wrong shape.** Version 1 turned every useful lesson into an instruction the AI had to carry on every task. A one-line bug fix received about 450 words of methodology. The five prompt types mixed different things (how long the task is, whether it is new, what kind of work it is), so most real tasks fitted none of them cleanly.
2. **It was never compared with a plain request.** Version 1 was tested on whether agents could follow it, not on whether following it produced better work. When version 2 ran that comparison, the v1 prompts cost more on almost every task and did clearly worse on creative writing, where the agent stopped to ask questions the request had already answered.
3. **One owner's lessons were stated as general rules.** The evidence came from seven projects by one person, several of them visual work with a very high quality bar. Lessons such as "show a sample before producing the whole thing" were right for those projects and wrong as a default for everyone.
4. **Different questions were merged.** Instructions in a project file and instructions planted in a web page were both called "data". Notes about the current state and requirements about the desired state were both ranked below the artifact. Having read a source and the claim being true were both called "verified".
5. **It prescribed structure instead of outcomes.** Every new project got the same files (`AGENTS.md`, `STATE.md`, `DECISIONS.md`), whether or not it needed them and whether or not similar files already existed.
6. **Nothing removed rules.** Numeric limits that the reference said had been dropped (two attempts, three repairs, 30-line notes) were back in the operating layer, and the size limits the project set itself had been exceeded. The playbook was accumulating the stale instructions it warned against.
7. **The engineering did not match the claims.** A syntax error in the prompt builder reached the live site. There were no automated checks, versions were copied by hand into several files, and the license said "all rights reserved" while the site said "copy this".

## What survived

The lessons themselves were mostly sound. They moved to [Notes](../NOTES.html), written for people, with their support stated. One of them, recording what a later session needs, earned a place as a paragraph the AI can receive, because it changed the outcome in the [evaluation](../EVALUATION.html). Everything else is no longer sent to the AI.

## Corrections to version 1's evidence

- **Xiang et al. (2026).** Version 1 said "a reviewer allowed to rewrite reduced the pass rate". The paper found an asymmetry: one model reviewing the other's code raised the pass rate (71.6% to 89.7%), and the reverse lowered it (91.4% to 82.8%). The authors say rewriting is their interpretation, not something they measured.
- **Gloaguen et al. (2026).** Version 1's summary was accurate but incomplete. Developer-written instruction files beat generated ones, but neither beat having no file by a statistically significant margin, and both raised cost.
- **CRBugBench (2026).** "A misleading author description misled every model" describes one qualitative example in the paper, not a measured effect across the benchmark.
- **Vendor memory documentation and Hacker News threads** were cited without links or dates. Version 2 does not rely on them.
