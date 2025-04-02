#' @title SCORE2-Asia-Pacific
#' @description This function calculates the 10-year cardiovascular
#' risk estimation for patients aged 40 to 69 years using the
#' \doi{10.1093/eurheartj/ehae609} SCORE2-Asia-Pacific algorithm.
#' Risk score is expressed as percentage in one decimal place.
#' It also categorises these patients into different risk groups.
#' @param Risk.region Input character to indicate an Asian or Oceania risk region
#' group the patient belongs to. The allowed categories are
#' \itemize{
#'   \item Low
#'   \item Moderate
#'   \item High
#'   \item Very high
#' }
#' @param Age Input positive integer to indicate the age of the patient.
#' @param Gender  Input character to indicate the gender of the patient.
#' The allowed categories are
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
#' @param classify When set to \code{TRUE}, the function will
#' return the patient's risk group based on the SCORE2-Asia-Pacific
#' risk score in percentage rounded to one decimal place.
#' Default: \code{FALSE}.
#'
#' Risk groups are classified based on Figure 3 from the
#'  \doi{10.1093/eurheartj/ehad192} \emph{2023 ESC Guidelines for the management
#' of cardiovascular disease in patients with diabetes}:
#'
#' \tabular{ll}{
#'   \strong{SCORE2-Asia-Pacific Score} \tab
#'   \strong{10-year Cardiovascular Disease (CVD) Risk Group} \cr
#'   \eqn{<5\%} \tab Low risk \cr
#'   \eqn{5\%} to \eqn{<10\%} \tab Moderate risk \cr
#'   \eqn{10\%} to \eqn{<20\%} \tab High risk \cr
#'   \eqn{\ge20\%} \tab Very high risk \cr
#' }
#'
#' @return SCORE2-Asia-Pacific \doi{10.1093/eurheartj/ehae609} risk
#' score expressed as a positive percentage rounded to one decimal place
#' when \code{classify} is \code{FALSE}. A patient's risk group when \code{classify} is \code{TRUE}.
#' @details SCORE2-Asia-Pacific \doi{10.1093/eurheartj/ehae609} was developed
#' by extending the SCORE2 \doi{10.1093/eurheartj/ehab309} algorithms
#' using 8405574 participants (556421 CVD events) from
#' the Asia-Pacific regions without previous CVD.
#'
#' @examples
#' # 50 years old male from low risk region
#' # who is a smoker, non-diabetic
#' # with a systolic blood pressure of 140 mmHg,
#' # total cholesterol of 5.5 mmol/L,
#' # HDL cholesterol of 1.3 mmol/L,
#' # will have a risk score of 10.3 and
#' # at high risk of CVD.
#'
#' SCORE2_Asia_Pacific(
#'   Risk.region = "Low",
#'   Age = 50,
#'   Gender = "male",
#'   smoker = 1,
#'   systolic.bp = 140,
#'   total.chol = 5.5,
#'   total.hdl = 1.3,
#'   diabetes = 0,
#'   classify = FALSE
#' )
#'
#' SCORE2_Asia_Pacific(
#'   Risk.region = "Low",
#'   Age = 50,
#'   Gender = "male",
#'   smoker = 1,
#'   systolic.bp = 140,
#'   total.chol = 5.5,
#'   total.hdl = 1.3,
#'   diabetes = 0,
#'   classify = TRUE
#' )
#'
#' @references
#'
#' \subsection{Primary Paper}{
#' \itemize{
#'   \item SCORE2 Asia-Pacific writing group, Hageman SHJ, Huang Z, Lee H, Kaptoge S,
#'         Dorresteijn JAN, Pennells L, Angelantonio ED, Visseren FLJ, Hyeon CK, Johar A,
#'         the European Society of Cardiology and European
#'         Association of Preventive Cardiology: Cardiovascular Risk Collaboration (ESC CRC),
#'         the ASEAN Federation of Cardiology (AFC),
#'         the Asian-Pacific Society of Cardiology (APSC),
#'         on behalf of the SCORE2 Asia-Pacific collaborators,
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
#'         \doi{10.1093/eurheartj/ehad192}
#' }
#' }
#'
#' @rdname SCORE2_Asia_Pacific
#' @export
SCORE2_Asia_Pacific <- function(
    Risk.region,
    Age,
    Gender,
    smoker,
    systolic.bp,
    total.chol,
    total.hdl,
    diabetes,
    classify = FALSE
){

  ten_year_cvd_risk = NA_real_

  scale1 <- dplyr::case_when(
    Risk.region == "Low"       & Gender == "male"   ~ -0.375229965,
    Risk.region == "Moderate"  & Gender == "male"   ~  0.284885676,
    Risk.region == "High"      & Gender == "male"   ~  0.778231091,
    Risk.region == "Very high" & Gender == "male"   ~  0.608975204,
    Risk.region == "Low"       & Gender == "female" ~ -0.986572446,
    Risk.region == "Moderate"  & Gender == "female" ~  0.08278687,
    Risk.region == "High"      & Gender == "female" ~  0.611474287,
    Risk.region == "Very high" & Gender == "female" ~  0.502751798,
    .default = NA_real_
  )

  scale2 <- dplyr::case_when(
    Risk.region == "Low"       & Gender == "male"   ~ 0.62020875,
    Risk.region == "Moderate"  & Gender == "male"   ~ 0.778128607,
    Risk.region == "High"      & Gender == "male"   ~ 0.844985356,
    Risk.region == "Very high" & Gender == "male"   ~ 0.679014197,
    Risk.region == "Low"       & Gender == "female" ~ 0.536743779,
    Risk.region == "Moderate"  & Gender == "female" ~ 0.718980326,
    Risk.region == "High"      & Gender == "female" ~ 0.703624072,
    Risk.region == "Very high" & Gender == "female" ~ 0.555577072,
    .default = NA_real_
  )

  # Calculate SCORE2-Asia-Pacific

  if (isTRUE(Gender == "male")) {
    linear_predictor_male <-
      # SCORE2 variables
      ( 0.3742 * ((Age - 60)/5)) +
      ( 0.6012 * smoker) +
      ( 0.2777 * ((systolic.bp - 120)/20)) +
      ( 0.6457 * diabetes) +
      ( 0.1458 * ((total.chol - 6)/1)) +
      (-0.2698 * ((total.hdl - 1.3)/0.5)) +
      (-0.0755 * ((Age - 60)/5) * smoker) +
      (-0.0255 * ((Age - 60)/5) * ((systolic.bp - 120)/20)) +
      (-0.0983 * ((Age - 60)/5) * diabetes) +
      (-0.0281 * ((Age - 60)/5) * ((total.chol - 6)/1)) +
      ( 0.0426 * ((Age - 60)/5) * ((total.hdl - 1.3)/0.5))

    uncalibrated_risk_male <-
      1 - 0.9605^exp(linear_predictor_male)

    calibrated_risk_male <-
      1 - exp(-exp(scale1 + scale2 * log(-log(1 - uncalibrated_risk_male))))

    ten_year_cvd_risk <- calibrated_risk_male

  } else if (isTRUE(Gender == "female")) {

    linear_predictor_female <-
      # SCORE2 variables
      ( 0.4648 * ((Age - 60)/5)) +
      ( 0.7744 * smoker) +
      ( 0.3131 * ((systolic.bp - 120)/20)) +
      ( 0.8096 * diabetes) +
      ( 0.1002 * ((total.chol - 6)/1)) +
      (-0.2606 * ((total.hdl - 1.3)/0.5)) +
      (-0.1088 * ((Age - 60)/5) * smoker) +
      (-0.0277 * ((Age - 60)/5) * ((systolic.bp - 120)/20)) +
      (-0.1272 * ((Age - 60)/5) * diabetes) +
      (-0.0226 * ((Age - 60)/5) * ((total.chol - 6)/1)) +
      ( 0.0613 * ((Age - 60)/5) * ((total.hdl - 1.3)/0.5))

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
