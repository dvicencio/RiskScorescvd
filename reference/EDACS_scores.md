# EDACS score function for data frame; EDACS = Emergency Department Assessment of Chest Pain Score

This function allows you to calculate the EDACS score row wise in a data
frame with the required variables. It would then retrieve a data frame
with two extra columns including the calculations and their
classifications

## Usage

``` r
EDACS_scores(
  data,
  Age = Age,
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
  classify
)
```

## Arguments

- data:

  A data frame with all the variables needed for calculation: Age,
  Gender, diabetes, smoker, hypertension, hyperlipidaemia,
  family.history, sweating, pain.radiation, pleuritic, palpation,
  ecg.st.depression, ecg.twi, presentation_hstni, second_hstni, classify

- Age:

  a numeric vector of age values, in years

- Gender:

  a binary character vector of sex values. Categories should include
  only 'male' or 'female'

- diabetes:

  a binary numeric vector, 1 = yes and 0 = no

- smoker:

  a binary numeric vector, 1 = yes and 0 = no

- hypertension:

  a binary numeric vector, 1 = yes and 0 = no

- hyperlipidaemia:

  a binary numeric vector, 1 = yes and 0 = no

- family.history:

  a binary numeric vector, 1 = yes and 0 = no

- sweating:

  a binary numeric vector, 1 = yes and 0 = no

- pain.radiation:

  a binary numeric vector, 1 = yes and 0 = no

- pleuritic:

  a binary numeric vector, 1 = yes and 0 = no

- palpation:

  a binary numeric vector, 1 = yes and 0 = no

- ecg.st.depression:

  a binary numeric vector, 1 = yes and 0 = no

- ecg.twi:

  a binary numeric vector, 1 = yes and 0 = no

- presentation_hstni:

  a continuous numeric vector of the troponin levels

- second_hstni:

  a binary numeric vector, 1 = yes and 0 = no

- classify:

  a logical parameter to indicate classification of Scores "TRUE" or
  none "FALSE"

## Value

data frame with two extra columns including the 'EDACS_score'
calculations and their classifications, 'EDACS_strat'

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
  second_hstni = as.numeric(sample(1:200, num_rows, replace = TRUE))
)

# Call the function with the cohort_xx

result <- EDACS_scores(data = cohort_xx, classify = TRUE)
summary(result$EDACS_strat)
#>     Low risk Not low risk 
#>            1           99 
summary(result$EDACS_score)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>   -3.00    4.75   10.00   10.18   14.25   25.00 
```
