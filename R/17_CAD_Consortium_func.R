#' Coronary Artery Disease Consortium Score (Low Prevalence Model)
#'
#' @description This function implements the CAD Consortium model (BMJ 2012, Table 2 - Low Prevalence)
#' to estimate the pre-test probability of obstructive coronary artery disease (CAD)
#' in patients based on age, sex, symptoms, and cardiovascular risk factors.
#'
#' There are two models available:
#' - Basic model: age, sex, chest pain type
#' - Clinical model: includes additional risk factors (diabetes, hypertension, dyslipidaemia, smoking)
#'
#' Chest Pain Types:
#' - 1: Non-anginal
#' - 2: Atypical angina
#' - 3: Typical angina
#'
#' The function uses published odds ratios to compute a logistic regression-based probability
#' of CAD, expressed as a percentage. When `classify = TRUE`, it returns a risk category:
#' - Low (<15%)
#' - Intermediate (15–50%)
#' - High (50–85%)
#' - Very High (>85%)
#'
#' @param Age A numeric value for age in years.
#' @param Sex A character vector ("male" or "female").
#' @param ChestPainType A numeric value: 1 (non-anginal), 2 (atypical angina), or 3 (typical angina).
#' @param Diabetes A binary value: 1 = yes, 0 = no.
#' @param Hypertension A binary value: 1 = yes, 0 = no.
#' @param Dyslipidaemia A binary value: 1 = yes, 0 = no.
#' @param Smoking A binary value: 1 = yes, 0 = no.
#' @param model_type A character value, "basic" or "clinical". Defaults to "clinical".
#' @param classify A logical value. If TRUE, returns a risk category; if FALSE, returns numeric probability.
#'
#' @return A numeric value representing the pre-test probability (%) of CAD, or a categorical risk label.
#'
#' @examples
#' # Basic model
#' CAD_Consortium_func(Age = 60, Sex = "male", ChestPainType = 3, model_type = "basic")
#'
#' # Clinical model with risk classification
#' CAD_Consortium_func(Age = 55, Sex = "female", ChestPainType = 2, Diabetes = 1,
#'   Hypertension = 1, Dyslipidaemia = 1, Smoking = 0, model_type = "clinical", classify = TRUE)
#'
#' @keywords CAD risk score pretest probability BMJ
#' @importFrom dplyr case_when
#' @name CAD_Consortium_func
#' @export

CAD_Consortium_func <- function(Age,
                                  Sex,
                                  ChestPainType,
                                  Diabetes = 0,
                                  Hypertension = 0,
                                  Dyslipidaemia = 0,
                                  Smoking = 0,
                                  model_type = "clinical",
                                  classify = FALSE) {

  # Convert OR to log(OR) coefficients
  logOR <- list(
    basic = list(
      intercept = -6.917,  # from Table in earlier figure
      age = log(1.89) / 10,  # per year
      sex = log(3.89),
      cp = c("non" = 0, "atypical" = log(1.93), "typical" = log(7.21))
    ),
    clinical = list(
      intercept = -7.539,
      age = log(1.85) / 10,  # per year
      sex = log(3.79),
      cp_typical_diab = log(4.91),
      cp_typical_nodiab = log(7.36),
      cp_atypical = log(1.88),
      diabetes = log(2.29),
      hypertension = log(1.40),
      lipids = log(1.53),
      smoking = log(1.59)
    )
  )

  model <- match.arg(model_type, choices = c("basic", "clinical"))
  beta <- logOR[[model]]

  SexNum <- ifelse(tolower(Sex) == "male", 1, 0)

  # Chest pain effect
  cp_term <- switch(as.character(ChestPainType),
                    "1" = 0,
                    "2" = ifelse(model == "clinical", beta$cp_atypical, beta$cp["atypical"]),
                    "3" = ifelse(model == "clinical",
                                 ifelse(Diabetes == 1, beta$cp_typical_diab, beta$cp_typical_nodiab),
                                 beta$cp["typical"]),
                    stop("Invalid ChestPainType")
  )

  # Build logit
  logit <- beta$intercept +
    beta$age * Age +
    beta$sex * SexNum +
    cp_term

  if (model == "clinical") {
    logit <- logit +
      beta$diabetes * Diabetes +
      beta$hypertension * Hypertension +
      beta$lipids * Dyslipidaemia +
      beta$smoking * Smoking
  }

  prob <- 1 / (1 + exp(-logit))
  ptp <- round(prob * 100, 1)

  if (classify) {
    return(dplyr::case_when(
      ptp < 15 ~ "Low (<15%)",
      ptp <= 50 ~ "Intermediate (15-50%)",
      ptp <= 85 ~ "High (50-85%)",
      ptp > 85 ~ "Very High (>85%)"
    ))
  } else {
    return(ptp)
  }
}
