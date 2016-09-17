// program:		09-prelim_sumStatistics_20160829.do
// task:		Create summary statistics for prelim defense
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 8/29/2016
//
// set settings and working directory
cd "C:/TRRC"
capture log close master
log using 09-prelim_sumStatistics_20160829, name(master) replace text
clear all
version 13
set more off
cd "C:/TRRC"
cd Posted
//
// find number of unique gas wells reporting disposition in 2012
use 07-disposition_20160824
keep if oil_gas_code == "G"
keep district_no lease_no field_no
duplicates drop
count
clear all
//
// find number of unique operators reporting disposition in 2012
use 07-disposition_20160824
keep if oil_gas_code == "G"
keep operator_name
duplicates drop
count
clear all
//
// find summary statistics on the number of wells within operating companines in 2012
use 07-disposition_20160824
keep if oil_gas_code == "G"
keep district_no lease_no field_no operator_name
duplicates drop
gen well_id = string(district_no) + string(field_no) + string(lease_no)
keep well_id operator_name
sort operator_name well_id
by operator_name: gen opWells = _N
keep operator_name opWells
duplicates drop
summarize opWells
count if opWells <= 5
count if opWells > 5
