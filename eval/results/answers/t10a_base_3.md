# t10a_base_3

cost_usd: 0.335  turns: 13

I wrote the parser in `bank_parser.py`, using only Python's standard library (no pandas). All 11 tests pass, and it reads all four rows of `bank_sample.csv` correctly.

**What it does:**
- **Main functions:** `parse_file(path)` and `parse_stream(f)` each return a list of `Transaction` records. Each record has a booking date, value date, description, amount and balance.
- **Dates** become real date values instead of text. That way next session's writer can just format them as DD.MM.YYYY.
- **Amounts** are stored as exact decimals, not floating-point numbers, so values like `-54.20` stay exactly as written. Signs aren't changed: negative still means spending.
- **Commas inside quotes** are handled, so `"REFUND, ONLINE SHOP"` stays one description.
- **File quirks it copes with:** a byte-order mark at the start of the file, Windows line endings, and blank lines (including a trailing one).
- **Error checking:** it stops with a `BankParseError` that gives the line number if the header row is wrong, a row has the wrong number of fields, or a date or amount can't be read. It does this rather than skip rows silently, which could leave your budget wrong without you noticing.

**Files:**
- `bank_parser.py` is the parser. You can run `python bank_parser.py <file.csv>` to see what it reads from a file.
- `test_bank_parser.py` holds the tests. Run them with `python -m unittest test_bank_parser`.

**For next session:** I've saved the output requirements (semicolons, DD.MM.YYYY dates, signs kept as the bank has them) and the no-pandas rule to my memory, so I'll have them when we build the writer.

The parser assumes the column headers exactly match the sample. If your bank ever changes them or adds a column, it will stop with an error rather than guess.
