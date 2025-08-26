test_that("TIMI function works correctly", {
  
  # Test basic functionality with valid inputs
  result <- TIMI(
    Age = 65, hypertension = 1, hyperlipidaemia = 1,
    family.history = 1, diabetes = 1, smoker = 1,
    previous.pci = 0, previous.cabg = 0, aspirin = 1,
    number.of.episodes.24h = 2, ecg.st.depression = 1,
    presentation_hstni = 50, Gender = "male", classify = FALSE
  )
  
  expect_type(result, "double")
  expect_length(result, 1)
  expect_false(is.na(result))
  expect_true(result >= 0)
  
  # Test classification
  result_class <- TIMI(
    Age = 75, hypertension = 1, hyperlipidaemia = 1,
    family.history = 1, diabetes = 1, smoker = 1,
    previous.pci = 1, previous.cabg = 1, aspirin = 1,
    number.of.episodes.24h = 3, ecg.st.depression = 1,
    presentation_hstni = 100, Gender = "female", classify = TRUE
  )
  
  expect_type(result_class, "character")
  expect_true(result_class %in% c("Very low risk", "Low risk", "Moderate risk", "High risk"))
  
  # Test minimum score (young, no risk factors)
  result_min <- TIMI(
    Age = 40, hypertension = 0, hyperlipidaemia = 0,
    family.history = 0, diabetes = 0, smoker = 0,
    previous.pci = 0, previous.cabg = 0, aspirin = 0,
    number.of.episodes.24h = 0, ecg.st.depression = 0,
    presentation_hstni = 10, Gender = "female", classify = FALSE
  )
  
  expect_type(result_min, "double")
  expect_true(result_min >= 0)
  
  # Test edge cases
  expect_error(TIMI(Age = NULL, Gender = "male"))
  expect_error(TIMI(Age = 50, Gender = "invalid"))
  expect_error(TIMI(Age = 50, Gender = "male", diabetes = 2))
})

test_that("TIMI_scores function works correctly", {
  
  # Create test data
  test_data <- data.frame(
    Age = c(45, 65, 75),
    hypertension = c(0, 1, 1),
    hyperlipidaemia = c(1, 1, 0),
    family.history = c(1, 0, 1),
    diabetes = c(0, 1, 1),
    smoker = c(1, 0, 1),
    previous.pci = c(0, 1, 0),
    previous.cabg = c(0, 0, 1),
    aspirin = c(1, 1, 0),
    number.of.episodes.24h = c(1, 2, 3),
    ecg.st.depression = c(0, 1, 1),
    presentation_hstni = c(20, 50, 80),
    Gender = c("male", "female", "male")
  )
  
  # Test without classification
  result <- TIMI_scores(data = test_data, classify = FALSE)
  
  expect_s3_class(result, "data.frame")
  expect_true("TIMI_score" %in% names(result))
  expect_equal(nrow(result), 3)
  expect_type(result$TIMI_score, "double")
  
  # Test with classification
  result_class <- TIMI_scores(data = test_data, classify = TRUE)
  
  expect_s3_class(result_class, "data.frame")
  expect_true("TIMI_score" %in% names(result_class))
  expect_true("TIMI_strat" %in% names(result_class))
  expect_s3_class(result_class$TIMI_strat, "factor")
  
  # Test error handling
  expect_error(TIMI_scores(data = data.frame()))
  expect_error(TIMI_scores(data = NULL))
})
