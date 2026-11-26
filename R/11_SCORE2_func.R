#'  Systematic COronary Risk Evaluation (SCORE) model function
#'
#'
#' @description This function implements the SCORE2 and SCORE2 older population (OP) score calculation as a vector
#'
#'*Diabetes mellitus was included in the modelling since this was necessary for the recalibration approach, which relies data from the whole population, including those with diabetes. However, SCORE2 is not intended for use in individuals with diabetes and has not been validated in this population. For risk prediction in the target population of individuals without diabetes this risk factor will always be 0, meaning the coefficient can effectively be ignored.
#'
#' **Diabetes handling (since 0.4.0):** for patients aged under 70 (SCORE2)
#' with `diabetes = 1`, the function returns `NA` with a warning, because
#' SCORE2 is not validated in people with diabetes (Hageman et al. 2022,
#' \doi{10.1093/eurheartj/ehab761}, Table 1 footnote; SCORE2 working group
#' 2021, \doi{10.1093/eurheartj/ehab309}). Use [SCORE2_Diabetes()]
#' for these patients. For patients aged 70 and over (SCORE2-OP), diabetes is
#' a predictor in the published model and is used as before.
#'
#' **Missing inputs (since 0.4.0):** if any required input is `NA`, the
#' result is `NA` with a warning naming the missing input(s). SCORE2 gives
#' no rule for imputing a missing predictor.
#'
#' **Vector input (since 0.4.0):** every input except `classify` can be a
#' vector of length 1 or n; the result is a vector of length n, identical to
#' scoring each row separately.
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
#' Risk categories as defined in the 2021 ESC Guidelines on cardiovascular
#' disease prevention (Visseren et al., \doi{10.1093/eurheartj/ehab484}).
#' Ages are grouped as under 50, 50 to under 70, and 70 and over, matching
#' the SCORE2 / SCORE2-OP age split.
#'
#' above classifications referred from https://www.inanutshell.ch/en/digital-doctors-bag/score2-and-score2-op/#:~:text=SCORE2%20(%C2%ABSystematic%20COronary%20Risk%20Evaluation,Society%20of%20Cardiology%20(ESC).
#'
#' @param Risk.region a character value to set the desired risk region calculations. Categories should include "Low", "Moderate", "High", or "Very high"
#' @param Age a numeric vector of age values, in years. SCORE2 applies to
#'   ages 40-69 and SCORE2-OP to ages 70 and over; `Age < 40` gives `NA`
#'   with a warning (\doi{10.1093/eurheartj/ehab309}).
#' @param Gender a binary character vector of Gender values. Categories should include only 'male' or 'female'
#' @param smoker a binary numeric vector, 1 = yes and 0 = no
#' @param systolic.bp a numeric vector of systolic blood pressure continuous values
#' @param total.chol a numeric vector of total cholesterol values, in mmol/L
#' @param total.hdl a numeric vector of total high density lipoprotein total.hdl values, in mmol/L
#' @param classify set TRUE if wish to add a column with the scores' categories
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no. If omitted,
#'   it is assumed to be 0 (no diabetes, the population SCORE2 is intended
#'   for) with a warning; pass it explicitly to silence this. For ages under
#'   70, `diabetes = 1` gives `NA` with a warning (see Description); an
#'   explicit `NA` is treated as a missing input.
#'
#' @keywords
#' SCORE2/OP Age Gender smoker systolic.bp diabetes total.chol
#' total.hdl classify
#'
#' @return
#' A vector with SCORE2/OP score calculations
#' and/or a vector of their classifications if indicated. `NA` (with a
#' warning) for patients aged under 70 with `diabetes = 1`, under 40, or
#' with any missing required input.
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
#'   # SCORE2 is for people without diabetes; use SCORE2_Diabetes() otherwise
#'   diabetes = 0,
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
#'   Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE)
#' )
#'
#' # Call the function with the cohort_xx
#'
#'   results <- cohort_xx %>% rowwise() %>%
#'   mutate(SCORE2OP_score = SCORE2(Risk.region = "Low", Age, Gender, smoker,
#'   systolic.bp, diabetes, total.chol, total.hdl, classify = FALSE))
#'
#' @name SCORE2/OP
#'
#'
#' @export

SCORE2 <- function(Risk.region, Age = Age, Gender = Gender, smoker = smoker, systolic.bp = systolic.bp, diabetes = 0, total.chol = total.chol, total.hdl = total.hdl, classify){

  # Vector input: score each element with the one-row logic below (#18)
  args <- list(
    Risk.region = Risk.region, Age = Age, Gender = Gender, smoker = smoker,
    systolic.bp = systolic.bp, diabetes = diabetes, total.chol = total.chol,
    total.hdl = total.hdl
  )
  n <- score2_check_lengths(args, "SCORE2")

  # diabetes defaults to 0, but the assumption is announced (#15). Checked
  # after the inputs are evaluated, and only in the outer call, so vector
  # input gives a single warning.
  if (missing(diabetes)) {
    warning(
      "SCORE2(): diabetes not supplied, so it was assumed to be 0 (no ",
      "diabetes). Pass diabetes explicitly to silence this, or use ",
      "SCORE2_Diabetes() for patients with diabetes.",
      call. = FALSE
    )
  }

  if (n > 1L) {
    return(do.call(
      mapply,
      c(list(FUN = SCORE2, MoreArgs = list(classify = classify),
             SIMPLIFY = TRUE, USE.NAMES = FALSE), args)
    ))
  }

  # Missing required inputs give NA with a warning (#21)
  required <- list(
    Risk.region = Risk.region, Age = Age, Gender = Gender, smoker = smoker,
    systolic.bp = systolic.bp, diabetes = diabetes, total.chol = total.chol,
    total.hdl = total.hdl
  )
  if (score2_missing_inputs(required, "SCORE2")) {
    return(if (isTRUE(classify)) NA_character_ else NA_real_)
  }

  # SCORE2 is not validated below age 40 (#17)
  if (score2_age_out_of_scope(Age, "SCORE2")) {
    return(if (isTRUE(classify)) NA_character_ else NA_real_)
  }

  # SCORE2 (< 70 years) is not validated in people with diabetes (#15)
  if (score2_diabetes_out_of_scope(Age, diabetes, "SCORE2")) {
    return(if (isTRUE(classify)) NA_character_ else NA_real_)
  }

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

    xx_female3 <- 1-exp(-exp(scale1+scale2 * log(-log(1-xx_female2))))

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

    xx_male3_op <- 1-exp(-exp(scale1+scale2 * log(-log(1-xx_male2_op))))

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

    xx_female3_op <- 1-exp(-exp(scale1+scale2 * log(-log(1-xx_female2_op))))

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

  else if((50 <= Age & Age < 70) & x < 5){
    class <- "Low risk"
  }

  else if((50 <= Age & Age < 70) & (5 <= x & x < 10)){
    class <- "Moderate risk"
  }
  else if((50 <= Age & Age < 70) & x >= 10){
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

  else{return(round(x, 1))}

  #return(class)

}



# Internal helper: is this row outside SCORE2's validated population?
#
# SCORE2 (ages < 70) is not intended for, nor validated in, people with
# diabetes (SCORE2 working group, Eur Heart J 2021, doi:10.1093/eurheartj/ehab309;
# Hageman et al., Eur Heart J 2022;43:241-242, doi:10.1093/eurheartj/ehab761,
# Table 1 footnote). Those patients should use SCORE2-Diabetes
# (doi:10.1093/eurheartj/ehad260). SCORE2-OP (ages >= 70) includes diabetes as
# a predictor, so it is not affected. See GitHub issue #15.
#
# Returns TRUE (and warns) when Age < 70 and diabetes == 1; FALSE otherwise,
# including when either value is NA (existing NA handling then applies).
score2_diabetes_out_of_scope <- function(Age, diabetes, fun_name) {
  out_of_scope <- !is.na(Age) && !is.na(diabetes) && Age < 70 && diabetes == 1
  if (out_of_scope) {
    warning(
      fun_name, "(): SCORE2 (ages under 70) is not validated in people with ",
      "diabetes, so NA was returned. Use SCORE2_Diabetes() for these patients.",
      call. = FALSE
    )
  }
  out_of_scope
}

# Internal helper: is this row below SCORE2's validated age range?
#
# SCORE2 was developed and validated for ages 40-69 (SCORE2 working group,
# Eur Heart J 2021, doi:10.1093/eurheartj/ehab309, Aims). Ages under 40 are
# extrapolation, so NA is returned with a warning. See GitHub issue #17.
# No upper bound is applied to SCORE2-OP (ages >= 70) until one can be cited.
score2_age_out_of_scope <- function(Age, fun_name) {
  out_of_scope <- !is.na(Age) && Age < 40
  if (out_of_scope) {
    warning(
      fun_name, "(): SCORE2 is validated for ages 40 and over, so NA was ",
      "returned for Age < 40.",
      call. = FALSE
    )
  }
  out_of_scope
}

# Internal helper: check that vectorised inputs have length 1 or n, and
# return n. Used by SCORE2() and SCORE2_CKD() (GitHub issue #18).
score2_check_lengths <- function(args, fun_name) {
  lens <- lengths(args)
  n <- max(lens)
  bad <- names(lens)[lens == 0L | !lens %in% c(1L, n)]
  if (length(bad) > 0L) {
    stop(
      fun_name, "(): every input must have length 1 or the same length as ",
      "the others (", n, "). Check: ", paste(bad, collapse = ", "), ".",
      call. = FALSE
    )
  }
  n
}

# Internal helper: are any required inputs missing (NA)?
#
# SCORE2/SCORE2-OP give no rule for imputing a missing predictor, so NA is
# returned with a warning naming the missing inputs. Without this, a missing
# Age, Gender or Risk.region stopped with "missing value where TRUE/FALSE
# needed". See GitHub issue #21.
score2_missing_inputs <- function(args, fun_name) {
  missing_inputs <- names(args)[vapply(args, function(x) is.na(x), logical(1))]
  if (length(missing_inputs) > 0L) {
    warning(
      fun_name, "(): NA returned because of missing input(s): ",
      paste(missing_inputs, collapse = ", "), ".",
      call. = FALSE
    )
  }
  length(missing_inputs) > 0L
}
