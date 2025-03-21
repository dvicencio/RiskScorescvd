
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd

<a href="https://dvicencio.github.io/RiskScorescvd/"><img src="logo.png" align="right" height="240" alt="Risk Scores" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/RiskScorescvd?color=green)](https://cran.r-project.org/package=RiskScorescvd)
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
- SCORE2-Diabetes
- SCORE2-CKD
- PCE (ASCVD)

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

<img src="man/figures/README-Plot-1.png" alt="Heatmap showing which clinical variables are required for the different risk scores. Required variables are indicated in blue, variables not required are indicated in red." width="100%" />

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
   heart.rate = as.numeric(sample(0:300, num_rows, replace = TRUE)),
   systolic.bp = as.numeric(sample(40:300, num_rows, replace = TRUE)),
   aspirin = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
   creat = as.numeric(sample(0:4, num_rows, replace = TRUE)),
   number.of.episodes.24h = as.numeric(sample(0:20, num_rows, replace = TRUE)),
   previous.pci = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
   cardiac.arrest = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
   previous.cabg = as.numeric(sample(c(0, 1), num_rows, replace = TRUE)),
   total.chol = as.numeric(sample(5:100, num_rows, replace = TRUE)),
   total.hdl = as.numeric(sample(2:5, num_rows, replace = TRUE)),
   Ethnicity = sample(c("white", "black", "asian", "other"), num_rows, replace = TRUE),
   eGFR = as.numeric(sample(15:120, num_rows, replace = TRUE)),
   ACR = as.numeric(sample(5:1500, num_rows, replace = TRUE)),
   trace = sample(c("trace", "1+", "2+", "3+", "4+"), num_rows, replace = TRUE)
 )

  str(cohort_xx)
#> 'data.frame':    100 obs. of  34 variables:
#>  $ typical_symptoms.num   : num  5 1 2 4 1 0 0 2 3 2 ...
#>  $ ecg.normal             : num  0 0 1 0 0 1 1 0 1 0 ...
#>  $ abn.repolarisation     : num  0 0 1 1 0 0 0 0 0 0 ...
#>  $ ecg.st.depression      : num  0 1 0 1 0 1 1 1 0 1 ...
#>  $ Age                    : num  74 68 58 46 55 67 42 30 38 36 ...
#>  $ diabetes               : num  1 1 0 0 0 0 1 0 1 0 ...
#>  $ smoker                 : num  0 0 0 0 0 1 0 0 1 1 ...
#>  $ hypertension           : num  0 1 1 0 0 1 0 1 1 0 ...
#>  $ hyperlipidaemia        : num  1 0 1 0 0 1 0 0 1 1 ...
#>  $ family.history         : num  0 0 1 0 1 1 0 0 0 1 ...
#>  $ atherosclerotic.disease: num  0 0 1 0 1 0 1 0 0 0 ...
#>  $ presentation_hstni     : num  37 18 79 34 71 16 80 18 26 99 ...
#>  $ Gender                 : chr  "male" "female" "male" "male" ...
#>  $ sweating               : num  0 1 0 1 0 1 0 0 0 0 ...
#>  $ pain.radiation         : num  1 0 0 1 0 1 0 1 1 1 ...
#>  $ pleuritic              : num  1 1 0 0 0 1 1 1 1 1 ...
#>  $ palpation              : num  1 0 1 1 1 1 1 0 0 1 ...
#>  $ ecg.twi                : num  1 0 0 0 0 1 1 0 0 1 ...
#>  $ second_hstni           : num  48 89 65 13 11 132 184 61 71 154 ...
#>  $ killip.class           : num  1 1 3 4 4 4 3 4 1 4 ...
#>  $ heart.rate             : num  37 273 123 121 159 250 88 50 263 116 ...
#>  $ systolic.bp            : num  109 240 206 285 175 254 281 146 258 288 ...
#>  $ aspirin                : num  1 0 0 0 0 1 1 0 1 0 ...
#>  $ creat                  : num  0 2 1 2 2 4 0 1 0 1 ...
#>  $ number.of.episodes.24h : num  7 3 15 17 13 13 9 12 9 4 ...
#>  $ previous.pci           : num  0 0 1 0 1 0 0 0 0 1 ...
#>  $ cardiac.arrest         : num  1 1 1 1 0 1 1 1 1 0 ...
#>  $ previous.cabg          : num  0 1 1 1 0 1 0 0 0 1 ...
#>  $ total.chol             : num  30 88 16 92 83 63 88 99 31 56 ...
#>  $ total.hdl              : num  3 5 2 4 2 2 4 3 3 3 ...
#>  $ Ethnicity              : chr  "other" "asian" "black" "white" ...
#>  $ eGFR                   : num  49 72 112 52 92 101 52 21 103 86 ...
#>  $ ACR                    : num  599 1054 14 1132 1330 ...
#>  $ trace                  : chr  "1+" "trace" "3+" "1+" ...
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
#> 1           7 High risk              15 Not low risk         115 Moderate risk
#> 2           6 Moderate risk          11 Not low risk         124 High risk    
#> 3           6 Moderate risk           8 Not low risk          97 Moderate risk
#> 4           5 Moderate risk          12 Not low risk         107 Moderate risk
#> 5           6 Moderate risk           0 Not low risk         127 High risk    
#> 6           6 Moderate risk          16 Not low risk         153 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score          HEART_strat  EDACS_score          EDACS_strat
#>  Min.   : 3.0   Low risk     : 3   Min.   :-8.00   Low risk    : 3  
#>  1st Qu.: 5.0   Moderate risk:55   1st Qu.: 3.00   Not low risk:97  
#>  Median : 6.0   High risk    :42   Median :10.00                    
#>  Mean   : 6.3                      Mean   : 9.40                    
#>  3rd Qu.: 8.0                      3rd Qu.:14.25                    
#>  Max.   :10.0                      Max.   :25.00                    
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 36.00   Low risk     :26   Min.   :2.00   Very low risk: 0  
#>  1st Qu.: 87.75   Moderate risk:38   1st Qu.:3.75   Low risk     :11  
#>  Median :106.50   High risk    :36   Median :4.00   Moderate risk:49  
#>  Mean   :110.31                      Mean   :4.24   High risk    :40  
#>  3rd Qu.:132.25                      3rd Qu.:5.00                     
#>  Max.   :220.00                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.20   Very low risk: 0    Min.   :0.0000   Very low risk:12  
#>  1st Qu.: 46.17   Low risk     : 7    1st Qu.:0.1675   Low risk     : 4  
#>  Median : 98.65   Moderate risk: 2    Median :0.4500   Moderate risk:13  
#>  Mean   : 73.09   High risk    :91    Mean   :0.4947   High risk    :71  
#>  3rd Qu.:100.00                       3rd Qu.:0.8600                     
#>  Max.   :100.00                       Max.   :1.0000
```
