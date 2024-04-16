#' SCORE2/OP with CKD add-on risk score function for a data frame;
#' SCORE2/OP = Systematic COronary Risk Evaluation /and Older Population
#' CKD = Chronic kidney disease
#' @description
#' This function allows you to calculate the SCORE2 and OP score with CKD add-ons (eGFR, ACR, dipstick) row wise
#' in a data frame with the required variables. It would then retrieve a data
#' frame with two extra columns including the calculations and their classifications
#'
#' @param data
#' A data frame with all the variables needed for calculation:
#'  Age, Gender, smoker, systolic.bp, diabetes, total.chol,
#' total.hdl
#'
#' @param Risk.region a character value to set the desired risk region calculations. Categories should include "Low", "Moderate", "High", or "Very high"
#' @param Age a numeric vector of age values, in years
#' @param Gender a binary character vector of Gender values. Categories should include only 'male' or 'female'
#' @param smoker a binary numeric vector, 1 = yes and 0 = no
#' @param systolic.bp a numeric vector of systolic blood pressure continuous values
#' @param total.chol a numeric vector of total cholesterol values, in mmol/L
#' @param total.hdl a numeric vector of total high density lipoprotein total.hdl values, in mmol/L
#' @param classify set TRUE if wish to add a column with the scores' categories
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no
#' @param eGFR a numeric vector of total estimated glomerular rate (eGFR) values, in mL/min/1.73m2
#' @param ACR a numeric vector of total urine albumin to creatine ratio (ACR) values, in mg/g. Default set to NA
#' @param trace a character vector of urine protein dipstick categories. Categories should include 'negative', 'trace', '1+', '2+', '3+', '4+. Default set to NA
#' @param addon set the add-on you wish to calculate. Categories should include only 'ACR' or 'trace'. Default set to 'ACR'
#'
#'
#' @keywords
#' SCORE2/OP Age Gender smoker systolic.bp diabetes total.chol
#' total.hdl classify eGFR ACR trace addon
#'
#' @return
#' A vector with SCORE2/OP score calculations with CKD add-ons
#' and/or a vector of their classifications if indicated
#'
#' @examples
#'
#' # Create a data frame or list with the necessary variables
#' # Set the number of rows
#' num_rows <- 100
#'
#' # Create a larger dataset with 100 rows
#' cohort_xx <- data.frame(
#'   typical_symptoms.num = as.numeric(sample(0:6, num_rows, replace = TRUE)),
#'   ecg.normal = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   abn.repolarisation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   ecg.st.depression = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   Age = as.numeric(sample(40:85, num_rows, replace = TRUE)),
#'   diabetes = sample(c(1, 0), num_rows, replace = TRUE),
#'   smoker = sample(c(1, 0), num_rows, replace = TRUE),
#'   hypertension = sample(c(1, 0), num_rows, replace = TRUE),
#'   hyperlipidaemia = sample(c(1, 0), num_rows, replace = TRUE),
#'   family.history = sample(c(1, 0), num_rows, replace = TRUE),
#'   atherosclerotic.disease = sample(c(1, 0), num_rows, replace = TRUE),
#'   presentation_hstni = as.numeric(sample(10:100, num_rows, replace = TRUE)),
#'   Gender = sample(c("male", "female"), num_rows, replace = TRUE),
#'   sweating = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   pain.radiation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   pleuritic = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   palpation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   ecg.twi = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   second_hstni = as.numeric(sample(1:200, num_rows, replace = TRUE)),
#'   killip.class = as.numeric(sample(1:4, num_rows, replace = TRUE)),
#'   systolic.bp = as.numeric(sample(90:180, num_rows, replace = TRUE)),
#'   heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'   creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
#'   cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   previous.pci = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   previous.cabg = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   aspirin = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   number.of.episodes.24h = as.numeric(sample(0:20, num_rows, replace = TRUE)),
#'   total.chol = as.numeric(round(runif(num_rows, 3.9, 7.2), 1)),
#'   total.hdl = as.numeric(round(runif(num_rows, .8, 2.1), 1)),
#'   Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE),
#'   eGFR = as.numeric(sample(15:120, num_rows, replace = TRUE)),
#'   ACR = as.numeric(sample(5:1500, num_rows, replace = TRUE)),
#'   trace = sample(c("trace", "1+", "2+", "3+", "4+"), num_rows, replace = TRUE)
#' )
#'
#' # Call the function with the cohort_xx
#' result <- SCORE2_CKD_scores(data = cohort_xx, Risk.region = "Low", addon = "ACR", classify = TRUE)
#'
#' # Print the results
#' summary(result$SCORE2_score)
#' summary(result$SCORE2_strat)
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr rename
#' @importFrom dplyr %>%
#' @importFrom dplyr rowwise
#'
#' @export



SCORE2_CKD_scores <- function(data, Risk.region, Age = Age, Gender = Gender, smoker = smoker, systolic.bp = systolic.bp, diabetes = diabetes, total.chol = total.chol, total.hdl = total.hdl, eGFR = eGFR, ACR = NA, trace = NA, addon = "ACR", classify) {

  data <- data %>% rename(Age = Age, Gender = Gender, smoker = smoker, systolic.bp = systolic.bp, diabetes = diabetes, total.chol = total.chol, total.hdl = total.hdl)

  if (classify == TRUE) {
    results <- data  %>% rowwise() %>% mutate(
      SCORE2_CKD_score = SCORE2_CKD(
        Risk.region = Risk.region,
        Age,
        Gender,
        smoker,
        systolic.bp,
        diabetes,
        total.chol,
        total.hdl,
        eGFR,
        ACR,
        trace,
        addon,
        classify = FALSE
      ),
      SCORE2_CKD_strat = SCORE2_CKD(
        Risk.region = Risk.region,
        Age,
        Gender,
        smoker,
        systolic.bp,
        diabetes,
        total.chol,
        total.hdl,
        eGFR,
        ACR,
        trace,
        addon,
        classify = classify
      ) %>% as.factor() %>% ordered(
        levels = c("Very low risk", "Low risk", "Moderate risk", "High risk")
      )
    )

  }


  else{
    results <- data  %>% rowwise() %>% mutate(
      SCORE2_CKD_score = SCORE2_CKD(
        Risk.region = Risk.region,
        Age,
        Gender,
        smoker,
        systolic.bp,
        diabetes,
        total.chol,
        total.hdl,
        eGFR,
        ACR,
        trace,
        addon,
        classify = classify
      )
    )
  }
  return(results)
}
