#' TIMI Risk Score for UA/NSTEMI function
#'
#' TIMI = Thrombolysis In Myocardial Infarction
#'
#' @description
#' This function allows you to calculate the HEART score row wise
#' in a data frame with the required variables. It would then retrieve a data
#' frame with two extra columns including the calculations and their classifications
#'
#' @param data
#' A data frame with all the variables needed for calculation:
#' typical_symptoms.num, ecg.normal, abn.repolarisation, ecg.st.depression,Age,
#' diabetes, smoker, hypertension, hyperlipidaemia, family.history,
#' atherosclerotic.disease, presentation_hstni, Gender
#'
#' @keywords
#' HEART, typical_symptoms.num, ecg.normal, abn.repolarisation, ecg.st.depression,
#' Age, diabetes, smoker, hypertension, hyperlipidaemia, family.history,
#' atherosclerotic.disease, presentation_hstni, Gender, classify
#'
#' @return
#' data frame with two extra columns including the HEART score calculations
#' and their classifications
#'
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
#'   family_history = sample(c(1, 0), num_rows, replace = TRUE),
#'   atherosclerotic.disease = sample(c(1, 0), num_rows, replace = TRUE),
#'   presentation_hstni = as.numeric(sample(10:100, num_rows, replace = TRUE)),
#'   Gender = sample(c("male", "female"), num_rows, replace = TRUE)
#' )


#' # Call the function with the cohort_xx
#' result <- HEART_scores(data = cohort_xx, classify = TRUE)

#' # Print the results
#' summary(result$HEART_score)
#' summary(result$HEART_strat)
#'
#' @name TIMI
#'
#'@import dplyr
#'
#' @export
TIMI_scores <- function(data, classify) {
  library(tidyverse)

  if (classify == TRUE) {
    results <- data  %>% rowwise() %>% mutate(
      TIMI_score = TIMI(
        Age,
        hypertension,
        hyperlipidaemia,
        family.history,
        diabetes,
        smoker,
        previous.pci,
        previous.cabg,
        aspirin,
        number.of.episodes.24h,
        ecg.st.depression,
        presentation_hstni,
        Gender,
        classify = FALSE
      ),
      TIMI_strat = TIMI(
        Age,
        hypertension,
        hyperlipidaemia,
        family.history,
        diabetes,
        smoker,
        previous.pci,
        previous.cabg,
        aspirin,
        number.of.episodes.24h,
        ecg.st.depression,
        presentation_hstni,
        Gender,
        classify = classify
      ) %>% as.factor() %>% ordered(
        levels = c("Very low risk", "Low risk", "Moderate risk", "High risk")
      )
    )

  }

  else{
    results <- data  %>% rowwise() %>% mutate(
      TIMI_score = TIMI(
        Age,
        hypertension,
        hyperlipidaemia,
        family.history,
        diabetes,
        smoker,
        previous.pci,
        previous.cabg,
        aspirin,
        number.of.episodes.24h,
        ecg.st.depression,
        presentation_hstni,
        Gender,
        classify = classify
      )
    )
  }
  return(results
  )
}
