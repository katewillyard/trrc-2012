cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 16-mergeWprLocInfo_20161220, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
// program:		16-mergeWprLocInfo_20161220.do
// task:		clean daf802daroot data
//				merge gas pd, orgInfo, wellbore, and location info 
//					with programmed request data
//				save oil location data as csv
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 12/20/2016
//
/********-*********-*********-*********-*********-*********-*********/
/* Set Settings and Working Directory								*/
/********-*********-*********-*********-*********-*********-*********/
clear all
version 13
set more off
cd "C:/Users/TXCRDC/Documents/Research/eocpc"
//
//
/********-*********-*********-*********-*********-*********-*********/
/* clean programmed request location (Well_GIS_4.11) data			*/
/********-*********-*********-*********-*********-*********-*********/
cd Original 
// Prior to entering the data, I deleted " & ' in the text file I 
// received in order to manage input issues
import delimited Well_GIS_4.11.txt, delimiter("|")
cd ..
cd Working
label data "TRRC 2016 Programmed Well & Operators Extracted Dataset"
note: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable api_no "api number"
note api_no: "This data item  contains the API Number-- A unique number assigned by the RRC to identify well bores. The API well numbering system was first developed by and administered through the American Petroleum Institute (API), an oil trade organziaiton which sets standards for the petroleum industry. An API number is an eight-digit number made up of a three-digit county code, and a five-digit unique number. There isno duplication of API numbers"
note api_no: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable district_code "district code"
label define district_code 01 "District 01" 02 "District 02" 03 "District 03" 04 "District 04" 05 "District 05" 06 "District 06" 07 "District 6E (oil only)" 08 "District 7B" 09 "District 7C" 10 "District 08" 11 "District 8A" 12 "District 8B" 13 "District 09" 14 "District 10" 
note district_code: "This two-digit number designates the RRC district in which the drilling operation is to take place; this is the district as it was approved by the RRC and may differ from what the operator submitted on the application. It is stored as an RRC automatic processing internal code"
note district_code: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable well_no_display "well number"
note well_no_display: "This data item contains a six-character well number (including spaces). This is the well number as it has been approved by the RRC. The well number is assigned by the operator and is generally not changed, even when the well is worked over significnatly"
note well_no_display: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable well_type_name "well type (as of April 2016)"
note well_type_name: "Current type of well (April 11, 2016). Type of well may be: 1. ABANDONED 2. BRINE MINING 3. DOMESTIC USE WELL 4. GAS STRG-INJECTION 5. GAS STRG-SALT FORMATION 6. GAS STRG-WITHDRAWAL 7. GEOTHERMAL WELL 8. INJECTION 9. LPG STORAGE 10.NO PRODUCTION 11. NOT ELIGIBLE FOR ALLOWABLE 12. OBSERVATION 13. OTHER TYPE SERVICE 14. PARTIAL PLUG 15. PROD FACTOR WELL 16.PRODUCING 17.SEALED 18. SHUT IN 19. SHUT IN – MULTI- COMPLETIONS 20.SWR-10-WELL 21. TEMP ABANDONED 22. TRAINING 23.WATER SUPPLY"
note well_type_name: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable lease_name "lease name"
note lease_name: "Name of the lease as filed by the operator. The Lease Name is idnicated by the RRC proration schedule. It describes specific total lease/pooled unit/unitized acreage established for RRC regulatory purposes such as obtaining drilling permits and filing completion reports. All contiguous lease/pooled unit/unitized acreage must be identified with the exact same lease name. Lease names may contain up to 32 characters. Preferred formatting is for last names to be listed first, for example: Smith, John rather than John Smith"
note lease_name: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable lease_number "lease number"
note lease_number: "Numberic designation for the elase assigned by the RRC. For an oil well, this will be the lease number. For a gas well, this will be the gas well identification number. "
note lease_number: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable oil_gas_code "oil gas code"
note oil_gas_code: "Code that denotes Oil or Gas (O= Oil and G= Gas)"
note oil_gas_code: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable operator_name "operator name"
note operator_name: "Organization name as filed on RRC Organization Report Form P-5"
note operator_name: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable operator_number "operator number"
note operator_number: "Organization/Operator ID Number as assigned by the Railroad Commission of Texas (RRC)"
note operator_number: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable completion_date "completion date"
note completion_date: "Most recent date completion forms were completed for an oil or gas well. Forms include either a W-2 or G-1 form."
note completion_date: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable mailing_address1 "operator (as of April 11, 2016) address 1"
note mailing_address1: "This is the first line of the organization's master mailing address"
note mailing_address1: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable mailing_address2 "operator (as of April 11, 2016) address 2"
note mailing_address2: "This is the second line of the organizaion's master mailing address"
note mailing_address2: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable mailing_city "operator (as of April 11, 2016) city"
note mailing_city: "This is the city of the organization's master mailing address"
note mailing_city: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable mailing_state "operator (as of April 11, 2016) state"
note mailing_state: "This is the state of the organization's master mailing address"
note mailing_state: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable mailing_zip "operator (as of April 11, 2016) zip code"
note mailing_zip: "This is the zip code for the organizaion's master mailing address."
note mailing_zip: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable organization_type "organizational type of operator as of April 11, 2016"
note organization_type: "Current plan of organizaion code. The name of the code  can be found in the organizationtypedetail variable or as follows: A- Corporation, B- Limited Partnership, C- Sole Proprietorship, D- Partnership, E- Trust, F- Joint Venture, G- Other"
note organization_type: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable organizationtypedetail "operator (as of April 11, 2016) organizational type"
note organizationtypedetail: "Current plan of organizaion. It can be one of the following: Corporation, Limited Partnership, Sole Proprietorship, Partnership, Trust, Joint Venture, or Other"
note organizationtypedetail: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable initialp5filingdate "operator (as of April 11, 2016) initial filing date"
note initialp5filingdate: "Date that the last refiled form P-5 was received and processed by the RRC. This includes not just annual refilings, but all filings(MMDDYY where MM is mont, DD is day, YY is year)"
note initialp5filingdate: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable latitudedatum83 "latitude datum NAD 83"
note latitudedatum83: "Well Latitude referenced to datum NAD 83"
note latitudedatum83: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label variable longitudedatum83 "longitude datum NAD 83"
note longitudedatum83: "Well Longitude referenced to datum NAD 83"
note longitudedatum83: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
drop v21
save 16-wellGIS411_20161220
cd ..
cd Posted
save 16-wellGIS411_20161220
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* merge programmed request location (Well_GIS_4.11) data with gas 	*/
/*    pd, orgInfo, wellbore, and location info						*/
/********-*********-*********-*********-*********-*********-*********/
cd Working
keep api_no district_code well_no_display well_type_name lease_name ///
	lease_number oil_gas_code completion_date latitudedatum83 ///
	longitudedatum83
gen prApiNo = subinstr(api_no, "'","",.)
label variable prApiNo "API number"
notes prApiNo: "API number according to Well_GIS_4.11"
notes prApiNo: "Created in 16-mergeWprLocInfo_20161220.do"
notes prApiNo: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
// keep updated gas well api data
keep if oil_gas_code == "'G'"
bysort api_no (completion_date): keep if _n==_N
save gisWellWID
clear
cd ..
cd Posted
use 15-daf802dapermit-clean_20161211
keep api_no id wellDepth spudDate horizontalWell
merge 1:1 id using 15-daf802daw999a1-clean_20161211
cd ..
cd Working
// only keep permits with location data
drop if _merge == 1
drop _merge id
duplicates drop
// use revised well depth
bysort api_no (wellDepth): keep if _n==_N
gen prApiNo = api_no
merge 1:1 prApiNo using gisWellWID
gen permitPRmatch = .
replace permitPRmatch = 1 if _merge == 3
replace permitPRmatch = 0 if _merge == 2
drop if _merge == 1
label variable permitPRmatch "daf802 and programized request well gis 4.11 match using api no"
notes permitPRmatch: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes : "Created from 15-802dapermit-clean_20161211, 15-daf802daw999a1-clean_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
drop _merge
replace district_code = subinstr(district_code, "'","",.)
replace well_no_display = subinstr(well_no_display, "'","",.)
replace well_type_name = subinstr(well_type_name, "'","",.)
replace lease_name = subinstr(lease_name, "'","",.)
replace lease_number = subinstr(lease_number, "'","",.)
replace oil_gas_code = subinstr(oil_gas_code, "'","",.)
gen uid = district_code + "-" + lease_number
label variable uid "uid: district code - lease number"
notes uid: "UID created as: district_code + "-" + lease_number"
notes uid: "Created in 16-mergeWprLocInfo_20161220.do"
notes uid: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
tostring completion_date, replace
gen completionYear = substr(completion_date,1,4)
destring completionYear, replace
label variable completionYear "year well was completed"
notes completionYear: "Year well was completed calculated by extracting the first four characters of completion_date"
notes completionYear: "Created in 16-mergeWprLocInfo_20161220.do"
notes completionYear: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
drop if completionYear > 2012
save wellLocInfo
keep if oil_gas_code == "G"
sort uid
quietly by uid: gen dup = cond(_N==1,0,_n)
save gasDupID
keep if dup > 0
drop dup
save 16-gasDupGisInfo_20161220
cd ..
cd Posted
save 16-gasDupGisInfo_20161220
cd ..
cd Working
clear
use gasDupID
keep if dup == 0
drop dup
save gasLocInfo
cd ..
cd Posted 
use 15-gasPDorgVioWLoc_20161211
cd ..
cd Working
gen uid = district_name + "-" + string(lease_no, "%06.0f")
label variable uid "uid: district code - lease number"
notes uid: "UID created as: district_code + "-" + lease_number"
notes uid: "Created in 16-mergeWprLocInfo_20161220.do"
notes uid: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
gen pdovlUID = _n
gen prApiNo = api_no
save gasPDOVL
merge m:1 uid using gasLocInfo
gen prLocMatch = .
replace prLocMatch = 1 if _merge == 3
replace prLocMatch = 0 if _merge == 1
drop if _merge == 2
label variable prLocMatch "matched to programized request GIS data using uid"
notes prLocMatch: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes prLocMatch: "Created from 15-gasPDorgVioWLoc_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
drop _merge
// many because there can be two different operators throughout the year on a single well
merge m:1 prApiNo using gasLocInfo
gen prAPImatch = .
replace prAPImatch = 1 if _merge == 3
replace prAPImatch = 0 if _merge == 1
drop if _merge == 2
drop _merge 
label variable prAPImatch "matched to programized request GIS data using api no"
notes prAPImatch: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes prAPImatch: "Created from 15-gasPDorgVioWLoc_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
gen noGIS = .
replace noGIS = 1 if prLocMatch == 0 & noLocMatch == 1 & prAPImatch == 0
replace noGIS = 0 if prLocMatch == 1 | noLocMatch == 0 | prAPImatch == 1
label variable noGIS "production data not able to be linked with well GIS data"
notes noGIS: "Production data is not able to be linked with well GIS data"
notes noGIS: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes noGIS: "Created from 15-gasPDorgVioWLoc_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
tab noGIS
drop dup pdovlUID
save 16-gasPDorgVioLocGIS_20161220
cd ..
cd Posted
save 16-gasPDorgVioLocGIS_20161220
keep if noGIS == 1
save 16-noGasGis_20161220
export delimited 16-noGasGis_20161220
cd ..
cd Working 
save 16-noGasGis_20161220
export delimited 16-noGasGis_20161220
// find number of producing gas wells with no gis data
use 16-gasPDorgVioLocGIS_20161220
drop if lease_gas_prod_vol == 0
tab noGIS
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* merge programmed request location (Well_GIS_4.11) data with oil 	*/
/*    pd, orgInfo, wellbore, and location info						*/
/********-*********-*********-*********-*********-*********-*********/
cd Working
clear
use 16-wellGIS411_20161220
keep api_no district_code well_no_display well_type_name lease_name ///
	lease_number oil_gas_code completion_date latitudedatum83 ///
	longitudedatum83
gen prApiNo = subinstr(api_no, "'","",.)
label variable prApiNo "API number"
notes prApiNo: "API number according to Well_GIS_4.11"
notes prApiNo: "Created in 16-mergeWprLocInfo_20161220.do"
notes prApiNo: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
// keep updated gas well api data
keep if oil_gas_code == "'O'"
bysort api_no (completion_date): keep if _n==_N
save gisOilWellWID
clear
cd ..
cd Posted
use 15-daf802dapermit-clean_20161211
keep api_no id wellDepth spudDate horizontalWell
merge 1:1 id using 15-daf802daw999a1-clean_20161211
cd ..
cd Working
// only keep permits with location data
drop if _merge == 1
drop _merge id
duplicates drop
// use revised well depth
bysort api_no (wellDepth): keep if _n==_N
gen prApiNo = api_no
merge 1:1 prApiNo using gisOilWellWID
gen permitPRmatch = .
replace permitPRmatch = 1 if _merge == 3
replace permitPRmatch = 0 if _merge == 2
drop if _merge == 1
label variable permitPRmatch "daf802 and programized request well gis 4.11 match using api no"
notes permitPRmatch: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes : "Created from 15-802dapermit-clean_20161211, 15-daf802daw999a1-clean_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
drop _merge
replace district_code = subinstr(district_code, "'","",.)
replace well_no_display = subinstr(well_no_display, "'","",.)
replace well_type_name = subinstr(well_type_name, "'","",.)
replace lease_name = subinstr(lease_name, "'","",.)
replace lease_number = subinstr(lease_number, "'","",.)
replace oil_gas_code = subinstr(oil_gas_code, "'","",.)
gen uid = district_code + "-" + lease_number
label variable uid "uid: district code - lease number"
notes uid: "UID created as: district_code + "-" + lease_number"
notes uid: "Created in 16-mergeWprLocInfo_20161220.do"
notes uid: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
tostring completion_date, replace
gen completionYear = substr(completion_date,1,4)
destring completionYear, replace
label variable completionYear "year well was completed"
notes completionYear: "Year well was completed calculated by extracting the first four characters of completion_date"
notes completionYear: "Created in 16-mergeWprLocInfo_20161220.do"
notes completionYear: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
drop if completionYear > 2012
save oilWellLocInfo
keep if oil_gas_code == "O"
sort uid
quietly by uid: gen dup = cond(_N==1,0,_n)
save oilDupID
keep if dup > 0
drop dup
save 16-oilDupGisInfo_20161220
cd ..
cd Posted
save 16-oilDupGisInfo_20161220
cd ..
cd Working
clear
use oilDupID
keep if dup == 0
drop dup
save oilLocInfo
cd ..
cd Posted 
use 15-oilPDorgVioWLoc_20161211
cd ..
cd Working
gen uid = district_name + "-" + string(lease_no, "%05.0f")
label variable uid "uid: district code - lease number"
notes uid: "UID created as: district_code + "-" + lease_number"
notes uid: "Created in 16-mergeWprLocInfo_20161220.do"
notes uid: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
gen pdovlUID = _n
gen prApiNo = api_no
save oilPDOVL
merge m:m uid using oilLocInfo
gen prLocMatch = .
replace prLocMatch = 1 if _merge == 3
replace prLocMatch = 0 if _merge == 1
drop if _merge == 2
label variable prLocMatch "matched to programized request GIS data using uid"
notes prLocMatch: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes prLocMatch: "Created from 15-gasPDorgVioWLoc_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
drop _merge
// many because there can be two different operators throughout the year on a single well
merge m:1 prApiNo using oilLocInfo
gen prAPImatch = .
replace prAPImatch = 1 if _merge == 3
replace prAPImatch = 0 if _merge == 1
drop if _merge == 2
drop _merge 
label variable prAPImatch "matched to programized request GIS data using api no"
notes prAPImatch: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes prAPImatch: "Created from 15-gasPDorgVioWLoc_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
gen noGIS = .
replace noGIS = 1 if prLocMatch == 0 & noLocMatch == 1 & prAPImatch == 0
replace noGIS = 0 if prLocMatch == 1 | noLocMatch == 0 | prAPImatch == 1
label variable noGIS "production data not able to be linked with well GIS data"
notes noGIS: "Production data is not able to be linked with well GIS data"
notes noGIS: "Created when production, organization, inspection, and location data was matched to Well_GIS_4.11 using district code and lease number"
notes noGIS: "Created from 15-gasPDorgVioWLoc_20161211 and Well_GIS_4.11 in 16-mergeWprLocInfo_20161220.do"
tab noGIS
drop dup pdovlUID
save 16-oilPDorgVioLocGIS_20161220
cd ..
cd Posted
save 16-oilPDorgVioLocGIS_20161220
keep if noGIS == 1
save 16-noOilGis_20161220
export delimited 16-noOilGis_20161220
cd ..
cd Working 
save 16-noOilGis_20161211
export delimited 16-noOilGis_20161211
// find number of producing gas wells with no gis data
use 16-oilPDorgVioLocGIS_20161220
drop if lease_gas_prod_vol == 0
tab noGIS
cd ..
//