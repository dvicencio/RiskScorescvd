
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

This is a basic example which shows you how to solve a common problem:

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


 # Call the function with the cohort_xx

 new_data_frame <- calc_scores(data = cohort_xx)
 
 summary(new_data_frame)
#>  typical_symptoms.num   ecg.normal   abn.repolarisation ecg.st.depression
#>  Min.   :0.00         Min.   :0.00   Min.   :0.00       Min.   :0.0      
#>  1st Qu.:1.00         1st Qu.:0.00   1st Qu.:0.00       1st Qu.:0.0      
#>  Median :3.00         Median :0.00   Median :1.00       Median :0.5      
#>  Mean   :3.06         Mean   :0.43   Mean   :0.53       Mean   :0.5      
#>  3rd Qu.:5.00         3rd Qu.:1.00   3rd Qu.:1.00       3rd Qu.:1.0      
#>  Max.   :6.00         Max.   :1.00   Max.   :1.00       Max.   :1.0      
#>       Age           diabetes        smoker      hypertension  hyperlipidaemia
#>  Min.   :30.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   
#>  1st Qu.:40.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   
#>  Median :54.50   Median :1.00   Median :0.00   Median :1.00   Median :1.00   
#>  Mean   :53.67   Mean   :0.58   Mean   :0.47   Mean   :0.56   Mean   :0.55   
#>  3rd Qu.:65.25   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   
#>  Max.   :78.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   
#>  family.history atherosclerotic.disease presentation_hstni    Gender         
#>  Min.   :0.00   Min.   :0.00            Min.   :12.00      Length:100        
#>  1st Qu.:0.00   1st Qu.:0.00            1st Qu.:33.00      Class :character  
#>  Median :0.00   Median :1.00            Median :57.00      Mode  :character  
#>  Mean   :0.47   Mean   :0.53            Mean   :53.82                        
#>  3rd Qu.:1.00   3rd Qu.:1.00            3rd Qu.:71.25                        
#>  Max.   :1.00   Max.   :1.00            Max.   :98.00                        
#>     sweating    pain.radiation   pleuritic      palpation       ecg.twi    
#>  Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00  
#>  1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00  
#>  Median :0.00   Median :0.00   Median :1.00   Median :0.00   Median :0.00  
#>  Mean   :0.41   Mean   :0.47   Mean   :0.54   Mean   :0.48   Mean   :0.47  
#>  3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00  
#>  Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00  
#>   second_hstni    killip.class   systolic.bp      heart.rate        creat     
#>  Min.   :  3.0   Min.   :1.00   Min.   :  1.0   Min.   :  5.0   Min.   :0.00  
#>  1st Qu.: 42.0   1st Qu.:1.00   1st Qu.: 67.5   1st Qu.: 77.5   1st Qu.:1.00  
#>  Median : 91.0   Median :2.00   Median :161.5   Median :153.5   Median :2.00  
#>  Mean   : 94.4   Mean   :2.37   Mean   :155.4   Mean   :148.2   Mean   :2.01  
#>  3rd Qu.:137.5   3rd Qu.:3.00   3rd Qu.:237.2   3rd Qu.:213.0   3rd Qu.:3.00  
#>  Max.   :200.0   Max.   :4.00   Max.   :298.0   Max.   :300.0   Max.   :4.00  
#>  cardiac.arrest  previous.pci  previous.cabg     aspirin    
#>  Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00  
#>  1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00  
#>  Median :1.00   Median :0.00   Median :0.00   Median :0.00  
#>  Mean   :0.57   Mean   :0.49   Mean   :0.48   Mean   :0.46  
#>  3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00  
#>  Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00  
#>  number.of.episodes.24h   total.chol       total.hdl     Ethnicity        
#>  Min.   : 0.00          Min.   :  6.00   Min.   :2.00   Length:100        
#>  1st Qu.: 4.00          1st Qu.: 34.00   1st Qu.:2.75   Class :character  
#>  Median : 9.50          Median : 57.00   Median :4.00   Mode  :character  
#>  Mean   : 9.62          Mean   : 56.16   Mean   :3.58                     
#>  3rd Qu.:15.00          3rd Qu.: 79.00   3rd Qu.:5.00                     
#>  Max.   :20.00          Max.   :100.00   Max.   :5.00                     
#>   HEART_score    EDACS_score     GRACE_score      TIMI_score    ASCVD_score    
#>  Min.   : 3.0   Min.   :-8.00   Min.   : 13.0   Min.   :2.00   Min.   :0.0000  
#>  1st Qu.: 5.0   1st Qu.: 4.00   1st Qu.: 85.0   1st Qu.:3.00   1st Qu.:0.1175  
#>  Median : 6.0   Median : 9.00   Median :111.0   Median :4.00   Median :0.4000  
#>  Mean   : 6.4   Mean   : 9.26   Mean   :110.7   Mean   :4.23   Mean   :0.4423  
#>  3rd Qu.: 7.0   3rd Qu.:14.00   3rd Qu.:139.0   3rd Qu.:5.00   3rd Qu.:0.7825  
#>  Max.   :10.0   Max.   :24.00   Max.   :203.0   Max.   :6.00   Max.   :1.0000  
#>   SCORE2_score           HEART_strat       EDACS_strat         GRACE_strat
#>  Min.   :  0.00   Low risk     : 1   Low risk    :  0   Low risk     :27  
#>  1st Qu.: 35.00   Moderate risk:53   Not low risk:100   Moderate risk:28  
#>  Median : 99.00   High risk    :46                      High risk    :45  
#>  Mean   : 71.21                                                           
#>  3rd Qu.:100.00                                                           
#>  Max.   :100.00                                                           
#>          TIMI_strat        ASCVD_strat        SCORE2_strat
#>  Very low risk: 0   Very low risk:17   Very low risk: 0   
#>  Low risk     : 8   Low risk     : 3   Low risk     : 7   
#>  Moderate risk:49   Moderate risk:14   Moderate risk: 8   
#>  High risk    :43   High risk    :66   High risk    :85   
#>                                                           
#> 
```
