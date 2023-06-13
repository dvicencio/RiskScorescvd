#' ASCVD risk score function
#' ASCVD = Atherosclerotic Cardiovascular Disease
#'
#' @description
#' This function allows you to calculate the ASCVD score row wise
#' in a data frame with the required variables. It would then retrieve a data
#' frame with two extra columns including the calculations and their classifications
#'
#' @param data
#' A data frame with all the variables needed for calculation:
#' Gender, Ethnicity, Age, total.chol, total.hd,
#' systolic.bp,hypertension, smoker, diabetes
#'
#' @param classify set TRUE if wish to add a column with the scores' categories
#'
#' @keywords
#' HEART, Gender, Ethnicity, Age, total.chol, total.hd,
#' systolic.bp,hypertension, smoker, diabetes classify
#'
#' @return
#' data frame with two extra columns including the ASCVD score calculations
#' and their classifications
#'
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
#'   Gender = sample(c("male", "female"), num_rows, replace = TRUE),
#'   sweating = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  pain.radiation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  pleuritic = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  palpation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  ecg.twi = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  Δ2nd_hstni = as.numeric(sample(1:200, num_rows, replace = TRUE)),
#'  killip.class = as.numeric(sample(1:4, num_rows, replace = TRUE)),
#'  systolic.bp = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'  heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'  creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
#'  cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  previous.pci = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  previous.cabg = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  aspirin = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'  number.of.episodes.24h = as.numeric(sample(0:20, num_rows, replace = TRUE)),
#'  total.chol = as.numeric(sample(5:100, num_rows, replace = TRUE)),
#'  total.hdl = as.numeric(sample(2:5, num_rows, replace = TRUE)),
#'  Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE)
#' )


#' # Call the function with the cohort_xx
#' result <- ASCVD_scores(data = cohort_xx, classify = TRUE)

#' # Print the results
#' summary(result$ASCVD_score)
#' summary(result$ASCVD_strat)
#'
#' @import dplyr
#' @import PooledCohort
#' @export


ASCVD_scores <- function(data, classify) {
  library(tidyverse)
  library(PooledCohort)

  if (classify == TRUE) {
    results <- data  %>% rowwise() %>% mutate(
      ASCVD_score = ASCVD(
        Gender,
        Ethnicity,
        Age,
        total.chol,
        total.hdl,
        systolic.bp,
        hypertension,
        smoker,
        diabetes,
        classify = FALSE
      ),
      ASCVD_strat = ASCVD(
        Gender,
        Ethnicity,
        Age,
        total.chol,
        total.hdl,
        systolic.bp,
        hypertension,
        smoker,
        diabetes,
        classify = classify
      ) %>% as.factor() %>% ordered(levels = c("Very low risk", "Low risk", "Moderate risk", "High risk"))
    )

  }


  else{
    results <- data  %>% rowwise() %>% mutate(
      ASCVD_score = ASCVD(
        Gender,
        Ethnicity,
        Age,
        total.chol,
        total.hdl,
        systolic.bp,
        hypertension,
        smoker,
        diabetes,
        classify = classify
      )
    )
  }
  return(results)
}