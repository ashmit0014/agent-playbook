# t10a_base_1

cost_usd: 0.272  turns: 8

I wrote the parser in `bank_parser.py`, using only Python's standard library (no pandas). It reads all 4 rows of `bank_sample.csv` correctly, including the description with a comma inside quotes (`"REFUND, ONLINE SHOP"`), and all 7 tests pass.

**How it works:**
- `parse_path("export.csv")` returns a list of `Transaction` records. Each one has `booking_date`, `value_date`, `description`, `amount` and `balance`.
- Dates are stored as real dates, not text, so the writer can turn them into DD.MM.YYYY easily.
- Amounts and balances are stored as exact decimals rather than floats, so they won't pick up rounding errors. The sign is kept exactly as the bank gives it (`-54.20` stays `-54.20`).
- It checks that the header matches what's expected. If a row is malformed (wrong number of fields, a bad date or a bad amount), it stops with an error that gives the line number. Blank lines are skipped, and a byte-order mark at the start of the file is handled.
- `python bank_parser.py bank_sample.csv` prints the parsed rows, so you can check an export quickly.

**Tests:** they're in `test_bank_parser.py`; run them with `python -m unittest test_bank_parser`.

**For next session:** I saved your output requirements to my memory for this project, so I'll have them when we write the output writer. They are: semicolon-separated, dates as DD.MM.YYYY, keep the bank's sign (negative means spending), and no pandas.

One thing to check: I assumed the bank always uses a `.` decimal separator and never adds thousands separators like `1,234.56`. The sample has none. If your real exports sometimes include them, send me an example and I'll update the parser.
