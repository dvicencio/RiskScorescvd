# Comprehensive tests for CAD Consortium function

test_that("CAD_Consortium_func basic functionality", {
  
  # Test basic model
  result_basic <- CAD_Consortium_func(Age = 60, Sex = "male", ChestPainType = 3, model_type = "basic")
  expect_type(result_basic, "double")
  expect_true(result_basic >= 0 && result_basic <= 100)
  
  # Test clinical model without classification
  result_clinical <- CAD_Consortium_func(
    Age = 55, Sex = "female", ChestPainType = 2, 
    Diabetes = 1, Hypertension = 1, Dyslipidaemia = 1, Smoking = 0,
    model_type = "clinical", classify = FALSE
  )
  expect_type(result_clinical, "double")
  expect_true(result_clinical >= 0 && result_clinical <= 100)
  
  # Test clinical model with classification
  result_clinical_class <- CAD_Consortium_func(
    Age = 65, Sex = "male", ChestPainType = 3,
    Diabetes = 1, Hypertension = 1, Dyslipidaemia = 1, Smoking = 1,
    model_type = "clinical", classify = TRUE
  )
  expect_type(result_clinical_class, "character")
  valid_classes <- c("Very low (<5%)", "Low (<15%)", "Intermediate (15-85%)", "High (>85%)", 
                     "Low (<15%)", "Intermediate (15-50%)", "High (50-85%)", "Very high (>85%)")
  expect_true(result_clinical_class %in% valid_classes)
})

test_that("CAD_Consortium_func comprehensive parameter testing", {
  
  # Test chest pain types 1-3 (not 1-4)
  for(pain_type in 1:3) {
    result <- CAD_Consortium_func(Age = 55, Sex = "male", ChestPainType = pain_type, model_type = "basic")
    expect_type(result, "double")
    expect_false(is.na(result))
  }
  
  # Test both sexes
  for(sex in c("male", "female")) {
    result <- CAD_Consortium_func(Age = 50, Sex = sex, ChestPainType = 2, model_type = "basic")
    expect_type(result, "double")
    expect_false(is.na(result))
  }
  
  # Test age range
  ages <- c(30, 40, 50, 60, 70, 80)
  for(age in ages) {
    result <- CAD_Consortium_func(Age = age, Sex = "male", ChestPainType = 2, model_type = "basic")
    expect_type(result, "double")
    expect_false(is.na(result))
  }
  
  # Test clinical model with different risk factor combinations
  risk_combinations <- expand.grid(
    Diabetes = c(0, 1),
    Hypertension = c(0, 1),
    Dyslipidaemia = c(0, 1),
    Smoking = c(0, 1)
  )
  
  for(i in 1:min(8, nrow(risk_combinations))) {
    row <- risk_combinations[i, ]
    result <- CAD_Consortium_func(
      Age = 55, Sex = "male", ChestPainType = 2,
      Diabetes = row$Diabetes, Hypertension = row$Hypertension,
      Dyslipidaemia = row$Dyslipidaemia, Smoking = row$Smoking,
      model_type = "clinical"
    )
    expect_type(result, "double")
    expect_false(is.na(result))
  }
})

test_that("CAD_Consortium_func error handling", {
  
  # Test invalid model type
  expect_error(CAD_Consortium_func(Age = 50, Sex = "male", ChestPainType = 2, model_type = "invalid"))
  
  # Test invalid chest pain type (only these actually cause errors based on function code)
  expect_error(CAD_Consortium_func(Age = 50, Sex = "male", ChestPainType = 4, model_type = "basic"))
  expect_error(CAD_Consortium_func(Age = 50, Sex = "male", ChestPainType = 0, model_type = "basic"))
  
  # Test that function handles various sex inputs (doesn't error, treats non-male as female)
  expect_no_error(CAD_Consortium_func(Age = 50, Sex = "invalid", ChestPainType = 2, model_type = "basic"))
  expect_no_error(CAD_Consortium_func(Age = 50, Sex = "female", ChestPainType = 2, model_type = "basic"))
  
  # Test that clinical model works without explicit risk factors (uses defaults)
  expect_no_error(CAD_Consortium_func(Age = 50, Sex = "male", ChestPainType = 2, model_type = "clinical"))
})
