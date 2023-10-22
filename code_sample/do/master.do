********************************************************************************
*               Universal Basic Income and Living Arrangements:                *
*              Evidence from the Alaska Permanent Fund Dividend                *
*                              By: Liew Jia Wen                                *
********************************************************************************

/* Before executing, make sure to install the following commands:
ssc install outreg2, replace
ssc install synth, replace
ssc install touch, replace
*/

clear all
set more off, permanent

* Switch conditions *
local SETUP           1 // datasetup
local PFDhistorical   1 // historical payout figure
local SYNTHalaska     1 // synthetic figures for treated alaska only
local WEIGHTS         1 // synth weights for alaska
local DIDestimates    1 // DID estimates for alaska
local SUMMARY         1 // summary table
local BALANCE         1 // balance table
local PLACEBOSfull    1 // SC placebos for full panel
local PLACEBOSnarrow  1 // SC placebos for narrow panel

if `SETUP' == 1 {
	do "datasetup.do"
}

if `PFDhistorical' == 1 {
	do "pfd_historical_payout.do"
}

if `SYNTHalaska' == 1 {
	do "synth_figures.do"
}

if `WEIGHTS' == 1 {
	do "child_weights.do"
	do "adult_weights.do"
}

if `DIDestimates' == 1 {
	do "did.do"
}

if `SUMMARY' == 1 {
	do "summary_table.do"
}

if `BALANCE' == 1 {
	do "balance_table.do"
}

if `PLACEBOSfull' == 1 {
	do "synth_placebos_full.do"
}

if `PLACEBOSnarrow' == 1 {
	do "synth_placebos_narrow.do"
}

