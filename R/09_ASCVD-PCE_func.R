#' ASCVD (Atherosclerotic Cardiovascular Disease) Risk Algorithm including Known ASCVD from AHA/ACC
#'
#' @description This function implements the ASCVD score calculation as a vector
#'
#' Scored using 3 steps
#'
#' Step 1: High-Risk Criteria: History of ASCVD
#' History of ASCVD - History of acute coronary syndrome (ACS),
                     #' myocardial infarction (MI), stable angina,
                     #' coronary/other arterial revascularization,
                     #' stroke, transient ischemic attack,
                     #' or Peripheral Arterial Disease (PAD) from atherosclerosis
                     #'
#' Step 2: High-Risk Criteria: Extreme LDL
#' LDL Cholesterol ≥190mg/dL (4.92 mmol/L)
#'
#' Step 3: ASCVD Risk Criteria; Only Apply When LDL 70-189mg/dL (1.81-4.90 mmol/L)
#' Age
#' Diabetes
#' Total cholesterol
#' HDL cholesterol
#' Systolic BP
#' Treatment for Hypertension
#' Smoker
#' Race
#' Balck british as Black; everything else as White
#'
#' Three possible outcome
#'
#' High-Intensity Statin Therapy
#' Moderate-Intensity Statin Therapy
#' Low-Intensity Statin Therapy
#'
#' @param Age a numeric vector of age values, in years
#' @param Gender a binary character vector of sex values. Categories should include
#' only 'male' or 'female'.
#' @param smoker a binary numeric vector, 1 = yes and 0 = no
#' @param systolic.bp a numeric vector of systolic blood pressure continuous values
#' @param Ethnicity a character vector, 'white', 'black', 'asian', or other
#' @param total.chol a numeric vector of total cholesterol values, in mmol/L
#' @param total.hdl a numeric vector of total high density lipoprotein HDL values, in mmol/L
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no
#' @param hypertension a binary numeric vector, 1 = yes and 0 = no
#' @param classify a logical parameter to indicate classification of Scores "TRUE" or none "FALSE"
#'
#' @keywords
#' ASCVD, Gender, Ethnicity, Age, total.chol, total.hdl,
#' systolic.bp,hypertension, smoker, diabetes, classify
#'
#' @return
#' A vector with ASCVD score calculations
#' and/or a vector of their classifications if indicated
#'
#' @examples
#' results <- cohort_xx %>% rowwise() %>% mutate(ASCVD_score = ASCVD(Gender, Ethnicity, Age, total.chol, total.hdl, systolic.bp,hypertension, smoker, diabetes, classify = FALSE))
#'
#' @import dplyr
#' @import PooledCohort
#' @export
# Function ----------------------------------------------------------------

ASCVD <- function(Gender, Ethnicity, Age, total.chol, total.hdl,
                  systolic.bp, hypertension, smoker, diabetes, classify ){

  round_DD <- function(x, n) {
    posneg = sign(x)
    z = abs(x) * 10^n
    z = z + 0.5
    z = trunc(z)
    z = z / 10^n
    z * posneg
  }
  score <- round_DD(predict_10yr_ascvd_risk(sex = Gender,
                                   race = Ethnicity, age_years = Age,
                                   chol_total_mgdl = total.chol*38.67,
                                   chol_hdl_mgdl = total.hdl*38.67,
                                   bp_sys_mmhg = systolic.bp,
                                   bp_meds = hypertension,
                                   smoke_current = smoker,
                                   diabetes = diabetes,
                                   sex_levels = list(female = 'female', male = 'male'),
                                   race_levels = list(black = 'black',
                                                      white = c('white', 'other', 'asian')), # if you have other, group with white
                                   smoke_current_levels = list(no = '0', yes = '1'),
                                   bp_meds_levels = list(no = '0', yes = '1'),
                                   diabetes_levels = list(no = '0', yes = '1'), override_boundary_errors = TRUE), 2)

  class <- function(score) {
    if (is.na(score)) {
      class <- NA
    }

    else if (score < 0.05) {
      class <- "Very low risk"
    }

    else if (0.05 <= score & score < 0.075) {
      class <- "Low risk"
    }

    else if (0.075 <= score & score < .2) {
      class <- "Moderate risk"
    }

    else if (score >= .2) {
      class <- "High risk"
    }

    return(class)
  }

  pred <- class(score)

  if (classify == TRUE) {
    return(pred)
  }


  else{
    return(score)
  }

  }
