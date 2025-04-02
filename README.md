
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd <a href="https://dvicencio.github.io/RiskScorescvd/"><img src="man/figures/logo.png" align="right" height="220" alt="Hex logo of R package RiskScorescvd. Logo is a rectangular card with a picture of cardiac heart." /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
[![downloads](http://cranlogs.r-pkg.org/badges/grand-total/RiskScorescvd?color=green)](https://cran.r-project.org/package=RiskScorescvd)
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
#>  $ typical_symptoms.num   : num  1 5 5 5 2 3 3 2 4 6 ...
#>  $ ecg.normal             : num  0 1 0 1 0 0 0 0 0 0 ...
#>  $ abn.repolarisation     : num  1 1 0 0 0 0 0 1 1 1 ...
#>  $ ecg.st.depression      : num  1 1 1 0 1 0 1 1 0 0 ...
#>  $ Age                    : num  64 68 80 51 69 63 36 41 59 65 ...
#>  $ diabetes               : num  0 0 0 1 0 1 0 1 1 1 ...
#>  $ smoker                 : num  1 1 1 1 0 1 1 1 1 0 ...
#>  $ hypertension           : num  1 1 0 1 0 0 0 0 0 0 ...
#>  $ hyperlipidaemia        : num  1 0 1 1 0 1 1 0 1 1 ...
#>  $ family.history         : num  1 1 0 0 1 0 1 1 1 0 ...
#>  $ atherosclerotic.disease: num  1 1 1 0 0 0 1 1 1 1 ...
#>  $ presentation_hstni     : num  26 15 28 13 90 36 41 87 94 27 ...
#>  $ Gender                 : chr  "male" "male" "female" "male" ...
#>  $ sweating               : num  0 0 0 1 0 0 0 0 0 0 ...
#>  $ pain.radiation         : num  1 0 1 1 0 0 0 1 1 0 ...
#>  $ pleuritic              : num  0 1 1 1 1 1 0 1 0 0 ...
#>  $ palpation              : num  0 0 1 0 0 1 0 0 1 1 ...
#>  $ ecg.twi                : num  1 1 0 0 1 0 0 1 1 1 ...
#>  $ second_hstni           : num  46 156 72 50 193 72 117 78 36 190 ...
#>  $ killip.class           : num  2 1 1 1 3 2 4 2 2 2 ...
#>  $ heart.rate             : num  246 215 131 158 128 212 182 187 195 71 ...
#>  $ systolic.bp            : num  128 239 229 115 118 141 255 294 113 179 ...
#>  $ aspirin                : num  1 0 0 1 1 0 1 0 1 1 ...
#>  $ creat                  : num  4 3 2 1 3 4 4 4 1 3 ...
#>  $ number.of.episodes.24h : num  2 3 2 0 9 1 19 2 3 15 ...
#>  $ previous.pci           : num  1 0 0 1 1 1 1 1 1 0 ...
#>  $ cardiac.arrest         : num  1 1 0 1 1 1 0 1 1 1 ...
#>  $ previous.cabg          : num  1 1 0 0 1 0 0 1 0 0 ...
#>  $ total.chol             : num  98 62 69 71 92 16 61 9 27 35 ...
#>  $ total.hdl              : num  2 2 2 4 5 4 3 2 4 2 ...
#>  $ Ethnicity              : chr  "black" "asian" "asian" "white" ...
#>  $ eGFR                   : num  28 55 69 57 73 105 119 93 16 106 ...
#>  $ ACR                    : num  673 127 250 565 420 ...
#>  $ trace                  : chr  "4+" "4+" "4+" "1+" ...
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
#> 1           5 Moderate risk          21 Not low risk         143 High risk    
#> 2           8 High risk              14 Not low risk         111 Moderate risk
#> 3           9 High risk              11 Not low risk         128 High risk    
#> 4           5 Moderate risk          16 Not low risk          82 Low risk     
#> 5           7 High risk              14 Not low risk         164 High risk    
#> 6           6 Moderate risk           0 Not low risk         132 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat
#>  Min.   : 1.00   Low risk     : 5   Min.   :-4.00   Low risk    : 1  
#>  1st Qu.: 5.00   Moderate risk:48   1st Qu.: 5.00   Not low risk:99  
#>  Median : 6.00   High risk    :47   Median :10.00                    
#>  Mean   : 6.24                      Mean   : 9.86                    
#>  3rd Qu.: 7.25                      3rd Qu.:15.00                    
#>  Max.   :10.00                      Max.   :28.00                    
#>   GRACE_score           GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 29.0   Low risk     :28   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 82.0   Moderate risk:30   1st Qu.:3.00   Low risk     : 8  
#>  Median :111.0   High risk    :42   Median :4.00   Moderate risk:48  
#>  Mean   :109.9                      Mean   :4.21   High risk    :44  
#>  3rd Qu.:139.5                      3rd Qu.:5.00                     
#>  Max.   :230.0                      Max.   :6.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.40   Very low risk: 0    Min.   :0.0000   Very low risk:10  
#>  1st Qu.: 28.60   Low risk     : 7    1st Qu.:0.1400   Low risk     : 6  
#>  Median : 98.90   Moderate risk: 5    Median :0.4450   Moderate risk:16  
#>  Mean   : 68.72   High risk    :88    Mean   :0.4518   High risk    :68  
#>  3rd Qu.:100.00                       3rd Qu.:0.7100                     
#>  Max.   :100.00                       Max.   :1.0000
```
