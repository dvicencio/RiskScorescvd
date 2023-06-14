
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RiskScorescvd

<!-- badges: start -->

[![R-CMD-check](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dvicencio/RiskScorescvd/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of RiskScorescvd is to calculate the most commonly used
cardiovascular risk scores

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
#>  1st Qu.:1.75         1st Qu.:0.00   1st Qu.:0.00       1st Qu.:0.0      
#>  Median :3.00         Median :1.00   Median :1.00       Median :0.5      
#>  Mean   :3.17         Mean   :0.58   Mean   :0.57       Mean   :0.5      
#>  3rd Qu.:5.00         3rd Qu.:1.00   3rd Qu.:1.00       3rd Qu.:1.0      
#>  Max.   :6.00         Max.   :1.00   Max.   :1.00       Max.   :1.0      
#>       Age           diabetes        smoker      hypertension  hyperlipidaemia
#>  Min.   :31.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   
#>  1st Qu.:42.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   
#>  Median :54.00   Median :0.00   Median :0.00   Median :1.00   Median :1.00   
#>  Mean   :54.46   Mean   :0.47   Mean   :0.49   Mean   :0.56   Mean   :0.51   
#>  3rd Qu.:67.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   
#>  Max.   :80.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   
#>  family.history atherosclerotic.disease presentation_hstni    Gender         
#>  Min.   :0.00   Min.   :0.00            Min.   : 10.0      Length:100        
#>  1st Qu.:0.00   1st Qu.:0.00            1st Qu.: 31.5      Class :character  
#>  Median :0.00   Median :1.00            Median : 51.5      Mode  :character  
#>  Mean   :0.49   Mean   :0.52            Mean   : 52.9                        
#>  3rd Qu.:1.00   3rd Qu.:1.00            3rd Qu.: 75.0                        
#>  Max.   :1.00   Max.   :1.00            Max.   :100.0                        
#>     sweating    pain.radiation   pleuritic      palpation       ecg.twi    
#>  Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00  
#>  1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00  
#>  Median :0.00   Median :0.00   Median :1.00   Median :0.00   Median :0.00  
#>  Mean   :0.46   Mean   :0.47   Mean   :0.53   Mean   :0.43   Mean   :0.44  
#>  3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00  
#>  Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00  
#>   second_hstni     killip.class   systolic.bp      heart.rate    
#>  Min.   :  2.00   Min.   :1.00   Min.   : 13.0   Min.   :  3.00  
#>  1st Qu.: 46.75   1st Qu.:2.00   1st Qu.: 64.5   1st Qu.: 66.75  
#>  Median : 99.50   Median :2.50   Median :122.5   Median :123.50  
#>  Mean   : 96.68   Mean   :2.61   Mean   :132.0   Mean   :141.86  
#>  3rd Qu.:146.25   3rd Qu.:4.00   3rd Qu.:180.8   3rd Qu.:221.25  
#>  Max.   :198.00   Max.   :4.00   Max.   :294.0   Max.   :293.00  
#>      creat      cardiac.arrest  previous.pci  previous.cabg     aspirin    
#>  Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00  
#>  1st Qu.:1.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00  
#>  Median :2.00   Median :0.00   Median :1.00   Median :1.00   Median :1.00  
#>  Mean   :2.16   Mean   :0.47   Mean   :0.55   Mean   :0.53   Mean   :0.51  
#>  3rd Qu.:3.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00  
#>  Max.   :4.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00  
#>  number.of.episodes.24h   total.chol       total.hdl     Ethnicity        
#>  Min.   : 0.00          Min.   :  5.00   Min.   :2.00   Length:100        
#>  1st Qu.: 6.75          1st Qu.: 34.00   1st Qu.:3.00   Class :character  
#>  Median :12.00          Median : 56.00   Median :4.00   Mode  :character  
#>  Mean   :10.98          Mean   : 53.91   Mean   :3.59                     
#>  3rd Qu.:15.00          3rd Qu.: 74.25   3rd Qu.:5.00                     
#>  Max.   :20.00          Max.   :100.00   Max.   :5.00                     
#>   HEART_score     EDACS_score     GRACE_score      TIMI_score  
#>  Min.   : 3.00   Min.   :-4.00   Min.   : 28.0   Min.   :2.00  
#>  1st Qu.: 5.00   1st Qu.: 4.00   1st Qu.: 91.0   1st Qu.:3.00  
#>  Median : 6.00   Median : 9.50   Median :118.5   Median :4.00  
#>  Mean   : 6.24   Mean   : 9.67   Mean   :119.5   Mean   :4.26  
#>  3rd Qu.: 7.00   3rd Qu.:15.25   3rd Qu.:150.5   3rd Qu.:5.00  
#>  Max.   :10.00   Max.   :25.00   Max.   :218.0   Max.   :7.00  
#>   ASCVD_score      SCORE2_score           HEART_strat       EDACS_strat
#>  Min.   :0.0000   Min.   :  0.00   Low risk     : 5   Low risk    : 1  
#>  1st Qu.:0.0500   1st Qu.: 19.00   Moderate risk:51   Not low risk:99  
#>  Median :0.2400   Median : 96.50   High risk    :44                    
#>  Mean   :0.3936   Mean   : 66.71                                       
#>  3rd Qu.:0.7400   3rd Qu.:100.00                                       
#>  Max.   :1.0000   Max.   :100.00                                       
#>         GRACE_strat         TIMI_strat        ASCVD_strat        SCORE2_strat
#>  Low risk     :20   Very low risk: 0   Very low risk:24   Very low risk: 0   
#>  Moderate risk:29   Low risk     : 9   Low risk     : 9   Low risk     : 9   
#>  High risk    :51   Moderate risk:47   Moderate risk:12   Moderate risk: 8   
#>                     High risk    :44   High risk    :55   High risk    :83   
#>                                                                              
#> 
```
