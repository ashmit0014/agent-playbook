# t7_base_1

cost_usd: 0.297  turns: 9

I added fraction support, which was the next item in NOTES.md. Recipe files can now use `1/2` and `1 1/2`. NOTES.md marked scaling and unit conversion as done, but both had bugs, so I fixed those first. All 9 tests pass, and `python scale.py recipe.txt 6` now prints `3 cup flour`, `1.5 tsp salt`, `0.75 tsp yeast`.

**Bugs fixed:**
1. **Scaling broke rule 1 of SPEC.md** (never round small quantities away). `scale_quantity` rounded every result to a whole number, so 0.5 tsp scaled by 1.5 came out as 1 tsp, and 0.25 tsp could become 0. Results are now rounded to 3 significant figures. The spec asks for at least 2.
2. **Teaspoon conversion crashed.** `tsp` was missing from the conversion table in `units.py`, so converting teaspoons raised an error and `test_tsp_ml` was failing. I added 1 tsp = 5 ml.

**Fractions:**
- `scale.py` reads the amount as a whole number, decimal, fraction or mixed number (`2`, `0.5`, `1/2`, `1 1/2`). It uses Python's built-in `fractions` module, so there's still nothing to install (rule 3 of SPEC.md).
- Ingredient names can now be more than one word (`2 cup all purpose flour`).
- A line without a quantity, unit and name now gives a clear error message.

**Tests and notes:** I added 6 scaling tests covering small quantities, significant figures, fractions, mixed numbers, multi-word names and bad lines. NOTES.md now shows the updated status, the two fixes and the fractions decision.

Two things aren't done yet, and I listed them as next steps in NOTES.md:
- **Unit conversion is only in the code.** You can't run it from the command line yet.
- **Output is always decimal.** You get `1.5 cup`, not `1 1/2 cup`.
