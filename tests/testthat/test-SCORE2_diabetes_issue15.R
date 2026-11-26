# Regression tests for GitHub issue #15:
# SCORE2 (ages < 70) is not validated in people with diabetes, so SCORE2()
# and SCORE2_CKD() must return NA with a warning for diabetes = 1, Age < 70.
# SCORE2-OP (ages >= 70) includes diabetes as a predictor and is unaffected.

score2_call <- function(Age, diabetes, classify = FALSE, Gender = "male") {
  SCORE2(
    Risk.region = "Low", Age = Age, Gender = Gender, smoker = 1,
    systolic.bp = 140, diabetes = diabetes, total.chol = 6.3,
    total.hdl = 1.4, classify = classify
  )
}

score2_ckd_call <- function(Age, diabetes, classify = FALSE) {
  SCORE2_CKD(
    Risk.region = "Low", Age = Age, Gender = "male", smoker = 1,
    systolic.bp = 140, diabetes = diabetes, total.chol = 6.3,
    total.hdl = 1.4, eGFR = 45, ACR = 150, classify = classify
  )
}

test_that("SCORE2 returns NA with a warning for diabetes under 70 (#15)", {
  for (gender in c("male", "female")) {
    for (age in c(40, 50, 69)) {
      expect_warning(
        res <- score2_call(age, diabetes = 1, Gender = gender),
        "not validated in people with diabetes"
      )
      expect_identical(res, NA_real_)

      expect_warning(
        cls <- score2_call(age, diabetes = 1, classify = TRUE, Gender = gender),
        "SCORE2_Diabetes"
      )
      expect_identical(cls, NA_character_)
    }
  }
})

test_that("SCORE2 age boundary: 69 vs 70 with diabetes (#15)", {
  # 69: SCORE2 -> out of scope
  expect_warning(res_69 <- score2_call(69, diabetes = 1))
  expect_true(is.na(res_69))

  # 70: SCORE2-OP -> diabetes is a valid predictor, no warning
  expect_no_warning(res_70 <- score2_call(70, diabetes = 1))
  expect_type(res_70, "double")
  expect_false(is.na(res_70))
  expect_gt(res_70, score2_call(70, diabetes = 0))
})

test_that("SCORE2-OP diabetic results are unaffected (#15)", {
  # SCORE2-OP Supplementary Table 3 case (published 18.6% when non-diabetic);
  # adding diabetes must give a higher risk and no warning
  op_dm0 <- SCORE2("Low", 75, "male", 1, 140, 0, 5.5, 1.3, classify = FALSE)
  expect_equal(op_dm0, 18.6)
  expect_no_warning(
    op_dm1 <- SCORE2("Low", 75, "male", 1, 140, 1, 5.5, 1.3, classify = FALSE)
  )
  expect_gt(op_dm1, op_dm0)
})

test_that("SCORE2 non-diabetic results are unchanged (#15)", {
  # SCORE2 Supplementary Table 4 worked examples (low-risk region)
  expect_no_warning(m <- score2_call(50, diabetes = 0, Gender = "male"))
  expect_no_warning(f <- score2_call(50, diabetes = 0, Gender = "female"))
  expect_equal(m, 6.3)
  expect_equal(f, 4.3)
  expect_no_warning(score2_call(69, diabetes = 0))
})

test_that("SCORE2 with NA diabetes gives NA with a missing-input warning (#15, #21)", {
  expect_warning(res <- score2_call(50, diabetes = NA), "missing input")
  expect_true(is.na(res))
})

test_that("SCORE2_CKD returns NA with a warning for diabetes under 70 (#15)", {
  expect_warning(
    res <- score2_ckd_call(60, diabetes = 1),
    "SCORE2_CKD\\(\\).*not validated in people with diabetes"
  )
  expect_identical(res, NA_real_)

  expect_warning(cls <- score2_ckd_call(69, diabetes = 1, classify = TRUE))
  expect_identical(cls, NA_character_)

  # Boundary: 70+ uses SCORE2-OP, unaffected
  expect_no_warning(res_70 <- score2_ckd_call(70, diabetes = 1))
  expect_false(is.na(res_70))

  # Non-diabetic under 70 unaffected
  expect_no_warning(res_dm0 <- score2_ckd_call(60, diabetes = 0))
  expect_false(is.na(res_dm0))
})

test_that("SCORE2_scores handles mixed rows (#15)", {
  df <- data.frame(
    Age = c(55, 55, 69, 70, 75),
    Gender = c("male", "female", "male", "male", "female"),
    smoker = c(1, 0, 1, 1, 0),
    systolic.bp = c(140, 130, 150, 140, 135),
    diabetes = c(0, 1, 1, 1, 0),
    total.chol = c(6.3, 5.5, 6.0, 5.5, 5.0),
    total.hdl = c(1.4, 1.3, 1.2, 1.3, 1.5)
  )

  res <- suppressWarnings(
    SCORE2_scores(data = df, Risk.region = "Low", classify = TRUE)
  )

  expect_equal(is.na(res$SCORE2_score), c(FALSE, TRUE, TRUE, FALSE, FALSE))
  expect_equal(is.na(res$SCORE2_strat), c(FALSE, TRUE, TRUE, FALSE, FALSE))
})

omitted_msg <- "diabetes not supplied, so it was assumed to be 0"

test_that("Omitted diabetes is assumed 0, with a warning (#15)", {
  # SCORE2 Supplementary Table 4, low-risk region, men aged 50
  expect_warning(
    m <- SCORE2(Risk.region = "Low", Age = 50, Gender = "male", smoker = 1,
                systolic.bp = 140, total.chol = 6.3, total.hdl = 1.4,
                classify = FALSE),
    omitted_msg
  )
  expect_equal(m, 6.3)
  expect_identical(m, score2_call(50, diabetes = 0, Gender = "male"))

  # Classification too
  expect_warning(
    cls <- SCORE2("Low", 50, "male", 1, 140, total.chol = 6.3,
                  total.hdl = 1.4, classify = TRUE),
    omitted_msg
  )
  expect_identical(cls, score2_call(50, diabetes = 0, classify = TRUE))

  # SCORE2-OP: omitted equals explicit 0, and still warns
  expect_warning(
    op <- SCORE2("Low", 75, "male", 1, 140, total.chol = 5.5,
                 total.hdl = 1.3, classify = FALSE),
    omitted_msg
  )
  expect_identical(op, SCORE2("Low", 75, "male", 1, 140, 0, 5.5, 1.3, classify = FALSE))
})

test_that("Explicit diabetes never gives the omitted warning (#15)", {
  expect_no_warning(score2_call(50, diabetes = 0))
  w1 <- tryCatch(score2_call(50, diabetes = 1), warning = conditionMessage)
  expect_match(w1, "SCORE2_Diabetes")
  expect_no_match(w1, "not supplied")
  wna <- tryCatch(score2_call(50, diabetes = NA), warning = conditionMessage)
  expect_match(wna, "missing input")
  expect_no_match(wna, "not supplied")
})

test_that("Omitted diabetes with vector input warns once (#15)", {
  msgs <- character()
  res <- withCallingHandlers(
    SCORE2("Low", c(50, 50, 75), c("male", "female", "male"), 1, 140,
           total.chol = c(6.3, 6.3, 5.5), total.hdl = c(1.4, 1.4, 1.3),
           classify = FALSE),
    warning = function(w) {
      msgs <<- c(msgs, conditionMessage(w))
      invokeRestart("muffleWarning")
    }
  )
  expect_length(msgs, 1)
  expect_match(msgs, omitted_msg)
  # SCORE2 Supp. Table 4 (men, women aged 50) and SCORE2-OP Supp. Table 3
  expect_equal(res, c(6.3, 4.3, 18.6))
})

test_that("SCORE2_CKD: omitted diabetes is assumed 0, with a warning (#15)", {
  ckd_args <- list(Risk.region = "Low", Age = 60, Gender = "male", smoker = 1,
                   systolic.bp = 140, total.chol = 6.3, total.hdl = 1.4,
                   eGFR = 45, ACR = 150, classify = FALSE)
  expect_warning(res <- do.call(SCORE2_CKD, ckd_args),
                 "SCORE2_CKD\\(\\): diabetes not supplied")
  expect_no_warning(res0 <- do.call(SCORE2_CKD, c(ckd_args, diabetes = 0)))
  expect_identical(res, res0)
})

test_that("Data-frame wrappers pass diabetes, so they never warn about it (#15)", {
  df <- data.frame(Age = c(50, 75), Gender = "male", smoker = 1,
                   systolic.bp = 140, diabetes = 0, total.chol = c(6.3, 5.5),
                   total.hdl = c(1.4, 1.3))
  expect_no_warning(res <- SCORE2_scores(data = df, Risk.region = "Low", classify = FALSE))
  expect_equal(res$SCORE2_score, c(6.3, 18.6))
})
