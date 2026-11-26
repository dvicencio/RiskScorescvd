# Regression tests: ages between 69 and 70 fell into a gap between the
# "50-69" and ">= 70" risk bands, so classify = TRUE returned base::class
# (a function) instead of a risk group. Bands follow the 2021 ESC
# prevention guidelines (doi:10.1093/eurheartj/ehab484): <50, 50-69, >=70.

band_class <- function(age, score) {
  cuts <- if (age < 50) c(2.5, 7.5) else if (age < 70) c(5, 10) else c(7.5, 15)
  c("Low risk", "Moderate risk", "High risk")[findInterval(score, cuts) + 1]
}

test_that("SCORE2 classifies non-integer ages between 69 and 70", {
  for (age in c(69, 69.1, 69.5, 69.99)) {
    for (gender in c("male", "female")) {
      for (smoker in c(0, 1)) {
        score <- SCORE2("Low", age, gender, smoker, 160, 0, 7, 1.0, classify = FALSE)
        cls <- SCORE2("Low", age, gender, smoker, 160, 0, 7, 1.0, classify = TRUE)
        expect_type(cls, "character")
        expect_identical(cls, band_class(age, score))
      }
    }
  }
})

test_that("SCORE2 band boundaries at 50 and 70 are unchanged", {
  for (age in c(49, 49.5, 50, 70, 70.5)) {
    score <- SCORE2("High", age, "male", 1, 150, 0, 6.5, 1.1, classify = FALSE)
    cls <- SCORE2("High", age, "male", 1, 150, 0, 6.5, 1.1, classify = TRUE)
    expect_identical(cls, band_class(age, score))
  }
})

test_that("SCORE2_CKD classifies non-integer ages between 69 and 70", {
  for (age in c(69.5, 69.99)) {
    score <- SCORE2_CKD("Low", age, "male", 1, 160, 0, 7, 1.0, eGFR = 45,
                        ACR = 150, classify = FALSE)
    cls <- SCORE2_CKD("Low", age, "male", 1, 160, 0, 7, 1.0, eGFR = 45,
                      ACR = 150, classify = TRUE)
    expect_type(cls, "character")
    expect_identical(cls, band_class(age, score))
  }
})
