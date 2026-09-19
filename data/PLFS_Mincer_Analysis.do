*==============================================================
* PLFS Mincer Wage Equation Project
* 4-year appended panel (PLFS 2020-21 to 2023-24)
* Author: Abhishek
*==============================================================

* NOTE: change this to wherever your appended dta lives
* use "C:\Users\aasin\OneDrive\Desktop\Advanced Dataset\PLFS\PLFS\plfs21.dta"
* append using "...\plfs22.dta" "...\plfs23.dta" "...\plfs24.dta", generate(t)

*==============================================================
* PANEL IDENTIFIER SETUP
*==============================================================
br pid
egen id = group(pid)
drop if id==.

xtset id t
* Panel variable: id (unbalanced)
* Time variable: t, 0 to 3, but with gaps

duplicates report id t
* Confirms 0 surplus - one row per person per round

*==============================================================
* VALUE LABELS
*==============================================================
label define religion_lbl 1 "Hinduism" 2 "Islam" 3 "Christianity" 4 "Sikhism" 5 "Jainism" 6 "Buddhism" 7 "Zoroastrianism" 9 "Others"
label values religion religion_lbl

label define sector_lbl 1 "Rural" 2 "Urban"
label values sector sector_lbl

label define sex_lbl 1 "Male" 2 "Female"
label values sex sex_lbl

label define social_group_lbl 1 "ST" 2 "SC" 3 "OBC" 9 "Others/General"
label values social_group social_group_lbl

label define marital_lbl 1 "Never Married" 2 "Currently Married" 3 "Widowed" 4 "Divorced/Separated"
label values marital_status marital_lbl

*==============================================================
* MINCER VARIABLES
*==============================================================
gen logwage = ln(wage)
gen experience = age - year_edu - 6
gen exp2 = experience^2

* Data quality checks run before finalizing (kept for documentation)
sum wage if (acws==31|acws==71|acws==72), detail
count if wage==0 & (acws==31|acws==71|acws==72)
tab acws, m
tab sector religion social_group sex marital_status

*==============================================================
* Q1: Returns to education by SEX and MARITAL STATUS
*==============================================================
reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & sex==1
outreg2 using Q1_sex.xls, replace ctitle("Male") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & sex==2
outreg2 using Q1_sex.xls, append ctitle("Female") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & marital_status==1
outreg2 using Q1_marital.xls, replace ctitle("Never Married") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & marital_status==2
outreg2 using Q1_marital.xls, append ctitle("Currently Married") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & marital_status==3
outreg2 using Q1_marital.xls, append ctitle("Widowed") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & marital_status==4
outreg2 using Q1_marital.xls, append ctitle("Divorced/Separated") pvalue noaster

*==============================================================
* Q2: Returns to education by SOCIAL GROUP and RELIGION
*==============================================================
reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & social_group==1
outreg2 using Q2_socialgroup.xls, replace ctitle("ST") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & social_group==2
outreg2 using Q2_socialgroup.xls, append ctitle("SC") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & social_group==3
outreg2 using Q2_socialgroup.xls, append ctitle("OBC") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & social_group==9
outreg2 using Q2_socialgroup.xls, append ctitle("Others/General") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==1
outreg2 using Q2_religion.xls, replace ctitle("Hinduism") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==2
outreg2 using Q2_religion.xls, append ctitle("Islam") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==3
outreg2 using Q2_religion.xls, append ctitle("Christianity") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==4
outreg2 using Q2_religion.xls, append ctitle("Sikhism") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==5
outreg2 using Q2_religion.xls, append ctitle("Jainism") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==6
outreg2 using Q2_religion.xls, append ctitle("Buddhism") pvalue noaster

* Zoroastrianism: N=8 in this sample - reported for completeness only,
* not statistically usable (see write-up)
reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==7
outreg2 using Q2_religion.xls, append ctitle("Zoroastrianism") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & religion==9
outreg2 using Q2_religion.xls, append ctitle("Others") pvalue noaster

*==============================================================
* Q3: Returns to education by SECTOR (Rural/Urban)
*==============================================================
reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & sector==1
outreg2 using Q3_sector.xls, replace ctitle("Rural") pvalue noaster

reg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72) & sector==2
outreg2 using Q3_sector.xls, append ctitle("Urban") pvalue noaster

*==============================================================
* Q6: Fixed-effects panel regression (individual heterogeneity)
*==============================================================
xtreg logwage year_edu experience exp2 if (acws==31|acws==71|acws==72), fe
outreg2 using Q6_FE_results.xls, replace pvalue noaster
