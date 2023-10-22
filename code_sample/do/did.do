clear all
set more off
log using ../log/did.log, replace

************************
* DID estimates adults *
************************

capture erase ../output/DID_adult_full.xls
capture erase ../output/DID_adult_full.txt
capture erase ../output/DID_adult_narrow.xls
capture erase ../output/DID_adult_narrow.txt
shell touch ../output/DID_adult_full.xls
shell touch ../output/DID_adult_narrow.xls


forvalues k = 1/2 {
	if `k' == 1 {
		global width = "full"
	}
	if `k' == 2 {
		global width = "narrow"
	}
	forvalues i = 1/3 {
		if `i' == 1 {
			global group = "female"
		}
		if `i' == 2 {
			global group = "male"
		}
		if `i' == 3 {
			global group = "heads"
			global fixedeffects = "age1 age2 educ1 educ2 child5 racewhite female"
		}
		if `i' <= 2 {
			global fixedeffects = "age1 age2 educ1 educ2 child5 racewhite"
		}
		global covariates = "treatgroup apfd tapfd"
		forvalues z = 1/3 {
			global dataset = "../dta/asec_adult_${group}_did_${width}.dta"
			if `z' == 1 {
				global outcome = "livmarspouse"
			}
			if `z' == 2 {
				global outcome = "ownhouse"
			}
			if `z' == 3 {
				global outcome = "married"
			}
			use ${dataset}, clear
			reg ${outcome} ${covariates}, cluster(statefip)
			outreg2 using ../output/DID_adult_${width}.xls, append ctitle(${group} ${outcome} OLS)
			xtreg ${outcome} ${covariates} ${fixedeffects}, fe vce(cluster statefip)
			outreg2 using ../output/DID_adult_${width}.xls, append ctitle(${group} ${outcome} FE)
	}
	}
}

**************************
* DID estimates children *
**************************

capture erase ../output/DID_child_full.xls
capture erase ../output/DID_child_full.txt
capture erase ../output/DID_child_narrow.xls
capture erase ../output/DID_child_narrow.txt
shell touch ../output/DID_child_full.xls
shell touch ../output/DID_child_narrow.xls


forvalues k = 1/2 {
	if `k' == 1 {
		global width = "full"
	}
	if `k' == 2 {
		global width = "narrow"
	}
	forvalues i = 1/7 {
		if `i' == 1 {
			global group = "all"
			global fixedeffects = "age1 age2 age3 sib1 sib2 sib3 racewhite female"
		}
		if `i' == 2 {
			global group = "female"
		}
		if `i' == 3 {
			global group = "male"
		}
		if `i' == 4 {
			global group = "age1"
		}
		if `i' == 5 {
			global group = "age2"
		}
		if `i' == 6 {
			global group = "age3"
		}
		if `i' == 7 {
			global group = "age4"
		}
		if `i' >= 2 & `i' <= 3 {
			global fixedeffects = "age1 age2 age3 sib1 sib2 sib3 racewhite"
		}
		if `i' >= 4 {
			global fixedeffects = "sib1 sib2 sib3 female racewhite"
		}
		global covariates = "treatgroup apfd tapfd"
		forvalues z = 1/3 {
			global dataset = "../dta/asec_child_${group}_did_${width}.dta"
			if `z' == 1 {
				global outcome = "livmomonly"
			}
			if `z' == 2 {
				global outcome = "livdadonly"
			}
			if `z' == 3 {
				global outcome = "livparents"
			}
			use ${dataset}, clear
			reg ${outcome} ${covariates}, cluster(statefip)
			outreg2 using ../output/DID_child_${width}.xls, append ctitle(${group} ${outcome} OLS)			
			xtreg ${outcome} ${covariates} ${fixedeffects}, fe vce(cluster statefip)
			outreg2 using ../output/DID_child_${width}.xls, append ctitle(${group} ${outcome} FE)
	}
	}
}

log close
