#' Six commonly used cardiovascular risk scores for the prediction of major cardiac events (MACE)
#'
#'
#' @description This function implements seven cardiovascular risk scores row wise
#' in a data frame with the required variables. It would then retrieve a data
#' frame with two extra columns for each risk score including their calculations and classifications
#'
#' @param data
#' A data frame with all the variables needed for calculation:
#' @param typical_symptoms.num a numeric vector of the number of typical symptoms; renames alternative column name
#' @param ecg.normal a binary numeric vector,  1 = yes and 0 = no; renames alternative column name
#' @param abn.repolarisation a binary numeric vector,  1 = yes and 0 = no; renames alternative column name
#' @param ecg.st.depression a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param Age a numeric vector of age values, in years; renames alternative column name
#' @param diabetes a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param smoker a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param hypertension a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param hyperlipidaemia a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param family.history a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param atherosclerotic.disease a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param presentation_hstni a continuous numeric vector of the troponin levels; renames alternative column name
#' @param Gender a binary character vector of sex values. Categories should include only 'male' or 'female'; renames alternative column name
#' @param sweating a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param pain.radiation a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param pleuritic a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param palpation a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param ecg.twi a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param second_hstni a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param killip.class a numeric vector of killip class values, 1 to 4; renames alternative column name
#' @param heart.rate a numeric vector of heart rate continuous values; renames alternative column name
#' @param systolic.bp a numeric vector of systolic blood pressure continuous values; renames alternative column name
#' @param aspirin a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param number.of.episodes.24h a numeric vector of number of angina episodes in 24 hours; renames alternative column name
#' @param previous.pci a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param previous.cabg a binary numeric vector, 1 = yes and 0 = no; renames alternative column name
#' @param total.chol a numeric vector of total cholesterol values, in mmol/L; renames alternative column name
#' @param total.hdl a numeric vector of total high density lipoprotein HDL values, in mmol/L; renames alternative column name
#' @param creat a continuous numeric vector of the creatine levels
#' @param Ethnicity a character vector, 'white', 'black', 'asian', or other
#' @param eGFR a numeric vector of total estimated glomerular rate (eGFR) values, in mL/min/1.73m2
#' @param ACR a numeric vector of total urine albumin to creatine ratio (ACR) values, in mg/g. Default set to NA
#' @param trace a character vector of urine protein dipstick categories. Categories should include 'negative', 'trace', '1+', '2+', '3+', '4+. Default set to NA
#'
#'
#' @keywords
#' Cardiovascular risk scores typical_symptoms.num ecg.normal abn.repolarisation ecg.st.depression
#' Age diabetes smoker hypertension hyperlipidaemia family.history
#' atherosclerotic.disease presentation_hstni Gender sweating pain.radiation pleuritic palpation ecg.twi
#' second_hstni killip.class heart.rate systolic.bp aspirin number.of.episodes.24h previous.pci
#' previous.cabg total.chol total.hdl
#'
#' @return
#' a data frame with two extra columns including all the cardiovascular risk score calculations
#' and their classifications
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
#'   second_hstni = as.numeric(sample(1:200, num_rows, replace = TRUE)),
#'   killip.class = as.numeric(sample(1:4, num_rows, replace = TRUE)),
#'   systolic.bp = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'   heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
#'   creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
#'   cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   previous.pci = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   previous.cabg = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   aspirin = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
#'   number.of.episodes.24h = as.numeric(sample(0:20, num_rows, replace = TRUE)),
#'   total.chol = as.numeric(sample(2:6, num_rows, replace = TRUE)),
#'   total.hdl = as.numeric(sample(2:5, num_rows, replace = TRUE)),
#'   Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE),
#'   eGFR = as.numeric(sample(15:120, num_rows, replace = TRUE)),
#'   ACR = as.numeric(sample(5:1500, num_rows, replace = TRUE)),
#'   trace = sample(c("trace", "1+", "2+", "3+", "4+"), num_rows, replace = TRUE)
#' )
#'
#'
#'
#' # Call the function with the cohort_xx
#'
#' new_data_frame <- calc_scores(data = cohort_xx)
#'
#' @name RiskScoresCalc
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr rename
#' @importFrom dplyr %>%
#' @importFrom dplyr rowwise
#'
#' @export

calc_scores <- function(data, typical_symptoms.num = typical_symptoms.num, ecg.normal = ecg.normal,
                        abn.repolarisation = abn.repolarisation, ecg.st.depression = ecg.st.depression,
                       Age= Age, diabetes = diabetes, smoker = smoker, hypertension = hypertension,
                       hyperlipidaemia = hyperlipidaemia, family.history = family.history,
                       atherosclerotic.disease = atherosclerotic.disease, presentation_hstni = presentation_hstni,
                       Gender = Gender, sweating = sweating, pain.radiation = pain.radiation,
                       pleuritic = pleuritic, palpation = palpation, ecg.twi = ecg.twi,
                       second_hstni = second_hstni, killip.class = killip.class, heart.rate = heart.rate,
                       systolic.bp = systolic.bp, aspirin = aspirin, number.of.episodes.24h = number.of.episodes.24h,
                       previous.pci = previous.pci, creat = creat, previous.cabg = previous.cabg, total.chol = total.chol,
                       total.hdl = total.hdl, Ethnicity = Ethnicity,eGFR = eGFR, ACR = NA, trace = NA
                       ) {

data <- data %>% rename(typical_symptoms.num = typical_symptoms.num, ecg.normal = ecg.normal,
                        abn.repolarisation = abn.repolarisation, ecg.st.depression = ecg.st.depression,
                        Age= Age, diabetes = diabetes, smoker = smoker, hypertension = hypertension,
                        hyperlipidaemia = hyperlipidaemia, family.history = family.history,
                        atherosclerotic.disease = atherosclerotic.disease, presentation_hstni = presentation_hstni,
                        Gender = Gender, sweating = sweating, pain.radiation = pain.radiation,
                        pleuritic = pleuritic, palpation = palpation, ecg.twi = ecg.twi,
                        second_hstni = second_hstni, killip.class = killip.class, heart.rate = heart.rate,
                        systolic.bp = systolic.bp, aspirin = aspirin, number.of.episodes.24h = number.of.episodes.24h,
                        previous.pci = previous.pci, creat = creat, previous.cabg = previous.cabg, total.chol = total.chol,
                        total.hdl = total.hdl, Ethnicity = Ethnicity, eGFR = eGFR, ACR = ACR, trace = trace)

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
                                                        SCORE2(Risk.region = "Low", Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl, classify = FALSE),

                                              SCORE2OP_CKD_score = SCORE2_CKD(Risk.region = "Low", Age, Gender,
                                                            smoker, systolic.bp, diabetes, total.chol, total.hdl, eGFR, ACR, trace,
                                                            classify = FALSE)


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
                                                                  SCORE2(Risk.region = "Low", Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl, classify = TRUE) %>%
                                                      as.factor() %>% ordered(
                                                                    levels = c("Very low risk", "Low risk", "Moderate risk", "High risk")),

                                                    SCORE2OP_CKD_strat = SCORE2_CKD(Risk.region = "Low", Age, Gender,
                                                               smoker, systolic.bp, diabetes, total.chol, total.hdl, eGFR, ACR, trace,
                                                               classify = TRUE)




  )

  return(all_scores)
}




