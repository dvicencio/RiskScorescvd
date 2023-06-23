#' History, ECG, Age, Risk factors and Troponin (HEART) risk score
#'
#'
#' @description This function implements the HEART score calculation as a vector
#'
#' History -
#' Absence of history for coronary ischemia: nonspecific  = 0
#' Nonspecific + suspicious elements: moderately suspicious = 1
#' Mainly suspicious elements (middle- or left-sided, /
#' heavy chest pain, radiation, /
#' and/or relief of symptoms by sublingual nitrates):  = 2
#'
#' EGG -
#' Normal ECG according to Minnesota criteria (what's this criteria?)  = 0
#' Repolarization abnormalities without /
#' significant ST-segment depression or elevation                   = 1
#' Presence of a bundle branch block or pacemaker rhythm, /
#' typical abnormalities indicative of left ventricular hypertrophy, /
#' repolarization abnormalities probably caused by digoxin use, /
#' or in case of unchanged known repolarization disturbances.            = 1
#' Significant ST-segment depressions /
#' or elevations in absence of a bundle branch block, /
#' left ventricular hypertrophy, or the use of digoxin       =  2
#'
#' Age -
#' Younger than 45 = 0
#' 45 to 65 years old = 1
#' 65 years or older = 2
#'
#' Risk facrtor -
#' Currently treated diabetes mellitus, /
#' current or recent (<90 days) smoker, /
#' diagnosed and/or treated hypertension, /
#' diagnosed hypercholesterolemia, /
#' family history of coronary artery disease,
#' obesity (body mass index BMI >30),
#' or a history of significant atherosclerosis, /
#' (coronary revascularization, myocardial infarction, stroke, /
#' or peripheral arterial disease, /
#' irrespective of the risk factors for coronary artery disease)
#' None of the above = 0
#' One or two of the above = 1
#' Three or more of the above = 2
#'
#' Troponin T or I -
#' Below the threshold for positivity = 0                    A
#' Between 1 and 3 times the threshold for positivity = 1    A
#' higher than 3 times the threshold for positivity   = 2    A
#'
#' Two possible outcomes:
#' 0-3 = Low risk
#' 4-6 = Moderate risk
#' Over 7 = High risk
#'
#' The HEART score: A guide to its application in the emergency department paper reference
#' Website: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6005932/
#'
#' @param typical_symptoms.num a numeric vector of the number of typical symptoms
#' @param ecg.normal a binary numeric vector,  1 = yes and 0 = no
#' @param abn.repolarisation a binary numeric vector,  1 = yes and 0 = no
#' @param ecg.st.depression a binary numeric vector, 1 = yes and 0 = no
#' @param Age a numeric vector of age values, in years
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no
#' @param smoker a binary numeric vector, 1 = yes and 0 = no
#' @param hypertension a binary numeric vector, 1 = yes and 0 = no
#' @param hyperlipidaemia a binary numeric vector, 1 = yes and 0 = no
#' @param family.history a binary numeric vector, 1 = yes and 0 = no
#' @param atherosclerotic.disease a binary numeric vector, 1 = yes and 0 = no
#' @param presentation_hstni a continuous numeric vector of the troponin levels
#' @param Gender a binary character vector of sex values. Categories should include only 'male' or 'female'
#' @param classify a logical parameter to indicate classification of Scores "TRUE" or none "FALSE"
#'
#' @keywords
#' HEART typical_symptoms.num ecg.normal abn.repolarisation ecg.st.depression
#' Age diabetes smoker hypertension hyperlipidaemia family.history
#' atherosclerotic.disease presentation_hstni Gender classify
#'
#' @return
#' A vector with HEART score calculations
#' and/or a vector of their classifications if indicated
#'
#' @examples
#'
#' # Create a data frame or list with the necessary variables
#' # Set the number of rows
#' num_rows <- 100

#' # Create a larger dataset with 100 rows
#' cohort_xx <- data.frame(
#'   typical_symptoms.num = as.numeric(sample(0:6, num_rows, replace = TRUE)),
#'   ecg.normal = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   abn.repolarisation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   ecg.st.depression = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   Age = as.numeric(sample(30:80, num_rows, replace = TRUE)),
#'   diabetes = sample(c(1, 0), num_rows, replace = TRUE),
#'   smoker = sample(c(1, 0), num_rows, replace = TRUE),
#'   hypertension = sample(c(1, 0), num_rows, replace = TRUE),
#'   hyperlipidaemia = sample(c(1, 0), num_rows, replace = TRUE),
#'   family.history = sample(c(1, 0), num_rows, replace = TRUE),
#'   atherosclerotic.disease = sample(c(1, 0), num_rows, replace = TRUE),
#'   presentation_hstni = as.numeric(sample(10:100, num_rows, replace = TRUE)),
#'   Gender = sample(c("male", "female"), num_rows, replace = TRUE)
#' )
#'
#' # Call the function with the cohort_xx
#'
#'  results <- cohort_xx %>% rowwise() %>%
#'  mutate(HEART_score = HEART(typical_symptoms.num, ecg.normal,
#'  abn.repolarisation, ecg.st.depression, Age, diabetes, smoker, hypertension,
#'  hyperlipidaemia, family.history, atherosclerotic.disease,
#'  presentation_hstni, Gender, classify = FALSE))
#'
#' @importFrom dplyr case_when
#'
#' @name HEART
#' @export

  HEART <- function(typical_symptoms.num = typical_symptoms.num,
                    ecg.normal = ecg.normal,
                    abn.repolarisation = abn.repolarisation,
                    ecg.st.depression = ecg.st.depression,
                    Age = Age,
                    diabetes = diabetes,
                    smoker = smoker,
                    hypertension = hypertension,
                    hyperlipidaemia = hyperlipidaemia,
                    family.history = family.history,
                    atherosclerotic.disease = atherosclerotic.disease,
                    presentation_hstni = presentation_hstni,
                    Gender = Gender,
                    classify = classify) {


    if (missing(typical_symptoms.num) ||
        missing(ecg.normal) || missing(abn.repolarisation) ||
        missing(ecg.st.depression) ||
        missing(Age) || missing(diabetes) || missing(smoker) ||
        missing(hypertension) ||
        missing(hyperlipidaemia) || missing(family.history) ||
        missing(atherosclerotic.disease) ||
        missing(presentation_hstni) || missing(Gender)) {
      warning("One or more required variables are missing.")
    }

    if (!is.numeric(typical_symptoms.num) ||
        !is.numeric(ecg.normal) || !is.numeric(abn.repolarisation) ||
        !is.numeric(ecg.st.depression) ||
        !is.numeric(Age) || !is.numeric(diabetes) || !is.numeric(smoker) ||
        !is.numeric(hypertension) ||
        !is.numeric(hyperlipidaemia) || !is.numeric(family.history) ||
        !is.numeric(atherosclerotic.disease) ||
        !is.numeric(presentation_hstni) || !is.character(Gender) ||
        !is.logical(classify)) {
      warning("Invalid variable type detected.")
    }


    # 1. History - classical or not classical cardiac features
    Hist <- case_when(
      is.na(typical_symptoms.num) ~ NA_real_,
      typical_symptoms.num <= 1 ~ 0,
      #0-1
      2 <= typical_symptoms.num  &
        typical_symptoms.num <= 4 ~ 1,
      #2-4
      5 <= typical_symptoms.num  &
        typical_symptoms.num <= 6 ~ 2,
      #5-6
      TRUE ~ NA_real_
    )

    # 2. ECG - Normal					                			     0
    # Non-specific repolarisation abnormality				+1
    # Significant ST depression                      +2

    ECG <- case_when(
      is.na(ecg.normal) &
        is.na(ecg.st.depression) & is.na(abn.repolarisation) ~ NA_real_,

      (ecg.normal == 0 |
         is.na(ecg.normal)) &
        (abn.repolarisation == 0 |
           is.na(abn.repolarisation)) &
        (ecg.st.depression == 0 | is.na(ecg.st.depression)) ~ 1,

      ecg.normal == 1 &
        (abn.repolarisation == 0 |
           is.na(abn.repolarisation)) &
        (ecg.st.depression == 0 | is.na(ecg.st.depression)) ~ 0,

      abn.repolarisation == 1 &
        ((ecg.normal == 0 |
            is.na(ecg.normal) |
            ecg.normal == 1) &
           (ecg.st.depression == 0 | is.na(ecg.st.depression))
        ) ~ 1,

      ecg.st.depression == 1 &
        ((
          abn.repolarisation == 1 |
            abn.repolarisation == 0 |
            is.na(abn.repolarisation)
        ) & (ecg.normal == 1 | ecg.normal == 0 | is.na(ecg.normal))
        ) ~ 2,
      TRUE ~ NA_real_
    )


    # 3. Age in years;
    # Younger than 45                  0
    # 45 to 65 years old               1
    # 65 years or older                2
    Age2 <- case_when(
      is.na(Age) ~ NA_real_,
      Age < 45 ~ 0,
      45 <= Age & Age <= 64 ~ 1,
      65 <= Age & Age <= 150 ~ 2,
      TRUE ~ NA_real_
    )

    # 4. Risk facrtor -
    # No risk factors                              0
    # 1 to 2									                    +1
    # >3 OR known atherosclerotic disease 				+2
    Risk <- case_when(
      sum(
        diabetes,
        smoker,
        hypertension,
        hyperlipidaemia,
        family.history,

        na.rm = TRUE
      ) == 0 &
        (
          atherosclerotic.disease == 0 | is.na(atherosclerotic.disease)
        ) ~ 0,
      sum(
        diabetes,
        smoker,
        hypertension,
        hyperlipidaemia,
        family.history,

        na.rm = TRUE
      ) == 1 &
        (
          atherosclerotic.disease == 0 | is.na(atherosclerotic.disease)
        ) ~ 1,
      sum(
        diabetes,
        smoker,
        hypertension,
        hyperlipidaemia,
        family.history,

        na.rm = TRUE
      ) == 2 &
        (
          atherosclerotic.disease == 0 | is.na(atherosclerotic.disease)
        ) ~ 1,
      sum(
        diabetes,
        smoker,
        hypertension,
        hyperlipidaemia,
        family.history,

        na.rm = TRUE
      ) >= 3 &
        (
          atherosclerotic.disease == 0 | is.na(atherosclerotic.disease)
        ) ~ 2,
      atherosclerotic.disease == 1 ~ 2,
      TRUE ~ NA_real_
    )

    # 5. Troponin T or I -
    # <URL									 0
    # 1-3*URL								+1
    # >3*URL								+2

    URL <- case_when(
      is.na(presentation_hstni) ~ NA_real_,
      Gender == "male" & presentation_hstni < 34 ~ 0,
      Gender == "male" &
        (1 * 34 <= presentation_hstni & presentation_hstni <= 3 * 34) ~ 1,
      Gender == "male" &
        (3 * 34 < presentation_hstni &
           presentation_hstni <= 1000000 * 34) ~ 2,
      Gender == "female" & presentation_hstni < 16 ~ 0,
      Gender == "female" &
        (1 * 16 <= presentation_hstni & presentation_hstni <= 3 * 16) ~ 1,
      Gender == "female" &
        (3 * 16 < presentation_hstni &
           presentation_hstni <= 1000000 * 16) ~ 2,
      TRUE ~ NA_real_
    )


    score <-  Hist + ECG + Age2 + Risk + URL



    if (is.na(score)) {
      pred <- NA
    }

    else if (score <= 3) {
      pred <- "Low risk"
    }
    else if (3 < score & score <= 6) {
      pred <- "Moderate risk"
    }
    else if (score > 6) {
      pred <- "High risk"
    }

    if (classify == TRUE) {
      return(pred)
    }

    else{
      return(round(score, 0))
    }

  }
