# Comprehensive tests for HEART function edge cases and coverage

test_that("HEART function parameter validation", {
  
  # Test all valid typical symptom numbers
  for(symptoms in 0:6) {
    result <- HEART(
      typical_symptoms.num = symptoms, ecg.normal = 1, abn.repolarisation = 0,
      ecg.st.depression = 0, Age = 50, diabetes = 0, smoker = 0,
      hypertension = 0, hyperlipidaemia = 0, family.history = 0,
      atherosclerotic.disease = 0, presentation_hstni = 30, Gender = "male",
      classify = FALSE
    )
    expect_type(result, "double")
    expect_false(is.na(result))
  }
  
  # Test age boundaries for different risk categories
  ages <- c(25, 35, 45, 55, 65, 75)
  for(age in ages) {
    result <- HEART(
      typical_symptoms.num = 3, ecg.normal = 1, abn.repolarisation = 0,
      ecg.st.depression = 0, Age = age, diabetes = 0, smoker = 0,
      hypertension = 0, hyperlipidaemia = 0, family.history = 0,
      atherosclerotic.disease = 0, presentation_hstni = 30, Gender = "male",
      classify = FALSE
    )
    expect_type(result, "double")
    expect_false(is.na(result))
  }
  
  # Test troponin thresholds
  troponin_levels <- c(10, 25, 34, 50, 100, 200)
  for(troponin in troponin_levels) {
    result <- HEART(
      typical_symptoms.num = 3, ecg.normal = 1, abn.repolarisation = 0,
      ecg.st.depression = 0, Age = 50, diabetes = 0, smoker = 0,
      hypertension = 0, hyperlipidaemia = 0, family.history = 0,
      atherosclerotic.disease = 0, presentation_hstni = troponin, Gender = "male",
      classify = FALSE
    )
    expect_type(result, "double")
    expect_false(is.na(result))
  }
})

test_that("HEART function ECG combinations", {
  
  # Test all ECG combinations
  ecg_combinations <- expand.grid(
    ecg.normal = c(0, 1),
    abn.repolarisation = c(0, 1),
    ecg.st.depression = c(0, 1)
  )
  
  for(i in 1:nrow(ecg_combinations)) {
    row <- ecg_combinations[i, ]
    result <- HEART(
      typical_symptoms.num = 3, ecg.normal = row$ecg.normal, 
      abn.repolarisation = row$abn.repolarisation,
      ecg.st.depression = row$ecg.st.depression, Age = 50, diabetes = 0, smoker = 0,
      hypertension = 0, hyperlipidaemia = 0, family.history = 0,
      atherosclerotic.disease = 0, presentation_hstni = 30, Gender = "male",
      classify = FALSE
    )
    expect_type(result, "double")
    expect_false(is.na(result))
  }
})

test_that("HEART_scores batch processing", {
  
  # Create large test dataset
  n <- 100
  large_test_data <- data.frame(
    typical_symptoms.num = sample(0:6, n, replace = TRUE),
    ecg.normal = sample(c(0, 1), n, replace = TRUE),
    abn.repolarisation = sample(c(0, 1), n, replace = TRUE),
    ecg.st.depression = sample(c(0, 1), n, replace = TRUE),
    Age = sample(30:80, n, replace = TRUE),
    diabetes = sample(c(0, 1), n, replace = TRUE),
    smoker = sample(c(0, 1), n, replace = TRUE),
    hypertension = sample(c(0, 1), n, replace = TRUE),
    hyperlipidaemia = sample(c(0, 1), n, replace = TRUE),
    family.history = sample(c(0, 1), n, replace = TRUE),
    atherosclerotic.disease = sample(c(0, 1), n, replace = TRUE),
    presentation_hstni = sample(10:100, n, replace = TRUE),
    Gender = sample(c("male", "female"), n, replace = TRUE)
  )
  
  result <- HEART_scores(data = large_test_data, classify = TRUE)
  
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), n)
  expect_true("HEART_score" %in% names(result))
  expect_true("HEART_strat" %in% names(result))
  
  # Check that all scores are in valid range (typically 0-10 for HEART)
  expect_true(all(result$HEART_score >= 0 & result$HEART_score <= 10))
  
  # Check that all stratifications are valid
  valid_strats <- c("Low risk", "Moderate risk", "High risk")
  expect_true(all(result$HEART_strat %in% valid_strats))
})

test_that("HEART function risk stratification boundaries", {
  
  # Test known risk boundaries
  # Low risk: score 0-3
  low_risk_params <- list(
    typical_symptoms.num = 0, ecg.normal = 1, abn.repolarisation = 0,
    ecg.st.depression = 0, Age = 35, diabetes = 0, smoker = 0,
    hypertension = 0, hyperlipidaemia = 0, family.history = 0,
    atherosclerotic.disease = 0, presentation_hstni = 20, Gender = "female"
  )
  
  low_risk_result <- do.call(HEART, c(low_risk_params, classify = TRUE))
  expect_equal(low_risk_result, "Low risk")
  
  # High risk: score 7+
  high_risk_params <- list(
    typical_symptoms.num = 6, ecg.normal = 0, abn.repolarisation = 1,
    ecg.st.depression = 1, Age = 75, diabetes = 1, smoker = 1,
    hypertension = 1, hyperlipidaemia = 1, family.history = 1,
    atherosclerotic.disease = 1, presentation_hstni = 100, Gender = "male"
  )
  
  high_risk_result <- do.call(HEART, c(high_risk_params, classify = TRUE))
  expect_equal(high_risk_result, "High risk")
})
