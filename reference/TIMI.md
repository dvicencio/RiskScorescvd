# Thrombolysis In Myocardial Infarction (TIMI) Risk Score for UA/NSTEMI function

This function implements the TIMI score calculation as a vector

Age \<65 = 0 65 - 74 = 2 \>= 75 = 3

Risk factors \>3\* yes = 1, no = 0

Known CAD (stenosis \>= 50 yes = 1, no = 0

Aspirin Use yes = 1, no = 0

Severe angina yes = 1, no = 0

ECG ST Elevation or LBBB yes = 1, no = 0

Positive cardiac marker yes = 1, no = 0

Four possible outcomes

0 = Very low risk 1-2 = Low risk 3-4 = Moderate risk =\>5 = High risk

## Usage

``` r
TIMI(
  Age = Age,
  hypertension = hypertension,
  hyperlipidaemia = hyperlipidaemia,
  family.history = family.history,
  diabetes = diabetes,
  smoker = smoker,
  previous.pci = previous.pci,
  previous.cabg = previous.cabg,
  aspirin = aspirin,
  number.of.episodes.24h = number.of.episodes.24h,
  ecg.st.depression = ecg.st.depression,
  presentation_hstni = presentation_hstni,
  Gender = Gender,
  classify
)
```

## Arguments

- Age:

  a numeric vector of age values, in years

- hypertension:

  a binary numeric vector, 1 = yes and 0 = no

- hyperlipidaemia:

  a binary numeric vector, 1 = yes and 0 = no

- family.history:

  a binary numeric vector, 1 = yes and 0 = no

- diabetes:

  a binary numeric vector, 1 = yes and 0 = no

- smoker:

  a binary numeric vector, 1 = yes and 0 = no

- previous.pci:

  a binary numeric vector, 1 = yes and 0 = no

- previous.cabg:

  a binary numeric vector, 1 = yes and 0 = no

- aspirin:

  a binary numeric vector, 1 = yes and 0 = no

- number.of.episodes.24h:

  a numeric vector of number of angina episodes in 24 hours

- ecg.st.depression:

  a binary numeric vector, 1 = yes and 0 = no

- presentation_hstni:

  a continuous numeric vector of the troponin levels

- Gender:

  a binary character vector of sex values. Categories should include
  only 'male' or 'female'

- classify:

  set TRUE if wish to add a column with the scores' categories

## Value

A vector with TIMI score calculations and/or a vector of their
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
  cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  previous.pci = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  previous.cabg = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  aspirin = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
  number.of.episodes.24h = as.numeric(sample(0:20, num_rows, replace = TRUE)),
  total.chol = as.numeric(sample(5:100, num_rows, replace = TRUE)),
  total.hdl = as.numeric(sample(2:5, num_rows, replace = TRUE)),
  Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE)
)


# Call the function with the cohort_xx

  results <- cohort_xx %>% rowwise() %>%
  mutate(TIMI_score = TIMI(Age, hypertension, hyperlipidaemia, family.history,
  diabetes, smoker, previous.pci, previous.cabg, aspirin, number.of.episodes.24h,
  ecg.st.depression, presentation_hstni, Gender, classify = FALSE))

```
