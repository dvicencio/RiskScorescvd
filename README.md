
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
[![](http://cranlogs.r-pkg.org/badges/grand-total/RiskScorescvd?color=green)](https://cran.r-project.org/package=RiskScorescvd)
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

## Installation

You can install the development version of RiskScorescvd from
[GitHub](https://github.com/) with:

``` r
# Install from CRAN
install.packages("RiskScorescvd")

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
#>  $ typical_symptoms.num   : num  0 1 0 2 6 1 6 2 5 2 ...
#>  $ ecg.normal             : num  1 1 1 0 1 1 0 1 1 1 ...
#>  $ abn.repolarisation     : num  0 1 1 1 1 1 0 1 1 0 ...
#>  $ ecg.st.depression      : num  1 1 0 1 0 0 1 0 1 0 ...
#>  $ Age                    : num  67 58 78 57 38 59 30 59 51 34 ...
#>  $ diabetes               : num  0 0 1 1 1 1 0 0 1 0 ...
#>  $ smoker                 : num  1 1 1 0 0 1 1 1 0 0 ...
#>  $ hypertension           : num  1 1 1 0 1 0 0 1 0 0 ...
#>  $ hyperlipidaemia        : num  1 1 0 0 0 0 1 0 0 1 ...
#>  $ family.history         : num  0 1 1 0 0 0 1 0 1 1 ...
#>  $ atherosclerotic.disease: num  1 1 1 0 1 1 0 0 1 0 ...
#>  $ presentation_hstni     : num  37 57 49 66 20 62 68 48 93 20 ...
#>  $ Gender                 : chr  "male" "male" "female" "male" ...
#>  $ sweating               : num  0 1 1 1 1 1 0 0 0 0 ...
#>  $ pain.radiation         : num  1 1 1 1 1 1 1 0 1 1 ...
#>  $ pleuritic              : num  1 0 0 1 1 0 0 0 1 1 ...
#>  $ palpation              : num  0 1 0 1 1 0 1 0 1 1 ...
#>  $ ecg.twi                : num  1 1 1 0 1 0 1 1 0 1 ...
#>  $ second_hstni           : num  88 37 177 65 118 157 19 171 100 157 ...
#>  $ killip.class           : num  4 1 4 1 1 4 4 4 2 4 ...
#>  $ systolic.bp            : num  42 236 225 131 295 103 40 220 173 200 ...
#>  $ heart.rate             : num  116 158 291 231 271 12 240 39 199 76 ...
#>  $ creat                  : num  0 0 2 3 4 0 1 1 4 4 ...
#>  $ cardiac.arrest         : num  0 1 1 0 1 0 1 1 0 0 ...
#>  $ previous.pci           : num  0 0 1 1 1 1 0 0 1 0 ...
#>  $ previous.cabg          : num  0 1 0 1 0 0 1 0 1 1 ...
#>  $ aspirin                : num  1 0 1 0 0 1 1 1 1 1 ...
#>  $ number.of.episodes.24h : num  2 15 7 11 10 6 19 1 12 13 ...
#>  $ total.chol             : num  33 45 67 82 36 41 27 84 47 72 ...
#>  $ total.hdl              : num  5 2 3 5 5 3 4 3 2 4 ...
#>  $ Ethnicity              : chr  "other" "white" "black" "other" ...
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
#> 1           7 High risk              19 Not low risk         184 High risk    
#> 2           6 Moderate risk          16 Not low risk          96 Moderate risk
#> 3           7 High risk              24 Not low risk         170 High risk    
#> 4           6 Moderate risk          12 Not low risk         127 High risk    
#> 5           6 Moderate risk           0 Not low risk          53 Low risk     
#> 6           6 Moderate risk          16 Not low risk         133 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 2.00   Low risk     : 4   Min.   :-8.00   Low risk    :  0  
#>  1st Qu.: 5.00   Moderate risk:49   1st Qu.: 5.00   Not low risk:100  
#>  Median : 6.00   High risk    :47   Median : 9.00                     
#>  Mean   : 6.34                      Mean   : 9.43                     
#>  3rd Qu.: 7.00                      3rd Qu.:14.00                     
#>  Max.   :10.00                      Max.   :30.00                     
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 33.00   Low risk     :27   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 84.75   Moderate risk:28   1st Qu.:3.00   Low risk     : 8  
#>  Median :111.50   High risk    :45   Median :4.00   Moderate risk:53  
#>  Mean   :110.50                      Mean   :4.18   High risk    :39  
#>  3rd Qu.:137.25                      3rd Qu.:5.00                     
#>  Max.   :201.00                      Max.   :6.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  1.00   Very low risk: 0    Min.   :0.0000   Very low risk:12  
#>  1st Qu.: 47.50   Low risk     : 5    1st Qu.:0.1700   Low risk     : 3  
#>  Median : 99.00   Moderate risk: 4    Median :0.4650   Moderate risk:13  
#>  Mean   : 74.05   High risk    :91    Mean   :0.5081   High risk    :72  
#>  3rd Qu.:100.00                       3rd Qu.:0.9000                     
#>  Max.   :100.00                       Max.   :1.0000
```
