// program:		03_extract_daf802_20160824.do
// task:		Create files with id merge variable using DAF802 TXRRC file (Permit Master and Trailer Plus Latitudes and Longitudes)
// version: 	Second Draft
// project:		EOCPC 
// author:		Kate Willyard 8/24/2016
//
// set settings and working directory
cd "C:/TRRC"
capture log close master
log using 03_extract_daf802_20160824, name(master) replace text
clear all
version 13
set more off
cd "C:/TRRC"
cd Original
//
// Make File For Record Key 01 DAROOT: 	DA ROOT SEGMENT
infile using daf802daroot if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
gen long id =_n
sort id
cd ..
cd Posted
save 03-daf802daroot_20160824, replace
export delimited 03-daf802daroot_20160824
clear
cd ..
//
// Make File For Record Key 02 DAPERMIT: DA PERMIT MASTER SEGMENT
cd Original
infile using daf802dapermit if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="02"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dapermit_20160824, replace
export delimited 03-daf802dapermit_20160824
clear
cd ..
//
// Make File For Record Key 03 DAFIELD: DA FIELD SEGMENT
cd Original
infile using daf802dafield if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="03"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dafield_20160824, replace
export delimited 03-daf802dafield_20160824
clear
cd ..
//
// Make File For Record Key 04 DAFLDSPC: DA FIELD SPECIFIC DATA SEGMENT
cd Original
infile using daf802dafldspc if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="04"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dafldspc_20160824, replace
export delimited 03-daf802dafldspc_20160824
clear
cd ..
//
// Make File For Record Key 05 DAFLDBHL: DA FIELD BOTTOM-HOLE LOCATION
cd Original
infile using daf802dafldbhl if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="05"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dafldbhl_20160824, replace
export delimited 03-daf802dafldbhl_20160824
clear
cd ..
//
// Make File For Record Key 06 DACANRES: DA CANNED RESTRICTIONS
cd Original
infile using daf802dacanres if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="06"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dacanres_20160824, replace
export delimited 03-daf802dacanres_20160824
clear
cd ..
//
// Make File For Record Key 07 DACANFLD: DA CANNED RESTRICTION FIELDS
cd Original
infile using daf802dacanfld if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="07"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dacanfld_20160824, replace
export delimited 03-daf802dacanfld_20160824
clear
cd ..
//
// Make File For Record Key 08 DAFRERES: DA FREE-FORM RESTRICTIONS
cd Original
infile using daf802dafreres if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="08"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dafreres_20160824, replace
export delimited 03-daf802dafreres_20160824
clear
cd ..
//
// Make File For Record Key 09 DAFREFLD: DA FREE-FORM RESTRICTION FIELD
cd Original
infile using daf802dafrefld if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="09"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dafrefld_20160824, replace
export delimited 03-daf802dafrefld_20160824
clear
cd ..
//
// Make File For Record Key 10 DAPMTBHL: DA BOTTOM-HOLE LOCATION SEGMENT
cd Original
infile using daf802dapmtbhl if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="10"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dapmtbhl_20160824, replace
export delimited 03-daf802dapmtbhl_20160824
clear
cd ..
//
// Make File For Record Key 11 DAALTADD: DA ALTERNATIVE ADDRESS SEGMENT
cd Original
infile using daf802daaltadd if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="11"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802daaltadd_20160824, replace
export delimited 03-daf802daaltadd_20160824
clear
cd ..
//
// Make File For Record Key 12 DAREMARK: DA PERMIT REMARKS
cd Original
infile using daf802daremark if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="12"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802daremark_20160824, replace
export delimited 03-daf802daremark_20160824
clear
cd ..
//
// Make File For Record Key 13 DACHECK: DA CHECK REGISTER SEGMENT
cd Original
infile using daf802dacheck if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="13"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802dacheck_20160824, replace
export delimited 03-daf802dacheck_20160824
clear
cd ..
//
// Make File For Record Key 14 DAW999A1: GIS SURFACE LOCATION COORDINATES
cd Original
infile using daf802daw999a1 if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="14"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802daw999a1_20160824, replace
export delimited 03-daf802daw999a1_20160824
clear
cd ..
//
// Make File For Record Key 15 DAW999B1: GIS BOTTOM HOLE LOCATION COORDINATES
cd Original
infile using daf802daw999a1 if RRC_TAPE_RECORD_ID=="01" | RRC_TAPE_RECORD_ID=="15"
gen long id  = 1 if RRC_TAPE_RECORD_ID=="01"
replace id = sum(id)
drop if RRC_TAPE_RECORD_ID=="01"
drop RRC_TAPE_RECORD_ID
sort id 
cd ..
cd Posted
save 03-daf802daw999b1_20160824, replace
export delimited 03-daf802daw999b1_20160824
clear