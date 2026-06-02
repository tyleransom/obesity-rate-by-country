# Sources and provenance — per country

Adult obesity prevalence = % of adults with **BMI &ge; 30 kg/m&sup2;**, total (both sexes),
from **measured** height/weight unless explicitly noted. `obesity_pct` is **crude** prevalence
(not age-standardised). `survey_period` is the period exactly as the source reports it.

Each section lists the SOURCE URL the data came from, so the CSV can be reproduced/audited and
the bulky national source files (xlsx/explorer exports) need not be stored in the repo.

---

## USA — `USA.csv`  (adults 20+, NHANES; 1900 anchor)

- 1900-1901 = 3.0 — anthropometric anchor, **not** NHANES. Derived from Helmchen & Henderson
  (2004, *Ann Hum Biol*), who report measured obesity of 3.3–5.9% among white male Union Army
  veterans aged 40–69 (12,312 men examined 1890–1900); adjusted down for younger adults (Komlos
  & Brabec 2010, *Am J Hum Biol*) and across sex/race to ~3% for all US adults.
- 1960-1962 onward = NHANES / NHES measured survey waves (BMI &ge; 30, adults 20+).
  SOURCE: Fryar et al. (2020), NCHS,
  https://www.cdc.gov/nchs/data/hestat/obesity-adult-17-18/obesity-adult.htm
  (the 2021-2023 point is from the subsequent NHANES release).
- The NCHS source also reports **severe obesity** (BMI &ge; 40); not carried here (this repo is
  BMI &ge; 30 only).

## United Kingdom — `GBR.csv`  (ENGLAND, Health Survey for England, age 16+)

- IMPORTANT: this is **England**, not the whole UK — the Health Survey for England (HSE) is the
  measured national series. Coded `GBR` for convenience; treat as England.
- 1980 = 7.5 — pre-HSE anchor, National Heights & Weights Survey (6% men / 9% women). UKHSA.
- 1993-2024 = HSE, **single-year** % obese (BMI &ge; 30, incl. severe), All adults (both sexes).
  Retains real survey wobble (e.g. 2009 dip 23.0, 2010 jump 26.1). EXCLUDED: 2020 (no survey)
  and 2021 (HSE switched to self-report — methodology break; the source lists 2021 = 25.9).
  2022 returned to measured.
  SOURCE: NHS England Digital, Health Survey for England 2024, "Adult and child overweight and
  obesity tables", Table 3 ("Adults' BMI by survey year, age and sex"), row "All adults" /
  "% Obesity, including severe obesity". Direct file:
  https://files.digital.nhs.uk/1E/EE2200/HSE-2024-Adult-and-child-overweight-and-obesity-tables.xlsx

## Canada — `CAN.csv`  (national; CHMS measured, adults 18-79)

- 1970-72 = 9.7 — Nutrition Canada Survey (7.6% men / 11.7% women). Katzmarzyk 2002, *Obes Res*.
- 1978-79 = 13.8 — Canada Health Survey.
- 2004 = 23.1 — CCHS-Nutrition, measured subsample.
- 2007-09, 2009-11, 2012-13, 2014-15, 2016-17, 2018-19, 2022-24 = Canadian Health Measures
  Survey (CHMS), measured, adults 18-79, both sexes. Note the genuine 2018-19 dip (24.3) and
  post-COVID jump (33.4 in 2022-24).
  SOURCE: Statistics Canada Table 13-10-0373-01 ("Overweight and obesity based on measured body
  mass index"). Table page: https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310037301
  Pulled via the StatCan open-data CSV API:
    curl -s "https://www150.statcan.gc.ca/t1/wds/rest/getFullTableDownloadCSV/13100373/en"
    -> JSON with a zip URL (https://www150.statcan.gc.ca/n1/tbl/csv/13100373-eng.zip); then filter
    GEO=Canada, Measures=Obese, Sex=Both sexes, Age group="Ages 18 to 79", Characteristics=Percent.
  (REF_DATE in the table = the cycle END year; survey_period here gives the full cycle span.)

## Australia — `AUS.csv`  (national 1995+; ABS surveys, adults 18+)

- 1980 = 7.1 — NHF Risk Factor Prevalence Study. CAVEAT: 6 capital cities only, ages 25-64 —
  NOT national; likely understates the national rate. Bennett & Magnus 1994, *MJA*.
- 1989 = 11.1 — NHF RFPS (approximate).
- 1999-2000 = 20.8 — AusDiab (not in the AIHW table below).
- 1995, 2007-08, 2011-12, 2014-15, 2017-18, 2022 = measured obesity (BMI &ge; 30, persons 18+),
  CRUDE rate. Underlying ABS surveys: National Nutrition Survey 1995, National Health Survey
  2007-08, Australian Health Survey 2011-12, NHS 2014-15/2017-18/2022.
  SOURCE: AIHW report PHE 251, "Overweight and obesity", Data tables 2024, **Table S4**
  ("Age-standardised and crude proportions of overweight or obese persons aged 18 and over, 1995
  to 2022") — the "Obese" / crude row.
  https://www.aihw.gov.au/reports/overweight-obesity/overweight-and-obesity/data
  NOTE: in 2022 a large share of height/weight was self-reported/imputed (AIHW note) — a minor
  break from the fully-measured earlier waves.

## New Zealand — `NZL.csv`  (national 2011/12+; NZ Health Survey, adults 15+)

- 1977 = 10.0 — National Diet Survey (9% men / 11% women). MoH "Tracking the Obesity Epidemic
  1977-2003".
- 1989 = 11.0 — Life in New Zealand Survey.
- 1997 = 17.0 — National Nutrition Survey (14.7% men / 19.2% women).
- 2011/12 onward = NZ Health Survey, measured, total adults **15+**, CRUDE %, the "Obese" row.
  Continuous annual survey. EXCLUDED: 2021-22 (blank in the source export — COVID-disrupted
  fieldwork). A 2002/03 figure is omitted (the "Tracking" report ~21% and the early NZHS ~24%
  disagree, and the 1997->2011/12 gap spans a change of survey program).
  SOURCE: NZ Health Survey Annual Data Explorer (Ministry of Health):
  https://minhealthnz.shinyapps.io/nz-health-survey-2024-25-annual-data-explorer/
  To reproduce: "Explore topics" -> "Body size" (Population: Adults, Subgroup: Total) ->
  "Download data" (CSV). The exported "Obese" row, columns percent.NN = survey year 20NN/NN+1.

---

## Cross-country comparability notes

- **Age base differs**: NZ 15+, UK/US 16+, Australia/Canada 18+.
- All values are **crude** (not age-standardised).
- Pre-continuous-survey points are isolated waves; treat early anchors cautiously (esp. AUS 1980
  capital-cities-only and the US 1890s anthropometric anchor).
- The UK series is **England** (HSE), not the whole United Kingdom.
