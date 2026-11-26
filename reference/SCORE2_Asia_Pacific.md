# SCORE2-Asia-Pacific

This function calculates the 10-year cardiovascular risk estimation for
patients aged 40 to 69 years using the
[doi:10.1093/eurheartj/ehae609](https://doi.org/10.1093/eurheartj/ehae609)
SCORE2-Asia-Pacific algorithm. Risk score is expressed as percentage in
one decimal place. It also categorises these patients into different
risk groups.

## Usage

``` r
SCORE2_Asia_Pacific(
  Risk.region,
  Age,
  Gender,
  smoker,
  systolic.bp,
  total.chol,
  total.hdl,
  diabetes,
  classify = FALSE
)
```

## Arguments

- Risk.region:

  Input character to indicate an Asian or Oceania risk region group the
  patient belongs to. The allowed categories are

  - Low

  - Moderate

  - High

  - Very high

- Age:

  Input positive integer to indicate the age of the patient.

- Gender:

  Input character to indicate the gender of the patient. The allowed
  categories are

  - male

  - female

- smoker:

  Input integer 0 or 1 to indicate if the patient is a current smoker.

  - 0 stands for patient is either a former/past smoker or a non-smoker.

  - 1 stands for patient is a current smoker.

- systolic.bp:

  Input positive numeric value to indicate the patient's systolic blood
  pressure in \\mm HG\\.

- total.chol:

  Input positive numeric value to indicate the patient's total
  cholesterol in \\mmol/L\\.

- total.hdl:

  Input positive numeric value to indicate the patient's high-density
  lipoprotein (HDL) in \\mmol/L\\.

- diabetes:

  Input integer 0 or 1 to indicate if the patient has diabetes.

  - 0 stands for not having diabetes.

  - 1 stands for having diabetes.

- classify:

  When set to `TRUE`, the function will return the patient's risk group
  based on the SCORE2-Asia-Pacific risk score in percentage rounded to
  one decimal place. Default: `FALSE`.

  Risk groups are classified based on Figure 3 from the
  [doi:10.1093/eurheartj/ehad192](https://doi.org/10.1093/eurheartj/ehad192)
  *2023 ESC Guidelines for the management of cardiovascular disease in
  patients with diabetes*:

  |  |  |
  |----|----|
  | **SCORE2-Asia-Pacific Score** | **10-year Cardiovascular Disease (CVD) Risk Group** |
  | \\\<5\\\\ | Low risk |
  | \\5\\\\ to \\\<10\\\\ | Moderate risk |
  | \\10\\\\ to \\\<20\\\\ | High risk |
  | \\\ge20\\\\ | Very high risk |

## Value

SCORE2-Asia-Pacific
[doi:10.1093/eurheartj/ehae609](https://doi.org/10.1093/eurheartj/ehae609)
risk score expressed as a positive percentage rounded to one decimal
place when `classify` is `FALSE`. A patient's risk group when `classify`
is `TRUE`.

## Details

SCORE2-Asia-Pacific
[doi:10.1093/eurheartj/ehae609](https://doi.org/10.1093/eurheartj/ehae609)
was developed by extending the SCORE2
[doi:10.1093/eurheartj/ehab309](https://doi.org/10.1093/eurheartj/ehab309)
algorithms using 8405574 participants (556421 CVD events) from the
Asia-Pacific regions without previous CVD.

## References

### Primary Paper

- SCORE2 Asia-Pacific writing group, Hageman SHJ, Huang Z, Lee H,
  Kaptoge S, Dorresteijn JAN, Pennells L, Angelantonio ED, Visseren FLJ,
  Hyeon CK, Johar A, the European Society of Cardiology and European
  Association of Preventive Cardiology: Cardiovascular Risk
  Collaboration (ESC CRC), the ASEAN Federation of Cardiology (AFC), the
  Asian-Pacific Society of Cardiology (APSC), on behalf of the SCORE2
  Asia-Pacific collaborators, SCORE2-Diabetes: 10-year cardiovascular
  risk estimation in type 2 diabetes in Europe, *Eur Heart J*,
  **44**:2544–2556,
  [doi:10.1093/eurheartj/ehad260](https://doi.org/10.1093/eurheartj/ehad260)

### Clinical Practice Guidelines

- Marx N, Federici M, Schütt K, Müller-Wieland D, Ajjan RA,vAntunes MJ,
  Christodorescu RM, Crawford C, Angelantonio ED, Eliasson B,
  Espinola-Klein C, Fauchier L, Halle M, Herrington WG, Kautzky-Willer
  A, Lambrinou E, Lesiak M, Lettino M, McGuire DK, Mullens W, Rocca B,
  Sattar N, ESC Scientific Document Group, 2023 ESC Guidelines for the
  management of cardiovascular disease in patients with diabetes:
  Developed by the task force on the management of cardiovascular
  disease in patients with diabetes of the European Society of
  Cardiology (ESC), *Eur Heart J*, **44**:4043–4140,
  [doi:10.1093/eurheartj/ehad192](https://doi.org/10.1093/eurheartj/ehad192)

## Examples

``` r
# 50 years old male from low risk region
# who is a smoker, non-diabetic
# with a systolic blood pressure of 140 mmHg,
# total cholesterol of 5.5 mmol/L,
# HDL cholesterol of 1.3 mmol/L,
# will have a risk score of 10.3 and
# at high risk of CVD.

SCORE2_Asia_Pacific(
  Risk.region = "Low",
  Age = 50,
  Gender = "male",
  smoker = 1,
  systolic.bp = 140,
  total.chol = 5.5,
  total.hdl = 1.3,
  diabetes = 0,
  classify = FALSE
)
#> [1] 10.3

SCORE2_Asia_Pacific(
  Risk.region = "Low",
  Age = 50,
  Gender = "male",
  smoker = 1,
  systolic.bp = 140,
  total.chol = 5.5,
  total.hdl = 1.3,
  diabetes = 0,
  classify = TRUE
)
#> [1] "High risk"
```
