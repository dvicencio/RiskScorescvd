#' CAD Consortium Model (BMJ 2012, Table 2 - Low Prevalence)
#'
#' Uses ORs from Table 2 to estimate pre-test probability of CAD in low prevalence populations.
#'
#' @param Age Age in years
#' @param Sex "male" or "female"
#' @param ChestPainType 1 = non-anginal, 2 = atypical angina, 3 = typical angina
#' @param Diabetes 1 = yes, 0 = no
#' @param Hypertension 1 = yes, 0 = no
#' @param Dyslipidaemia 1 = yes, 0 = no
#' @param Smoking 1 = yes, 0 = no
#' @param model_type "basic" or "clinical"
#' @param classify TRUE to return risk category, FALSE for numeric probability
#'
#' @return Probability (%) or risk category

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
