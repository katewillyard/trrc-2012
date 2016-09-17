// program:		04-extract_orf850_20160824.do
// task:		Create files with id merge variable using ORF850 TXRRC file (Report of Organizations)
// version: 	Second Draft
// project:		EOCPC 
// author:		Kate Willyard 8/24/2016
//
// set settings and working directory
cd "C:/TRRC"
capture log close master
log using 04-extract_orf850_20160824, name(master) replace text
clear all
version 13
set more off
cd "C:/TRRC"
cd Original
//
// Make File For Record Key 01 TABLE: SPECIALTY/ACTIVITY CODE TABLE
infile using orf850table if RRC_TAPE_RECORD_ID=="1T"
drop RRC_TAPE_RECORD_ID
gen long id =_n
sort id
cd ..
cd Posted
save 04-orf850table_20160824, replace
export delimited 04-orf850table_20160824
clear
cd ..
//
// Make File For Record Key 02 INFO: ORGANIZATION INFORMATION
cd Original
infile using orf850info if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
gen long id =_n
sort id
cd ..
cd Posted
save 04-orf850info_20160824, replace
export delimited 04-orf850info_20160824
clear
cd ..
//
// Make File For Record Key 03 CODES: SPECIALTY CODES
cd Original
infile using orf850codes if RRC_TAPE_RECORD_ID=="A" | RRC_TAPE_RECORD_ID=="F"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="A"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 04-orf850codes_20160824, replace
export delimited 04-orf850codes_20160824
clear
cd ..
//
// Make File For Record Key 04 DISTRICT: SPECIAL ADDRESS BY DISTRICT
cd Original
infile using orf850district if RRC_TAPE_RECORD_ID=="A" | RRC_TAPE_RECORD_ID=="H"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="A"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 04-orf850district_20160824, replace
export delimited 04-orf850district_20160824
clear
cd ..
//
// Make File For Record Key 05 FIELD: FIELD INFORMATION (FUTURE SET)
cd Original
infile using orf850field if RRC_TAPE_RECORD_ID=="A" | RRC_TAPE_RECORD_ID=="J"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="A"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 04-orf850field_20160824, replace
export delimited 04-orf850field_20160824
clear
cd ..
//
// Make File For Record Key 06 OFFICER: OFFICER INFORMATION
cd Original
infile using orf850officer if RRC_TAPE_RECORD_ID=="A" | RRC_TAPE_RECORD_ID=="K"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="A"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 04-orf850officer_20160824, replace
export delimited 04-orf850officer_20160824
clear
cd ..
//
// Make File For Record Key 07 REMARKS: REMARKS
cd Original
infile using orf850remarks if RRC_TAPE_RECORD_ID=="A" | RRC_TAPE_RECORD_ID=="P"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="A"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 04-orf850remarks_20160824, replace
export delimited 04-orf850remarks_20160824
clear
cd ..
//
// Make File For Record Key 08 INDICATOR: ACTIVITY INDICATOR
cd Original
infile using orf850indicator if RRC_TAPE_RECORD_ID=="A" | RRC_TAPE_RECORD_ID=="U"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="A"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 04-orf850indicator_20160824, replace
export delimited 04-orf850indicator_20160824
clear
cd ..
//
// Make File For Record Key 09 RESTRICTION: ACTIVITY RESTRICTION
cd Original
infile using orf850restriction if RRC_TAPE_RECORD_ID=="A" | RRC_TAPE_RECORD_ID=="R"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="A"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="A"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 04-orf850restriction_20160824, replace
export delimited 04-orf850restriction_20160824
clear
