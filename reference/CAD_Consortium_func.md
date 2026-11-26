# Coronary Artery Disease Consortium Score (Low Prevalence Model)

This function implements the CAD Consortium model (BMJ 2012, Table 2 -
Low Prevalence) to estimate the pre-test probability of obstructive
coronary artery disease (CAD) in patients based on age, sex, symptoms,
and cardiovascular risk factors.

There are two models available: - Basic model: age, sex, chest pain
type - Clinical model: includes additional risk factors (diabetes,
hypertension, dyslipidaemia, smoking)

Chest Pain Types: - 1: Non-anginal - 2: Atypical angina - 3: Typical
angina

The function uses published odds ratios to compute a logistic
regression-based probability of CAD, expressed as a percentage. When
\`classify = TRUE\`, it returns a risk category: - Low (\<15 -
Intermediate (15–50 - High (50–85 - Very High (\>85

## Usage

``` r
CAD_Consortium_func(
  Age,
  Sex,
  ChestPainType,
  Diabetes = 0,
  Hypertension = 0,
  Dyslipidaemia = 0,
  Smoking = 0,
  model_type = "clinical",
  classify = FALSE
)
```

## Arguments

- Age:

  A numeric value for age in years.

- Sex:

  A character vector ("male" or "female").

- ChestPainType:

  A numeric value: 1 (non-anginal), 2 (atypical angina), or 3 (typical
  angina).

- Diabetes:

  A binary value: 1 = yes, 0 = no.

- Hypertension:

  A binary value: 1 = yes, 0 = no.

- Dyslipidaemia:

  A binary value: 1 = yes, 0 = no.

- Smoking:

  A binary value: 1 = yes, 0 = no.

- model_type:

  A character value, "basic" or "clinical". Defaults to "clinical".

- classify:

  A logical value. If TRUE, returns a risk category; if FALSE, returns
  numeric probability.

## Value

A numeric value representing the pre-test probability (

## Examples

``` r
# Basic model
CAD_Consortium_func(Age = 60, Sex = "male", ChestPainType = 3, model_type = "basic")
#> [1] 55.9

# Clinical model with risk classification
CAD_Consortium_func(Age = 55, Sex = "female", ChestPainType = 2, Diabetes = 1,
  Hypertension = 1, Dyslipidaemia = 1, Smoking = 0, model_type = "clinical", classify = TRUE)
#> [1] "Low (<15%)"
```
