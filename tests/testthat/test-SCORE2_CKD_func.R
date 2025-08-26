test_that("SCORE2_CKD function works correctly", {
  
  # Test basic functionality with valid inputs
  result <- SCORE2_CKD(
    Risk.region = "Low", Age = 55, Gender = "male", smoker = 1,
    systolic.bp = 140, diabetes = 0, total.chol = 5.5,
    total.hdl = 1.3, eGFR = 45, ACR = 150, trace = "1+",
    classify = FALSE
  )
  
  expect_type(result, "double")
  expect_length(result, 1)
  expect_false(is.na(result))
  expect_true(result >= 0)
  
  # Test classification
  result_class <- SCORE2_CKD(
    Risk.region = "Low", Age = 65, Gender = "female", smoker = 0,
    systolic.bp = 160, diabetes = 1, total.chol = 6.0,
    total.hdl = 1.0, eGFR = 30, ACR = 300, trace = "2+",
    classify = TRUE
  )
  
  expect_type(result_class, "character")
  expect_true(result_class %in% c("Very low risk", "Low risk", "Moderate risk", "High risk"))
  
  # Test different risk regions
  for(region in c("Low", "Moderate", "High", "Very high")) {
    result_region <- SCORE2_CKD(
      Risk.region = region, Age = 60, Gender = "male", smoker = 0,
      systolic.bp = 130, diabetes = 0, total.chol = 5.0,
      total.hdl = 1.2, eGFR = 50, ACR = 100, trace = "trace",
      classify = FALSE
    )
    expect_type(result_region, "double")
    expect_false(is.na(result_region))
  }
  
  # Test different trace levels
  for(trace_level in c("trace", "1+", "2+", "3+", "4+")) {
    result_trace <- SCORE2_CKD(
      Risk.region = "Low", Age = 60, Gender = "male", smoker = 0,
      systolic.bp = 130, diabetes = 0, total.chol = 5.0,
      total.hdl = 1.2, eGFR = 50, ACR = 100, trace = trace_level,
      classify = FALSE
    )
    expect_type(result_trace, "double")
    expect_false(is.na(result_trace))
  }
  
  # Test edge cases
  expect_error(SCORE2_CKD(Risk.region = "Invalid", Age = 50))
  expect_error(SCORE2_CKD(Risk.region = "Low", Age = 30))  # Too young
  expect_error(SCORE2_CKD(Risk.region = "Low", Age = 50, Gender = "invalid"))
})

test_that("SCORE2_CKD_scores function works correctly", {
  
  # Create test data
  test_data <- data.frame(
    Age = c(50, 60, 70),
    Gender = c("male", "female", "male"),
    smoker = c(0, 1, 0),
    systolic.bp = c(120, 140, 160),
    diabetes = c(0, 0, 1),
    total.chol = c(4.5, 5.5, 6.0),
    total.hdl = c(1.4, 1.2, 1.0),
    eGFR = c(60, 45, 30),
    ACR = c(50, 150, 300),
    trace = c("trace", "1+", "2+")
  )
  
  # Test without classification
  result <- SCORE2_CKD_scores(
    data = test_data, Risk.region = "Low", addon = "ACR", classify = FALSE
  )
  
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 3)
  
  # Test with classification
  result_class <- SCORE2_CKD_scores(
    data = test_data, Risk.region = "Low", addon = "ACR", classify = TRUE
  )
  
  expect_s3_class(result_class, "data.frame")
  
  # Test with trace addon
  result_trace <- SCORE2_CKD_scores(
    data = test_data, Risk.region = "Low", addon = "trace", classify = FALSE
  )
  
  expect_s3_class(result_trace, "data.frame")
  
  # Test error handling
  expect_error(SCORE2_CKD_scores(data = data.frame(), Risk.region = "Low"))
  expect_error(SCORE2_CKD_scores(data = test_data, Risk.region = "Invalid"))
})
