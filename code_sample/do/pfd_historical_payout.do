clear all
set more off
log using ../log/pfd_payout_plot.log, replace

import excel ../raw/RealAlaskaPFDPayout.xlsx, sheet("Sheet1") firstrow

sort year

twoway line nominal_payout year, lcolor(orange) || line real_payout_2019 year, lp(dash) lcolor(blue) ||, legend(label(1 "Nominal payout in USD") label(2 "Real payout in 2019 USD") cols(1)) xtitle(Year) ytitle(Dividend Amount) graphregion(color(white)) name(new_fig, replace) ylabel(0 "$0" 1000 "$1,000" 2000 "$2,000" 3000 "$3,000" 4000 "$4,000") xlabel(1980 1985 1990 1995 2000 2005 2010 2015)

graph export ../figures/real_payout.png, replace

log close
