# HEART risk score function for data frame; HEART = History, ECG, Age, Risk factors, Troponin

This function allows you to calculate the HEART score row wise in a data
frame with the required variables. It would then retrieve a data frame
with two extra columns including the calculations and their
classifications

## Usage

``` r
HEART_scores(
  data,
  typical_symptoms.num = typical_symptoms.num,
  ecg.normal = ecg.normal,
  abn.repolarisation = abn.repolarisation,
  ecg.st.depression = ecg.st.depression,
  Age = Age,
  diabetes = diabetes,
  smoker = smoker,
  hypertension = hypertension,
  hyperlipidaemia = hyperlipidaemia,
  family.history = family.history,
  atherosclerotic.disease = atherosclerotic.disease,
  presentation_hstni = presentation_hstni,
  Gender = Gender,
  classify
)
```

## Arguments

- data:

  A data frame with all the variables needed for calculation:
  typical_symptoms.num, ecg.normal, abn.repolarisation,
  ecg.st.depression,Age, diabetes, smoker, hypertension,
  hyperlipidaemia, family.history, atherosclerotic.disease,
  presentation_hstni, Gender

- typical_symptoms.num:

  a numeric vector of the number of typical symptoms

- ecg.normal:

  a binary numeric vector, 1 = yes and 0 = no

- abn.repolarisation:

  a binary numeric vector, 1 = yes and 0 = no

- ecg.st.depression:

  a binary numeric vector, 1 = yes and 0 = no

- Age:

  a numeric vector of age values, in years

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

- atherosclerotic.disease:

  a binary numeric vector, 1 = yes and 0 = no

- presentation_hstni:

  a continuous numeric vector of the troponin levels

- Gender:

  a binary character vector of sex values. Categories should include
  only 'male' or 'female'

- classify:

  a logical parameter to indicate classification of Scores "TRUE" or
  none "FALSE"

## Value

a data frame with two extra columns including the HEART score
calculations and their classifications

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
  Gender = sample(c("male", "female"), num_rows, replace = TRUE)
)
# Call the function with the cohort_xx
result <- HEART_scores(data = cohort_xx, classify = TRUE)
# Print the results
summary(result$HEART_score)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>    2.00    5.00    6.00    6.14    7.00   10.00 
summary(result$HEART_strat)
#>      Low risk Moderate risk     High risk 
#>             4            51            45 
```
