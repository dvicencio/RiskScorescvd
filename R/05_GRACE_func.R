#' GRACE Global Registry of Acute Coronary Events version 2.0, 6 months outcome
#'
#' @description This function implements the GRACE 2.0 for 6 months outcome score calculation as a vector
#'
#' Needed variables --------------------------------------------------------
#' Age = A
#' Heart Rate = H
#' Systolic BP = S
#' Creatine = C
#'
#' killip.class class (signs/symptoms) = K
#' No CHF = 1
#' Rales and/or JVD = 2
#' Pulmonary edema = 3
#' Cardiogenic shock = 4
#'
#' Cardiac Arrest = X
#' no = 0  yes = 1
#'
#' ST segment deviation on EKG? = E
#' no = 0  yes = 1
#'
#' Abnormal cardiac enzymes = T
#' no = 0  yes = 1
#'
#' Add variables to equation and solve for p
#' xb= -7.7035 + (0.0531*A) + (0.0087*H) - (0.0168*S) + (0.1823*C) + (0.6931* K) +
#' (1.4586*Xt) + (0.4700*E) + (0.8755*T);
#' p=(exp(xb))/(1 + exp(xb));
#'
#' Possible outcomes
#'
#' A percentage for Probability of death from admission to 6 months is given
#'
#' footnote: * A = Available, NA = notavailable.
#'
#' Another formula found in https://www.outcomes-umassmed.org/grace/files/GRACE_RiskModel_Coefficients.pdf
#' https://www.outcomes-umassmed.org/grace/grace_risk_table.aspx
#' https://www.outcomes-umassmed.org/grace/acs_risk2/index.html
#' •	Low 			       1-88
#' •	Intermediate 		89-118
#' •	High 			     119-263
#'
#'
#' @param ecg.st.depression a binary numeric vector, 1 = yes and 0 = no
#' @param Age a numeric vector of age values, in years
#' @param presentation_hstni a continuous numeric vector of the troponin levels
#' @param Gender a binary character vector of sex values. Categories should include only 'male' or 'female'
#' @param killip.class a numeric vector of killip class values, 1 to 4
#' @param heart.rate a numeric vector of heart rate continuous values
#' @param systolic.bp a numeric vector of systolic blood pressure continuous values
#' @param cardiac.arrest  a binary numeric vector, 1 = yes and 0 = no
#' @param creat a continuous numeric vector of the creatine levels
#' @param classify a logical parameter to indicate classification of Scores "TRUE" or none "FALSE"
#'
#' @keywords
#' GRACE killip.class systolic.bp heart.rate Age creat ecg.st.depression
#' presentation_hstni cardiac.arrest Gender classify
#'
#' @return
#' A vector with GRACE score calculations
#' and/or a vector of their classifications if indicated
#' @examples
#'
#'# Create a data frame or list with the necessary variables
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
#'   cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE))
#' )
#' # Call the function with the cohort_xx
#'
#'   results <- cohort_xx %>% rowwise() %>%
#'   mutate(GRACE_score = GRACE(killip.class, systolic.bp, heart.rate,
#'   Age, creat, ecg.st.depression, presentation_hstni, cardiac.arrest, Gender, classify = FALSE))
#'
#'@importFrom dplyr case_when
#'
#' @export


GRACE <- function(killip.class = killip.class, systolic.bp = systolic.bp, heart.rate = heart.rate, Age = Age, creat = creat, ecg.st.depression = ecg.st.depression,
                   presentation_hstni = presentation_hstni, cardiac.arrest = cardiac.arrest, Gender = Gender, classify = FALSE) {

  # 1. killip.class class I,II,III,IV;
  killip.class2 <- case_when(
    is.na(killip.class) ~ NA_real_,
    killip.class == 1 ~ 0,
    killip.class == 2 ~ 15,
    killip.class == 3 ~ 29,
    killip.class == 4 ~ 44
  )

  # 2. systolic.bp is systolic blood pressure (mm Hg);
  systolic.bp2 <- case_when(
    is.na(systolic.bp) ~ NA_real_,
    0 <= systolic.bp & systolic.bp < 80 ~ 40,
    80 <= systolic.bp & systolic.bp < 100 ~ 40 - (systolic.bp - 80) * (.3),
    100 <= systolic.bp & systolic.bp < 110 ~ 34 - (systolic.bp - 100) * (.3),
    110 <= systolic.bp & systolic.bp < 120 ~ 31 - (systolic.bp - 110) * (.4),
    120 <= systolic.bp & systolic.bp < 130 ~ 27 - (systolic.bp - 120) * (.3),
    130 <= systolic.bp & systolic.bp < 140 ~ 24 - (systolic.bp - 130) * (.3),
    140 <= systolic.bp & systolic.bp < 150 ~ 20 - (systolic.bp - 140) * (.4),
    150 <= systolic.bp & systolic.bp < 160 ~ 17 - (systolic.bp - 150) * (.3),
    160 <= systolic.bp & systolic.bp < 180 ~ 14 - (systolic.bp - 160) * (.3),
    180 <= systolic.bp & systolic.bp < 200 ~ 8 - (systolic.bp - 180) * (.4),
    systolic.bp >= 200 ~ 0
  )

  # 3. heart.rate in beats/minute;
  heart.rate2 <- case_when(
    is.na(heart.rate) ~ NA_real_,
    0 <= heart.rate & heart.rate < 70 ~ 0,
    70 <= heart.rate & heart.rate < 80 ~ 0 + (heart.rate - 70) * (.3),
    80 <= heart.rate & heart.rate < 90 ~ 3 + (heart.rate - 80) * (.2),
    90 <= heart.rate & heart.rate < 100 ~ 5 + (heart.rate - 90) * (.3),
    100 <= heart.rate & heart.rate < 110 ~ 8 + (heart.rate - 100) * (.2),
    110 <= heart.rate & heart.rate < 150 ~ 10 + (heart.rate - 110) * (.3),
    150 <= heart.rate & heart.rate < 200 ~ 22 + (heart.rate - 150) * (.3),
    heart.rate >= 200 ~ 34
  )

  # 4. Age in years;
  Age2 <- case_when(
    is.na(Age) ~ NA_real_,
    0 <= Age & Age < 35 ~ 0,
    35 <= Age & Age < 45 ~ 0 + (Age - 35) * (1.8),
    45 <= Age & Age < 55 ~ 18 + (Age - 45) * (1.8),
    55 <= Age & Age < 65 ~ 36 + (Age - 55) * (1.8),
    65 <= Age & Age < 75 ~ 54 + (Age - 65) * (1.9),
    75 <= Age & Age < 85 ~ 73 + (Age - 75) * (1.8),
    85 <= Age & Age < 90 ~ 91 + (Age - 85) * (1.8),
    Age >= 90 ~ 100
  )

  #creat
  creat2 <- dplyr::case_when(
    is.na(creat) ~ NA_real_,
    0.0 <= creat/88.4 & creat/88.4 < 0.2 ~ 0 + (creat/88.4 - 0) * (1/0.2),
    0.2 <= creat/88.4 & creat/88.4 < 0.4 ~ 1 + (creat/88.4 - 0.2) * (2/0.2),
    0.4 <= creat/88.4 & creat/88.4 < 0.6 ~ 3 + (creat/88.4 - 0.4) * (1/0.2),
    0.6 <= creat/88.4 & creat/88.4 < 0.8 ~ 4 + (creat/88.4 - 0.6) * (2/0.2),
    0.8 <= creat/88.4 & creat/88.4 < 1.0 ~ 6 + (creat/88.4 - 0.8) * (1/0.2),
    1.0 <= creat/88.4 & creat/88.4 < 1.2 ~ 7 + (creat/88.4 - 1.0) * (1/0.2),
    1.2 <= creat/88.4 & creat/88.4 < 1.4 ~ 8 + (creat/88.4 - 1.2) * (2/0.2),
    1.4 <= creat/88.4 & creat/88.4 < 1.6 ~ 10 + (creat/88.4 - 1.4) * (1/0.2),
    1.6 <= creat/88.4 & creat/88.4 < 1.8 ~ 11 + (creat/88.4 - 1.6) * (2/0.2),
    1.8 <= creat/88.4 & creat/88.4 < 2.0 ~ 13 + (creat/88.4 - 1.8) * (1/0.2),
    2.0 <= creat/88.4 & creat/88.4 < 3.0 ~ 14 + (creat/88.4 - 2.0) * (7/1),
    3.0 <= creat/88.4 & creat/88.4 < 4.0 ~ 21 + (creat/88.4 - 3.0) * (7/1),
    creat/88.4 >= 4.0 ~ 28,
    TRUE ~ NA_real_
  )

  #posinit
  posinit <- dplyr::case_when(
    is.na(presentation_hstni) ~ NA_real_,
    Gender == "male" & presentation_hstni >= 34 ~ 13,
    Gender == "male" & presentation_hstni < 34 ~ 0,
    Gender == "female" & presentation_hstni >= 16 ~ 13,
    Gender == "female" & presentation_hstni < 16 ~ 0,
    TRUE ~ NA_real_
  )

  #carrst
  carrst <- dplyr::case_when(
    is.na(cardiac.arrest) ~ 0,
    cardiac.arrest == 1 ~ 30,
    cardiac.arrest == 0 ~ 0,
    TRUE ~ 0
  )

  #stchange
  stchange <- dplyr::case_when(
    is.na(ecg.st.depression) ~ NA_real_,
    ecg.st.depression == 1 ~ 17,
    ecg.st.depression == 0 ~ 0,
    TRUE ~ NA_real_
  )

  # 6. STCHANGE is ST deviation, assigned a value of 1 if present, 0 if absent;
  Death_pt <- killip.class2 + systolic.bp2 + heart.rate2 + Age2 + creat2 + posinit + carrst + stchange

   #return(round(Death_pt, 0))

  if(is.na(Death_pt)){
    pred <- NA
  }
  else if(Death_pt <= 88){
    pred <- "Low risk"
  }

  else if(88 < Death_pt & Death_pt <= 118){
    pred <- "Moderate risk"
  }

  else if(Death_pt > 118){
    pred <- "High risk"
  }


  if(classify == TRUE){return(pred)}

  else{return(round(Death_pt, 0))}

  #  return(pred)

}


