# t10a_base_2

cost_usd: 0.263  turns: 8

I've written the parser in `bank_parser.py`. It reads `bank_sample.csv` correctly, and all 6 tests in `test_bank_parser.py` pass.

**How it works:**
- `parse_file(path)` returns a list of transactions. Each one has the booking date, value date, description, amount and balance.
- Dates become real date values, so writing them as DD.MM.YYYY later is a one-liner.
- Amounts are kept as exact decimals rather than floats, so `-54.20` stays exactly `-54.20` with its sign unchanged. Negative still means spending.
- Descriptions that contain a comma inside quotes, like `"REFUND, ONLINE SHOP"`, are read correctly.
- It uses only Python's standard library, with no pandas.
- It skips blank lines and copes with the invisible marker some programs put at the start of a CSV file.
- Bad input stops with a clear message that gives the line number: a wrong header, an unreadable date or amount, or the wrong number of columns.
- You can also run it on its own as a quick check: `python bank_parser.py bank_sample.csv` prints each parsed transaction.

**For the output writer:** I saved your requirements to memory so the next session has them: semicolons between fields, dates as DD.MM.YYYY, the bank's signs kept as they are, and no pandas. One thing to decide then: the bank gives both a booking date and a value date, and they can differ (the rent row is 03.10 vs 04.10). Which one should the budgeting app get?
