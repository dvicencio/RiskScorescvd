test_that("SCORE2-Diabetes function works on example data from journal", {
  # Use journal as reference
  # Example data is taken from Structured Graphical Abstract from SCORE2-Diabetes paper

  graphical_abstract_medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_current_smoker, ~systolic_bp,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    ~have_diabetes, ~diabetes_age,
    ~hba1c_mmol_mol, ~eGFR_mL_min_1_73_m2,
    # 60 years old male from low risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Low", 60, "male", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old female from low risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Low", 60, "female", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old male from moderate risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Moderate", 60, "male", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old female from moderate risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Moderate", 60, "female", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old male from high risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "High", 60, "male", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old female from high risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "High", 60, "female", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old male from very high risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Very high", 60, "male", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old female from very high risk region who is a non-smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Very high", 60, "female", 0, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old male from low risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "Low", 60, "male", 0, 140, 5.5, 1.3, 1, 50, 70, 60,
    # 60 years old female from low risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "Low", 60, "female", 0, 140, 5.5, 1.3, 1, 50, 70, 60,
    # 60 years old male from moderate risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "Moderate", 60, "male", 0, 140, 5.5, 1.3, 1, 50, 70, 60,
    # 60 years old female from moderate risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "Moderate", 60, "female", 0, 140, 5.5, 1.3, 1, 50, 70, 60,
    # 60 years old male from high risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "High", 60, "male", 0, 140, 5.5, 1.3, 1, 50, 70, 60,
    # 60 years old female from high risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "High", 60, "female", 0, 140, 5.5, 1.3, 1, 50, 70, 60,
    # 60 years old male from very high risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "Very high", 60, "male", 0, 140, 5.5, 1.3, 1, 50, 70, 60,
    # 60 years old female from very high risk region who is a non-smoker, diabetic at age 50
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 70 mmol/mol and eGFR of 60 mL/min/1.73m2
    "Very high", 60, "female", 0, 140, 5.5, 1.3, 1, 50, 70, 60

  )

  graphical_abstract_medical_data <- graphical_abstract_medical_data |>
    dplyr::mutate(
      score2_diabetes_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          diabetes = .data[["have_diabetes"]],
          diabetes.age = .data[["diabetes_age"]],
          HbA1c = .data[["hba1c_mmol_mol"]],
          eGFR = .data[["eGFR_mL_min_1_73_m2"]],
          classify = FALSE
        ),
        .f = RiskScorescvd::SCORE2_Diabetes
      ),
      score2_diabetes_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          diabetes = .data[["have_diabetes"]],
          diabetes.age = .data[["diabetes_age"]],
          HbA1c = .data[["hba1c_mmol_mol"]],
          eGFR = .data[["eGFR_mL_min_1_73_m2"]]
        ),
        .f = RiskScorescvd::SCORE2_Diabetes,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    graphical_abstract_medical_data[["score2_diabetes_percentage"]],
    c( 8.4, 6.1, 11.0,  7.6, 12.5, 11.1, 20.3, 20.6,
      12.9, 9.8, 17.2, 12.7, 21.0, 20.4, 31.2, 34.0)
  )

  testthat::expect_equal(
    graphical_abstract_medical_data[["score2_diabetes_classification"]],
    c("Moderate risk", "Moderate risk", "High risk",  "Moderate risk",
      "High risk", "High risk", "Very high risk", "Very high risk",
      "High risk", "Moderate risk", "High risk", "High risk",
      "Very high risk", "Very high risk", "Very high risk", "Very high risk")
  )

})


test_that("SCORE2-Diabetes function works on smokers", {

  # Use https://www.mdcalc.com/calc/10510/score2-diabetes as reference

  smoker_medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_current_smoker, ~systolic_bp,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    ~have_diabetes, ~diabetes_age,
    ~hba1c_mmol_mol, ~eGFR_mL_min_1_73_m2,
    # 60 years old male from low risk region who is a smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Low", 60, "male", 1, 140, 5.5, 1.3, 1, 60, 50, 90,
    # 60 years old female from low risk region who is a smoker, diabetic at age 60
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Low", 60, "female", 1, 140, 5.5, 1.3, 1, 60, 50, 90

  )

  smoker_medical_data <- smoker_medical_data |>
    dplyr::mutate(
      score2_diabetes_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          diabetes = .data[["have_diabetes"]],
          diabetes.age = .data[["diabetes_age"]],
          HbA1c = .data[["hba1c_mmol_mol"]],
          eGFR = .data[["eGFR_mL_min_1_73_m2"]],
          classify = FALSE
        ),
        .f = RiskScorescvd::SCORE2_Diabetes
      ),
      score2_diabetes_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          diabetes = .data[["have_diabetes"]],
          diabetes.age = .data[["diabetes_age"]],
          HbA1c = .data[["hba1c_mmol_mol"]],
          eGFR = .data[["eGFR_mL_min_1_73_m2"]]
        ),
        .f = RiskScorescvd::SCORE2_Diabetes,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    smoker_medical_data[["score2_diabetes_percentage"]],
    c(11.8, 9.2)
  )

  testthat::expect_equal(
    smoker_medical_data[["score2_diabetes_classification"]],
    c("High risk", "Moderate risk")
  )

})


test_that("SCORE2-Diabetes function works on non-diabetic patients", {

  # Use https://www.mdcalc.com/calc/10510/score2-diabetes as reference

  non_diabetic_medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_current_smoker, ~systolic_bp,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    ~have_diabetes, ~diabetes_age,
    ~hba1c_mmol_mol, ~eGFR_mL_min_1_73_m2,
    # 60 years old male from low risk region who is a non-smoker, non-diabetic
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Low", 60, "male", 0, 140, 5.5, 1.3, 0, NA, 50, 90,
    # 60 years old female from low risk region who is a non-smoker, non-diabetic
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L,
    # HDL cholesterol of 1.3 mmol/L, HbA1c of 50 mmol/mol and eGFR of 90 mL/min/1.73m2
    "Low", 60, "female", 0, 140, 5.5, 1.3, 0, NA, 50, 90

  )

  non_diabetic_medical_data <- non_diabetic_medical_data |>
    dplyr::mutate(
      score2_diabetes_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          diabetes = .data[["have_diabetes"]],
          diabetes.age = .data[["diabetes_age"]],
          HbA1c = .data[["hba1c_mmol_mol"]],
          eGFR = .data[["eGFR_mL_min_1_73_m2"]],
          classify = FALSE
        ),
        .f = RiskScorescvd::SCORE2_Diabetes
      ),
      score2_diabetes_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          diabetes = .data[["have_diabetes"]],
          diabetes.age = .data[["diabetes_age"]],
          HbA1c = .data[["hba1c_mmol_mol"]],
          eGFR = .data[["eGFR_mL_min_1_73_m2"]]
        ),
        .f = RiskScorescvd::SCORE2_Diabetes,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    non_diabetic_medical_data[["score2_diabetes_percentage"]],
    c(6.1, 4.1)
  )

  testthat::expect_equal(
    non_diabetic_medical_data[["score2_diabetes_classification"]],
    c("Moderate risk", "Low risk")
  )

})
