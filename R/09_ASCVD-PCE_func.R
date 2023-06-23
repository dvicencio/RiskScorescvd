#' ASCVD (Atherosclerotic Cardiovascular Disease) Risk Algorithm including Known ASCVD from AHA/ACC
#'
#' @description This function implements the ASCVD score calculation as a vector
#'
#' Scored using 3 steps
#'
#' Step 1: High-Risk Criteria: History of ASCVD \cr
#' History of ASCVD - History of acute coronary syndrome (ACS),
                     #' myocardial infarction (MI), stable angina,
                     #' coronary/other arterial revascularization,
                     #' stroke, transient ischemic attack,
                     #' or Peripheral Arterial Disease (PAD) from atherosclerosis
                     #'
#' Step 2: High-Risk Criteria:\cr
#' Extreme LDL\cr
#' LDL Cholesterol >= 190mg/dL (4.92 mmol/L)
#'
#' Step 3: ASCVD Risk Criteria:\cr
#' Only Apply When LDL 70-189mg/dL (1.81-4.90 mmol/L)\cr
#'
#' Age\cr
#' Diabetes\cr
#' Total cholesterol\cr
#' HDL cholesterol\cr
#' Systolic BP\cr
#' Treatment for Hypertension\cr
#' Smoker\cr
#' Race\cr
#' Black British as Black; everything else as White
#'
#' Three possible outcome
#'
#' High risk - Intensity Statin Therapy\cr
#' Moderate risk- Intensity Statin Therapy\cr
#' Low risk - Intensity Statin Therapy
#'
#' @param Age a numeric vector of age values, in years
#' @param Gender a binary character vector of sex values. Categories should include only 'male' or 'female'
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
#' ASCVD Gender Ethnicity Age total.chol total.hdl
#' systolic.bphypertension smoker diabetes classify
#'
#' @return
#' A vector with ASCVD score calculations
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
#'   Age = as.numeric(sample(30:80, num_rows, replace = TRUE)),
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
#'   systolic.bp = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'   heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'   creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
#'   cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   previous.pci = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   previous.cabg = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   aspirin = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   number.of.episodes.24h = as.numeric(sample(0:20, num_rows, replace = TRUE)),
#'   total.chol = as.numeric(sample(5:100, num_rows, replace = TRUE)),
#'   total.hdl = as.numeric(sample(2:5, num_rows, replace = TRUE)),
#'   Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE)
#' )
#'
#'
#' # Call the function with the cohort_xx
#'
#' results <- cohort_xx %>% rowwise() %>%
#'  mutate(ASCVD_score = ASCVD(Gender, Ethnicity, Age, total.chol, total.hdl,
#'  systolic.bp,hypertension, smoker, diabetes, classify = FALSE))
#'
#' @importFrom PooledCohort predict_10yr_ascvd_risk
#'
#' @export
# Function ----------------------------------------------------------------

ASCVD <- function(Gender = Gender, Ethnicity = Ethnicity, Age = Age, total.chol = total.chol, total.hdl = total.hdl,
                  systolic.bp = systolic.bp, hypertension = hypertension, smoker = smoker, diabetes = diabetes, classify = FALSE ){



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
