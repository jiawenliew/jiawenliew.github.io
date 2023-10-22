clear all
set more off
log using ../log/synth_placebos_full.log, replace

*************************************
**# Placebos for adults 1977 - 2019 *
*************************************

forvalues k = 1/51 {
	forvalues i = 1/3 {
		if `i' == 1 {
			global group = "female"
		}
		if `i' == 2 {
			global group = "male"
		}
		if `i' == 3 {
			global group = "heads"
			global predictors = "age1 age2 educ1 educ2 child5 racewhite female"
		}
		if `i' <= 2 {
			global predictors = "age1 age2 educ1 educ2 child5 racewhite"
		}
		forvalues z = 1/3 {
			global xperiod = "(1977(1)1981)"
			global dataset = "../dta/asec_adult_collapsed_${group}.dta"
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
			synth ${outcome} ${outcome}${xperiod} ${predictors}, trunit(`k') trperiod(1982) nested allopt keep(../int/adult_placebo_${outcome}_${group}_full_`k'.dta, replace) fig
			graph export ../figures/adult_placebo_${outcome}_${group}_full_`k'.png, replace
	}
	}
}

***************************************
**# Placebos for children 1977 - 2019 *
***************************************

forvalues k = 1/51 {
	forvalues i = 1/7 {
		if `i' == 1 {
			global group = "all"
			global predictors = "age1 age2 age3 sib1 sib2 sib3 racewhite female"
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
			global predictors = "age1 age2 age3 sib1 sib2 sib3 racewhite"
		}
		if `i' >= 4 {
			global predictors = "sib1 sib2 sib3 female racewhite"
		}
		forvalues z = 1/3 {
			global xperiod = "(1977(1)1981)"
			global dataset = "../dta/asec_child_collapsed_${group}"
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
			synth ${outcome} ${outcome}${xperiod} ${predictors}, trunit(`k') trperiod(1982) nested allopt keep(../int/child_${outcome}_${group}_full_`k'.dta, replace) fig
			graph export ../figures/child_${outcome}_${group}_full_`k'.png, replace
	}
	}
}

log close
