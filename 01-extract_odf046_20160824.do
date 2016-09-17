// program:		01_extract_odf046_20160824.do
// task:		Create files with id merge variable using ODF046 TXRRC file (Oil and Gas Docket)
// version: 	Second Draft
// project:		EOCPC 
// author:		Kate Willyard 8/24/2016
//
// set settings and working directory
cd "C:/TRRC"
capture log close master
log using 01_extract_odf046_20160824, name(master) replace text
clear all
version 13
set more off
cd "C:/TRRC"
cd Original
//
// Make File For Record Key 01 MASTER: TIMES, EVENTS, AND ACTIONS
infile using odf046master if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
gen long id =_n
sort id
cd ..
cd Posted
save 01-odf046master_20160824, replace
export delimited 01-odf046master_20160824
clear
cd ..
//
// Make File For Record Key 02 NAME: APPLICANT/OPERATOR NAME
cd Original
infile using odf046name if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="02"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046name_20160824, replace
export delimited 01-odf046name_20160824
clear
cd ..
//
// Make File For Record Key 03 ODOFICER: OFFICERS OF THE APPLICANT/OPERATOR
cd Original
infile using odf046odoficer if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="03"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odoficer_20160824, replace
export delimited 01-odf046odoficer_20160824
clear
cd ..
//
// Make File For Record Key 04 FIELD: FIELD NAME AND NUMBER
cd Original
infile using odf046field if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="04"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046field_20160824, replace
export delimited 01-odf046field_20160824
clear
cd ..
//
// Make File For Record Key 05 ODLEASE: LEASE LEVEL TIMES, EVENTS, AND ACTIONS
cd Original
infile using odf046odlease if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="05"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odlease_20160824, replace
export delimited 01-odf046odlease_20160824
clear
cd ..
//
// Make File For Record Key 06 ODLSVL: VIOLATION ON THE LEASE
cd Original
infile using odf046odlsvl if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="06"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odlsvl_20160824, replace
export delimited 01-odf046odlsvl_20160824
clear
cd ..
//
// Make File For Record Key 07 ODLSEPY: PAYMENT INFORMATION FOR A LEASE VIOLATION
cd Original
infile using odf046odlsepy if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="07"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odlsepy_20160824, replace
export delimited 01-odf046odlsepy_20160824
clear
cd ..
//
// Make File For Record Key 08 ODLSERM: LEASE LEVEL ADMINISTRATIVE INFORMATION
cd Original
infile using odf046odlserm if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="08"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odlserm_20160824, replace
export delimited 01-odf046odlserm_20160824
clear
cd ..
//
// Make File For Record Key 09 ODWELL: WELL LEVEL TIMES, EVENTS, AND ACTIONS
cd Original
infile using odf046odwell if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="09"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odwell_20160824, replace
export delimited 01-odf046odwell_20160824
clear
cd ..
//
// Make File For Record Key 10 ODWELVLV: VIOLATION ON THE WELL
cd Original
infile using odf046odwelvlv if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="10"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odwelvlv_20160824, replace
export delimited 01-odf046odwelvlv_20160824
clear
cd ..
//
// Make File For Record Key 11 ODWELPY: PAYMENT INFORMATION FOR A WELL VIOLATION
cd Original
infile using odf046odwelpy if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="11"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odwelpy_20160824, replace
export delimited 01-odf046odwelpy_20160824
clear
cd ..
//
// Make File For Record Key 12 ODWELRM: WELL LEVEL ADMINISTRATIVE INFORMATION
cd Original
infile using odf046odwelrm if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="12"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odwelrm_20160824, replace
export delimited 01-odf046odwelrm_20160824
clear
cd ..
//
// Make File For Record Key 13 ODWELABS: COUNTY THAT ABSTRACTS ON THE WELL WERE FILED IN
cd Original
infile using odf046odwelabs if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="13"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odwelabs_20160824, replace
export delimited 01-odf046odwelabs_20160824
clear
cd ..
//
// Make File For Record Key 14 ODWLSFFO: WELL LEVEL, STATE FUND AND FINAL ORDER INFORMATION
cd Original
infile using odf046odwlsffo if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="14"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odwlsffo_20160824, replace
export delimited 01-odf046odwlsffo_20160824
clear
cd ..
//
// Make File For Record Key 15 ODLSEABS: COUNTY THAT ABSTRACTS ON THE LEASE WERE FILED IN
cd Original
infile using odf046odlseabs if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="15"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odlseabs_20160824, replace
export delimited 01-odf046odlseabs_20160824
clear
cd ..
//
// Make File For Record Key 16 ODLSSFO: LEASE LEVEL, STATE FUND AND FINAL ORDER INFORMATION
cd Original
infile using odf046odlssfo if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="16"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odlssfo_20160824, replace
export delimited 01-odf046odlssfo_20160824
clear
cd ..
//
// Make File For Record Key 17 SUBJECT: DESCRIPTION OF THE DOCKET
cd Original
infile using odf046subject if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="17"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046subject_20160824, replace
export delimited 01-odf046subject_20160824
clear
cd ..
//
// Make File For Record Key 18 REMARKS: ADMINISTRATIVE INFORMATION
cd Original
infile using odf046remarks if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="18"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046remarks_20160824, replace
export delimited 01-odf046remarks_20160824
clear
cd ..
//
// Make File For Record Key 19 ODPERMT: PERMIT (OTHER) LEVEL TIMES, EVENTS, AND ACTIONS
cd Original
infile using odf046odpermt if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="19"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odpermt_20160824, replace
export delimited 01-odf046odpermt_20160824
clear
cd ..
//
// Make File For Record Key 20 ODPMTVL: VIOLATION ON THE PERMIT (OTHER)
cd Original
infile using odf046odpmtvl if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="20"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odpmtvl_20160824, replace
export delimited 01-odf046odpmtvl_20160824
clear
cd ..
//
// Make File For Record Key 21 ODPMTPY: PAYMENT INFORMATION FOR A PERMIT (OTHER) VIOLATION
cd Original
infile using odf046odpmtpy if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="21"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odpmtpy_20160824, replace
export delimited 01-odf046odpmtpy_20160824
clear
cd ..
//
// Make File For Record Key 22 ODPMTRM: PERMIT (OTHER) LEVEL ADMINISTRATIVE INFORMATION
cd Original
infile using odf046odpmtrm if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="22"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odpmtrm_20160824, replace
export delimited 01-odf046odpmtrm_20160824
clear
cd ..
//
// Make File For Record Key 23 ODPMTABS: COUNTY THAT ABSTRACTS ON THE PERMIT (OTHER) WERE FILED
cd Original
infile using odf046odpmtabs if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="23"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odpmtabs_20160824, replace
export delimited 01-odf046odpmtabs_20160824
clear
cd ..
//
// Make File For Record Key 24 ODPMSFFO: PERMIT (OTHER) LEVEL, STATE FUND AND FINAL ORDER INFORMATION
cd Original
infile using odf046odpmsffo if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="24"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046odpmsffo_20160824, replace
export delimited 01-odf046odpmsffo_20160824
clear
cd ..
//
// Make File For Record Key 25 ENFORMNT: PLUGGING ENFORCEMENT INFORMATION
cd Original
infile using odf046enformnt if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="25"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 01-odf046enformnt_20160824, replace
export delimited 01-odf046enformnt_20160824
clear
cd ..
//