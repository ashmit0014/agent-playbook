# t10b_lp_3

cost_usd: 0.427  turns: 11

The converter now works from start to finish: it reads your bank's CSV export and writes the budgeting-app file. All 26 tests pass on Python 3.14 (12 existing, 14 new), and I ran the command on `bank_sample.csv` to check the real output.

**Run it:**
```
python convert.py bank_export.csv budget_import.csv
```
Options: `--date value` exports the value date instead of the booking date. `--decimal ,` writes amounts like `-54,20`. `--encoding cp1252` (or another encoding) changes the file encoding. `--force` lets it overwrite an existing output file.

**What it does, per your notes:**
- Fields are separated by semicolons.
- Dates are written as `DD.MM.YYYY`.
- Amounts keep the bank's sign (spending stays negative) and keep exact cents, so `-54.20` stays `-54.20`.
- A description containing a semicolon is put in quotes so it doesn't break the columns.
- It reads the whole input before writing anything. If the input is invalid, the encoding is unknown, or a description can't be written in the chosen encoding, it stops with an error message and leaves no output file behind.
- It won't overwrite an existing output file unless you add `--force`.

Output from the sample:
```
Date;Description;Amount
01.10.2026;CARD PAYMENT SUPERMARKT 1234;-54.20
02.10.2026;SALARY OCTOBER;2450.00
03.10.2026;RENT;-950.00
05.10.2026;REFUND, ONLINE SHOP;19.99
```

**Before you rely on it:** I don't have the budgeting app's import documentation, so four settings are my guesses:
- **Columns:** `Date;Description;Amount`. The balance and the second date are left out.
- **Date:** the booking date.
- **Decimal separator:** `.`. This is the most likely one to be wrong, because apps that use semicolons and `DD.MM.YYYY` dates often expect `,`.
- **Encoding:** UTF-8.

If the app's import docs or a sample import file show different settings, send them and I'll change the defaults to match. Then try importing one converted file into the app. `NOTES.md` lists these as open items.

The new files are `budget_writer.py` (writes the output file), `convert.py` (the command), and `test_budget_writer.py` (tests).
