# Regression tests for GitHub issue #21: any missing required input in
# SCORE2() or SCORE2_CKD() gives NA with a warning naming the input(s).

base_args <- list(
  Risk.region = "Low", Age = 50, Gender = "male", smoker = 1,
  systolic.bp = 140, diabetes = 0, total.chol = 6.3, total.hdl = 1.4
)

test_that("Each missing SCORE2 input gives NA with a named warning (#21)", {
  for (input in names(base_args)) {
    args <- base_args
    args[[input]] <- NA

    expect_warning(
      res <- do.call(SCORE2, c(args, classify = FALSE)),
      paste0("missing input\\(s\\): ", input, "\\.")
    )
    expect_identical(res, NA_real_)

    expect_warning(
      cls <- do.call(SCORE2, c(args, classify = TRUE)),
      input
    )
    expect_identical(cls, NA_character_)
  }
})

test_that("Missing Age, Gender or Risk.region no longer error (#21)", {
  for (input in c("Age", "Gender", "Risk.region")) {
    args <- base_args
    args[[input]] <- NA
    expect_no_error(suppressWarnings(do.call(SCORE2, c(args, classify = FALSE))))
  }
})

test_that("Several missing inputs are all named in one warning (#21)", {
  args <- base_args
  args$smoker <- NA
  args$total.hdl <- NA
  expect_warning(
    res <- do.call(SCORE2, c(args, classify = FALSE)),
    "missing input\\(s\\): smoker, total.hdl\\."
  )
  expect_true(is.na(res))
})

test_that("Typed NAs are treated as missing (#21)", {
  args <- base_args
  args$Age <- NA_real_
  args$Gender <- NA_character_
  expect_warning(
    res <- do.call(SCORE2, c(args, classify = FALSE)),
    "Age, Gender"
  )
  expect_true(is.na(res))
})

test_that("Complete inputs are unchanged and give no warning (#21)", {
  # SCORE2 Supplementary Table 4, low-risk region, men aged 50
  expect_no_warning(res <- do.call(SCORE2, c(base_args, classify = FALSE)))
  expect_equal(res, 6.3)
})

test_that("An invalid but present Risk.region is still an error (#21)", {
  args <- base_args
  args$Risk.region <- "Very High"
  expect_error(suppressMessages(do.call(SCORE2, c(args, classify = FALSE))))
})

test_that("SCORE2 vector input with missing values (#21)", {
  res <- suppressWarnings(SCORE2(
    "Low", c(50, NA, 50), c("male", "male", NA), 1, 140, 0, 6.3, 1.4,
    classify = FALSE
  ))
  expect_equal(res[1], 6.3)
  expect_true(all(is.na(res[2:3])))
})

test_that("SCORE2_scores no longer stops on a missing Age (#21)", {
  df <- data.frame(
    Age = c(50, NA, 75), Gender = c("male", "female", "male"),
    smoker = c(1, 1, 1), systolic.bp = c(140, 140, 140), diabetes = 0,
    total.chol = c(6.3, 6.3, 5.5), total.hdl = c(1.4, 1.4, 1.3)
  )
  res <- suppressWarnings(
    SCORE2_scores(data = df, Risk.region = "Low", classify = FALSE)
  )
  expect_equal(is.na(res$SCORE2_score), c(FALSE, TRUE, FALSE))
  expect_equal(res$SCORE2_score[c(1, 3)], c(6.3, 18.6))
})

test_that("SCORE2_CKD: missing required inputs give NA with a warning (#21)", {
  ckd <- function(...) {
    args <- utils::modifyList(
      c(base_args, list(eGFR = 45, ACR = 150, classify = FALSE)),
      list(...)
    )
    do.call(SCORE2_CKD, args)
  }
  expect_warning(res <- ckd(eGFR = NA), "SCORE2_CKD\\(\\).*missing input\\(s\\): eGFR")
  expect_identical(res, NA_real_)
  expect_warning(res <- ckd(Age = NA), "Age")
  expect_identical(res, NA_real_)

  # ACR and trace are optional: NA is not a missing-input warning
  expect_no_warning(res <- ckd(ACR = NA))
  expect_false(is.na(res))
})
