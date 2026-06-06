# Sources and provenance — per country

Adult obesity prevalence = % of adults with **BMI &ge; 30 kg/m&sup2;**, total (both sexes),
from **measured** height/weight unless explicitly noted. Two basis exceptions: **China and Italy**
are **age-standardised** (not crude; neither publishes crude BMI &ge; 30), and **Denmark** is the one
**self-reported** series (calibration-corrected) — included for coverage but not comparable head-to-head
with the measured countries. Everything else is crude + measured. `survey_period` is the period exactly
as the source reports it.

Each section lists the SOURCE URL the data came from, so the CSV can be reproduced/audited and
the bulky national source files (xlsx/explorer exports) need not be stored in the repo.

Where a source was a paywalled or bulky PDF, a local copy is kept untracked in `data/tmp/`
(gitignored, not redistributable) — currently the Japan MHLW report `000894105.pdf` and the
Yoshiike et al. 2002 *Obesity Reviews* article, the Korea KSSO 2025 Obesity Fact Sheet, the
China Lancet paper `EMS201458.pdf` plus its supplementary `EMS201458-supplement-Appendix.pdf`, the
Brazil IBGE POF 2008-2009 anthropometry report `liv45419.pdf`, and two Saudi obesity reviews used to
vet the Saudi series for any post-2013 measured point — Al-Omar et al. 2024 *Saudi Pharm J*
`1-s2.0-S1319016424002433-main.pdf` and the *Healthcare* 2023 anthropometry review `healthcare-11-01982.pdf`,
and the Malaysia **NHMS 2023** NCD technical report `report-nhms-2023.pdf` (its section 4.4 Tables 4.4.1
and 4.4.3 are the primary source for the Malaysia 2023 point and its sex split), the Singapore
**NPHS 2020** survey report `nphs-2020-survey-report.pdf` (Table 12.6 is the primary source for the
2010-2020 Singapore series), the HPB-MOH *Clinical Practice Guidelines: Obesity* `SMJ-57-292.pdf`
(Fig. 1 holds the excluded 1992-2010 age-standardised NHS series), and the Ecuador **ENSANUT-ECU 2012
Resumen Ejecutivo** `Publicacion ENSANUT 2011-2013 tomo 1.pdf` (Gráfico 21 / §4.2.4 — the adult base,
measurement and exceso de peso 62.8%) plus the **ENSANUT 2018 Principales resultados**
`Principales resultados ENSANUT_2018.pdf` (child-only; confirms the official summary carries no adult
&ge; 30 figure).

## CSV columns

Beyond `country, iso3, survey_period, obesity_pct`, each raw point carries seven quality columns
that encode, in closed vocabularies, the comparability caveats spelled out per country below:

- **`basis`** — `crude` (default) or `age-standardised` (only **China** & **Italy** — neither
  publishes crude BMI &ge; 30).
- **`measurement`** — `measured` (default) or `self-reported` (only **Denmark**).
- **`derivation`** — `published` (a source-reported both-sexes total), `reconstructed` (the 50/50
  male/female average of by-sex figures — flagged "RECONSTRUCTED" in the sections below), or `anchor`
  (a derived non-survey figure — only USA 1900-1901).
- **`age_group`** — adult age base as published (e.g. `20+`, `18-79`, `35-74`); see the
  cross-country comparability note at the foot of this file.
- **`coverage`** — `national`, `sub-national` (GBR = England, NOR = Nord-Trøndelag county,
  AUS 1980 = capital cities, NLD 1976-2002 = RIVM monitoring municipalities), or
  `non-probability` (SWE = occupational cohort).
- **`source`** — short survey/study name (same vocabulary as `data/cleaned/obesity-by-sex.csv`).
- **`note`** — short free-text caveat (double-quoted; may be empty).

These are a structured summary, not a replacement for the per-point prose + URLs that follow.

The cleaned panel (`data/cleaned/obesity-rate-by-country.csv`) adds two derived columns that are **not**
in the raw files: `year` (numeric midpoint of `survey_period`) and **`age_base_varies`** (logical) —
computed by `combine.R`, `TRUE` for every row of a country whose waves do not all share one `age_group`.
A `TRUE` flags an **age-base seam**: a raw year-on-year change in that series can be an artifact of the
shifting age window, not a real trend — age-match the bands before reading it (the worked example is
Israel's MABAT 25-64 &rarr; 18-64, where the apparent 22.9&rarr;17.0 drop is mostly the base change).
As of this writing 17 countries are flagged: AUS, BRA, CHL, EGY, ESP, FIN, IRN, ISR, JPN, KOR, MWI,
NLD, PER, PHL, RUS, SAU, THA. The stable-base multi-wave series (e.g. MOZ 25-64, RWA 15-64) are `FALSE`
and can be read directly.

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
- BY SEX (in `data/cleaned/obesity-by-sex.csv`): the full HSE annual series 1993-2024 (2021
  self-report wave excluded, as in the panel) plus the 1980 anchor (men 6 / women 9). Taken from
  the **Men** and **Women** "All adults" / "% Obesity, including severe obesity" rows of the same
  Table 3 — i.e. the by-sex split of the both-sexes totals above; the men/women average reproduces
  each year's panel total (e.g. 1993 men 13.2 / women 16.4 &rarr; 14.9; 2024 men 29.2 / women 30.6
  &rarr; 29.9). Crude, measured, England, 16+. The female excess is small (typically 1-3 pp) and a
  few waves are male-skewed (2010, 2013, 2015), unlike the large female skews seen in MENA/Africa.

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

## Ireland — `IRL.csv`  (Republic; IUNA national nutrition surveys, adults 18-64, measured)

- Ireland has no continuous measured series. The comparable points come from the three island
  nutrition surveys run by the Irish Universities Nutrition Alliance (IUNA), all **measured**
  (researcher-measured height/weight), total adults **18-64**, BMI &ge; 30, both sexes. Harmonised
  as a trend by Walls/Boylan et al. (2024), "The prevalence and trends in overweight and obesity in
  Irish adults between 1990 and 2011", *Public Health Nutrition*.
  SOURCE: https://pmc.ncbi.nlm.nih.gov/articles/PMC10282270/
- 1990 = 10.9 — Irish National Nutrition Survey (INNS), Republic of Ireland (7.8% men / 13.2% women).
- 1997-1999 = 18.0 — North/South Ireland Food Consumption Survey (NSIFCS) (20.1% men / 16.1% women).
  CAVEAT: **all-island** (958 Republic + 421 Northern Ireland adults), so this one point also
  includes Northern Ireland (UK); the 1990 and 2008-10 points are Republic-only.
- 2008-2010 = 23.6 — National Adult Nutrition Survey (NANS) (25.7% men / 21.5% women).
- EXCLUDED: **NANS II (2021-2022)**, Ireland's most recent official nutrition survey, reports ~17%
  obese (adults 19-64). It is excluded because height/weight were **self-measured by participants at
  home** (a COVID-era change from researcher measurement) — a methodology break — and the rate
  implausibly *falls* from 23.6%, the classic self-measurement understatement this repo screens out
  (cf. the excluded GBR 2021 and NZL 2021-22 self-report waves).
  NANS II report: https://irp.cdn-website.com/46a7ad27/files/uploaded/NANS_II_Summary_Report_(May_2024).pdf
- NOTE: the widely-cited self-reported national series (SLÁN, and the Healthy Ireland Survey) is
  **not** used here — those are self-reported and understate obesity. SLÁN 1998/2002/2007 had a
  measured subsample but on a different (18+) age base; not carried, to keep the 18-64 series clean.

## Mexico — `MEX.csv`  (national; ENSA/ENSANUT, INSP, adults 20+, measured)

- Mexico's NHANES-equivalent is **ENSANUT** (Encuesta Nacional de Salud y Nutrición), run by the
  Instituto Nacional de Salud Pública (INSP). Height/weight are **measured** by trained personnel
  (electronic scale to 100 g, stadiometer to 2 mm), adults **20+**, both sexes, WHO BMI &ge; 30.
- 2000 = 23.5 — ENSA 2000 (the predecessor national health survey).
- 2006 = 30.4, 2012 = 32.4, 2016 = 33.3 — ENSANUT 2006, 2012, and Medio Camino 2016. These three
  (plus 2022) are the official INSP comparable trend.
  CAVEAT: 2016 is "Medio Camino" (a smaller mid-cycle sample); wider CIs than the full waves.
- 2018-2019 = 36.1 — ENSANUT 2018-19. SOURCE: Campos-Nonato et al. (2020), "Obesity in Mexico,
  prevalence and trends in adults. Ensanut 2018-19", *Salud Pública de México*.
  https://www.scielo.org.mx/scielo.php?pid=S0036-36342020000600682&script=sci_abstract&tlng=en
- 2022 = 36.9 — ENSANUT Continua 2022.
  SOURCE: Campos-Nonato et al. (2023), "Prevalencia de obesidad y factores de riesgo asociados en
  adultos mexicanos: resultados de la Ensanut 2022", *Salud Pública de México* 65(supl 1):S238-S247.
  https://ensanut.insp.mx/encuestas/ensanutcontinua2022/doctos/analiticos/31-Obesidad.y.riesgo-ENSANUT2022-14809-72498-2-10-20230619.pdf
  The 2006/2012/2016/2022 total ("ambos sexos") obesity figures above are from this paper's trend
  table; 2022 sex split was 32.3% men / 41.0% women.

## South Korea — `KOR.csv`  (national; KNHANES, KDCA, adults 19+, measured)

- Korea's NHANES-equivalent is **KNHANES** (Korea National Health and Nutrition Examination
  Survey, run by the Korea Disease Control and Prevention Agency, KDCA): measured height/weight,
  complex probability sample, run annually since 2007.
- THE BMI &ge; 30 PROBLEM: Korea does not headline a crude both-sexes BMI &ge; 30 series. Official
  Korean obesity uses the Asia-Pacific **BMI &ge; 25** cutoff, and the Korean Society for the Study
  of Obesity "Obesity Fact Sheet" BMI &ge; 30 ("class II+III") figures are **age-standardised** to
  the 2010 census (and blend in NHIS administrative checkups, not the survey) — the wrong basis for
  this repo, which is **crude** everywhere. KNHANES papers that do report BMI &ge; 30 almost always
  split it by sex (men's and women's trends diverge), not as a total.
- 2007-2009 = 4.1 and 2020-2022 = 7.4 — **published both-sexes totals**. Crude, survey-weighted,
  measured, total adults 19+. Computed as class II (BMI 30-34.9) + class III (BMI &ge; 35):
  3.7 + 0.4 = 4.1% and 6.1 + 1.3 = 7.4%.
  SOURCE: Lee et al., "Trends in Prevalence of Obesity and Related Cardiometabolic and Renal
  Complications in Korea: A Nationwide Study 2007 to 2022."
  https://pmc.ncbi.nlm.nih.gov/articles/PMC12583793/
  (Only these two endpoint periods are reported numerically for the total; the paper's intermediate
  periods 2010-12, 2013-15, 2016-19 appear only in a figure.)
- 1998 = 2.4, 2001 = 3.2, 2005 = 3.5 — **RECONSTRUCTED, not source-reported**. No both-sexes total
  was published this far back; these are the simple **50/50 male/female average** of the by-sex
  BMI &ge; 30 figures (adults 20+) in Khang & Yun,
  https://pmc.ncbi.nlm.nih.gov/articles/PMC3983283/ : men 1.7/2.8/3.6 and women 3.0/3.5/3.4 for
  1998/2001/2005, i.e. (1.7+3.0)/2, (2.8+3.5)/2, (3.6+3.4)/2.
  KNOWN BIAS: a true both-sexes total weights by population sex shares, and Korean adult women are a
  slight majority concentrated at older (higher-obesity) ages, so the 50/50 average runs **~0.2 pp
  low**. This is measurable: for 2007-09 the same 50/50 method gives (3.8+4.0)/2 = 3.9 vs the
  published total 4.1. So treat 1998/2001/2005 as mild *under*estimates. (Handled the same way as the
  repo's other non-survey anchors, e.g. USA 1900 and AUS 1980 — caveated here, not in the CSV.)
  Also note the small age-base seam: the reconstructed points are 20+ (Khang & Yun), the two
  published totals are 19+ (Lee et al.).

## Japan — `JPN.csv`  (national; NHNS, MHLW, adults 20+, measured) — mostly RECONSTRUCTED (2019 is a published total)

- Japan's NHANES-equivalent is the **National Health and Nutrition Survey** (NHNS, formerly the
  National Nutrition Survey), run annually by the Ministry of Health, Labour and Welfare (MHLW):
  measured height/weight, adults 20+.
- THE BMI &ge; 30 PROBLEM (worse than Korea): Japan defines obesity as **BMI &ge; 25** (Asia-Pacific
  cutoff) and almost never tabulates BMI &ge; 30 — it is genuinely rare (~2-5%). The MHLW's own
  trend chart relegates BMI &ge; 30 to two barely-readable dashed lines under the headline BMI &ge; 25
  series. So no crude both-sexes BMI &ge; 30 series is published; the only widely-circulated current
  number is the NCD-RisC **modelled** estimate (rejected here). Note Japan is the mirror image of the
  West: women's BMI &ge; 30 has historically *exceeded* men's.
- All points **except 2019** are **RECONSTRUCTED** as the simple 50/50 male/female average of
  published by-sex **crude** BMI &ge; 30 figures (same method + caveat as the Korea 1998-2005 points:
  a true total weights by population sex shares, so 50/50 is approximate). Not source-reported totals.
  (2019 is a published both-sexes total — see below.) The
  male/female gap is large in Japan (women historically ~3x men), but the Japanese adult sex split is
  near 50/50, so the 50/50 approximation bias is small (~0.05 pp).
- 1976-1980 = 1.8, 1981-1985 = 1.8, 1986-1990 = 1.9, 1991-1995 = 2.3 — National Nutrition Survey,
  adults **20+**, CRUDE, from Table 3 of Yoshiike et al. (2002). By-sex crude BMI &ge; 30 used:
  men 0.84/1.07/1.27/1.86 and women 2.69/2.55/2.62/2.79 across the four 5-year periods.
  IMPORTANT: that paper headlines **age-adjusted** prevalences (standardised to the world standard
  population); we deliberately took its **crude** rows instead, to stay on this repo's crude basis.
  SOURCE: Yoshiike et al. (2002), "Twenty-year changes in the prevalence of overweight in Japanese
  adults: The National Nutrition Survey 1976-95", *Obesity Reviews* 3:183-190,
  https://onlinelibrary.wiley.com/doi/10.1046/j.1467-789X.2002.00070.x
- 2000 = 2.9 — National Nutrition Survey 2000, adults **20+**, crude: men 2.2% / women 3.5% ->
  (2.2+3.5)/2. SOURCE: Yoshiike et al., epidemiology of obesity in Japan (NNS 2000 figures);
  see also https://onlinelibrary.wiley.com/doi/abs/10.1046/j.1440-6047.11.s8.18.x
- 2010 = 3.9 — NIPPON DATA2010 (the cohort drawn from the 2010 NHNS), crude: men 4.6% / women 3.1%
  -> (4.6+3.1)/2. SOURCE: https://pmc.ncbi.nlm.nih.gov/articles/PMC5825685/
  CAVEAT: these by-sex figures are for ages **20-64** (the paper reports 65+ separately: men 1.2% /
  women 4.3%), so this point is on a 20-64 base, a seam vs the 20+ base of every earlier point. Note
  too that 2010 is the first year men (4.6) exceed women (3.1) in the 20-64 group — a reversal of the
  historical women > men pattern.
- 2019 = 4.6 — **NOT reconstructed**: a published both-sexes total. OECD "Obese population, measured
  (age 15+)", Japan 2019, ultimately from the 2019 NHNS measured height/weight.
  SOURCE: MHLW, "Changes in Nutrition and Health in Japan" (English), final-page OECD country
  comparison (which also lists, measured 15+: US 42.8, UK 28.0, Canada 24.3 for 2019):
  https://www.mhlw.go.jp/content/000894105.pdf
  CAVEAT: age base is **15+** here (vs 20+ for the earlier points); Japanese 15-19-year-olds have
  near-zero obesity, so the 15+ figure is marginally *below* what a 20+ figure would be. This is the
  cleanest modern point (no sex-reconstruction), so it anchors the recent end of the series.

## China — `CHN.csv`  (national; CCDRFS, China CDC, adults 18-69, measured) — AGE-STANDARDISED (the one exception in this repo)

- China's NHANES-equivalent is the **China Chronic Disease and Risk Factor Surveillance (CCDRFS)**,
  run by the China CDC: six nationally representative surveys (2004, 2007, 2010, 2013, 2015, 2018),
  measured height/weight, adults **18-69**, n = 645,223.
- BASIS EXCEPTION — READ THIS: every other country here is **crude**; China is **age-standardised**
  (to the 2010 China census). This is the only nationally-representative measured series at the WHO
  **BMI &ge; 30** cutoff — China's own reports use the Chinese **BMI &ge; 28** cutoff, and *no crude
  &ge; 30 series is published* (the source paper computes standardised prevalence only; the word
  "crude" never appears in it). Standardising to China's own 2010 census is a far milder adjustment
  than the NCD-RisC modelling this repo otherwise rejects, but it is NOT crude — do not compare
  China's level too precisely against the crude countries. Because the sample aged over 2004-2018
  (mean age 44 -> 52), the crude figures would likely run somewhat ABOVE these standardised ones,
  especially by 2018.
- 2004 = 3.1, 2007 = 3.0, 2010 = 5.1, 2013 = 6.4, 2015 = 6.6, 2018 = 8.1 — standardised obesity
  (BMI &ge; 30), both sexes ("Both / Overall"), all six survey years. Note the genuine 2007 dip
  (3.1 -> 3.0) before the jump to 5.1 in 2010.
  SOURCE: Wang L et al. (2021), "Trends in body-mass index and obesity in urban and rural China:
  findings from consecutive nationally representative surveys during 2004-2018", *The Lancet*
  398:53-63, **Appendix Table 1** (the supplementary appendix; the manuscript text gives only the
  2004/2018 endpoints). https://pmc.ncbi.nlm.nih.gov/articles/PMC7617101/
  Local copies: data/tmp/EMS201458.pdf (manuscript) and
  data/tmp/EMS201458-supplement-Appendix.pdf (appendix, p.20-21 "Both/Overall" obesity row).
  For reference, the same table by sex (overall): men 2.6/2.4/5.1/6.3/6.8/9.0 and women
  3.7/3.6/5.2/6.6/6.5/7.2 — men start below women but overtake them, the BMI&ge;30 echo of the
  reversal seen in Japan/Korea.

## France — `FRA.csv`  (national; ENNS / Esteban, Santé publique France, adults 18-74, measured)

- France uses the standard WHO **BMI &ge; 30** cutoff (no Asia-Pacific complication). Its
  NHANES-equivalent measured surveys are run by Santé publique France: **ENNS 2006-2007** and
  **Esteban 2014-2016**, three-stage probability samples, measured height/weight, adults **18-74**.
- 2006-2007 = 16.9, 2014-2016 = 17.2 — measured obesity (BMI &ge; 30), total adults, both sexes
  (Esteban 2015 by sex: men 16.8 / women 17.4). The change 2006 -> 2015 was **not** statistically
  significant — measured French obesity has been flat at ~17%.
  SOURCE: Verdot et al. (2017), "Corpulence des enfants et des adultes en France métropolitaine en
  2015. Résultats de l'étude Esteban et évolution depuis 2006", *BEH* 2017;(13):234-41.
  https://beh.santepubliquefrance.fr/beh/2017/13/2017_13_1.html
- Only two measured points exist: France had **no** measured national nutrition survey before ENNS
  (2006). For a longer view you must use self-report, which this repo excludes (see next).
- NOT USED — the **ObÉpi-Roche** survey is France's famous long obesity series (triennial 1997-2012,
  then 2020), but height/weight are **self-reported**, so it is excluded here (self-report understates
  obesity). Its self-reported adult BMI &ge; 30 series, for reference: 1997 = 8.5, 2003 = 11.9,
  2006 = 13.1, 2009 = 14.5, 2012 = 15.0, 2020 = 17.0. The 2006 overlap is the clean proof of the bias:
  ObÉpi self-report **13.1** vs ENNS measured **16.9** the same year — a ~4 pp understatement. (Also
  note an internal ObÉpi break: 1997-2012 were mailed questionnaires; 2020 was online self-measurement
  by a different operator, so its apparent "catch-up" to 17% is partly a methodology change.)

## Germany — `DEU.csv`  (national; GNHIES98 / DEGS1, Robert Koch Institut, adults 18-79, measured)

- Germany uses the standard WHO **BMI &ge; 30** cutoff. Its NHANES-equivalent measured surveys are the
  RKI examination surveys: **GNHIES98/BGS98 (1998)** and **DEGS1 (2008-2011)**, both measured
  height/weight, nationally representative, adults **18-79**, and directly compared in one paper.
- Both points are **RECONSTRUCTED** 50/50 from the published **crude** by-sex prevalences (same method
  + caveat as Japan/Korea; Germany's adult sex ratio is ~50/50 and the male-female gap is small, so the
  approximation is tight):
  - 1998 = 20.7 — GNHIES98, crude: men 18.9% / women 22.5% -> (18.9+22.5)/2.
  - 2008-2011 = 23.6 — DEGS1, crude: men 23.3% / women 23.9% -> (23.3+23.9)/2.
  The rise is real and driven mainly by **men** (a statistically significant increase; the women's
  change was not significant). We use the **crude** figures; the paper also gives GNHIES98
  age-adjusted to the DEGS1 reference population (men 19.5 / women 23.1) — not used here.
  SOURCE: Mensink GBM et al. (2013), "Übergewicht und Adipositas in Deutschland: Ergebnisse der
  Studie zur Gesundheit Erwachsener in Deutschland (DEGS1)", *Bundesgesundheitsblatt* 56:786-794
  (English version: https://www.gbe-bund.de/pdf/DEGS1_Uebergewicht_Adipositas_E.pdf).
- Only two all-Germany measured points exist. NOT USED: the **GEDA** telephone surveys, the
  Telephone Health Survey 2003, and the **Mikrozensus** are **self-reported** (excluded, as elsewhere).
  Earlier RKI National Examination Surveys (1984-1992) were **West-Germany-only** with a different age
  base (pre-reunification), so they are not stitched onto the all-Germany series.

## Spain — `ESP.csv`  (national; ENRICA / ENPE, measured)

- Spain uses the standard WHO **BMI &ge; 30** cutoff. The famous long series (ENSE, Encuesta Nacional
  de Salud) is **self-reported** and excluded; the measured data comes from scientific studies.
- 2008-2010 = 22.9 — **ENRICA study**, measured, adults **18+**, crude, **published both-sexes total**
  (men 24.4 / women 21.4; n=12,883, household anthropometry). The cleanest Spanish point.
  SOURCE: Gutiérrez-Fisac et al. (2012), "Prevalence of general and abdominal obesity in the adult
  population of Spain, 2008-2010: the ENRICA study", *Obes Rev* 13:388-392.
  https://pubmed.ncbi.nlm.nih.gov/22151906/
- 2014-2015 = 21.6 — **ENPE study**, measured, crude, published total.
  CAVEAT: ages **25-64** only (vs 18+ for ENRICA), so it excludes the high-obesity 65+ group and the
  low-obesity 18-24 group; the apparent dip from 22.9 is partly this age-base difference, not a real
  decline. SOURCE: Aranceta-Bartrina et al. (2016), "Prevalence of General Obesity and Abdominal
  Obesity in the Spanish Adult Population (Aged 25-64 Years) 2014-2015: The ENPE Study",
  *Rev Esp Cardiol* 69:579-587. https://www.revespcardiol.org/en-prevalence-general-obesity-abdominal-obesity-articulo-S1885585716001225
- For reference, the diabetes-focused **Di\@bet.es** study (2009-2010, measured, 18+) reported higher
  obesity (~28-30% nationally), but with different sampling; not used, to keep ENRICA as the clean
  18+ anchor.

## Italy — `ITA.csv`  (national; CUORE Project HES, Istituto Superiore di Sanità, ages 35-74, measured) — AGE-STANDARDISED

- Italy uses the standard WHO **BMI &ge; 30** cutoff. The famous long series (ISTAT Multiscopo /
  "Aspetti della vita quotidiana", and PASSI) is **self-reported** and excluded. The only national
  **measured** survey is the cardiovascular **Health Examination Survey** of the CUORE Project (ISS),
  run 1998 / 2008 / 2018.
- TWO BASIS CAVEATS (read before comparing):
  1. **Age-standardised, not crude** — like China, the only available basis (the paper reports
     standardised prevalence only, to the Italian population of 2000/2010/2019). The second
     age-standardised series in this repo.
  2. **Ages 35-74**, not 18+ — it omits low-obesity young adults (18-34) and the 75+. This tends to
     *overstate* the all-adult rate relative to the 18+ countries. (Also: the source reports
     whole-percent values, so these carry ~+/-0.5 pp rounding.)
- 1998 = 18.0, 2008 = 23.5, 2018 = 21.5 — **RECONSTRUCTED** 50/50 from the published by-sex
  age-standardised prevalences: men 17/24/20 and women 19/23/23 for 1998/2008/2018. Note the genuine
  shape: a sharp 1998->2008 rise, then a 2008->2018 dip in men (24->20) while women held (23).
  SOURCE: Vannucci et al. / CUORE Project (2022), "Trends of overweight, obesity and anthropometric
  measurements among the adult population in Italy: The CUORE Project health examination surveys 1998,
  2008, and 2018", *PLOS One* 17(3):e0264778. https://pmc.ncbi.nlm.nih.gov/articles/PMC8887738/

## Brazil — `BRA.csv`  (national; IBGE surveys ENDEF/PNSN/POF/PNS, measured)

- Brazil uses the standard WHO **BMI &ge; 30** cutoff and has an unusually long **measured** lineage,
  all run by IBGE with measured anthropometry (portable digital scales + stadiometers): ENDEF
  (1974-75), PNSN (1989), POF (2002-2003 and 2008-2009), and the National Health Survey **PNS**
  (2013, 2019). The famous annual **VIGITEL** telephone survey is **self-reported** and excluded.
- 1974-1975 = 5.4, 1989 = 9.3, 2002-2003 = 11.3, 2008-2009 = 14.7 — **RECONSTRUCTED** 50/50 from the
  IBGE published by-sex obesity prevalences for adults **20+**: men 2.8/5.4/9.0/12.5 and women
  8.0/13.2/13.5/16.9. Note the documented Brazilian pattern hidden inside the totals: **women's**
  obesity plateaued 1989->2002 (13.2->13.5) while **men's** rose steadily — so the rise here is
  male-driven early on. SOURCE (verified against the primary): IBGE, *POF 2008-2009: Antropometria e
  estado nutricional de crianças, adolescentes e adultos no Brasil*, **Gráfico 16** (national adult
  20+ obesity by sex across the four surveys). https://biblioteca.ibge.gov.br/visualizacao/livros/liv45419.pdf
  (local copy: data/tmp/liv45419.pdf). The four-survey graph confirms men 2.8/5.4/9.0/12.4 and women
  8.0/13.2/13.5/16.9.
- 2013 = 20.8, 2019 = 25.9 — **published both-sexes totals**, PNS, measured, adults **18+** (2013:
  men 16.8 / women 24.4; 2019: men 21.8 / women 29.5). ~41 million obese adults in 2019.
  SOURCE: Ferreira et al. (2021), "Aumento nas prevalências de obesidade entre 2013 e 2019 ... PNS",
  *Rev Bras Epidemiol*. https://www.scielo.br/j/rbepid/a/QVtDq9fGVsG7JjwDZrTcXFh/
- Two small seams: the historical ENDEF/PNSN/POF points are **20+** while PNS is **18+** (minor:
  18-19 year-olds are few and rarely obese). And the 50/50 reconstruction slightly *underestimates*
  the total (women are a majority and have higher obesity) — checkable against PNS, where the
  published totals (20.8, 25.9) sit ~0.2 pp above the 50/50 of their by-sex values (20.6, 25.7).

## India — `IND.csv`  (national; NNMS 2017-18, ICMR-NCDIR, adults 18-69, measured) — single point

- THE PROBLEM (worse than China/Japan): India uses the Asian-Indian cutoffs (overweight BMI &ge; 23,
  obesity BMI &ge; 25), so a crude national **BMI &ge; 30** figure is almost never reported. The famous
  India "obesity" numbers — NFHS-5 ~24%, ICMR-INDIAB ~28.6% — are **BMI &ge; 25**, roughly 3x the
  &ge; 30 figure; do not conflate them.
- 2017-2018 = 9.3 — the **one** published national, crude, **measured** BMI &ge; 30 figure, from the
  **National NCD Monitoring Survey (NNMS)**, WHO-STEPS methodology (which uses the &ge; 30 standard),
  adults **18-69**, both sexes (men 5.8 / women 12.7; nationally representative, n~10,659 measured).
  India shows the same large female excess as Japan/Korea (women >2x men at BMI &ge; 30).
  SOURCE: ICMR-NCDIR, NNMS 2017-18 Fact Sheet, https://www.ncdirindia.org/nnms/resources/factsheet.pdf
  (analysis: https://pmc.ncbi.nlm.nih.gov/articles/PMC9150326/).
- SINGLE POINT — no trend: there is no comparable earlier national measured BMI &ge; 30 survey. **Not**
  stitched to NFHS: NFHS measures height/weight but reports BMI &ge; 23/25 and covers only reproductive
  age (women 15-49, men 15-54), so its BMI &ge; 30 (computable only from microdata) is a different,
  younger age base and not comparable to NNMS 18-69.

## South Africa — `ZAF.csv`  (national; SADHS, adults 18+, measured)

- Standard WHO **BMI &ge; 30** cutoff. The measured national series is the South African Demographic
  and Health Surveys (SADHS), adults **18+**, with **published both-sexes totals** (essential here —
  see the sex gap below — so no reconstruction).
- 1998 = 20.3 (men 10.1 / women 29.5), 2016 = 28.0 (men 12.1 / women 42.6). SADHS 1998 and SADHS 2016
  are the same DHS series, directly comparable. (The 2016 survey's report is sometimes dated 2017.)
- DEFINING FEATURE — an enormous sex gap: women's BMI &ge; 30 is ~3-4x men's, and the 1998->2016 rise
  is almost entirely **female-driven** (women 29.5 -> 42.6; men 10.1 -> 12.1, barely moving). Among
  South African **women**, obesity is >40% — comparable to US levels — a fact the both-sexes total
  understates. This is the largest sex gap in the panel.
- SANHANES-1 (2012, HSRC, ages 15+) measured men 10.6% / women 39.2% — consistent with and bracketed
  by the two SADHS points, but its both-sexes **total** is not cleanly published (and it is a
  different survey at 15+), so it is not added; it serves as a cross-check between 1998 and 2016.
- SOURCE: "Epidemiology of adult obesity" (SAMJ, 2025, SciELO) compiling SADHS measured surveys;
  original SADHS 1998 https://pubmed.ncbi.nlm.nih.gov/12376585/ and SADHS 2016 (Stats SA / NDoH).

## Finland — `FIN.csv`  (national; FINRISK / FinHealth, THL, measured)

- Standard WHO **BMI &ge; 30**. The strongest measured Nordic series: the THL examination surveys
  (FINRISK, then FinHealth), measured height/weight, probability samples.
- 1978-1980 = 14.6 (men 11.3 / women 17.9, ages **25-64**) and 2000-2001 = 22.4 (men 20.7 / women
  24.1, 25-64) — **RECONSTRUCTED** 50/50 from the published by-sex FINRISK prevalences.
  SOURCE: Lahti-Koski et al., "Twenty-year changes in the prevalence of obesity among Finnish adults",
  https://pubmed.ncbi.nlm.nih.gov/19874529/
- 2017 = 25.0 — FinHealth 2017 (THL), measured, "~1 in 4" adults **30+** obese.
  SOURCE: THL FinHealth 2017. CAVEAT: age base shifts to **30+** here (vs 25-64 earlier); the 30+ base
  runs a bit higher (includes high-obesity 65+, drops low-obesity 25-29), so part of the 22.4 -> 25.0
  step is the age-base change, not all real.

## Norway — `NOR.csv`  (HUNT Study, measured) — REGIONAL (Nord-Trøndelag), used as broadly national

- Standard WHO **BMI &ge; 30**, measured. Norway has **no national** measured obesity survey; the
  reference series is the **HUNT Study** — but it covers **one county (Nord-Trøndelag)**, not all of
  Norway (rural-leaning, so likely a touch higher than a true national figure). Treated as broadly
  representative here, flagged like the GBR=England series.
- 1984-1986 = 10.5, 1995-1997 = 16.4, 2006-2008 = 22.6 — HUNT1/2/3, **RECONSTRUCTED** 50/50 from the
  published by-sex prevalences (men 7.7/14.4/22.1; women 13.3/18.3/23.1). Note men overtook women by
  HUNT3. SOURCE: Midthjell et al. (2013), "Trends in overweight and obesity over 22 years ... the HUNT
  Study", https://pmc.ncbi.nlm.nih.gov/articles/PMC3734732/

## Sweden — `SWE.csv`  (HPI occupational cohort, measured) — NOT a probability sample

- Standard WHO **BMI &ge; 30**, measured. Sweden has **no measured national probability survey** of
  obesity (the official national figures are self-reported, ~15-16%). The only large *measured* source
  is occupational-health "Health Profile Assessments".
- 1995 = 9.1, 2017 = 17.0 — measured, but from **employed working-age adults who underwent health
  profiles**, not a random national sample (so likely *understates* — employed/health-engaged people
  skew leaner). Treat as indicative, not strictly comparable to the probability-sample countries.
  SOURCE: Hemmingsson et al. (2021), "Prevalence and time trends of overweight, obesity and severe
  obesity in 447,925 Swedish adults, 1995-2017", https://pmc.ncbi.nlm.nih.gov/articles/PMC8135248/

## Denmark — `DNK.csv`  (national; SUSY, adults 16+, SELF-REPORTED) — the one self-reported series here

- READ THIS FIRST — BASIS EXCEPTION: Denmark is the **only self-reported series in the panel**. Every
  other country's self-reported source (France ObÉpi, Brazil VIGITEL, Spain ENSE, UK self-report
  waves, Sweden's official figures, etc.) was *excluded*; Denmark is included **by request** because
  it is the only way to cover the country — Denmark has no usable measured national survey (the
  measured DANHES 2007-2008 had a ~10% participation rate in 13 municipalities). Do **not** compare
  Denmark's level head-to-head with the measured countries: self-report understates obesity, so the
  true Danish figures are higher than shown (the measured countries would all shift up similarly, but
  Denmark alone is on the lower self-report basis).
- The series is the **Danish National Health & Morbidity Surveys (SUSY)**, adults **16+**, height and
  weight **self-reported but calibration-corrected** (the authors applied correction equations from
  15,692 people with both self-reported and measured data — so it is "self-report nudged toward
  measured", better than raw self-report but still not measured).
- 1987 = 6.1 and 2021 = 18.4 are exact (stated in the source text); the intermediate waves
  (1994 = 9.5, 2000 = 12.3, 2005 = 14.8, 2010 = 17.6, 2013 = 18.6, 2017 = 20.5) are read from the
  paper's figure and are approximate (~&plusmn;0.5 pp). Note the 2017 -> 2021 *fall* (20.5 -> 18.4) —
  possibly a real dip or a methodology artefact in the latest wave.
  SOURCE: "Changes in adult obesity prevalence in Denmark, 1987-2021: age-period-cohort analysis of
  nationally representative data", *Eur J Public Health* 33(3):463.
  https://academic.oup.com/eurpub/article/33/3/463/7058153

## Türkiye — `TUR.csv`  (national; WHO STEPS, adults 15+, measured)

- Türkiye uses the standard WHO **BMI &ge; 30** cutoff. Coded `TUR`; named *Türkiye* (the official
  English name since 2022).
- THE BASIS PROBLEM: the famous long Turkish measured series is **TURDEP** (the Turkish Diabetes
  Epidemiology Study), TURDEP-I (1997-98) and TURDEP-II (2010), measured, adults 20+, run in the same
  centres 12 years apart. Its headline obesity totals — **22.3%** (1998) and **31.2%** (2010) — are
  **age-standardised, NOT crude**: with women ~55% of the sample at 32.9%/44.2% obesity vs men
  13.2%/27.3%, a crude both-sexes total would be ~24% / ~37%, well above the published 22.3 / 31.2.
  So the TURDEP headline figures are the wrong basis for this crude repo and are **not used** —
  but they document Türkiye's steep real rise to ~2010, and the by-sex figures are the cleanest
  long record (SOURCE: Satman et al., TURDEP / TURDEP-II, *Eur J Epidemiol* 2013;28:169-180,
  https://pubmed.ncbi.nlm.nih.gov/23407904/). The other widely-circulated number is the **Eurostat
  self-reported** series (~21%), excluded here as self-report.
- 2017 = 28.8, 2023 = 25.4 — **WHO STEPS** (National Household Health Survey – Prevalence of NCD
  Risk Factors), measured height/weight, **crude**, both sexes, BMI &ge; 30, adults **15+**, all 12
  regions. Published both-sexes totals. By sex: 2017 women **35.9** / men ~21.6; 2023 women **30.8**
  / men ~20.0 (the men figures are approximate, read from the World Obesity STEPS compilation; the
  totals and women's rates are source-stated). Note the modest 2017&rarr;2023 **decline** (28.8&rarr;25.4),
  driven by women (35.9&rarr;30.8) — possibly real, possibly a methodology/sampling artefact in the
  latest wave; treat the two-point STEPS series cautiously.
  CAVEAT: age base is **15+** (15-17 year-olds have low obesity, so 15+ runs marginally below a 20+
  figure — same seam as NZ/Japan-2019). Only the two STEPS waves are carried (crude + measured +
  comparable instrument); they do not reach back to the TURDEP era, so the CSV understates Türkiye's
  full historical climb.
  SOURCE: WHO Europe / Türkiye Ministry of Health STEPS 2017 (https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/turkey/who-turkey-risk-factors-a4_eng.08_10_2018.pdf)
  and STEPS 2023 (WHO Türkiye, fieldwork Sep-Nov 2023, n&gt;6000;
  https://www.who.int/europe/news/item/28-05-2025-turkiye-completes-national-household-survey-on-noncommunicable-disease-risk-factors).
  Compiled with sex splits in the World Obesity Türkiye adult report card
  (https://data.worldobesity.org/country/turkey-219/).

## Argentina — `ARG.csv`  (national/urban; ENFR-2018 + ENNyS 2, adults 18+, measured)

- Argentina uses the standard WHO **BMI &ge; 30** cutoff. WHY ONLY ~2018 ONWARD (vs Brazil's long
  measured lineage): Argentina had **no national measured adult anthropometry until 2018**. Its
  flagship risk-factor survey, the **ENFR** (Encuesta Nacional de Factores de Riesgo), used
  **self-reported** height/weight in its 1st-3rd editions — 2005 = 14.6%, 2009 = 17.4%, 2013 = 20.8%
  obesity, *autorreporte* (explicitly: "no se realizaron mediciones antropométricas"), so those are
  excluded. The first nutrition survey **ENNyS 1 (2004-05)** measured only children and women of
  reproductive age, not adult men. So unlike Brazil — whose IBGE has measured adults since 1974
  (ENDEF) — Argentina's *measured* adult record begins in 2018. Two independent national measured
  surveys landed that year and **agree**:
- 2018 = 32.4 — **4th ENFR (2018)**, the first ENFR with an **objective-measurement** module
  (peso/talla measured at home; n~12,871). Crude, both sexes, BMI &ge; 30. Measured obesity 32.4%
  (overweight 33.7%, excess weight 66.1%) — vs the **self-reported** 25.4% in the very same survey:
  a ~7 pp measured-vs-self-report gap, the textbook understatement this repo screens for.
  Measured **by sex**: men 31.4% / women 33.4% (small, non-significant female excess; Cuadro 6.5).
  VERIFIED against the primary report: the measured subsample is **18+** (national, localities
  &ge;5,000 inhabitants), and the figures are **crude** (survey-weighted, not age-standardised).
  SOURCE: INDEC / Secretaría de Gobierno de Salud, *4ª ENFR 2018, Resultados definitivos* (Oct 2019),
  ch. 6 "Peso corporal", Gráfico 8 (p.131) and **Cuadro 6.5** (p.138, mediciones antropométricas):
  https://www.indec.gob.ar/ftp/cuadros/publicaciones/enfr_2018_resultados_definitivos.pdf
  (NOT the CONICET dataset by Pou & Aballay, https://ri.conicet.gov.ar/handle/11336/161347, which
  gives ENFR obesity by province but from **self-reported** weight/height.)
- 2018-2019 = 33.9 — **2ª Encuesta Nacional de Nutrición y Salud (ENNyS 2)**, anthropometry
  **measured** by trained nutritionists, adults **18+**, crude, **published both-sexes total**
  (overweight 34.0% + obesity 33.9% = excess weight 67.9%; n~7,367 adults). The two 2018 measured
  estimates — ENFR 32.4 and ENNyS 2 33.9, **both 18+** — bracket ~33%, well within the
  sampling/method differences between two independent national surveys.
  CAVEAT: ENNyS 2 sampled **urban localities of &ge;5,000 inhabitants** only (no rural/small-town
  coverage); ~92% of Argentines are urban, so it is broadly national but flagged `coverage=national`
  with this note.
- NO PRE-2018 NATIONAL MEASURED POINT — the only earlier *measured* adult data is **sub-national**:
  the **CESCAS I** study (2010-2011, measured, adults **35-74**) sampled two Argentine cities —
  Marcos Paz (44.7% obese) and Bariloche (32.2%) — not added here (two cities, restricted age base;
  pooled Southern-Cone obesity 35.7%). SOURCE: Rubinstein et al., *PLOS One* 2016,
  https://pmc.ncbi.nlm.nih.gov/articles/PMC5065193/.
- `obesity-by-sex.csv` carries the **ENFR-2018 measured** sex split (men 31.4 / women 33.4, Cuadro
  6.5). ENNyS 2's by-sex measured obesity is not separately added — its priority-indicator report
  gives the adult total and an age breakdown, not a clean obesity-by-sex table.
  SOURCE (ENNyS 2): *Indicadores priorizados* (2019),
  https://fagran.org.ar/wp-content/uploads/2020/01/Encuesta-nacional-de-nutricion-y-salud.pdf
  (cross-check: World Obesity Argentina report card, https://data.worldobesity.org/country/argentina-7/).

## Russia — `RUS.csv`  (national; RLMS-HSE + ESSE-RF, measured)

- Standard WHO **BMI &ge; 30**, crude, measured. Russia has two strong *measured* national sources,
  and the CSV uses both: the **RLMS-HSE** (Russia Longitudinal Monitoring Survey — HSE) household
  panel for the long trend, and the one-off multicentre **ESSE-RF** examination survey for a recent
  published both-sexes anchor.
- 1994 = 20.3 and 2004 = 28.0 — **RLMS-HSE**, measured anthropometry, nationally representative adult
  sample, **published, population-weighted both-sexes** prevalences from Huffman & Rizov: obesity rose
  exactly **+38%** across the post-Soviet transition decade (20.3 &times; 1.38 = 28.0, so both endpoints
  are the source's own figures, not rounded). By sex: 1994 women **27.8** / men **9.5**; 2004 women
  **36.6** / men **16.3** — note the large female excess (women ~3&times; men in 1994), narrowing only
  slightly by 2004. VERIFIED against the article's Introduction (which states these exact values).
  SOURCE: Huffman & Rizov, "Determinants of obesity in transition economies: the case of Russia",
  *Economics and Human Biology* 5(3):379-391, https://pubmed.ncbi.nlm.nih.gov/17702676/.
  - RLMS = MEASURED (not self-reported): the interviewer records height/weight with scale & stadiometer.
    Confirmed by Jahns, Baturin & Popkin, "Obesity, diet, and poverty: trends in the Russian transition
    to market economy", *Eur J Clin Nutr* 57:1295 (https://www.nature.com/articles/1601691 — RLMS gives
    "measured height and weight") and by Kozlov et al. (the RLMS 1994-2012 obesity-trends paper,
    https://rlms-hse.cpc.unc.edu/publications/bib/2785/), which reports the same measured uptrend
    (~+0.4 pp/yr in the general adult population 2000-2012 — i.e. ~28% in 2004 drifting to ~31% by 2012,
    which the ESSE-RF 30.3% below corroborates). So the 20.3/28.0 trend is both primary-sourced (the
    exact Huffman & Rizov values) and triangulated across the Kozlov RLMS series + ESSE-RF.
  - AGE BASE — CONFIRMED `18+`: Huffman & Rizov state the estimation sample is "6424 individuals
    (age 18 and over)" (p. 381, Data and methods), so the `18+` label in the CSV is the source's own
    explicit lower cut, not an inference from RLMS convention. (Some other RLMS analyses, e.g. Jahns,
    restrict to working-age adults — a base that would drop high-obesity elderly and sit a touch low —
    but that does not apply here.) The age base is now primary-sourced from the article itself.
  - NOT USED — the Rosstat trap: the widely-circulated Rosstat "Sample Survey of Population Diets"
    series (2013-2023; e.g. 2023 men 17.3 / women 24.2) is **self-reported** — Rosstat recorded height
    and weight "from the respondents' words without objective measurements" from 2013 on — so it
    understates and is excluded here (it would also clash with the measured RLMS/ESSE-RF basis).
- 2012-2014 = 30.3 — **ESSE-RF** (Epidemiology of Cardiovascular Diseases in the Regions of the
  Russian Federation), measured height/weight standardised to WHO protocol, **crude**, **published
  both-sexes total**, adults **25-64**, n = 20,190 across 13 regions (men 27.5 / women 31.4).
  SOURCE: Balanova et al. / Shalnova et al., "Overweight and Obesity in the Russian Population",
  *Obesity Facts* 12(1):103-114, https://karger.com/ofa/article/12/1/103/239609/ (PubMed 30844809).
- CAVEAT — two instruments, one seam: RLMS (adult household panel, 18+) and ESSE-RF (25-64 examination
  survey) are different designs, so the 2004&rarr;2013 step (28.0&rarr;30.3) is partly a method/age-base
  change, not all real. Both are measured and crude, so they sit on the same basis; the consistent
  ~28-30% level across the two is reassuring. The famous female skew holds (women > men throughout),
  with men catching up fastest after 2005.

## Indonesia — `IDN.csv`  (national; RISKESDAS / Basic Health Research, adults 20+, measured)

- THE BASIS PROBLEM (same as India): Indonesia uses the **Asian-Indonesian cutoff** — Gurrici et al.
  (1998) put the obesity threshold at **BMI &ge; 27**, not 30 — so the national **RISKESDAS** reports
  headline obesity at **&ge; 27** (10.5% in 2007 rising to 21.8% in 2018, adults 18+). Those are **not**
  BMI &ge; 30 and must not be conflated with this repo's series (they run roughly double).
- 2007 = 3.7, 2013 = 5.8, 2018 = 9.8, 2023 = 10.4 — the crude national **BMI &ge; 30** both-sexes
  totals, computed from the pooled **RISKESDAS / Basic Health Research** waves (Indonesia MoH /
  Balitbangkes), measured height/weight, adults **20+**, ~2.4 million adults pooled. Obesity at the
  WHO &ge; 30 standard nearly **tripled** 2007&rarr;2023. These appear as the WHO-cutoff comparison in:
  SOURCE: "Trends in the double burden of malnutrition among Indonesian adults, 2007 to 2023",
  *Scientific Reports* (2025), https://pmc.ncbi.nlm.nih.gov/articles/PMC12504651/ (the paper's
  *primary* analysis uses the &ge; 25 Asian cutoff; the &ge; 30 figures are its WHO-standard sensitivity
  series — that is what is carried here).
- WHY RISKESDAS, NOT IFLS: the **Indonesia Family Life Survey (IFLS)** also measures height/weight
  and does reach BMI &ge; 30, but it covers only **13 of 27 provinces (~83% of the 1993 population)**
  and publishes &ge; 30 mostly in figures / by sex (e.g. Roemling & Qaim, *Appetite* 2012, headline a
  &ge; 27 cutoff), so it is **not** added — RISKESDAS is fully national (514 districts) with a clean
  published &ge; 30 both-sexes total. The large female excess (as in India/Japan/Korea) holds in both.

## Saudi Arabia — `SAU.csv`  (national; Al-Nuaim 1990-93, CADISS 1995-2000, SHIS 2013, measured)

- Standard WHO **BMI &ge; 30**, crude, measured. Three national **measured** household/examination
  surveys span ~1992 to 2013 — but on **different age bases**, which drives most of the wiggle.
- 1990-1993 = 22.1 — **Al-Nuaim** national epidemiological household survey, measured, adults **15+**,
  n = 13,177, **published both-sexes total** (men ~16 / women ~24). SOURCE: Al-Nuaim et al., "High
  prevalence of overweight and obesity in Saudi Arabia", https://pubmed.ncbi.nlm.nih.gov/8782731/
  (the 22.1% total is restated in Al-Nozha 2005, below).
- 1995-2000 = 35.6 — **CADISS** (Coronary Artery Disease in Saudis Study), a 5-year national measured
  survey, n = 17,232, **crude** both-sexes total 35.6% [95% CI 34.9-36.3] (age-adjusted 35.5% —
  essentially identical), men 26.4 / women 44.0. CAVEAT: age base is **30-70**, not 15+ — it excludes
  the lean 15-29 group, so it runs **high** relative to the 15+ points; the 22.1&rarr;35.6 jump is partly
  this age-base change, not all real. SOURCE: Al-Nozha et al., "Obesity in Saudi Arabia", *Saudi Med J*
  26(5):824-829, https://smj.org.sa/content/smj/26/5/824.full.pdf. (Consistent with the ~36% from the
  2005 WHO STEPS-aligned national survey.)
- 2013 = 28.7 — **SHIS** (Saudi Health Interview Survey), height/weight measured at the household,
  **crude**, **published both-sexes total**, adults **15+**, n = 10,735 (men 24.1 / women 33.5).
  SOURCE: Memish et al., "Obesity and Associated Factors — Kingdom of Saudi Arabia, 2013",
  *Prev Chronic Dis* 11:E174, https://www.cdc.gov/pcd/issues/2014/14_0236.htm.
- THE 1997&rarr;2013 "FALL" (35.6&rarr;28.7) IS NOT A REAL DECLINE — it is an **age-base artifact**. The
  honest read holds the age base constant: the two **15+** probability surveys, **Al-Nuaim 1990-93 =
  22.1** and **SHIS 2013 = 28.7**, rise **monotonically**. CADISS's 35.6 sits high only because it is
  ages **30-70** (it drops the lean 15-29s); restrict SHIS to 30-70 and it climbs back to ~35% (SHIS
  obesity peaks >40% in the 45-64 ages), i.e. the two surveys agree once the base matches. So the
  series is a steady **rise** 1991&rarr;2013, not a hump. The female skew (women ~1.4x men) persists.
- WHY NO POST-2013 POINT (all rejected against this repo's measured-probability-sample bar) — checked
  in two 2023-24 Saudi reviews (Al-Omar et al., *Saudi Pharm J* 32:102192,
  https://www.sciencedirect.com/science/article/pii/S1319016424002433; and the anthropometry review
  *Healthcare* 2023, 11, 1982): **(a)** the widely-cited **37.7%** is **OECD-modelled** (*The Heavy
  Burden of Obesity*, 2019) — modelled, not a survey, excluded like all NCD-RisC/GHO figures here;
  **(b)** **Alghnam et al. 2021 = 38.96%** (n=615,768) is a **National Guard EHR / clinic** population,
  not a probability sample (sicker/older skew, biased high); **(c)** **Althumiri et al. 2021** ("Sharik"
  national survey, ~24%) and **(d)** **WHS-KSA 2019** (MOH, 20%) are both **self-reported** (understate).
  None is measured + national + probability, so SHIS 2013 remains the most recent qualifying point.

## Chile — `CHL.csv`  (national; ENS 2003 / 2009-2010 / 2016-2017, MINSAL / PUC, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**. Chile has a clean three-wave national
  measured series: the **Encuesta Nacional de Salud (ENS)**, run by MINSAL and executed by the
  Pontificia Universidad Católica de Chile — random, stratified, multistage probability samples with
  anthropometry **measured** by trained nurses at the household.
- THE CATEGORY-SUM POINT: the ENS reports obesity split into **`obesidad`** (BMI 30-39.9) and
  **`obesidad mórbida`** (BMI &ge; 40) as mutually-exclusive adjacent categories. This repo's series
  is **total BMI &ge; 30 = the sum of the two**, which is exactly how the primary trend article
  reports it ("la obesidad, incluyendo la obesidad mórbida, aumentó de 23,2% el 2003 a 34,4% el
  2016"). VERIFIED against the primary PDF (Vio et al. 2019) and the MINSAL *Primeros Resultados*:
  - 2003 = **23.2** — ENS 2003 (obesidad 21.9 + mórbida 1.3), adults **17+**, n = 3,619. (Excess
    weight 37.8 + 21.9 + 1.3 = 61.0%, the published "61%".)
  - 2009-2010 = **27.4** — ENS 2009-2010 (obesidad 25.1 + mórbida 2.3), adults **15+**, n = 5,412.
    (Excess weight 39.3 + 25.1 + 2.3 = 66.7%, the published "66,7%".)
  - 2016-2017 = **34.4** — ENS 2016-2017 (obesidad 31.2 + mórbida 3.2), adults **15+**, n = 6,233.
    (Excess weight 39.8 + 31.2 + 3.2 = 74.2%, the published "74,2%".) By sex (Primeros Resultados,
    internally consistent with the 34.4 total): men 28.6 + 1.7 = **30.3** / women 33.7 + 4.7 =
    **38.4** (the usual large female excess; Vio's text prints women 39.4, an apparent typo).
  AGE-BASE SEAM (VERIFIED in the Primeros Resultados methods table): 2003 is **17 y más años**
  while the two later waves are **15 y más años** — a minor downward base shift (adds lean 15-16s)
  that slightly *understates* the 2003&rarr;later rise, not inflates it. All three are
  Nacional/urbano-rural probability samples (2003 also covered the VIII región specifically).
- THE 2009-2010 RE-TABULATION WRINKLE (why 27.4, not 25.1): the **original** ENS 2009-2010 figures
  (obesidad 25.1 + mórbida 2.3 = 27.4, excess 66.7%) are used here — they are the survey's own
  published headline and the source of the famous "two-thirds overweight/obese" (66.7%) statistic.
  The ENS 2016-2017 *Primeros Resultados* **re-plots** 2009-2010 slightly lower (obesidad 22.9 +
  mórbida 2.2 = 25.1, excess 64.4%), evidently a re-weighted reanalysis for cross-wave comparison.
  Per this repo's "original survey observation" rule the published 27.4 is kept; the re-tabulated
  25.1 is noted here for transparency (it would shave ~2.3 pp off the 2009-2010 point).
- SOURCE (all three waves, with the obesidad/mórbida split and the 23.2&rarr;34.4 total trend):
  **Vio et al.**, "Descripción de la progresión de la obesidad y enfermedades relacionadas en Chile"
  ("Increasing frequency of obesity in Chile"), *Rev Méd Chile* 147(9):1114-1121 (2019),
  https://www.scielo.cl/scielo.php?script=sci_arttext&pid=S0034-98872019000901114. ENS 2016-2017
  primary results + the three-wave methods/sample table and the by-sex BMI distribution: MINSAL,
  *Encuesta Nacional de Salud 2016-2017, Primeros resultados* (15+, n = 6,233).
- These are **crude** survey-weighted prevalences (the ENS headline figures), not age-standardised.

## Peru — `PER.csv`  (national; ENPPE 1975, ENIN 2005 (CENAN), ENDES 2014/2022, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**. Peru has one of the longer Latin-American
  measured lineages, but stitched across two institutions: the early anchors are CENAN
  (Centro Nacional de Alimentación y Nutrición) nutrition surveys; the recent points are INEI's
  **ENDES** (Encuesta Demográfica y de Salud Familiar), which added **measured** adult anthropometry
  (15+) only from ~2013-2014 — before that ENDES weighed only children and women 15-49.
- 1975 = **9.0** — **ENPPE 1975** (Evaluación Nutricional de la Población Peruana), Peru's first
  national adult anthropometry, measured, both sexes (women 10.9 / men 5.2). CAVEAT: obesity was
  concentrated in Lima Metropolitana and the coast; treat the national figure as an early anchor.
  SOURCE: Pajuelo, "Estado Nutricional del Adulto en el Perú", *Acta Méd Peru* 16:22-32 (1992),
  restated in Pajuelo-Ramírez, "La obesidad en el Perú", *An Fac Med* 78(2):73-79 (2017),
  http://www.scielo.org.pe/pdf/afm/v78n2/a12v78n2.pdf.
- 2004-2005 = **14.2** — **ENIN 2005** (Encuesta Nacional de Indicadores Nutricionales, Bioquímicos,
  Socioeconómicos y Culturales, CENAN/INS), an ENPPE-style national resurvey ~30 yr later, measured,
  adults 20+, both sexes. SOURCE: same Pajuelo-Ramírez 2017 review (its ref 19, CENAN/INS Lima 2005).
- 2014 = **20.9** and 2022 = **27.3** — **ENDES** (INEI), measured height/weight, **published
  both-sexes totals**, adults **18+** — the cleanest internally-consistent recent trend (a repeated
  cross-section on a fixed 18+ base). SOURCE: Bernabe-Ortiz, Carrillo-Larco et al., "Eligibility for
  obesity management in Peru: Analysis of National Health Surveys from 2014 to 2022",
  https://pmc.ncbi.nlm.nih.gov/articles/PMC11474143/ ("obesity ... increased from 20.9% to 27.3%").
  CROSS-CHECK: a 2024 systematic review/meta-analysis (Cardenas et al.,
  https://pmc.ncbi.nlm.nih.gov/articles/PMC11869839/) puts ENDES 2022 at 25.65% on a **20-99** base —
  the small gap vs 27.3 is the age-base/weighting difference; the 18+ ENDES series is used here for
  internal consistency with the 2014 point.
- AGE-BASE SEAM: the two CENAN anchors are **20+** and the ENDES points are **18+** (a minor base
  shift). Heterogeneous-but-honest, in the spirit of the rest of this panel.

## Egypt — `EGY.csv`  (national; WHO/MoHP STEPwise 2012 & 2017, 100 Million Seha 2019, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **published both-sexes totals**. Three
  national measured surveys span 2011-2019. WHY NO PRE-2011 BOTH-SEXES POINT: Egypt's long measured
  anthropometry is the **DHS/EHIS** lineage (Egypt Demographic & Health Surveys 1992-2014, then the
  Egypt Family Health Survey 2021), but those measured **only ever-married women aged 15-49** — a
  women-only series rising ~23% (1992) &rarr; ~56% (2021), *not* a both-sexes total and not carried
  here. Adult **men** were first measured nationally in the **2011-2012 STEPS**, so the both-sexes
  record begins in 2011. (The frequently cited single-governorate / clinic studies — e.g. the 2004
  4-governorate PHC survey, mean BMI 28.1 — are sub-national and excluded.)
- 2011-2012 = 31.3 — **WHO EMRO / Ministry of Health & Population STEPwise survey**, measured
  height/weight, **crude both-sexes total**, ages **15-65**, multistage household sample across 10
  governorates (designed as the national NCD risk-factor baseline; released Dec 2012). Overweight
  62.2%. SOURCE: WHO EMRO, "Results of national STEPwise survey released" (20 Dec 2012),
  http://www.emro.who.int/egy/egypt-events/ncd-launch-dec-12.html (the 31.3% total is restated as the
  2012 comparator in the 2017 STEPS Facts & Figures sheet below).
- 2017 = 35.7 — **Egypt National STEPwise Survey 2017** (MoHP / CAPMAS / WHO), national household
  survey, measured, **crude both-sexes total** [95% CI 34.1-37.3], ages **15-69**, 6,680 households
  (94.3% response). Strong female skew: **men 24.8 / women 48.8** (mean BMI 28.2). SOURCE: WHO Egypt,
  *Egypt STEPS Survey 2017 — Facts & Figures*,
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/egpyt/steps/egypt-steps-survey-2017-facts-and-figures.pdf
  (the same sheet's 2012-vs-2017 comparison panel gives the 31.3% &rarr; 35.7% rise).
- 2019 = 39.8 — **"100 Million Seha" (100 Million Healthy Lives) initiative**, the mass national
  screening that measured ~49.7 million adults, **crude both-sexes total**, ages **18+**
  (men 29.5 / women 49.5). Not a probability *survey* but a near-census screening; included as a
  published measured both-sexes total. SOURCE: Aboulghate et al., "The Burden of Obesity in Egypt",
  *Front Public Health* 9:718978, https://pmc.ncbi.nlm.nih.gov/articles/PMC8429929/.
- AGE-BASE SEAM: the two STEPS points are **15+** (15-69 / 15-65, so they include the lean 15-17s and
  run marginally below an 18+/20+ base — same seam as Türkiye 15+ and NZ); the 2019 point is **18+**.
  Part of the 35.7&rarr;39.8 jump is therefore the base change, not all real growth — but the direction
  (a steep rise, women ~2x men) is unambiguous and consistent across all three.

## Netherlands — `NLD.csv`  (RIVM monitoring projects + Nederland de Maat, measured) — SUB-NATIONAL / RECONSTRUCTED

- Standard WHO **BMI &ge; 30**, **crude**, **measured**. THE DUTCH MEASUREMENT PROBLEM: the long
  *national* Dutch obesity series (CBS / RIVM Health Survey, 1981&rarr;2023, ~5%&rarr;16%) is
  **self-reported** — RIVM/CBS themselves note "a lack of data on national prevalence based on
  **measured** height and weight." To stay on this repo's measured bar we instead use the **RIVM
  measured monitoring projects**, which are **measured** but **sub-national** (specific municipalities,
  not a national probability sample) and published **by sex only** — so every total here is
  **RECONSTRUCTED** as the 50/50 male/female average (same convention as JPN/DEU). Carried for
  coverage; treat the level cautiously and watch the age-base seams.
- 1976-1980 = 5.6 — **Consultation Bureau Heart Project (CBHP)**, measured, **50/50 of men 4.9 / women
  6.2**. CAVEAT: this early anchor is the narrow **37-43** age band (the only band followable back to
  the 1970s), so it is *not* on the 20-59 base of the next two points — being middle-aged it if
  anything runs **high** vs a 20-59 figure, so the true rise off a constant base is even steeper.
- 1993-1997 = 9.1 — **MORGEN** (Monitoring Project on Risk Factors for Chronic Diseases), measured,
  ages **20-59**, **50/50 of men 8.5 / women 9.6**. Run in three municipalities (Amsterdam, Doetinchem,
  Maastricht) &mdash; hence sub-national.
- 1998-2002 = 11.2 — **REGENBOOG** (the Health Examination Survey of the Risk Factors & Health project,
  RIVM + municipal health centres), measured, ages **20-59**, **50/50 of men 11.5 / women 11.0**
  (n = 1809 men + 1882 women). This is the cleanest comparator to MORGEN (same RIVM monitoring lineage,
  same **20-59** base): a real ~9.1&rarr;11.2 rise across the 1990s. SOURCE: Visscher et al. (2006),
  "Underreporting of BMI in adults...", *Obesity* 14(11):2054-2063 (the measured arm of that
  underreporting study; reported/self-report obesity in the same sample was only men 8.5 / women 7.7 —
  the ~3 pp measured-vs-self-report gap this repo screens for).
- 2009-2010 = 13.5 — **Nederland de Maat Genomen** ("The Netherlands Measured", RIVM health
  examination survey), measured, **national sample** (n &asymp; 4,500), ages **30-70**,
  **50/50 of men 13 / women 14**. The one *national* measured point; note its **30-70** base (drops the
  lean 20-29s, adds the 60-70s) runs a touch high vs the 20-59 points, so part of the 11.2&rarr;13.5 gap
  is the base change. SOURCE: RIVM, *Nederland de Maat Genomen, 2009-2010*,
  https://www.rivm.nl/nederland-maat-genomen/wat-zijn-belangrijkste-resultaten.
- SOURCE for the 1976-1997 measured trend: Visscher, Kromhout & Seidell (2002), "Long-term and recent
  time trends in the prevalence of obesity among Dutch men and women", *Int J Obes* 26:1218-1224,
  https://pubmed.ncbi.nlm.nih.gov/12187399/ (CBHP 1976-80, Monitoring Cardiovascular Diseases 1987-91,
  MORGEN 1993-97; long-term band ages 37-43, recent band ages 20-59).
- WHY NO POST-2010 POINT: after Nederland de Maat (2009-2010) the national monitoring reverted to the
  **self-reported** CBS Health Survey (excluded here); the Doetinchem Cohort continued (rounds to
  2013-17) but is a **closed, ageing** cohort (the same people get older each round), so its rising
  prevalence is confounded by ageing and it is not a repeated cross-section — not used.
- AGE-BASE SEAM: bands shift **37-43 &rarr; 20-59 &rarr; 20-59 &rarr; 30-70** across the four points; the
  trend (a clear secular rise) is robust to this, but the *levels* are not strictly comparable
  point-to-point. Sub-national + reconstructed + heterogeneous base — the weakest series in the panel,
  kept only because there is no national measured Dutch alternative.

## Thailand — `THA.csv`  (national; TFCS 2004-05, NHES V 2014 & VI 2019-20, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. THE CUTOFF PROBLEM: almost every
  Thai obesity figure in circulation uses the **Asia-Pacific cutoff BMI &ge; 25** (e.g. NHES VI headline
  "obese" = 37.8% men / 46.4% women) — *not* the WHO BMI &ge; 30 used in this repo. The WHO &ge;30 numbers
  exist but are buried inside the NHES report BMI-distribution tables; the values here are read from the
  **&ge;30 row** of those tables, so they are the genuine crude BMI &ge; 30 prevalences, not the &ge;25
  headline.
- 2004-2005 = 4.8 — **National Thai Food Consumption Survey (TFCS)**, measured, **published total**
  (men 2.2 / women 7.3), adults **19+**, n = 4,286. CAVEAT: this is a *different instrument* from the
  NHES and reads **low** (a food-consumption survey with an anthropometry module); used only as the
  early crude anchor — do not read the 4.8&rarr;10.8 step as all-real, part is the instrument change.
  SOURCE: Aekplakorn et al., "Prevalence of overweight and obesity in Thai population: Results of the
  National Thai Food Consumption Survey", https://pmc.ncbi.nlm.nih.gov/articles/PMC5824639/.
- 2014 = 10.8 — **5th National Health Examination Survey (NHES V)**, measured, **50/50 reconstructed**
  from men 8.5 / women 13.1, adults **15+** (n = 8,160 men + 11,171 women). Crude, read from NHES V
  report Table 5.1.3 (the &ge;30 row). SOURCE: Aekplakorn (ed.), *Thai NHES V report* (HSRI),
  ch.5 ภาวะสุขภาพ, https://www.hiso.or.th/hiso5/report/sreport.php?y=2014&l=sreport5.
- 2019-2020 = 13.2 — **6th NHES (NHES VI)**, measured, **50/50 reconstructed** from men 10.0 / women
  16.4, adults **15+** (n = 9,390 men + 13,069 women). Crude, NHES VI report Table 5.1.3 (&ge;30 row);
  the chapter text states it outright: "BMI &ge; 30 kg/m²: men 10%, women 16.4%". SOURCE: Aekplakorn
  (ed.), *Thai NHES VI report 2019-2020* (HSRI),
  https://www.hiso.or.th/hiso/picture/reportHealth/report/sreport6/sreport6_7.pdf.
- THE LONG NHES TREND IS PUBLISHED ONLY **AGE-STANDARDISED** (not carried as crude rows). Aekplakorn
  et al. (*J Obes* 2014, https://pmc.ncbi.nlm.nih.gov/articles/PMC3976913/) give the NHES BMI &ge; 30
  trend **standardised to the 2004 Thai population**, ages 20-59: men/women **1.7/5.9** (1991, NHES I),
  **4.3/8.8** (1997, NHES II), **5.4/10.3** (2004, NHES III), **6.8/12.1** (2009, NHES IV). These show
  the real long climb but are the wrong *basis* for this crude repo (cf. China/Italy), and crude &ge;30
  for those waves sits only in the gated HSRI NHES IV report — so 1991-2009 is documented here as
  context but not added as data points. (NHES IV 2009 crude could extend the series to four NHES waves
  if that report PDF is obtained.)
- AGE-BASE SEAM: the two NHES points are **15+** (include the lean 15-17s, like Türkiye/NZ); TFCS is
  **19+**. Crude, measured, national throughout — but instrument-mixed (TFCS vs NHES) at the early end.

---

## Philippines — `PHL.csv`  (national; FNRI NNS / NNHeS / ENNS, adults 20+ &rarr; 20-59, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. THE CUTOFF PROBLEM (as in
  Thailand): Philippine headlines use the **Asia-Pacific cutoff BMI &ge; 25** ("overweight and obese"
  = 57.1% of adults in 2023); the WHO BMI &ge; 30 "obese" row is reported separately by FNRI and is
  what is carried here.
- AGE-BASE SEAM: the FNRI adult base is **20+** through the 8th NNS (2013) and shifts to **20-59**
  from the Expanded NNS (ENNS) onward (2018-2019, 2023). Read the 2013&rarr;2018-2019 step as partly a
  base change (dropping the leaner 60+).
- 2003 = 5.0 — **NNHeS 2003-2004** (National Nutrition and Health Survey, the clinical component of the
  6th NNS, FNRI-DOST), measured, adults 20+, n = 4,753; overall BMI &ge; 30 = 5.0%. SOURCE: Velandria
  et al., "Nutrition and Health Status of Filipino Adults (Excerpts from NNHeS 2003-2004)", FNRI,
  https://fnri.dost.gov.ph/images/images/nutristat/health.pdf.
- (2008 = the 7th NNS is **not carried**: FNRI publishes the 1993-2013 adult trend only as the
  *overweight+obese* combined &ge;25 series — 16.6/20.2/24.0/26.6/28.4/31.1 for 1993/1998/2003/2008/
  2011/2013 — and never breaks out crude BMI &ge; 30 by year, so a 2008 &ge;30 point could not be
  sourced.)
- 2013 = 6.8 — **8th NNS (2013)**, FNRI-DOST, measured, adults 20+ (172,323 persons surveyed), men 5.2
  / women 8.3, WHO BMI &ge; 30. SOURCE: FNRI / Philippine Heart Association, "8th National Nutrition
  Survey — NCD risk factors", https://www.philheart.org/images/8thNNSResultsNCD.pdf.
- 2018-2019 = 9.6 — **ENNS 2018-2019** (Expanded National Nutrition Survey), FNRI-DOST, measured,
  adults 20-59; overweight 28.8 + obese 9.6 on the WHO cutoff.
- 2023 = 10.3 — **2023 NNS**, FNRI-DOST, measured, adults 20-59, men 8.0 / women 13.1, WHO BMI &ge; 30
  (overweight 29.5). SOURCE: DOST-FNRI, "Nutritional Status of Adults (20 to 59 years old)", 2023 NNS,
  https://enutrition.fnri.dost.gov.ph/uploads/7_2023_NNS_ADULTS.pdf.
- The COVID-truncated **2021 ENNS** round (a ~7.2% WHO-obesity reference appears in the 2023 deck) is
  **omitted** as not comparable with the full survey rounds.

## Iran — `IRN.csv`  (national; WHO STEPS 2011 / 2016 / 2021, adults 20+/18+, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. Iran's **STEPS** (STEPwise
  approach to NCD risk-factor surveillance) waves report a national crude obesity headline; a large
  female excess throughout (women run ~13-14 pp above men).
- AGE-BASE SEAM: the 2011 figure is for adults **&ge;20**; the 2016 and 2021 waves are **18+**
  (by-age tables begin at 18-24).
- NOT carried: the earlier **2005 / 2007 first-nationwide surveys** (Janghorbani et al.) report
  **age-standardised** obesity (men 11.1 / women 25.2 in 2005) — the wrong *basis* for this crude
  repo (cf. China/Italy) — so they are context here, not added as rows.
- 2011 = 22.3 — **STEPS 2011**, measured, adults &ge;20 (n = 8,639), men 14.7 / women 27.7. SOURCE:
  Tabrizi et al., "Obesity and Related Factors in Iran: The STEPS Survey, 2011",
  https://pmc.ncbi.nlm.nih.gov/articles/PMC4552963/.
- 2016 = 22.7 — **STEPS 2016** (SuRFNCD-2016), measured, adults 18+, men 15.3 / women 29.8 (95% CI
  22.2-23.2). SOURCE: Djalalinia et al., "Patterns of Obesity and Overweight in the Iranian
  Population: Findings of STEPs 2016", https://pmc.ncbi.nlm.nih.gov/articles/PMC7055062/.
- 2021 = 25.0 — **STEPS 2021**, measured, adults 18+, men 17.2 / women 31.2 (24.96%, 95% CI
  24.39-25.53); the first national STEPS during the COVID-19 pandemic. SOURCE: "The levels of BMI and
  patterns of obesity and overweight during the COVID-19 pandemic: Experience from the Iran STEPs 2021
  survey", https://pmc.ncbi.nlm.nih.gov/articles/PMC9798439/.

## Colombia — `COL.csv`  (national; ENSIN 2005 / 2010 / 2015, adults 18-64, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. **ENSIN** (Encuesta Nacional de
  la Situación Nutricional), led by ICBF with MinSalud, INS and Universidad Nacional, is Colombia's
  national measured-anthropometry survey, fielded roughly every five years among adults **18-64**;
  obesity (obesidad) is the source-published both-sexes total. Women run above men throughout.
- 2005 = 13.7 — **ENSIN 2005**, measured, adults 18-64.
- 2010 = 16.5 — **ENSIN 2010**, measured, adults 18-64 (anthropometry module n &asymp; 162,331).
- 2015 = 18.7 — **ENSIN 2015**, measured, adults 18-64; sobrepeso 37.7 + obesidad 18.7 = 56.4 exceso
  de peso, +5.2 pp on 2010. SOURCE (all waves): ICBF/MinSalud ENSIN,
  https://www.icbf.gov.co/nutricion/ensin-encuesta-nacional-de-situacion-nutricional; the 13.7 (2005)
  &rarr; 16.5 (2010) trend is restated in Escobar-Velásquez et al., "Desigualdad social y obesidad en
  la población adulta colombiana", *Arch Med* 17(2) (2017),
  https://www.redalyc.org/journal/2738/273854673013/273854673013.pdf.

## Poland — `POL.csv`  (national; WOBASZ 2003-2005 & WOBASZ II 2013-2014, adults 20-74, measured) — RECONSTRUCTED

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. **WOBASZ** (Wieloośrodkowe
  Ogólnopolskie Badanie Stanu Zdrowia Ludności) is Poland's multicentre national health survey, with
  weight/height **measured by nurses**. Both points are **50/50 male/female reconstructions** (the
  papers publish by sex, not a both-sexes total), using the **crude** (not age-standardised) by-sex
  figures.
- 2003-2005 = 21.0 — **WOBASZ**, measured, adults 20-74, **reconstructed** from crude men 20.0 /
  women 22.0.
- 2013-2014 = 23.8 — **WOBASZ II**, measured, adults 20-74, **reconstructed** from crude men 24.2 /
  women 23.4. NOTE: the widely-quoted WOBASZ II "24.4% men / 25.0% women" are the **age-standardised**
  figures; the crude values used here are slightly lower. SOURCE: Stepaniak et al., "Prevalence of
  general and abdominal obesity ... WOBASZ II (2013-2014) and comparison with the WOBASZ study
  (2003-2005)", *Pol Arch Med Wewn* (2016), PMID 27535012; crude by-sex values restated in Kucharska
  et al., *Ann Agric Environ Med* 30(2):322-330 (2023), https://www.aaem.pl/pdf-165913-89770.

## Malaysia — `MYS.csv`  (national; NHMS II/III/IV/V + 2019/2023, adults 18+, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **18+**. The
  **National Health and Morbidity Survey (NHMS)** is run by the Institute for Public Health (IPH/IKU)
  under the Ministry of Health; height and weight are **measured** in the household. Each point is a
  **published both-sexes total**. A clean six-wave rise — roughly a **fivefold** increase
  1996&rarr;2023.
- THE CUTOFF CAVEAT (as in Indonesia/Philippines): Malaysia's own **Clinical Practice Guidelines**
  define obesity at the **Asian BMI &ge; 27.5**, so some Malaysian reports headline a much higher
  "obese" figure. The numbers carried here are the **WHO BMI &ge; 30** prevalences, to match the rest
  of this repo.
- 1996 = 4.4 (**NHMS II**; overweight 16.6 / obese 4.4, adults 18+), 2006 = 14.5 (**NHMS III**,
  95% CI 13.6-15.4) &mdash; obesity roughly **tripled** over the decade. 2011 = 15.1 (**NHMS IV**,
  95% CI 14.3-15.9), 2015 = 17.7 (**NHMS V**, 95% CI 16.9-18.5). The 2006/2011/2015 figures (and
  measured-height/weight method, n = 17,261 in 2015) are stated in the NHMS 2015 paper.
  SOURCE: Chan YY et al., "Physical activity and overweight/obesity among Malaysian adults: findings
  from the 2015 NHMS", *BMC Public Health* 17:733 (2017),
  https://pmc.ncbi.nlm.nih.gov/articles/PMC5609047/ (the 1996 = 4.4 back-point — NHMS II, overweight
  16.6 / obese 4.4 — is corroborated by the systematic review "Trends in overweight and obese adults
  in Malaysia, 1996-2009", PMID 20233309).
- 2019 = 19.7 (**NHMS 2019**), **published** both-sexes total, men 15.3 / women 24.7 (large female
  excess, as across Asia). SOURCE: Chong et al., "Prevalence of Obesity and Its Associated Factors
  Among Malaysian Adults: Finding From the NHMS 2019", *Asia Pac J Public Health* 34(8) (2022),
  https://journals.sagepub.com/doi/abs/10.1177/10105395221129113.
- 2023 = 21.8 (**NHMS 2023**), 95% CI 20.5-23.2, men 17.9 / women 26.0. **Verified against the primary
  report**: NHMS 2023 Technical Report Vol. (Non-Communicable Diseases), section 4.4 "Overweight and
  Obesity" — **Table 4.4.1** gives the 2011-2023 trend (obesity 15.1 / 17.7 / 19.7 / 21.8), and
  **Table 4.4.3** the crude BMI &ge; 30 (WHO 1998) prevalence by subgroup (Malaysia 21.8; male 17.9
  [16.3-19.7], female 26.0 [24.3-27.8]; n = 10,130). Height/weight **measured** twice with a SECA
  scale + stadiometer and averaged. The 2011/2015/2019 totals in Table 4.4.1 corroborate the points
  above. (The report also reports the Malaysian CPG &ge; 27.5 cutoff at 36.3% — not used here.)
  SOURCE: Institute for Public Health (IPH), Ministry of Health Malaysia, *NHMS 2023* (untracked local
  copy `data/tmp/report-nhms-2023.pdf`); summarised in CodeBlue (2024),
  https://codeblue.galencentre.org/2024/05/nhms-2023-over-half-of-malaysian-adults-overweight-or-obese/.

## Singapore — `SGP.csv`  (national; NHS 2010, NHSS 2013 & NPHS 2017-2024, adults 18-74, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **18-74**. Singapore's
  measured series runs from the Ministry of Health / Health Promotion Board **National Health Survey
  (NHS, 2010)** through the **National Health Surveillance Survey (NHSS, 2013)** into the **National
  Population Health Survey (NPHS, 2017 on)**; height/weight are **measured** at a health examination.
  All carried points are the **crude** prevalence on the consistent **18-74** base.
- 2010 = 10.5, 2013 = 8.6, 2017 = 8.6, 2019-2020 = 10.5, 2023-2024 = 12.7. The 2013/2017 dip-then-rise
  is what the crude series shows; note a **methodology change** at 2013 means pre-2013 figures are not
  strictly comparable. **Verified against the primary report**: NPHS 2020 report **Table 12.6**
  ("Crude prevalence (%) of obesity among Singapore residents aged 18 to 74 years, 2010, 2013, 2017
  and 2019-2020") gives Total 10.5 / 8.6 (7.9-9.3) / 8.6 (6.6-10.5) / 10.5 (9.6-11.6), with the
  **age-standardised** rates essentially identical (10.5 / 8.6 / 8.8 / 10.7) &mdash; so crude is safe
  here. Unusually for Asia, Singapore obesity is **male-skewed** (2019-2020 men 11.9 / women 9.3).
  The latest point (12.7% in 2023-2024, health exams Jul 2022-Aug 2024) is the highest in the series.
  SOURCE: MOH/HPB, *National Population Health Survey 2020* (untracked local copy
  `data/tmp/nphs-2020-survey-report.pdf`), Table 12.6; the 2023-2024 point from MOH, "National
  Population Health Survey 2024 ..." (2024),
  https://www.moh.gov.sg/newsroom/national-population-health-survey-2024-shows-singaporeans-are-adopting-healthier-lifestyles---but-rising-obesity-is-a-concern/.
- WHY THE EARLY NHS POINTS ARE **NOT** ADDED (documented but excluded): the classic NHS doubling is
  published **age-standardised** on an **18-69** base &mdash; **1992 = 5.5, 1998 = 6.3, 2004 = 6.8,
  2010 = 10.8** (then NHSS **2013 = 8.6**), per the HPB-MOH *Clinical Practice Guidelines: Obesity*
  Fig. 1 (*Singapore Med J* 2016; 57(6):292-300, untracked copy `data/tmp/SMJ-57-292.pdf`). That is a
  different basis and age base from the crude 18-74 series carried here, and not crude (so it would be
  a basis exception like China/Italy). To keep Singapore on a single crude, comparable footing, only
  the 18-74 crude NHS/NHSS/NPHS points are added; the 1992-2010 age-standardised series is recorded
  here in prose for reference.

## Ecuador — `ECU.csv`  (national; ENSANUT-ECU 2012 & ENSANUT 2018, adults 19-59, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. The **Encuesta Nacional de
  Salud y Nutrición (ENSANUT)**, run by INEC / MSP, measures height/weight by trained fieldworkers
  (portable stadiometers + electronic scales). Both points are **published both-sexes totals** for
  adults **19-59**. AGE CAP: ENSANUT's adult anthropometry stops at **59** (no 60+), so these run
  **low** versus the open-ended series — like Colombia (18-64) and Ireland (18-64).
- 2011-2013 = 22.2 — **ENSANUT-ECU 2012** (fieldwork 2011-2013). WHAT THE OFFICIAL REPORT STATES
  (verified, *Resumen Ejecutivo* §4.2.4, adults "mayores de 19 años a menores de 60 años"): height/
  weight **measured**, national **exceso de peso (IMC &ge; 25) = 62.8%** (women 65.5 / men 60.0), and
  obesity **IMC &ge; 30 by age decade** 13.4 / 22.7 / 28.4 / 32.7 (ages 20-29 → 50-59). The executive
  summary headlines the &ge; 25 combined figure and does **not** print a single national &ge; 30 total
  — the **22.2** carried here is the crude national &ge; 30 prevalence from the fuller ENSANUT
  tabulations, corroborated by a peer-reviewed **age-standardised re-analysis = 22.3%** (women 25.9 /
  men 15.4, ages 18-59, n = 10,318), i.e. crude ≈ age-standardised, so the figure is safe. The by-sex
  &ge; 30 split (women 28.1 / men 17.0) is likewise from the fuller tabulations, not the exec summary.
  SOURCE: Freire WB et al., *ENSANUT-ECU 2011-2013, Tomo I* (INEC/MSP), untracked copy
  `data/tmp/Publicacion ENSANUT 2011-2013 tomo 1.pdf` (Gráfico 21, p. 40); age-standardised
  re-analysis: Orces & Lorenzo, *J Endocrinol Invest* (2020),
  https://pmc.ncbi.nlm.nih.gov/articles/PMC7796886/.
- 2018 = 25.7 — **ENSANUT 2018** (INEC), adults 19-59. CAVEAT ON SOURCING: the official
  *Principales resultados* slide deck reports only **child** obesity (5-11 yrs = 35.4% sobrepeso+
  obesidad) and carries **no adult &ge; 30 figure**; the adult **25.7** (with exceso &ge; 25 ≈ 63.6%,
  n = 89,212, OW+OB women 67.4 / men 59.7) is from **secondary analyses of the ENSANUT 2018 microdata**,
  not a primary national-report table — treat as the one less-verified Ecuador point. SOURCE
  (child-only summary): INEC, *ENSANUT 2018, Principales resultados*, untracked copy
  `data/tmp/Principales resultados ENSANUT_2018.pdf`; adult figure via secondary microdata analyses
  (e.g. *Nutr Hosp* / RECIAMUC 2023). (Do not confuse with the separate **STEPS Ecuador 2018** survey
  — the ENSANUT nutrition survey, with its large measured sample, is the one used here.)

## Kenya — `KEN.csv`  (national; WHO STEPS 2015, adults 18-69, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **18-69**. The **2015
  Kenya STEPwise (STEPS) Survey** (MoH / KNBS / WHO) was the **first nationally representative survey
  to objectively measure BMI** in Kenya — a stratified multistage probability sample, height/weight
  measured at the household. AGE CAP: STEPS caps at **69** (no 70+).
- 2015 = 9.1 — **published both-sexes total**, men 4.4 / women 13.8 (a very large female skew, typical
  of sub-Saharan Africa), overweight 18.9 (men 13.2 / women 24.7), n = 4,283 adults. SOURCE: Mkuu et
  al., "The prevalence and associated factors of underweight and overweight/obesity among adults in
  Kenya", *Pan Afr Med J* 36:338 (2020), https://pmc.ncbi.nlm.nih.gov/articles/PMC7603835/ (analysing
  the 2015 Kenya STEPS microdata); the 9.1% both-sexes total is restated in Mohamed et al.,
  *PLoS One* (2018), https://pmc.ncbi.nlm.nih.gov/articles/PMC8170142/. This is Kenya's only national
  measured BMI &ge; 30 point — a single STEPS wave, no panel yet.

---

## Tanzania — `TZA.csv`  (national; WHO STEPS 2012, adults 25-64, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **25-64**. The **2012
  Tanzania STEPS Survey** (NIMR / MoH / WHO, fieldwork Feb–Oct 2012) was a multistage cluster
  probability sample of adults 25-64; height/weight measured at Step 2. n = 5,680, response rate 94.7%.
  AGE BASE: 25-64 (no 65+).
- 2012 = 8.7 — **published both-sexes total**, men 2.5 / women 15.0 (very large female skew, typical of
  sub-Saharan Africa), overweight (BMI &ge; 25) 26.0. SOURCE: WHO STEPS Tanzania 2012 Fact Sheet,
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/united-republic-of-tanzania/steps/ur_tanzania_factsheet_2012.pdf
  (cached at `data/tmp/TZA_steps_2012_factsheet.pdf`). Tanzania's only national measured BMI &ge; 30 point.

---

## Malawi — `MWI.csv`  (national; WHO STEPS 2009 & 2017, measured) — 2-point panel

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. Two STEPS waves; note the
  **age base differs between waves**: 2009 = 25-64, 2017 = 18-69 (the 2017 survey lowered the floor to
  18 and included up to 69).
- 2009 = 4.6 — adults **25-64**, **published both-sexes total**, men 2.0 / women 7.3 (large female
  skew), overweight (BMI &ge; 25) 21.9. n = 4,845 (BMI subsample), response rate 95.5%, fieldwork
  Jul–Sep 2009. SOURCE: WHO STEPS Malawi 2009 Fact Sheet,
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/malawi/steps/2009-malawi-factsheet-en.pdf
  (cached at `data/tmp/MWI_steps_2009_factsheet.pdf`).
- 2017 = 5.1 — adults **18-69**, **published both-sexes total**, men 1.2 / women 9.0, overweight
  (BMI &ge; 25) 18.9 (Table 46). n = 3,799 (BMI), fieldwork to Oct 2017. The report's own 25-64
  comparison shows overweight essentially flat (21.9 in 2009 &rarr; 21.5 in 2017), so the apparent
  4.6&rarr;5.1 obesity rise is partly the wider 18-69 base — treat the trend cautiously. SOURCE: WHO
  STEPS Malawi 2017 Country Report (no standalone fact sheet),
  https://www.who.int/publications/m/item/2017-steps-country-report-malawi
  (cached at `data/tmp/MWI_steps_2017_report.pdf`).

---

## Eswatini — `SWZ.csv`  (national; WHO STEPS 2014, adults 15-69, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **15-69**. The **2014
  STEPS Survey** (published under the country's former name **Swaziland**; MoH / WHO, fieldwork Nov–Dec
  2014) was a multistage cluster probability sample; height/weight measured. n = 3,281, response rate
  76%. AGE BASE: 15-69 — includes adolescents 15-17 (broader low end than most series), no 70+.
- 2014 = 20.5 — **published both-sexes total**, men 8.8 / women 30.9 (very large female skew; among the
  highest obesity levels in the African series), overweight (BMI &ge; 25) 43.8. SOURCE: WHO STEPS
  Swaziland 2014 Fact Sheet,
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/eswatini/steps/2014-steps-swaziland-factsheet.pdf
  (cached at `data/tmp/SWZ_steps_2014_factsheet.pdf`). Eswatini's only national measured BMI &ge; 30 point.

---

## Zambia — `ZMB.csv`  (national; WHO STEPS 2017, adults 18-69, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **18-69**. The **2017
  Zambia STEPS Survey** (MoH / WHO, fieldwork Jul–Sep 2017) — Zambia's first national STEPS — was a
  multistage cluster probability sample; height/weight measured. n = 4,302, response rate 74% (Steps 1-2).
  AGE CAP: STEPS caps at 69 (no 70+).
- 2017 = 7.5 — **published both-sexes total**, men 3.0 / women 12.3 (large female skew), overweight
  (BMI &ge; 25) 24.2. SOURCE: WHO STEPS Zambia 2017 Fact Sheet,
  https://www.afro.who.int/sites/default/files/2018-05/STEPS%20SURVEY%20Zambia-fact-sheet.pdf
  (cached at `data/tmp/ZMB_steps_2017_factsheet.pdf`; full report:
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/zambia/steps/zambia-ncd-steps-survey-report-2017.pdf).
  Zambia's only national measured BMI &ge; 30 point.

---

## Uganda — `UGA.csv`  (national; WHO STEPS 2014, adults 18-69, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **18-69**. The **2014
  Uganda STEPS Survey** (UBOS / MoH / WHO, fieldwork Apr–Jun 2014) — Uganda's first national STEPS —
  was a multistage cluster probability sample; height/weight measured (obesity computed excluding
  pregnant women). n = 3,987. AGE CAP: STEPS caps at 69 (no 70+).
- 2014 = 4.6 — **published both-sexes total**, men 1.8 / women 7.5 (large female skew), overweight
  (BMI &ge; 25) 14.5. SOURCE: WHO STEPS Uganda 2014 Report (no standalone fact sheet was issued; obesity
  figures in the Physical Measurements section, restated in the executive summary),
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/uganda/steps/uganda_2014_steps_report.pdf
  (cached at `data/tmp/UGA_steps_2014_report.pdf`). Uganda's only national measured BMI &ge; 30 point.

---

## Ethiopia — `ETH.csv`  (national; WHO STEPS 2015, adults 15-69, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **15-69**. The **2015
  Ethiopia STEPS Survey** (Ethiopian Public Health Institute / WHO; Ethiopia's third STEPS) was a
  three-stage cluster probability sample; height/weight measured. n = 9,801, response rate 95.5%. AGE
  BASE: 15-69 — includes adolescents 15-17, no 70+.
- 2015 = 1.2 — **published both-sexes total**, men 0.5 / women 2.0; overweight (BMI &ge; 25) 6.3. Among
  the lowest obesity levels in the whole panel (mean BMI 20.4). SOURCE: WHO/EPHI STEPS Ethiopia 2015
  Fact Sheet,
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/ethiopia/steps/ethiopia-2015-steps-factsheet.pdf
  (cached at `data/tmp/ETH_steps_2015_factsheet.pdf`). Ethiopia's only national measured BMI &ge; 30 point.

---

## Mozambique — `MOZ.csv`  (national; WHO STEPS 2005 & 2014/15, adults 25-64, measured) — RECONSTRUCTED 2-point panel

- **BMI &ge; 30**, **crude**, **measured**, **national**, adults **25-64**. Two STEPS waves, compared on
  a consistent 25-64 base by Jessen et al., "Prevalence of overweight and obesity in Mozambique in 2005
  and 2015", *Public Health Nutrition* 22(17):3119-3128 (2019),
  https://pmc.ncbi.nlm.nih.gov/articles/PMC10260445/ (cached extract). The source publishes obesity
  **by sex only** (no both-sexes total), so both points are **reconstructed** as the 50/50 male/female
  average — consistent with the JPN/DEU/NLD/early-BRA convention in this repo.
- 2005 = 4.7 — reconstructed from men 2.3 / women 7.0.
- 2014/15 = 9.0 — reconstructed from men 5.0 / women 13.0; 2014/15 survey n = 2,595 (18-64), restricted
  to 25-64 for cross-wave comparability. A steep rise (overweight+obesity rose 11.7&rarr;18.2 in men and
  18.3&rarr;30.5 in women over the decade).

---

## Rwanda — `RWA.csv`  (national; WHO STEPS 2012/13 & 2021/22, adults 15-64, measured) — 2-point panel

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **15-64** (includes
  adolescents 15-17, no 65+). Two STEPS waves, both **published both-sexes totals**.
- 2012/13 = 2.8 — men 0.8 / women 4.7 (large female skew), overweight (BMI &ge; 25) 14.3. SOURCE: Rwanda
  2012-2013 STEPS Country Report (MoH / RBC / WHO),
  https://www.who.int/publications/m/item/2012-2013-steps-country-report-rwanda (figures restated in the
  Rwanda country report, *PLoS* PMC9562790).
- 2021/22 = 4.3 — men 1.3 / women 7.4 (large female skew), overweight (BMI &ge; 25) 14.3; obesity
  excludes pregnant women. n = 5,776 adults, fieldwork from Nov 2021. SOURCE: "STEPS: Prevalence of
  Non-Communicable Disease risk factors in the Republic of Rwanda, 2022" final report (fact-sheet table,
  both-sexes obese 4.3%),
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/rwanda/rwanda_final_report_steps_survey_2021-2022.pdf
  (cached at `data/tmp/RWA_steps_2021_report.pdf`).

---

## Kuwait — `KWT.csv`  (national; WHO STEPS 2014, adults 18-69, measured) — KUWAITI NATIONALS

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, adults **18-69**. The **2014 Kuwait STEPS
  Survey** (Kuwait MoH / WHO) was a cross-sectional measured survey of **Kuwaiti nationals only** — a
  major coverage caveat, since citizens are a minority of Kuwait's resident population (the expatriate
  majority is not sampled). Same nationals-only basis as the Saudi series.
- 2014 = 40.3 — **published both-sexes total** [95% CI 38.6-42.0], men 36.5 / women 44.0, n = 3,915.
  Nearly 8 in 10 Kuwaiti adults were overweight or obese. SOURCE: Weiderpass et al., "The Prevalence of
  Overweight and Obesity in an Adult Kuwaiti Population in 2014", *Front Endocrinol* 10:449 (2019),
  https://pmc.ncbi.nlm.nih.gov/articles/PMC6629831/.

---

## Qatar — `QAT.csv`  (national; WHO STEPS 2012, adults 18-64, measured) — QATARI NATIONALS

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, adults **18-64**. The **2012 Qatar STEPS
  Survey** (Supreme Council of Health / WHO, fieldwork Mar–May 2012, response 88%) sampled **Qatari
  nationals only** (expatriate majority not covered — same caveat as Kuwait).
- 2012 = 41.4 — **published both-sexes total** [95% CI 38.8-44.0], men 39.5 / women 43.2, n = 2,496
  (multistage cluster sample, fieldwork Mar–May 2012, mean BMI 29.2). One of the highest measured
  national obesity levels in the whole panel. SOURCE (PRIMARY): Qatar STEPwise Report 2012 (Supreme
  Council of Health / WHO), Table 3.35,
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/qatar/steps/qatar-2012-stepwise-report.pdf
  (cached at `data/tmp/QAT_steps_2012_report.pdf`; the 41.4% both-sexes total is stated verbatim in the
  report's BMI section and fact-sheet table).

---

## Oman — `OMN.csv`  (national; WHO STEPS 2017, adults 18+, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**, adults **18+**. The **2017 Oman
  STEPS Survey** (Ministry of Health / WHO, fieldwork Jan–Apr 2017, all governorates) measured
  height/weight on n = 6,582 Omani adults.
- 2017 = 30.7 — **published both-sexes total** [95% CI 26.0-35.7], men 23.2 / women 39.3 (large female
  skew). The report compares to the 2008 World Health Survey, where Omani obesity was ~24% (women rising
  ~24 &rarr; ~41 by 2017) — a steep decade rise, but the 2008 comparator is a different instrument so it
  is noted in prose rather than carried as a second data row. SOURCE: Al-Mawali et al., "Prevalence of
  risk factors of non-communicable diseases in the Sultanate of Oman: STEPS survey 2017",
  https://pmc.ncbi.nlm.nih.gov/articles/PMC8553065/.
- WHY NO EARLIER ROW (measured secular trend documented but not carried): Oman has measured national
  surveys back to 1991, but the earlier obesity figures are published **age-adjusted, by sex only** —
  not crude both-sexes totals — so carrying them would break the crude basis of the 2017 point and
  require reconstruction. For the record (Al-Lawati & Jousilahti, "Prevalence and 10-year secular trend
  of obesity in Oman", *Saudi Med J* 25(3):346-351, 2004, https://smj.org.sa/content/smj/25/3/346.full.pdf,
  cached at `data/tmp/OMN_allawati_2004.pdf`; Omani citizens 20+): **age-adjusted** obesity men
  10.5 (1991) &rarr; 16.7 (2000), women 25.1 (1991) &rarr; 23.8 (2000); the 2008 Oman World Health Survey
  put obesity at ~24%; a 2025 STEPS is in the pipeline. The crude 2017 STEPS point (30.7) is the only
  one carried; a future crude both-sexes series could be built if the earlier microdata are reprocessed.

---

## United Arab Emirates — `ARE.csv`  (national; UAE National Health Survey 2017-18, EMIRATI nationals, adults 18-69, measured)

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, adults **18-69**. The **UAE National Health
  Survey 2017-2018** (Ministry of Health & Prevention; IQVIA fieldwork) was a STEPS-structured
  household survey (height/weight measured at Step 2) of ~10,000 households across all seven emirates.
  The survey samples **all residents**, but to match the nationals-only basis of the rest of the Gulf
  (Kuwait/Qatar/Oman/Bahrain) we record the **Emirati-national** subgroup, which the report publishes
  directly.
- 2017-18 = 36.9 — **published Emirati-national both-sexes total**, men 32.2 / women 41.8. CONTEXT: the
  all-resident total was far lower at **27.8** (men 25.1 / women 30.6; non-Emiratis 26.3) — the gap is
  the (leaner, younger, male) labour-migrant majority. SOURCE: UAE National Health Survey Report
  2017-2018 (MoHAP / WHO), obesity-by-nationality table,
  https://cdn.who.int/media/docs/default-source/ncds/ncd-surveillance/data-reporting/united-arab-emirates/uae-national-health-survey-report-2017-2018.pdf
  (cached at `data/tmp/ARE_nhs_2017-2018_report.pdf`).

---

## Bahrain — `BHR.csv`  (national; Bahrain National Health Survey 2018, BAHRAINI nationals, adults 18+, measured) — RECONSTRUCTED

- **BMI &ge; 30**, **crude**, **measured**, adults **18+**. The **Bahrain National Health Survey 2018**
  (Ministry of Health) measured height/weight (n = 2,948, excludes pregnant women). Like UAE it samples
  all residents, but the **Bahraini-national** breakdown is published by sex only (no nationals
  both-sexes total), so this point is **reconstructed** as the 50/50 male/female average — same
  convention as the JPN/DEU/MOZ points.
- 2018 = 43.2 — reconstructed from Bahraini-national men 39.2 / women 47.2. CONTEXT: the all-resident
  total was 36.9 (men 30.9 / women 42.5), overweight (BMI 25-29.9) 35.5. SOURCE: Bahrain NHS 2018, as
  reported in Al-Sayyad et al. (WHO EMRO), "Bodyweight and obesity perceptions among adults in Bahrain",
  *East Mediterr Health J* 30(3) (2024), https://pubmed.ncbi.nlm.nih.gov/39584434/, and the World
  Obesity Federation Global Obesity Observatory (survey type: measured),
  https://data.worldobesity.org/country/bahrain-15/ (cached: `data/tmp/BHR_worldobesity_reportcard.pdf`).

---

## Israel — `ISR.csv`  (national; MABAT National Health & Nutrition Surveys, measured) — 2-point panel

- Standard WHO **BMI &ge; 30**, **crude**, **measured**, **national**. Two MABAT waves from the Israel
  Center for Disease Control, both height/weight measured, covering Jews and Arabs. NOTE the **age base
  differs between waves**: MABAT-1 = 25-64, MABAT-2 = 18-64 (the second wave lowered the floor to 18).
- 1999-2001 = 22.9 — adults **25-64**, **both-sexes total**, computed from Table 2 by-sex: men 19.9
  (class I 17.1 + class II/III 2.8) / women 25.8 (16.5 + 9.3); overweight (BMI 25-29.9) men 45.8 / women
  33.1 (~39.3 combined). Highest among Arab women (55-64: ~70%). n = 2,781. SOURCE (PRIMARY):
  Keinan-Boker, Kaluski et al., "Overweight and Obesity Prevalence in Israel: Findings of the First
  National Health and Nutrition Survey (MABAT)", *Isr Med Assoc J* 7:219-223 (2005),
  https://www.ima.org.il/filesupload/IMAJ/0/50/25159.pdf (cached at `data/tmp/ISR_MABAT1_IMAJ.pdf`).
- 2014-2016 = 17.0 — adults **18-64**, **published both-sexes total** (47.5% overweight-or-obese: 30.5%
  overweight + 17.0% obese), men 17.4 / women 16.6. SOURCE (PRIMARY): ICDC, *Mabat — Second National
  Health and Nutrition Survey, Ages 18-64, 2014-2016* (English edition), §2.1 measured-BMI table,
  https://www.gov.il/BlobFolder/reports/mabat-adults-2014-2016-383/en/files_publications_units_ICDC_mabat_adults_2014_2016_383_en.pdf
  (cached at `data/tmp/ISR_MABAT2_2014-2016_adults_en.pdf`).
- THE 22.9&rarr;17.0 "FALL" IS NOT A REAL DECLINE — it is mostly an **age-base artifact** plus noise.
  MABAT-2 is **18-64** (adds the lean 18-24s); MABAT-1 was **25-64**. AGE-MATCHED, the picture is
  essentially **flat**: men 35-44 20.9&rarr;20.0 and 45-64 ~24.5&rarr;27.3 (flat to marginally up, within
  CI); women 35-44 22.0&rarr;18.5 and 45-64 ~36&rarr;26.4 (flat to lower, but MABAT-1's 55-64 women had
  n=255 with wide CIs, so the older-women drop is partly regression-to-mean). So do **not** read a male
  rise: the narrowing of the female&gt;male gap is driven by the older-women estimate coming down, not by
  men climbing. NET: roughly flat 2000&rarr;2015. This agrees with the **NCD-RisC / OWID** modelled series
  (age-standardised, hierarchical-Bayes smoothed), which shows Israeli obesity flattening over the same
  period — reassuring that our two *crude, unmodelled* survey points carry no real signal of change once
  the age base is matched. Same age-base-seam caveat class as Malawi and Saudi Arabia.

---

## Cross-country comparability notes

- **Age base differs**: NZ 15+, UK/US 16+, Australia/Canada 18+, Ireland 18-64 (note the upper cap),
  Mexico 20+ (same base as US NHANES), South Korea 19+ (its two reconstructed early points are 20+),
  Japan 20+ (its 2010 reconstructed point is 20-64; its 2019 published point is 15+),
  China 18-69, France 18-74, Germany 18-79, Spain 18+ (ENPE point is 25-64), Italy **35-74** (note
  the restricted age base — no young adults), Brazil 20+ (PNS 2013/2019 points are 18+),
  India 18-69 (single NNMS point), South Africa 18+, Finland 25-64 (2017 point is 30+),
  Norway/Sweden ~25-74 working-age (see their sections), Türkiye **15+** (WHO STEPS),
  Argentina 18+ (single ENNyS 2 point), Russia 18+ (RLMS adult sample, age cut confirmed in
  Huffman & Rizov; the ESSE-RF point is 25-64),
  Indonesia 20+ (RISKESDAS), Saudi Arabia 15+ (the CADISS 1995-2000 point is **30-70** — much
  higher base, runs high), Chile 15+ (the ENS 2003 point is 17+), Peru 18-20+ (CENAN anchors 20+,
  ENDES points 18+),
  Philippines 20+ &rarr; **20-59** (FNRI base shifts at the 2018-2019 ENNS), Iran 20+/18+ (STEPS 2011
  is &ge;20, 2016/2021 are 18+), Colombia 18-64 (ENSIN, note the upper cap), Poland 20-74 (WOBASZ),
  Malaysia 18+ (NHMS), Singapore **18-74** (the NPHS base; the older NHS series is 18-69),
  Ecuador **19-59** (ENSANUT caps at 59 — no 60+, runs low), Kenya 18-69 (STEPS caps at 69).
- **Coverage / basis caveats**: GBR = England (HSE) only; Norway = HUNT, one county (Nord-Trøndelag),
  not national; Sweden = an employed occupational cohort, not a probability sample; **Denmark = the
  only self-reported series** (understates — not comparable head-to-head); Argentina = ENNyS 2,
  **urban localities &ge;5,000 only** (no rural coverage). Treat these loosely against the fully
  national measured probability-sample countries.
- **Basis**: all series are **crude** except **China** (standardised to the 2010 China census) and
  **Italy** (standardised to the Italian population) — the two series not on a crude basis; neither
  country publishes crude BMI &ge; 30.
- All values are **crude** (not age-standardised).
- Pre-continuous-survey points are isolated waves; treat early anchors cautiously (esp. AUS 1980
  capital-cities-only and the US 1890s anthropometric anchor).
- The UK series is **England** (HSE), not the whole United Kingdom.

---

## Disclaimer

This data was largely collected with the help of Anthropic's Claude Code (using the Opus 4.8 model).
I took care to check through the outputs. Nevertheless, some minor errors may exist.
