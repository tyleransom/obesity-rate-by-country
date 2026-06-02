# Obesity Rate by Country

Harmonized panel of **adult obesity prevalence** (% of adults with body mass index
&ge; 30 kg/m&sup2;) drawn from each country's own national **measured** height/weight
surveys.

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
│   │   ├── USA.csv  GBR.csv  CAN.csv  AUS.csv  NZL.csv
│   └── cleaned/
│       └── obesity-rate-by-country.csv   long-format panel (built by src/combine.R)
├── src/
│   └── combine.R            reads data/raw/*.csv -> data/cleaned panel
├── LICENSE                  MIT
└── README.md                this file
```

## Data schema

Each `data/raw/<ISO3>.csv` has four columns:

| column         | description |
|----------------|-------------|
| `country`      | country name |
| `iso3`         | ISO 3166-1 alpha-3 code (the file name) |
| `survey_period`| reporting period as published — a single year (`2004`) or a range (`1988-1994`) |
| `obesity_pct`  | % of adults with BMI &ge; 30, total (both sexes), **measured** |

The cleaned panel `data/cleaned/obesity-rate-by-country.csv` adds a numeric `year`
(midpoint of `survey_period`) and stacks all countries:
`country, iso3, year, survey_period, obesity_pct`.

## Reproduce / rebuild

```r
# from src/
Rscript combine.R        # rebuilds data/cleaned/obesity-rate-by-country.csv
```
Requires R with the `tidyverse` package. No raw national source files are stored here;
`data/raw/README.md` documents the exact source URL and extraction step for every data
point, so the raw CSVs can be reproduced from the primary sources.

## Adding a country

1. Create `data/raw/<ISO3>.csv` with the four standard columns.
2. Use **measured** (not self-reported) surveys, total adults, BMI &ge; 30, where possible.
3. Document every point — source, survey, age range, measured vs self-report, URL — in
   `data/raw/README.md`.
4. Re-run `src/combine.R`.

## Caveats (read before cross-country comparison)

These are **heterogeneous national surveys**, not a single harmonized instrument:

- **Age ranges differ**: e.g. NZ adults are 15+, UK/US 16+, Australia/Canada 18+.
- **Crude vs age-standardized**: values here are **crude** prevalence (to match the basis
  most national headline figures and the US NHANES series use), not age-standardized.
- **Measured vs self-reported**: all points aim to be from *measured* height/weight;
  self-reported waves (which understate obesity) are excluded or flagged in the raw README.
- **Coverage**: some early anchors are one-off or sub-national surveys (e.g. the UK series
  is **England** via the Health Survey for England; Australia's 1980 point is capital-cities
  only). All such caveats are documented per point in `data/raw/README.md`.
- **Gaps**: continuous annual measurement started at different times by country; pre-
  continuous points are isolated survey waves.

Treat the series as honest national survey observations, and consult `data/raw/README.md`
before drawing comparisons.

## License

MIT (see `LICENSE`).
