
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
#>  $ typical_symptoms.num   : num  0 5 6 1 2 6 3 1 6 1 ...
#>  $ ecg.normal             : num  0 1 0 0 1 1 0 1 0 1 ...
#>  $ abn.repolarisation     : num  0 1 0 1 0 1 1 1 0 0 ...
#>  $ ecg.st.depression      : num  1 1 0 0 0 0 0 1 0 0 ...
#>  $ Age                    : num  59 63 66 64 62 57 47 64 79 50 ...
#>  $ diabetes               : num  1 0 1 0 1 1 0 1 1 0 ...
#>  $ smoker                 : num  1 1 0 0 1 1 1 0 0 0 ...
#>  $ hypertension           : num  1 0 1 0 0 0 1 0 0 1 ...
#>  $ hyperlipidaemia        : num  0 0 1 1 1 0 0 0 0 1 ...
#>  $ family.history         : num  0 1 0 0 0 1 0 0 0 1 ...
#>  $ atherosclerotic.disease: num  0 0 1 1 0 1 1 1 0 1 ...
#>  $ presentation_hstni     : num  61 85 71 48 10 80 37 83 69 96 ...
#>  $ Gender                 : chr  "female" "female" "male" "male" ...
#>  $ sweating               : num  1 1 1 0 0 0 1 0 1 1 ...
#>  $ pain.radiation         : num  0 0 0 1 1 0 1 1 0 0 ...
#>  $ pleuritic              : num  0 0 0 0 1 0 1 1 0 1 ...
#>  $ palpation              : num  0 0 1 0 0 1 1 1 0 1 ...
#>  $ ecg.twi                : num  1 1 0 1 0 0 1 0 1 1 ...
#>  $ second_hstni           : num  117 193 55 185 194 108 64 129 46 124 ...
#>  $ killip.class           : num  3 2 4 3 3 3 2 2 3 3 ...
#>  $ systolic.bp            : num  56 40 291 148 155 78 299 208 237 295 ...
#>  $ heart.rate             : num  94 72 281 61 190 262 109 177 26 134 ...
#>  $ creat                  : num  3 4 1 3 1 1 1 2 1 1 ...
#>  $ cardiac.arrest         : num  0 0 0 0 1 1 1 1 1 0 ...
#>  $ previous.pci           : num  0 1 1 1 1 1 0 0 1 0 ...
#>  $ previous.cabg          : num  0 0 0 1 1 0 1 1 0 0 ...
#>  $ aspirin                : num  1 0 0 1 1 1 0 1 1 0 ...
#>  $ number.of.episodes.24h : num  3 7 14 8 5 11 17 6 6 11 ...
#>  $ total.chol             : num  86 20 66 39 87 97 68 6 53 13 ...
#>  $ total.hdl              : num  3 2 5 4 4 3 5 2 2 3 ...
#>  $ Ethnicity              : chr  "asian" "other" "white" "other" ...
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
#> 1           7 High risk              11 Not low risk         149 High risk    
#> 2           8 High risk              13 Not low risk         136 High risk    
#> 3           8 High risk              15 Not low risk         147 High risk    
#> 4           5 Moderate risk          21 Not low risk         111 Moderate risk
#> 5           4 Moderate risk          11 Not low risk         127 High risk    
#> 6           8 High risk               2 Not low risk         156 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 3.00   Low risk     : 2   Min.   :-4.00   Low risk    :  0  
#>  1st Qu.: 5.00   Moderate risk:52   1st Qu.: 4.00   Not low risk:100  
#>  Median : 6.00   High risk    :46   Median :10.00                     
#>  Mean   : 6.36                      Mean   : 9.98                     
#>  3rd Qu.: 7.00                      3rd Qu.:13.25                     
#>  Max.   :10.00                      Max.   :28.00                     
#>   GRACE_score           GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 29.0   Low risk     :31   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 80.0   Moderate risk:19   1st Qu.:4.00   Low risk     : 6  
#>  Median :119.0   High risk    :50   Median :4.00   Moderate risk:56  
#>  Mean   :114.2                      Mean   :4.18   High risk    :38  
#>  3rd Qu.:142.2                      3rd Qu.:5.00                     
#>  Max.   :195.0                      Max.   :7.00                     
#>   SCORE2_score          SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  2.0   Very low risk: 0    Min.   :0.0000   Very low risk: 9  
#>  1st Qu.: 50.5   Low risk     : 5    1st Qu.:0.2175   Low risk     : 1  
#>  Median :100.0   Moderate risk: 8    Median :0.4550   Moderate risk:10  
#>  Mean   : 75.9   High risk    :87    Mean   :0.5058   High risk    :80  
#>  3rd Qu.:100.0                       3rd Qu.:0.8500                     
#>  Max.   :100.0                       Max.   :1.0000
```
