# Systematic COronary Risk Evaluation (SCORE) model function

This function implements the SCORE2 and SCORE2 older population (OP)
score calculation as a vector

\*Diabetes mellitus was included in the modelling since this was
necessary for the recalibration approach, which relies data from the
whole population, including those with diabetes. However, SCORE2 is not
intended for use in individuals with diabetes and has not been validated
in this population. For risk prediction in the target population of
individuals without diabetes this risk factor will always be 0, meaning
the coefficient can effectively be ignored.

\*\*Diabetes handling (since 0.4.0):\*\* for patients aged under 70
(SCORE2) with \`diabetes = 1\`, the function returns \`NA\` with a
warning, because SCORE2 is not validated in people with diabetes
(Hageman et al. 2022,
[doi:10.1093/eurheartj/ehab761](https://doi.org/10.1093/eurheartj/ehab761)
, Table 1 footnote; SCORE2 working group 2021,
[doi:10.1093/eurheartj/ehab309](https://doi.org/10.1093/eurheartj/ehab309)
). Use \[SCORE2_Diabetes()\] for these patients. For patients aged 70
and over (SCORE2-OP), diabetes is a predictor in the published model and
is used as before.

\*\*Missing inputs (since 0.4.0):\*\* if any required input is \`NA\`,
the result is \`NA\` with a warning naming the missing input(s). SCORE2
gives no rule for imputing a missing predictor.

\*\*Vector input (since 0.4.0):\*\* every input except \`classify\` can
be a vector of length 1 or n; the result is a vector of length n,
identical to scoring each row separately.

formula in SCORE2 Updated Supplementary Material page 9. paper: "SCORE2
risk prediction algorithms: new models to estimate 10-year risk of
cardiovascular disease in Europe"

Age 10-year risk of fatal and non-fatal cardiovascular disease

\| Low risk \| Moderate risk \| High risk \|  
\| :———— \| ————- \| ————— \| ———-: \|  
\| \< 50 years \| \<2.5 \| 50 - 69 years \| \<5 \| =\> 70 years \| \<7.5

above classifications referred from
https://www.inanutshell.ch/en/digital-doctors-bag/score2-and-score2-op/#:~:text=SCORE2

## Usage

``` r
SCORE2(
  Risk.region,
  Age = Age,
  Gender = Gender,
  smoker = smoker,
  systolic.bp = systolic.bp,
  diabetes = diabetes,
  total.chol = total.chol,
  total.hdl = total.hdl,
  classify
)
```

## Arguments

- Risk.region:

  a character value to set the desired risk region calculations.
  Categories should include "Low", "Moderate", "High", or "Very high"

- Age:

  a numeric vector of age values, in years. SCORE2 applies to ages 40-69
  and SCORE2-OP to ages 70 and over; \`Age \< 40\` gives \`NA\` with a
  warning
  ([doi:10.1093/eurheartj/ehab309](https://doi.org/10.1093/eurheartj/ehab309)
  ).

- Gender:

  a binary character vector of Gender values. Categories should include
  only 'male' or 'female'

- smoker:

  a binary numeric vector, 1 = yes and 0 = no

- systolic.bp:

  a numeric vector of systolic blood pressure continuous values

- diabetes:

  a binary numeric vector, 1 = yes and 0 = no. For ages under 70,
  \`diabetes = 1\` gives \`NA\` with a warning (see Description).

- total.chol:

  a numeric vector of total cholesterol values, in mmol/L

- total.hdl:

  a numeric vector of total high density lipoprotein total.hdl values,
  in mmol/L

- classify:

  set TRUE if wish to add a column with the scores' categories

## Value

A vector with SCORE2/OP score calculations and/or a vector of their
classifications if indicated. \`NA\` (with a warning) for patients aged
under 70 with \`diabetes = 1\`, under 40, or with any missing required
input.

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
  Age = as.numeric(sample(40:85, num_rows, replace = TRUE)),
  # SCORE2 is for people without diabetes; use SCORE2_Diabetes() otherwise
  diabetes = 0,
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
  systolic.bp = as.numeric(sample(90:180, num_rows, replace = TRUE)),
  heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
  creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
  cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  previous.pci = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  previous.cabg = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  aspirin = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  number.of.episodes.24h = as.numeric(sample(0:20, num_rows, replace = TRUE)),
  total.chol = as.numeric(round(runif(num_rows, 3.9, 7.2), 1)),
  total.hdl = as.numeric(round(runif(num_rows, .8, 2.1), 1)),
  Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE)
)

# Call the function with the cohort_xx

  results <- cohort_xx %>% rowwise() %>%
  mutate(SCORE2OP_score = SCORE2(Risk.region = "Low", Age, Gender, smoker,
  systolic.bp, diabetes, total.chol, total.hdl, classify = FALSE))
```
