# combine.R
# Combine the per-country raw obesity-prevalence CSVs in data/raw/ into a single
# long-format panel in data/cleaned/. Adds a numeric `year` (midpoint of the
# survey period) so the heterogeneous survey-period strings (single years and
# multi-year ranges) can be plotted/merged on a common axis.
#
# Adding a new country = drop a data/raw/<ISO3>.csv with the standard columns
# (country, iso3, survey_period, obesity_pct) and document it in data/raw/README.md;
# this script will pick it up automatically. Run from the repo's src/ directory.

library(tidyverse)

raw_dir <- "../data/raw"
out_dir <- "../data/cleaned"

# midpoint of a "survey period" string, e.g. "1988-1994" -> 1991, "2004" -> 2004
mid_year <- function(s) {
    map_dbl(str_extract_all(s, "\\d{4}"), ~ mean(as.numeric(.x)))
}

files <- list.files(raw_dir, pattern = "\\.csv$", full.names = TRUE)

panel <- map_dfr(files, ~ read_csv(.x, show_col_types = FALSE,
                                   col_types = cols(.default = col_character()))) %>%
    mutate(obesity_pct = as.numeric(obesity_pct),
           year        = mid_year(survey_period)) %>%
    select(country, iso3, year, survey_period, obesity_pct) %>%
    arrange(country, year)

dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
write_csv(panel, file.path(out_dir, "obesity-rate-by-country.csv"))

message("Wrote ", file.path(out_dir, "obesity-rate-by-country.csv"),
        " (", nrow(panel), " rows, ", n_distinct(panel$iso3), " countries)")
