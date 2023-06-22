
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
#>  $ typical_symptoms.num   : num  3 4 6 5 5 5 3 6 5 2 ...
#>  $ ecg.normal             : num  1 1 0 0 1 1 1 1 1 1 ...
#>  $ abn.repolarisation     : num  0 1 1 0 0 1 1 0 0 0 ...
#>  $ ecg.st.depression      : num  0 1 1 0 1 1 0 1 1 0 ...
#>  $ Age                    : num  32 71 67 31 41 67 30 45 69 32 ...
#>  $ diabetes               : num  0 0 0 0 1 1 1 0 0 1 ...
#>  $ smoker                 : num  1 0 1 0 0 1 0 0 0 1 ...
#>  $ hypertension           : num  0 0 0 1 1 1 1 0 0 0 ...
#>  $ hyperlipidaemia        : num  1 0 1 0 1 0 1 0 1 0 ...
#>  $ family.history         : num  1 0 1 1 0 1 0 0 1 1 ...
#>  $ atherosclerotic.disease: num  0 0 1 0 0 0 0 1 0 1 ...
#>  $ presentation_hstni     : num  57 70 92 65 15 56 28 89 28 76 ...
#>  $ Gender                 : chr  "male" "male" "male" "male" ...
#>  $ sweating               : num  0 1 1 1 0 1 1 1 1 1 ...
#>  $ pain.radiation         : num  0 0 0 1 1 0 0 1 0 1 ...
#>  $ pleuritic              : num  0 0 1 0 1 1 0 0 1 0 ...
#>  $ palpation              : num  1 0 0 0 0 1 0 0 1 1 ...
#>  $ ecg.twi                : num  0 1 1 0 0 1 1 0 0 0 ...
#>  $ second_hstni           : num  183 26 112 98 52 27 188 40 20 200 ...
#>  $ killip.class           : num  1 1 1 1 4 2 1 3 1 1 ...
#>  $ systolic.bp            : num  174 238 45 134 184 253 51 63 217 99 ...
#>  $ heart.rate             : num  29 96 166 152 291 208 252 161 189 136 ...
#>  $ creat                  : num  1 3 3 3 1 3 2 1 2 2 ...
#>  $ cardiac.arrest         : num  0 1 0 0 0 1 0 0 1 1 ...
#>  $ previous.pci           : num  1 1 1 0 1 0 1 0 1 1 ...
#>  $ previous.cabg          : num  0 0 0 1 1 0 0 1 0 0 ...
#>  $ aspirin                : num  0 1 1 0 0 1 0 0 0 0 ...
#>  $ number.of.episodes.24h : num  3 2 6 10 4 9 18 10 19 1 ...
#>  $ total.chol             : num  93 60 79 18 34 31 65 44 94 29 ...
#>  $ total.hdl              : num  5 4 4 3 4 4 5 3 5 2 ...
#>  $ Ethnicity              : chr  "black" "asian" "white" "black" ...
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
#> 1           4 Moderate risk           6 Not low risk          23 Low risk     
#> 2           6 Moderate risk          23 Not low risk         102 Moderate risk
#> 3           9 High risk              17 Not low risk         155 High risk    
#> 4           5 Moderate risk          16 Not low risk          59 Low risk     
#> 5           6 Moderate risk           7 Not low risk         112 Moderate risk
#> 6          10 High risk               5 Not low risk         137 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat
#>  Min.   : 2.00   Low risk     : 4   Min.   :-8.00   Low risk    : 1  
#>  1st Qu.: 5.00   Moderate risk:51   1st Qu.: 5.75   Not low risk:99  
#>  Median : 6.00   High risk    :45   Median :10.50                    
#>  Mean   : 6.28                      Mean   :10.57                    
#>  3rd Qu.: 8.00                      3rd Qu.:15.25                    
#>  Max.   :10.00                      Max.   :27.00                    
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 23.00   Low risk     :32   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 80.75   Moderate risk:28   1st Qu.:4.00   Low risk     : 3  
#>  Median :110.50   High risk    :40   Median :4.00   Moderate risk:54  
#>  Mean   :108.73                      Mean   :4.34   High risk    :43  
#>  3rd Qu.:137.00                      3rd Qu.:5.00                     
#>  Max.   :196.00                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.00   Very low risk: 0    Min.   :0.0000   Very low risk: 8  
#>  1st Qu.: 47.00   Low risk     : 3    1st Qu.:0.1700   Low risk     : 3  
#>  Median : 98.50   Moderate risk: 6    Median :0.4600   Moderate risk:17  
#>  Mean   : 74.17   High risk    :91    Mean   :0.4927   High risk    :72  
#>  3rd Qu.:100.00                       3rd Qu.:0.8050                     
#>  Max.   :100.00                       Max.   :1.0000
```
