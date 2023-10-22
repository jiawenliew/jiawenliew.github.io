clear all
set more off
log using ../log/adult_weights.log, replace

***********************************
* Adult synthetic control weights *
***********************************

tempfile adult_weights
save `adult_weights', emptyok

forvalues i = 1/3 {
	if `i' == 1 {
		global group = "female"
	}
	if `i' == 2 {
		global group = "male"
	}
	if `i' == 3 {
		global group = "heads"
	}
	forvalues k = 1/3 {
		if `k' == 1 {
			global outcome = "livmarspouse"
		}
		if `k' == 2 {
			global outcome = "ownhouse"
		}
		if `k' == 3 {
			global outcome = "married"
		}
		global dataset = "../int/adult_${outcome}_${group}_full.dta"
		use ${dataset}, clear
		drop if _W_Weight == 0
		rename _Co_Number ${group}_${outcome}_s
		rename _W_Weight ${group}_${outcome}_w
		drop _Y_treated _Y_synthetic _time
		append using `adult_weights'
		save `"`adult_weights'"', replace
	}
}

export excel using ../output/adult_weights.xls, firstrow(variables) replace

log close
