# Generate outputs of every changed exported function on fixed inputs.
# Usage: Rscript gen.R <lib> <out.rds>
args <- commandArgs(TRUE)
lib <- args[1]; out <- args[2]
suppressPackageStartupMessages({
  library(dplyr)
  library(RiskScorescvd, lib.loc = lib)
})
cat("Package version:", as.character(packageVersion("RiskScorescvd", lib.loc = lib)), "\n")

# Value as character; "ERROR" if it errors. Warnings/messages silenced.
safe <- function(expr) {
  v <- tryCatch(suppressWarnings(suppressMessages(expr)),
                error = function(e) "ERROR")
  if (length(v) != 1) return(paste0("LEN", length(v)))
  if (is.factor(v)) v <- as.character(v)
  if (is.na(v)) return(NA_character_)
  as.character(v)
}

# ---- SCORE2 grid ----
g <- expand.grid(
  Risk.region = c("Low", "Moderate", "High", "Very high"),
  Age = c(30, 35, 39, 39.9, 40, 45, 49, 50, 55, 60, 65, 69, 69.5, 70, 75, 80, 85, 89, 95),
  Gender = c("male", "female"), smoker = c(0, 1), systolic.bp = c(100, 140, 180),
  diabetes = c(0, 1), total.chol = c(3.5, 6.3, 8), total.hdl = c(0.8, 1.4, 2.2),
  stringsAsFactors = FALSE
)
# NA rows: each input missing in turn, on a small base set
base <- g[g$Risk.region == "Low" & g$systolic.bp == 140 & g$total.chol == 6.3 &
          g$total.hdl == 1.4 & g$Age %in% c(45, 60, 75), ]
na_rows <- do.call(rbind, lapply(names(g), function(v) { b <- base; b[[v]] <- NA; b }))
g <- rbind(g, na_rows)
call_s2 <- function(cls) mapply(function(Risk.region, Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl)
  safe(SCORE2(Risk.region, Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl, classify = cls)),
  g$Risk.region, g$Age, g$Gender, g$smoker, g$systolic.bp, g$diabetes, g$total.chol, g$total.hdl,
  USE.NAMES = FALSE)
g$score <- call_s2(FALSE); g$class <- call_s2(TRUE)

# ---- SCORE2_CKD grid ----
ck <- expand.grid(
  Risk.region = c("Low", "Very high"), Age = c(35, 39, 40, 55, 69, 70, 80),
  Gender = c("male", "female"), smoker = c(0, 1), systolic.bp = c(120, 160),
  diabetes = c(0, 1), total.chol = c(5, 6.5), total.hdl = c(1, 1.5),
  eGFR = c(25, 50, 75, 105), addon_set = 1:5, stringsAsFactors = FALSE
)
sets <- list(list(NA, NA, "ACR"), list(150, NA, "ACR"), list(NA, "2+", "ACR"),
             list(30, "trace", "trace"), list(30, "1+", "ACR"))
ck$ACR <- vapply(sets[ck$addon_set], `[[`, 1, FUN.VALUE = numeric(1))
ck$trace <- vapply(sets[ck$addon_set], function(s) as.character(s[[2]]), character(1))
ck$addon <- vapply(sets[ck$addon_set], `[[`, 3, FUN.VALUE = character(1))
ckbase <- ck[ck$Risk.region == "Low" & ck$eGFR == 50 & ck$addon_set == 2 & ck$Age %in% c(55, 80), ]
ck_na <- do.call(rbind, lapply(c("Risk.region", "Age", "Gender", "smoker", "systolic.bp",
                                 "diabetes", "total.chol", "total.hdl", "eGFR"),
                               function(v) { b <- ckbase; b[[v]] <- NA; b }))
ck <- rbind(ck, ck_na)
call_ck <- function(cls) mapply(function(Risk.region, Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl, eGFR, ACR, trace, addon)
  safe(SCORE2_CKD(Risk.region, Age, Gender, smoker, systolic.bp, diabetes, total.chol, total.hdl,
                  eGFR, ACR, trace, addon, classify = cls)),
  ck$Risk.region, ck$Age, ck$Gender, ck$smoker, ck$systolic.bp, ck$diabetes, ck$total.chol,
  ck$total.hdl, ck$eGFR, ck$ACR, ck$trace, ck$addon, USE.NAMES = FALSE)
ck$score <- call_ck(FALSE); ck$class <- call_ck(TRUE)

# ---- Cohort for calc_scores and the data-frame wrappers (docs example + CKD columns) ----
set.seed(2026)
n <- 500
cohort <- data.frame(
  typical_symptoms.num = as.numeric(sample(0:6, n, TRUE)),
  ecg.normal = as.numeric(sample(c(0, 1), n, TRUE)),
  abn.repolarisation = as.numeric(sample(c(0, 1), n, TRUE)),
  ecg.st.depression = as.numeric(sample(c(0, 1), n, TRUE)),
  Age = as.numeric(sample(30:90, n, TRUE)),
  diabetes = sample(c(1, 0), n, TRUE), smoker = sample(c(1, 0), n, TRUE),
  hypertension = sample(c(1, 0), n, TRUE), hyperlipidaemia = sample(c(1, 0), n, TRUE),
  family.history = sample(c(1, 0), n, TRUE),
  atherosclerotic.disease = sample(c(1, 0), n, TRUE),
  presentation_hstni = as.numeric(sample(10:100, n, TRUE)),
  Gender = sample(c("male", "female"), n, TRUE),
  sweating = as.numeric(sample(c(0, 1), n, TRUE)),
  pain.radiation = as.numeric(sample(c(0, 1), n, TRUE)),
  pleuritic = as.numeric(sample(c(0, 1), n, TRUE)),
  palpation = as.numeric(sample(c(0, 1), n, TRUE)),
  ecg.twi = as.numeric(sample(c(0, 1), n, TRUE)),
  second_hstni = as.numeric(sample(1:200, n, TRUE)),
  killip.class = as.numeric(sample(1:4, n, TRUE)),
  systolic.bp = as.numeric(sample(90:180, n, TRUE)),
  heart.rate = as.numeric(sample(0:300, n, TRUE)),
  creat = as.numeric(sample(0:4, n, TRUE)),
  cardiac.arrest = as.numeric(sample(c(0, 1), n, TRUE)),
  previous.pci = as.numeric(sample(c(0, 1), n, TRUE)),
  previous.cabg = as.numeric(sample(c(0, 1), n, TRUE)),
  aspirin = as.numeric(sample(c(0, 1), n, TRUE)),
  number.of.episodes.24h = as.numeric(sample(0:20, n, TRUE)),
  total.chol = as.numeric(round(runif(n, 3.9, 7.2), 1)),
  total.hdl = as.numeric(round(runif(n, .8, 2.1), 1)),
  Ethnicity = sample(c("white", "black", "asian", "other"), n, TRUE),
  eGFR = as.numeric(sample(15:120, n, TRUE)),
  ACR = as.numeric(sample(5:1500, n, TRUE)),
  trace = sample(c("trace", "1+", "2+", "3+", "4+"), n, TRUE),
  stringsAsFactors = FALSE
)
df_out <- function(expr) {
  v <- tryCatch(suppressWarnings(suppressMessages(expr)), error = function(e) conditionMessage(e))
  if (is.character(v)) return(v)
  v <- as.data.frame(v)
  v[] <- lapply(v, function(x) if (is.factor(x)) as.character(x) else x)
  v
}
res <- list(
  score2 = g, ckd = ck, cohort = cohort,
  calc_scores = df_out(calc_scores(data = cohort)),
  score2_scores = df_out(SCORE2_scores(data = cohort, Risk.region = "Low", classify = TRUE)),
  score2_ckd_scores = df_out(SCORE2_CKD_scores(data = cohort, Risk.region = "Low", classify = TRUE))
)
saveRDS(res, out)
cat("Saved", out, "\n")
