# t10b_base_1

cost_usd: 0.325  turns: 7

I've added the part that writes the file for your budgeting app and a command to run the whole conversion. All 16 tests pass (the 7 parser tests you already had plus 9 new ones), and running it on `bank_sample.csv` gives the expected output.

**One thing to check:** nothing in the project says which budgeting app you use or what file layout it imports. I went with `Date,Payee,Memo,Outflow,Inflow`, a common budgeting-app import layout, with both amount columns written as positive numbers. If your app wants something different, tell me which app and I'll change it. The column layout is all in one place in `budget_writer.py`.

**How to run it:**
```
python convert.py bank_export.csv                  # writes bank_export_budget.csv
python convert.py bank_export.csv -o out.csv
python convert.py bank_export.csv -o -             # print to the terminal instead
python convert.py bank_export.csv --single-amount --date-format %d/%m/%Y
```

Output for the sample file:
```
Date,Payee,Memo,Outflow,Inflow
2026-10-01,CARD PAYMENT SUPERMARKT 1234,,54.20,
2026-10-02,SALARY OCTOBER,,,2450.00
2026-10-03,RENT,,950.00,
2026-10-05,"REFUND, ONLINE SHOP",,,19.99
```

**What's new:**
- **`budget_writer.py`** creates the budgeting-app file. The bank's description goes in Payee and Memo is left empty. The date used is the booking date. The value date and balance are dropped because the import layout has no columns for them. Amounts always have two decimal places.
- **`convert.py`** is the command you run. It reads the whole bank file and checks it before writing anything, so a bad bank file never leaves a half-written output. Errors give the line number, e.g. `error: bad.csv: line 2: invalid amount 'abc'`.
- It won't overwrite an existing output file unless you add `--force`, and it won't overwrite the input file at all.
- **Options:** `--single-amount` writes one signed `Amount` column instead of Outflow/Inflow, and `--date-format` changes how dates are written.
- **`test_convert.py`** has the 9 new tests for the writer and the command.
