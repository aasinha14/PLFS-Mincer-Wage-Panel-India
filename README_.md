# PLFS Mincer Wage Equation — Panel Analysis

Master's project (Public Policy & Governance) examining how returns to education
vary across gender, marital status, social group, religion, and sector (rural/urban)
in India, using a Mincerian wage equation estimated on an appended 4-year PLFS panel
(2020-21 to 2023-24).

## Research questions answered

- **Q1** — Returns to education by sex and marital status (separate models per category)
- **Q2** — Returns to education by social group and religion (separate models per category)
- **Q3** — Returns to education by sector (rural/urban)
- **Q4** — Cross-comparison of Q1–Q3 returns, interpreted through human capital theory,
  Weber's social closure theory, Arrow's statistical discrimination theory, and
  Becker's taste-based discrimination theory
- **Q6** — Role of individual-level heterogeneity, using a fixed-effects panel model

(Q5, the policy-implications question, was not selected for this submission — 5 of 6
questions were required.)

## Data

Source: Periodic Labour Force Survey (PLFS), Ministry of Statistics and Programme
Implementation (MoSPI), Government of India — unit-level data, 2020-21 through 2023-24
rounds, appended into a single panel.

**Raw microdata is not included in this repository** (large files, and best practice
is for each user to download PLFS unit-level data directly from MoSPI/NDAP/NSSO
rather than redistribute it). To reproduce this analysis, download the four PLFS
rounds yourself and point the `use`/`append` paths at the top of the do-file to your
local copies.

## Method

- Dependent variable: log(wage), restricted to regular salaried/wage employees
  (activity status codes 31, 71, 72 — see repo notes / instruction manual)
- Key regressors: years of education, potential experience (age − years of
  education − 6), experience squared
- Subgroup estimation: separate OLS regressions per category (not interaction terms),
  matching the primary do-file's method
- Panel/individual heterogeneity: fixed-effects (within) regression on the person-level
  panel identifier

## Repository structure

```
├── README.md
├── do-files/
│   └── PLFS_Mincer_Analysis.do      # full, reproducible Stata do-file
├── output/
│   ├── Q1_sex.xls
│   ├── Q1_marital.xls
│   ├── Q2_socialgroup.xls
│   ├── Q2_religion.xls
│   ├── Q3_sector.xls
│   └── Q6_FE_results.xls
└── report/
    └── PLFS_Mincer_Report.docx      # final write-up with interpretation and references
```

## Key findings (summary)

- Returns to education are positive and significant in every subgroup studied — the
  baseline human capital prediction holds everywhere.
- The *size* of the return varies substantially: highest for Scheduled Tribes (12.8%)
  and lowest for Scheduled Castes (9.56%) among social groups; lowest for Islam (9.04%)
  among religions with adequate sample size; higher for urban (11.3%) than rural (9.57%).
- A fixed-effects panel regression shows over half of total wage variation (ρ ≈ 0.52)
  is explained by time-invariant, unobserved individual characteristics rather than
  education or experience alone — supporting the view that social background and
  identity carry independent economic weight beyond human capital.

## References

Full APA reference list is included in the final report (`report/` folder).
