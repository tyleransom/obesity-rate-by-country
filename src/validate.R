#!/usr/bin/env Rscript
# validate.R — integrity checks for the obesity panel + by-sex companion.
#
#   run from src/ ; requires R with tidyverse
#   Rscript validate.R
#
# Hard checks FAIL the run (exit 1): column sets, controlled vocabularies, ISO3 ==
# filename, numeric fields, duplicate country-years, every raw file documented in the
# README, every by-sex row mapping to a panel row. Reconciliation gaps are WARN only
# (a simple (men+women)/2 legitimately diverges from the population-weighted total when
# the sex gap is large), so they flag rows to eyeball, not errors.

suppressMessages(library(tidyverse))

fail <- 0L; warn <- 0L
say  <- function(...) cat(..., "\n")
FAIL <- function(msg, df = NULL) { fail <<- fail + 1L; say("  [FAIL]", msg); if (!is.null(df) && nrow(df)) print(as.data.frame(df), row.names = FALSE) }
WARN <- function(msg, df = NULL) { warn <<- warn + 1L; say("  [warn]", msg); if (!is.null(df) && nrow(df)) print(as.data.frame(df), row.names = FALSE) }
OK   <- function(msg) say("  [ ok ]", msg)

vocab <- list(
  basis       = c("crude", "age-standardised"),
  measurement = c("measured", "self-reported"),
  derivation  = c("published", "reconstructed", "anchor"),
  coverage    = c("national", "sub-national", "non-probability")
)

# By-sex rows that intentionally have no panel counterpart (documented in the notes).
allow_nopanel <- tibble(iso3 = "ZAF", survey_period = "2012")  # SANHANES-1, "not in main panel"

raw_dir <- "../data/raw"
files   <- list.files(raw_dir, pattern = "\\.csv$", full.names = TRUE)
raw_cols <- c("country", "iso3", "survey_period", "obesity_pct", "basis", "measurement",
              "derivation", "age_group", "coverage", "source", "note")

## [1] raw per-country files -------------------------------------------------
say("\n[1] Raw per-country files")
raw_all <- list()
for (f in files) {
  iso <- sub("\\.csv$", "", basename(f))
  d <- suppressMessages(read_csv(f, col_types = cols(.default = "c")))
  raw_all[[iso]] <- d
  if (!identical(names(d), raw_cols))
    FAIL(paste0(iso, ": unexpected columns: ", paste(names(d), collapse = ",")))
  bad <- d %>% filter(iso3 != iso)
  if (nrow(bad)) FAIL(paste0(iso, ": iso3 column != filename"), bad %>% select(iso3, survey_period))
  if (any(is.na(suppressWarnings(as.numeric(d$obesity_pct))))) FAIL(paste0(iso, ": non-numeric obesity_pct"))
  if (any(!str_detect(d$survey_period, "\\d{4}"))) FAIL(paste0(iso, ": survey_period without a 4-digit year"))
  dd <- d %>% count(survey_period) %>% filter(n > 1)
  if (nrow(dd)) FAIL(paste0(iso, ": duplicate survey_period"), dd)
}
say(sprintf("  %d files read", length(files)))
allraw <- bind_rows(raw_all)
for (col in names(vocab)) {
  bad <- setdiff(unique(allraw[[col]]), vocab[[col]])
  if (length(bad)) FAIL(paste0("raw ", col, " out-of-vocab: ", paste(bad, collapse = ", ")))
  else OK(paste0("raw ", col, " vocab clean"))
}

## [2] cleaned panel ---------------------------------------------------------
say("\n[2] Cleaned panel")
p <- suppressMessages(read_csv("../data/cleaned/obesity-rate-by-country.csv", col_types = cols(.default = "c")))
miss <- setdiff(names(raw_all), unique(p$iso3))
if (length(miss)) FAIL(paste0("panel missing countries (re-run combine.R?): ", paste(miss, collapse = ","))) else OK("all raw countries present in panel")
if (nrow(p) != nrow(allraw)) WARN(sprintf("panel rows (%d) != raw rows (%d) — re-run combine.R", nrow(p), nrow(allraw))) else OK("panel row count matches raw")
dp <- p %>% count(iso3, survey_period) %>% filter(n > 1)
if (nrow(dp)) FAIL("panel duplicate iso3+survey_period", dp) else OK("no panel duplicates")

## [3] by-sex companion ------------------------------------------------------
say("\n[3] By-sex companion")
bs <- suppressMessages(read_csv("../data/cleaned/obesity-by-sex.csv", col_types = cols(.default = "c")))
for (col in intersect(names(vocab), names(bs))) {
  bad <- setdiff(unique(bs[[col]]), vocab[[col]])
  if (length(bad)) FAIL(paste0("by-sex ", col, " out-of-vocab: ", paste(bad, collapse = ", "))) else OK(paste0("by-sex ", col, " vocab clean"))
}
for (col in c("men_pct", "women_pct", "women_minus_men_pp"))
  if (any(is.na(suppressWarnings(as.numeric(bs[[col]]))))) FAIL(paste0("by-sex non-numeric ", col))
chk <- bs %>% mutate(m = as.numeric(men_pct), w = as.numeric(women_pct), d = as.numeric(women_minus_men_pp)) %>%
  filter(abs(round(w - m, 1) - d) > 0.05)
if (nrow(chk)) FAIL("women_minus_men_pp != women_pct - men_pct", chk %>% select(iso3, survey_period, men_pct, women_pct, women_minus_men_pp)) else OK("women_minus_men_pp consistent")
db <- bs %>% count(iso3, survey_period) %>% filter(n > 1)
if (nrow(db)) FAIL("by-sex duplicate iso3+survey_period", db) else OK("no by-sex duplicates")

j <- bs %>% mutate(m = as.numeric(men_pct), w = as.numeric(women_pct), avg = (m + w) / 2) %>%
  left_join(p %>% transmute(iso3, survey_period, total = as.numeric(obesity_pct)), by = c("iso3", "survey_period"))
nopan <- j %>% filter(is.na(total)) %>% anti_join(allow_nopanel, by = c("iso3", "survey_period"))
if (nrow(nopan)) FAIL("by-sex row with no matching panel row (not allow-listed)", nopan %>% select(country, iso3, survey_period)) else OK("every by-sex row maps to a panel row (or is allow-listed)")

recon <- j %>% filter(!is.na(total)) %>%
  mutate(gap = avg - total, tol = pmax(1.0, 0.07 * abs(w - m))) %>%
  filter(abs(gap) > tol) %>%
  transmute(iso3, survey_period, men_pct, women_pct, avg = round(avg, 1), total, gap = round(gap, 1), tol = round(tol, 1))
if (nrow(recon)) WARN(sprintf("%d by-sex rows exceed adaptive reconciliation tolerance (eyeball; large sex gaps diverge legitimately):", nrow(recon)), recon) else OK("all by-sex rows reconcile within tolerance")

## [4] README provenance coverage -------------------------------------------
say("\n[4] README provenance coverage")
readme <- readLines("../data/raw/README.md", warn = FALSE)
documented <- unique(na.omit(unlist(lapply(str_match_all(readme, "`([A-Z]{3})\\.csv`"), function(m) m[, 2]))))
undoc <- setdiff(names(raw_all), documented)
if (length(undoc)) FAIL(paste0("raw files with no README section: ", paste(undoc, collapse = ","))) else OK("every raw file has a README section")

## summary -------------------------------------------------------------------
say(sprintf("\n==== %d FAIL, %d WARN ====", fail, warn))
if (fail > 0L) quit(status = 1L)
