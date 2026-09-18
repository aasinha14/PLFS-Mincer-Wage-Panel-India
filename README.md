# Mincer Wage Equation and Panel Wage Determinants in India: Evidence from PLFS 2021 to 2024

---

## Authors

Abhishek Anand Sinha, MA in Public Policy & Governance, TISS

---

## Research Question

> *Estimate the returns to education and experience in India using a Mincer wage equation on a 4-year appended PLFS panel, comparing pooled OLS and fixed-effects estimates, and examining how these returns differ by social group, sex, and religion.*

---

## Dataset

- **Source:** Periodic Labour Force Survey (PLFS), Ministry of Statistics and Programme Implementation (MoSPI), Government of India
- **Unit of Analysis:** Individual (usual principal + subsidiary status, employed persons)
- **Panel Structure:** 4 appended rounds, individual-level panel linked via PID
- **Sample Size:** ~16 lakh, unbalanced
- **Coverage:** Rural and Urban

> ⚠️ The raw PLFS unit-level data files are **not included** in this repository, as they are government microdata files subject to MoSPI's terms of use. See [`data/README_data.md`](data/README_data.md) for instructions on how to access and prepare them.

---

## Methodology

Two core estimation strategies are used, following the project's Stata command reference (`destring`, `recode`, `egen group()`, `tab [iw=weight]`, `regress`, `xtreg, fe`, `logit`/`or`, `outreg2`, `margins`, `coefplot`):

1. **Mincer Wage Equation**: `ln(wage)` regressed on years of education, potential experience (`age - year_edu - 6`), and experience-squared
2. **Pooled OLS**: baseline estimate across all appended rounds, ignoring individual-level panel structure
3. **Fixed Effects (Within Estimator)**: `xtreg, fe` to net out time-invariant unobserved individual heterogeneity (u_i)
4. **Stratified Subgroup Regressions**: separate `bysort` regressions by social group, sex, and religion (not interaction terms), following the primary do-file's method
5. **Diagnostics**: rho, sigma_u, sigma_e, and the F-test on u_i = 0 to justify FE over pooled OLS

### Variables

| Variable      | Type                | Description                                                                 |
| ------------- | ------------------- | ----------------------------------------------------------------------------|
| `ln_wage`     | Continuous (Dependent) | Log of wage/earnings                                                      |
| `year_edu`    | Continuous          | Years of completed education                                               |
| `experience`  | Continuous          | Potential experience = age − year_edu − 6                                  |
| `exp2`        | Continuous          | Experience squared                                                         |
| `social_group`| Categorical         | ST, SC, OBC, Others (reference); confirm against `codebook`             |
| `sex`         | Categorical         | Male, Female                                                                |
| `religion`    | Categorical         | Hindu (reference), Muslim, Christian, Sikh, and other groups present in state |
| `year`/`round`| Panel/time control  | Round or year identifier; name to confirm from data                     |
| `weight`      | Survey weight        | PLFS survey weight variable; name to confirm from data                  |
| `PID`         | Panel identifier     | Person ID used to link individuals across the 4 appended rounds; confirm consistency across rounds |

> Variable names above are placeholders pending `describe, full` / `codebook` output on the actual state-level extract; see project notes.

---

## Key Findings

### Pooled OLS vs. Fixed Effects

| Variable      | Pooled OLS | Fixed Effects |
| ------------- | ---------- | -------------- |
| `year_edu`    | 0.1105     | 0.1002         |
| `experience`  | 0.0447     | 0.0332         |
| `exp2`        | -0.0005    | -0.0004        |

- FE model: **rho = 0.5199** (≈52% of unexplained variance attributable to individual-specific effects), **corr(u_i, Xb) = 0.0621**

> All results to be exported via `outreg2` to Excel; see `outputs/tables/`.

---

## Literature

Minimum 10 cited empirical papers on Indian labour markets (caste wage gaps, gender wage gaps, religion-based labour market outcomes, Mincerian returns to education), APA style, in-text citations tied to each interpreted coefficient. See `outputs/literature_review.docx` [or equivalent] for the full reference list.

---

## How to Reproduce the Analysis

1. Download the relevant PLFS unit-level data files from MoSPI/NDAP (see `data/README_data.md`)
2. Place the cleaned, state-filtered, appended 4-year panel file in the `data/` folder, named as specified in the do file
3. Open Stata and run `code/plfs_mincer_panel.do` from start to finish
4. Outputs (regression tables, coefplots) will be saved to `outputs/tables/` and `outputs/graphs/`

**Software:** Stata
**Packages required:** `outreg2`, `coefplot` (install via `ssc install outreg2` / `ssc install coefplot` if not already installed); otherwise standard Stata commands only.

---

## Data Ethics Note

PLFS unit-level microdata is anonymised and publicly available from MoSPI/NDAP. No individual can be identified from this data. All analysis uses PLFS survey weights to produce representative estimates for the selected state.

---

## License

This project is licensed under [CC BY 4.0](LICENSE); you are free to use, share, and adapt with attribution.
