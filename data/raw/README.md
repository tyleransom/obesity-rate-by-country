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
China Lancet paper `EMS201458.pdf` plus its supplementary `EMS201458-supplement-Appendix.pdf`, and
the Brazil IBGE POF 2008-2009 anthropometry report `liv45419.pdf`.

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
  AUS 1980 = capital cities), or `non-probability` (SWE = occupational cohort).
- **`source`** — short survey/study name (same vocabulary as `data/cleaned/obesity-by-sex.csv`).
- **`note`** — short free-text caveat (double-quoted; may be empty).

These are a structured summary, not a replacement for the per-point prose + URLs that follow.

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

---

## Cross-country comparability notes

- **Age base differs**: NZ 15+, UK/US 16+, Australia/Canada 18+, Ireland 18-64 (note the upper cap),
  Mexico 20+ (same base as US NHANES), South Korea 19+ (its two reconstructed early points are 20+),
  Japan 20+ (its 2010 reconstructed point is 20-64; its 2019 published point is 15+),
  China 18-69, France 18-74, Germany 18-79, Spain 18+ (ENPE point is 25-64), Italy **35-74** (note
  the restricted age base — no young adults), Brazil 20+ (PNS 2013/2019 points are 18+),
  India 18-69 (single NNMS point), South Africa 18+, Finland 25-64 (2017 point is 30+),
  Norway/Sweden ~25-74 working-age (see their sections), Türkiye **15+** (WHO STEPS),
  Argentina 18+ (single ENNyS 2 point).
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
