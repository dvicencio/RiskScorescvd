# Additional comprehensive tests for SCORE2 functions

test_that("SCORE2 function boundary testing", {
  
  # Test age boundaries
  expect_no_error(SCORE2("Low", 40, "male", 0, 120, 0, 5.0, 1.2, classify = FALSE))
  expect_no_error(SCORE2("Low", 89, "male", 0, 120, 0, 5.0, 1.2, classify = FALSE))
  
  # Test different risk regions
  risk_regions <- c("Low", "Moderate", "High", "Very high")
  for(region in risk_regions) {
    result <- SCORE2(region, 50, "male", 0, 120, 0, 5.0, 1.2, classify = FALSE)
    expect_type(result, "double")
    expect_false(is.na(result))
  }
  
  # Test extreme values
  result_high_risk <- SCORE2("Low", 75, "male", 1, 180, 1, 7.0, 0.8, classify = FALSE)
  result_low_risk <- SCORE2("Low", 40, "female", 0, 110, 0, 4.0, 2.0, classify = FALSE)
  
  expect_type(result_high_risk, "double")
  expect_type(result_low_risk, "double")
  expect_true(result_high_risk > result_low_risk)
})

test_that("SCORE2_scores comprehensive testing", {
  
  # Create comprehensive test data
  test_data <- data.frame(
    Age = rep(c(45, 55, 65, 75), each = 4),
    Gender = rep(c("male", "female"), 8),
    smoker = rep(c(0, 1), each = 2, times = 4),
    systolic.bp = rep(c(120, 140, 160, 180), 4),
    diabetes = c(rep(0, 8), rep(1, 8)),
    total.chol = rep(c(4.5, 5.5, 6.5, 7.5), 4),
    total.hdl = rep(c(1.0, 1.3, 1.6, 1.9), 4)
  )
  
  result <- SCORE2_scores(data = test_data, Risk.region = "Low", classify = TRUE)
  
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 16)
  expect_true("SCORE2_score" %in% names(result))
  expect_true("SCORE2_strat" %in% names(result))
  
  # Verify all scores are positive
  expect_true(all(result$SCORE2_score > 0))
  
  # Test different risk regions
  for(region in c("Low", "Moderate", "High", "Very high")) {
    result_region <- SCORE2_scores(data = test_data[1:4, ], Risk.region = region, classify = FALSE)
    expect_s3_class(result_region, "data.frame")
    expect_equal(nrow(result_region), 4)
  }
})

test_that("SCORE2 error handling", {
  
  # Test invalid inputs
  expect_error(SCORE2("Invalid", 50, "male", 0, 120, 0, 5.0, 1.2))
  expect_error(SCORE2("Low", 35, "male", 0, 120, 0, 5.0, 1.2))  # Too young
  expect_error(SCORE2("Low", 95, "male", 0, 120, 0, 5.0, 1.2))  # Too old
  expect_error(SCORE2("Low", 50, "invalid", 0, 120, 0, 5.0, 1.2))
  expect_error(SCORE2("Low", 50, "male", 2, 120, 0, 5.0, 1.2))  # Invalid smoker
  expect_error(SCORE2("Low", 50, "male", 0, 120, 2, 5.0, 1.2))  # Invalid diabetes
})
