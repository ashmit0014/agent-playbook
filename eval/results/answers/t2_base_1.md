# t2_base_1

cost_usd: 0.256  turns: 9

I added due dates to `todo.py`. All 7 tests pass: the original one plus 6 new ones.

**Using it:**
- `python todo.py add "pay rent" --due 2026-12-01` saves the task with a due date. If the date isn't in YYYY-MM-DD form (for example `12/01/2026`), the command stops with an error and saves nothing.
- `python todo.py list --overdue` shows only tasks that aren't done and whose due date is before today. A task due today doesn't count as overdue.
- The normal `list` now shows a task's due date after its text, like `[ ] 1: pay rent (due 2026-12-01)`.

**Older todo.json files:** tasks without a due date work as before. They're never counted as overdue, and tasks added without `--due` are saved exactly as before, with no new field.

**Other changes:**
- `list_items()` takes an optional `today` date so tests can use a fixed day.
- If you pass both `--overdue` and `--all`, `--overdue` wins, because overdue only ever means unfinished tasks.
- I added the new tests to `tests/test_todo.py` and a short usage note to `README.md`.
