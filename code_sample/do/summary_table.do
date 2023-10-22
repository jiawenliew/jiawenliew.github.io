clear all
set more off
log using ../log/summary_table.log, replace

**********************
* Summary Statistics *
**********************

// Adult females //
use ../dta/asec_adult_collapsed_female.dta, clear
gen alaska = statefip == 2
egen mean_livmarspouse = mean(livmarspouse), by(year alaska)
replace mean_livmarspouse = round(mean_livmarspouse, 0.001)*100
egen mean_ownhouse = mean(ownhouse), by(year alaska)
replace mean_ownhouse = round(mean_ownhouse, 0.001)*100
egen mean_married = mean(married), by(year alaska)
replace mean_married = round(mean_married, 0.001)*100

sort year statefip

drop if statefip > 2
drop statefip-livmarspouse

export excel using ../output/adult_female_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmarspouse year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmarspouse year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult females") xtitle("Year") ytitle("Percentage living with married spouse") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/female_livmarspouse_trend.png, replace

graph twoway (connected mean_ownhouse year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_ownhouse year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult females") xtitle("Year") ytitle("Percentage own house") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/female_ownhouse_trend.png, replace

graph twoway (connected mean_married year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_married year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult females") xtitle("Year") ytitle("Percentage married") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/female_married_trend.png, replace

// Adult males //
use ../dta/asec_adult_collapsed_male.dta, clear
gen alaska = statefip == 2
egen mean_livmarspouse = mean(livmarspouse), by(year alaska)
replace mean_livmarspouse = round(mean_livmarspouse, 0.001)*100
egen mean_ownhouse = mean(ownhouse), by(year alaska)
replace mean_ownhouse = round(mean_ownhouse, 0.001)*100
egen mean_married = mean(married), by(year alaska)
replace mean_married = round(mean_married, 0.001)*100

sort year statefip

drop if statefip > 2
drop statefip-livmarspouse

export excel using ../output/adult_male_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmarspouse year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmarspouse year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult males") xtitle("Year") ytitle("Percentage living with married spouse") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/male_livmarspouse_trend.png, replace

graph twoway (connected mean_ownhouse year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_ownhouse year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult males") xtitle("Year") ytitle("Percentage own house") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/male_ownhouse_trend.png, replace

graph twoway (connected mean_married year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_married year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult males") xtitle("Year") ytitle("Percentage married") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/male_married_trend.png, replace

// Adult heads //
use ../dta/asec_adult_collapsed_heads.dta, clear
gen alaska = statefip == 2
egen mean_livmarspouse = mean(livmarspouse), by(year alaska)
replace mean_livmarspouse = round(mean_livmarspouse, 0.001)*100
egen mean_ownhouse = mean(ownhouse), by(year alaska)
replace mean_ownhouse = round(mean_ownhouse, 0.001)*100
egen mean_married = mean(married), by(year alaska)
replace mean_married = round(mean_married, 0.001)*100

sort year statefip

drop if statefip > 2
drop statefip-livmarspouse

export excel using ../output/adult_heads_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmarspouse year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmarspouse year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult heads") xtitle("Year") ytitle("Percentage living with married spouse") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/heads_livmarspouse_trend.png, replace

graph twoway (connected mean_ownhouse year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_ownhouse year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult heads") xtitle("Year") ytitle("Percentage own house") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/heads_ownhouse_trend.png, replace

graph twoway (connected mean_married year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_married year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Adult heads") xtitle("Year") ytitle("Percentage married") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/heads_married_trend.png, replace

// All children //
use ../dta/asec_child_collapsed_all.dta, clear
gen alaska = statefip == 2
egen mean_livmomonly = mean(livmomonly), by(year alaska)
replace mean_livmomonly = round(mean_livmomonly, 0.001)*100
egen mean_livdadonly = mean(livdadonly), by(year alaska)
replace mean_livdadonly = round(mean_livdadonly, 0.001)*100
egen mean_livparents = mean(livparents), by(year alaska)
replace mean_livparents = round(mean_livparents, 0.001)*100
sort year statefip

drop if statefip > 2
drop statefip-female

export excel using ../output/child_all_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmomonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmomonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("All children") xtitle("Year") ytitle("Percentage live with single mother") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/all_livmomonly_trend.png, replace

graph twoway (connected mean_livdadonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livdadonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("All children") xtitle("Year") ytitle("Percentage live with single father") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/all_livdadonly_trend.png, replace

graph twoway (connected mean_livparents year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livparents year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("All children") xtitle("Year") ytitle("Percentage live with parents") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/all_livparents_trend.png, replace

// Female children //
use ../dta/asec_child_collapsed_female.dta, clear
gen alaska = statefip == 2
egen mean_livmomonly = mean(livmomonly), by(year alaska)
replace mean_livmomonly = round(mean_livmomonly, 0.001)*100
egen mean_livdadonly = mean(livdadonly), by(year alaska)
replace mean_livdadonly = round(mean_livdadonly, 0.001)*100
egen mean_livparents = mean(livparents), by(year alaska)
replace mean_livparents = round(mean_livparents, 0.001)*100
sort year statefip

drop if statefip > 2
drop statefip-livparents

export excel using ../output/child_female_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmomonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmomonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Female children") xtitle("Year") ytitle("Percentage live with single mother") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/female_livmomonly_trend.png, replace

graph twoway (connected mean_livdadonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livdadonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Female children") xtitle("Year") ytitle("Percentage live with single father") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/female_livdadonly_trend.png, replace

graph twoway (connected mean_livparents year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livparents year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Female children") xtitle("Year") ytitle("Percentage live with parents") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/female_livparents_trend.png, replace

// Male children //
use ../dta/asec_child_collapsed_male.dta, clear
gen alaska = statefip == 2
egen mean_livmomonly = mean(livmomonly), by(year alaska)
replace mean_livmomonly = round(mean_livmomonly, 0.001)*100
egen mean_livdadonly = mean(livdadonly), by(year alaska)
replace mean_livdadonly = round(mean_livdadonly, 0.001)*100
egen mean_livparents = mean(livparents), by(year alaska)
replace mean_livparents = round(mean_livparents, 0.001)*100
sort year statefip

drop if statefip > 2
drop statefip-livparents

export excel using ../output/child_male_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmomonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmomonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Male children") xtitle("Year") ytitle("Percentage live with single mother") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/male_livmomonly_trend.png, replace

graph twoway (connected mean_livdadonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livdadonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Male children") xtitle("Year") ytitle("Percentage live with single father") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/male_livdadonly_trend.png, replace

graph twoway (connected mean_livparents year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livparents year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Male children") xtitle("Year") ytitle("Percentage live with parents") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/male_livparents_trend.png, replace

// Children aged 0-4 //
use ../dta/asec_child_collapsed_age1.dta, clear
gen alaska = statefip == 2
egen mean_livmomonly = mean(livmomonly), by(year alaska)
replace mean_livmomonly = round(mean_livmomonly, 0.001)*100
egen mean_livdadonly = mean(livdadonly), by(year alaska)
replace mean_livdadonly = round(mean_livdadonly, 0.001)*100
egen mean_livparents = mean(livparents), by(year alaska)
replace mean_livparents = round(mean_livparents, 0.001)*100
sort year statefip

drop if statefip > 2
drop statefip-livparents

export excel using ../output/child_age1_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmomonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmomonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 0-4") xtitle("Year") ytitle("Percentage live with single mother") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age1_livmomonly_trend.png, replace

graph twoway (connected mean_livdadonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livdadonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 0-4") xtitle("Year") ytitle("Percentage live with single father") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age1_livdadonly_trend.png, replace

graph twoway (connected mean_livparents year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livparents year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 0-4") xtitle("Year") ytitle("Percentage live with parents") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age1_livparents_trend.png, replace

// Children aged 5-10 //
use ../dta/asec_child_collapsed_age2.dta, clear
gen alaska = statefip == 2
egen mean_livmomonly = mean(livmomonly), by(year alaska)
replace mean_livmomonly = round(mean_livmomonly, 0.001)*100
egen mean_livdadonly = mean(livdadonly), by(year alaska)
replace mean_livdadonly = round(mean_livdadonly, 0.001)*100
egen mean_livparents = mean(livparents), by(year alaska)
replace mean_livparents = round(mean_livparents, 0.001)*100
sort year statefip

drop if statefip > 2
drop statefip-livparents

export excel using ../output/child_age2_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmomonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmomonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 5-10") xtitle("Year") ytitle("Percentage live with single mother") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age2_livmomonly_trend.png, replace

graph twoway (connected mean_livdadonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livdadonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 5-10") xtitle("Year") ytitle("Percentage live with single father") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age2_livdadonly_trend.png, replace

graph twoway (connected mean_livparents year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livparents year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 5-10") xtitle("Year") ytitle("Percentage live with parents") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age2_livparents_trend.png, replace

// Children aged 11-13 //
use ../dta/asec_child_collapsed_age3.dta, clear
gen alaska = statefip == 2
egen mean_livmomonly = mean(livmomonly), by(year alaska)
replace mean_livmomonly = round(mean_livmomonly, 0.001)*100
egen mean_livdadonly = mean(livdadonly), by(year alaska)
replace mean_livdadonly = round(mean_livdadonly, 0.001)*100
egen mean_livparents = mean(livparents), by(year alaska)
replace mean_livparents = round(mean_livparents, 0.001)*100
sort year statefip

drop if statefip > 2
drop statefip-livparents

export excel using ../output/child_age3_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmomonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmomonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 11-13") xtitle("Year") ytitle("Percentage live with single mother") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age3_livmomonly_trend.png, replace

graph twoway (connected mean_livdadonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livdadonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 11-13") xtitle("Year") ytitle("Percentage live with single father") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age3_livdadonly_trend.png, replace

graph twoway (connected mean_livparents year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livparents year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 11-13") xtitle("Year") ytitle("Percentage live with parents") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age3_livparents_trend.png, replace

// Children aged 14-18 //
use ../dta/asec_child_collapsed_age4.dta, clear
gen alaska = statefip == 2
egen mean_livmomonly = mean(livmomonly), by(year alaska)
replace mean_livmomonly = round(mean_livmomonly, 0.001)*100
egen mean_livdadonly = mean(livdadonly), by(year alaska)
replace mean_livdadonly = round(mean_livdadonly, 0.001)*100
egen mean_livparents = mean(livparents), by(year alaska)
replace mean_livparents = round(mean_livparents, 0.001)*100
sort year statefip

drop if statefip > 2
drop statefip-livparents

export excel using ../output/child_age4_summary.xls, firstrow(variables) replace

graph twoway (connected mean_livmomonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livmomonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 14-18") xtitle("Year") ytitle("Percentage live with single mother") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age4_livmomonly_trend.png, replace

graph twoway (connected mean_livdadonly year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livdadonly year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 14-18") xtitle("Year") ytitle("Percentage live with single father") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age4_livdadonly_trend.png, replace

graph twoway (connected mean_livparents year if alaska == 0, msymbol(T) mcolor(blue)) (connected mean_livparents year if alaska == 1, msymbol(O) mcolor(orange) xline(1982) title("Children aged 14-18") xtitle("Year") ytitle("Percentage live with parents") legend(order(1 "Rest of US" 2 "Alaska")))
graph export ../figures/age4_livparents_trend.png, replace

log close
