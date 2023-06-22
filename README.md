
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
#>  $ typical_symptoms.num   : num  5 2 3 2 5 1 4 4 5 3 ...
#>  $ ecg.normal             : num  1 1 1 1 1 1 0 1 0 0 ...
#>  $ abn.repolarisation     : num  0 1 1 1 0 1 0 1 0 1 ...
#>  $ ecg.st.depression      : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ Age                    : num  42 76 42 41 65 57 47 42 71 59 ...
#>  $ diabetes               : num  1 1 1 1 0 0 0 1 1 1 ...
#>  $ smoker                 : num  0 0 1 0 1 1 0 0 0 1 ...
#>  $ hypertension           : num  0 1 1 0 1 1 0 0 1 1 ...
#>  $ hyperlipidaemia        : num  0 0 0 0 1 1 1 0 0 1 ...
#>  $ family.history         : num  0 1 1 1 0 1 0 0 1 1 ...
#>  $ atherosclerotic.disease: num  1 0 0 0 0 1 0 1 0 0 ...
#>  $ presentation_hstni     : num  31 11 96 63 90 73 21 84 97 47 ...
#>  $ Gender                 : chr  "female" "female" "male" "male" ...
#>  $ sweating               : num  0 0 1 0 1 1 0 1 1 1 ...
#>  $ pain.radiation         : num  0 0 0 0 1 0 1 0 0 0 ...
#>  $ pleuritic              : num  1 0 1 1 1 1 1 1 0 0 ...
#>  $ palpation              : num  1 0 0 0 1 0 1 1 1 0 ...
#>  $ ecg.twi                : num  1 0 1 1 0 1 1 0 1 1 ...
#>  $ second_hstni           : num  138 153 153 42 170 164 193 153 114 24 ...
#>  $ killip.class           : num  3 2 1 1 2 1 2 2 4 4 ...
#>  $ systolic.bp            : num  54 64 243 275 114 78 187 281 55 57 ...
#>  $ heart.rate             : num  240 182 118 290 147 112 295 256 113 293 ...
#>  $ creat                  : num  0 4 4 4 3 2 3 2 4 1 ...
#>  $ cardiac.arrest         : num  1 0 1 1 0 0 1 1 1 1 ...
#>  $ previous.pci           : num  1 0 1 1 1 0 1 0 1 0 ...
#>  $ previous.cabg          : num  1 1 0 0 1 1 0 1 0 1 ...
#>  $ aspirin                : num  0 1 1 1 1 1 0 1 0 1 ...
#>  $ number.of.episodes.24h : num  17 2 10 6 20 6 15 7 19 19 ...
#>  $ total.chol             : num  93 25 53 36 85 12 13 51 86 83 ...
#>  $ total.hdl              : num  3 5 3 5 4 4 4 3 5 2 ...
#>  $ Ethnicity              : chr  "white" "white" "white" "white" ...
```

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
#> 1           5 Moderate risk          -8 Not low risk         129 High risk    
#> 2           6 Moderate risk          16 Not low risk         162 High risk    
#> 3           5 Moderate risk          11 Not low risk          38 Low risk     
#> 4           4 Moderate risk           4 Not low risk          58 Low risk     
#> 5           7 High risk              14 Not low risk         133 High risk    
#> 6           5 Moderate risk          13 Not low risk         103 Moderate risk
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 3.00   Low risk     : 5   Min.   :-8.00   Low risk    :  0  
#>  1st Qu.: 5.00   Moderate risk:54   1st Qu.: 3.75   Not low risk:100  
#>  Median : 6.00   High risk    :41   Median :10.00                     
#>  Mean   : 6.26                      Mean   : 9.14                     
#>  3rd Qu.: 7.00                      3rd Qu.:15.00                     
#>  Max.   :10.00                      Max.   :26.00                     
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 22.00   Low risk     :30   Min.   :2.00   Very low risk: 0  
#>  1st Qu.: 81.25   Moderate risk:24   1st Qu.:3.00   Low risk     : 6  
#>  Median :114.50   High risk    :46   Median :4.00   Moderate risk:54  
#>  Mean   :112.23                      Mean   :4.22   High risk    :40  
#>  3rd Qu.:141.00                      3rd Qu.:5.00                     
#>  Max.   :227.00                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.00   Very low risk: 0    Min.   :0.0000   Very low risk: 9  
#>  1st Qu.: 13.00   Low risk     :13    1st Qu.:0.1275   Low risk     : 8  
#>  Median : 96.00   Moderate risk: 8    Median :0.3100   Moderate risk:21  
#>  Mean   : 60.75   High risk    :79    Mean   :0.4035   High risk    :62  
#>  3rd Qu.:100.00                       3rd Qu.:0.6725                     
#>  Max.   :100.00                       Max.   :1.0000
```
