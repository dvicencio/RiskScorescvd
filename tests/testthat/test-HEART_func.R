test_that("HEART function is able to provide the different risk groups", {

  # Verified with https://www.mdcalc.com/calc/1752/heart-score-major-cardiac-events

  medical_data <- tibble::tribble(
    ~typical_symptoms_num,
    ~ecg_normal, ~abn_repolarisation, ~ecg_st_depression,
    ~age,
    ~diabetes, ~smoker, ~hypertension, ~hyperlipidaemia, ~family_history,
    ~atherosclerotic_disease,
    ~presentation_hstni_ng_L,
    ~gender,
    # 40 years old male who has no symptom of ACS, normal ECG,
    # no risk factors, and troponin or 30 ng/L (<=34ng/L)
    0,
    1, 0, 0,
    40,
    0, 0, 0, 0, 0,
    0,
    30,
    "male",
    # 50 years old male who has three symptoms of ACS, abnormal ECG with repolarization abnormalities,
    # two risk factors but no history of atherosclerotic disease, and troponin of 65 (>2*34ng/L)
    3,
    0, 1, 0,
    50,
    1, 1, 0, 0, 0,
    0,
    65,
    "male",
    # 50 years old female who has three symptoms of ACS, abnormal ECG with repolarization abnormalities,
    # three risk factors but no history of atherosclerotic disease, and troponin of 35 (>2*17ng/L)
    3,
    0, 1, 0,
    50,
    0, 0, 1, 1, 1,
    0,
    35,
    "female",
    # 65 years old female who has five symptoms of ACS, abnormal ECG with significant ST deviation,
    # no risk factors but history of atherosclerotic disease, and troponin of 60 ng/L (>3*17ng/L)
    5,
    0, 0, 1,
    65,
    0, 0, 0, 0, 0,
    1,
    60,
    "female",
  ) |>
    dplyr::mutate(
      heart_score = purrr::pmap_vec(
        .l = list(
          typical_symptoms.num = .data[["typical_symptoms_num"]],
          ecg.normal = .data[["ecg_normal"]],
          abn.repolarisation = .data[["abn_repolarisation"]],
          ecg.st.depression = .data[["ecg_st_depression"]],
          Age = .data[["age"]],
          diabetes = .data[["diabetes"]],
          smoker = .data[["smoker"]],
          hypertension = .data[["hypertension"]],
          hyperlipidaemia = .data[["hyperlipidaemia"]],
          family.history = .data[["family_history"]],
          atherosclerotic.disease = .data[["atherosclerotic_disease"]],
          presentation_hstni = .data[["presentation_hstni_ng_L"]],
          Gender = .data[["gender"]]
        ),
        .f = RiskScorescvd::HEART,
        classify = FALSE
      ),
      heart_classification = purrr::pmap_chr(
        .l = list(
          typical_symptoms.num = .data[["typical_symptoms_num"]],
          ecg.normal = .data[["ecg_normal"]],
          abn.repolarisation = .data[["abn_repolarisation"]],
          ecg.st.depression = .data[["ecg_st_depression"]],
          Age = .data[["age"]],
          diabetes = .data[["diabetes"]],
          smoker = .data[["smoker"]],
          hypertension = .data[["hypertension"]],
          hyperlipidaemia = .data[["hyperlipidaemia"]],
          family.history = .data[["family_history"]],
          atherosclerotic.disease = .data[["atherosclerotic_disease"]],
          presentation_hstni = .data[["presentation_hstni_ng_L"]],
          Gender = .data[["gender"]]
        ),
        .f = RiskScorescvd::HEART,
        classify = TRUE
      )
    )

  testthat::expect_equal(
    medical_data[["heart_score"]],
    c(0L, 5L, 6L, 10L)
  )

  testthat::expect_equal(
    medical_data[["heart_classification"]],
    c("Low risk", "Moderate risk", "Moderate risk", "High risk")
  )

})

test_that("HEART function works on invalid inputs", {

  # Missing the Age Variable
  testthat::expect_error(
    RiskScorescvd::HEART(
      typical_symptoms.num = NULL,
      ecg.normal = 0,
      abn.repolarisation = 1,
      ecg.st.depression = 1,
      diabetes = 0,
      smoker = 0,
      hypertension = 0,
      hyperlipidaemia = 0,
      family.history = 0,
      atherosclerotic.disease = 0,
      presentation_hstni = 40,
      Gender = "male",
      classify = FALSE) |>
      suppressWarnings()
  )

  # Smoker is NA, making the patient classification as NA
  na_classification <- RiskScorescvd::HEART(
    typical_symptoms.num = NA,
    ecg.normal = 0,
    abn.repolarisation = 1,
    ecg.st.depression = 1,
    Age = 40,
    diabetes = 0,
    smoker = 0,
    hypertension = 0,
    hyperlipidaemia = 0,
    family.history = 0,
    atherosclerotic.disease = 0,
    presentation_hstni = NA,
    Gender = "male",
    classify = FALSE) |>
    suppressWarnings()

  testthat::expect_equal(
    is.na(na_classification),
    TRUE
  )

})

