## Submission

This is an update from 0.3.1 to 0.4.0.

Main changes (see NEWS.md):

* `SCORE2()` and `SCORE2_CKD()` now return `NA` with a warning outside the
  populations the published models were validated for (diabetes under 70,
  age under 40) and for missing inputs, instead of silently extrapolating or
  stopping with an error.
* `SCORE2()` and `SCORE2_CKD()` accept vector inputs.
* Bug fix for risk classification at ages between 69 and 70.
* Corrected a DOI in the Description field.

## R CMD check results

0 errors | 0 warnings | 0 notes

## Test environments

* GitHub Actions: ubuntu-latest (R release, R devel), macos-latest (R release),
  windows-latest (R release)
* win-builder: R release and R devel

## Reverse dependencies

There are currently no reverse dependencies on CRAN.
