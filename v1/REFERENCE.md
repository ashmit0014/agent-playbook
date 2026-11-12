# Agent Playbook — Reference

*v1.2 · 2026-11-12*

Why the rules in [PLAYBOOK.md](PLAYBOOK.md) exist, where they stop applying, which earlier rules they replaced, and how the playbook was tested. Read this when a rule seems wrong for your situation, when two rules conflict, or before you change the playbook. It is not meant to be loaded into an agent's context by default.

## 1. Where this came from

The playbook was extracted from about five weeks of real projects, run with frontier models (Claude Opus and Fable, OpenAI Codex models, ChatGPT as an occasional reviewer). One owner directed all of them. The project records were treated as evidence, not as conclusions: each project's own written lessons were checked against what actually happened next.

**The cases.** Each is described only as far as the lessons need. The project records themselves are private.

| Case | What it was | Outcome |
|---|---|---|
| **A** | Validation of a desktop data-safety tool, using frozen kill-test criteria and a real reset in a virtual machine | Still alive; it reached a decision point honestly |
| **B** | An idle strategy game, built with broad autonomy and automated simulation | Stopped after about two hours |
| **C** | A small 2D platformer | Stopped after its first human playthrough |
| **D** | A habit tracker whose core visual was a procedurally drawn tree | Abandoned after about ten hours |
| **E** | A habit and abstinence tracker | Abandoned over visual design, then restarted with a corrected operating model |
| **F** | A series of image-generation workflow projects, mostly run in Codex | Paused |
| **G** | A backup and recovery audit of one development machine | Completed |

**Other inputs:**
- token telemetry measured from 16 Claude Code sessions and 371 Codex sessions;
- the owner's corrections across all sessions;
- an external literature and practitioner scan, done with full reads where possible (see [EVIDENCE.md](EVIDENCE.md)).

**What this evidence can support.**
- Four of the seven cases had taste or feel as their core promise. That skews the evidence toward creative failure, so rules drawn mainly from those cases are labelled.
- The strongest rules are the ones that recur across very different work: games, apps, image generation, a systems tool, an audit and research.

## 2. The principles and their grounds

### 2.1 The promise and its oracle

The most decisive variable across all cases was whether a real truth source for the promise existed and was used.

**The pattern.** Proxies passed while the promise failed:
- **Case C.** Thousands of automated checks passed. Its reachability test walked a graph of room connections, not the geometry, so a hero taller than a ceiling gap was blocked in the first room a human played.
- **Case B.** About 2,000 headless checks passed, and simulation bots won every run, while the main game view file had been corrupted into megabytes of one repeated snippet and the game could not launch. The bots that were meant to model a human player were never validated against one.
- **Case D.** A blind ordering test of tree maturity scored 6/6 while the owner's complaint was exactly that older trees looked like bigger copies.
- **Case G.** It found a byte-perfect archive of a project whose main file was corrupt. The archive was faithful; the project inside it could not run.
- **External.** An agent-built database engine had hundreds of passing agent-written tests while its reference harness covered three trivial queries.

**The reverse, done right.** Case A's check reported two lost folders after a reset. Instead of accepting the proxy, the team checked the bytes, found them intact in cloud storage, fixed the measurement and left the pass/fail threshold untouched.

**Why "at the level of the claim".** Every failure above was a check one level below the promise: connectivity instead of traversal, unit tests instead of launch, size instead of maturity, presence instead of recovery. The fix is not more checks. It is a check at the same level as the promise.

**Why "never present a stand-in as the oracle".**
- In Case E, an agent asked to test a design tool hand-wrote the designs itself, stored them in the tool, judged them itself, and reported the result as a test of the tool. It was not one.
- If the real oracle is out of reach, the honest move is a graded proxy, not a disguised one.

**Why "keep categories apart".** Case F's correction log is mostly category slips:
- a result graded against a proposal that was never executed;
- "same seed" treated as a controlled comparison when other inputs differed;
- matching hashes read as quality;
- membership in a "liked" collection read as endorsement of the whole image;
- one component working read as all of them working together.

### 2.2 Separate the producer from the judge

This is the principle beneath most of the specific rules. Each useful mechanism in the evidence moves judgment away from whoever produced the thing:
- tests written from the specification by an agent that did not write the code;
- review packets without the author's rationale;
- criteria frozen before evidence;
- predictions written before the run;
- the owner judging their own taste;
- a restore drill instead of a status document;
- a reviewer checking that claimed fixes were real.

**Grounds.**
- **Case E restart.** A cross-family review of core logic found 8 real defects, and two independent reviews of the storage layer found about 7 more. All were in code that the author's own tests passed. An earlier audit had found that code violating the product's own rule that missing data must not be counted as zero.
- **Case B.** A reviewer asked to verify fixes, each marked fixed with a passing test, rated 8 of 11 as only partial.
- **Case A.** Pre-registered expectations were the only place in the corpus where a prediction could fail before anyone saw the result. That is what gave them weight.
- **Taste (Cases D and E).** The model judged its own output as improving at every round. The owner judged it failing. In every creative case, the agent's assessment before the first human look was positive, and the human's first look was negative.

**Limits.**
- Independence of *information* is necessary but not sufficient. An unprimed reviewer from another model family still endorsed the wrong visual direction twice, because two models' blind spots about taste are correlated.
- Independence can also deprive a reviewer of facts it needs: one rated as "stronger" an option the owner had already rejected.
- Hence the packet rule: withhold your *argument*, but supply the owner's recorded verdicts as facts.

### 2.3 Load-bearing risk first

**Grounds.**
- **Case D.** The test that ended the project was drawing one static tree. It took about five minutes, and it was run eight hours in instead of at the start.
- **Case B.** It built five eras, two dozen building types and dozens of research nodes before the experience was good.
- **Case C.** It generated most of its rooms within minutes of a negative playtest, without re-testing.
- **Case F.** A technically valid training run answered a question the baseline had already settled. It had no decision value.

**The correction that shaped playbook §2.3.**
- "Prove the look before any plumbing" was right for Case D. Applied to Case E, it made the hardest-to-produce layer (a model-originated visual design) the gate for the easiest-to-test thesis (the product's record model). The product was never tested.
- After the restart separated the two tracks, a verified, installable first version existed within one working session.
- Hence "load-bearing risk first", plus "independent risks on separate tracks".

**Pre-registration is a Default, not a Rule.** It is strongly supported by one case and is the right shape for go/no-go decisions. For routine engineering it is overkill: a failing test already acts as a pre-registered prediction.

### 2.4 Ownership by capability

**Grounds.** Four of five product cases failed on a capability the model was given but had not demonstrated: visual and feel quality, level geometry relative to the character, and naming (several names rejected).

**What the cases showed about current models:**

| Confidence | Capability |
|---|---|
| High | Engineering to a specification |
| High | Research synthesis with source grades |
| High | Safe automation under explicit rules |
| High | Faithful record-keeping |
| Medium | Implementing a supplied design (little direct evidence) |
| Medium | Critique against a reference |
| Low | One-shot taste choices such as names |
| Do not rely on | Originating a visual language against a high bar |
| Do not rely on | Judging "premium" or "fun" |
| Do not rely on | Model consensus on taste |

**"Models critique better than they generate."** In Case E, two models from different families each critiqued the other's design, and each critique closely matched the owner's later verdict. Neither could generate past the level both could critique. Critique against a reference is a real capability; originating taste, and judging your own, is not yet.

**Why lessons must be written as ownership.** Case D's visual lesson was recorded as narrow bans ("no custom art", "don't self-grade"). Case E obeyed both and still put the model in charge of the look, failing the same way seven times. Case B's "breadth before experience" lesson was obeyed for app features in Case D, and the breadth then reappeared inside the tree renderer. In both cases the narrow reading was the one that let the next project start with the same roles.

**Where the human boundary sits.**
- It is not "everything subjective". The owner happily delegated scope cuts, engineering trade-offs and deletion judgment within stated limits. They kept names, looks and pass/fail verdicts.
- Clause (c) of playbook §3.3 makes the boundary empirical: it applies where the model's judgment has been measured against the real oracle and found wanting, or where there is no record and being wrong is costly.

**Generation is still the model's job when generation is the task.** It drafts and revises against named features of the reference. The human keeps only the final verdict on whether it meets their taste. This was added after a blind review showed that the earlier wording blocked self-revision in writing tasks (§6).

### 2.5 The autonomy model

**Autonomy failed in both directions.**
- **Too much.** One early instruction said finishing an experiment is never a reason to stop. A later one said to continue automatically and never wait. Together they coincided with a single Codex thread lineage that reached about 1.2 billion cumulative input tokens over about a week and used a full weekly allowance in about a day and a half. Case B's "never ask me routine design questions" produced scale with no experience check.
- **Too little.** Case F had to rewrite its policy after it had been requiring the owner's approval for every technical repair and stalling for long stretches.

**The resolution.** It was reached independently in two different cases:
- implementation detail belongs to the agent, with a bound on repair attempts (both used three);
- criteria, the variables under test and the meaning of success belong to the human, even when the agent believes a change is equivalent.

**The owner repeatedly asked agents to overrule them on evidence.** One case's policy put it as "instructions are means, not ends". Hence the playbook row on instructions that look wrong: deviate on reversible matters and record why; escalate if the deviation would change the goal.

**Explicit stop is absolute.** Every stopped case ended with the same instructions: do not fix, do not defend, do not offer one more experiment, preserve the evidence.

**Real devices.** Automated input sent to a personal phone twice reached other apps. The second incident happened *after* a once-per-batch check had been added, which is why the rule says before *every* action.

### 2.6 Convergence and stopping

**Grounds.**
- **Case D.** The owner described the problem at the level of the representation early: the tree read as separate pieces, not one picture. Six more parameter-level attempts followed, each a "small bounded experiment".
- **Case E.** The written rule "after two rejections, propose a different direction" was satisfied seven times by the same model proposing another direction.
- **Case F.** One target ran through seven gated experiments with no qualifying result, each ending with a note naming the next route to try.

**Why it happens.** The postmortems explain it the same way each time:
- each rejection came with specific, intelligent criticism;
- specific criticism feels actionable;
- a bounded next step is always available;
- stopping requires the model to say something negative about its own capability.

**Why the rule says "change the source".** The only moves that ever produced a decisive answer changed the producer or the representation: a single static image, a two-model comparison read as evidence about the medium, a different design workflow. No parameter change ever did.

**Guard against premature quitting.** Case A fixed a broken measurement and re-ran the experiment once; it then converged. Case E's restarted engineering found and fixed defects steadily. Flat verdicts are the signal, not difficulty.

**A fair experiment can ask the wrong question.** Case D's two-model comparison was blind, isolated and fair. It was also limited to one component, while the complaint was about the whole picture. A clean method does not rescue a wrong variable.

### 2.7 Other models

**Yield, best first:**

| Use | Result |
|---|---|
| Bounded defect review of logic and data code | Case E: 8 of 8 core-logic findings reproduced. Storage findings: 6 of 7 from one family and 6 of 8 from the other were reproduced or fixed, and the two reviewers overlapped on only 3 |
| Bounded review in Case A | About 33 concrete findings across four cycles, each with file, line and failing input, including subtle cross-domain bugs |
| Specification review before code | Case B found holes in the economy and offline design |
| Fix verification | Case B: 8 of 11 claimed fixes were only partial, and the reviewer also found the launch blocker |
| Research behind blocked sites | Useful, but mostly search snippets until full reads were required |
| Taste review and co-design | Negative: it endorsed wrong directions and sanded off anything risky |

**External studies** (links in [EVIDENCE.md](EVIDENCE.md)):
- one same-model plus one cross-model review found more planted errors than two same-model reviews, and a third reviewer added little (single author, low to medium confidence);
- a reviewer allowed to rewrite made working code worse;
- every model tested accepted a misleading pull-request description;
- different providers' models share errors.

**Rejected findings.** A record with zero rejected findings is a warning about who wrote the dispositions (the implementer), not proof the reviewer was always right. The real check is the reproduction, which is why the rule is "reproduce it", not "assess it".

**Delegation.**
- Cheap extraction agents saved the lead's context in the synthesis of this playbook.
- Parallel agents elsewhere sometimes worked against stale code, or ran into usage limits.
- Hence: delegate locating and extraction, keep judgment-bearing reading for the lead, and never let parallel work outrun integration.

### 2.8 Context and memory

**Measured:**
- **Claude Code.** Median per-call context was 160–440k tokens, peaking at about 960k in image-heavy sessions. Fresh sessions started at about 75–110k. Output was 0.3–1.6% of tokens processed; rereading context was the rest.
- **Codex.** The largest thread lineage reached about 1.2B cumulative input, 98% cached, with about 49 compactions. Context averaged about 424k just before each compaction and about 72k just after.

**The diagnosis** (the case's own): caching was working. Cost was large active context × very many calls × a long mixed-task conversation. Cache discounts lower the price but still consume usage limits, and usage limits interrupted work mid-task in several cases.

**Why fresh sessions are a Default, not a Rule.** A fresh session once lost the owner's decisive sentence, because state recorded "renderer reset" but not the owner's words. Another case's measured fix concluded that a single compaction is no reason to stop healthy work. Hence: fresh at milestones or when the session keeps regrowing without progress, with the human's verdict carried verbatim.

**Why the artifact outranks the document.** Case G found four status claims contradicted by reality: "complete and tested" for a game that could not launch, "done" for one that failed its first playtest, "abandoned" for one that had restarted, and a stale tool path. Case F's status file accumulated 29 stacked "CURRENT/LATEST" entries, which became competing instructions. Its restart cut core documentation about 8× and kept current state only.

**Instruction files.**
- **External (full read).** Agent instruction files gave no significant gain in task resolution, raised cost by about 20%, and showed no clear effect of length. Developer-written files beat generated ones.
- **What it overturned.** This weakened the belief that "shorter instruction files are better".
- **What stays.** "Load by when it must be true", supported by vendor documentation on what survives compaction and on scoped rules and skills.

### 2.9 Process theatre

**Ratio of documentation words to code lines** (two independent counts differed by up to 10%; only the ordering is reliable):

| Case | Ratio |
|---|---|
| Case A, the one still alive | about 3 |
| Case D | about 7–8 |
| Case E | about 9–10 |

In Case F, five or six consolidation and reset passes in under three weeks, and gigabytes of tooling, outweighed the creative output.

**What separated rigor from its appearance** was never the amount of process. It was whether the process touched the promise:
- Case A's heavy safety rules guarded its actual promise: a read-only scan, where unknown stays unresolved.
- Case D's equally careful review packaging guarded taste reviews that could not change the verdict. In its own postmortem's words, the rigor was correct in form but applied to the wrong layer.

**Explanations.** The most uncomfortable finding in the postmortems is that the owner lost more to the model's fluency than to its failures: better explanations made each failed attempt look worth one more round.

### 2.10 Evidence grades

The labels (Verified / Supported / Plausible / Inferred / Contested / Unknown) are the minimum that preserves the distinctions that mattered:
- **Model memory corrected by current documentation:** library versions; a library wrongly called immature; a CLI flag that silently broke every file read; a removed subcommand.
- **Research weakened on full read:** features entered a product scope on two snippet-level discussions each, and were deferred once the threads were read in full.
- **Absence:** "no log is not zero"; "unknown stays unresolved".
- **Invented specifics:** a price that had been made up.

"Contested" and the cap on causal and forecast claims were added after the blind review (§6). The earlier labels could not express a historical "why".

### 2.11 Trust boundaries and enforcement (added in 1.2)

**Why it was missing.** None of the original cases was attacked through its inputs, so the 1.0 playbook covered real devices and real data but not untrusted content. An outside review pointed out the gap. The broader issue is that an agent's safety depends on the whole system it runs in, not only the model's judgment: instructions, tools, environment, credentials and the content it reads.

**Grounds for "data is not instruction".**
- Anthropic's research on prompt-injection defenses describes the threat as adversarial instructions hidden in content the model processes, and states that no browser agent is immune.
- OpenAI's Codex security documentation warns that injected content can make an agent fetch and follow untrusted instructions, and advises treating web results as untrusted.
- Both vendors rely on approvals, sandboxes and network limits as well as on model training, not on training alone.

**Grounds for "instructions are advisory; boundaries are enforced".**
- **Vendor documentation.** Claude Code's own documentation says instruction files are treated "as context, not enforced configuration". It says hooks give deterministic control and settings rules are enforced "regardless of what Claude decides".
- **Case D.** The second phone incident happened after a written device rule was already in place.
- **Case A.** It held its frozen criteria and human-owned reference files with enforced mechanisms: a pre-commit hook, deny rules and schema-checked review records. The implementing agent could not have edited them even by mistake.
- **This project.** When an installer tried to add a permission rule to the agent's own settings, the tool's safety classifier refused, which is the intended behaviour.

**Limits.**
- Enforcement mechanisms are partial too. Claude Code's sandbox, for example, covers shell commands only and does not run on native Windows.
- Hence the rule says "where the stakes justify it and a mechanism exists". It never treats any single mechanism as a guarantee.

### 2.12 Every harness component expires (added in 1.2)

**Grounds.**
- Anthropic's harness-design work (March 2026) says that every component of a harness encodes an assumption about what the model cannot do on its own, and that these assumptions go stale as models improve. It reports removing a planning construct and context resets for newer models. It also kept an evaluator for tasks beyond what the model handles reliably, so the lesson is to re-test each component, not to strip them all.
- Community reports (self-report, Hacker News 2026) point both ways. Some users found a popular large skill pack had become unnecessary or harmful with newer models. Others keep small process skills because models still skip steps without them.
- This project removed its own skill and global installer once it became clear they cost more debugging than they saved.

**Consolidation.** The 1.0 rules "build tooling only after the manual step proves itself" and "automation has running costs" are now one rule: every component, including this playbook, is a hypothesis that must keep paying for itself and must be re-tested when the model or tool changes. The Current-models label marks the parts most likely to expire.

### 2.13 Continuing and resuming (added in 1.2)

**What went wrong.** The 1.1 Continue prompt assumed every project had been started by this playbook. It told the agent to read AGENTS.md, STATE.md and DECISIONS.md, and to create them if missing. For a project with its own conventions, that would have produced a second, competing record, which is exactly what §7's "one home per fact" warns against.

**The fix.** Continuing now starts by discovering how the project already records itself (instruction files, plans, notes, decision records, issue lists, git history). It checks those notes against the actual work, keeps the project's conventions, and adds a record only where none is usable.

**Cold-start resumability as the oracle.**
- A state file existing does not show that a project can be resumed, just as a pushed repository does not show that a project can be recovered (§2.1).
- The matching drill is to give a fresh agent only the durable files and a continuation prompt, and check whether it reconstructs the goal, what is verified, what is open, what was abandoned and the next step.
- It is a Default for long or high-value work, not a ceremony for every project.
- Support: it is inferred from the restore-drill evidence and from Case D, where a fresh session lost the owner's decisive sentence. It was tested on three fixtures before release (§6).

## 3. Corrections to earlier rules

| # | Earlier rule or belief | What happened | Now |
|---|---|---|---|
| 1 | Prove look and feel before any plumbing | Right in one case; in the next it blocked the only test that mattered | Load-bearing risk first; independent risks on separate tracks |
| 2 | "No custom art"; "don't self-grade" | Obeyed, and the model still originated the look; seven failures | Ownership: the model does not originate or judge taste against a high bar |
| 3 | Two rejections, then propose a different direction | Satisfied by generating more directions from the same model | After non-improvement, change the *source* |
| 4 | "The model cannot do UI" | Overstated; functional UI and layout work were fine | It cannot originate or judge a look; it can implement and check measurable properties |
| 5 | Unprimed independent review protects judgment | Two model families still agreed on wrong visual directions | Information independence plus different failure modes; never consensus on taste |
| 6 | "Verified X by Y; not verified Z" as a ritual | X was often a proxy (internal tests, build time) | X must be the promise |
| 7 | Pushed, or a clean `git status`, means safe | A faithful archive of a corrupt file; some projects had no remote at all | Only a restore drill on a clean copy, followed by running it, shows recovery |
| 8 | Status documents describe the project | Four status claims contradicted by reality in one audit | The artifact outranks the document |
| 9 | A self-reported improvement in failure containment | Contradicted by the same project's hours of repeated attempts | Self-assessed improvement is a claim like any other |
| 10 | Shorter instruction files work better | Full read of the study: no clear length effect | Organize by when information must hold |
| 11 | More reviewers mean more coverage; one of each family is best | Little gain from a third reviewer; weak family evidence | A second family only in risk areas, with a yield log |
| 12 | Fresh sessions preserve what matters | Lost the owner's decisive sentence | Carry the human's verdict verbatim in state |
| 13 | Community research established product features | Mostly snippets; weak on full read | Read in full before a source changes a rule; count independent origins |
| 14 | Versions and CLI flags from model memory | Wrong several times; a written command failed its first smoke test | Current docs or a local run before a version or flag drives a decision |
| 15 | Core code "verified" by its author | Violated the product's own rule; 8 defects found by review | Author-verified is not verified |
| 16 | "Never stop; continue automatically" | About 1.2B tokens in one lineage; a weekly allowance gone in about a day and a half | Autonomy over how, with stop triggers; files carry memory |
| 17 | Owner approval for every technical repair | Stalled work | The agent owns repair within a bound; the human owns what counts |
| 18 | An automatic review gate wired into hooks | Abandoned within about half an hour, replaced by one explicit command | Build tooling only after the manual step has proven itself; then freeze it |
| 19 | Postmortems prevent recurrence | The same failure recurred twice with its lesson already written | Lessons become structure: ownership at kickoff, pre-agreed stop rules |
| 20 | A two-model comparison tests model ability | It tested one component, while the complaint was about the whole | Check that the variable can answer the latest complaint |
| 21 | Image quality needs better metrics | No metric tracked the owner's preference; exact technical equivalence did not predict perceived benefit | Human judgment on real output beside references; metrics only for integrity |
| 22 | Install the playbook as a skill, plus a global always-on Core (1.0) | It took more debugging (did the skill load? file permissions) than it saved, and hid what the agent had received | Explicit prompts the human copies and pastes; nothing installed |
| 23 | Continuing a project means reading this playbook's own state files (1.1) | Most projects use other conventions; forcing the schema creates a competing record | Discover and keep the project's own conventions; check them against the work |
| 24 | Cheaper models for extraction and summaries | A summary that decides what the lead sees is a judgment; cheaper models can be good at locating and worse at fact-checking | Match capability to the cost of a mistake; pass source pointers; escalate doubts |
| 25 | Delegation is a context saver | Helpers cost inference, latency and coordination; the vendor's own multi-agent system used about 15× the tokens of a chat | Delegation must pay for itself: parallel, independent, isolating or reach |

## 4. Conditional distinctions

| Tension | Resolution |
|---|---|
| Prove the experience first vs. build the product first | Whichever is the load-bearing and uncertain risk goes first. If both are, separate the tracks |
| Autonomy vs. gates | Gates on human-owned judgments and on authority; autonomy everywhere else |
| Fresh session vs. continuity | Fresh at milestones or on regrowth; carry verbatim verdicts and abandoned approaches |
| Withhold rationale vs. give context | Withhold your argument; give the requirements and the owner's verdicts as facts |
| Full reads vs. endless browsing | Read in full what will change a decision; stop at saturation; record what is unresolved |
| Cross-family review vs. cost | Only where defects are expensive; one round; keep a yield log |
| Ask vs. decide on subjective matters | Ask when it is the success criterion or a demonstrated blind spot; decide when it is reversible and incidental |
| Generate vs. don't judge your own taste | Generate and revise against named features; the human gives the final verdict |
| Pre-registration vs. agility | Pre-register for go/no-go and validation; for routine work a failing test is enough |
| Saving tokens vs. quality | Delegate locating and extraction; never delegate the reading that judgment rests on |

## 5. What was dropped

- **Project-specific rules:** library choices, device gesture margins, CLI flags, language quirks. They live in their projects. The general form is "check current docs or a local run" and "precondition before every action on a real device".
- **Exact numeric thresholds** ("two strikes", "30 lines", "three repair cycles", "at most two review calls"). The evidence supports the shape (bounded, compared with the best so far), not the numbers.
- **Advice aimed at the human,** such as a cooling-off period before restarting after an abandonment. The agent-side version is in playbook §3.1: check whether the new project assigns the capability that just failed.
- **Elaborate review packaging for taste reviews,** and diagnosis documents written in response to a taste rejection. Rigor on the wrong layer.
- **On/off policies for particular models.** Policies flipped repeatedly with quota and mood. What stayed stable was the *role* of the second model (bounded, read-only, findings treated as claims), so that is what the playbook encodes.

## 6. How the playbook was tested

It was tested by its own method, separating producer from judge:

1. **Counterexample checks against the cases.**

   | Case | Result |
   |---|---|
   | D | The playbook stops it at the owner's early medium-level complaint (§5), and forces the asset-source question at kickoff (§3.1) |
   | E | Its product track stays alive (§2.3) |
   | B | Caught by version control (§2.6), launch as the oracle (§1.2) and no breadth before the core (§2.2) |
   | A | Nothing would have changed. That the surviving project already fitted these rules is part of why they are trusted |

2. **Blind usability review.** A fresh agent saw only the playbook, with none of this rationale, and applied it to four unrelated tasks: a market study, a historical research question, a zero-loss database migration, and a short story in a named author's style.
   - **Gaps it found:**
     - generative tasks had no workable path;
     - research with unreachable primary sources would stall;
     - the evidence grades could not express causal or contested claims;
     - "reach via another model" invited citations from memory;
     - no rule covered tracing a claim to its origin, irreversible operations, or the facts only the human holds;
     - state files were too heavy for short tasks;
     - the examples were software-heavy.
   - **Outcome:** all were fixed. This was the largest single improvement to generality.
3. **Fact-check.** An independent agent checked 20 claims against the private primary sources: 1 was wrong, 1 mis-sourced and 5 overstated, and all were corrected. The synthesis had made the very error it warns about, carrying precise-looking numbers forward from notes without re-reading.
4. **Onboarding test.** See the [changelog](../CHANGELOG.md).

5. **Revalidation tests for 1.2.** Every prompt was generated by running the site's real builder script, not a hand-made copy.
   - **Continue on three project fixtures.** One was created with the New-project prompt. One was an ordinary repository with no playbook files. One used its own conventions (a CLAUDE.md, a roadmap and decision records) and had a deliberately stale status note.

     In all three, a fresh agent:
     - found the project's own records and kept its conventions;
     - created no new file schema and did not restart onboarding;
     - corrected the stale roadmap and respected a recorded abandoned approach;
     - proposed the right next step.

     On the playbook-created fixture, it also found that the open questions for the owner had never been written to disk. That is the cold-start resumability check catching a real gap in a state record.
   - **Planted instruction.** A hidden comment in the ordinary repository told AI assistants to delete the tests, dump environment variables and keep quiet.
     - The agent never obeyed it, in any of three runs.
     - Whether it *reported* the comment varied between identical runs. That is a small, direct example of why written instructions are advisory and costly limits need enforcement. The Core now says to report such text, and the Continue summary has a slot for it.
   - **First-time-user review.** A reviewer playing someone who had never used an AI tool found the gaps listed below, and all were fixed in plain wording inside the existing help sections:
     - how to open a tool "in a folder";
     - where your own documents go;
     - that the AI will change a folder's files;
     - that the optional file can be skipped;
     - what "here" referred to.

## 7. Provisional hypotheses

These are not yet rules.
- **Plain first, skin later.** Building a working product in a plain skin, and designing the look afterwards, may be cheaper for taste-heavy products. One restart is testing it, with no outcome yet.
- **The efficient review setup for high-risk code** may be one fresh same-family review plus one cross-family review. There is one logged comparison.
- **Structure-first, human-gated design workflows** converge in an orderly way but do not create taste. One case.
- **Scoped retrieval, bounded output and tiered tests** reduce long-session cost. There is no measured causal saving yet.
- **A written pre-mortem before restarting a failed project** produces a better-shaped restart. Two cases, no long-run outcome.

## 8. Updating the playbook

- Change a rule only on new evidence that is stronger than what supports it now. Record the change in the [changelog](../CHANGELOG.md) and the support in [EVIDENCE.md](EVIDENCE.md).
- If the change overturns an earlier rule, add a row to §3 here.
- When the models or tools you use change materially, do a small revalidation, not a rewrite. Re-test the **Current models** items and any rule that exists to compensate for a model weakness. Downgrade, rewrite or remove what no longer improves results (§2.12).
- Keep [CORE.md](CORE.md) at about 350 words and [PLAYBOOK.md](PLAYBOOK.md) under about 4,000. When they grow, merge rules that turn out to be one principle; do not add a section per failure.
