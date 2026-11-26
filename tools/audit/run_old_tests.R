# Run the unmodified 0.3.1 test suite against the package installed in a
# given library. Usage: Rscript run_old_tests.R <lib> <old_tests_dir>
args <- commandArgs(TRUE)
lib <- normalizePath(args[1]); dir <- normalizePath(args[2])
suppressPackageStartupMessages({
  library(dplyr)
  library(RiskScorescvd, lib.loc = lib)
})
cat("Package version:", as.character(packageVersion("RiskScorescvd", lib.loc = lib)), "\n")
res <- testthat::test_dir(dir, reporter = "summary", stop_on_failure = FALSE,
                          stop_on_warning = FALSE, load_package = "none")
df <- as.data.frame(res)
cat("\n== Totals ==\n")
print(colSums(df[, c("nb", "failed", "skipped", "warning")]))
cat("errored tests:", sum(df$error), "\n")
cat("\n== Tests with failures or errors ==\n")
print(df[df$failed > 0 | df$error, c("file", "test", "nb", "failed", "error")], row.names = FALSE)
