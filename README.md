
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of RiskScorescvd r package is to calculate the most commonly
used cardiovascular risk scores

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
   systolic.bp = as.numeric(sample(0:300, num_rows, replace = TRUE)),
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

  head(cohort_xx)
#>   typical_symptoms.num ecg.normal abn.repolarisation ecg.st.depression Age
#> 1                    2          0                  0                 0  58
#> 2                    3          0                  1                 0  41
#> 3                    4          1                  1                 0  73
#> 4                    4          1                  0                 0  63
#> 5                    2          0                  0                 1  53
#> 6                    6          1                  0                 0  54
#>   diabetes smoker hypertension hyperlipidaemia family.history
#> 1        0      0            1               1              0
#> 2        0      1            0               0              1
#> 3        0      0            0               1              1
#> 4        0      1            0               0              1
#> 5        0      0            1               1              0
#> 6        1      1            1               0              1
#>   atherosclerotic.disease presentation_hstni Gender sweating pain.radiation
#> 1                       0                 74 female        1              0
#> 2                       0                 71 female        1              1
#> 3                       0                 76   male        1              1
#> 4                       0                 10   male        1              1
#> 5                       0                 64 female        1              1
#> 6                       0                 94 female        0              1
#>   pleuritic palpation ecg.twi second_hstni killip.class systolic.bp heart.rate
#> 1         1         0       0           24            2         192        126
#> 2         0         1       1          198            3          31        163
#> 3         0         0       0          146            3          24         93
#> 4         1         0       1           52            4         160        122
#> 5         0         1       1           25            1          43         11
#> 6         1         1       0          158            2          66        132
#>   creat cardiac.arrest previous.pci previous.cabg aspirin
#> 1     2              0            0             0       1
#> 2     3              1            0             0       0
#> 3     0              1            1             1       1
#> 4     2              1            0             1       0
#> 5     2              0            0             1       0
#> 6     0              1            0             1       1
#>   number.of.episodes.24h total.chol total.hdl Ethnicity
#> 1                     11         70         3     asian
#> 2                      1         75         2     white
#> 3                     10        100         5     black
#> 4                     16         65         2     asian
#> 5                     15         54         4     other
#> 6                      6          8         3     other
```

``` r
# Call the function with the cohort_xx to calculate all risk scores available in the package

new_data_frame <- calc_scores(data = cohort_xx)
 
All_scores <- new_data_frame %>% select(HEART_score, HEART_strat, EDACS_score, EDACS_strat, GRACE_score, GRACE_strat, TIMI_score, TIMI_strat, SCORE2_score, SCORE2_strat, ASCVD_score, ASCVD_strat)

head(All_scores)
#> # A tibble: 6 × 12
#> # Rowwise: 
#>   HEART_score HEART_strat   EDACS_score EDACS_strat  GRACE_score GRACE_strat  
#>         <dbl> <ord>               <dbl> <ord>              <dbl> <ord>        
#> 1           6 Moderate risk           7 Not low risk          88 Low risk     
#> 2           5 Moderate risk           4 Not low risk         119 High risk    
#> 3           6 Moderate risk          28 Not low risk         157 High risk    
#> 4           3 Low risk               20 Not low risk         122 High risk    
#> 5           7 High risk               8 Not low risk         103 Moderate risk
#> 6           7 High risk               1 Not low risk         119 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

summary(All_scores)
#>   HEART_score         HEART_strat  EDACS_score          EDACS_strat
#>  Min.   :3.0   Low risk     : 5   Min.   :-8.00   Low risk    : 2  
#>  1st Qu.:5.0   Moderate risk:61   1st Qu.: 5.00   Not low risk:98  
#>  Median :6.0   High risk    :34   Median : 8.00                    
#>  Mean   :5.9                      Mean   : 9.75                    
#>  3rd Qu.:7.0                      3rd Qu.:15.00                    
#>  Max.   :9.0                      Max.   :30.00                    
#>   GRACE_score           GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 13.0   Low risk     :31   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 85.0   Moderate risk:24   1st Qu.:3.00   Low risk     : 9  
#>  Median :113.0   High risk    :45   Median :4.00   Moderate risk:56  
#>  Mean   :113.3                      Mean   :4.11   High risk    :35  
#>  3rd Qu.:146.2                      3rd Qu.:5.00                     
#>  Max.   :204.0                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.00   Very low risk: 0    Min.   :0.0000   Very low risk:21  
#>  1st Qu.: 24.00   Low risk     : 9    1st Qu.:0.0700   Low risk     : 5  
#>  Median :100.00   Moderate risk: 6    Median :0.3300   Moderate risk:14  
#>  Mean   : 69.74   High risk    :85    Mean   :0.4161   High risk    :60  
#>  3rd Qu.:100.00                       3rd Qu.:0.7800                     
#>  Max.   :100.00                       Max.   :1.0000
```
