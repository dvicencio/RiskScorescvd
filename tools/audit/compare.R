# Compare 0.3.1 vs new outputs. Every difference must be explained by a
# deliberate change: Age < 40 (#17), Age < 70 & diabetes == 1 (#15), or a
# missing required input (#21), in which case the new value must be NA.
args <- commandArgs(TRUE)
old <- readRDS(args[1]); new <- readRDS(args[2])
problems <- 0

expected_change <- function(d, req) {
  anyna <- Reduce(`|`, lapply(d[req], is.na))
  age <- d$Age; dm <- d$diabetes
  (!is.na(age) & age < 40) | (!is.na(age) & !is.na(dm) & age < 70 & dm == 1) | anyna
}

check_grid <- function(name, o, n, req) {
  exp <- expected_change(o, req)
  cat(sprintf("\n== %s: %d rows (%d with an intended change) ==\n", name, nrow(o), sum(exp)))
  for (col in c("score", "class")) {
    same <- identical(o[[col]][!exp], n[[col]][!exp])
    diff_unexp <- sum(!(o[[col]][!exp] %in% n[[col]][!exp] &
                        mapply(identical, o[[col]][!exp], n[[col]][!exp])))
    new_na <- all(is.na(n[[col]][exp]))
    cat(sprintf("  %-5s unchanged rows identical: %s (%d differ) | intended rows all NA in new: %s\n",
                col, same, diff_unexp, new_na))
    cat("        old values in intended rows: ",
        paste(names(table(ifelse(is.na(o[[col]][exp]), "NA",
               ifelse(o[[col]][exp] == "ERROR", "ERROR", "value")))),
              table(ifelse(is.na(o[[col]][exp]), "NA",
               ifelse(o[[col]][exp] == "ERROR", "ERROR", "value"))), sep = "=", collapse = ", "), "\n")
    if (!same || !new_na) {
      problems <<- problems + 1
      bad <- which(!exp)[!mapply(identical, o[[col]][!exp], n[[col]][!exp])]
      print(head(cbind(o[bad, req], old = o[[col]][bad], new = n[[col]][bad]), 20))
    }
  }
}
req2 <- c("Risk.region", "Age", "Gender", "smoker", "systolic.bp", "diabetes", "total.chol", "total.hdl")
check_grid("SCORE2()", old$score2, new$score2, req2)
check_grid("SCORE2_CKD()", old$ckd, new$ckd, c(req2, "eGFR"))

check_df <- function(name, o, n, score_cols, cohort) {
  cat(sprintf("\n== %s ==\n", name))
  if (is.character(o) || is.character(n)) {
    cat("  old:", if (is.character(o)) o else "ok", "\n  new:", if (is.character(n)) n else "ok", "\n")
    if (is.character(n) && !is.character(o)) problems <<- problems + 1
    return(invisible())
  }
  if (!identical(names(o), names(n)) || nrow(o) != nrow(n)) {
    cat("  columns/rows differ!\n"); problems <<- problems + 1; return(invisible())
  }
  exp <- expected_change(cohort, req2)
  for (col in names(o)) {
    if (col %in% score_cols) {
      ok <- identical(o[[col]][!exp], n[[col]][!exp]) && all(is.na(n[[col]][exp]))
      cat(sprintf("  %-22s SCORE2 column: unchanged rows identical & intended rows NA: %s (%d intended)\n",
                  col, ok, sum(exp)))
    } else {
      ok <- identical(o[[col]], n[[col]])
      if (!ok) cat(sprintf("  %-22s DIFFERS\n", col))
    }
    if (!ok) problems <<- problems + 1
  }
  others <- setdiff(names(o), score_cols)
  cat(sprintf("  %d other columns compared; all identical: %s\n", length(others),
              all(mapply(identical, o[others], n[others]))))
}
s2cols <- c("SCORE2_score", "SCORE2_strat", "SCORE2OP_CKD_score", "SCORE2OP_CKD_strat",
            "SCORE2_CKD_score", "SCORE2_CKD_strat")
check_df("calc_scores()", old$calc_scores, new$calc_scores, s2cols, old$cohort)
check_df("SCORE2_scores()", old$score2_scores, new$score2_scores, s2cols, old$cohort)
check_df("SCORE2_CKD_scores()", old$score2_ckd_scores, new$score2_ckd_scores, s2cols, old$cohort)

cat("\n== Pre-existing: SCORE2(classify = TRUE) returning a function (age gap 69-70) ==\n")
cat("  old:", sum(old$score2$class == "FUNCTION", na.rm = TRUE),
    " new:", sum(new$score2$class == "FUNCTION", na.rm = TRUE), "\n")
cat("  CKD old:", sum(old$ckd$class == "FUNCTION", na.rm = TRUE),
    " new:", sum(new$ckd$class == "FUNCTION", na.rm = TRUE), "\n")
cat(sprintf("\n==== UNEXPLAINED DIFFERENCES: %d ====\n", problems))
if (problems > 0) quit(status = 1)
