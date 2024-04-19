#'  Systematic COronary Risk Evaluation (SCORE) model function including chronic kidney disease (CKD) measures
#'
#'
#' @description This function implements the SCORE2 and SCORE2 older population (OP) score calculation as a vector plus the ckd add-ons as suggested on the https://doi.org/10.1093/eurjpc/zwac216 publication
#'
#'*Diabetes mellitus was included in the modelling since this was necessary for the recalibration approach, which relies data from the whole population, including those with diabetes. However, SCORE2 is not intended for use in individuals with diabetes and has not been validated in this population. For risk prediction in the target population of individuals without diabetes this risk factor will always be 0, meaning the coefficient can effectively be ignored.
#'
#' formula in SCORE2 Updated Supplementary Material page  9. paper:
#' "SCORE2 risk prediction algorithms: new models to estimate 10-year risk of cardiovascular disease in Europe"
#'
#' Age	10-year risk of fatal and non-fatal cardiovascular disease
#'
#'                 | Low risk      |  Moderate risk  |  High risk  |\cr
#' | :------------ | ------------- | --------------- | ----------: |\cr
#' | < 50 years    |   <2.5%	     |  2.5 to <7.5%   |    =>7.5%   |\cr
#' | 50 - 69 years |    <5%        |   5 to <10%	   |     =>10%   |\cr
#' | => 70 years   |   <7.5%	     |  7.5 to <15% 	 |     =>15%   |\cr
#'
#'
#' above classifications referred from https://www.inanutshell.ch/en/digital-doctors-bag/score2-and-score2-op/#:~:text=SCORE2%20(%C2%ABSystematic%20COronary%20Risk%20Evaluation,Society%20of%20Cardiology%20(ESC).
#'
#' The underlying model was developed and validated using eligible data from 3,054,840 individuals from 34 different cohorts and 5,997,719 individuals from 34 independent cohorts, respectively, from the Chronic Kidney Disease Prognosis Consortium. https://doi.org/10.1093/eurjpc/zwac176
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
#'
#'   results <- cohort_xx %>% rowwise() %>%
#'   mutate(SCORE2OP_CKD_score = SCORE2_CKD(Risk.region = "Low", Age, Gender,
#'   smoker, systolic.bp, diabetes, total.chol, total.hdl, eGFR, ACR, trace,
#'   classify = FALSE))
#'
#' @name SCORE2/OP-CKD
#'
#'
#' @export

SCORE2_CKD <- function(Risk.region, Age = Age, Gender = Gender, smoker = smoker, systolic.bp = systolic.bp, diabetes = diabetes, total.chol = total.chol, total.hdl = total.hdl, eGFR = eGFR, ACR = NA, trace = NA, addon = "ACR", classify){




  if (Risk.region == "Low" & Age < 70 & Gender == "male"){
    scale1 <- -0.5699
    scale2 <- 0.7476
  }

  else if (Risk.region == "Low" & Age < 70 & Gender == "female"){
    scale1 <- -0.7380
    scale2 <- 0.7019
  }

  else if (Risk.region == "Moderate" & Age < 70 & Gender == "male"){
    scale1 <-  -0.1565
    scale2 <- 	0.8009
  }

  else if (Risk.region == "Moderate" & Age < 70 & Gender == "female"){
    scale1 <- -0.3143
    scale2 <- 0.7701
  }

  else if (Risk.region == "High" & Age < 70 & Gender == "male"){
    scale1 <-   0.3207
    scale2 <- 	0.9360
  }

  else if (Risk.region == "High" & Age < 70 & Gender == "female"){
    scale1 <- 0.5710
    scale2 <- 0.9369
  }

  else if (Risk.region == "Very high" & Age < 70 & Gender == "male"){
    scale1 <-   0.5836
    scale2 <- 	0.8294
  }

  else if (Risk.region == "Very high" & Age < 70 & Gender == "female"){
    scale1 <- 0.9412
    scale2 <- 0.8329
  }


  else if (Risk.region == "Low" & Age >= 70 & Gender == "male"){
    scale1 <- -0.34
    scale2 <- 1.19
  }
  else if (Risk.region == "Low" & Age >= 70 & Gender == "female"){
    scale1 <- -0.52
    scale2 <- 1.01
  }

  else if (Risk.region == "Moderate" & Age >= 70 & Gender == "male"){
    scale1 <-  0.01
    scale2 <- 	1.25
  }
  else if (Risk.region == "Moderate" & Age >= 70 & Gender == "female"){
    scale1 <- -0.1
    scale2 <- 1.1
  }

  else if (Risk.region == "High" & Age >= 70 & Gender == "male"){
    scale1 <-   0.08
    scale2 <- 	1.15
  }
  else if (Risk.region == "High" & Age >= 70 & Gender == "female"){
    scale1 <- 0.38
    scale2 <- 1.09
  }

  else if (Risk.region == "Very high" & Age >= 70 & Gender == "male"){
    scale1 <-   0.05
    scale2 <- 	0.7
  }

  else if (Risk.region == "Very high" & Age >= 70 & Gender == "female"){
    scale1 <- 0.38
    scale2 <- 0.69
  }else{message("Risk region specification required!")}

  if (Gender == "male" & Age < 70) {
    xx_male <- c(0.3742*(Age - 60)/5 +
                   0.6012*smoker +
                   0.2777*(systolic.bp - 120)/20 +
                   0.6457*diabetes +
                   0.1458*(total.chol - 6)/1 + # /1?
                   (-0.2698)*(total.hdl - 1.3)/0.5 +
                   (-0.0755)*(Age - 60)/5 * smoker +
                   (-0.0255)*(Age - 60)/5 * (systolic.bp - 120)/20 +
                   (-0.0281)*(Age - 60)/5 * (total.chol - 6)/1 +
                   0.0426*(Age - 60)/5 * (total.hdl - 1.3)/0.5 +
                   (-0.0983)*(Age - 60)/5 * diabetes)


    xx_male2 <- 1 - 0.9605^exp(xx_male)

    xx_male3 <- 1-exp(-exp(scale1+scale2 * log(-log(1-xx_male2))))

    x <- xx_male3

  }

  if (Gender == "female" & Age < 70) {
    xx_female <- c(0.4648*(Age - 60)/5 +
                     0.7744*smoker +
                     0.3131*(systolic.bp - 120)/20 +
                     0.8096*diabetes +
                     0.1002*(total.chol - 6)/1 + # /1?
                     (-0.2606)*(total.hdl - 1.3)/0.5 +
                     (-0.1088)*(Age - 60)/5 * smoker +
                     (-0.0277)*(Age - 60)/5 * (systolic.bp - 120)/20 +
                     (-0.0226)*(Age - 60)/5 * (total.chol - 6)/1 +
                     0.0613*(Age - 60)/5 * (total.hdl - 1.3)/0.5 +
                     (-0.1272)*(Age - 60)/5 * diabetes)


    xx_female2 <- 1 - 0.9776^exp(xx_female)

    xx_female3 <- 1-exp(-exp(scale1+scale2 * log(-log(1-xx_female2))))

    x <- xx_female3
  }

  if (Gender == "male" & Age >= 70) {
    xx_male_op <- c(0.0634*(Age - 73) +
                      0.4245*diabetes +
                      0.3524*smoker +
                      0.0094*(systolic.bp - 150) +
                      0.0850*(total.chol - 6) +
                      (-0.3564)*(total.hdl - 1.4) +
                      (-0.0174)*(Age - 73) * diabetes +
                      (-0.0247)*(Age - 73) * smoker +
                      (-0.0005)*(Age - 73) * (systolic.bp - 150) +
                      0.0073*(Age - 73) * (total.chol - 6) +
                      0.0091*(Age - 73) * (total.hdl - 1.4))


    xx_male2_op <- 1 - 0.7576^exp(xx_male_op - 0.0929)

    xx_male3_op <- 1-exp(-exp(scale1+scale2 * log(-log(1-xx_male2_op))))

    x <- xx_male3_op
  }

  if (Gender == "female" & Age >= 70) {
    xx_female_op <- c(0.0789*(Age - 73) +
                        0.6010*diabetes +
                        0.4921*smoker +
                        0.0102*(systolic.bp - 150) +
                        0.0605*(total.chol - 6) +
                        (-0.3040)*(total.hdl - 1.4) +
                        (-0.0107)*(Age - 73) * diabetes +
                        (-0.0255)*(Age - 73) * smoker +
                        (-0.0004)*(Age - 73) * (systolic.bp - 150) +
                        (-0.0009)*(Age - 73) * (total.chol - 6) +
                        0.0154*(Age - 73) * (total.hdl - 1.4))


    xx_female2_op <- 1 - 0.8082^exp(xx_female_op-0.229)

    xx_female3_op <- 1-exp(-exp(scale1+scale2 * log(-log(1-xx_female2_op))))

    x <- xx_female3_op
  }

  # return(x)




  #return(class)


  exeGFR = 87.8980 -
    (3.7891 * (Age - 60) /5) -
    (ifelse(Gender == "female", 0.7023, 0)) -
    (0.2941 * (total.chol - 6)) +
    (1.0960 * (total.hdl - 1.3) /0.5) -
    (0.1364 * (systolic.bp - 120) /20) +
    (0.1205 * diabetes) +
    (1.3211 * smoker) +
    ((0.0555 * (Age - 60) /5) * (total.chol - 6)) +
    ((0.1717 * (Age - 60) /5) * (total.hdl - 1.3) /0.5) +
    ((0.0059 * (Age - 60) /5) * (systolic.bp - 120) /20) -
    ((0.8994 * (Age - 60) /5) * diabetes) +
    ((0.2181 * (Age - 60) /5) * smoker)

  if (Age < 70) {

    score_eGFR = 1 -
    (1 - x) ^ exp(0.4713 * (min(eGFR, 60) / -15 - min(exeGFR, 60) / -15) +
                         0.0956 * (min(max(eGFR - 60, 0), 30) / -15 -
                                     min(max(exeGFR - 60, 0), 30) / -15) -
                         0.0802 * (Age - 60) /5 * (min(eGFR, 60) / -15 -
                                                     min(exeGFR, 60) / -15) +
                         0.0088 * (Age - 60) /5 * (min(max(eGFR - 60, 0), 30) / -15 -
                                                     min(max(exeGFR - 60, 0), 30) / -15))}

  else if (Age >= 70) {
  score_eGFR = 1 -
  (1 - x) ^ exp(0.3072 * (min(eGFR, 60) / -15 - min(exeGFR, 60) / -15) +
                          0.0942 * (min(max(eGFR - 60, 0), 30) / -15 -
                                    min(max(exeGFR - 60, 0), 30) / -15) -
                        0.4616 * (max(eGFR - 90, 0) / -15 -
                                  max(exeGFR - 90, 0) / -15) -
                        0.0127 * (Age - 73) * (min(eGFR, 60) / -15 -
                                               min(exeGFR, 60) / -15) -
                        0.0098 * (Age - 73) * (min(max(eGFR - 60, 0), 30) / -15 -
                                               min(max(exeGFR - 60, 0), 30) / -15) -
                        0.0075 * (Age - 73) * (max(eGFR - 90, 0) / -15 -
                                               max(exeGFR - 90, 0) / -15))}

  exACR = 8 ^ (1 - 0.0225 + 0.0159 * (Age - 60) /5 +
                 ifelse(Gender == "female", 0.0308, 0) +
                 0.0185 * (total.chol - 6) -
                 0.0274 * (total.hdl - 1.3) /0.5 +
                 0.1339 * (systolic.bp - 120) /20 +
                 0.2171 * diabetes +
                 0.0629 * smoker -
                 0.0062 * (Age - 60) /5 * (total.chol - 6) +
                 0.0003 * (Age - 60) /5 * (total.hdl - 1.3) /0.5 +
                 0.0008 * (Age - 60) /5 * (systolic.bp - 120) /20 -
                 0.0109 * (Age - 60) /5 * diabetes +
                 0.0085 * (Age - 60) /5 * smoker +
                 0.4057 * min(eGFR-60, 0) /-15 +
                 0.0597 * min(max(eGFR - 60, 0), 30) /-15 -
                 0.0916 * max(eGFR - 90, 0) /-15)

  if (Age < 70) {
    score_eGFR_ACR = 1 - (1 - score_eGFR) ^ exp(0.2432 * (log(ACR, base = 8) -log(exACR, base = 8)))
  }

  else if (Age >= 70) {
    score_eGFR_ACR = 1 - (1 - score_eGFR) ^ exp (0.2370 * (log(ACR, base = 8) -log(exACR, base = 8)))
  }

  if (Age < 70) {

    score_eGFR_dip = 1 - (1 - score_eGFR) ^ exp(case_when(
      is.na(trace) ~ NA_real_,
      trace == 0 ~ 0,
      trace == "negative" ~ 0,
      trace == "trace" ~ 0.2644,
      trace == "1+" ~ 0.4126,
      trace == "2+" ~ 0.4761,
      trace == "3+" ~ 0.4761,
      trace == "4+" ~ 0.4761,
    ))
  }

  else if (Age >= 70) {

    score_eGFR_dip = 1 - (1 - score_eGFR) ^ exp(case_when(
      is.na(trace) ~ NA_real_,
      trace == 0 ~ 0,
      trace == "negative" ~ 0,
      trace == "trace" ~ 0.2644,
      trace == "1+" ~ 0.4126,
      trace == "2+" ~ 0.4761,
      trace == "3+" ~ 0.4761,
      trace == "4+" ~ 0.4761,
    ))
  }


  if(is.na(ACR) & is.na(trace)){

    ckd <- score_eGFR

  }

  else if(is.na(trace)){

    ckd <- score_eGFR_ACR

  }

  else if(is.na(ACR)){

    ckd <- score_eGFR_dip

  }

  else{

    ckd <- ifelse(addon == "ACR", score_eGFR_ACR, score_eGFR_dip)


  }

  ckd <- round(ckd*100, 1)

  if(is.na(ckd)){
    class <- NA
  }

  else if(Age < 50 & ckd < 2.5){
    class <- "Low risk"
  }

  else if(Age < 50 & (2.5 <= ckd & ckd < 7.5)){
    class <- "Moderate risk"
  }
  else if(Age < 50 & ckd >= 7.5){
    class <- "High risk"
  }

  else if((50  <= Age & Age <= 69) & ckd < 5){
    class <- "Low risk"
  }

  else if((50  <= Age & Age <= 69) & (5 <= ckd & ckd < 10)){
    class <- "Moderate risk"
  }
  else if((50  <= Age & Age <= 69) & ckd >= 10){
    class <- "High risk"
  }

  else if(Age >= 70 & ckd < 7.5){
    class <- "Low risk"
  }

  else if(Age >= 70 & (7.5 <= ckd & ckd < 15)){
    class <- "Moderate risk"
  }
  else if(Age >= 70 & ckd >= 15){
    class <- "High risk"
  }

  if(classify == TRUE){return(class)}

  else{return(ckd)}

}


