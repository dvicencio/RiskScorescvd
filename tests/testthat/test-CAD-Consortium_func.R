test_that("CAD_Consortium_func returns correct PTP and categories", {

  test_data <- tibble::tribble(
    ~age, ~sex, ~chest_pain_type, ~diabetes, ~hypertension, ~dyslipidaemia, ~smoking, ~expected_ptp, ~expected_category,
    60,  "male",       3,             1,            1,             1,            0,         66.1,          "High (50–85%)",
    60,  "male",       3,             0,            1,             1,            0,         56.0,          "High (50–85%)",
    50,  "female",     2,             0,            0,             0,            0,          2.1,          "Low (<15%)",
    70,  "male",       3,             1,            1,             1,            1,         85.1,          "Very High (>85%)",
    40,  "female",     1,             0,            0,             0,            0,          0.6,          "Low (<15%)"
  )

  # Run model
  test_data <- test_data |>
    dplyr::mutate(
      calculated_ptp = purrr::pmap_dbl(
        .l = list(Age = age, Sex = sex, ChestPainType = chest_pain_type,
                  Diabetes = diabetes, Hypertension = hypertension,
                  Dyslipidaemia = dyslipidaemia, Smoking = smoking,
                  model_type = "clinical", classify = FALSE),
        .f = CAD_Consortium_func
      ),
      calculated_category = purrr::pmap_chr(
        .l = list(Age = age, Sex = sex, ChestPainType = chest_pain_type,
                  Diabetes = diabetes, Hypertension = hypertension,
                  Dyslipidaemia = dyslipidaemia, Smoking = smoking,
                  model_type = "clinical", classify = TRUE),
        .f = CAD_Consortium_func
      )
    )

  expect_equal(round(test_data$calculated_ptp, 1), round(test_data$expected_ptp, 1))
  expect_equal(test_data$calculated_category, test_data$expected_category)
})
