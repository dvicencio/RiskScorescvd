# RiskScorescvd (development version, planned 0.4.0)

---

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

