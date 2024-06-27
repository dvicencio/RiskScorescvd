#' @title SCORE2-Diabetes
#' @description This function calculates the 10-year cardiovascular
#' risk estimation for patients aged 40 to 69 years with type 2 diabetes
#' without atherosclerotic cardiovascular disease (ASCVD) or
#' severe target organ damage (TOD) using the
#' \doi{10.1093/eurheartj/ehad260} SCORE2-Diabetes algorithm.
#' Risk score is expressed as percentage in one decimal place.
#' It also categorises these patients into different risk groups.
#' @param Risk.region Input character to indicate an European risk region
#' group the patient belongs to. The allowed categories are
#' \itemize{
#'   \item Low
#'   \item Moderate
#'   \item High
#'   \item Very high
#' }
#' @param Age Input positive integer to indicate the age of the patient.
#' @param Gender Input character to indicate an European risk region
#' group the patient belongs to. The allowed categories are
#' \itemize{
#'   \item male
#'   \item female
#' }
#' @param smoker Input integer 0 or 1 to indicate if the patient
#' is a current smoker.
#' \itemize{
#'   \item 0 stands for patient is either a former/past smoker or a non-smoker.
#'   \item 1 stands for patient is a current smoker.
#' }
#' @param systolic.bp Input positive numeric value to indicate the
#' patient's systolic blood pressure in \eqn{mm HG}.
#' @param total.chol Input positive numeric value to indicate the
#' patient's total cholesterol in \eqn{mmol/L}.
#' @param total.hdl Input positive numeric value to indicate the
#' patient's high-density lipoprotein (HDL) in \eqn{mmol/L}.
#' @param diabetes Input integer 0 or 1 to indicate if the patient
#' has diabetes.
#' \itemize{
#'   \item 0 stands for not having diabetes.
#'   \item 1 stands for having diabetes.
#' }
#' @param diabetes.age Input positive integer to indicate the age
#' when the patient is diagnosed with diabetes. It can be set
#' to \code{NA} if patient is not diabetic.
#' @param HbA1c Input positive numeric value to indicate the
#' patient's hemoglobin A1C (HbA1c) in \eqn{mmol/mol}.
#' @param eGFR Input positive numeric value to indicate the
#' patient's estimated glomerular filtration rate (eGFR)
#' in \eqn{ml/min/1.73m^2}.
#' @param classify When set to \code{TRUE}, the function will
#' return the patient's risk group based on the SCORE2-Diabetes
#' risk score in percentage rounded to one decimal place.
#' Default: \code{FALSE}.
#'
#' Risk groups are classified based on Figure 3 from the
#'  \doi{10.1093/eurheartj/ehad192} \emph{2023 ESC Guidelines for the management
#' of cardiovascular disease in patients with diabetes}:
#'
#' \tabular{ll}{
#'   \strong{SCORE2-Diabetes Score} \tab
#'   \strong{10-year Cardiovascular Disease (CVD) Risk Group} \cr
#'   \eqn{<5\%} \tab Low risk \cr
#'   \eqn{5\%} to \eqn{<10\%} \tab Moderate risk \cr
#'   \eqn{10\%} to \eqn{<20\%} \tab High risk \cr
#'   \eqn{\ge20\%} \tab Very high risk \cr
#' }
#'
#' @return SCORE2-Diabetes risk \doi{10.1093/eurheartj/ehad260}
#' score expressed as a positive percentage rounded to one decimal place
#' when \code{classify} is \code{FALSE}. A patient's risk group when \code{classify} is \code{TRUE}.
#' @details \doi{10.1093/eurheartj/ehad260} was developed
#' by extending the SCORE2 \doi{10.1093/eurheartj/ehad260} algorithms
#' using 229460 participants (43706 CVD events) with type 2 diabetes and without previous CVD
#' from four population data sources [Scottish Care Information—Diabetes (SCID),
#' Clinical Practice Research Datalink (CPRD), UK Biobank (UKB),
#' Emerging Risk Factors Collaboration (ERFC)] across seven countries
#' (England, Wales, Scotland, France, Germany, Italy, and the USA).
#'
#' @examples
#' # 60 years old male from low risk region
#' # who is a non-smoker, diabetic at age 60
#' # with a systolic blood pressure of 140 mmHg,
#' # total cholesterol of 5.5 mmol/L,
#' # HDL cholesterol of 1.3 mmol/L,
#' # HbA1c of 50 mmol/mol and
#' # eGFR of 90 mL/min/1.73m2
#' # will have a risk score of 8.4 and
#' # at moderate risk of CVD.
#'
#' SCORE2_Diabetes(
#'   Risk.region = "Low",
#'   Age = 60,
#'   Gender = "male",
#'   smoker = 0,
#'   systolic.bp = 140,
#'   total.chol = 5.5,
#'   total.hdl = 1.3,
#'   diabetes = 1,
#'   diabetes.age = 60,
#'   HbA1c = 50,
#'   eGFR = 90,
#'   classify = FALSE
#' )
#'
#' SCORE2_Diabetes(
#'   Risk.region = "Low",
#'   Age = 60,
#'   Gender = "male",
#'   smoker = 0,
#'   systolic.bp = 140,
#'   total.chol = 5.5,
#'   total.hdl = 1.3,
#'   diabetes = 1,
#'   diabetes.age = 60,
#'   HbA1c = 50,
#'   eGFR = 90,
#'   classify = TRUE
#' )
#'
#' @references
#'
#' \subsection{Primary Paper}{
#' \itemize{
#'   \item SCORE2-Diabetes Working Group and the ESC Cardiovascular Risk Collaboration,
#'         SCORE2-Diabetes: 10-year cardiovascular risk estimation in type 2 diabetes
#'         in Europe, \emph{Eur Heart J}, \strong{44}:2544–2556,
#'        \doi{10.1093/eurheartj/ehad260}
#' }
#' }
#'
#' \subsection{Clinical Practice Guidelines}{
#' \itemize{
#'   \item Marx N, Federici M, Schütt K, Müller-Wieland D,
#'         Ajjan RA,vAntunes MJ, Christodorescu RM, Crawford C,
#'         Angelantonio ED, Eliasson B, Espinola-Klein C,
#'         Fauchier L, Halle M, Herrington WG,
#'         Kautzky-Willer A, Lambrinou E, Lesiak M,
#'         Lettino M, McGuire DK, Mullens W,
#'         Rocca B, Sattar N,
#'         ESC Scientific Document Group,
#'         2023 ESC Guidelines for the management of cardiovascular
#'         disease in patients with diabetes: Developed by the task force
#'         on the management of cardiovascular disease in patients with
#'         diabetes of the European Society of Cardiology (ESC),
#'         \emph{Eur Heart J}, \strong{44}:4043–4140,
#'         \doi{10.1093/eurheartj/ehad260}
#' }
#' }
#'
#' @rdname SCORE2_Diabetes
#' @export
SCORE2_Diabetes <- function(
    Risk.region,
    Age,
    Gender,
    smoker,
    systolic.bp,
    total.chol,
    total.hdl,
    diabetes,
    diabetes.age,
    HbA1c,
    eGFR,
    classify = FALSE
){

  ten_year_cvd_risk = NA_real_

  # Resolve case when diabetes.age is NA as patient is not diabetic
  # This is done by setting diabetes.age to be 0 so that score is not NA
  diabetes.age <- dplyr::case_when(
    diabetes == 0 ~ 0,
    diabetes == 1 ~ diabetes.age,
    .default = NA
  )

  scale1 <- dplyr::case_when(
    Risk.region == "Low"       & Gender == "male"   ~ -0.5699,
    Risk.region == "Moderate"  & Gender == "male"   ~ -0.1565,
    Risk.region == "High"      & Gender == "male"   ~  0.3207,
    Risk.region == "Very high" & Gender == "male"   ~  0.5836,
    Risk.region == "Low"       & Gender == "female" ~ -0.7380,
    Risk.region == "Moderate"  & Gender == "female" ~ -0.3143,
    Risk.region == "High"      & Gender == "female" ~  0.5710,
    Risk.region == "Very high" & Gender == "female" ~  0.9412,
    .default = NA_real_
  )

  scale2 <- dplyr::case_when(
    Risk.region == "Low"       & Gender == "male"   ~ 0.7476,
    Risk.region == "Moderate"  & Gender == "male"   ~ 0.8009,
    Risk.region == "High"      & Gender == "male"   ~ 0.9360,
    Risk.region == "Very high" & Gender == "male"   ~ 0.8294,
    Risk.region == "Low"       & Gender == "female" ~ 0.7019,
    Risk.region == "Moderate"  & Gender == "female" ~ 0.7701,
    Risk.region == "High"      & Gender == "female" ~ 0.9369,
    Risk.region == "Very high" & Gender == "female" ~ 0.8329,
    .default = NA_real_
  )

  # Calculate SCORE2-Diabetes

  if (isTRUE(Gender == "male")) {
    linear_predictor_male <-
      # SCORE2 variables
      ( 0.5368 * ((Age - 60)/5)) +
      ( 0.4774 * smoker) +
      ( 0.1322 * ((systolic.bp - 120)/20)) +
      ( 0.6457 * diabetes) +
      ( 0.1102 * ((total.chol - 6)/1)) +
      (-0.1087 * ((total.hdl - 1.3)/0.5)) +
      (-0.0672 * ((Age - 60)/5) * smoker) +
      (-0.0268 * ((Age - 60)/5) * ((systolic.bp - 120)/20)) +
      (-0.0983 * ((Age - 60)/5) * diabetes) +
      (-0.0181 * ((Age - 60)/5) * ((total.chol - 6)/1)) +
      ( 0.0095 * ((Age - 60)/5) * ((total.hdl - 1.3)/0.5)) +
      # SCORE2-DM2 additional variables
      (-0.0998 * diabetes * ((diabetes.age - 50)/5)) +
      ( 0.0955 * ((HbA1c - 31)/9.34)) +
      (-0.0591 * ((log(eGFR) - 4.5)/0.15)) +
      ( 0.0058 * ((log(eGFR) - 4.5)/0.15) * ((log(eGFR) - 4.5)/0.15)) +
      (-0.0134 * ((HbA1c - 31)/9.34) * ((Age - 60)/5)) +
      ( 0.0115 * ((log(eGFR) - 4.5)/0.15) * ((Age - 60)/5))

    uncalibrated_risk_male <-
      1 - 0.9605^exp(linear_predictor_male)

    calibrated_risk_male <-
      1 - exp(-exp(scale1 + scale2 * log(-log(1 - uncalibrated_risk_male))))

    ten_year_cvd_risk <- calibrated_risk_male

  } else if (isTRUE(Gender == "female")) {

    linear_predictor_female <-
      # SCORE2 variables
      ( 0.6624 * ((Age - 60)/5)) +
      ( 0.6139 * smoker) +
      ( 0.1421 * ((systolic.bp - 120)/20)) +
      ( 0.8096 * diabetes) +
      ( 0.1127 * ((total.chol - 6)/1)) +
      (-0.1568 * ((total.hdl - 1.3)/0.5)) +
      (-0.1122 * ((Age - 60)/5) * smoker) +
      (-0.0167 * ((Age - 60)/5) * ((systolic.bp - 120)/20)) +
      (-0.1272 * ((Age - 60)/5) * diabetes) +
      (-0.0200 * ((Age - 60)/5) * ((total.chol - 6)/1)) +
      ( 0.0186 * ((Age - 60)/5) * ((total.hdl - 1.3)/0.5)) +
      # SCORE2-DM2 additional variables
      (-0.118  * diabetes * ((diabetes.age - 50)/5)) +
      ( 0.1173 * ((HbA1c - 31)/9.34)) +
      (-0.0640 * ((log(eGFR) - 4.5)/0.15)) +
      ( 0.0062 * ((log(eGFR) - 4.5)/0.15) * ((log(eGFR) - 4.5)/0.15)) +
      (-0.0196 * ((HbA1c - 31)/9.34) * ((Age - 60)/5)) +
      ( 0.0169 * ((log(eGFR) - 4.5)/0.15) * ((Age - 60)/5))

    uncalibrated_risk_female <-
      1 - 0.9776^exp(linear_predictor_female)

    calibrated_risk_female <-
      1 - exp(-exp(scale1 + scale2 * log(-log(1 - uncalibrated_risk_female))))

    ten_year_cvd_risk <- calibrated_risk_female

  }

  # Convert risk to percentage rounded to 1 decimal place

  ten_year_cvd_risk_percentage <- (ten_year_cvd_risk * 100) |>
    round_to_nearest_digit(digits = 1)

  if (isTRUE(classify)) {

    # Classify percentage to different risk group
    # based on 2023 ESC Guidelines for the management
    # of cardiovascular disease in patients with diabetes

    ten_year_cvd_risk_group <- dplyr::case_when(
      (ten_year_cvd_risk_percentage < 5) ~ "Low risk",
      (ten_year_cvd_risk_percentage >=5 &
         ten_year_cvd_risk_percentage < 10) ~ "Moderate risk",
      (ten_year_cvd_risk_percentage >=10 &
         ten_year_cvd_risk_percentage < 20) ~ "High risk",
      (ten_year_cvd_risk_percentage >=20) ~ "Very high risk",
      .default = NA_character_
    )

    return(ten_year_cvd_risk_group)
  } else {
    return(ten_year_cvd_risk_percentage)
  }


}
