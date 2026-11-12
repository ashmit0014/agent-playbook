<!-- profile-editorial-cover -->
<picture>
  <img src=".github/project-cover.png" alt="agent-playbook by Ashmit Kundu" width="100%" />
</picture>

# Agent Playbook

**Add only the instructions that measurably help an AI assistant with your task. Often that is nothing.**

Version 1 of this project was a large set of operating rules for AI agents, drawn from real projects that went wrong. Version 2 tested those rules against a plain, clear request on ten realistic tasks. For most tasks the plain request did as well or better, and was cheaper. One situation needed help: work that continues in a later session, where requirements given in conversation were lost. So the site now adds one tested paragraph for that situation, and otherwise tells you to paste your request as it is.

## Use it

1. Open **https://ashmit0014.github.io/agent-playbook/**.
2. Write what you want the AI to do.
3. Tick "The work will continue in another conversation" if you will come back to it in a tool that works on your files.
4. Copy the result into your AI tool.

Nothing is installed and no files are required. You see exactly what the site adds to your request. Your AI tool also follows its own rules, which this site cannot see or change.

## What is here

| | |
|---|---|
| [`index.html`](index.html), [`assets/`](assets/), [`additions.json`](additions.json) | The page. `additions.json` is the single source for what the site can add, its version, and the advice it shows. |
| [`EVALUATION.md`](EVALUATION.md) | How each candidate addition was tested, what helped and what did not, and the limits of the test. |
| [`NOTES.md`](NOTES.md) | Lessons for people: who may give an agent instructions, current state versus requirements, how sure a claim is, and the v1 lessons that held up. Nothing here is sent to the AI. |
| [`eval/`](eval/) | The evaluation: fixtures, requests, candidate paragraphs, graders, judge, and every final answer. |
| [`v1/`](v1/) | Version 1, archived unchanged, with an account of what went wrong. Exact files are in tags `v1.0`, `v1.1`, `v1.2`. |
| [`tests/`](tests/) | Checks that run before every deployment. |

## Changing what the site adds

Change a paragraph only with evidence: run the relevant tasks in `eval/` with the old and new text, then update `additions.json`, the version, `CHANGELOG.md` and the snapshot (`node tests/check.js --update`, after reviewing the diff). The deploy workflow refuses to publish if the checks fail.

## License

- Code (`assets/`, `_layouts/`, `tests/`, `eval/*.py`, `.github/`): MIT.
- The paragraphs the site adds to prompts (the `text` fields in `additions.json`): CC0. Use them however you like, without credit.
- All other writing: CC BY 4.0. Share and adapt it with credit to "Agent Playbook by Ashmit Kundu".

Full terms are in [`LICENSE`](LICENSE).
