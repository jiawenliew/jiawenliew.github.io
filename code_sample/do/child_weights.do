clear all
set more off
log using ../log/child_weights.log, replace

**************************************
* Children synthetic control weights *
**************************************

tempfile child_weights
save `child_weights', emptyok

forvalues z = 1/7 {
	if `z' == 1 {
		global group = "all"
	}
	if `z' == 2 {
		global group = "female"
	}
	if `z' == 3 {
		global group = "male"
	}
	if `z' == 4 {
		global group = "age1"
	}
	if `z' == 5 {
		global group = "age2"
	}
	if `z' == 6 {
		global group = "age3"
	}
	if `z' == 7 {
		global group = "age4"
	}
	forvalues p = 1/3 {
		if `p' == 1 {
			global outcome = "livmomonly"
		}
		if `p' == 2 {
			global outcome = "livdadonly"
		}
		if `p' == 3 {
			global outcome = "livparents"
		}
		global dataset = "../int/child_${outcome}_${group}_full.dta"
		use ${dataset}, clear
		drop if _W_Weight == 0
		rename _Co_Number ${group}_${outcome}_s
		rename _W_Weight ${group}_${outcome}_w
		drop _Y_treated _Y_synthetic _time
		append using `child_weights'
		save `"`child_weights'"', replace
	}
}

export excel using ../output/child_weights.xls, firstrow(variables) replace

log close
