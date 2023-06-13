#' Commonly used cardiovascular risk scores for the prediction of major cardiac events (MACE)
#'
#'
#' @description This function implements seven cardiovascular risk scores row wise
#' in a data frame with the required variables. It would then retrieve a data
#' frame with two extra columns for each risk score including their calculations and classifications
#'
#'
#' @param  typical_symptoms.num_df a numeric vector of the number of typical symptoms; renames alternative column name
#' @param ecg.normal_df a binary numeric vector,  1 = yes and 0 = no; renames alternative column name
#' @param abn.repolarisation_df a binary numeric vector,  1 = yes and 0 = no; renames alternative column name
#' @param ecg.st.depression_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param Age_df a numeric vector of age values, in years; renames alternative column name
#' @param diabetes_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param smoker_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param hypertension_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param hyperlipidaemia_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param family.history_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param atherosclerotic.disease_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param presentation_hstni_df a continuous numeric vector of the troponin levels; renames alternative column name
#' @param Gender_df a binary character vector of sex values. Categories should include
#' only 'male' or 'female'; renames alternative column name
#' @param sweating_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param pain.radiation_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param pleuritic_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param palpation_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param ecg.twi_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param second_hstni_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param killip.class_df a numeric vector of killip class values, 1 to 4; renames alternative column name
#' @param heart.rate_df a numeric vector of heart rate continuous values; renames alternative column name
#' @param systolic.bp_df a numeric vector of systolic blood pressure continuous values; renames alternative column name
#' @param aspirin_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param number.of.episodes.24h_df a numeric vector of number of angina episodes in 24 hours; renames alternative column name
#' @param previous.pci_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param previous.cabg_df a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param total.chol_df a numeric vector of total cholesterol values, in mmol/L; renames alternative column name
#' @param total.hdl_df a numeric vector of total high density lipoprotein HDL values, in mmol/L; renames alternative column name
#'
#' @keywords
#' Cardiovascular risk scores, typical_symptoms.num, ecg.normal, abn.repolarisation, ecg.st.depression,
#' Age, diabetes, smoker, hypertension, hyperlipidaemia, family.history,
#' atherosclerotic.disease, presentation_hstni, Gender, sweating, pain.radiation, pleuritic, palpation, ecg.twi,
#' 2nd_hstni, killip.class, heart.rate, systolic.bp, aspirin, number.of.episodes.24h, previous.pci,
#' previous.cabg, total.chol, total.hdl
#'
#' @return
#' a data frame with two extra columns including all the cardiovascular risk score calculations
#' and their classifications
#'
#' @examples
#' new_data_frame <- calc_scores(data = cohort_xx)
#'
#' @name RiskScoresCalc
#'
#' @import tidyverse
#' @import PooledCohort
#' @export

calc_scores <- function(data, typical_symptoms.num_df = "typical_symptoms.num", ecg.normal_df = "ecg.normal",
                        abn.repolarisation_df = "abn.repolarisation", ecg.st.depression_df = "ecg.st.depression",
                       Age_df= "Age", diabetes_df = "diabetes", smoker_df = "smoker", hypertension_df = "hypertension",
                       hyperlipidaemia_df = "hyperlipidaemia", family.history_df = "family.history",
                       atherosclerotic.disease_df = "atherosclerotic.disease", presentation_hstni_df = "presentation_hstni",
                       Gender_df = "Gender", sweating_df = "sweating", pain.radiation_df = "pain.radiation",
                       pleuritic_df = "pleuritic", palpation_df = "palpation", ecg.twi_df = "ecg.twi",
                       second_hstni_df = "second_hstni", killip.class_df = "killip.class", heart.rate_df = "heart.rate",
                       systolic.bp_df = "systolic.bp", aspirin_df = "aspirin", number.of.episodes.24h_df = "number.of.episodes.24h",
                       previous.pci_df = "previous.pci", previous.cabg_df = "previous.cabg", total.chol_df = "total.chol", total.hdl_df = "total.hdl", Ethnicity_df = "Ethnicity"
                       ) {

data <- data %>% rename(typical_symptoms.num = typical_symptoms.num_df, ecg.normal = ecg.normal_df,
                        abn.repolarisation = abn.repolarisation_df, ecg.st.depression = ecg.st.depression_df,
                        Age= Age_df, diabetes = diabetes_df, smoker = smoker_df, hypertension = hypertension_df,
                        hyperlipidaemia = hyperlipidaemia_df, family.history = family.history_df,
                        atherosclerotic.disease = atherosclerotic.disease_df, presentation_hstni = presentation_hstni_df,
                        Gender = Gender_df, sweating = sweating_df, pain.radiation = pain.radiation_df,
                        pleuritic = pleuritic_df, palpation = palpation_df, ecg.twi = ecg.twi_df,
                        second_hstni = second_hstni_df, killip.class = killip.class_df, heart.rate = heart.rate_df,
                        systolic.bp = systolic.bp_df, aspirin = aspirin_df, number.of.episodes.24h = number.of.episodes.24h_df,
                        previous.pci = previous.pci_df, previous.cabg = previous.cabg_df, total.chol = total.chol_df, total.hdl = total.hdl_df, Ethnicity = Ethnicity_df)

  all_scores <- data %>% rowwise() %>% mutate(HEART_score =
                                                        HEART(typical_symptoms.num = typical_symptoms.num,
                                                              ecg.normal = ecg.normal,
                                                              abn.repolarisation = abn.repolarisation,
                                                              ecg.st.depression = ecg.st.depression,
                                                              Age = Age, diabetes = diabetes,
                                                              smoker = smoker, hypertension = hypertension,
                                                              hyperlipidaemia = hyperlipidaemia,
                                                              family.history = family.history,
                                                              atherosclerotic.disease = atherosclerotic.disease,
                                                              presentation_hstni = presentation_hstni,
                                                              Gender = Gender, classify = FALSE),

                                                      EDACS_score =
                                                        EDACS(Age = Age , Gender = Gender,
                                                              diabetes = diabetes, smoker = smoker,
                                                              hypertension = hypertension, hyperlipidaemia = hyperlipidaemia,
                                                              family.history = family.history,
                                                              sweating = sweating, pain.radiation = pain.radiation,
                                                              pleuritic = pleuritic, palpation = palpation,
                                                              ecg.st.depression = ecg.st.depression, ecg.twi = ecg.twi,
                                                              presentation_hstni = presentation_hstni,
                                                              second_hstni = second_hstni, classify = FALSE),

                                                      # TMACS_score =
                                                      #   TMACSprec(ecg.ischaemia = ecg.ischaemia,
                                                      #         ecg.st.depression = ecg.st.depression,
                                                      #         ecg.twi = ecg.twi,
                                                      #         angina = angina, radiation.right.arm = radiation.right.arm,
                                                      #         vomiting = vomiting, sweating = sweating,
                                                      #         systolic.bp = systolic.bp,
                                                      #         presentation_hstni = presentation_hstni),

                                                      GRACE_score =
                                                        GRACE(killip.class = killip.class, systolic.bp = systolic.bp,
                                                              heart.rate = heart.rate, Age = Age, creat = creat,
                                                              ecg.st.depression = ecg.st.depression,
                                                              presentation_hstni = presentation_hstni,
                                                              cardiac.arrest = NA, Gender = Gender, classify = FALSE),

                                                      TIMI_score =
                                                        TIMI(Age = Age, hypertension = hypertension,
                                                                hyperlipidaemia = hyperlipidaemia,
                                                                family.history = family.history, diabetes = diabetes,
                                                                smoker = smoker, previous.pci = previous.pci,
                                                                previous.cabg = previous.cabg, aspirin = aspirin,
                                                                number.of.episodes.24h = number.of.episodes.24h,
                                                                ecg.st.depression = ecg.st.depression,
                                                                presentation_hstni = presentation_hstni, Gender = Gender, classify = FALSE),

                                                      ASCVD_score =
                                                ASCVD(Gender, Ethnicity, Age, total.chol, total.hdl,
                                                      systolic.bp,hypertension, smoker, diabetes, classify = FALSE),

                                                      SCORE2_score =
                                                        SCORE2(Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl, classify = FALSE)


  )


  all_scores <- all_scores %>% rowwise() %>% mutate(HEART_strat =
                                                                    HEART(typical_symptoms.num = typical_symptoms.num,
                                                                          ecg.normal = ecg.normal,
                                                                          abn.repolarisation = abn.repolarisation,
                                                                          ecg.st.depression = ecg.st.depression,
                                                                          Age = Age, diabetes = diabetes,
                                                                          smoker = smoker, hypertension = hypertension,
                                                                          hyperlipidaemia = hyperlipidaemia,
                                                                          family.history = family.history,
                                                                          atherosclerotic.disease = atherosclerotic.disease,
                                                                          presentation_hstni = presentation_hstni,
                                                                          Gender = Gender, classify = TRUE)%>% as.factor() %>% ordered(levels = c(
                                                                            "Low risk", "Moderate risk", "High risk"
                                                                          )),

                                                                  EDACS_strat =
                                                                  EDACS(Age = Age , Gender = Gender,
                                                                          diabetes = diabetes, smoker = smoker,
                                                                          hypertension = hypertension, hyperlipidaemia = hyperlipidaemia,
                                                                          family.history = family.history,
                                                                          sweating = sweating, pain.radiation = pain.radiation,
                                                                          pleuritic = pleuritic, palpation = palpation,
                                                                          ecg.st.depression = ecg.st.depression, ecg.twi = ecg.twi,
                                                                          presentation_hstni = presentation_hstni,
                                                                          second_hstni = second_hstni, classify = TRUE)%>% as.factor() %>% ordered(levels = c(
                                                                            "Low risk", "Not low risk"
                                                                          )
                                                                          ),

                                                                  # TMACS_strat =
                                                                  #   TMACSprec(ecg.ischaemia = ecg.ischaemia,
                                                                  #         ecg.st.depression = ecg.st.depression,
                                                                  #         ecg.twi = ecg.twi,
                                                                  #         angina = angina, radiation.right.arm = radiation.right.arm,
                                                                  #         vomiting = vomiting, sweating = sweating,
                                                                  #         systolic.bp = systolic.bp,
                                                                  #         presentation_hstni = presentation_hstni),

                                                                  GRACE_strat =
                                                                    GRACE(killip.class = killip.class, systolic.bp = systolic.bp,
                                                                          heart.rate = heart.rate, Age = Age, creat = creat,
                                                                          ecg.st.depression = ecg.st.depression,
                                                                          presentation_hstni = presentation_hstni,
                                                                          cardiac.arrest = NA, Gender = Gender, classify = TRUE) %>% as.factor() %>% ordered(levels =
                                                                                                                                                              c( "Low risk", "Moderate risk", "High risk")),

                                                                  TIMI_strat =
                                                                    TIMI(Age = Age, hypertension = hypertension,
                                                                            hyperlipidaemia = hyperlipidaemia,
                                                                            family.history = family.history, diabetes = diabetes,
                                                                            smoker = smoker, previous.pci = previous.pci,
                                                                            previous.cabg = previous.cabg, aspirin = aspirin,
                                                                            number.of.episodes.24h = number.of.episodes.24h,
                                                                            ecg.st.depression = ecg.st.depression,
                                                                            presentation_hstni = presentation_hstni, Gender = Gender, classify = TRUE)%>% as.factor() %>% ordered(
                                                                              levels = c("Very low risk", "Low risk", "Moderate risk", "High risk")
                                                                            ),

                                                                ASCVD_strat =
                                                              ASCVD(Gender, Ethnicity, Age, total.chol, total.hdl,
                                                            systolic.bp,hypertension, smoker, diabetes, classify = TRUE) %>%
                                                      as.factor() %>% ordered(levels = c("Very low risk", "Low risk", "Moderate risk", "High risk")),

                                                                SCORE2_strat =
                                                                  SCORE2(Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl, classify = TRUE) %>%
                                                      as.factor() %>% ordered(
                                                                    levels = c("Very low risk", "Low risk", "Moderate risk", "High risk"))


  )

  return(all_scores)
}




