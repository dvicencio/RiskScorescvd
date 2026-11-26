# Tests for GitHub issue #18: SCORE2() and SCORE2_CKD() accept vectors and
# give results identical to scoring each row separately.

vec_data <- data.frame(
  Age = c(40, 50, 50, 55, 69, 70, 75, 75, 35, 60),
  Gender = c("male", "male", "female", "female", "male",
             "female", "male", "female", "male", "male"),
  smoker = c(0, 1, 1, 0, 1, 0, 1, 1, 0, 1),
  systolic.bp = c(120, 140, 140, 130, 150, 135, 140, 140, 120, 160),
  diabetes = c(0, 0, 0, 0, 0, 1, 0, 0, 0, 1), # row 10: diabetic under 70
  total.chol = c(5.0, 6.3, 6.3, 5.5, 6.0, 5.0, 5.5, 5.5, 5.0, 6.5),
  total.hdl = c(1.2, 1.4, 1.4, 1.3, 1.2, 1.5, 1.3, 1.3, 1.2, 1.1),
  eGFR = c(90, 60, 45, 80, 50, 70, 40, 55, 90, 60),
  ACR = c(10, 30, 150, 20, 300, 50, 100, 30, 10, 40)
)

row_by_row <- function(f, data, ...) {
  out <- lapply(seq_len(nrow(data)), function(i) {
    suppressWarnings(f(
      Risk.region = "Low", Age = data$Age[i], Gender = data$Gender[i],
      smoker = data$smoker[i], systolic.bp = data$systolic.bp[i],
      diabetes = data$diabetes[i], total.chol = data$total.chol[i],
      total.hdl = data$total.hdl[i], ...
    ))
  })
  unlist(out)
}

test_that("SCORE2 vector input matches row-by-row results (#18)", {
  for (cls in c(FALSE, TRUE)) {
    expected <- row_by_row(SCORE2, vec_data, classify = cls)
    got <- suppressWarnings(SCORE2(
      Risk.region = "Low", Age = vec_data$Age, Gender = vec_data$Gender,
      smoker = vec_data$smoker, systolic.bp = vec_data$systolic.bp,
      diabetes = vec_data$diabetes, total.chol = vec_data$total.chol,
      total.hdl = vec_data$total.hdl, classify = cls
    ))
    expect_identical(got, expected)
    expect_length(got, nrow(vec_data))
  }
})

test_that("SCORE2 vector input keeps published values and NA rows (#18)", {
  got <- suppressWarnings(SCORE2(
    "Low", vec_data$Age, vec_data$Gender, vec_data$smoker,
    vec_data$systolic.bp, vec_data$diabetes, vec_data$total.chol,
    vec_data$total.hdl, classify = FALSE
  ))
  expect_type(got, "double")
  # SCORE2 Supp. Table 4 (rows 2-3) and SCORE2-OP Supp. Table 3 (rows 7-8)
  expect_equal(got[c(2, 3, 7, 8)], c(6.3, 4.3, 18.6, 15.2))
  # Row 9: age 35 (#17); row 10: diabetic under 70 (#15)
  expect_true(all(is.na(got[c(9, 10)])))
  expect_false(anyNA(got[1:8]))
})

test_that("SCORE2 recycles length-1 inputs and vectorises Risk.region (#18)", {
  regions <- c("Low", "Moderate", "High", "Very high")
  got <- SCORE2(regions, 50, "male", 1, 140, 0, 6.3, 1.4, classify = FALSE)
  # SCORE2 Supplementary Table 4, men aged 50
  expect_equal(got, c(6.3, 8.1, 8.8, 15.1))
})

test_that("SCORE2 single-row calls are unchanged (#18)", {
  expect_equal(SCORE2("Low", 50, "female", 1, 140, 0, 6.3, 1.4, classify = FALSE), 4.3)
  expect_identical(
    SCORE2("Low", 50, "female", 1, 140, 0, 6.3, 1.4, classify = TRUE),
    "Low risk"
  )
})

test_that("SCORE2 errors informatively on mismatched lengths (#18)", {
  expect_error(
    SCORE2("Low", c(50, 60, 70), c("male", "female"), 1, 140, 0, 6.3, 1.4,
           classify = FALSE),
    "length 1 or the same length.*Gender"
  )
  expect_error(
    SCORE2("Low", numeric(0), "male", 1, 140, 0, 6.3, 1.4, classify = FALSE),
    "Age"
  )
})

test_that("SCORE2_CKD vector input matches row-by-row results (#18)", {
  for (cls in c(FALSE, TRUE)) {
    expected <- unlist(lapply(seq_len(nrow(vec_data)), function(i) {
      suppressWarnings(SCORE2_CKD(
        Risk.region = "Low", Age = vec_data$Age[i], Gender = vec_data$Gender[i],
        smoker = vec_data$smoker[i], systolic.bp = vec_data$systolic.bp[i],
        diabetes = vec_data$diabetes[i], total.chol = vec_data$total.chol[i],
        total.hdl = vec_data$total.hdl[i], eGFR = vec_data$eGFR[i],
        ACR = vec_data$ACR[i], classify = cls
      ))
    }))
    got <- suppressWarnings(SCORE2_CKD(
      Risk.region = "Low", Age = vec_data$Age, Gender = vec_data$Gender,
      smoker = vec_data$smoker, systolic.bp = vec_data$systolic.bp,
      diabetes = vec_data$diabetes, total.chol = vec_data$total.chol,
      total.hdl = vec_data$total.hdl, eGFR = vec_data$eGFR,
      ACR = vec_data$ACR, classify = cls
    ))
    expect_identical(got, expected)
  }
})

test_that("SCORE2_CKD errors informatively on mismatched lengths (#18)", {
  expect_error(
    SCORE2_CKD("Low", c(50, 60), "male", 1, 140, 0, 6.3, 1.4,
               eGFR = c(60, 45, 30), classify = FALSE),
    "SCORE2_CKD\\(\\).*length 1 or the same length.*Age"
  )
})
