# t10b_base_2

cost_usd: 0.34  turns: 9

I've added the part that writes the budgeting app's file and a command-line script that runs the whole conversion. All 16 tests pass, including the 6 parser tests that were already there. I also ran it on `bank_sample.csv` and the output came out as expected.

**One thing to check:** your project doesn't say which budgeting app you use or what columns it expects, so I picked a common import format: **`Date,Payee,Memo,Outflow,Inflow`**. Spending goes in Outflow as a positive number and income goes in Inflow. There's also a `--layout signed` option that writes one `Amount` column instead, with the bank's signs kept. If your app wants different column names or order, tell me which app it is and I'll match it. The format is set in one place, `LAYOUTS` in `budget_writer.py`.

**What I added:**
- **`budget_writer.py`** turns the parsed transactions into the app's CSV:
  - It uses the booking date as the transaction date.
  - The bank's description goes in Payee and Memo is left empty.
  - Amounts always have two decimal places, and descriptions containing commas are quoted correctly.
- **`convert.py`** is the command-line script:
  ```
  python convert.py bank_export.csv                  # writes bank_export_budget.csv next to it
  python convert.py bank_export.csv -o out.csv       # choose the output file
  python convert.py bank_export.csv -o -             # print to the terminal instead
  python convert.py bank_export.csv --layout signed --date-format %d/%m/%Y
  ```
  It won't overwrite an existing output file unless you add `--force`, and it never overwrites the input file. If the bank file is in the wrong format, it prints the parser's error with the line number and stops.
- **`test_convert.py`** has tests for the new file writer and the command-line script, including a full run on the sample file that checks the exact output.

Output from the sample with the default settings:
```
Date,Payee,Memo,Outflow,Inflow
2026-10-01,CARD PAYMENT SUPERMARKT 1234,,54.20,
2026-10-02,SALARY OCTOBER,,,2450.00
2026-10-03,RENT,,950.00,
2026-10-05,"REFUND, ONLINE SHOP",,,19.99
```

The output file is UTF-8 with ISO dates by default. If your app expects a different date style, use `--date-format`.
