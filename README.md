
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
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
#>  $ typical_symptoms.num   : num  6 0 3 3 0 0 4 6 3 3 ...
#>  $ ecg.normal             : num  0 1 1 1 1 0 0 1 1 0 ...
#>  $ abn.repolarisation     : num  0 0 0 0 1 0 1 1 1 1 ...
#>  $ ecg.st.depression      : num  0 1 1 0 0 0 1 1 1 1 ...
#>  $ Age                    : num  36 45 44 47 48 30 43 64 45 40 ...
#>  $ diabetes               : num  1 1 0 1 1 0 0 1 1 0 ...
#>  $ smoker                 : num  0 1 1 1 0 0 0 1 1 1 ...
#>  $ hypertension           : num  1 0 0 1 0 0 0 1 0 1 ...
#>  $ hyperlipidaemia        : num  0 1 1 0 1 0 1 1 1 0 ...
#>  $ family.history         : num  0 1 1 0 1 0 1 0 0 1 ...
#>  $ atherosclerotic.disease: num  0 1 1 1 0 0 0 1 0 1 ...
#>  $ presentation_hstni     : num  69 19 89 52 95 46 97 45 18 34 ...
#>  $ Gender                 : chr  "female" "female" "female" "male" ...
#>  $ sweating               : num  1 0 1 0 1 0 1 0 1 1 ...
#>  $ pain.radiation         : num  1 0 1 0 1 1 1 1 0 0 ...
#>  $ pleuritic              : num  0 1 0 0 1 1 0 1 0 0 ...
#>  $ palpation              : num  0 1 1 0 1 1 0 1 1 0 ...
#>  $ ecg.twi                : num  1 0 0 0 0 0 0 0 1 0 ...
#>  $ second_hstni           : num  28 85 76 192 49 33 25 80 49 171 ...
#>  $ killip.class           : num  1 1 1 3 2 4 2 3 1 3 ...
#>  $ systolic.bp            : num  118 99 78 129 88 250 139 185 231 88 ...
#>  $ heart.rate             : num  59 38 198 87 294 14 64 69 210 149 ...
#>  $ creat                  : num  1 2 1 3 0 3 1 1 0 1 ...
#>  $ cardiac.arrest         : num  1 1 1 1 0 0 0 1 0 0 ...
#>  $ previous.pci           : num  1 1 1 1 1 0 1 1 0 1 ...
#>  $ previous.cabg          : num  0 1 0 0 0 1 0 1 0 1 ...
#>  $ aspirin                : num  1 1 1 0 0 0 0 1 1 0 ...
#>  $ number.of.episodes.24h : num  16 3 5 19 11 3 11 7 12 12 ...
#>  $ total.chol             : num  96 62 72 59 99 23 74 70 82 25 ...
#>  $ total.hdl              : num  2 3 3 5 3 3 4 5 3 3 ...
#>  $ Ethnicity              : chr  "asian" "white" "white" "asian" ...
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
#> 1           6 Moderate risk          10 Not low risk          43 Low risk     
#> 2           6 Moderate risk          -4 Not low risk          82 Low risk     
#> 3           7 High risk               8 Not low risk         123 High risk    
#> 4           5 Moderate risk          14 Not low risk          92 Moderate risk
#> 5           6 Moderate risk           6 Not low risk         123 High risk    
#> 6           2 Low risk                3 Not low risk          57 Low risk     
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 2.00   Low risk     : 5   Min.   :-6.00   Low risk    :  0  
#>  1st Qu.: 5.00   Moderate risk:55   1st Qu.: 5.00   Not low risk:100  
#>  Median : 6.00   High risk    :40   Median : 9.50                     
#>  Mean   : 6.28                      Mean   : 9.53                     
#>  3rd Qu.: 7.00                      3rd Qu.:14.25                     
#>  Max.   :10.00                      Max.   :27.00                     
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 18.00   Low risk     :33   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 78.75   Moderate risk:26   1st Qu.:3.75   Low risk     :10  
#>  Median :110.00   High risk    :41   Median :4.00   Moderate risk:47  
#>  Mean   :108.67                      Mean   :4.26   High risk    :43  
#>  3rd Qu.:135.00                      3rd Qu.:5.00                     
#>  Max.   :223.00                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.00   Very low risk: 0    Min.   :0.0000   Very low risk:10  
#>  1st Qu.: 46.75   Low risk     : 7    1st Qu.:0.1675   Low risk     : 2  
#>  Median : 97.50   Moderate risk: 6    Median :0.3800   Moderate risk:17  
#>  Mean   : 71.16   High risk    :87    Mean   :0.4477   High risk    :71  
#>  3rd Qu.:100.00                       3rd Qu.:0.7350                     
#>  Max.   :100.00                       Max.   :1.0000
```
