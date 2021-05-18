
* ECON 21030 Econometrics - Honors
* Spring 2020, Final Project
* This version: 06/07/2020
* Author: Becky Scurlock

* Clear pre-existing work
clear all

* Prevent long code from stopping during execution
set more off


********************************************************************************
******************************** (0) ENVIRONMENT *******************************
********************************************************************************

* Set directories
global 	root 		"/Users/beckyscurlock/Documents/"
global	maindir		"$root/Other/Classes/Spring 2020/Metrics/Stata/Final Project/"
global 	rawdir 		"$maindir/Data"
global	outdir 		"$maindir/out"

* Install packages 
//ssc install reghdfe 
//ssc install estout

********************************************************************************
******************************* (1) DATA CLEANING ******************************
********************************************************************************

* UNEMPLOYMENT CLAIMS DATA
* Read in CSV 
import delimited "$rawdir/weekly_initial_claims.csv"

* Rename variables
forval i = 1/12 {
	forval j = 1/4 {
		local num = (`i' - 1)*4 + `j' + 1
		rename v`num' ws`i'`j'
	}
}
* Reshape data 
rename v1 county
reshape long ws, i(county) j(weeksex)
tostring(weeksex), replace

* Generate sex and week variables
gen sex = substr(weeksex,-1,1)
gen week = substr(weeksex,1,length(weeksex)-1)
drop weeksex 
rename ws claims
drop if county == "ï»¿Week" | county == "Gender"

* Create indicator for female, drop nonbinary counts
destring(sex), replace // convert sex and week back to integers
destring(week), replace
drop if sex == 1 | sex == 4
replace sex = 1 if sex == 2
replace sex = 0 if sex == 3 

* Replace stars with missing values and convert to numeric
replace claims = "" if claims == "*"
destring(claims), replace

* Generate indicator of missing claim data
gen claim_missing = 0
replace claim_missing = 1 if claims == .

* Make columns for claims by sex
reshape wide claims claim_missing, i(county week) j(sex)
rename claims0 male_claims
rename claims1 female_claims
rename claim_missing0 male_missing
rename claim_missing1 female_missing

* Insert day at end of week corresponding to each numbered week
local dates 7-Mar 14-Mar 21-Mar 28-Mar 4-Apr 11-Apr 18-Apr ///
	25-Apr 2-May 9-May 16-May 23-May
	
local i = 1 // index corresponding to numbered week

gen week_end_real = ""

foreach j of local dates {
	replace week_end_real = "`j'" if week == `i'
	local ++i
}

* Generate week_end variable with same end week for Mar 21-28 (1st post-period)
gen week_end = week_end_real
replace week_end = "28-Mar" if week_end == "21-Mar" // Add week to first period
drop week

* Collapse data to get unique weeks
collapse (sum) male_claims male_missing female_claims female_missing, ///
	by(week_end county)

* Replace sums with missing data
replace female_claims = . if female_claims == 0 & female_missing != 0
replace male_claims = . if male_claims == 0 & male_missing != 0

* Delete "county" after each county name
replace county = subinstr(county, " County", "", .)

* Drop state total/out of state/not disclosed
drop if county == "State Total" | county == "Not Disclosed" ///
	| county == "Out of State" 

* Create tempfile, save, and clear
tempfile claims
save `claims'
clear


* LABOR FORCE DATA
* Read in CSV 
import delimited "$rawdir/2018_census.csv", varnames(1)

* Calculate number of people in labor force, drop other variables
keep county male_pop_2064 male_lfp_2064 female_pop_2064 female_lfp_2064
gen lf_male = (male_lfp_2064*male_pop_2064)/100
gen lf_female = (female_lfp_2064*female_pop_2064)/100
drop male_pop_2064 male_lfp_2064 female_pop_2064 female_lfp_2064

* Merge with unemployment claims data
replace county = subinstr(county, " County, Washington", "", .)
merge 1:m county using `claims', nogenerate

* Generate variables to measure difference in claims
gen claim_perc = female_claims/(female_claims + male_claims)
gen unemp_gr_diff = (female_claims/lf_female) - (male_claims/lf_male)

* Collapse pre-period difference and change week to last (for robustness check)
replace claim_perc = -claim_perc if week_end == "7-Mar"
replace unemp_gr_diff = -unemp_gr_diff if week_end == "7-Mar"
replace week_end = "14-Mar" if week_end == "7-Mar"
collapse (sum) male_claims female_claims claim_perc unemp_gr_diff ///
	(max) male_missing female_missing, by(week_end county)
replace claim_perc = . if female_missing == 1 | male_missing == 1
replace unemp_gr_diff = . if female_missing == 1 | male_missing == 1
drop female_missing male_missing 
	
gen pre_period = 0
replace pre_period = 1 if week_end == "14-Mar"
replace week_end = "23-May" if week_end == "14-Mar" //match pre to last period

* Save file
save "$outdir/empdata", replace
clear

* ENROLLMENT DATA
* Read in csv
import delimited "$rawdir/2020_enrollment.csv"

* Drop unnecessary observations and variables
drop if schoolname != "District Total"
keep county districtname gradelevel allstudents

* Clean grade level and enrollment variables
replace gradelevel = subinstr(gradelevel, " Grade", "", .)
keep if gradelevel == "Pre-Kindergarten" | gradelevel == "Kindergarten" | ///
	gradelevel == "1st" | gradelevel == "2nd" | gradelevel == "3rd" ///
	| gradelevel == "4th" | gradelevel == "5th"
replace allstudents = subinstr(allstudents, ",", "", .)
destring(allstudents), replace

* Collapse enrollment data to district level (from school level)
collapse (sum) allstudents (first) county, by(districtname)
bysort county : egen county_enroll = total(allstudents)

* Clean districtname variable to match district/county data
replace districtname = upper(districtname)
replace districtname = subinstr(districtname, " #49", "", .)
replace districtname = subinstr(districtname, " NO. 64", "", .)
replace districtname = subinstr(districtname, "SEATTLE SCHOOL DISTRICT #1", ///
	"SEATTLE PUBLIC SCHOOLS", .)
replace districtname = subinstr(districtname, ///
	"INDEX ELEMENTARY SCHOOL DISTRICT 63", "INDEX SCHOOL DISTRICT", .)
	
* Save tempfile
tempfile enrollment
save `enrollment'
clear


********************************************************************************
******************************** (2) DATA MERGE ********************************
********************************************************************************

* Import school district/county data
clear 
import delimited "$rawdir/school_district_county.csv"

* Keep only ditrict name and county 
keep districtna county
rename districtna districtname

* Save data in temporary file
tempfile district_county
save `district_county'

* Import child care survey data, merge (2 questions)
clear 
import delimited "$rawdir/child_care_q1.csv", varnames(1)
rename response cc //cc stand for childcare
tempfile q1
save `q1'
clear
import delimited "$rawdir/child_care_q2.csv", varnames(1)
rename response openings
replace openings = openings/1000 // Openings is thousands of openings
merge 1:1 districtname week_end using `q1', nogenerate 
drop question 

* Clean districtname to match district/county data
replace districtname = upper(districtname)
replace districtname = subinstr(districtname,"WALLAWALLA","WALLA WALLA",.)
replace districtname = subinstr(districtname,"NINEMILE","NINE MILE",.)
replace districtname = subinstr(districtname,"NORTHMASON","NORTH MASON",.)
replace districtname = subinstr(districtname,"SOUTHWHIDBEY","SOUTH WHIDBEY",.)
replace districtname = subinstr(districtname,"MARYWALKER","MARY WALKER",.)
replace districtname = subinstr(districtname,"GREENMOUNTAIN","GREEN MOUNTAIN",.)
replace districtname = ///
	subinstr(districtname,"LAKEWASHINGTON","LAKE WASHINGTON",.)
replace districtname = subinstr(districtname,"(SPOKA..","(SPOKANE)",.)
replace districtname = subinstr(districtname,"(YAKIM..","(YAKIMA)",.)
replace districtname = subinstr(districtname,"DIS..","DISTRICT",.)
replace districtname = subinstr(districtname,"SCHOOL ..","SCHOOL DISTRICT",.)

* Match county to school district
merge m:1 districtname using `district_county'
keep if _merge == 3
drop _merge

* Merge in enrollment data
merge m:1 districtname using `enrollment'
keep if _merge == 3
drop _merge

* Convert childcare to indicator variable
gen cc_ind = 0 
replace cc_ind = 1 if cc == "Yes"

* Calculate # students in responding counties and # openings per county
bysort county week_end : egen county_enroll_r = total(allstudents)
gen allstud2 = allstudents //find # students in district with openings data
replace allstud2 = 0 if openings == . 
bysort county week_end : egen county_enroll_o = total(allstud2)
bysort county week_end : egen tot_openings = total(openings)

* Make childcare consistent within school district (for robustness check) 
gen ind = 1 // generate indicator for each observation
bysort districtname : egen cc_weeks = total(cc_ind) //total weeks of child care
bysort districtname : egen resp_weeks = total(ind) //total weeks responded
gen cc_avg = cc_weeks/resp_weeks 
gen cc_ind_2 = 0 // indicates whether district provided child care most weeks
replace cc_ind_2 = 1 if cc_avg >= 0.5
bysort county week_end : egen tot_cc_2 = total(cc_ind_2)
bysort county week_end : egen c_resp = total(ind) //responses by county/week
gen o_ind = 0 // generate indicator for response to openings question
replace o_ind = 1 if openings != .
bysort county week_end : egen o_resp = total(o_ind) //sum of openings responses

* Collapse school district data to county level (weight by enrollment/district)
collapse (first) tot_openings county_enroll county_enroll_r county_enroll_o ///
	c_resp o_resp (sum) cc_ind cc_ind_2 ind [aweight=allstudents], ///
	by (week_end county)
gen childcare = cc_ind/ind // collapsed ind = # of school districts per county
gen childcare2 = cc_ind_2/ind 
drop cc_ind cc_ind_2 ind
rename tot_openings openings

* Only keep cc_ind_2 with maximum responses (to avoid bias from # responses)
bysort county : egen max_resp = max(c_resp)
gen max_cc_temp = 0
replace max_cc_temp = childcare2 if c_resp == max_resp
bysort county : egen max_cc = max(max_cc_temp)
replace childcare2 = max_cc
drop max_resp max_cc max_cc_temp

* Match school district data to employment data
merge 1:m week_end county using "$outdir/empdata"
drop if _merge != 3
drop _merge

* Make separate dataset for pre-trends to use in robustness checks
preserve
drop if pre_period == 0
tempfile pre_period 
save `pre_period'
restore

* Convert week_end to date format
drop if pre_period == 1 //only use post-period data
replace week_end = subinstr(week_end, "Mar", "3", .)
replace week_end = subinstr(week_end, "Apr", "4", .)
replace week_end = subinstr(week_end, "May", "5", .)
split week_end, p("-") destring
rename week_end1 week_end_day
rename week_end2 week_end_month
sort county week_end_month week_end_day
gen week_end_lag = week_end[_n+1]
replace week_end_lag = "" if week_end_lag == "28-3"
drop week_end_day week_end_month

* Generate copy of child care (so lagged version in new row in regression table)
gen childcare_lag = childcare

* Calculate total number of districts that responded (to child care) each week
bysort week_end: egen week_resp_c = total(c_resp)

* Caluclate total number of ditricts that responded to openings each week
bysort week_end: egen week_resp_o = total(o_resp)

* Calculate percentage of districts that responded 
replace week_resp_c = week_resp_c/294
replace week_resp_o = week_resp_o/294

********************************************************************************
*************************** (3) SUMMARY STATISTICS *****************************
********************************************************************************
 
* Calculate summary statistics for response rates by week and output
preserve
collapse (first) week_resp_c week_resp_o, by(week_end)
estpost summarize week_resp_c week_resp_o
restore 
esttab using "$outdir/summ.tex", ///
	cells("count mean(fmt(3)) sd(fmt(3)) min(fmt(3)) max(fmt(3))") ///
	replace booktabs

* Calculate other summary statistics and output
estpost summarize childcare openings female_claims male_claims claim_perc ///
	unemp_gr_diff
esttab using "$outdir/summ.tex", ///
	cells("count mean(fmt(3)) sd(fmt(3)) min(fmt(3)) max(fmt(3))") ///
	append booktabs

********************************************************************************
******************************* (4) REGRESSIONS ********************************
********************************************************************************

* MAIN REGRESSIONS

/* Set options for regression tables (output LaTeX files, restrict output to 2
decimal points, omit intercepts, include variable labels) */
global optreg 	= " tex(frag) bd(3) sd(3) nocons nonotes label "

* Run regression without clustering (robust SEs)
reghdfe claim_perc childcare, absorb(county week_end) vce(robust)
outreg2 using "$outdir/final_reg1", replace $optreg ctitle(Robust SEs)

* Run regression with clustering
reghdfe claim_perc childcare, absorb(county week_end) ///
	vce(cluster county week_end)
outreg2 using "$outdir/final_reg1", append $optreg ctitle(Clustered SEs)

* Run same regressions with lagged week
preserve
drop if week_end_lag == ""
reghdfe claim_perc childcare_lag, absorb(county week_end_lag) vce(robust)
outreg2 using "$outdir/final_reg1", append $optreg ctitle(Robust SEs)

reghdfe claim_perc childcare_lag, absorb(county week_end_lag) ///
	vce(cluster county week_end_lag)
outreg2 using "$outdir/final_reg1", append $optreg ctitle(Clustered SEs)
restore

* Run same regressions with difference in unemployment rate growth as DV
reghdfe unemp_gr_diff childcare, absorb(county week_end) vce(robust)
outreg2 using "$outdir/final_reg2", replace $optreg ctitle(Robust SEs)

reghdfe unemp_gr_diff childcare, absorb(county week_end) ///
	vce(cluster county week_end)
outreg2 using "$outdir/final_reg2", append $optreg ctitle(Clustered SEs)

preserve
drop if week_end_lag == ""
reghdfe unemp_gr_diff childcare_lag, absorb(county week_end_lag) vce(robust)
outreg2 using "$outdir/final_reg2", append $optreg ctitle(Robust SEs)

reghdfe unemp_gr_diff childcare_lag, absorb(county week_end_lag) ///
	vce(cluster county week_end_lag)
outreg2 using "$outdir/final_reg2", append $optreg ctitle(Clustered SEs)
restore

* Run same regressions with openings as IV (independent variable)
reghdfe claim_perc openings, absorb(county week_end) vce(robust)
outreg2 using "$outdir/final_reg1", append $optreg ctitle(Robust SEs)

reghdfe claim_perc openings, absorb(county week_end) ///
	vce(cluster county week_end)
outreg2 using "$outdir/final_reg1", append $optreg ctitle(Clustered SEs)

reghdfe unemp_gr_diff openings, absorb(county week_end) vce(robust)
outreg2 using "$outdir/final_reg2", append $optreg ctitle(Robust SEs)

reghdfe unemp_gr_diff openings, absorb(county week_end) ///
	vce(cluster county week_end)
outreg2 using "$outdir/final_reg2", append $optreg ctitle(Clustered SEs)


* ROBUSTNESS CHECKS
* 1: Set missing claims to 0
preserve
replace claim_perc = 0 if claim_perc == . 
replace unemp_gr_diff = 0 if unemp_gr_diff == .

reghdfe claim_perc childcare, absorb(county week_end) ///
	vce(cluster county week_end) // DV is female share of unemployment claims
outreg2 using "$outdir/final_reg3", replace $optreg ctitle(Missing = 0)
restore

* 2: Use childcare2 (childcare constant across school districts) as IV
preserve // collapse since childcare is same across weeks
collapse (first) childcare2 (sum) male_claims female_claims, by(county)
gen claim_perc = female_claims/(female_claims + male_claims)
rename childcare2 childcare
reg claim_perc childcare, r // DV is female share of unemployment claims
outreg2 using "$outdir/final_reg3", append $optreg ctitle(Child Care Constant)
restore
	
* 3: Weight openings by (inverse of) percent response by county
replace county_enroll_o = . if county_enroll_o == 0 // avoid dividing by zero
gen openings2 = (openings*county_enroll)/county_enroll_o
replace openings = openings2
reghdfe claim_perc openings, absorb(county week_end) ///
	vce(cluster county week_end) // DV is female share of unemployment claims
outreg2 using "$outdir/final_reg3", append $optreg ctitle(Weighted Openings)

* 4: Test pre-period trends (DV: March 14 claim share - March 7 claim share)
clear
use `pre_period'

reg claim_perc childcare, r // use childcare as IV
outreg2 using "$outdir/final_reg3", append $optreg ctitle(Pre-Period)

reg claim_perc openings, r // use openings as IV
outreg2 using "$outdir/final_reg3", append $optreg ctitle(Pre-Period)
