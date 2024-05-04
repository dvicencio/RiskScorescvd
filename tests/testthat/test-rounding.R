test_that("round_to_nearest_digit works", {

  testthat::expect_equal(round_to_nearest_digit(0.5), 1)
  testthat::expect_equal(round_to_nearest_digit(1.5), 2)
  testthat::expect_equal(round_to_nearest_digit(-0.5), -1)
  testthat::expect_equal(round_to_nearest_digit(-1.5), -2)

})
