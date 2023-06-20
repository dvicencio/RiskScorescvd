
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

This is a basic example of how the dataset should look to calculate all
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


 # Call the function with the cohort_xx

 new_data_frame <- calc_scores(data = cohort_xx)
 
 summary(new_data_frame)
#>  typical_symptoms.num   ecg.normal   abn.repolarisation ecg.st.depression
#>  Min.   :0.00         Min.   :0.00   Min.   :0.00       Min.   :0.00     
#>  1st Qu.:1.00         1st Qu.:0.00   1st Qu.:0.00       1st Qu.:0.00     
#>  Median :4.00         Median :1.00   Median :1.00       Median :0.00     
#>  Mean   :3.26         Mean   :0.51   Mean   :0.55       Mean   :0.48     
#>  3rd Qu.:5.00         3rd Qu.:1.00   3rd Qu.:1.00       3rd Qu.:1.00     
#>  Max.   :6.00         Max.   :1.00   Max.   :1.00       Max.   :1.00     
#>       Age           diabetes        smoker      hypertension  hyperlipidaemia
#>  Min.   :30.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   
#>  1st Qu.:40.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   
#>  Median :56.00   Median :0.00   Median :0.00   Median :0.00   Median :1.00   
#>  Mean   :54.96   Mean   :0.44   Mean   :0.46   Mean   :0.48   Mean   :0.53   
#>  3rd Qu.:68.25   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   
#>  Max.   :80.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   
#>  family.history atherosclerotic.disease presentation_hstni    Gender         
#>  Min.   :0.0    Min.   :0.00            Min.   : 10.00     Length:100        
#>  1st Qu.:0.0    1st Qu.:0.00            1st Qu.: 32.75     Class :character  
#>  Median :0.5    Median :0.00            Median : 55.00     Mode  :character  
#>  Mean   :0.5    Mean   :0.44            Mean   : 56.59                       
#>  3rd Qu.:1.0    3rd Qu.:1.00            3rd Qu.: 87.00                       
#>  Max.   :1.0    Max.   :1.00            Max.   :100.00                       
#>     sweating    pain.radiation   pleuritic      palpation       ecg.twi    
#>  Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00  
#>  1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00  
#>  Median :1.00   Median :1.00   Median :0.00   Median :1.00   Median :0.00  
#>  Mean   :0.52   Mean   :0.51   Mean   :0.48   Mean   :0.51   Mean   :0.36  
#>  3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00  
#>  Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00  
#>   second_hstni     killip.class   systolic.bp       heart.rate   
#>  Min.   :  1.00   Min.   :1.00   Min.   :  1.00   Min.   :  2.0  
#>  1st Qu.: 66.25   1st Qu.:1.00   1st Qu.: 87.75   1st Qu.: 68.0  
#>  Median :116.00   Median :3.00   Median :161.00   Median :160.0  
#>  Mean   :106.41   Mean   :2.51   Mean   :156.14   Mean   :157.1  
#>  3rd Qu.:153.00   3rd Qu.:4.00   3rd Qu.:232.25   3rd Qu.:245.0  
#>  Max.   :200.00   Max.   :4.00   Max.   :293.00   Max.   :294.0  
#>      creat      cardiac.arrest  previous.pci  previous.cabg     aspirin    
#>  Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00   Min.   :0.00  
#>  1st Qu.:0.75   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00   1st Qu.:0.00  
#>  Median :1.50   Median :1.00   Median :1.00   Median :0.00   Median :0.00  
#>  Mean   :1.77   Mean   :0.53   Mean   :0.53   Mean   :0.47   Mean   :0.47  
#>  3rd Qu.:3.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00   3rd Qu.:1.00  
#>  Max.   :4.00   Max.   :1.00   Max.   :1.00   Max.   :1.00   Max.   :1.00  
#>  number.of.episodes.24h   total.chol       total.hdl     Ethnicity        
#>  Min.   : 0.00          Min.   :  6.00   Min.   :2.00   Length:100        
#>  1st Qu.: 5.75          1st Qu.: 32.75   1st Qu.:2.00   Class :character  
#>  Median :10.00          Median : 54.50   Median :3.50   Mode  :character  
#>  Mean   : 9.76          Mean   : 52.49   Mean   :3.46                     
#>  3rd Qu.:14.00          3rd Qu.: 73.00   3rd Qu.:4.00                     
#>  Max.   :20.00          Max.   :100.00   Max.   :5.00                     
#>   HEART_score     EDACS_score     GRACE_score      TIMI_score  
#>  Min.   : 3.00   Min.   :-4.00   Min.   : 30.0   Min.   :1.00  
#>  1st Qu.: 5.00   1st Qu.: 6.00   1st Qu.: 86.0   1st Qu.:3.00  
#>  Median : 6.00   Median :10.00   Median :120.0   Median :4.00  
#>  Mean   : 6.17   Mean   :10.03   Mean   :115.5   Mean   :4.21  
#>  3rd Qu.: 7.00   3rd Qu.:13.00   3rd Qu.:143.2   3rd Qu.:5.00  
#>  Max.   :10.00   Max.   :25.00   Max.   :191.0   Max.   :6.00  
#>   ASCVD_score      SCORE2_score           HEART_strat       EDACS_strat 
#>  Min.   :0.0000   Min.   :  0.00   Low risk     : 5   Low risk    :  0  
#>  1st Qu.:0.0700   1st Qu.: 28.00   Moderate risk:51   Not low risk:100  
#>  Median :0.4450   Median : 92.00   High risk    :44                     
#>  Mean   :0.4423   Mean   : 66.63                                        
#>  3rd Qu.:0.7325   3rd Qu.:100.00                                        
#>  Max.   :1.0000   Max.   :100.00                                        
#>         GRACE_strat         TIMI_strat        ASCVD_strat        SCORE2_strat
#>  Low risk     :27   Very low risk: 0   Very low risk:17   Very low risk: 0   
#>  Moderate risk:21   Low risk     : 6   Low risk     : 9   Low risk     : 7   
#>  High risk    :52   Moderate risk:51   Moderate risk: 7   Moderate risk: 5   
#>                     High risk    :43   High risk    :67   High risk    :88   
#>                                                                              
#> 
```
