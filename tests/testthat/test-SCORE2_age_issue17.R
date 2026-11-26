# Regression tests for GitHub issue #17:
# SCORE2 is validated for ages 40-69 (doi:10.1093/eurheartj/ehab309), so
# SCORE2() and SCORE2_CKD() must return NA with a warning for Age < 40.

score2_age <- function(Age, classify = FALSE, Gender = "male", diabetes = 0) {
  SCORE2(
    Risk.region = "Low", Age = Age, Gender = Gender, smoker = 1,
    systolic.bp = 140, diabetes = diabetes, total.chol = 6.3,
    total.hdl = 1.4, classify = classify
  )
}

test_that("SCORE2 returns NA with a warning under 40 (#17)", {
  for (gender in c("male", "female")) {
    for (age in c(18, 35, 39, 39.9)) {
      expect_warning(
        res <- score2_age(age, Gender = gender),
        "validated for ages 40"
      )
      expect_identical(res, NA_real_)

      expect_warning(cls <- score2_age(age, classify = TRUE, Gender = gender))
      expect_identical(cls, NA_character_)
    }
  }
})

test_that("SCORE2 age boundary: 39 vs 40 (#17)", {
  expect_warning(res_39 <- score2_age(39))
  expect_true(is.na(res_39))

  expect_no_warning(res_40 <- score2_age(40))
  expect_type(res_40, "double")
  expect_false(is.na(res_40))
  expect_no_warning(score2_age(40, classify = TRUE))
})

test_that("Under 40 with diabetes gives a single age warning (#17)", {
  # The age check runs first, so only one warning is raised
  expect_warning(res <- score2_age(35, diabetes = 1), "validated for ages 40")
  expect_true(is.na(res))
})

test_that("SCORE2 with NA age gives NA with a missing-input warning (#17, #21)", {
  expect_warning(res <- score2_age(NA), "missing input\\(s\\): Age")
  expect_identical(res, NA_real_)
})

test_that("SCORE2 results from 40 upwards are unchanged (#17)", {
  # SCORE2 Supplementary Table 4 worked example and SCORE2-OP Table 3 example
  expect_equal(score2_age(50), 6.3)
  expect_equal(
    SCORE2("Low", 75, "male", 1, 140, 0, 5.5, 1.3, classify = FALSE),
    18.6
  )
})

test_that("SCORE2_CKD returns NA with a warning under 40 (#17)", {
  ckd <- function(Age, classify = FALSE) {
    SCORE2_CKD(
      Risk.region = "Low", Age = Age, Gender = "male", smoker = 1,
      systolic.bp = 140, diabetes = 0, total.chol = 6.3, total.hdl = 1.4,
      eGFR = 45, ACR = 150, classify = classify
    )
  }
  expect_warning(res <- ckd(39), "SCORE2_CKD\\(\\).*validated for ages 40")
  expect_identical(res, NA_real_)
  expect_warning(cls <- ckd(39, classify = TRUE))
  expect_identical(cls, NA_character_)
  expect_no_warning(res_40 <- ckd(40))
  expect_false(is.na(res_40))
})

test_that("SCORE2_scores handles mixed ages (#17)", {
  df <- data.frame(
    Age = c(30, 39, 40, 55, 75),
    Gender = c("male", "female", "male", "female", "male"),
    smoker = c(1, 0, 1, 0, 1),
    systolic.bp = c(140, 130, 150, 135, 140),
    diabetes = 0,
    total.chol = c(6.3, 5.5, 6.0, 5.0, 5.5),
    total.hdl = c(1.4, 1.3, 1.2, 1.5, 1.3)
  )
  res <- suppressWarnings(
    SCORE2_scores(data = df, Risk.region = "Low", classify = TRUE)
  )
  expect_equal(is.na(res$SCORE2_score), c(TRUE, TRUE, FALSE, FALSE, FALSE))
  expect_equal(is.na(res$SCORE2_strat), c(TRUE, TRUE, FALSE, FALSE, FALSE))
})
