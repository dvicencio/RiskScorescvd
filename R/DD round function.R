round_DD <- function(x, n) {
  posneg = sign(x)
  z = abs(x) * 10^n
  z = z + 0.5
  z = trunc(z)
  z = z / 10^n
  z * posneg
} 