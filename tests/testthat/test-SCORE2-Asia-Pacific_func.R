test_that("SCORE2-Asia-Pacific function works on example data from journal", {

  # Example data is taken from Abstract Figures in SCORE2-Asia-Pacific paper

  abstract_medical_data <- tibble::tribble(
    ~risk_region, ~age, ~gender, ~is_current_smoker, ~systolic_bp, ~have_diabetes,
    ~total_chol_mmol_L, ~total_hdl_mmol_L,
    # 50 years old male from low risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Low", 50, "male", 1, 140, 0, 5.5, 1.3,
    # 50 years old male from moderate risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Moderate", 50, "male", 1, 140, 0, 5.5, 1.3,
    # 50 years old male from high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "High", 50, "male", 1, 140, 0, 5.5, 1.3,
    # 50 years old male from very high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Very high", 50, "male", 1, 140, 0, 5.5, 1.3,
    # 50 years old female from low risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Low", 50, "female", 1, 140, 0, 5.5, 1.3,
    # 50 years old female from moderate risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Moderate", 50, "female", 1, 140, 0, 5.5, 1.3,
    # 50 years old female from high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "High", 50, "female", 1, 140, 0, 5.5, 1.3,
    # 50 years old female from very high risk region who is a current smoker and non-diabetic,
    # with a systolic blood pressure of 140 mmHg, total cholesterol of 5.5 mmol/L
    # and HDL cholesterol of 1.3 mmol/L
    "Very high", 50, "female", 1, 140, 0, 5.5, 1.3,
  ) |>
    dplyr::mutate(
      score2_asia_pacific_percentage = purrr::pmap_vec(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = SCORE2_Asia_Pacific,
        classify = FALSE
      ),
      score2_asia_pacific_classification = purrr::pmap_chr(
        .l = list(
          Risk.region = .data[["risk_region"]],
          Age = .data[["age"]],
          Gender = .data[["gender"]],
          smoker = .data[["is_current_smoker"]],
          systolic.bp = .data[["systolic_bp"]],
          diabetes = .data[["have_diabetes"]],
          total.chol = .data[["total_chol_mmol_L"]],
          total.hdl = .data[["total_hdl_mmol_L"]]
        ),
        .f = SCORE2_Asia_Pacific,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    abstract_medical_data[["score2_asia_pacific_percentage"]],
    c(10.3, 12.3,
      16.1, 21.6,
      5.7,  8.8,
      15.2, 21.8)
  )

  testthat::expect_equal(
    abstract_medical_data[["score2_asia_pacific_classification"]],
    c("High risk", "High risk",
      "High risk", "Very high risk",
      "Moderate risk", "Moderate risk",
      "High risk", "Very high risk"
    )
  )

})
