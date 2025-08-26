test_that("EDACS function works correctly", {
  
  # Test basic functionality with valid inputs
  result <- EDACS(
    Age = 50, Gender = "male", diabetes = 1, smoker = 1,
    hypertension = 1, hyperlipidaemia = 1, family.history = 1,
    sweating = 1, pain.radiation = 1, pleuritic = 0, palpation = 0,
    ecg.st.depression = 1, ecg.twi = 1, presentation_hstni = 50,
    second_hstni = 100, classify = FALSE
  )
  
  expect_type(result, "double")
  expect_length(result, 1)
  expect_false(is.na(result))
  
  # Test classification
  result_class <- EDACS(
    Age = 50, Gender = "male", diabetes = 1, smoker = 1,
    hypertension = 1, hyperlipidaemia = 1, family.history = 1,
    sweating = 1, pain.radiation = 1, pleuritic = 0, palpation = 0,
    ecg.st.depression = 1, ecg.twi = 1, presentation_hstni = 50,
    second_hstni = 100, classify = TRUE
  )
  
  expect_type(result_class, "character")
  expect_true(result_class %in% c("Low risk", "Not low risk"))
  
  # Test with female gender
  result_female <- EDACS(
    Age = 45, Gender = "female", diabetes = 0, smoker = 0,
    hypertension = 0, hyperlipidaemia = 0, family.history = 0,
    sweating = 0, pain.radiation = 0, pleuritic = 1, palpation = 1,
    ecg.st.depression = 0, ecg.twi = 0, presentation_hstni = 10,
    second_hstni = 20, classify = FALSE
  )
  
  expect_type(result_female, "double")
  expect_false(is.na(result_female))
  
  # Test edge cases
  expect_error(EDACS(Age = NULL, Gender = "male"))
  expect_error(EDACS(Age = 50, Gender = "invalid"))
  expect_error(EDACS(Age = 50, Gender = "male", diabetes = 2))
})

test_that("EDACS_scores function works correctly", {
  
  # Create test data
  test_data <- data.frame(
    Age = c(45, 55, 65),
    Gender = c("male", "female", "male"),
    diabetes = c(0, 1, 0),
    smoker = c(1, 0, 1),
    hypertension = c(1, 1, 0),
    hyperlipidaemia = c(0, 1, 1),
    family.history = c(1, 0, 1),
    sweating = c(1, 0, 0),
    pain.radiation = c(1, 1, 0),
    pleuritic = c(0, 1, 0),
    palpation = c(0, 0, 1),
    ecg.st.depression = c(1, 0, 1),
    ecg.twi = c(0, 1, 0),
    presentation_hstni = c(30, 50, 20),
    second_hstni = c(60, 100, 40)
  )
  
  # Test without classification
  result <- EDACS_scores(data = test_data, classify = FALSE)
  
  expect_s3_class(result, "data.frame")
  expect_true("EDACS_score" %in% names(result))
  expect_equal(nrow(result), 3)
  expect_type(result$EDACS_score, "double")
  
  # Test with classification
  result_class <- EDACS_scores(data = test_data, classify = TRUE)
  
  expect_s3_class(result_class, "data.frame")
  expect_true("EDACS_score" %in% names(result_class))
  expect_true("EDACS_strat" %in% names(result_class))
  expect_s3_class(result_class$EDACS_strat, "factor")
  
  # Test error handling
  expect_error(EDACS_scores(data = data.frame()))
  expect_error(EDACS_scores(data = NULL))
})
