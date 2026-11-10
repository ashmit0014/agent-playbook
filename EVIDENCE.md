# Agent Playbook — Evidence

*v1.0 · 2026-11-11*

What each part of the playbook rests on, and how much weight each kind of support deserves. The cases (A–G) are described in [REFERENCE.md](REFERENCE.md) §1.

**What is public and what is not.** The project records, session transcripts, extraction notes and measurement scripts behind this file are private. They contain unpublished projects, personal history and machine details. The public version keeps:
- the kind of evidence behind each rule;
- the cases it came from;
- aggregate measurements;
- links to external sources.

Nothing here is invented to fill a gap left by private material. Where a rule rests only on private project evidence, it says so.

## Evidence types

| Code | Meaning | Weight |
|---|---|---|
| **P** | Direct project evidence: what happened in a case, from its records and history | Strong for "this happened"; one case is still one case |
| **O** | The owner's own verdicts and corrections | Authoritative for that owner's preferences; not universal |
| **M** | Measured: token telemetry, counts, drills, re-runs | Strong for what was measured |
| **X** | External source read in full | As strong as the source; see the grade given |
| **X-part** | External source partly read, or self-reported practitioner account | Plausible support only |
| **V** | Vendor documentation | Strong for how a tool behaves on that date; can go stale |
| **I** | Inference made while synthesizing | Weakest; never the only support for a Rule |

A **Rule** in the playbook has P or M support from more than one kind of work, or a single catastrophic and cheap-to-prevent case. A **Default** has support from one domain, or graded external support. **Current models** items describe today's model behaviour.

## Rule → evidence

| Playbook | Rule | Support | Cases |
|---|---|---|---|
| §1.2 | Check at the level of the claim | P, M, X | B, C, D, G; external engine test suite |
| §1.2 | Trust the real oracle over the proxy | P | A |
| §1.4 | Absence is not zero | P | A, E |
| §1.5 | Never present a stand-in as the oracle | P, O | E |
| §1.6 | Keep categories apart (proposed / executed / judged; integrity ≠ quality) | P | F |
| §2.1 | Load-bearing risk first, smallest, final form | P | D (decisive), B, C |
| §2.2 | No breadth before the core passes; re-test after a negative verdict | P, O | B, C, D |
| §2.3 | Independent risks on separate tracks | P | E (correction of D's rule) |
| §2.4 | Freeze criteria and predictions before evidence | P | A |
| §2.5 | Smallest experiment that could change a decision | P | F |
| §2.6 | Make destructive changes recoverable | P, M | B (one catastrophic case) |
| §2.7 | Rehearse irreversible operations; go/no-go | I, P | Added after the blind review; consistent with A and G |
| §3.1–3.2 | Ownership by demonstrated capability; current models weak at originating taste | P, O, X-part | B, C, D, E, F; practitioner reports |
| §3.2 | Models critique better than they generate | P | E |
| §3.4 | Lessons as ownership, not medium bans | P | D → E recurrence |
| §3.6 | Generate and self-revise; the human gives the final taste verdict | I | Blind review |
| §4 | Agent owns how, human owns what counts; repair within a bound | P | F (both directions), E |
| §4 | Uncertainty is not a reason to ask; ask for human-held facts once | O | A, E, G |
| §4 | Explicit stop is absolute | O | B, C, D, E |
| §4 | Real devices: precondition before every action | P | D (two incidents) |
| §5 | Non-convergence signals; change the source, not the parameters | P | D, E, F |
| §5 | Compare with the best so far and the external bar | P, O | D, E, F |
| §5 | The variable must be able to answer the latest complaint | P | D |
| §6.1 | Another model is not a truth source; agreement on taste is weak | P, X | D, E; external correlated-error studies |
| §6.2 | Review packet without rationale | X, P | External anchoring result; D |
| §6.3 | Reproduce every finding; reviewer reports, owner edits | P, M, X | A, E; external rewrite study |
| §6.4 | Second family in risk areas; third rarely pays | P, X | E; external review studies (low–medium) |
| §6.5 | High-yield uses: spec review, fix verification, static read | P | A, B |
| §7 | Cost is calls × context; fresh at milestones or on regrowth | M | Claude Code and Codex telemetry |
| §7 | Human's verdict verbatim; record abandoned approaches | P, X-part | D; external compaction report |
| §7 | Artifact outranks document; one current statement | P, M | F, G |
| §7 | Load by when it must hold; length is not the variable | X, V | External instruction-file study; vendor docs |
| §8 | Build tooling after the step proves itself; delete theatre | P, O, M | A, D, E, F |
| §9 | Model memory is Plausible at best | P, V | E, F |
| §9 | Snippet ≠ read source; trace claims to their origin | P, I | E; blind review |
| §9 | Never grade your own subjective output; short rationale | P, O | D, E |

## Measurements

**Claude Code, 16 sessions across the cases:**
- median context per call 160–440k tokens, maximum about 960k;
- fresh sessions start at about 75–110k;
- output is 0.3–1.6% of tokens processed; the rest is rereading context.

**Codex, 371 sessions:**
- the largest thread lineage reached about 1.2B cumulative input over about a week, 98% of it cached;
- about 49 compactions, with context averaging about 424k before each and about 72k after;
- one weekly allowance was used up in about 33.5 hours.

**Review yield:**
- Case E core logic: 8 of 8 findings reproduced.
- Case E storage: 6 of 7 from one family and 6 of 8 from the other were reproduced or fixed, with only 3 overlapping.
- Case B fix verification: 8 of 11 claimed fixes were partial.
- Case A: about 33 findings across four bounded cycles.

**Documentation words per line of code:** about 3 in the surviving case versus about 7–10 in the two longest failures. Counts vary by about 10% depending on which files are counted.

**Fact-check of the synthesis:** 20 claims checked against primary sources; 13 verified, 1 wrong, 1 mis-sourced, 5 overstated, all corrected.

## External sources

These were read during the research on 2026-11-10; the grades are those recorded then. The links have not been re-checked since. Where a source is graded low, the playbook uses it only as support for a Default.

| Source | Used for | Grade |
|---|---|---|
| Gloaguen et al., *Evaluating AGENTS.md* (v3), [arXiv 2602.11988](https://arxiv.org/html/2602.11988v3) | Instruction files: no significant gain in task resolution, about 20% higher cost, no clear length effect; developer-written beat generated | Full read; medium |
| Lulla et al., [arXiv 2601.20404](https://arxiv.org/html/2601.20404v2) | Curated instruction files cut runtime; correctness not measured (counter-evidence) | Full read |
| Song, [arXiv 2610.01471](https://arxiv.org/html/2610.01471v2) | One same-model plus one cross-model review beat two same-model reviews on planted errors; a third reviewer added little | Full read; single author, low–medium |
| Xiang et al., [arXiv 2607.21656](https://arxiv.org/html/2607.21656v1) | A reviewer allowed to rewrite reduced the pass rate | Full read; medium |
| CRBugBench, [arXiv 2610.13668](https://arxiv.org/html/2610.13668v1) | Review ensembles give modest gains at high cost; a misleading author description misled every model | Full read |
| Kim et al., [arXiv 2506.07962](https://arxiv.org/html/2506.07962v1) | Models from different providers share errors | Full read |
| Anthropic, [Building a C compiler](https://www.anthropic.com/research/building-c-compiler) | Long autonomous work succeeded where a human built and reworked the verifiers | Vendor report |
| Anthropic, [Effective context engineering for AI agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) | Context as a finite resource; progressive disclosure | Vendor |
| Claude Code docs: [memory](https://code.claude.com/docs/en/memory), [what survives compaction](https://code.claude.com/docs/en/context-window.md#what-survives-compaction), [skills](https://code.claude.com/docs/en/skills.md) | What is always loaded, what is re-read after compaction, what loads on demand | Vendor; checked 2026-11-10 |
| Practitioner threads (Hacker News, Reddit) on agent-built software, self-scored UI, long-running goals and review loops | Patterns consistent with the cases; never the only support for a Rule | Self-report; partial to full reads |

## Known gaps

- **Cases B and C** have no full postmortems; their lessons come from status files, notes and short records.
- **Case A** has no product outcome yet. Its value is in the shape of its process.
- **Case E's restart** has one working session of evidence.
- **One owner.** The taste-related rules may partly reflect one owner with a professional-designer bar.
- **Telemetry** counts tokens processed, not money.
