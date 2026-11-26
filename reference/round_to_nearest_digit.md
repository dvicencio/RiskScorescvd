# Round To Nearest Digit

A function that does symmetric rounding to the nearest digits.

## Usage

``` r
round_to_nearest_digit(number, digits = 0)
```

## Arguments

- number:

  Input numeric value

- digits:

  Input integer indicating the number of decimal places to be used. By
  default, it symmetrically rounds off to the nearest integer. Default:
  0

## Examples

``` r
round_to_nearest_digit(0.5)
#> [1] 1
round_to_nearest_digit(1.5)
#> [1] 2
round_to_nearest_digit(-0.5)
#> [1] -1
round_to_nearest_digit(-1.5)
#> [1] -2
```
