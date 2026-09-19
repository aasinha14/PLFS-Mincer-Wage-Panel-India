# Data Access Instructions

The raw PLFS unit-level data files are **not included** in this repository, as they
are government microdata files distributed by MoSPI (not to be redistributed
directly by third parties).

## Source

Periodic Labour Force Survey (PLFS), Ministry of Statistics and Programme
Implementation (MoSPI), Government of India.

- Portal: [https://mospi.gov.in](https://mospi.gov.in) / National Data Archive (NDAP)
- Rounds used: PLFS 2020-21, 2021-22, 2022-23, 2023-24 (unit-level person records)

## Steps to reproduce this dataset

1. Download the unit-level data files for each of the four PLFS rounds above from
   the MoSPI portal.
2. Place all four `.dta` files in this `data/` folder (this folder is git-ignored,
   so they will not be committed).
3. Open `PLFS_Mincer_Analysis.do` at the repo root and update the file paths at the
   top (`use "..."` / `append using "..."`) to point to your local copies.
4. Run the do-file from the top — it appends all four rounds into a single panel,
   builds the panel identifier (`egen id = group(pid)`), and proceeds with the
   full analysis.

## Sample restriction

All regressions are restricted to regular salaried/wage employees, identified via
current weekly activity status codes 31, 71, and 72 (see PLFS Instruction Manual,
Block 6, for code definitions).
