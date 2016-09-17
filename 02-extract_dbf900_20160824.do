// program:		02_extract_dbf900_20160824.do
// task:		Create files with id merge variable using DBF900 TXRRC file (Oil and Gas Well Bore System)
// version: 	Second Draft
// project:		EOCPC 
// author:		Kate Willyard 8/24/2016
//
// set settings and working directory
cd "C:/TRRC"
capture log close master
log using 02_extract_dbf900_20160824, name(master) replace text
clear all
version 13
set more off
cd "C:/TRRC"
cd Original
//
// Make File For Record Key 01 WBROOT: 	WELL BORE TECHNICAL DATA ROOT SEGMENT
infile using dbf900wbroot if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
gen long id =_n
sort id
cd ..
cd Posted
save 02-dbf900wbroot_20160824, replace
export delimited 02-dbf900wbroot_20160824
clear
cd ..
//
// Make File For Record Key 02 WBCOMP: WELL BORE COMPLETION INFORMATION SEGMENT
cd Original
infile using dbf900wbcomp if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="02"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbcomp_20160824, replace
export delimited 02-dbf900wbcomp_20160824
clear
cd ..
//
// Make File For Record Key 03 WBDATE: WELL BORE TECHNICAL DATA FORMS FILE DATA
cd Original
infile using dbf900wbdate if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="03"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbdate_20160824, replace
export delimited 02-dbf900wbdate_20160824
clear
cd ..
//
// Make File For Record Key 04 WBRMKS: WELL BORE REMARKS SEGMENT
cd Original
infile using dbf900wbrmks if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="04"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbrmks_20160824, replace
export delimited 02-dbf900wbrmks_20160824
clear
cd ..
//
// Make File For Record Key 05 WBTUBE: WELL BORE TUGING SEGMENT
cd Original
infile using dbf900wbtube if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="05"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbtube_20160824, replace
export delimited 02-dbf900wbtube_20160824
clear
cd ..
//
// Make File For Record Key 06 WBCASE: WELL BORE CASING SEGMENT
cd Original
infile using dbf900wbcase if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="06"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbcase_20160824, replace
export delimited 02-dbf900wbcase_20160824
clear
cd ..
//
// Make File For Record Key 07 WBPERF: WELL BORE PERF SEGMENT
cd Original
infile using dbf900wbperf if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="07"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbperf_20160824, replace
export delimited 02-dbf900wbperf_20160824
clear
cd ..
//
// Make File For Record Key 08 WBLINE: WELL BORE LINER SEGMENT
cd Original
infile using dbf900wbline if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="08"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbline_20160824, replace
export delimited 02-dbf900wbline_20160824
clear
cd ..
//
// Make File For Record Key 09 WBFORM: WELL BORE FORMATION DATA SEGMENT
cd Original
infile using dbf900wbform if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="09"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbform_20160824, replace
export delimited 02-dbf900wbform_20160824
clear
cd ..
//
// Make File For Record Key 10 WBSQEZE: WELL BORE SQUEEZE SEGMENT
cd Original
infile using dbf900wbsqeze if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="10"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbsqeze_20160824, replace
export delimited 02-dbf900wbsqeze_20160824
clear
cd ..
//
// Make File For Record Key 11 WBFRESH: WELL BORE USABLE QUALITY WATER PROTECTION
cd Original
infile using dbf900wbfresh if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="11"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbfresh_20160824, replace
export delimited 02-dbf900wbfresh_20160824
clear
cd ..
//
// Make File For Record Key 12 WBOLDLOC: WELL BORE OLD LOCATION SEGMENT
cd Original
infile using dbf900wboldloc if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="12"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wboldloc_20160824, replace
export delimited 02-dbf900wboldloc_20160824
clear
cd ..
//
// Make File For Record Key 13 WBNEWLOC: WELL BORE NEW LOCATION SEGMENT
cd Original
infile using dbf900wbnewloc if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="13"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbnewloc_20160824, replace
export delimited 02-dbf900wbnewloc_20160824
clear
cd ..
//
// Make File For Record Key 14 WBPLUG: WELL BORE PLUGGING DATA SEGMENT
cd Original
infile using dbf900wbplug if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="14"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbplug_20160824, replace
export delimited 02-dbf900wbplug_20160824
clear
cd ..
//
// Make File For Record Key 15 WBPLRMKS: WELL BORE PLUGGING REMARKS SEGMENT
cd Original
infile using dbf900wbplrmks if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="15"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbplrmks_20160824, replace
export delimited 02-dbf900wbplrmks_20160824
clear
cd ..
//
// Make File For Record Key 16 WBPLREC: WELL BORE RECORD SEGMENT
cd Original
infile using dbf900wbplrec if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="16"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbplrec_20160824, replace
export delimited 02-dbf900wbplrec_20160824
clear
cd ..
//
// Make File For Record Key 17 WBPLCASE: WELL BORE PLUGGING DATA CASING-TUBING RECORD
cd Original
infile using dbf900wbplcase if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="17"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbplcase_20160824, replace
export delimited 02-dbf900wbplcase_20160824
clear
cd ..
//
// Make File For Record Key 18 WBPLPERF: WELL BORE PLUGGING PERFS SEGMENT
cd Original
infile using dbf900wbplperf if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="18"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbplperf_20160824, replace
export delimited 02-dbf900wbplperf_20160824
clear
cd ..
//
// Make File For Record Key 19 WBPLNAME: WELL BORE PLUGGING DATA NOMENCLATURE SEGMENT
cd Original
infile using dbf900wbplname if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="19"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbplname_20160824, replace
export delimited 02-dbf900wbplname_20160824
clear
cd ..
//
// Make File For Record Key 20 WBDRILL: WELL BORE DRILLING PERMIT NUMBER
cd Original
infile using dbf900wbdrill if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="20"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbdrill_20160824, replace
export delimited 02-dbf900wbdrill_20160824
clear
cd ..
//
// Make File For Record Key 21 WBWELLID: WELL BORE WELL-ID SEGMENT
cd Original
infile using dbf900wbwellid if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="21"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbwellid_20160824, replace
export delimited 02-dbf900wbwellid_20160824
clear
cd ..
//
// Make File For Record Key 22 WB14B2: 14B2 WELL SEGMENT
cd Original
infile using dbf900wb14b2 if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="22"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wb14b2_20160824, replace
export delimited 02-dbf900wb14b2_20160824
clear
cd ..
//
// Make File For Record Key 23 WBH15: H-15 REPORT SEGMENT
cd Original
infile using dbf900wbh15 if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="23"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbh15_20160824, replace
export delimited 02-dbf900wbh15_20160824
clear
cd ..
//
// Make File For Record Key 24 WBH15RMK: H-15 REMARK SEGMENT
cd Original
infile using dbf900wbh15rmk if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="24"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbh15rmk_20160824, replace
export delimited 02-dbf900wbh15rmk_20160824
clear
cd ..
//
// Make File For Record Key 25 WBSB126: SENATE BILL 126 (2-YR INACTIVE PROGRAM) SEGMENT
cd Original
infile using dbf900wbsb126 if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="25"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbsb126_20160824, replace
export delimited 02-dbf900wbsb126_20160824
clear
cd ..
//
// Make File For Record Key 26 WBDASTAT: WELL BORE - DRILLING PERMIT STATUS SEGMENT
cd Original
infile using dbf900wbdastat if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="26"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbdastat_20160824, replace
export delimited 02-dbf900wbdastat_20160824
clear
cd ..
//
// Make File For Record Key 27 WBW3C: WELL BORE FORM W3C SEGMENT
cd Original
infile using dbf900wbw3c if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="27"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wbw3c_20160824, replace
export delimited 02-dbf900wbw3c_20160824
clear
cd ..
//
// Make File For Record Key 28 WB14B2RM: WELL BORE 14B2 REMARKS
cd Original
infile using dbf900wb14b2rm if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="28"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 02-dbf900wb14b2rm_20160824, replace
export delimited 02-dbf900wb14b2rm_20160824
clear
cd ..