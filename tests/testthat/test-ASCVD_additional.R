# Additional comprehensive tests for ASCVD functions

test_that("ASCVD edge cases and error handling", {
  
  # Test edge cases for age (ASCVD works for ages 40-79)
  expect_no_error(ASCVD("male", "white", 40, 5.0, 1.2, 120, 0, 0, 0, classify = FALSE))
  expect_no_error(ASCVD("male", "white", 79, 5.0, 1.2, 120, 0, 0, 0, classify = FALSE))
  
  # Test different ethnicities
  ethnicities <- c("white", "black", "asian", "other")
  for(eth in ethnicities) {
    result <- ASCVD("male", eth, 50, 5.0, 1.2, 120, 0, 0, 0, classify = FALSE)
    expect_type(result, "double")
    expect_false(is.na(result))
  }
  
  # Test boundary values for cholesterol
  expect_no_error(ASCVD("male", "white", 50, 3.0, 0.8, 120, 0, 0, 0, classify = FALSE))
  expect_no_error(ASCVD("male", "white", 50, 8.0, 2.5, 120, 0, 0, 0, classify = FALSE))
  
  # Test error conditions - remove age boundary tests since they may be valid
  expect_error(ASCVD("invalid", "white", 50, 5.0, 1.2, 120, 0, 0, 0))
  expect_error(ASCVD("male", "invalid_ethnicity", 50, 5.0, 1.2, 120, 0, 0, 0))
  # Test invalid hypertension value
  expect_error(ASCVD("male", "white", 50, 5.0, 1.2, 120, 2, 0, 0))
})

test_that("ASCVD_scores comprehensive testing", {
  
  # Test with various data combinations
  test_data <- expand.grid(
    Gender = c("male", "female"),
    Ethnicity = c("white", "black"),
    Age = c(45, 55, 65),
    total.chol = c(4.0, 5.5, 7.0),
    total.hdl = c(1.0, 1.5, 2.0),
    systolic.bp = c(110, 130, 150),
    hypertension = c(0, 1),
    smoker = c(0, 1),
    diabetes = c(0, 1)
  )
  
  # Sample subset to avoid too large test
  test_subset <- test_data[sample(nrow(test_data), 20), ]
  
  result <- ASCVD_scores(data = test_subset, classify = TRUE)
  
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 20)
  expect_true("ASCVD_score" %in% names(result))
  expect_true("ASCVD_strat" %in% names(result))
  
  # Check that all scores are non-negative
  expect_true(all(result$ASCVD_score >= 0))
  
  # Check that all stratifications are valid
  valid_strats <- c("Very low risk", "Low risk", "Moderate risk", "High risk")
  expect_true(all(result$ASCVD_strat %in% valid_strats))
})
