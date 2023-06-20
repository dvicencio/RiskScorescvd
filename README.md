
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
#> 1                    1          1                  1                 0  35
#> 2                    5          1                  1                 1  32
#> 3                    5          0                  1                 0  50
#> 4                    5          1                  0                 0  72
#> 5                    4          1                  1                 0  57
#> 6                    4          0                  1                 0  34
#>   diabetes smoker hypertension hyperlipidaemia family.history
#> 1        0      1            1               0              1
#> 2        0      1            0               0              0
#> 3        0      0            1               1              1
#> 4        1      1            0               1              0
#> 5        0      1            0               1              0
#> 6        0      0            1               0              0
#>   atherosclerotic.disease presentation_hstni Gender sweating pain.radiation
#> 1                       1                 28 female        1              0
#> 2                       0                 88   male        1              1
#> 3                       0                 53 female        0              0
#> 4                       1                 21   male        1              0
#> 5                       0                 52   male        0              1
#> 6                       1                 31 female        1              1
#>   pleuritic palpation ecg.twi second_hstni killip.class systolic.bp heart.rate
#> 1         1         0       0           61            4         216        128
#> 2         1         1       1          132            3         286        206
#> 3         0         0       0            3            2         252        188
#> 4         1         0       0          175            2         271        140
#> 5         0         1       0          105            1         212         54
#> 6         0         1       1           88            4         184        300
#>   creat cardiac.arrest previous.pci previous.cabg aspirin
#> 1     1              0            1             1       1
#> 2     2              0            1             0       0
#> 3     1              0            0             1       1
#> 4     3              0            1             1       1
#> 5     2              0            1             0       1
#> 6     1              1            1             0       1
#>   number.of.episodes.24h total.chol total.hdl Ethnicity
#> 1                     11         36         3     asian
#> 2                     12         67         5     asian
#> 3                      9          6         3     black
#> 4                      2         85         5     asian
#> 5                     20         42         5     white
#> 6                      2         82         2     black
```

``` r
# Call the function with the cohort_xx

 new_data_frame <- calc_scores(data = cohort_xx)
 
All_scores <- new_data_frame %>% select(HEART_score, HEART_strat, EDACS_score, EDACS_strat, GRACE_score, GRACE_strat, TIMI_score, TIMI_strat, SCORE2_score, SCORE2_strat, ASCVD_score, ASCVD_strat)

head(All_scores)
#> # A tibble: 6 × 12
#> # Rowwise: 
#>   HEART_score HEART_strat   EDACS_score EDACS_strat  GRACE_score GRACE_strat  
#>         <dbl> <ord>               <dbl> <ord>              <dbl> <ord>        
#> 1           4 Moderate risk           5 Not low risk          72 Low risk     
#> 2           6 Moderate risk           6 Not low risk          93 Moderate risk
#> 3           8 High risk               8 Not low risk          88 Moderate risk
#> 4           6 Moderate risk          19 Not low risk         101 Moderate risk
#> 5           5 Moderate risk          13 Not low risk          53 Low risk     
#> 6           5 Moderate risk           4 Not low risk          97 Moderate risk
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

summary(All_scores)
#>   HEART_score           HEART_strat  EDACS_score          EDACS_strat 
#>  Min.   : 3.00   Low risk     : 5   Min.   :-4.00   Low risk    :  0  
#>  1st Qu.: 5.00   Moderate risk:63   1st Qu.: 4.00   Not low risk:100  
#>  Median : 6.00   High risk    :32   Median : 9.00                     
#>  Mean   : 5.99                      Mean   : 8.99                     
#>  3rd Qu.: 7.00                      3rd Qu.:14.00                     
#>  Max.   :10.00                      Max.   :23.00                     
#>   GRACE_score           GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 20.0   Low risk     :32   Min.   :1.00   Very low risk: 0  
#>  1st Qu.: 79.0   Moderate risk:26   1st Qu.:4.00   Low risk     : 9  
#>  Median :107.0   High risk    :42   Median :4.00   Moderate risk:45  
#>  Mean   :110.3                      Mean   :4.27   High risk    :46  
#>  3rd Qu.:136.2                      3rd Qu.:5.00                     
#>  Max.   :217.0                      Max.   :7.00                     
#>   SCORE2_score           SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  1.00   Very low risk: 0    Min.   :0.0000   Very low risk:12  
#>  1st Qu.: 25.75   Low risk     : 5    1st Qu.:0.1350   Low risk     : 7  
#>  Median : 98.00   Moderate risk: 5    Median :0.3100   Moderate risk:14  
#>  Mean   : 70.27   High risk    :90    Mean   :0.4354   High risk    :67  
#>  3rd Qu.:100.00                       3rd Qu.:0.7850                     
#>  Max.   :100.00                       Max.   :1.0000
```
