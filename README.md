# Obesity Rate by Country

Harmonized panel of **adult obesity prevalence** (% of adults with body mass index
&ge; 30 kg/m&sup2;) drawn from each country's own national **measured** height/weight
surveys.

**Scope** (snapshot): 156 countries and 352 survey observations, earliest US 1900-1901,
latest 2024-25; covers all 19 G20 national economies, the high-obesity Pacific island
states, the Caucasus & Central Asia, mainland Southeast Asia, Latin America & the
Caribbean, a broad Sub-Saharan Africa block, and Europe (measured examination surveys
only). A companion file adds sex-specific rates for 154 of them.

## Countries covered (156)

Afghanistan&dagger; · Albania&dagger; · Algeria&dagger; · Angola&dagger; · Argentina&dagger; ·
Armenia&dagger; · Australia&dagger; · Austria&dagger; · Azerbaijan&dagger; · Bahrain&dagger; · Bangladesh&dagger; ·
Barbados&dagger; · Belarus&dagger; · Belgium&dagger; · Benin&dagger; · Bhutan&dagger; · Bolivia&dagger; ·
Botswana&dagger; · Brazil&dagger; · Burkina Faso&dagger; · Cabo Verde&dagger; · Cambodia&dagger; ·
Cameroon&dagger; · Canada&dagger; · Chile&dagger; · China&dagger; · Colombia&dagger; · Comoros&dagger; ·
Congo&dagger; · Cook Islands&dagger; · Costa Rica&dagger; · Croatia&dagger; · Cuba&dagger; · Czechia&dagger; ·
Côte d'Ivoire&dagger; · Denmark&dagger; · Dominican Republic&dagger; · DR Congo&dagger; · Ecuador&dagger; ·
Egypt&dagger; · El Salvador&dagger; · Equatorial Guinea&dagger; · Estonia&dagger; · Eswatini&dagger; ·
Ethiopia&dagger; · Fiji&dagger; · Finland&dagger; · France&dagger; · Gabon&dagger; · Gambia&dagger; ·
Georgia&dagger; · Germany&dagger; · Ghana&dagger; · Greece&dagger; · Guyana&dagger; · Hungary&dagger; ·
Iceland&dagger; · India&dagger; · Indonesia · Iran&dagger; · Iraq&dagger; · Ireland&dagger; · Israel&dagger; · Italy&dagger; ·
Jamaica&dagger; · Japan&dagger; · Jordan&dagger; · Kazakhstan · Kenya&dagger; · Kiribati&dagger; ·
Kuwait&dagger; · Kyrgyzstan&dagger; · Laos&dagger; · Latvia&dagger; · Lebanon&dagger; · Lesotho&dagger; ·
Liberia&dagger; · Libya&dagger; · Lithuania&dagger; · Luxembourg&dagger; · Malawi&dagger; · Malaysia&dagger; · Maldives&dagger; ·
Malta&dagger; · Marshall Islands&dagger; · Mauritania&dagger; · Mauritius&dagger; · Mexico&dagger; ·
Moldova&dagger; · Mongolia&dagger; · Montenegro&dagger; · Morocco&dagger; · Mozambique&dagger; · Myanmar&dagger; ·
Namibia&dagger; · Nauru&dagger; · Nepal&dagger; · Netherlands&dagger; · New Zealand&dagger; ·
Niger&dagger; · Niue&dagger; · Norway&dagger; · Oman&dagger; · Palau&dagger; · Palestine&dagger; ·
Panama&dagger; · Papua New Guinea&dagger; · Paraguay&dagger; · Peru&dagger; · Philippines&dagger; ·
Poland&dagger; · Portugal&dagger; · Qatar&dagger; · Romania&dagger; · Russia&dagger; · Rwanda&dagger; ·
Saint Lucia&dagger; · Saint Vincent and the Grenadines&dagger; · Samoa&dagger; ·
Sao Tome and Principe&dagger; · Saudi Arabia&dagger; · Senegal&dagger; · Serbia&dagger; · Seychelles&dagger; ·
Sierra Leone&dagger; · Singapore&dagger; · Solomon Islands&dagger; · South Africa&dagger; ·
South Korea&dagger; · Spain&dagger; · Sri Lanka&dagger; · Sudan&dagger; · Sweden&dagger; · Syria&dagger; ·
Tajikistan&dagger; · Tanzania&dagger; · Thailand&dagger; · Timor-Leste&dagger; · Togo&dagger; ·
Tonga&dagger; · Tunisia&dagger; · Turkmenistan&dagger; · Tuvalu&dagger; · Türkiye&dagger; ·
Uganda&dagger; · Ukraine&dagger; · United Arab Emirates&dagger; · United Kingdom&dagger; ·
United States&dagger; · Uruguay&dagger; · Uzbekistan&dagger; · Vanuatu&dagger; · Venezuela&dagger; ·
Vietnam&dagger; · Zambia&dagger; · Zimbabwe&dagger;

&dagger; = also has sex-specific rates in `data/cleaned/obesity-by-sex.csv` (154 countries). The 2
without a dagger have no by-sex row in the companion file: **Indonesia** (the RISKESDAS sex split is
published only at the &ge; 25 Asian cut-off, not at BMI &ge; 30) and **Kazakhstan** (its 2021-22 total is
reconstructed from urban/rural figures, with no sex breakdown). Some daggered countries carry by-sex for
only part of their series (e.g. Denmark's intermediate SUSY waves and Colombia 2005 are persons-only).

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

Latin America & the Caribbean (Bolivia, Uruguay, Paraguay, Costa Rica; Jamaica, Barbados, Panama,
Dominican Republic, El Salvador, Cuba — STEPS, national health-examination and risk-factor surveys)
sit mostly **mid-to-high** (24-34%), with multi-wave series for Jamaica (2000-2017), Panama
(2003-2010) and Paraguay (2011-2022). The Caribbean shows the panel's **largest female skew** (Jamaica
and Barbados women run 2-3x men), while **Cuba (15.0%)** is the regional low — well under its neighbours.

The residual-Europe block (Belgium, Croatia, Czechia, Greece, Luxembourg, Malta, Portugal, Romania,
Serbia) is **measured-only by design**: most European countries' recurring national surveys (EHIS) are
*self-reported* and were excluded, so each series here comes from a measured examination survey (EHES /
national HES, MONICA, ORISCAV, or a measured-anthropometry NHS). **Malta (34.1%) and Czechia (32.7%)**
are the panel's rare **male-skewed** series. Belgium illustrates the gap the design avoids — measured
21.0% vs the self-reported 15.9%.

A later expansion (each point **verified against its primary** STEPS/DHS/national-survey report, not a
secondary aggregator) adds: the EMRO block (Iraq 33.9%, Afghanistan 17.2%); more measured European
series (Ukraine 24.8%, Moldova 22.7%, Belarus 25.4%, Albania — a rare European DHS); Bhutan (11.4%);
the largest remaining DHS gaps (DR Congo, plus Guyana, Maldives, Timor-Leste — male anthropometry being
the binding constraint, so both-sexes points are reconstructed 50/50); and more Caribbean/Pacific STEPS
(Saint Lucia, Saint Vincent, Palau 42.9%, Marshall Islands, Niue 61.0%, Papua New Guinea). **Mauritius**
enters as a third *age-standardised* series (its NCD survey publishes no crude BMI &ge; 30). Deliberately
**excluded** for failing the measured-national-BMI&ge;30 bar: Yemen (no national STEPS), Suriname
(ethnic-specific cutoffs only), Madagascar/Guinea/Burundi (women-only DHS), and dependent territories
that are not WHO member states (e.g. Tokelau).

A further round adds **Venezuela** (EVESCAM 24.6%) and fills in measured Europe — **Hungary** (the OTAP
nutritional-status survey), the **Baltic republics** (Estonia 8.0%, Latvia 13.5%, Lithuania 14.9%, from a
1997 measured survey), **Iceland** (the Reykjavik Heart Association cohort, used as broadly national) and
**Montenegro** (the EU Menu survey) — plus **Austria** as a *second self-reported* series (with Denmark,
both bias-corrected). After this, only **Indonesia** and **Kazakhstan** lack a sex-specific companion row.

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
│   │   ├── USA.csv  GBR.csv  CAN.csv  AUS.csv  NZL.csv  …  (one per country, 148 total)
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
| `basis`        | `crude` or `age-standardised` (standardised for China, Italy, Mauritius & the two oldest USA points) |
| `measurement`  | `measured` or `self-reported` (self-reported only for Denmark and Austria) |
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
`published` throughout: these are by-sex figures from the source — reported directly, or computed
from its public microdata as for the US — it's the *totals* in the main panel that are sometimes
`reconstructed` as their 50/50 average.) It exists because the
male/female gap is itself a striking cross-country pattern: tiny or male-favouring in rich Western
countries, reversing over time in East Asia (China/Japan), enormous and female-skewed in South
Africa (+30 pp), Eswatini (+22 pp), Egypt (+24 pp), the Caribbean (Jamaica +25 pp, Barbados +20 pp,
women 2-3x men) and across sub-Saharan Africa (women 4-6x men in Ghana, Tanzania, Senegal), and —
unusually — near-parity at very high levels in the Pacific, where Nauru is even slightly male-skewed.
A handful of recent European measured surveys run the **other** way (men higher): Malta (-5.6 pp) and
Czechia (-10.1 pp). The per-row `basis` notes crude vs age-standardised and any age
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

- **Age ranges differ**: e.g. NZ adults are 15+, UK 16+, Australia/Canada 18+, US 20+ (20-74 for
  the pre-1988 NHANES waves, which had no 75+).
- **Crude vs age-standardized**: values here are **crude** prevalence (to match the basis
  most national headline figures and the US NHANES series use), not age-standardized.
- **Measured vs self-reported**: all points aim to be from *measured* height/weight; self-reported
  waves (which understate obesity) are excluded — with **two exceptions, Denmark and Austria** (the only
  self-reported series, both bias-corrected), included for coverage by request and flagged as such (not
  comparable head-to-head).
  A few series are **age-standardised** rather than crude (China, Italy and Mauritius, whose
  national reports publish no crude BMI &ge; 30; and the two oldest US points — 1960-62 & 1971-74 —
  whose crude is not recoverable from microdata). All flagged per point in `data/raw/README.md`.
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