# RiskScorescvd 0.4.0

---

This release changes `SCORE2()` / `SCORE2_CKD()` results for some patients
(see the breaking changes below). Results for everyone else are identical to
0.3.1, which was verified against the 0.3.1 release on a grid of more than
35,000 input combinations and on `calc_scores()`.

### Bug fix: SCORE2 classification for ages between 69 and 70

- For non-integer ages between 69 and 70 (e.g. 69.5), `classify = TRUE` in
  `SCORE2()` and `SCORE2_CKD()` returned a function instead of a risk group,
  because the age bands were defined as `<= 69` and `>= 70`. The 50-69 band
  now covers ages up to 70, matching the SCORE2 / SCORE2-OP age split. Risk
  categories follow the 2021 ESC prevention guidelines
  (doi:10.1093/eurheartj/ehab484). Whole-number ages are unaffected.

### Other

- Corrected the SCORE2-Diabetes DOI in DESCRIPTION (`ehad260`).

### Missing inputs in SCORE2 and SCORE2_CKD give NA with a warning (#21)

- If any required input is `NA`, `SCORE2()` and `SCORE2_CKD()` return `NA`
  with a warning naming the missing input(s). A missing `Age`, `Gender` or
  `Risk.region` previously stopped with "missing value where TRUE/FALSE
  needed", which in `calc_scores()` stopped the whole data frame. Other
  missing inputs already gave `NA`, but silently. `ACR` and `trace` remain
  optional.

### New: SCORE2 and SCORE2_CKD accept vectors (#18)

- `SCORE2()` and `SCORE2_CKD()` now accept vector inputs (each of length 1
  or n) and return a vector, without needing `dplyr::rowwise()`. Results are
  identical to scoring row by row. Mismatched lengths give an informative error.

### Breaking change: SCORE2 no longer scores people under 40 (#17)

- `SCORE2()` and `SCORE2_CKD()` now return `NA` with a warning for patients
  aged under 40. SCORE2 was developed and validated for ages 40-69
  (doi:10.1093/eurheartj/ehab309). The data-frame wrappers and `calc_scores()`
  inherit this.

### Breaking change: SCORE2 no longer scores people with diabetes under 70 (#15)

- `SCORE2()` and `SCORE2_CKD()` now return `NA` with a warning for patients
  aged under 70 with `diabetes = 1`. SCORE2 is not intended for, or validated
  in, people with diabetes. The diabetes coefficients came from the derivation
  model used for recalibration, not from the published risk algorithm
  (SCORE2 working group 2021, doi:10.1093/eurheartj/ehab309; Hageman et al.
  2022, doi:10.1093/eurheartj/ehab761, Table 1 footnote). Use
  `SCORE2_Diabetes()` for these patients.
- `SCORE2_scores()`, `SCORE2_CKD_scores()` and `calc_scores()` inherit this:
  their SCORE2 columns are now `NA` for those rows.
- No change for people without diabetes, or for anyone aged 70 or over
  (SCORE2-OP includes diabetes as a predictor).
- Thanks to @meehownow for the report.
- SCORE2 and SCORE2-CKD examples now use patients without diabetes.
- `diabetes` can now be omitted in `SCORE2()` and `SCORE2_CKD()`: it is then
  assumed to be `0` (no diabetes), with a warning so the assumption is never
  silent. Calls that pass `diabetes`, including the data-frame wrappers and
  `calc_scores()`, are unaffected.

# RiskScorescvd 0.3.1

---

### CRAN resubmission fix

- Updated R version requirement from >= 3.1.0 to >= 4.1.0 to match native pipe syntax usage
- No functional changes to package code

---

# RiskScorescvd 0.3.0

---

### Major testing and documentation improvements

- Comprehensive test suite added with 328 tests achieving 93.98% coverage
- New vignette with practical examples and distribution plots added
- All functions now have extensive unit tests covering edge cases and error handling
- Package dependencies properly declared in DESCRIPTION
- Enhanced package reliability and documentation quality

---

# RiskScorescvd 0.2.1

---

### New risk score added and published article

-Article accepted in BMJ Heart

---

## version 0.2.0.9000

---

### New risk scores added

-SCORE2-Asia-Pacific added

---

## version 0.2.0

---

### Two new risk scores added

-SCORE2 updated and CKD add-ons implemented

---

## version 0.0.1

---

### DOI added to description file

- Methods an references added

---

### Package passed all tests 

- Added information suggested by Victoria Wimmer
- All fixed

---

### Pakage Passed all Tests with Notes Only

- Manatainer name
- Global environment


## version 0.0.0.9000

---

### NEWS.md setup

- added NEWS.md creation with [newsmd](https://github.com/Dschaykib/newsmd)

