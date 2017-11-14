cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 31-addFvPermit_20171104, name(master) append text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		31-addFvPermit_20171104.do
// task:		import and clean venting and flaring permit data
//				match permit data with oil and gas information
//				show vf permit data longitudinally
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 11/4/2017
//
//
/********-*********-*********-*********-*********-*********-*********/
/* Set Settings and Working Directory								*/
/********-*********-*********-*********-*********-*********-*********/
//
clear all
version 14
set more off
cd "C:/Users/katew/Documents/eocpc"
//
/********-*********-*********-*********-*********-*********-*********/
/* read in flare and vent permit data								*/
/********-*********-*********-*********-*********-*********-*********/
//
cd original
import delimited FVPM_fvf615.dat, delimiter("}")
label data "Flare Vent Permit Download For Engineering Unit"
notes: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
cd ..
cd working
rename v1 permit
rename v2 typeCode
rename v3 district
rename v4 leaseNumber
rename v5 apiNumber
rename v6 drillingPermit
rename v7 commingleDist
rename v8 comminglePermit
rename v9 plantIdDist
rename v10 plantIdNum
rename v11 dist
rename v12 operator
rename v13 county
rename v14 flared
rename v15 vented
rename v16 gasWell
rename v17 casinghead
rename v18 exist
rename v19 new
rename v20 amend
rename v21 concentration
rename v22 volume
rename v23 approvalDate
rename v24 applicationDate
rename v25 effectiveDate
rename v26 expireDate
rename v27 amendDate
rename v28 fieldName
rename v29 leaseName
rename v30 timePeriod
rename v31 conferenceDate
rename v32 remarks1
rename v33 remarks2
rename v34 remarks3
rename v35 expPrintedFlag
rename v36 permanentPermit
rename v37 temporaryPermit
rename v38 conferencePermit
rename v39 address1
rename v40 address2
rename v41 city
rename v42 state
rename v43 zip
rename v44 zipExt
rename v45 remarks4
rename v46 remarks6
rename v47 remarks7
rename v48 remarks8
save 31-cleanVfPermit_20171104
cd ..
cd posted
save 31-cleanVfPermit_20171104
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Save Temporary Permit Data for 2012								*/
/********-*********-*********-*********-*********-*********-*********/
//
// Save for permits identified by district and lease number
//
cd working 
label data "Temporary Permits to Vent or Flare in 2012 by Lease Uid"
keep if district != 0 & leaseNumber != 0
gen uid = string(district) + "-" + string(leaseNumber)
tostring effectiveDate, replace format(%20.0f)
gen effectiveYear = substr(effectiveDate,1,4)
destring effectiveYear, replace
tostring expireDate, replace format(%20.0f)
gen expireYear = substr(effectiveDate,1,4)
destring expireYear, replace
keep if effectiveYear <=2012 & expireYear >= 2012 & permanentPermit != "Y"
gen vfTempPermits = 1
collapse (sum) vfTempPermits, by(uid)
label variable vfTempPermits "non permanent permits to vent or flare in 2012"
notes vfTempPermits : "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
sort uid
save vfTempUid
clear
//
// Save for permits identified by apiNumber
//
use 31-cleanVfPermit_20171104
label data "Temporary Permits to Vent or Flare in 2012 by API number"
keep if apiNumber != 0
tostring effectiveDate, replace format(%20.0f)
gen effectiveYear = substr(effectiveDate,1,4)
destring effectiveYear, replace
tostring expireDate, replace format(%20.0f)
gen expireYear = substr(effectiveDate,1,4)
destring expireYear, replace
keep if effectiveYear <=2012 & expireYear >= 2012  & permanentPermit != "Y"
gen vfTempPermits = 1
// NO TEMPORARY PERMITS ISSUED FOR API NUMBER IN 2012
// collapse (sum) vfTempPermits, by(apiNumber)
// label variable vfTempPermits "non permanent permits to vent or flare in 2012"
// notes vfTempPermits : "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
// sort apiNumber
// rename apiNumber api_no
save vfTempApi
clear
//
// Save for permits identified by drillingPermit 
//
use 31-cleanVfPermit_20171104
label data "Temporary Permits to Vent or Flare in 2012 by Drilling Permit"
keep if drillingPermit != 0
tostring effectiveDate, replace format(%20.0f)
gen effectiveYear = substr(effectiveDate,1,4)
destring effectiveYear, replace
tostring expireDate, replace format(%20.0f)
gen expireYear = substr(effectiveDate,1,4)
destring expireYear, replace
keep if effectiveYear <=2012 & expireYear >= 2012  & permanentPermit != "Y"
gen vfTempPermits = 1
collapse (sum) vfTempPermits, by(drillingPermit)
label variable vfTempPermits "non permanent permits to vent or flare in 2012"
notes vfTempPermits : "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
sort drillingPermit
save vfTempPermit
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Save Permanent Permit Data for 2012								*/
/********-*********-*********-*********-*********-*********-*********/
//
// Save for permits identified by lease and district number
//
cd working
use 31-cleanVfPermit_20171104
label data "Permanent Permits to Vent or Flare by Lease Number and District Number"
keep if district != 0 & leaseNumber != 0
gen uid = string(district) + "-" + string(leaseNumber)
tostring effectiveDate, replace format(%20.0f)
gen effectiveYear = substr(effectiveDate,1,4)
destring effectiveYear, replace
keep if effectiveYear <= 2012 & permanentPermit == "Y"
gen vfPermPermits = 1
collapse (sum) vfPermPermits, by(uid)
label variable vfPermPermits "permanent permits to vent or flare valid in 2012"
notes vfPermPermits: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
sort uid
save vfPermUid
clear
//
// Save for permits identified by api number
//
use 31-cleanVfPermit_20171104
label data "Permanent Permits to Vent or Flare by API Number"
keep if apiNumber != 0 
tostring effectiveDate, replace format(%20.0f)
gen effectiveYear = substr(effectiveDate,1,4)
destring effectiveYear, replace
keep if effectiveYear <= 2012 & permanentPermit == "Y"
gen vfPermPermits = 1
// NO PERMANENT PERMITS ISSUED FOR API NUMBERS
// collapse (sum) vfPermPermits, by(apiNumber)
// label variable vfPermPermits "permanent permits to vent or flare valid in 2012"
// notes vfPermPermits: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
// sort apiNumber
// rename apiNumber api_no
// save vfTempApi
clear
//
// Save for permits identified by drilling permit number
//
use 31-cleanVfPermit_20171104
label data "Permanent Permits to Vent or Flare by Drilling Permit Number"
keep if drillingPermit != 0 
tostring effectiveDate, replace format(%20.0f)
gen effectiveYear = substr(effectiveDate,1,4)
destring effectiveYear, replace
keep if effectiveYear <= 2012 & permanentPermit == "Y"
gen vfPermPermits = 1
collapse (sum) vfPermPermits, by(drillingPermit)
label variable vfPermPermits "permanent permits to vent or flare valid in 2012"
notes vfPermPermits: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
sort drillingPermit
save vfPermPermit
clear
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge with gas well data 										*/
/********-*********-*********-*********-*********-*********-*********/
//
// merge using district and lease number
//
cd posted
use 30-gasLease_20171104
cd ..
cd working
gen uid = string(district_no ) + "-" + string(lease_no)
sort uid
merge m:1 uid using vfTempUid
drop if _merge == 2
replace vfTempPermits = 0 if _merge == 1
drop if _merge == 2
drop _merge 
merge m:1 uid using vfPermUid
drop if _merge == 2
drop _merge
sort wellop
save gasuid
clear
//
// merge using api number not necessary 
//
// 
// merge using drilling number
//
cd ..
cd posted
import delimited 19-gas_20161230.csv
cd ..
cd working
keep wellop permit
rename permit drillingPermit
sort drillingPermit
merge m:1 drillingPermit using vfTempPermit
drop if _merge == 2
replace vfTempPermits = 0 if _merge == 1
drop _merge 
merge m:1 drillingPermit using vfPermPermit
drop if _merge == 2
drop _merge
sort wellop
merge 1:1 wellop using gasuid

drop _merge
save 31-gasWpermit_20171104
cd ..
cd posted
save 31-gasWpermit_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge with oil lease data										*/
/********-*********-*********-*********-*********-*********-*********/
//
// merge using district and lease number
//
cd posted
use 30-oilLease_20171104
cd ..
cd working
gen uid = string(district_no ) + "-" + string(lease_no)
sort uid
merge m:1 uid using vfTempUid
drop if _merge == 2
replace vfTempPermits = 0 if _merge == 1
drop _merge 
merge m:1 uid using vfPermUid
drop if _merge == 2
drop _merge
sort wellop
save oiluid
clear
cd ..
//
// merge using api number not necessary
//
//
// merge using drilling number
//
cd posted
use 21-oil_20170115
cd ..
cd working
rename wellOP wellop
keep wellop permit
rename permit drillingPermit
sort drillingPermit
destring drillingPermit, replace
merge m:1 drillingPermit using vfTempPermit
drop if _merge == 2
replace vfTempPermits = 0 if _merge == 1
drop _merge 
merge m:1 drillingPermit using vfPermPermit
drop if _merge == 2
drop _merge
sort wellop
collapse (sum) vfPermPermits vfTempPermits, by(wellop)
label variable vfPermPermits "permanent permits to vent or flare valid in 2012"
notes vfPermPermits: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
label variable vfTempPermits "temporary permits to vent or flare valid in 2012"
notes vfTempPermits: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
merge 1:1 wellop using oiluid
drop if _merge == 1
drop _merge
save 31-oilWpermit_20171104
cd ..
cd posted
save 31-oilWpermit_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* show vf permit data longitudinally								*/
/********-*********-*********-*********-*********-*********-*********/
//
// Show temporary permits by year
//
cd working
use 31-cleanVfPermit_20171104
label data "Approved Temporary Flare Vent Permits by Year"
tostring approvalDate, replace format(%20.0f)
gen approvalYear = substr(approvalDate,1,4)
label variable approvalYear "year venting and flaring permit was approved"
notes approvalYear: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
keep if permanentPermit != "Y"
gen vfPermits = 1
collapse (sum) vfPermits, by(approvalYear)
label variable vfPermits "venting and flaring permits approved in year"
notes vfPermits : "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
save 31-vfTempPermitByYear_20171104
export delimited using 31-vfTempPermitByYear_20171104.csv
cd ..
cd posted
save 31-vfTempPermitByYear_20171104
export delimited using 31-vfTempPermitByYear_20171104.csv
cd ..
clear
//
// Show permanent permits by year
//
cd working
use 31-cleanVfPermit_20171104
label data "Approved Permanent Flare Vent Permits by Year"
tostring approvalDate, replace format(%20.0f)
gen approvalYear = substr(approvalDate,1,4)
label variable approvalYear "year venting and flaring permit was approved"
notes approvalYear: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
keep if permanentPermit != "Y"
gen vfPermits = 1
collapse (sum) vfPermits, by(approvalYear)
label variable vfPermits "venting and flaring permits approved in year"
notes vfPermits : "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
save 31-vfPermPermitByYear_20171104
export delimited using 31-vfPermPermitByYear_20171104.csv
cd ..
cd posted
save 31-vfPermPermitByYear_20171104
export delimited using 31-vfPermPermitByYear_20171104.csv
cd ..
clear
//
// Show permits approved for economical reasons by year
//
cd working
use 31-cleanVfPermit_20171104
label data "Venting and Flaring Permits Approved for Economical Reasons by Year"
gen lowernotes = lower(remarks1) + lower(remarks2)+ ///
	lower(remarks3)+ lower(remarks4) + ///
	lower(remarks6) + lower(remarks7)
gen economicFlag = .
replace economicFlag = 1 if strpos(lowernotes, "economic")
replace economicFlag = 1 if strpos(lowernotes, "not") & ///
	strpos(lowernotes, "enough") & strpos(remarks1, "to sell")
save vfWeconomicFlag
keep if economicFlag == 1
tostring approvalDate, replace format(%20.0f)
gen approvalYear = substr(approvalDate,1,4)
label variable approvalYear "year venting and flaring permit was approved"
notes approvalYear: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
keep if permanentPermit != "Y"
gen vfPermits = 1
collapse (sum) vfPermits, by(approvalYear)
label variable vfPermits "venting and flaring permits approved in year"
notes vfPermits : "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
save 31-vfEconPermitByYear_20171104
export delimited using 31-vfEconPermitByYear_20171104.csv
cd ..
cd posted
save 31-vfEconPermitByYear_20171104
export delimited using 31-vfEconPermitByYear_20171104.csv
cd ..
clear
//
//