# Obesity Rate by Country

Harmonized panel of **adult obesity prevalence** (% of adults with body mass index
&ge; 30 kg/m&sup2;) drawn from each country's own national **measured** height/weight
surveys.

**Scope** (snapshot): 96 countries and 278 survey observations, earliest US 1900-1901,
latest 2024-25; covers all 19 G20 national economies, the high-obesity Pacific island
states, the Caucasus & Central Asia, and mainland Southeast Asia. A companion file adds
sex-specific rates for 89 of them.

## Countries covered (96)

Algeria&dagger; · Argentina&dagger; · Armenia&dagger; · Australia · Azerbaijan&dagger; · Bahrain&dagger; · Bangladesh&dagger; ·
Benin&dagger; · Brazil&dagger; · Burkina Faso&dagger; · Cabo Verde&dagger; · Cambodia&dagger; · Canada&dagger; · Chile&dagger; · China&dagger; ·
Colombia · Cook Islands&dagger; · Côte d'Ivoire&dagger; · Denmark · Ecuador&dagger; · Egypt&dagger; · Eswatini&dagger; ·
Ethiopia&dagger; · Fiji&dagger; · Finland&dagger; · France&dagger; · Gambia&dagger; · Georgia&dagger; · Germany&dagger; · Ghana&dagger; ·
India&dagger; · Indonesia · Iran&dagger; · Ireland&dagger; · Israel&dagger; · Italy&dagger; · Japan&dagger; · Jordan&dagger; ·
Kazakhstan · Kenya&dagger; · Kiribati&dagger; · Kuwait&dagger; · Kyrgyzstan&dagger; · Laos&dagger; · Lebanon&dagger; · Libya&dagger; ·
Malawi&dagger; · Malaysia&dagger; · Mexico&dagger; · Mongolia&dagger; · Morocco&dagger; · Mozambique&dagger; · Myanmar&dagger; · Nauru&dagger; ·
Nepal&dagger; · Netherlands&dagger; · New Zealand&dagger; · Niger&dagger; · Norway&dagger; · Oman&dagger; · Palestine&dagger; ·
Peru&dagger; · Philippines&dagger; · Poland&dagger; · Qatar&dagger; · Russia&dagger; · Rwanda&dagger; · Samoa&dagger; ·
Saudi Arabia&dagger; · Senegal&dagger; · Sierra Leone&dagger; · Singapore&dagger; · Solomon Islands&dagger; ·
South Africa&dagger; · South Korea&dagger; · Spain&dagger; · Sri Lanka&dagger; · Sweden · Syria&dagger; · Tajikistan&dagger; ·
Tanzania&dagger; · Thailand&dagger; · Togo&dagger; · Tonga&dagger; · Tunisia&dagger; · Turkmenistan&dagger; · Tuvalu&dagger; ·
Türkiye&dagger; · Uganda&dagger; · United Arab Emirates&dagger; · United Kingdom&dagger; · United States ·
Uzbekistan&dagger; · Vanuatu&dagger; · Vietnam&dagger; · Zambia&dagger;

&dagger; = also has sex-specific rates in `data/cleaned/obesity-by-sex.csv` (89 countries). The seven
without a dagger have no by-sex row in the companion file: Australia, Colombia, Denmark, Indonesia,
Sweden and the United States (no published by-sex split in the source), and Kazakhstan (its 2021-22
total is reconstructed from urban/rural figures, with no sex breakdown).

The Pacific island states (Cook Islands, Fiji, Kiribati, Nauru, Samoa, Solomon Islands, Tonga,
Tuvalu, Vanuatu — all WHO STEPS) anchor the **top of the panel**: Nauru (70.2%), Cook Islands
(69.8%), Tonga (67.6%) and Samoa (65.2%) are the most obese series here, while the Melanesian
states (Solomon Islands 32.8%, Vanuatu 18.8%) sit far lower.

The Caucasus & Central Asia block (Armenia, Azerbaijan, Georgia, Kazakhstan, Kyrgyzstan, Mongolia,
Tajikistan, Turkmenistan, Uzbekistan — all WHO STEPS, mostly mid-panel at 13-33%) adds four
multi-wave series: Mongolia (2005-2019), Georgia (2010-2016) and Turkmenistan (2013-2018), with
Mongolia's 2009&rarr;2013 jump (12.5&rarr;19.7%) and Georgia's climb to 33.2% the steepest moves.

Mainland Southeast Asia (Cambodia, Laos, Myanmar, Vietnam — all WHO STEPS) joins the region's
earlier entries (Thailand, Indonesia, Malaysia, Philippines, Singapore) at the **low end of the
panel**: BMI &ge; 30 prevalence runs just 1.9-5.6%, reflecting Asian body composition (most national
reports instead headline the much higher Asian &ge; 25 cutoff). Vietnam adds the block's one
multi-wave series — 2009&rarr;2021, 0.8&rarr;2.1% — though on a shifting age base (25-64 &rarr; 18-69).

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
│   │   ├── USA.csv  GBR.csv  CAN.csv  AUS.csv  NZL.csv  …  (one per country, 96 total)
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
countries, reversing over time in East Asia (China/Japan), enormous and female-skewed in South
Africa (+30 pp), Eswatini (+22 pp), Egypt (+24 pp) and across sub-Saharan Africa (women 4-6x men in
Ghana, Tanzania, Senegal), and — unusually — near-parity at very high levels in the Pacific, where
Nauru is even slightly male-skewed. The per-row `basis` notes crude vs age-standardised and any age
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