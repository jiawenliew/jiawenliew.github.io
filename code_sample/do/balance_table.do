clear all
set more off
log using ../log/balance_table.log, replace

***************************************
**# Adult pre-treatment balance table *
***************************************

capture erase ../output/adult_balance_table_female.xls
capture erase ../output/adult_balance_table_male.xls
capture erase ../output/adult_balance_table_heads.xls
capture erase ../output/child_balance_table_all.xls
capture erase ../output/child_balance_table_female.xls
capture erase ../output/child_balance_table_male.xls
capture erase ../output/child_balance_table_age1.xls
capture erase ../output/child_balance_table_age2.xls
capture erase ../output/child_balance_table_age3.xls
capture erase ../output/child_balance_table_age4.xls

// livmarspouse - female //
use ../dta/asec_adult_collapsed_female.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.183 if statefip == 16 // idaho
replace weight = 0.164 if statefip == 49 // utah
replace weight = 0.118 if statefip == 54 // west virginia
replace weight = 0.535 if statefip == 56 // wyoming

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "racewhite"
	}
	if `z' == 3 {
		global outcome = "livmarspouse"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 16
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_female.xls, sheet("livmarspouse") firstrow(variables) replace

// ownhouse - female //
use ../dta/asec_adult_collapsed_female.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.051 if statefip == 5 // arkansas
replace weight = 0.320 if statefip == 11 // d.c.
replace weight = 0.199 if statefip == 16 // idaho
replace weight = 0.431 if statefip == 49 // utah

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "racewhite"
	}
	if `z' == 3 {
		global outcome = "ownhouse"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 5
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_female.xls, sheet("ownhouse") firstrow(variables)

// married - female //
use ../dta/asec_adult_collapsed_female.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.325 if statefip == 38 // north dakota
replace weight = 0.675 if statefip == 56 // wyoming

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "married"
	}
	if `z' == 3 {
		global outcome = "racewhite"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 38
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_female.xls, sheet("married") firstrow(variables)

// livmarspouse - male //
use ../dta/asec_adult_collapsed_male.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.255 if statefip == 11 // d.c.
replace weight = 0.745 if statefip == 41 // oregon

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "racewhite"
	}
	if `z' == 3 {
		global outcome = "livmarspouse"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_male.xls, sheet("livmarspouse") firstrow(variables) replace

// ownhouse - male //
use ../dta/asec_adult_collapsed_male.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.192 if statefip == 5 // arkansas
replace weight = 0.292 if statefip == 11 // d.c.
replace weight = 0.002 if statefip == 15 // hawaii
replace weight = 0.027 if statefip == 41 // oregon
replace weight = 0.488 if statefip == 46 // south dakota

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "racewhite"
	}
	if `z' == 3 {
		global outcome = "ownhouse"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 5
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_male.xls, sheet("ownhouse") firstrow(variables)

// married - male //
use ../dta/asec_adult_collapsed_male.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.208 if statefip == 11 // d.c.
replace weight = 0.118 if statefip == 18 // indiana
replace weight = 0.674 if statefip == 41 // oregon

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "married"
	}
	if `z' == 3 {
		global outcome = "racewhite"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_male.xls, sheet("married") firstrow(variables)

// livmarspouse - heads //
use ../dta/asec_adult_collapsed_heads.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.266 if statefip == 15 // hawaii
replace weight = 0.301 if statefip == 41 // oregon
replace weight = 0.433 if statefip == 56 // wyoming

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/4 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "racewhite"
	}
	if `z' == 3 {
		global outcome = "female"
	}
	if `z' == 4 {
		global outcome = "livmarspouse"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_heads.xls, sheet("livmarspouse") firstrow(variables) replace

// ownhouse - heads //
use ../dta/asec_adult_collapsed_heads.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.063 if statefip == 11 // d.c.
replace weight = 0.162 if statefip == 15 // hawaii
replace weight = 0.776 if statefip == 41 // oregon

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/4 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "racewhite"
	}
	if `z' == 3 {
		global outcome = "female"
	}
	if `z' == 4 {
		global outcome = "ownhouse"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_heads.xls, sheet("ownhouse") firstrow(variables)

// married - heads //
use ../dta/asec_adult_collapsed_heads.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.164 if statefip == 15 // hawaii
replace weight = 0.222 if statefip == 41 // oregon
replace weight = 0.613 if statefip == 56 // wyoming

forvalues k = 1/3 {
	egen mean_educ`k' = mean(educ`k'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_educ`k' = mean_educ`k'*weight
	egen sum_mean_educ`k' = total(mean_educ`k') if statefip != 2 & year == 1977
	replace mean_educ`k' = sum_mean_educ`k' if statefip != 2
	drop sum_mean_educ`k'
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
}

forvalues z = 1/4 {
	if `z' == 1 {
		global outcome = "child5"
	}
	if `z' == 2 {
		global outcome = "married"
	}
	if `z' == 3 {
		global outcome = "racewhite"
	}
	if `z' == 4 {
		global outcome = "female"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-livmarspouse
drop weight

export excel using ../output/adult_balance_table_heads.xls, sheet("married") firstrow(variables)

***************************************
**# Child pre-treatment balance table *
***************************************

// livmomonly - all //
use ../dta/asec_child_collapsed_all.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.219 if statefip == 16 // idaho
replace weight = 0.118 if statefip == 40 // oklahoma
replace weight = 0.663 if statefip == 56 // wyoming

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livmomonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 16
drop year-female
drop weight

export excel using ../output/child_balance_table_all.xls, sheet("livmomonly") firstrow(variables)

// livdadonly - all //
use ../dta/asec_child_collapsed_all.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.295 if statefip == 11 // d.c.
replace weight = 0.705 if statefip == 41 // oregon

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-female
drop weight

export excel using ../output/child_balance_table_all.xls, sheet("livdadonly") firstrow(variables)

// livparents - all //
use ../dta/asec_child_collapsed_all.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.142 if statefip == 15 // hawaii
replace weight = 0.105 if statefip == 16 // idaho
replace weight = 0.482 if statefip == 40 // oklahoma
replace weight = 0.271 if statefip == 56 // wyoming

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-female
drop weight

export excel using ../output/child_balance_table_all.xls, sheet("livparents") firstrow(variables)

// livmomonly - female //
use ../dta/asec_child_collapsed_female.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.146 if statefip == 15 // hawaii
replace weight = 0.854 if statefip == 46 // south dakota

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/2 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "livmomonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-livparents
drop weight

export excel using ../output/child_balance_table_female.xls, sheet("livmomonly") firstrow(variables)

// livdadonly - female //
use ../dta/asec_child_collapsed_female.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.004 if statefip == 11 // d.c.
replace weight = 0.028 if statefip == 32 // nevada
replace weight = 0.967 if statefip == 41 // oregon

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/2 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-livparents
drop weight

export excel using ../output/child_balance_table_female.xls, sheet("livdadonly") firstrow(variables)

// livparents - female //
use ../dta/asec_child_collapsed_female.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.413 if statefip == 21 // kentucky
replace weight = 0.337 if statefip == 40 // oklahoma
replace weight = 0.015 if statefip == 54 // west virginia
replace weight = 0.235 if statefip == 56 // wyoming


forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/2 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 21
drop year-livparents
drop weight

export excel using ../output/child_balance_table_female.xls, sheet("livparents") firstrow(variables)

// livmomonly - male //
use ../dta/asec_child_collapsed_male.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.341 if statefip == 15 // hawaii
replace weight = 0.154 if statefip == 16 // idaho
replace weight = 0.192 if statefip == 20 // kansas
replace weight = 0.313 if statefip == 56 // wyoming

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/2 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "livmomonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-livparents
drop weight

export excel using ../output/child_balance_table_male.xls, sheet("livmomonly") firstrow(variables)

// livdadonly - male //
use ../dta/asec_child_collapsed_male.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.271 if statefip == 11 // d.c.
replace weight = 0.105 if statefip == 15 // hawaii
replace weight = 0.010 if statefip == 16 // idaho
replace weight = 0.243 if statefip == 18 // indiana
replace weight = 0.294 if statefip == 38 // north dakota
replace weight = 0.077 if statefip == 41 // oregon

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/2 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-livparents
drop weight

export excel using ../output/child_balance_table_male.xls, sheet("livdadonly") firstrow(variables)

// livparents - male //
use ../dta/asec_child_collapsed_male.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.029 if statefip == 11 // d.c.
replace weight = 0.327 if statefip == 15 // hawaii
replace weight = 0.334 if statefip == 16 // idaho
replace weight = 0.004 if statefip == 41 // oregon
replace weight = 0.158 if statefip == 54 // west virginia
replace weight = 0.148 if statefip == 56 // wyoming

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	egen mean_age`i' = mean(age`i'), by(statefip)
	
	replace mean_age`i' = mean_age`i'*weight
	egen sum_mean_age`i' = total(mean_age`i') if statefip !=2 & year == 1977
	replace mean_age`i' = sum_mean_age`i' if statefip != 2
	drop sum_mean_age`i'
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/2 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-livparents
drop weight

export excel using ../output/child_balance_table_male.xls, sheet("livparents") firstrow(variables)

// livmomonly - age1 //
use ../dta/asec_child_collapsed_age1.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.135 if statefip == 15 // hawaii
replace weight = 0.528 if statefip == 33 // new hampshire
replace weight = 0.095 if statefip == 37 // north carolina
replace weight = 0.243 if statefip == 50 // vermont

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livmomonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age1.xls, sheet("livmomonly") firstrow(variables)

// livdadonly - age1 //
use ../dta/asec_child_collapsed_age1.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.726 if statefip == 9 // connecticut
replace weight = 0.274 if statefip == 15 // hawaii

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 9
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age1.xls, sheet("livdadonly") firstrow(variables)

// livparents - age1 //
use ../dta/asec_child_collapsed_age1.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.003 if statefip == 4 // arizona
replace weight = 0.001 if statefip == 5 // arkansas
replace weight = 0.008 if statefip == 6 // california
replace weight = 0.003 if statefip == 8 // colorado
replace weight = 0.002 if statefip == 9 // connecticut
replace weight = 0.002 if statefip == 10 // delaware
replace weight = 0.004 if statefip == 11 // d.c.
replace weight = 0.001 if statefip == 12 // florida
replace weight = 0.002 if statefip == 13 // georgia
replace weight = 0.186 if statefip == 15 // hawaii
replace weight = 0.011 if statefip == 16 // idaho
replace weight = 0.001 if statefip == 17 // illinois
replace weight = 0.001 if statefip == 18 // indiana
replace weight = 0.002 if statefip == 19 // iowa
replace weight = 0.001 if statefip == 20 // kansas
replace weight = 0.005 if statefip == 21 // kentucky
replace weight = 0.001 if statefip == 23 // maine
replace weight = 0.002 if statefip == 25 // massachusetts
replace weight = 0.001 if statefip == 26 // michigan
replace weight = 0.064 if statefip == 27 // minnesota
replace weight = 0.001 if statefip == 28 // mississippi
replace weight = 0.002 if statefip == 29 // missouri
replace weight = 0.003 if statefip == 30 // montana
replace weight = 0.004 if statefip == 31 // nebraska
replace weight = 0.003 if statefip == 32 // nevada
replace weight = 0.123 if statefip == 33 // new hampshire
replace weight = 0.002 if statefip == 34 // new jersey
replace weight = 0.007 if statefip == 35 // new mexico
replace weight = 0.001 if statefip == 36 // new york
replace weight = 0.325 if statefip == 37 // north carolina
replace weight = 0.004 if statefip == 38 // north dakota
replace weight = 0.001 if statefip == 39 // ohio
replace weight = 0.002 if statefip == 40 // oklahoma
replace weight = 0.002 if statefip == 41 // oregon
replace weight = 0.003 if statefip == 42 // pennsylvania
replace weight = 0.001 if statefip == 44 // rhode island
replace weight = 0.001 if statefip == 45 // south carolina
replace weight = 0.002 if statefip == 46 // south dakota
replace weight = 0.001 if statefip == 47 // tennessee
replace weight = 0.004 if statefip == 48 // texas
replace weight = 0.002 if statefip == 49 // utah
replace weight = 0.016 if statefip == 50 // vermont
replace weight = 0.004 if statefip == 51 // virginia
replace weight = 0.169 if statefip == 53 // washington
replace weight = 0.003 if statefip == 54 // west virginia
replace weight = 0.001 if statefip == 55 // wisconsin
replace weight = 0.011 if statefip == 56 // wyoming

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livparents"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 4
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age1.xls, sheet("livparents") firstrow(variables)

// livmomonly - age2 //
use ../dta/asec_child_collapsed_age2.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.288 if statefip == 35 // new mexico
replace weight = 0.272 if statefip == 38 // north dakota
replace weight = 0.440 if statefip == 49 // utah

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livmomonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 35
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age2.xls, sheet("livmomonly") firstrow(variables)

// livdadonly - age2 //
use ../dta/asec_child_collapsed_age2.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.132 if statefip == 11 // d.c.
replace weight = 0.106 if statefip == 15 // hawaii
replace weight = 0.123 if statefip == 24 // maryland
replace weight = 0.198 if statefip == 32 // nevada
replace weight = 0.211 if statefip == 33 // new hampshire
replace weight = 0.230 if statefip == 41 // oregon

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 11
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age2.xls, sheet("livdadonly") firstrow(variables)

// livparents - age2 //
use ../dta/asec_child_collapsed_age2.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.495 if statefip == 21 // kentucky
replace weight = 0.020 if statefip == 32 // nevada
replace weight = 0.288 if statefip == 35 // new mexico
replace weight = 0.197 if statefip == 49 // utah

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livparents"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 21
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age2.xls, sheet("livparents") firstrow(variables)

// livmomonly - age3 //
use ../dta/asec_child_collapsed_age3.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.262 if statefip == 15 // hawaii
replace weight = 0.730 if statefip == 40 // oklahoma
replace weight = 0.008 if statefip == 46 // south dakota

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livmomonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age3.xls, sheet("livmomonly") firstrow(variables)

// livdadonly - age3 //
use ../dta/asec_child_collapsed_age3.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.192 if statefip == 20 // kansas
replace weight = 0.007 if statefip == 29 // missouri
replace weight = 0.480 if statefip == 41 // oregon
replace weight = 0.320 if statefip == 49 // utah

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 20
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age3.xls, sheet("livdadonly") firstrow(variables)

// livparents - age3 //
use ../dta/asec_child_collapsed_age3.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.133 if statefip == 4 // arizona
replace weight = 0.354 if statefip == 15 // hawaii
replace weight = 0.365 if statefip == 40 // oklahoma
replace weight = 0.148 if statefip == 56 // wyoming

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livparents"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 4
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age3.xls, sheet("livparents") firstrow(variables)

// livmomonly - age4 //
use ../dta/asec_child_collapsed_age4.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.607 if statefip == 23 // maine
replace weight = 0.393 if statefip == 38 // north dakota

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livmomonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 23
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age4.xls, sheet("livmomonly") firstrow(variables)

// livdadonly - age4 //
use ../dta/asec_child_collapsed_age4.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.434 if statefip == 10 // delaware
replace weight = 0.057 if statefip == 11 // d.c.
replace weight = 0.509 if statefip == 32 // nevada

forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livdadonly"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 10
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age4.xls, sheet("livdadonly") firstrow(variables)

// livparents - age4 //
use ../dta/asec_child_collapsed_age4.dta, clear

drop if year >= 1982
gen alaska = statefip == 2
gen weight = 0
replace weight = 1 if statefip == 2 // alaska
replace weight = 0.010 if statefip == 15 // hawaii
replace weight = 0.422 if statefip == 23 // maine
replace weight = 0.498 if statefip == 30 // montana
replace weight = 0.048 if statefip == 38 // north dakota
replace weight = 0.006 if statefip == 49 // utah
replace weight = 0.016 if statefip == 50 // vermont


forvalues i = 1/4 {
	egen mean_sib`i' = mean(sib`i'), by(statefip)
	
	replace mean_sib`i' = mean_sib`i'*weight
	egen sum_mean_sib`i' = total(mean_sib`i') if statefip !=2 & year == 1977
	replace mean_sib`i' = sum_mean_sib`i' if statefip != 2
	drop sum_mean_sib`i'
}

forvalues z = 1/3 {
	if `z' == 1 {
		global outcome = "racewhite"
	}
	if `z' == 2 {
		global outcome = "female"
	}
	if `z' == 3 {
		global outcome = "livparents"
	}
	egen mean_${outcome} = mean(${outcome}), by(statefip)
	replace mean_${outcome} = mean_${outcome}*weight
	egen sum_mean_${outcome} = total(mean_${outcome}) if statefip != 2 & year == 1977
	replace mean_${outcome} = sum_mean_${outcome} if statefip != 2
	drop sum_mean_${outcome}
}

drop if weight == 0 | year > 1977 | statefip > 15
drop year-livparents
drop weight

export excel using ../output/child_balance_table_age4.xls, sheet("livparents") firstrow(variables)

log close
