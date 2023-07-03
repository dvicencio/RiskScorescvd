#' Emergency Department Assessment of Chest Pain Score (EDACS) function
#'
#' @description This function implements the EDACS score calculation as a vector
#'
#' Age -
#' 18-45 = 2\cr
#' 46-50 = 4\cr
#' 51-55 = 6\cr
#' 56-60 = 8\cr
#' 61-65 = 10\cr
#' 66-70 = 12\cr
#' 71-75 = 14\cr
#' 76-80 = 16\cr
#' 81-85 = 18\cr
#' >=86 = 20\cr
#'
#' Sex -\cr
#' Female = 0\cr
#' Male = 6\cr
#'
#' Known coronary artery disease or >=3 risk factors*\cr
#' The risk factors only apply to patients 18-50-\cr
#' no = 0\cr
#' yes = 4\cr
#'
#' Symptoms and signs\cr
#' Diaphoresis                                         no = 0   yes = 3\cr
#' Pain radiates to arm, shoulder, neck, or jaw        no = 0   yes = 5\cr
#' Pain occurred or worsened with inspiration          no = 0   yes = -4\cr
#' Pain is reproduced by palpation                     no = 0   yes = -6\cr
#'
#'
#' Two possible outcomes\cr
#'
#' Low risk cohort:\cr
#' EDACS <16 and\cr
#' EKG shows no new ischemia and\cr
#' 0-hr and 2-hr troponin both negative.\cr
#' Not low risk cohort:\cr
#' EDACS >=16 or\cr
#' EKG shows new ischemia or\cr
#' 0-hr or 2-hr troponin positive.
#'
#' @param ecg.st.depression a binary numeric vector, 1 = yes and 0 = no
#' @param Age a numeric vector of age values, in years
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no
#' @param smoker a binary numeric vector, 1 = yes and 0 = no
#' @param hypertension a binary numeric vector, 1 = yes and 0 = no
#' @param hyperlipidaemia a binary numeric vector, 1 = yes and 0 = no
#' @param family.history a binary numeric vector, 1 = yes and 0 = no
#' @param presentation_hstni a continuous numeric vector of the troponin levels
#' @param Gender a binary character vector of sex values. Categories should include only 'male' or 'female'.
#' @param sweating a binary numeric vector, 1 = yes and 0 = no
#' @param pain.radiation a binary numeric vector, 1 = yes and 0 = no
#' @param pleuritic a binary numeric vector, 1 = yes and 0 = no
#' @param palpation a binary numeric vector, 1 = yes and 0 = no
#' @param ecg.twi a binary numeric vector, 1 = yes and 0 = no
#' @param second_hstni a binary numeric vector, 1 = yes and 0 = no
#' @param classify a logical parameter to indicate classification of scores "TRUE" or none "FALSE"
#'
#' @keywords
#' EDACS Age Gender diabetes smoker hypertension hyperlipidaemia
#' family.history sweating pain.radiation pleuritic palpation
#' ecg.st.depression ecg.twi presentation_hstni second_hstni classify
#'
#' @return
#' A vector with EDACS score calculations
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
#'   second_hstni = as.numeric(sample(1:200, num_rows, replace = TRUE))
#' )
#'
#' # Call the function with the cohort_xx
#'
#' results <- cohort_xx %>% rowwise() %>% mutate(EDACS_score = EDACS(Age,
#' Gender, diabetes, smoker, hypertension, hyperlipidaemia, family.history,
#' sweating, pain.radiation, pleuritic, palpation, ecg.st.depression, ecg.twi,
#' presentation_hstni, second_hstni, classify = FALSE))
#'
#'
#' @importFrom dplyr case_when
#'
#' @name EDACS
#' @export
EDACS <-
  function(Age = Age,
           Gender = Gender,
           diabetes = diabetes,
           smoker = smoker,
           hypertension = hypertension,
           hyperlipidaemia = hyperlipidaemia,
           family.history = family.history,
           sweating = sweating,
           pain.radiation = pain.radiation,
           pleuritic = pleuritic,
           palpation = palpation,
           ecg.st.depression = ecg.st.depression,
           ecg.twi = ecg.twi,
           presentation_hstni = presentation_hstni,
           second_hstni = second_hstni,
           classify = FALSE) {

    if (missing(sweating) ||
        missing(pain.radiation) ||
        missing(pleuritic) ||
        missing(ecg.st.depression) ||
        missing(palpation) ||
        missing(ecg.twi) ||
        missing(Age) ||
        missing(diabetes) ||
        missing(smoker) ||
        missing(hypertension) ||
        missing(second_hstni) ||
        missing(hyperlipidaemia) ||
        missing(family.history) ||
        missing(presentation_hstni) ||
        missing(Gender)) {
      warning("One or more required variables are missing.")
    }

    if (!is.numeric(sweating) ||
        !is.numeric(pain.radiation) || !is.numeric(pleuritic) ||
        !is.numeric(ecg.st.depression) || !is.numeric(ecg.twi) ||
        !is.numeric(Age) ||
        !is.numeric(diabetes) || !is.numeric(smoker) ||
        !is.numeric(hypertension) || !is.numeric(second_hstni) ||
        !is.numeric(hyperlipidaemia) || !is.numeric(family.history) ||
        !is.numeric(palpation) ||
        !is.numeric(presentation_hstni) || !is.character(Gender) ||
        !is.logical(classify)) {
      warning("Invalid variable type detected.")
    }

    # 1. Age in years;
    Age2 <- case_when(
      is.na(Age) ~ NA_real_,
      0 <= Age & Age < 18 ~ 0,
      18 <= Age & Age < 46 ~ 2,
      46 <= Age & Age < 51 ~ 4,
      51 <= Age & Age < 56 ~ 6,
      56 <= Age & Age < 61 ~ 8,
      61 <= Age & Age < 66 ~ 10,
      66 <= Age & Age < 71 ~ 12,
      71 <= Age & Age < 76 ~ 14,
      76 <= Age & Age < 81 ~ 16,
      81 <= Age & Age < 86 ~ 18,
      Age >= 86 ~ 20,
      TRUE ~ NA_real_
    )

    # 2. Sex;
    sex <- case_when(is.na(Gender) ~ NA_real_,
                     Gender == "male" ~ 6,
                     Gender == "female" ~ 0,
                     TRUE ~ NA_real_)

    # 3. Known coronary artery disease or >=3 risk factors;
    Risk <- case_when(
      is.na(Age) ~ NA_real_,
      (18 <= Age &
         Age <= 50) &
        sum(
          diabetes,
          smoker,
          hypertension,
          hyperlipidaemia,
          family.history,
          na.rm = TRUE
        ) >= 3 ~ 4,
      (18 <= Age &
         Age <= 50) &
        sum(
          diabetes,
          smoker,
          hypertension,
          hyperlipidaemia,
          family.history,
          na.rm = TRUE
        ) < 3 ~ 0,
      Age < 18 | (50 < Age & Age < 200) ~ 0,
      TRUE ~ NA_real_
    )

    # 4. Symptoms and signs;
    # 4.1 Sweating
    sw <- case_when(is.na(sweating) ~ NA_real_,
                    sweating == 1 ~ 3,
                    sweating == 0 ~ 0,
                    TRUE ~ NA_real_)

    # 4.2 Pain radiates to arm, shoulder, neck, or jaw;
    pain <- case_when(
      is.na(pain.radiation) ~ NA_real_,
      pain.radiation == 1 ~ 5,
      pain.radiation == 0 ~ 0,
      TRUE ~ NA_real_
    )

    # 4.3 Pain occurred or worsened with inspiration;
    pleu <- case_when(is.na(pleuritic) ~ NA_real_,
                      pleuritic == 1 ~ -4,
                      pleuritic == 0 ~ 0,
                      TRUE ~ NA_real_)

    # 4.4 Pain is reproduced by palpation;
    palp <- case_when(is.na(palpation) ~ NA_real_,
                      palpation == 1 ~ -6,
                      palpation == 0 ~ 0,
                      TRUE ~ NA_real_)

    score <-  Age2 + sex + Risk + sw + pain + pleu + palp

    #return(round(score, 0))
    # 5. Make a decision based on score, ECG and Troponin levels

    if ((!is.na(Gender) &
         Gender == "male") &
        ((!is.na(score) &
          score >= 16) |
         ((
           !is.na(ecg.st.depression) &
           ecg.st.depression == 1
         ) | (!is.na(ecg.twi) & ecg.twi == 1)) |
         ((!is.na(presentation_hstni) &
           presentation_hstni >= 34) |
          (!is.na(second_hstni) & second_hstni >= 34)
         ))) {
      fact <- "Not low risk"
    }

    else if ((!is.na(Gender) &
              Gender == "male") &
             ((!is.na(score) &
               score < 16) &
              ((
                !is.na(ecg.st.depression) &
                ecg.st.depression == 0
              ) & (ecg.twi == 0 | is.na(ecg.twi))) &
              ((
                !is.na(presentation_hstni) &
                presentation_hstni < 34
              ) & (is.na(second_hstni) | second_hstni < 34)))) {
      fact <- "Low risk"
    }

    else if ((!is.na(Gender) &
              Gender == "female") &
             ((!is.na(score) &
               score >= 16) |
              ((
                !is.na(ecg.st.depression) &
                ecg.st.depression == 1
              ) | (!is.na(ecg.twi) & ecg.twi == 1)) |
              ((!is.na(presentation_hstni) &
                presentation_hstni >= 16) |
               (!is.na(second_hstni) & second_hstni >= 16)
              ))) {
      fact <- "Not low risk"
    }

    else if ((!is.na(Gender) &
              Gender == "female") &
             ((!is.na(score) &
               score < 16) &
              ((
                !is.na(ecg.st.depression) &
                ecg.st.depression == 0
              ) & (ecg.twi == 0 | is.na(ecg.twi))) &
              ((
                !is.na(presentation_hstni) &
                presentation_hstni < 16
              ) & (is.na(second_hstni) | second_hstni < 16)))) {
      fact <- "Low risk"
    }

    else{
      fact <- NA
    }

    if (classify == TRUE) {
      return(fact)
    }

    else{
      return(round(score, 0))
    }


    # return both score and actual risk
    # return(paste(round(score, 0), fact, sep = " "))

    # return(fact)

  }
