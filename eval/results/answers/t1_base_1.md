# t1_base_1

cost_usd: 0.189  turns: 8

I fixed `summarize()` so it skips empty rows, and both tests pass.

**The fix** (`stats.py:9-13`): rows where every field is blank are now skipped. That covers lines of only commas (`,,`), only spaces, and short lines where the CSV reader fills the missing fields with nothing. Blank lines with no characters at all were already skipped before.

**Test:** I added `test_ignores_empty_rows` in `tests/test_stats.py`. It mixes `,`, a spaces-only line, a blank line and ` , ` in with real data and checks that the count, total and mean are still correct.

**Still crashes:** an export with no real data rows (only a header, or only empty rows) fails with a divide-by-zero error, because the mean has nothing to divide by. This happened before the fix too. If you want, I can make it return `mean: None` (or 0) in that case.
