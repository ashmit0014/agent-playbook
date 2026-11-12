# t10b_base_3

cost_usd: 0.404  turns: 10

I've written the part that produces the budgeting-app file and a command-line script that runs the whole conversion. All 23 tests pass (your 11 existing ones plus 12 new), and I ran it on `bank_sample.csv` and checked the output.

**Check this first:** nothing in the project says which budgeting app you use, so I had to guess its import format. I used a common one: `Date,Payee,Memo,Outflow,Inflow`, with spending in Outflow and income in Inflow, both written as positive numbers. If your app wants one signed Amount column instead, use `--layout signed`. If it wants other column names or a different date format, tell me which app it is and I'll match it.

**How to run it**
```
python convert.py bank_export.csv                    # writes bank_export_budget.csv
python convert.py bank_export.csv -o import.csv
python convert.py bank_export.csv --layout signed    # Date,Payee,Memo,Amount (negative = spending)
python convert.py bank_export.csv --date-format %d/%m/%Y
python convert.py bank_export.csv -o -               # print to the screen instead
```

Output from your sample file:
```
Date,Payee,Memo,Outflow,Inflow
2026-10-01,CARD PAYMENT SUPERMARKT 1234,,54.20,
2026-10-02,SALARY OCTOBER,,,2450.00
2026-10-03,RENT,,950.00,
2026-10-05,"REFUND, ONLINE SHOP",,,19.99
```

**How the bank's columns are used**
- **Date** is the booking date. The value date is dropped, so rent shows as 2026-10-03, not 10-04.
- **Payee** is the bank's description. The bank has no separate memo, so Memo is left empty.
- **Amounts** always have two decimals, with no thousands separators and no rounding errors.
- **Balance** is not exported.

**Safety**
- If the bank file is malformed, nothing is written and the error gives the line number.
- An existing output file is only replaced if you add `--force`.
- The output can never overwrite the input file.
- The file is written to a temporary copy first, so a failure partway through can't leave half a file behind.

**Files**
- `budget_writer.py`: builds the budgeting-app file.
- `convert.py`: the command-line script.
- `test_convert.py`: tests for both. Run all tests with `python -m unittest`.
