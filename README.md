
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
[![Connect](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/daniel-perez-vicencio-700549a0/)
<!-- badges: end -->

**Chest pain? Calculate your cardiovascular risk score.**

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

NOTE: Troponin I values should be used. Additional functions for
Troponin T are under development

## Installation

You can install from CRAN with:

``` r
# Install from CRAN
install.packages("RiskScorescvd")
```

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
#>  $ typical_symptoms.num   : num  2 0 4 4 1 5 2 1 4 5 ...
#>  $ ecg.normal             : num  1 0 1 1 0 1 1 0 1 1 ...
#>  $ abn.repolarisation     : num  0 0 1 0 1 1 0 0 0 0 ...
#>  $ ecg.st.depression      : num  0 1 1 0 1 0 1 0 1 1 ...
#>  $ Age                    : num  67 37 34 80 41 41 47 46 52 57 ...
#>  $ diabetes               : num  1 0 1 0 0 0 0 0 1 1 ...
#>  $ smoker                 : num  1 1 1 1 0 0 0 1 0 0 ...
#>  $ hypertension           : num  0 1 1 0 0 0 1 1 0 0 ...
#>  $ hyperlipidaemia        : num  0 0 1 1 0 0 0 0 0 0 ...
#>  $ family.history         : num  1 1 1 1 0 0 0 1 0 0 ...
#>  $ atherosclerotic.disease: num  1 1 1 1 1 1 1 1 0 0 ...
#>  $ presentation_hstni     : num  54 51 72 86 82 50 80 74 21 31 ...
#>  $ Gender                 : chr  "female" "male" "female" "male" ...
#>  $ sweating               : num  1 0 1 0 0 0 0 0 1 1 ...
#>  $ pain.radiation         : num  0 0 0 1 0 0 1 1 0 1 ...
#>  $ pleuritic              : num  1 1 1 1 0 0 1 0 1 0 ...
#>  $ palpation              : num  0 1 0 1 1 0 1 1 1 1 ...
#>  $ ecg.twi                : num  1 1 1 0 1 1 1 1 0 1 ...
#>  $ second_hstni           : num  197 83 119 64 172 169 176 134 83 54 ...
#>  $ killip.class           : num  3 4 4 4 2 3 3 2 1 2 ...
#>  $ systolic.bp            : num  202 77 216 138 256 197 197 203 121 41 ...
#>  $ heart.rate             : num  298 91 44 197 70 291 237 178 232 24 ...
#>  $ creat                  : num  0 3 0 1 2 2 2 0 1 4 ...
#>  $ cardiac.arrest         : num  0 0 0 1 0 1 1 0 1 0 ...
#>  $ previous.pci           : num  1 1 0 0 0 0 0 0 0 1 ...
#>  $ previous.cabg          : num  0 1 1 1 1 1 0 0 1 0 ...
#>  $ aspirin                : num  1 1 1 0 0 1 0 1 1 0 ...
#>  $ number.of.episodes.24h : num  7 0 17 9 10 8 5 17 20 11 ...
#>  $ total.chol             : num  89 89 20 96 25 17 80 68 72 96 ...
#>  $ total.hdl              : num  4 3 2 2 3 5 2 2 2 5 ...
#>  $ Ethnicity              : chr  "other" "black" "asian" "asian" ...
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
#> 1           7 High risk              11 Not low risk         134 High risk    
#> 2           5 Moderate risk           2 Not low risk         123 High risk    
#> 3           7 High risk               5 Not low risk          74 Low risk     
#> 4           6 Moderate risk          17 Not low risk         197 High risk    
#> 5           5 Moderate risk           2 Not low risk          56 Low risk     
#> 6           6 Moderate risk           8 Not low risk          88 Moderate risk
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 2.00   Low risk     : 3   Min.   :-8.00   Low risk    :  0  
#>  1st Qu.: 6.00   Moderate risk:53   1st Qu.: 5.75   Not low risk:100  
#>  Median : 6.00   High risk    :44   Median : 9.50                     
#>  Mean   : 6.36                      Mean   :10.08                     
#>  3rd Qu.: 7.00                      3rd Qu.:15.00                     
#>  Max.   :10.00                      Max.   :25.00                     
#>   GRACE_score           GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 34.0   Low risk     :23   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 90.5   Moderate risk:32   1st Qu.:4.00   Low risk     : 4  
#>  Median :114.5   High risk    :45   Median :4.00   Moderate risk:50  
#>  Mean   :116.9                      Mean   :4.44   High risk    :46  
#>  3rd Qu.:146.0                      3rd Qu.:5.00                     
#>  Max.   :202.0                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  1.00   Very low risk: 0    Min.   :0.0000   Very low risk:13  
#>  1st Qu.: 31.75   Low risk     : 6    1st Qu.:0.1500   Low risk     : 5  
#>  Median : 92.50   Moderate risk: 6    Median :0.3550   Moderate risk:16  
#>  Mean   : 67.68   High risk    :88    Mean   :0.4225   High risk    :66  
#>  3rd Qu.:100.00                       3rd Qu.:0.7075                     
#>  Max.   :100.00                       Max.   :1.0000
```
