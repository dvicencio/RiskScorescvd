#' GRACE Global Registry of Acute Coronary Events version 2.0, 6 months outcome
#'
#' @description
#' This function allows you to calculate the GRACE 2.0 score row wise
#' in a data frame with the required variables. It would then retrieve a data
#' frame with two extra columns including the calculations and their classifications
#'
#' @param data
#' A data frame with all the variables needed for calculation:
#' killip.class, systolic.bp, heart.rate, Age, creat, ecg.st.depression,
#' presentation_hstni, cardiac.arrest, Gender, classify
#'
#' @keywords
#' GRACE, killip.class, systolic.bp, heart.rate, Age, creat, ecg.st.depression,
#' presentation_hstni, cardiac.arrest, Gender, classify classify
#'
#' @return
#' data frame with two extra columns including the 'GRACE_score' calculations
#' and their classifications, 'GRACE_strat'
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
#'   pain.radiation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   pleuritic = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   palpation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   ecg.twi = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   Δ2nd_hstni = as.numeric(sample(1:200, num_rows, replace = TRUE)),
#'   killip.class = as.numeric(sample(1:4, num_rows, replace = TRUE)),
#'   systolic.bp = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'   heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'   creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
#'   cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE))
#' )


#' # Call the function with the cohort_xx
#' result <- GRACE_scores(data = cohort_xx, classify = TRUE)

#' Print the results
#' summary(result$GRACE_strat)
#' summary(result$GRACE_score)
#'
#' @import dplyr
#' @export


GRACE_scores <- function(data, classify) {
  library(tidyverse)
  if (classify == TRUE) {
    results <- data  %>% rowwise() %>% mutate(
      GRACE_score = GRACE(
        killip.class,
        systolic.bp,
        heart.rate,
        Age,
        creat,
        ecg.st.depression,
        presentation_hstni,
        cardiac.arrest,
        Gender,
        classify = FALSE
      ),

      GRACE_strat = GRACE(
        killip.class,
        systolic.bp,
        heart.rate,
        Age,
        creat,
        ecg.st.depression,
        presentation_hstni,
        cardiac.arrest,
        Gender,
        classify = classify
      ) %>% as.factor() %>% ordered(levels =
                                      c( "Low risk", "Moderate risk", "High risk"))
    )
  }

  else{results <- data  %>% rowwise() %>% mutate(
   GRACE_score = GRACE(
     killip.class,
     systolic.bp,
     heart.rate,
     Age,
     creat,
     ecg.st.depression,
     presentation_hstni,
     cardiac.arrest,
     Gender,
      classify = classify
    )
  )
  }
  return(results)
}
