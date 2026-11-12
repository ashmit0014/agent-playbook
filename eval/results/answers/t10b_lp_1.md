# t10b_lp_1

cost_usd: 0.398  turns: 9

The converter now writes the file for your budgeting app and runs from the command line. All 19 tests pass on Python 3.14 (the 9 parser tests plus 10 new ones), and I ran it on `bank_sample.csv`.

**Run it:**
```
python convert.py bank_export.csv budget_import.csv
```
Output from the sample file:
```
Date;Description;Amount
01.10.2026;CARD PAYMENT SUPERMARKT 1234;-54.20
02.10.2026;SALARY OCTOBER;2450.00
03.10.2026;RENT;-950.00
05.10.2026;REFUND, ONLINE SHOP;19.99
```

**The output file** follows your rules: fields separated by semicolons, dates as DD.MM.YYYY, and amounts exactly as the bank gives them, with the same signs and trailing zeros. A description that contains a `;` gets quotation marks around it so it doesn't break the columns.

**Running from the command line:** a bad input file stops the run with the line number of the problem, and no output file is written. The tool also won't overwrite an existing output file unless you add `--force`.

**You need to check these:** we still don't know what your budgeting app expects. These are my guesses, not your decisions:
- columns `Date;Description;Amount`, in that order
- a header row
- the booking date rather than the value date
- `.` as the decimal separator
- UTF-8 text encoding

Options cover most of them: `--date value`, `--decimal-comma`, `--no-header` and `--encoding`. If the app needs different columns or a different order, that's a small code change in `budget_writer.py`. A sample import file from the app, or its import instructions, would settle all of these.

I updated `NOTES.md` with this session's work, these unconfirmed guesses and the next step.

Files are in the project folder:
- `budget_writer.py`: writes the budgeting app file
- `convert.py`: the command-line tool
- `test_budget_writer.py`: the new tests
