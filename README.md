
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd <a href="https://dvicencio.github.io/RiskScorescvd/"><img src="man/figures/logo.png" align="right" height="220" alt="Hex logo of R package RiskScorescvd. Logo is a rectangular card with a picture of cardiac heart." /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
[![downloads](http://cranlogs.r-pkg.org/badges/grand-total/RiskScorescvd?color=green)](https://cran.r-project.org/package=RiskScorescvd)
[![Connect](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/daniel-perez-vicencio-700549a0/)
<!-- badges: end -->

**Chest pain? Calculate your cardiovascular risk score.**

The goal of RiskScorescvd R package is to calculate the most commonly
used cardiovascular risk scores. Original research publication can be
found here: <https://openheart.bmj.com/content/11/2/e002755>

We have developed nine of the most commonly used risk scores with a
dependency (ASCVD \[PooledCohort\]) making the following available:

- HEART
- EDACS
- GRACE 2.0
- TIMI
- SCORE2/OP
- SCORE2-Diabetes
- SCORE2-CKD
- SCORE2-Asia
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
#>  $ typical_symptoms.num   : num  1 5 3 2 1 6 4 4 2 1 ...
#>  $ ecg.normal             : num  1 0 1 0 0 1 1 1 1 0 ...
#>  $ abn.repolarisation     : num  0 1 1 0 0 0 1 0 1 1 ...
#>  $ ecg.st.depression      : num  0 0 1 0 0 1 1 0 0 1 ...
#>  $ Age                    : num  61 73 55 42 45 75 62 39 65 52 ...
#>  $ diabetes               : num  1 1 1 1 1 0 1 1 1 0 ...
#>  $ smoker                 : num  0 0 1 1 0 0 1 1 0 0 ...
#>  $ hypertension           : num  1 1 0 0 1 0 1 1 1 0 ...
#>  $ hyperlipidaemia        : num  0 1 0 0 0 0 0 0 0 1 ...
#>  $ family.history         : num  0 0 0 0 1 0 1 1 0 0 ...
#>  $ atherosclerotic.disease: num  0 0 0 1 1 0 1 1 0 0 ...
#>  $ presentation_hstni     : num  82 37 46 36 91 87 37 58 50 19 ...
#>  $ Gender                 : chr  "male" "female" "male" "female" ...
#>  $ sweating               : num  1 1 0 0 1 1 1 0 0 1 ...
#>  $ pain.radiation         : num  0 0 1 0 1 1 0 1 1 1 ...
#>  $ pleuritic              : num  0 1 1 1 1 1 1 0 1 0 ...
#>  $ palpation              : num  1 0 1 1 1 1 0 0 1 1 ...
#>  $ ecg.twi                : num  1 1 1 0 1 1 1 0 0 0 ...
#>  $ second_hstni           : num  11 174 100 1 55 70 167 97 114 198 ...
#>  $ killip.class           : num  2 1 1 1 3 2 1 2 4 2 ...
#>  $ heart.rate             : num  233 285 51 112 35 29 100 128 66 12 ...
#>  $ systolic.bp            : num  218 158 263 176 80 233 199 144 103 79 ...
#>  $ aspirin                : num  1 0 1 0 0 1 1 1 0 0 ...
#>  $ creat                  : num  0 4 2 3 0 4 1 2 0 3 ...
#>  $ number.of.episodes.24h : num  15 20 10 14 19 6 16 17 8 20 ...
#>  $ previous.pci           : num  0 0 1 1 1 1 0 1 1 0 ...
#>  $ cardiac.arrest         : num  0 0 1 0 1 1 1 1 0 1 ...
#>  $ previous.cabg          : num  0 0 1 0 0 1 0 1 1 0 ...
#>  $ total.chol             : num  97 59 30 88 40 89 88 60 34 50 ...
#>  $ total.hdl              : num  4 4 4 3 5 2 5 2 4 2 ...
#>  $ Ethnicity              : chr  "other" "other" "white" "asian" ...
#>  $ eGFR                   : num  93 68 120 58 82 77 76 86 33 80 ...
#>  $ ACR                    : num  235 581 1418 801 1370 ...
#>  $ trace                  : chr  "1+" "1+" "4+" "1+" ...
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
#> 1           3 Low risk               13 Not low risk         109 Moderate risk
#> 2           8 High risk              13 Not low risk         131 High risk    
#> 3           6 Moderate risk           7 Not low risk          66 Low risk     
#> 4           5 Moderate risk          -8 Not low risk          46 Low risk     
#> 5           6 Moderate risk           4 Not low risk         100 Moderate risk
#> 6           8 High risk              12 Not low risk         118 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score          HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   :2.00   Low risk     : 3   Min.   :-8.00   Low risk    :  0  
#>  1st Qu.:5.00   Moderate risk:48   1st Qu.: 5.00   Not low risk:100  
#>  Median :6.00   High risk    :49   Median :10.00                     
#>  Mean   :6.29                      Mean   :10.47                     
#>  3rd Qu.:7.00                      3rd Qu.:15.25                     
#>  Max.   :9.00                      Max.   :28.00                     
#>   GRACE_score           GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 34.0   Low risk     :30   Min.   :2.00   Very low risk: 0  
#>  1st Qu.: 85.0   Moderate risk:31   1st Qu.:3.75   Low risk     : 7  
#>  Median :109.0   High risk    :39   Median :4.00   Moderate risk:49  
#>  Mean   :114.4                      Mean   :4.22   High risk    :44  
#>  3rd Qu.:138.0                      3rd Qu.:5.00                     
#>  Max.   :221.0                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.10   Very low risk: 0    Min.   :0.0000   Very low risk: 8  
#>  1st Qu.: 29.70   Low risk     : 9    1st Qu.:0.1900   Low risk     : 2  
#>  Median : 98.75   Moderate risk: 6    Median :0.4750   Moderate risk:15  
#>  Mean   : 68.89   High risk    :85    Mean   :0.4959   High risk    :75  
#>  3rd Qu.:100.00                       3rd Qu.:0.8225                     
#>  Max.   :100.00                       Max.   :1.0000
```
