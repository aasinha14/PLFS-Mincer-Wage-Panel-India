# PLFS Mincer Wage Equation: Heterogeneous Returns to Education in India

---

## Authors

Abhishek Anand Sinha

---

## Research Questions

> *Estimate a Mincerian wage equation for regular salaried/wage employees in India
> and examine how the wage return to education varies by sex, marital status, social
> group, religion, and sector — then interpret the findings using human capital
> theory, Weber's social closure theory, Arrow's statistical discrimination theory,
> and Becker's taste-based discrimination theory.*

This submission answers 5 of 6 assigned questions:
- **Q1**: Returns to education by sex and marital status (separate models per category)
- **Q2**: Returns to education by social group and religion (separate models per category)
- **Q3**: Returns to education by sector (rural/urban)
- **Q4**: Cross-comparison of Q1–Q3, interpreted through the four theoretical lenses above
- **Q5**: Role of individual-level heterogeneity, using a fixed-effects panel model

---

## Dataset

- **Source:** Periodic Labour Force Survey (PLFS), Ministry of Statistics and
  Programme Implementation (MoSPI), Government of India
- **Unit of Analysis:** Individual (regular salaried/wage employees)
- **Rounds used:** PLFS 2020-21, 2021-22, 2022-23, 2023-24, appended into a single panel
- **Sample Size:** 175,390 regular salaried/wage employees (unweighted); 159,136
  unique individuals across the panel
- **Coverage:** All-India, rural and urban

> ⚠️ The raw data files are **not included** in this repository, as they are
> government microdata files. See [`data/README_data.md`](data/README_data.md)
> for instructions on how to access and prepare them.

---

## Methodology

Two estimation strategies were used:

1. **Separate OLS Mincerian wage regressions**, estimated independently for each
   category of sex, marital status, social group, religion, and sector (no pooling,
   no interaction terms, matching the course's taught method)
2. **Fixed-effects (within) panel regression**, using the person-level panel
   identifier, to isolate the role of time-invariant unobserved individual
   heterogeneity

### Variables

| Variable | Type | Description |
|---|---|---|
| `logwage` | Continuous (Dependent) | Log of earnings from regular salaried/wage activity |
| `year_edu` | Continuous | Years of formal education completed |
| `experience` | Continuous | Potential experience = age − year_edu − 6 |
| `exp2` | Continuous | Experience squared (captures declining returns) |
| `sex` | Categorical | Male, Female |
| `marital_status` | Categorical | Never Married, Currently Married, Widowed, Divorced/Separated |
| `social_group` | Categorical | ST, SC, OBC, Others/General |
| `religion` | Categorical | Hindu, Muslim, Christian, Sikh, Jain, Buddhist, Zoroastrian, Others |
| `sector` | Binary | Rural, Urban |
| `acws` | Filter | Current Weekly Status code — restricted to 31, 71, 72 (regular salaried/wage) |

---

## Key Findings

### Returns to education (year_edu coefficient) by group

| Category | Group | Return | N |
|---|---|---|---|
| Social group | Scheduled Tribe (ST) | **12.8%** (highest) | 21,710 |
| Social group | Scheduled Caste (SC) | **9.56%** (lowest) | 29,856 |
| Social group | OBC | 10.2% | 66,043 |
| Social group | Others/General | 11.4% | 57,364 |
| Religion | Islam | **9.04%** (lowest, usable N) | 18,836 |
| Religion | Sikhism | **12.6%** (highest, usable N) | 3,628 |
| Religion | Hinduism | 11.1% | 134,770 |
| Sex | Female | 12.3% | 43,620 |
| Sex | Male | 10.1% | 131,353 |
| Sector | Urban | 11.3% | 115,642 |
| Sector | Rural | 9.57% | 59,331 |
| Marital status | Currently Married | 11.2% (highest) | 121,866 |
| Marital status | Widowed | 9.72% (lowest) | 7,374 |

All coefficients significant at p < 0.001 unless noted otherwise (Jainism and
Zoroastrianism religion categories have very small N and unstable/insignificant
experience terms — see full report for details).

### Individual heterogeneity (fixed-effects panel model)

| Statistic | Value |
|---|---|
| year_edu (within) | 0.100 |
| rho (share of variance from individual effects) | **0.520** |
| corr(u_i, Xb) | 0.0621 |
| Observations / Groups | 174,973 / 159,136 |

Over half of total wage variance is explained by time-invariant, unobserved
individual characteristics rather than education or experience alone.

---

## Theoretical Framing

Findings are interpreted through four lenses:
- **Human capital theory**: baseline positive return to education, holds in every subgroup
- **Weber's social closure theory**: tests whether historically privileged groups show higher returns (only partially supported — ST results contradict a simple closure story)
- **Arrow's statistical discrimination theory**: employers using group identity as a productivity proxy under imperfect information
- **Becker's taste-based discrimination theory**: persistent wage gaps for SC and Muslim workers even after controlling for education

---

## How to Reproduce the Analysis

1. Download the four PLFS rounds from MoSPI (see [`data/README_data.md`](data/README_data.md))
2. Place the `.dta` files in the `data/` folder and update the file paths at the
   top of `PLFS_Mincer_Analysis.do`
3. Open Stata and run `PLFS_Mincer_Analysis.do` from start to finish
4. Outputs (Excel tables) are saved to `outputs/tables/`

**Software:** Stata
**Packages required:** `outreg2` (standard Stata commands otherwise — `destring`,
`recode`, `egen group()`, `regress`, `xtreg`, `xtset`)

---

## Data Ethics Note

The PLFS unit-level microdata is anonymised and publicly available from MoSPI.
No individual can be identified from this data. Estimates in this project are
**unweighted** (no sampling multiplier was available in the provided dataset) —
this is noted as a limitation in the full report and should be kept in mind when
interpreting population-level representativeness.

---

## License

This project is licensed under [CC BY 4.0](LICENSE) — you are free to use, share,
and adapt with attribution.
