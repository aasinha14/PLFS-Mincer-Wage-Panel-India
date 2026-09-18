# Data Access Instructions

The raw PLFS unit-level data files used in this project are **not included** in this repository, in line with MoSPI's data-sharing terms for government microdata.

## Source

- **Survey:** Periodic Labour Force Survey (PLFS)
- **Publisher:** National Sample Survey Office (NSSO), Ministry of Statistics and Programme Implementation (MoSPI), Government of India
- **Access point:** MoSPI PLFS data portal / NDAP (National Data & Analytics Platform)
- **Rounds used:** [PENDING, list the 4 specific PLFS annual rounds/years appended in this panel]
- **State:** [PENDING]

## Steps to Reproduce the Panel

1. Download the relevant PLFS unit-level record files for each of the 4 rounds/years from the MoSPI portal.
2. Filter each round's file to the selected state.
3. Confirm the person identifier (PID) is constructed consistently across all 4 rounds before appending; see `code/plfs_mincer_panel.do` for the exact PID-construction logic used.
4. Confirm the survey weight variable name and definition are consistent across rounds.
5. Append the 4 state-filtered round files into a single panel dataset.
6. Save the appended file into this `data/` folder under the filename referenced at the top of `code/plfs_mincer_panel.do`.

This file is intentionally left generic until the state and exact round years are finalized; update it once confirmed.
