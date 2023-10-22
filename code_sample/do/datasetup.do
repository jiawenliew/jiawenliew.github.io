clear all
set more off
log using ../log/setup.log, replace

*********************************************
* Data Setup for adults (aged 16 and above) *
*********************************************

use ../raw/IPUMS_asec_7719.dta, clear

* Generate hhid to identify households *
egen hhid = concat(year serial)

* Has child <19yo in HH *
sort hhid relate
by hhid: egen haschild = max(0|relate==301 & age < 19) // only consider households with at least one person labelled as 'child' under relate and aged 18 and below

save ../dta/asec_main_micro.dta, replace

use ../dta/asec_main_micro.dta, clear

* Keep only HH with child <19yo *
keep if haschild == 1 // only keep households with at least 1 child 

* Keep only relevant adults *
keep if relate == 101 | relate == 201 | relate == 202 | relate == 203 | relate == 1114 | relate == 1116 | relate == 1117 // head, spouse, opp sex spouse, same sex spouse, unmarried partner, opp sex unmarried partner, same sex unmarried partner

* Drop if age < 19 *
drop if age < 19
drop if age > 65

* Outcome variables *
gen ownhouse = ownershp == 10 // whether house is owned 
gen livmarspouse = marst == 1 & sploc != 0 // live with married spouse

* Marital status *
gen married = 0
replace married = 1 if marst == 1
replace married = 1 if marst == 2

* Education *
gen educ1 = educ>=2 & educ<=60 // Grade 11 (high school junior) or less
gen educ2 = educ>=70 & educ<=73 // Grade 12 (completed high school)
gen educ3 = educ>=80 // 1 year college or more

* Age *
gen age1 = age>=18 & age<=24
gen age2 = age>=25 & age<=44
gen age3 = age>=45 & age <=65

* Gender *
gen female = sex == 2

* White *
gen racewhite = race == 100

* Children aged below 5 in home *
gen child5 = nchlt5 >= 1

* Label variables *
label var hhid "household id"
label var haschild "hh has at least one child <19yo"
label var ownhouse "=1 if house is owned or being bought"
label var livmarspouse "living with married spouse"
label var married "=1 if married"
label var educ1 "grade 11 or less"
label var educ2 "grade 12 completed"
label var educ3 "1 year of college or more"
label var age1 "age 18-24"
label var age2 "age 25-44"
label var age3 "age 45-64"
label var female "=1 if female"
label var child5 "=1 if at least 1 own child aged < 5 in household"
label var racewhite "=1 if white, else non-white"

order year serial hhid pernum statefip relate age female racewhite child5 educ1 educ2 educ3 age1 age2 age3 haschild ownhouse livmarspouse married

save ../dta/asec_adult_micro.dta, replace

* Save files into respective samples *

// females //
use ../dta/asec_adult_micro.dta, clear
keep if female == 1
save ../int/asec_adult_micro_female.dta, replace

// males //
use ../dta/asec_adult_micro.dta, clear
keep if female == 0
save ../int/asec_adult_micro_male.dta, replace

// heads //
use ../dta/asec_adult_micro.dta, clear
keep if relate == 101
save ../int/asec_adult_micro_heads.dta, replace


***********************************
* Collapse data for female adults *
***********************************

use ../int/asec_adult_micro_female.dta, clear
collapse educ* age* married racewhite child5 ownhouse livmarspouse [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_adult_collapsed_female.dta, replace

*********************************
* Collapse data for male adults *
*********************************

use ../int/asec_adult_micro_male.dta, clear
collapse educ* age* married racewhite child5 ownhouse livmarspouse [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_adult_collapsed_male.dta, replace

********************************
* Collapse data for heads only *
********************************

use ../int/asec_adult_micro_heads.dta, clear
collapse educ* age* married racewhite female child5 ownhouse livmarspouse [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_adult_collapsed_heads.dta, replace

*********************************************
**# Data Setup for children (aged below 19) *
*********************************************

use ../dta/asec_main_micro.dta, clear

* Keep only HH with child <19yo *
keep if haschild == 1 // only keep households with at least 1 child 

* Keep children only *
keep if age < 19 & relate == 301

* Outcome variables *
gen livmomonly = 0
replace livmomonly = 1 if momloc != 0 & poploc == 0 & momloc2 == 0

gen livdadonly = 0
replace livdadonly = 1 if poploc != 0 & momloc == 0 & poploc2 == 0

gen livparents = 0
replace livparents = 1 if momloc !=0 & poploc != 0 // opposite sex parents
replace livparents = 1 if momloc !=0 & momloc2 != 0 // 2 mothers
replace livparents = 1 if poploc != 0 & poploc2 != 0 // 2 fathers

* Gender *
gen female = sex == 2

* White *
gen racewhite = race == 100

* Siblings *
gen sib1 = nsibs == 0 // No siblings
gen sib2 = nsibs == 1 // One sibling
gen sib3 = nsibs == 2 // Two siblings
gen sib4 = nsibs >= 3 // Three or more siblings

* Age *
gen age1 = age<=4 // Infant or toddler
gen age2 = age>=5 & age<=10 // Elementary school
gen age3 = age>=11 & age<=13 // Middle school
gen age4 = age>=14 // High school

* Label variables *
label var livmomonly "=1 if live with one parent (mother)"
label var livdadonly "=1 if live with one parent (father)"
label var livparents "=1 if live with both parents (mother+father, mother+mother, father+father)"
label var female "=1 if female"
label var racewhite "=1 if white, else non-white/mixed"
label var sib1 "No siblings in hh"
label var sib2 "One sibling in hh"
label var sib3 "Two siblings in hh"
label var sib4 "Three or more siblings in hh"
label var age1 "Is infant or toddler"
label var age2 "Elementary school aged"
label var age3 "Middle school aged"
label var age4 "High school aged"

save ../dta/asec_child_micro.dta, replace

* Save into respective samples *

// females //
use ../dta/asec_child_micro.dta, clear
keep if female == 1
save ../int/asec_child_micro_female.dta, replace

// males //
use ../dta/asec_child_micro.dta, clear
keep if female == 0
save ../int/asec_child_micro_male.dta, replace

// age 0-4 //
use ../dta/asec_child_micro.dta, clear
keep if age1 == 1
save ../int/asec_child_micro_age1.dta, replace

// age 5-10 //
use ../dta/asec_child_micro.dta, clear
keep if age2 == 1
save ../int/asec_child_micro_age2.dta, replace

// age 11-13 //
use ../dta/asec_child_micro.dta, clear
keep if age3 == 1
save ../int/asec_child_micro_age3.dta, replace

// age 14-18 //
use ../dta/asec_child_micro.dta, clear
keep if age4 == 1
save ../int/asec_child_micro_age4.dta, replace


**********************************
* Collapse data for all children *
**********************************

use ../dta/asec_child_micro.dta, clear
collapse sib* age* racewhite livmomonly livdadonly livparents female [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_child_collapsed_all.dta, replace

*************************************
* Collapse data for female children *
*************************************

use ../int/asec_child_micro_female.dta, clear
collapse sib* age* racewhite livmomonly livdadonly livparents [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_child_collapsed_female.dta, replace

***********************************
* Collapse data for male children *
***********************************

use ../int/asec_child_micro_male.dta, clear
collapse sib* age* racewhite livmomonly livdadonly livparents [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_child_collapsed_male.dta, replace

***********************************
* Collapse data for children age1 *
***********************************

use ../int/asec_child_micro_age1.dta, clear
collapse sib* racewhite female livmomonly livdadonly livparents [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_child_collapsed_age1.dta, replace

***********************************
* Collapse data for children age2 *
***********************************

use ../int/asec_child_micro_age2.dta, clear
collapse sib* racewhite female livmomonly livdadonly livparents [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_child_collapsed_age2.dta, replace

***********************************
* Collapse data for children age3 *
***********************************

use ../int/asec_child_micro_age3.dta, clear
collapse sib* racewhite female livmomonly livdadonly livparents [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_child_collapsed_age3.dta, replace

***********************************
* Collapse data for children age4 *
***********************************

use ../int/asec_child_micro_age4.dta, clear
collapse sib* racewhite female livmomonly livdadonly livparents [pw=asecwt], by(year statefip)
egen statenum = group(statefip)
label define state_names 1 "alabama" 2 "alaska" 3 "arizona" 4 "arkansas" 5 "california" 6 "colorado" 7 "connecticut" 8 "delaware" 9 "district of columbia" 10 "florida" 11 "georgia" 12 "hawaii" 13 "idaho" 14 "illinois" 15 "indiana" 16 "iowa" 17 "kansas" 18 "kentucky" 19 "louisiana" 20 "maine" 21 "maryland" 22 "massachusetts" 23 "michigan" 24 "minnesota" 25 "mississippi" 26 "missouri" 27 "montana" 28 "nebraska" 29 "nevada" 30 "new hampshire" 31 "new jersey" 32 "new mexico" 33 "new york" 34 "north carolina" 35 "north dakota" 36 "ohio" 37 "oklahoma" 38 "oregon" 39 "pennsylvania" 40 "rhode island" 41 "south carolina" 42 "south dakota" 43 "tennessee" 44 "texas" 45 "utah" 46 "vermont" 47 "virginia" 48 "washington" 49 "west virginia" 50 "wisconsin" 51 "wyoming"
label values statenum state_names
tsset statenum year
save ../dta/asec_child_collapsed_age4.dta, replace

***************************************
* Generate datasets for DID estimates *
***************************************

forvalues i = 1/10 {
	if `i' == 1 {
		global group = "female"
	}
	if `i' == 2 {
		global group = "male"
	}
	if `i' == 3 {
		global group = "heads"
	}
	if `i' == 4 {
		global group = "all"
	}
	if `i' == 5 {
		global group = "female"
	}
	if `i' == 6 {
		global group = "male"
	}
	if `i' == 7 {
		global group = "age1"
	}
	if `i' == 8 {
		global group = "age2"
	}
	if `i' == 9 {
		global group = "age3"
	}
	if `i' == 10 {
		global group = "age4"
	}
	if `i' <= 3 {
		global samp = "adult"
	}
	if `i' >= 4 {
		global samp = "child"
	}
	global dataset = "../dta/asec_${samp}_collapsed_${group}.dta"
	use ${dataset}, clear
	gen treatgroup = statefip == 2
	gen apfd = year >= 1982
	gen tapfd = treatgroup*apfd
	xtset statefip year
	save ../dta/asec_${samp}_${group}_did_full.dta, replace
	drop if year > 1989
	save ../dta/asec_${samp}_${group}_did_narrow.dta, replace
}

log close
