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
#' @param ecg.st.depression a binary numeric vector, 1 = yes and 0 = no
#' @param Age a numeric vector of age values, in years
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no
#' @param smoker a binary numeric vector, 1 = yes and 0 = no
#' @param hypertension a binary numeric vector, 1 = yes and 0 = no
#' @param hyperlipidaemia a binary numeric vector, 1 = yes and 0 = no
#' @param family.history a binary numeric vector, 1 = yes and 0 = no
#' @param presentation_hstni a continuous numeric vector of the troponin levels
#' @param Gender a binary character vector of sex values. Categories should include only 'male' or 'female'
#' @param aspirin a binary numeric vector, 1 = yes and 0 = no
#' @param number.of.episodes.24h a numeric vector of number of angina episodes in 24 hours
#' @param previous.pci a binary numeric vector, 1 = yes and 0 = no
#' @param previous.cabg a binary numeric vector, 1 = yes and 0 = no
#' @param classify set TRUE if wish to add a column with the scores' categories
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
#' result <- TIMI_scores(data = cohort_xx, classify = TRUE)

#' # Print the results
#' summary(result$TIMI_score)
#' summary(result$TIMI_strat)
#'
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr rename
#' @importFrom dplyr %>%
#' @importFrom dplyr rowwise
#'
#' @name TIMI
#'
#'
#' @export
TIMI_scores <- function(data, Age = Age, hypertension = hypertension, hyperlipidaemia = hyperlipidaemia, family.history = family.history, diabetes = diabetes,
                        smoker = smoker, previous.pci = previous.pci, previous.cabg = previous.pci, aspirin = aspirin,
                        number.of.episodes.24h = number.of.episodes.24h, ecg.st.depression = ecg.st.depression,
                        presentation_hstni = presentation_hstni, Gender = Gender, classify) {

  data <- data %>% rename(Age = Age, hypertension = hypertension, hyperlipidaemia = hyperlipidaemia, family.history = family.history, diabetes = diabetes,
                          smoker = smoker, previous.pci = previous.pci, previous.cabg = previous.pci, aspirin = aspirin,
                          number.of.episodes.24h = number.of.episodes.24h, ecg.st.depression = ecg.st.depression,
                          presentation_hstni = presentation_hstni, Gender = Gender)


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
