# Obesity Rate by Country

Harmonized panel of **adult obesity prevalence** (% of adults with body mass index
&ge; 30 kg/m&sup2;) drawn from each country's own national **measured** height/weight
surveys.

**Scope** (snapshot): 61 countries and 231 survey observations, earliest US 1900-1901,
latest 2024-25; covers all 19 G20 national economies. A companion file adds sex-specific
rates for 38 of them.

## Countries covered (61)

Algeria&dagger; · Argentina&dagger; · Australia · Bahrain · Brazil&dagger; · Canada · Chile&dagger; ·
China&dagger; · Colombia · Denmark · Ecuador&dagger; · Egypt&dagger; · Eswatini · Ethiopia ·
Finland&dagger; · France&dagger; · Germany&dagger; · India&dagger; · Indonesia · Iran&dagger; · Ireland ·
Israel · Italy&dagger; · Japan&dagger; · Jordan&dagger; · Kenya&dagger; · Kuwait · Lebanon&dagger; ·
Libya&dagger; · Malawi · Malaysia&dagger; · Mexico&dagger; · Morocco&dagger; · Mozambique ·
Netherlands&dagger; · New Zealand · Norway&dagger; · Oman · Palestine&dagger; · Peru&dagger; ·
Philippines&dagger; · Poland&dagger; · Qatar · Russia&dagger; · Rwanda · Saudi Arabia&dagger; ·
Singapore&dagger; · South Africa&dagger; · South Korea&dagger; · Spain&dagger; · Sweden · Syria&dagger; ·
Tanzania · Thailand&dagger; · Tunisia&dagger; · Türkiye&dagger; · Uganda · United Arab Emirates ·
United Kingdom&dagger; · United States · Zambia

&dagger; = also has sex-specific rates in `data/cleaned/obesity-by-sex.csv` (38 countries).

## Why this exists

The widely used cross-country obesity products (WHO Global Health Observatory, and the
NCD-RisC model it republishes) are **modelled estimates** (using a Bayesian hierarchical model
fit across pooled studies, which produces very smooth trend lines that wash out the real
survey-to-survey variation and rely on imputation for country-years without data). This
repository instead collects the **actual national survey observations** (the inputs such
models smooth over), so the data show genuine survey-wave detail. The trade-off is that
these series are sparser and less perfectly comparable across countries (see Caveats).

## Repository layout

```
obesity-rate-by-country/
├── data/
│   ├── raw/                 one CSV per country (the actual survey data points)
│   │   ├── README.md        per-country source documentation
│   │   ├── USA.csv  GBR.csv  CAN.csv  AUS.csv  NZL.csv  …  (one per country, 61 total)
│   └── cleaned/
│       └── obesity-rate-by-country.csv   long-format panel (built by src/combine.R)
├── src/
│   └── combine.R            reads data/raw/*.csv -> data/cleaned panel
├── LICENSE                  MIT
└── README.md                this file
```

## Data schema

Each `data/raw/<ISO3>.csv` has eleven columns — four core columns plus seven
**quality annotations** that make each point's comparability explicit:

| column         | description |
|----------------|-------------|
| `country`      | country name |
| `iso3`         | ISO 3166-1 alpha-3 code (the file name) |
| `survey_period`| reporting period as published — a single year (`2004`) or a range (`1988-1994`) |
| `obesity_pct`  | % of adults with BMI &ge; 30, total (both sexes) |
| `basis`        | `crude` or `age-standardised` (standardised only for China & Italy) |
| `measurement`  | `measured` or `self-reported` (self-reported only for Denmark) |
| `derivation`   | `published` (source-reported total), `reconstructed` (50/50 male/female average), or `anchor` (derived non-survey figure — USA 1900) |
| `age_group`    | adult age base as published, e.g. `20+`, `18-79`, `35-74` |
| `coverage`     | `national`, `sub-national` (GBR=England, NOR=one county, AUS 1980, NLD pre-2009 RIVM monitoring towns, SYR=Aleppo city), or `non-probability` (SWE occupational cohort) |
| `source`       | short survey/study name (e.g. `NHANES`, `HSE`, `ENSANUT`) |
| `note`         | short free-text caveat (quoted; may be empty) |

These columns structure the per-point provenance that `data/raw/README.md` documents in
full prose — they don't replace it. The cleaned panel
`data/cleaned/obesity-rate-by-country.csv` adds a numeric `year` (midpoint of
`survey_period`) and stacks all countries, carrying every column through:
`country, iso3, year, survey_period, obesity_pct, basis, measurement, derivation,
age_group, coverage, source, note`.

### Companion: obesity by sex

`data/cleaned/obesity-by-sex.csv` is a **hand-curated** companion (not built by `combine.R`)
giving the **sex-specific** BMI &ge; 30 prevalences — `men_pct, women_pct, women_minus_men_pp`
plus the same quality columns as the main panel (`basis, measurement, derivation, age_group,
coverage, source, note`) — for the country-years where the sources report them. (`derivation` is
`published` throughout: these are source-reported by-sex figures — it's the *totals* in the main
panel that are sometimes `reconstructed` as their 50/50 average.) It exists because the
male/female gap is itself a striking cross-country pattern: tiny or male-favouring in rich Western
countries, reversing over time in East Asia (China/Japan), and enormous and female-skewed in South
Africa (+30 pp), Egypt (+24 pp) and India (+7 pp). The per-row `basis` notes crude vs age-standardised and any age
caveat; see `data/raw/README.md` for full provenance of each figure.

## Reproduce / rebuild

```r
# from src/
Rscript combine.R        # rebuilds data/cleaned/obesity-rate-by-country.csv
```
Requires R with the `tidyverse` package. No raw national source files are stored here;
`data/raw/README.md` documents the exact source URL and extraction step for every data
point, so the raw CSVs can be reproduced from the primary sources.

## Adding a country

1. Create `data/raw/<ISO3>.csv` with the eleven standard columns (fill the quality
   annotations using the controlled vocabularies in the schema table above).
2. Use **measured** (not self-reported) surveys, total adults, BMI &ge; 30, where possible.
3. Document every point — source, survey, age range, measured vs self-report, URL — in
   `data/raw/README.md`.
4. Re-run `src/combine.R`.

## Caveats (read before cross-country comparison)

These are **heterogeneous national surveys**, not a single harmonized instrument:

- **Age ranges differ**: e.g. NZ adults are 15+, UK/US 16+, Australia/Canada 18+.
- **Crude vs age-standardized**: values here are **crude** prevalence (to match the basis
  most national headline figures and the US NHANES series use), not age-standardized.
- **Measured vs self-reported**: all points aim to be from *measured* height/weight; self-reported
  waves (which understate obesity) are excluded — with **one exception, Denmark**, the only
  self-reported series, included for coverage and flagged as such (not comparable head-to-head).
  A couple of series are **age-standardised** rather than crude (China, Italy). All flagged per point
  in `data/raw/README.md`.
- **Coverage**: some early anchors are one-off or sub-national surveys (e.g. the UK series
  is **England** via the Health Survey for England; Australia's 1980 point is capital-cities
  only). All such caveats are documented per point in `data/raw/README.md`.
- **Gaps**: continuous annual measurement started at different times by country; pre-
  continuous points are isolated survey waves.

Treat the series as honest national survey observations, and consult `data/raw/README.md`
before drawing comparisons.

## License

MIT (see `LICENSE`).

## Disclaimer

This data was largely collected with the help of Anthropic's Claude Code (using the Opus 4.8 model). I took care to check through the outputs. Nevertheless, some minor errors may exist.