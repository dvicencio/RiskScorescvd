
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

  str(cohort_xx)
#> 'data.frame':    100 obs. of  31 variables:
#>  $ typical_symptoms.num   : num  3 2 1 1 4 3 3 0 2 3 ...
#>  $ ecg.normal             : num  0 0 0 1 0 1 1 1 0 1 ...
#>  $ abn.repolarisation     : num  1 1 0 1 1 1 0 0 1 0 ...
#>  $ ecg.st.depression      : num  0 0 1 1 1 1 1 1 0 1 ...
#>  $ Age                    : num  76 50 53 39 54 72 69 44 74 55 ...
#>  $ diabetes               : num  0 1 0 0 1 1 1 0 1 1 ...
#>  $ smoker                 : num  1 1 1 1 0 1 0 1 1 1 ...
#>  $ hypertension           : num  1 0 0 1 0 1 0 0 1 0 ...
#>  $ hyperlipidaemia        : num  1 0 0 1 1 1 1 0 1 0 ...
#>  $ family.history         : num  0 0 0 1 1 0 1 1 0 0 ...
#>  $ atherosclerotic.disease: num  0 1 0 0 0 1 1 1 0 0 ...
#>  $ presentation_hstni     : num  74 35 88 16 29 46 74 16 60 17 ...
#>  $ Gender                 : chr  "male" "female" "female" "female" ...
#>  $ sweating               : num  1 1 0 0 1 1 0 0 0 1 ...
#>  $ pain.radiation         : num  1 0 0 1 0 1 0 0 0 1 ...
#>  $ pleuritic              : num  1 1 1 1 0 1 0 1 0 1 ...
#>  $ palpation              : num  0 0 1 0 1 1 0 0 1 1 ...
#>  $ ecg.twi                : num  0 0 0 0 1 0 0 1 1 0 ...
#>  $ second_hstni           : num  54 9 20 77 164 20 189 52 112 59 ...
#>  $ killip.class           : num  2 3 4 4 3 2 2 1 4 4 ...
#>  $ systolic.bp            : num  12 32 62 1 65 141 100 230 223 111 ...
#>  $ heart.rate             : num  186 95 258 38 202 88 213 266 128 30 ...
#>  $ creat                  : num  4 2 1 2 4 2 3 1 3 1 ...
#>  $ cardiac.arrest         : num  1 0 1 1 1 1 1 1 1 0 ...
#>  $ previous.pci           : num  1 1 1 0 1 0 1 1 1 0 ...
#>  $ previous.cabg          : num  0 0 1 1 0 1 0 1 0 0 ...
#>  $ aspirin                : num  1 1 1 0 0 0 1 1 0 1 ...
#>  $ number.of.episodes.24h : num  18 12 15 1 10 5 3 6 11 11 ...
#>  $ total.chol             : num  44 98 71 95 86 38 85 41 51 42 ...
#>  $ total.hdl              : num  2 2 3 2 2 3 3 2 5 4 ...
#>  $ Ethnicity              : chr  "white" "other" "white" "white" ...
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
#> 1           7 High risk              26 Not low risk         176 High risk    
#> 2           6 Moderate risk           3 Not low risk         116 Moderate risk
#> 3           6 Moderate risk          -4 Not low risk         180 High risk    
#> 4           5 Moderate risk           7 Not low risk         121 High risk    
#> 5           7 High risk               3 Not low risk         167 High risk    
#> 6           8 High risk              12 Not low risk         137 High risk    
#> # ℹ 6 more variables: TIMI_score <dbl>, TIMI_strat <ord>, SCORE2_score <dbl>,
#> #   SCORE2_strat <ord>, ASCVD_score <dbl>, ASCVD_strat <ord>

# Create a summary of them to obtain an initial idea of distribution
summary(All_scores)
#>   HEART_score          HEART_strat  EDACS_score          EDACS_strat
#>  Min.   :4.00   Low risk     : 0   Min.   :-4.00   Low risk    : 1  
#>  1st Qu.:5.75   Moderate risk:49   1st Qu.: 4.00   Not low risk:99  
#>  Median :7.00   High risk    :51   Median : 9.00                    
#>  Mean   :6.52                      Mean   : 9.85                    
#>  3rd Qu.:7.25                      3rd Qu.:15.00                    
#>  Max.   :9.00                      Max.   :30.00                    
#>                                                                     
#>   GRACE_score            GRACE_strat   TIMI_score           TIMI_strat
#>  Min.   : 20.00   Low risk     :20   Min.   :2.00   Very low risk: 0  
#>  1st Qu.: 93.75   Moderate risk:27   1st Qu.:4.00   Low risk     : 5  
#>  Median :120.50   High risk    :53   Median :5.00   Moderate risk:44  
#>  Mean   :122.40                      Mean   :4.43   High risk    :51  
#>  3rd Qu.:151.25                      3rd Qu.:5.00                     
#>  Max.   :201.00                      Max.   :7.00                     
#>                                                                       
#>   SCORE2_score          SCORE2_strat  ASCVD_score            ASCVD_strat
#>  Min.   :  0.0   Very low risk: 0    Min.   :0.0000   Very low risk:25  
#>  1st Qu.: 23.0   Low risk     : 8    1st Qu.:0.0450   Low risk     : 3  
#>  Median : 88.5   Moderate risk: 4    Median :0.2900   Moderate risk:15  
#>  Mean   : 66.6   High risk    :88    Mean   :0.3812   High risk    :56  
#>  3rd Qu.:100.0                       3rd Qu.:0.7000   NA's         : 1  
#>  Max.   :100.0                       Max.   :1.0000                     
#>                                      NA's   :1
```
