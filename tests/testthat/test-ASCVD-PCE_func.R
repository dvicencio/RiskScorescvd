test_that("ASCVD-PCE function works on example data from journal", {

  # Use https://www.ahajournals.org/doi/10.1161/01.cir.0000437741.48606.98 as reference
  # Example data is taken Supplementary methods Table 4 of ASCVD-PCE paper

  # Verified with https://tools.acc.org/ascvd-risk-estimator-plus/#!/calculate/estimate/

  supp_method_table_4_medical_data <- tibble::tribble(
    ~gender, ~ethnicity, ~age, ~total_chol_mmol_L, ~total_hdl_mmol_L,
    ~systolic_bp, ~treated_hypertension, ~is_current_smoker, ~have_diabetes,
    # 55 years old white female who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "female", "white", 55, 5.51, 1.29, 120, 0, 0, 0,
    # 55 years old black female who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "female", "black", 55, 5.51, 1.29, 120, 0, 0, 0,
    # 55 years old white male who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "male", "white", 55, 5.51, 1.29, 120, 0, 0, 0,
    # 55 years old black male who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "male", "black", 55, 5.51, 1.29, 120, 0, 0, 0,
  ) |>
    dplyr::mutate(
      ascvd_score = purrr::pmap_vec(
        .l = list(
          Gender = .data[["gender"]],
          Ethnicity = .data[["ethnicity"]],
          Age = .data[["age"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          systolic.bp = .data[["systolic_bp"]],
          hypertension = .data[["treated_hypertension"]],
          smoker = .data[["is_current_smoker"]],
          diabetes = .data[["have_diabetes"]]
        ),
        .f = RiskScorescvd::ASCVD,
        classify = FALSE
      ),
      ascvd_classification = purrr::pmap_chr(
        .l = list(
          Gender = .data[["gender"]],
          Ethnicity = .data[["ethnicity"]],
          Age = .data[["age"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          systolic.bp = .data[["systolic_bp"]],
          hypertension = .data[["treated_hypertension"]],
          smoker = .data[["is_current_smoker"]],
          diabetes = .data[["have_diabetes"]]
        ),
        .f = RiskScorescvd::ASCVD,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    supp_method_table_4_medical_data[["ascvd_score"]],
    c(0.02, 0.03, 0.05, 0.06)
  )

  testthat::expect_equal(
    supp_method_table_4_medical_data[["ascvd_classification"]],
    c("Very low risk", "Very low risk", "Low risk", "Low risk")
  )

})

test_that("ASCVD-PCE function is able to provide the different risk groups", {

  # Verified with https://tools.acc.org/ascvd-risk-estimator-plus/#!/calculate/estimate/

  medical_data <- tibble::tribble(
    ~gender, ~ethnicity, ~age, ~total_chol_mmol_L, ~total_hdl_mmol_L,
    ~systolic_bp, ~treated_hypertension, ~is_current_smoker, ~have_diabetes,
    # 55 years old white female who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "female", "white", 55, 5.51, 1.29, 120, 0, 0, 0,
    # 55 years old white male who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "male", "white", 58, 5.51, 1.29, 120, 0, 0, 0,
    # 55 years old white male who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "male", "white", 65, 5.51, 1.29, 120, 0, 0, 0,
    # 55 years old white male who is a non-smoker and non-diabetic,
    # with a untreated systolic blood pressure of 120 mmHg,
    # total cholesterol of 5.51 mmol/L (Converted from 213 mg/dL multiply by 0.02586)
    # and HDL cholesterol of 1.29 mmol/L (Converted from 50 mg/dL multiply by 0.02586)
    "male", "white", 75, 5.51, 1.29, 120, 0, 0, 0,
  ) |>
    dplyr::mutate(
      ascvd_score = purrr::pmap_vec(
        .l = list(
          Gender = .data[["gender"]],
          Ethnicity = .data[["ethnicity"]],
          Age = .data[["age"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          systolic.bp = .data[["systolic_bp"]],
          hypertension = .data[["treated_hypertension"]],
          smoker = .data[["is_current_smoker"]],
          diabetes = .data[["have_diabetes"]]
        ),
        .f = RiskScorescvd::ASCVD,
        classify = FALSE
      ),
      ascvd_classification = purrr::pmap_chr(
        .l = list(
          Gender = .data[["gender"]],
          Ethnicity = .data[["ethnicity"]],
          Age = .data[["age"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]],
          systolic.bp = .data[["systolic_bp"]],
          hypertension = .data[["treated_hypertension"]],
          smoker = .data[["is_current_smoker"]],
          diabetes = .data[["have_diabetes"]]
        ),
        .f = RiskScorescvd::ASCVD,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    medical_data[["ascvd_score"]],
    c(0.02, 0.07, 0.12, 0.23)
  )

  testthat::expect_equal(
    medical_data[["ascvd_classification"]],
    c("Very low risk", "Low risk", "Moderate risk", "High risk")
  )

})

test_that("ASCVD-PCE function works on invalid inputs", {

  # Spelling mistake on the Ethnicity parameters
  testthat::expect_error(
    RiskScorescvd::ASCVD(
      Gender = "male",
      ethnicity = "white",
      Age = 55,
      total.chol = 5.51, # Converted from 213 mg/dL multiply by 0.02586
      total.hdl = 1.29, # Converted from 50 mg/dL multiply by 0.02586
      systolic.bp = 120,
      hypertension = 0, # Untreated for hypertension
      smoker = NA,
      diabetes = 0,
      classify = FALSE) |>
      suppressMessages()
  )

  # Smoker is NA, making the patient classification as NA
  na_classification <- RiskScorescvd::ASCVD(
    Gender = "male",
    Ethnicity = "white",
    Age = 55,
    total.chol = 5.51, # Converted from 213 mg/dL multiply by 0.02586
    total.hdl = 1.29, # Converted from 50 mg/dL multiply by 0.02586
    systolic.bp = 120,
    hypertension = 0, # Untreated for hypertension
    smoker = NA,
    diabetes = 0,
    classify = FALSE) |>
    suppressWarnings()

  testthat::expect_equal(
    is.na(na_classification),
    TRUE
  )

})
