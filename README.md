
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
#>  $ typical_symptoms.num   : num  5 4 4 2 3 1 5 5 6 1 ...
#>  $ ecg.normal             : num  1 0 0 1 0 1 0 0 0 0 ...
#>  $ abn.repolarisation     : num  0 1 1 1 0 1 1 0 1 1 ...
#>  $ ecg.st.depression      : num  1 0 0 0 1 0 1 0 1 0 ...
#>  $ Age                    : num  44 52 37 78 69 37 50 65 53 53 ...
#>  $ diabetes               : num  0 1 1 1 0 0 0 0 1 1 ...
#>  $ smoker                 : num  1 0 0 0 1 0 1 0 0 1 ...
#>  $ hypertension           : num  1 0 0 0 1 0 1 1 1 1 ...
#>  $ hyperlipidaemia        : num  1 0 0 0 1 0 1 1 0 0 ...
#>  $ family.history         : num  0 1 1 0 0 1 1 1 0 1 ...
#>  $ atherosclerotic.disease: num  0 0 0 1 0 1 0 1 1 1 ...
#>  $ presentation_hstni     : num  27 74 65 34 46 93 35 24 56 93 ...
#>  $ Gender                 : chr  "female" "male" "female" "male" ...
#>  $ sweating               : num  1 0 0 1 1 0 0 1 0 1 ...
#>  $ pain.radiation         : num  0 0 0 0 0 1 1 0 0 0 ...
#>  $ pleuritic              : num  0 1 0 0 0 0 1 1 0 1 ...
#>  $ palpation              : num  0 1 1 0 1 0 0 1 1 0 ...
#>  $ ecg.twi                : num  1 1 1 1 1 0 0 1 1 0 ...
#>  $ second_hstni           : num  160 3 115 69 88 141 64 119 76 47 ...
#>  $ killip.class           : num  1 2 3 1 4 1 2 4 2 3 ...
#>  $ systolic.bp            : num  265 286 92 133 155 91 63 241 141 175 ...
#>  $ heart.rate             : num  167 29 66 80 196 106 52 283 278 38 ...
#>  $ creat                  : num  3 4 4 4 0 0 2 2 3 1 ...
#>  $ cardiac.arrest         : num  1 1 1 1 1 0 1 1 0 0 ...
#>  $ previous.pci           : num  1 0 1 0 1 0 0 0 0 0 ...
#>  $ previous.cabg          : num  1 1 0 0 1 0 1 0 1 1 ...
#>  $ aspirin                : num  1 0 1 0 0 1 0 0 0 0 ...
#>  $ number.of.episodes.24h : num  12 8 8 11 19 17 6 2 6 4 ...
#>  $ total.chol             : num  68 42 50 55 54 86 88 90 40 91 ...
#>  $ total.hdl              : num  4 5 5 3 2 5 5 2 3 3 ...
#>  $ Ethnicity              : chr  "black" "white" "black" "white" ...
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
#> 1           7 High risk               9 Not low risk          73 Low risk     
#> 2           5 Moderate risk           2 Not low risk          59 Low risk     
#> 3           5 Moderate risk          -4 Not low risk          82 Low risk     
#> 4           7 High risk              25 Not low risk         118 Moderate risk
#> 5           8 High risk               9 Not low risk         187 High risk    
#> 6           4 Moderate risk          13 Not low risk          63 Low risk     
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score          HEART_strat  EDACS_score          EDACS_strat
#>  Min.   :2.00   Low risk     : 6   Min.   :-4.00   Low risk    : 1  
#>  1st Qu.:5.00   Moderate risk:48   1st Qu.: 5.75   Not low risk:99  
#>  Median :6.00   High risk    :46   Median :11.00                    
#>  Mean   :6.15                      Mean   :11.19                    
#>  3rd Qu.:7.00                      3rd Qu.:17.00                    
#>  Max.   :9.00                      Max.   :28.00                    
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 30.00   Low risk     :30   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 82.75   Moderate risk:24   1st Qu.:4.00   Low risk     : 2  
#>  Median :114.50   High risk    :46   Median :4.00   Moderate risk:52  
#>  Mean   :115.03                      Mean   :4.36   High risk    :46  
#>  3rd Qu.:145.25                      3rd Qu.:5.00                     
#>  Max.   :197.00                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.00   Very low risk: 0    Min.   :0.0000   Very low risk:10  
#>  1st Qu.: 39.50   Low risk     : 7    1st Qu.:0.2450   Low risk     : 5  
#>  Median : 99.50   Moderate risk: 4    Median :0.4750   Moderate risk: 8  
#>  Mean   : 73.83   High risk    :89    Mean   :0.5284   High risk    :77  
#>  3rd Qu.:100.00                       3rd Qu.:0.8450                     
#>  Max.   :100.00                       Max.   :1.0000
```
