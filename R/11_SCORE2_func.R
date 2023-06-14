#'  Systematic COronary Risk Evaluation (SCORE) model
#'
#'
#' @description This function implements the ASCVD score calculation as a vector
#'
#' formula in SCORE2 Updated Supplementary Material page  9. paper:
#' "SCORE2 risk prediction algorithms: new models to estimate 10-year risk of cardiovascular disease in Europe"
#'
#' Age	10-year risk of fatal and non-fatal cardiovascular disease
#'               Low risk    Moderate risk     High risk
#' < 50 years   	  <2.5%	  |   2.5 to <7.5%  | 	≥7.5%
#' 50 - 69 years	  <5%     |   5 to <10%	    |   ≥10%
#'  ≥ 70 years	    <7.5%	  |  7.5 to <15% 	  |   ≥15%
#'
#' above classifications referred from https://www.inanutshell.ch/en/digital-doctors-bag/score2-and-score2-op/#:~:text=SCORE2%20(%C2%ABSystematic%20COronary%20Risk%20Evaluation,Society%20of%20Cardiology%20(ESC).
#'
#' @param Age a numeric vector of age values, in years
#' @param Gender a binary character vector of Gender values. Categories should include only 'male' or 'female'.
#' @param smoker a binary numeric vector, 1 = yes and 0 = no
#' @param systolic.bp a numeric vector of systolic blood pressure continuous values
#' @param total.chol a numeric vector of total cholesterol values, in mmol/L
#' @param total.hdl a numeric vector of total high density lipoprotein total.hdl values, in mmol/L
#' @param classify set TRUE if wish to add a column with the scores' categories
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no
#'
#' @keywords
#' SCORE2/OP, Age, Gender, smoker, systolic.bp, diabetes, total.chol,
#' total.hdl, classify
#'
#' @return
#' A vector with SCORE2/OP score calculations
#' and/or a vector of their classifications if indicated
#'
#' @examples
#'   results <- cohort_xx %>% rowwise() %>%
#'   mutate(SCORE2OP_score = SCORE2(Age, Gender, smoker, systolic.bp, diabetes,
#'   total.chol, total.hdl, classify = FALSE))
#'
#' @name SCORE2/OP
#'
#'
#' @export

SCORE2 <- function(Age = Age, Gender = Gender, smoker = smoker, systolic.bp = systolic.bp, diabetes = diabetes, total.chol = total.chol, total.hdl = total.hdl, classify){


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

    xx_male3 <- 1-exp(-exp(-0.5699+0.7476 * log(-log(1-xx_male2))))

    x <- round(xx_male3*100, 1)

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

    xx_female3 <- 1-exp(-exp(-0.7380+0.7019 * log(-log(1-xx_female2))))

    x <- round(xx_female3*100, 1)
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

    xx_male3_op <- 1-exp(-exp(-0.61+0.89 * log(-log(1-xx_male2_op))))

    x <- round(xx_male3_op*100, 1)
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

    xx_female3_op <- 1-exp(-exp(-0.85+0.82 * log(-log(1-xx_female2_op))))

    x <- round(xx_female3_op*100, 1)
  }

 # return(x)


  if(is.na(x)){
    class <- NA
  }

  else if(Age < 50 & x < 2.5){
    class <- "Low risk"
  }

  else if(Age < 50 & (2.5 <= x & x < 7.5)){
    class <- "Moderate risk"
  }
  else if(Age < 50 & x >= 7.5){
    class <- "High risk"
  }

  else if((50  <= Age & Age <= 69) & x < 5){
    class <- "Low risk"
  }

  else if((50  <= Age & Age <= 69) & (5 <= x & x < 10)){
    class <- "Moderate risk"
  }
  else if((50  <= Age & Age <= 69) & x >= 10){
    class <- "High risk"
  }

  else if(Age >= 70 & x < 7.5){
    class <- "Low risk"
  }

  else if(Age >= 70 & (7.5 <= x & x < 15)){
    class <- "Moderate risk"
  }
  else if(Age >= 70 & x >= 15){
    class <- "High risk"
  }

  if(classify == TRUE){return(class)}

  else{return(round(x))}

  #return(class)

}


