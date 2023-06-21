
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

## Example

This is a basic example of how the data set should look to calculate all
risk scores available in the package:

``` r
library(RiskScorescvd)
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
#> Loading required package: PooledCohort
# Create a data frame or list with the necessary variables
 # Set the number of rows
 num_rows <- 100
 
 # Create a larger dataset with 100 rows
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
#>  $ typical_symptoms.num   : num  5 0 0 4 2 2 4 1 0 0 ...
#>  $ ecg.normal             : num  1 0 0 0 0 0 1 1 0 0 ...
#>  $ abn.repolarisation     : num  1 0 0 0 0 1 0 1 1 1 ...
#>  $ ecg.st.depression      : num  1 0 0 0 1 1 0 0 1 0 ...
#>  $ Age                    : num  76 53 64 71 58 35 56 79 50 79 ...
#>  $ diabetes               : num  1 0 0 1 1 1 0 0 0 1 ...
#>  $ smoker                 : num  0 0 1 0 1 0 0 0 1 0 ...
#>  $ hypertension           : num  1 1 0 0 0 0 0 0 1 1 ...
#>  $ hyperlipidaemia        : num  1 0 0 1 1 1 0 0 1 1 ...
#>  $ family.history         : num  0 0 1 0 1 0 0 0 1 0 ...
#>  $ atherosclerotic.disease: num  0 1 1 1 1 0 1 1 1 1 ...
#>  $ presentation_hstni     : num  10 69 70 78 65 95 39 11 92 34 ...
#>  $ Gender                 : chr  "male" "male" "female" "male" ...
#>  $ sweating               : num  1 0 1 1 0 0 0 0 1 0 ...
#>  $ pain.radiation         : num  1 0 0 1 0 1 0 0 0 1 ...
#>  $ pleuritic              : num  1 0 1 0 0 1 0 1 0 0 ...
#>  $ palpation              : num  1 1 1 1 1 1 0 0 1 0 ...
#>  $ ecg.twi                : num  0 1 0 0 0 1 1 1 1 0 ...
#>  $ second_hstni           : num  77 190 99 123 6 192 85 157 48 132 ...
#>  $ killip.class           : num  1 1 2 2 3 1 1 1 2 4 ...
#>  $ systolic.bp            : num  64 48 115 204 174 201 177 267 120 64 ...
#>  $ heart.rate             : num  108 135 135 155 287 126 35 224 60 194 ...
#>  $ creat                  : num  0 2 4 2 1 1 4 1 3 1 ...
#>  $ cardiac.arrest         : num  1 0 0 0 0 1 1 1 0 1 ...
#>  $ previous.pci           : num  1 1 0 0 0 0 0 1 0 1 ...
#>  $ previous.cabg          : num  0 1 1 1 0 1 1 1 0 0 ...
#>  $ aspirin                : num  0 1 0 0 0 1 1 1 1 0 ...
#>  $ number.of.episodes.24h : num  0 6 7 4 16 8 19 17 13 1 ...
#>  $ total.chol             : num  71 8 12 76 36 39 37 72 92 50 ...
#>  $ total.hdl              : num  2 3 5 2 2 5 5 5 2 4 ...
#>  $ Ethnicity              : chr  "white" "white" "black" "black" ...
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
#> 1           8 High risk              20 Not low risk         141 High risk    
#> 2           5 Moderate risk           6 Not low risk         103 Moderate risk
#> 3           6 Moderate risk           3 Not low risk         127 High risk    
#> 4           7 High risk              22 Not low risk         117 Moderate risk
#> 5           8 High risk               2 Not low risk         144 High risk    
#> 6           6 Moderate risk          -3 Not low risk          45 Low risk     
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 2.00   Low risk     : 7   Min.   :-8.00   Low risk    :  0  
#>  1st Qu.: 5.00   Moderate risk:46   1st Qu.: 6.00   Not low risk:100  
#>  Median : 6.00   High risk    :47   Median :10.00                     
#>  Mean   : 6.31                      Mean   :11.02                     
#>  3rd Qu.: 8.00                      3rd Qu.:16.00                     
#>  Max.   :10.00                      Max.   :27.00                     
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 31.00   Low risk     :24   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 90.75   Moderate risk:36   1st Qu.:3.00   Low risk     : 3  
#>  Median :110.50   High risk    :40   Median :4.00   Moderate risk:56  
#>  Mean   :113.47                      Mean   :4.25   High risk    :41  
#>  3rd Qu.:137.50                      3rd Qu.:5.00                     
#>  Max.   :212.00                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  1.00   Very low risk: 0    Min.   :0.0100   Very low risk: 7  
#>  1st Qu.: 30.50   Low risk     : 6    1st Qu.:0.1700   Low risk     : 6  
#>  Median : 96.00   Moderate risk: 9    Median :0.4000   Moderate risk:14  
#>  Mean   : 68.66   High risk    :85    Mean   :0.4705   High risk    :73  
#>  3rd Qu.:100.00                       3rd Qu.:0.7800                     
#>  Max.   :100.00                       Max.   :1.0000
```
