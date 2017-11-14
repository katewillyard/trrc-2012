cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 18-mergeWvfPermit_20161220, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		18-mergeWvfPermit_20161220.do
// task:		clean fvf609
//				merge oil and gas pd, orgInfo, wellbore, location and
//					programmed request data with 2012 permit extract 
//					data
//				create seperate oil and gas files
//				verify no permit data was lost
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 12/20/2016
//
//
/********-*********-*********-*********-*********-*********-*********/
/* Set Settings and Working Directory								*/
/********-*********-*********-*********-*********-*********-*********/
//
clear all
version 13
set more off
cd "C:/Users/TXCRDC/Documents/Research/eocpc"
//
//
//
/********-*********-*********-*********-*********-*********-*********/
/* clean 2012 permit extract (fvf609) data							*/
/********-*********-*********-*********-*********-*********-*********/
//
cd Original 
import delimited fvf609.txt, delimiter("}")
cd ..
cd Working
label data "TRRC 2012 Venting and Flaring Permit Data"
note: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v1 vfPermitNo
label variable vfPermitNo "venting and flaring permit number"
note vfPermitNo: "Venting and flaring permit number"
note vfPermitNo: "Variable name created in 18-mergeWvfPermit_20161220.do"
note vfPermitNo: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v2 typeCode
label variable typeCode "type code"
note typeCode: "Type code"
note typeCode: "Variable name created in 18-mergeWvfPermit_20161220.do"
note typeCode: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v3 typeId
label variable typeId "type identifier"
note typeId: "Type ID"
note typeId: "Variable name created in 18-mergeWvfPermit_20161220.do"
note typeId: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v4 dst
label variable dst "district"
note dst: "District Number"
note dst: "Variable name created in 18-mergeWvfPermit_20161220.do"
note dst: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v5 oper
label variable oper "operator number"
note oper: "Operator number"
note oper: "Variable name created in 18-mergeWvfPermit_20161220.do"
note oper: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v6 cnty
label variable cnty "county number"
note cnty: "County number"
note cnty: "Variable name created in 18-mergeWvfPermit_20161220.do"
note cnty: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v7 flared
label variable flared "flaring permit"
note flared: "Flaring permit"
note flared: "Variable name created in 18-mergeWvfPermit_20161220.do"
note flared: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v8 vented
label variable vented "venting permit"
note vented: "Venting permit"
note vented: "Variable name created in 18-mergeWvfPermit_20161220.do"
note vented: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v9 gasWell
label variable gasWell "permit to vent or flare gas well gas"
note gasWell: "Gas well gas permit to vent or flare signifier"
note gasWell: "Variable name created in 18-mergeWvfPermit_20161220.do"
note gasWell: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v10 casinghead
label variable casinghead "permit to vent or flare casinghead gas"
note casinghead: "Casinghead gas permit to vented or flared"
note casinghead: "Variable name created in 18-mergeWvfPermit_20161220.do"
note casinghead: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v11 exist
label variable exist "existing permit"
note exist: "Existing venting and flaring permit"
note exist: "Variable name created in 18-mergeWvfPermit_20161220.do"
note exist: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v12 new
label variable new "new permit"
note new: "New venting and flaring permit"
note new:: "Variable name created in 18-mergeWvfPermit_20161220.do"
note new: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v13 amend
label variable amend "amended permit"
note amend: "Amended venting and flaring permit"
note amend: "Variable name created in 18-mergeWvfPermit_20161220.do"
note amend: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v14 concent
label variable concent "venting and flaring permitted"
note concent: "Venting and flaring permitted"
note concent: "Variable name created in 18-mergeWvfPermit_20161220.do"
note concent: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v15 volume
label variable volume "Venting and flaring volume permitted"
note volume: "Venting and vlaring volume permitted"
note volume: "Variable name created in 18-mergeWvfPermit_20161220.do"
note volume: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v16 approvalDt
label variable approvalDt "approval date for venting and flaring gas"
note approvalDt: "Approval date for venting and flaring gas"
note approvalDt: "Variable name created in 18-mergeWvfPermit_20161220.do"
note approvalDt: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v17 appDt
label variable appDt "application date for venting and flaring gas"
note appDt: "Application date for venting and flaring gas"
note appDt: "Variable name created in 18-mergeWvfPermit_20161220.do"
note appDt: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v18 effDt
label variable effDt "effective date for permit to vent and flare gas"
note effDt: "Effective date for permit to vent and flare gas"
note effDt: "Variable name created in 18-mergeWvfPermit_20161220.do"
note effDt: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v19 expDt 
label variable expDt "expiration date for permit to vent and flare gas"
note expDt: "Expiration date for permit to vent and flare gas"
note expDt: "Variable name created in 18-mergeWvfPermit_20161220.do"
note expDt: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v20 amendDt
label variable amendDt "amendment date for permit to vent and flare gas"
note amendDt: "Amendment date for permit to vent and flare gas"
note amendDt: "Variable name created in 18-mergeWvfPermit_20161220.do"
note amendDt: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v21 field
label variable field "field number"
note field: "Field number"
note field: "Variable name created in 18-mergeWvfPermit_20161220.do"
note field: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v22 lseNam
label variable lseNam "lease name"
note lseNam: "Lease name"
note lseNam: "Variable name created in 18-mergeWvfPermit_20161220.do"
note lseNam: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v23 timePeriod
label variable timePeriod "days venting and flaring allowed"
note timePeriod: "Days venting and flaring allowed"
note timePeriod: "Variable name created in 18-mergeWvfPermit_20161220.do"
note timePeriod: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v24 conferenceDt
label variable conferenceDt "conference date for venting and flaring permit"
note conferenceDt: "Conference date for venting and flaring permit"
note conferenceDt: "Variable name created in 18-mergeWvfPermit_20161220.do"
note conferenceDt: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v25 remarks1
label variable remarks1 "venting and flaring permit remarks 1"
note remarks1: "Line 1 of remarks regarding venting and flaring permit"
note remarks1: "Variable name created in 18-mergeWvfPermit_20161220.do"
note remarks1: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v26 remarks2 
label variable remarks2 "venting and flaring permit remarks 2"
note remarks2: "Line 2 of remarks regarding venting and flaring permit"
note remarks2: "Variable name created in 18-mergeWvfPermit_20161220.do"
note remarks2: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v27 remarks3
label variable remarks3 "venting and flaring permit remarks 3"
note remarks3: "Line 3 of remarks regarding venting and flaring permit"
note remarks3: "Variable name created in 18-mergeWvfPermit_20161220.do"
note remarks3: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v28 remarks4
label variable remarks4 "venting and flaring permit remarks 4"
note remarks4: "Line 4 of remarks regarding venting and flaring permit"
note remarks4: "Variable name created in 18-mergeWvfPermit_20161220.do"
note remarks4: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v29 remarks5
label variable remarks5 "venting and flaring permit remarks 5"
note remarks5: "Line 5 of remarks regarding venting and flaring permit"
note remarks5: "Variable name created in 18-mergeWvfPermit_20161220.do"
note remarks5: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v30 remarks6
label variable remarks6 "venting and flaring permit remarks 6"
note remarks6: "Line 6 of remarks regarding venting and flaring permit"
note remarks6: "Variable name created in 18-mergeWvfPermit_20161220.do"
note remarks6: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v31 expFlag
label variable expFlag "venting and flaring permit expired"
note expFlag: "Venting and flaring permit expired"
note expFlag: "Variable name created in 18-mergeWvfPermit_20161220.do"
note expFlag: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v32 permanentPermit
label variable permanentPermit "permanent venting and flaring permit received"
note permanentPermit: "Permanent venting and flaring permit received"
note permanentPermit: "Variable name created in 18-mergeWvfPermit_20161220.do"
note permanentPermit: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v33 temporaryPermit
label variable temporaryPermit "temporary venting and flaring permit received"
note temporaryPermit: "Temporary permit received"
note temporaryPermit: "Variable name created in 18-mergeWvfPermit_20161220.do"
note temporaryPermit: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v34 conferencePermit
label variable conferencePermit "conference venting and flaring permit received"
note conferencePermit: "Conference permit received"
note conferencePermit: "Variable name created in 18-mergeWvfPermit_20161220.do"
note conferencePermit: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v35 address1
label variable address1 "operator address 1"
note address1: "Operator address line 1"
note address1: "Variable name created in 18-mergeWvfPermit_20161220.do"
note address1: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v36 address2
label variable address2 "operator address 2"
note address2: "Operator address line 2"
note address2: "Variable name created in 18-mergeWvfPermit_20161220.do"
note address2: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v37 city
label variable city "operator city"
note city: "Operator city"
note city: "Variable name created in 18-mergeWvfPermit_20161220.do"
note city: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v38 state
label variable state "operator state"
note state: "Operator state"
note state: "Variable name created in 18-mergeWvfPermit_20161220.do"
note state: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v39 zip
label variable zip "operator zip code"
note zip: "Operator zip code"
note zip: "Variable name created in 18-mergeWvfPermit_20161220.do"
note zip: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
rename v40 zipExt
label variable zipExt "operator zip extension"
note zipExt: "Operator zip extension"
note zipExt: "Variable name created in 18-mergeWvfPermit_20161220.do"
note zipExt: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
save 18-fvf609_20161220
cd ..
cd Posted
save 18-fvf609_20161220
cd ..
//
// prepare data before finding permit counts
cd Working
gen newOpNo = string(oper, "%06.0f")
gen dstCode = "01" if dst == 1
replace dstCode = "02" if dst == 2
replace dstCode = "03" if dst == 3
replace dstCode = "04" if dst == 4
replace dstCode = "05" if dst == 5
replace dstCode = "06" if dst == 6
replace dstCode = "6E" if dst == 7
replace dstCode = "7B" if dst == 8
replace dstCode = "7C" if dst == 9
replace dstCode = "08" if dst == 10
replace dstCode = "8A" if dst == 11
replace dstCode = "8B" if dst == 12
replace dstCode = "09" if dst == 13
replace dstCode = "10" if dst == 14
gen trimLseNam = strrtrim(lseNam) 
gen insMergIdLnaOno = dstCode + "-" + trimLseNam + "-" + newOpNo
label variable insMergIdLnaOno "Unique Well-Operator Number for leases with duplicate names for different number"
note insMergIdLnaOno: "Unique well operator: District Number + Lease Name + Operator Number"
note insMergIdLnaOno: "Created in 18-mergeWvfPermit_20161220.do from fvf609"
note insMergIdLnaOno: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
drop newOpNo dstCode
save fvf609WmergeID
//
// create count before merge to verify no data was lost
count
gen preMergCount = r(N)
keep preMergCount
duplicates drop
gen n = _n
// find percent difference from 2012 state report for fy2012 (1,963) 
//     and reported permits in dataset. 2012 state report was found at:
//     Railroad Commission of Texas. 2016. "Flaring Regulation." Retrieved 
//     December 8, 2016 (http://www.rrc.state.tx.us/about-us/resource-center/faqs/oil-gas-faqs/faq-flaring-regulation/)
gen perVFpermitDif = 100 * (1963 - preMergCount) / preMergCount
sum perVFpermitDif
save preMergCount
//
// find permit counts
clear
use fvf609WmergeID
sort insMergIdLnaOno
gen n = 1
keep insMergIdLnaOno n
quietly by insMergIdLnaOno: egen totalVFpermits = total(n)
keep insMergIdLnaOno totalVFpermits
duplicates drop
count
label variable totalVFpermits "Unique Well-Operator Number for leases with duplicate names for different number"
note totalVFpermits: "Total permits well received to vent and flare gas in 2012""
note totalVFpermits: "Created in 18-mergeWvfPermit_20161220.do from fvf609"
note totalVFpermits: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
save vfPermitCounts
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* merge permit (fvf609) data with oil and gas	pd, orgInfo, 		*/
/*    wellbore, location and programmed request info				*/
/********-*********-*********-*********-*********-*********-*********/
//
clear
cd Posted
use 16-gasPDorgVioLocGIS_20161220
append using 17-oilWodfPermit_20161220
cd ..
cd Working
merge m:1 insMergIdLnaOno using vfPermitCounts
save m
keep if _merge == 3
keep insMergIdLnaOno totalVFpermits
duplicates drop
// find number of permits that were matched using insMergIdLnaOno
egen matchCount = total(totalVFpermits)
sum matchCount
clear
// make file of merged dataset with match identifier
use m
gen fvfMatch = .
replace fvfMatch = 1 if _merge ==3
replace fvfMatch = 0 if _merge ==1
drop if _merge ==2
drop _merge
label variable fvfMatch "17-oilWodfPermit_20161218 and 16-gasPDorgVioLocGIS_20161211 appendage has matching fvf permit data"
note fvfMatch: "17-oilWodfPermit_20161218 and 16-gasPDorgVioLocGIS_20161211 appendage has matching fvf permit data"
note fvfMatch: "Created in 18-mergeWvfPermit_20161220.do from fvf609"
note fvfMatch: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
save fvfPDOImatch
clear
// find permits that were unmatched using insMergIdLnaOno, and export them
use m
keep if _merge == 2
keep insMergIdLnaOno totalVFpermits
duplicates drop
count
save 18-vfPermitUnmatchable_20161220
export delimited using 18-vfPermitUnmatchable_20161220
cd ..
cd Posted
save 18-vfPermitUnmatchable_20161220
export delimited using 18-vfPermitUnmatchable_20161220
cd ..
cd Working
//
// The data cannot be matched because the lease names in the 
// 16-gasPDorgVioLocGIS_20161211 data have different lease numbers but
// they have the same name. This is because they are
// simplified names from the vfv permit data. A fuzzy match will not work 
// because of this problem. This makes the data unmatchable as given. 
//
//
/********-*********-*********-*********-*********-*********-*********/
/* create separate oil and gas files						 		*/
/********-*********-*********-*********-*********-*********-*********/
//
use fvfPDOImatch
keep if oil_gas_code == "G"
save 18-gasPOVLGPV_20161220
cd ..
cd Posted
save 18-gasPOVLGPV_20161220
cd ..
cd Working
use fvfPDOImatch
keep if oil_gas_code != "G"
save 18-oilPOVLGPV_20161220
cd ..
cd Posted
save 18-oilPOVLGPV_20161220
cd ..
cd Working
//
//
/********-*********-*********-*********-*********-*********-*********/
/* verify no permit data was lost									*/
/********-*********-*********-*********-*********-*********-*********/
//
append using 18-gasPOVLGPV_20161220
keep insMergIdLnaOno totalVFpermits
duplicates drop
append using 18-vfPermitUnmatchable_20161220
keep insMergIdLnaOno totalVFpermits
egen postMergCount = total(totalVFpermits)
keep postMergCount
duplicates drop
gen n = 1
merge 1:1 n using preMergCount
drop _merge
gen post_minus_pre = postMergCount - preMergCount
// post_minus_pre should equal to zero
sum post_minus_pre
//
//