test_that("GRACE function works correctly", {
  
  # Test basic functionality with valid inputs
  result <- GRACE(
    killip.class = 1, systolic.bp = 120, heart.rate = 70,
    Age = 55, creat = 1.2, ecg.st.depression = 1,
    presentation_hstni = 50, cardiac.arrest = 0,
    Gender = "male", classify = FALSE
  )
  
  expect_type(result, "double")
  expect_length(result, 1)
  expect_false(is.na(result))
  expect_true(result >= 0)
  
  # Test classification
  result_class <- GRACE(
    killip.class = 2, systolic.bp = 100, heart.rate = 90,
    Age = 70, creat = 1.8, ecg.st.depression = 1,
    presentation_hstni = 100, cardiac.arrest = 1,
    Gender = "female", classify = TRUE
  )
  
  expect_type(result_class, "character")
  expect_true(result_class %in% c("Low risk", "Moderate risk", "High risk"))
  
  # Test different killip classes
  for(killip in 1:4) {
    result_killip <- GRACE(
      killip.class = killip, systolic.bp = 120, heart.rate = 70,
      Age = 60, creat = 1.0, ecg.st.depression = 0,
      presentation_hstni = 30, cardiac.arrest = 0,
      Gender = "male", classify = FALSE
    )
    expect_type(result_killip, "double")
    expect_false(is.na(result_killip))
  }
  
  # Test edge cases
  expect_error(GRACE(killip.class = 5, systolic.bp = 120))
  expect_error(GRACE(killip.class = 1, systolic.bp = NULL))
  expect_error(GRACE(killip.class = 1, systolic.bp = 120, Gender = "invalid"))
})

test_that("GRACE_scores function works correctly", {
  
  # Create test data
  test_data <- data.frame(
    killip.class = c(1, 2, 3),
    systolic.bp = c(120, 100, 90),
    heart.rate = c(70, 90, 110),
    Age = c(50, 65, 75),
    creat = c(1.0, 1.5, 2.0),
    ecg.st.depression = c(0, 1, 1),
    presentation_hstni = c(20, 60, 120),
    cardiac.arrest = c(0, 0, 1),
    Gender = c("male", "female", "male")
  )
  
  # Test without classification
  result <- GRACE_scores(data = test_data, classify = FALSE)
  
  expect_s3_class(result, "data.frame")
  expect_true("GRACE_score" %in% names(result))
  expect_equal(nrow(result), 3)
  expect_type(result$GRACE_score, "double")
  
  # Test with classification
  result_class <- GRACE_scores(data = test_data, classify = TRUE)
  
  expect_s3_class(result_class, "data.frame")
  expect_true("GRACE_score" %in% names(result_class))
  expect_true("GRACE_strat" %in% names(result_class))
  expect_s3_class(result_class$GRACE_strat, "factor")
  
  # Test error handling
  expect_error(GRACE_scores(data = data.frame()))
  expect_error(GRACE_scores(data = NULL))
})
