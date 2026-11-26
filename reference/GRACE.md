# GRACE Global Registry of Acute Coronary Events version 2.0 (6 months outcome) function;

This function implements the GRACE 2.0 for 6 months outcome score
calculation as a vector

Needed variables ——————————————————– Age = A Heart Rate = H Systolic BP
= S Creatinine = C

killip.class class (signs/symptoms) = K No CHF = 1 Rales and/or JVD = 2
Pulmonary edema = 3 Cardiogenic shock = 4

Cardiac Arrest = X no = 0 yes = 1

ST segment deviation on EKG? = E no = 0 yes = 1

Abnormal cardiac enzymes = T no = 0 yes = 1

Add variables to equation and solve for p xb= -7.7035 + (0.0531\*A) +
(0.0087\*H) - (0.0168\*S) + (0.1823\*C) + (0.6931\* K) + (1.4586\*Xt) +
(0.4700\*E) + (0.8755\*T); p=(exp(xb))/(1 + exp(xb));

Possible outcomes

A percentage for Probability of death from admission to 6 months is
given

footnote: \* A = Available, NA = notavailable.

Another formula found in
https://www.outcomes-umassmed.org/grace/files/GRACE_RiskModel_Coefficients.pdf
https://www.outcomes-umassmed.org/grace/grace_risk_table.aspx
https://www.outcomes-umassmed.org/grace/acs_risk2/index.html • Low 1-88
• Intermediate 89-118 • High 119-263

## Usage

``` r
GRACE(
  killip.class = killip.class,
  systolic.bp = systolic.bp,
  heart.rate = heart.rate,
  Age = Age,
  creat = creat,
  ecg.st.depression = ecg.st.depression,
  presentation_hstni = presentation_hstni,
  cardiac.arrest = cardiac.arrest,
  Gender = Gender,
  classify = FALSE
)
```

## Arguments

- killip.class:

  a numeric vector of killip class values, 1 to 4

- systolic.bp:

  a numeric vector of systolic blood pressure continuous values

- heart.rate:

  a numeric vector of heart rate continuous values

- Age:

  a numeric vector of age values, in years

- creat:

  a continuous numeric vector of the creatinine levels

- ecg.st.depression:

  a binary numeric vector, 1 = yes and 0 = no

- presentation_hstni:

  a continuous numeric vector of the troponin levels

- cardiac.arrest:

  a binary numeric vector, 1 = yes and 0 = no

- Gender:

  a binary character vector of sex values. Categories should include
  only 'male' or 'female'

- classify:

  a logical parameter to indicate classification of Scores "TRUE" or
  none "FALSE"

## Value

A vector with GRACE score calculations and/or a vector of their
classifications if indicated

## Examples

``` r

# Create a data frame or list with the necessary variables
# Set the number of rows
num_rows <- 100

# Create a larger dataset with 100 rows
cohort_xx <- data.frame(
  typical_symptoms.num = as.numeric(sample(0:6, num_rows, replace = TRUE)),
  ecg.normal = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  abn.repolarisation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  ecg.st.depression = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  Age = as.numeric(sample(30:80, num_rows, replace = TRUE)),
  diabetes = sample(c(1, 0), num_rows, replace = TRUE),
  smoker = sample(c(1, 0), num_rows, replace = TRUE),
  hypertension = sample(c(1, 0), num_rows, replace = TRUE),
  hyperlipidaemia = sample(c(1, 0), num_rows, replace = TRUE),
  family.history = sample(c(1, 0), num_rows, replace = TRUE),
  atherosclerotic.disease = sample(c(1, 0), num_rows, replace = TRUE),
  presentation_hstni = as.numeric(sample(10:100, num_rows, replace = TRUE)),
  Gender = sample(c("male", "female"), num_rows, replace = TRUE),
  sweating = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  pain.radiation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  pleuritic = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  palpation = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  ecg.twi = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  second_hstni = as.numeric(sample(1:200, num_rows, replace = TRUE)),
  killip.class = as.numeric(sample(1:4, num_rows, replace = TRUE)),
  systolic.bp = as.numeric(sample(0:300, num_rows, replace = TRUE)),
  heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
  creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
  cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE))
)
# Call the function with the cohort_xx

  results <- cohort_xx %>% rowwise() %>%
  mutate(GRACE_score = GRACE(killip.class, systolic.bp, heart.rate,
  Age, creat, ecg.st.depression, presentation_hstni, cardiac.arrest, Gender, classify = FALSE))
```
