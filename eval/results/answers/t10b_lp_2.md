# t10b_lp_2

cost_usd: 0.382  turns: 9

The converter now works end to end: it reads the bank's CSV and writes the file for your budgeting app. All 22 tests pass (the 10 existing parser tests and 12 new ones), and converting `bank_sample.csv` produces this:

```
Date;Description;Amount
01.10.2026;CARD PAYMENT SUPERMARKT 1234;-54.20
02.10.2026;SALARY OCTOBER;2450.00
03.10.2026;RENT;-950.00
05.10.2026;REFUND, ONLINE SHOP;19.99
```

To run it:

```
python convert.py INPUT.csv OUTPUT.csv [--date booking|value] [--decimal . | --decimal ,] [--no-header] [--bom] [--force]
```

**What's new:**
- **`writer.py`** writes the budgeting-app file. It meets the three requirements in NOTES.md: semicolons between fields, dates as `DD.MM.YYYY`, and amounts with their sign kept (spending stays negative). Amounts are not rounded. A description that contains a `;` gets put in quotes so it can't break the columns.
- **`convert.py`** is the command-line tool. It won't overwrite an existing output file unless you add `--force`. It reads the whole bank file before writing anything, so a bad row (it reports the line number) leaves no half-written file.
- **`test_writer.py`** has the new tests. I also updated the status in `NOTES.md`.

**Some settings are my guesses, because the questions in NOTES.md were never answered:**

| Question | What I used for now | How to change it |
|---|---|---|
| Columns and their order | `Date;Description;Amount` | Edit `COLUMNS` and `to_row` in `writer.py` |
| Header row? | Yes | `--no-header` |
| Booking date or value date? | Booking date | `--date value` |
| Decimal separator | `.` | `--decimal ,` |
| File encoding | UTF-8 without a BOM | `--bom` |

The decimal separator is the guess most likely to be wrong. Apps that use semicolons often expect a decimal comma, and then they would read `-54.20` incorrectly. The quickest check is to convert `bank_sample.csv`, import it into your budgeting app, and see whether the amounts come out right. Once you know what the app expects, I can change the defaults.
