
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of RiskScorescvd r package is to calculate the most commonly
used cardiovascular risk scores.

We have developed five of the most commonly used risk scores with a
dependency (ASCVD \[PooledCohort\]) making the following available:

- HEART
- EDACS
- GRACE 2.0
- TIMI
- SCORE2/OP
- ASCVD

## Installation

You can install the development version of RiskScorescvd from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dvicencio/RiskScorescvd")
```

## Required variables for each risk score

<img src="man/figures/README-Plot-1.png" width="100%" />

## Example

This is a basic example of how the data set should look to calculate all
risk scores available in the package:

``` r
library(RiskScorescvd)
#> Loading required package: PooledCohort
# Create a data frame or list with the necessary variables
 # Set the number of rows
 num_rows <- 100
 
 # Create a large dataset with 100 rows
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
   systolic.bp = as.numeric(sample(40:300, num_rows, replace = TRUE)),
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

  str(cohort_xx)
#> 'data.frame':    100 obs. of  31 variables:
#>  $ typical_symptoms.num   : num  1 5 2 4 2 6 1 0 0 5 ...
#>  $ ecg.normal             : num  0 0 0 1 1 1 0 0 1 0 ...
#>  $ abn.repolarisation     : num  1 0 1 1 0 1 1 1 1 1 ...
#>  $ ecg.st.depression      : num  0 0 1 1 1 0 0 1 1 1 ...
#>  $ Age                    : num  54 33 67 75 46 43 41 54 41 31 ...
#>  $ diabetes               : num  0 0 0 1 1 0 1 1 0 0 ...
#>  $ smoker                 : num  1 1 1 0 1 0 0 1 1 0 ...
#>  $ hypertension           : num  1 1 0 1 0 0 1 1 0 0 ...
#>  $ hyperlipidaemia        : num  0 0 1 0 0 1 0 1 0 1 ...
#>  $ family.history         : num  0 0 1 0 1 1 0 0 0 0 ...
#>  $ atherosclerotic.disease: num  1 0 0 1 1 1 0 0 0 0 ...
#>  $ presentation_hstni     : num  43 52 58 99 13 22 11 79 76 67 ...
#>  $ Gender                 : chr  "male" "male" "male" "female" ...
#>  $ sweating               : num  0 1 0 0 0 1 0 1 1 1 ...
#>  $ pain.radiation         : num  1 1 1 0 1 0 1 0 1 0 ...
#>  $ pleuritic              : num  1 0 0 1 0 1 0 0 1 0 ...
#>  $ palpation              : num  1 0 0 0 0 0 1 1 0 1 ...
#>  $ ecg.twi                : num  1 1 1 0 0 0 1 1 1 1 ...
#>  $ second_hstni           : num  3 169 195 31 54 188 145 179 109 130 ...
#>  $ killip.class           : num  2 1 4 2 2 1 1 1 3 4 ...
#>  $ systolic.bp            : num  159 101 268 214 252 278 211 50 149 165 ...
#>  $ heart.rate             : num  103 19 38 151 106 74 109 190 56 61 ...
#>  $ creat                  : num  2 3 2 2 4 2 2 3 1 1 ...
#>  $ cardiac.arrest         : num  0 0 1 0 1 0 1 0 0 0 ...
#>  $ previous.pci           : num  1 1 1 0 1 1 1 1 0 0 ...
#>  $ previous.cabg          : num  1 1 1 0 1 0 0 1 1 1 ...
#>  $ aspirin                : num  1 0 0 0 0 1 0 1 0 1 ...
#>  $ number.of.episodes.24h : num  20 8 5 5 3 0 20 6 5 11 ...
#>  $ total.chol             : num  16 89 83 62 76 60 86 90 85 32 ...
#>  $ total.hdl              : num  5 5 2 4 5 2 3 5 5 4 ...
#>  $ Ethnicity              : chr  "black" "other" "black" "white" ...
```

## Calculation and Results

This is a basic example of how to calculate all risk scores available in
the package and create a new data set with 12 new variables of the
calculated and classified risk scores:

``` r
# Call the function with the cohort_xx to calculate all risk scores available in the package
new_data_frame <- calc_scores(data = cohort_xx)
 
# Select columns created after calculation
All_scores <- new_data_frame %>% select(HEART_score, HEART_strat, EDACS_score, EDACS_strat, GRACE_score, GRACE_strat, TIMI_score, TIMI_strat, SCORE2_score, SCORE2_strat, ASCVD_score, ASCVD_strat)

# Observe the results
head(All_scores)
#> # A tibble: 6 × 12
#> # Rowwise: 
#>   HEART_score HEART_strat   EDACS_score EDACS_strat  GRACE_score GRACE_strat
#>         <dbl> <ord>               <dbl> <ord>              <dbl> <ord>      
#> 1           5 Moderate risk           7 Not low risk          85 Low risk   
#> 2           5 Moderate risk          16 Not low risk          47 Low risk   
#> 3           8 High risk              23 Not low risk         132 High risk  
#> 4           9 High risk              10 Not low risk         140 High risk  
#> 5           6 Moderate risk          19 Not low risk          61 Low risk   
#> 6           6 Moderate risk           1 Not low risk          29 Low risk   
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 2.00   Low risk     : 1   Min.   :-5.00   Low risk    :  0  
#>  1st Qu.: 6.00   Moderate risk:38   1st Qu.: 6.00   Not low risk:100  
#>  Median : 7.00   High risk    :61   Median :11.50                     
#>  Mean   : 6.71                      Mean   :11.76                     
#>  3rd Qu.: 8.00                      3rd Qu.:18.00                     
#>  Max.   :10.00                      Max.   :27.00                     
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 13.00   Low risk     :27   Min.   :2.00   Very low risk: 0  
#>  1st Qu.: 86.75   Moderate risk:25   1st Qu.:4.00   Low risk     : 4  
#>  Median :117.00   High risk    :48   Median :4.00   Moderate risk:49  
#>  Mean   :115.95                      Mean   :4.46   High risk    :47  
#>  3rd Qu.:143.25                      3rd Qu.:5.00                     
#>  Max.   :214.00                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.00   Very low risk: 0    Min.   :0.0000   Very low risk: 5  
#>  1st Qu.: 65.75   Low risk     : 4    1st Qu.:0.2300   Low risk     : 3  
#>  Median :100.00   Moderate risk: 4    Median :0.5400   Moderate risk:14  
#>  Mean   : 77.84   High risk    :92    Mean   :0.5501   High risk    :78  
#>  3rd Qu.:100.00                       3rd Qu.:0.8550                     
#>  Max.   :100.00                       Max.   :1.0000
```
