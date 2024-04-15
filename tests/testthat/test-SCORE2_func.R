test_that("SCORE2 function works on example data from journal", {

  # Use https://www.heartscore.org/en_GB/ as reference
  # Example data is taken Supplementary methods Table 4 of SCORE2 paper

  supp_method_table_4_medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_cuurent_smoker, ~systolic_bp, ~have_diabetes,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    # 50 years old male from low risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "Low", 50, "male", 1, 140, 0, 6.3, 1.4,
    # 50 years old female from low risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "Low", 50, "female", 1, 140, 0, 6.3, 1.4,
    # 50 years old male from moderate risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "Moderate", 50, "male", 1, 140, 0, 6.3, 1.4,
    # 50 years old female from moderate risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "Moderate", 50, "female", 1, 140, 0, 6.3, 1.4,
    # 50 years old male from high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "High", 50, "male", 1, 140, 0, 6.3, 1.4,
    # 50 years old female from high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "High", 50, "female", 1, 140, 0, 6.3, 1.4,
    # 50 years old male from very high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "Very high", 50, "male", 1, 140, 0, 6.3, 1.4,
    # 50 years old female from very high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6.3 mmol/L
    # and HDL cholesterol of 1.4 mmol/L
    "Very high", 50, "female", 1, 140, 0, 6.3, 1.4
  ) |>
    dplyr::mutate(
      score2_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = FALSE
      ),
      score2_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = TRUE
      )
  )

  testthat::expect_equal(
    supp_method_table_4_medical_data[["score2_percentage"]],
    c(6.3, 4.3,
      8.1, 5.2,
      8.8, 7.1,
      15.1, 14.1)
  )

  testthat::expect_equal(
    supp_method_table_4_medical_data[["score2_classification"]],
    c("Moderate risk", "Low risk",
      "Moderate risk", "Moderate risk",
      "Moderate risk", "Moderate risk",
      "High risk", "High risk"
    )
  )

})

test_that("SCORE2 function works on people less than 50 years", {

  # Use https://www.heartscore.org/en_GB/ as reference

  medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_cuurent_smoker, ~systolic_bp, ~have_diabetes,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    # 45 years old male from low risk region who is not a current smoker and non-diabetic,
    # with a systolic blood pressure of 110 mmHg, total cholesterol of 5 mmol/L
    # and HDL cholesterol of 2 mmol/L
    "Low", 45, "male", 0, 110, 0, 5, 2,
    # 45 years old female from very high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5 mmol/L
    # and HDL cholesterol of 2 mmol/L
    "Very high", 45, "female", 1, 140, 0, 5, 2,
    # 48 years old male from high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 160 mmHg, total cholesterol of 8 mmol/L
    # and HDL cholesterol of 2 mmol/L
    "High", 48, "male", 1, 160, 0, 8, 2,
  ) |>
    dplyr::mutate(
      score2_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = FALSE
      ),
      score2_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    medical_data[["score2_percentage"]],
    c(1.1, 6.0, 10.0)
  )

  testthat::expect_equal(
    medical_data[["score2_classification"]],
    c("Low risk", "Moderate risk",
      "High risk"
    )
  )

})

test_that("SCORE2-OP function on example data from journal", {

  # Use https://www.heartscore.org/en_GB/ as reference
  # Example data is taken Supplementary methods Table 3 of SCORE2-OP paper

  supp_method_table_3_medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_cuurent_smoker, ~systolic_bp, ~have_diabetes,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    # 75 years old male from low risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Low", 75, "male", 1, 140, 0, 5.5, 1.3,
    # 75 years old female from low risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Low", 75, "female", 1, 140, 0, 5.5, 1.3
  ) |>
    dplyr::mutate(
      score2_op_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = FALSE
      ),
      score2_op_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    supp_method_table_3_medical_data[["score2_op_percentage"]],
    c(18.6, 15.2)
  )

  testthat::expect_equal(
    supp_method_table_3_medical_data[["score2_op_classification"]],
    c("High risk", "High risk"
    )
  )

})

test_that("SCORE2-OP function works on patient from different risk region", {

  # Use https://www.heartscore.org/en_GB/ as reference

  medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_cuurent_smoker, ~systolic_bp, ~have_diabetes,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    # 75 years old male from low risk region who is not a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Low", 75, "male", 0, 140, 0, 5.5, 1.3,
    # 75 years old female from low risk region who is not a current smoker and non-diabetic,
    # with a systolic blood pressure of 110 mmHg, total cholesterol of 5 mmol/L
    # and HDL cholesterol of 2 mmol/L
    "Low", 75, "female", 0, 110, 0, 5, 2,
    # 75 years old male from moderate risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Moderate", 75, "male", 1, 140, 0, 5.5, 1.3,
    # 75 years old female from moderate risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Moderate", 75, "female", 1, 140, 0, 5.5, 1.3,
    # 75 years old male from high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "High", 75, "male", 1, 140, 0, 6, 1.3,
    # 75 years old female from high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5 mmol/L
    # and HDL cholesterol of 2 mmol/L
    "High", 75, "female", 1, 110, 0, 5, 2,
    # 75 years old male from very high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Very high", 75, "male", 1, 140, 0, 6, 1.3,
    # 75 years old female from very high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 6 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Very high", 75, "female", 1, 140, 0, 6, 1.3,
  ) |>
    dplyr::mutate(
      score2_op_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = FALSE
      ),
      score2_op_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_cuurent_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = RiskScorescvd::SCORE2,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    medical_data[["score2_op_percentage"]],
    c(13.3, 6.1,
      23.9, 20.0,
      29.2, 19.0,
      40.8, 46.2)
  )

  testthat::expect_equal(
    medical_data[["score2_op_classification"]],
    c("Moderate risk", "Low risk",
      "High risk", "High risk",
      "High risk", "High risk",
      "High risk", "High risk"
    )
  )

})

test_that("SCORE2 function works on invalid inputs", {

  # Spelling mistake on the Risk.region parameters
  testthat::expect_error(
    RiskScorescvd::SCORE2(
      Risk.region = "Very High",
      Age = 75,
      Gender = "male",
      smoker = 0,
      systolic.bp = 140,
      diabetes = 0,
      total.chol = 5.5,
      total.hdl = 1.3,
      classify = FALSE) |>
      suppressMessages()
  )

  # Smoker is NA, making the patient classification as NA
  na_classification <- RiskScorescvd::SCORE2(
    Risk.region = "Low",
    Age = 75,
    Gender = "male",
    smoker = NA,
    systolic.bp = 140,
    diabetes = 0,
    total.chol = 5.5,
    total.hdl = 1.3,
    classify = TRUE)

  testthat::expect_equal(
    is.na(na_classification),
    TRUE
  )

})
