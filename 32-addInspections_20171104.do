cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 32-addInspections_20171104, name(master) append text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		32-addInspections_20171104.do
// task:		import and clean inspection data for 2012
//				find number of inspections per well & operator for 2012
//				find number of SWR inspections per well & operator for 2012
//				find number of swr32 violations per well & operator for 2012
//				match inspection data with oil and gas information  for 2012
//				make .csv of longitudinal inspection data (2009-2015)
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
/* read in inspection data											*/
/********-*********-*********-*********-*********-*********-*********/
//
cd original
import excel "2012 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
label data "2012 Texas Railroad Commission Inspection Data"
notes: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
gen uid = district_no + "-" + lease_no
label variable uid "unique lease number (district-lease)"
save 32-inspections_20171104
cd ..
cd posted
save 32-inspections_20171104
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Count inspections per well & per operator						*/
/********-*********-*********-*********-*********-*********-*********/
//
// Count Inpsections Per Well in 2012
//
cd working
keep uid insp_date
duplicates drop
gen lInsp = 1
drop insp_date
collapse (sum) lInsp, by(uid)
label variable lInsp "number of inspections at lease in 2012"
notes lInsp: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save generalInspectionsByLease
clear
//
// Count Inspections Per Operator in 2012
//
use 32-inspections_20171104
keep operator_no uid insp_date
duplicates drop
drop uid insp_date
gen oInsp = 1
collapse (sum) oInsp, by(operator_no)
label variable oInsp "number of inspections of operator in 2012"
notes oInsp: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save generalInspectionsByOperator
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Count SWR 32 inspections per well & per operator					*/
/********-*********-*********-*********-*********-*********-*********/
//
// Count SWR 32 Inspections Per Well in 2012
//
cd working
use 32-inspections_20171104
keep uid insp_date swr_no
keep if swr_no == "32"
duplicates drop
gen lSwr32Insp = 1
drop insp_date swr_no
collapse (sum) lSwr32Insp, by(uid)
label variable lSwr32Insp "number of state wide rule 32 inspections at lease in 2012"
notes lSwr32Insp: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save swr32InspectionsByLease
clear
//
// Count SWR 32 Inspections Per Operator in 2012
//
use 32-inspections_20171104
keep operator_no uid insp_date swr_no
keep if swr_no == "32"
duplicates drop
gen oSwr32Insp = 1
drop uid insp_date swr_no
collapse (sum) oSwr32Insp, by(operator_no)
label variable oSwr32Insp "number of inspections of operator in 2012"
notes oSwr32Insp: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save swr32InspectionsByOperator
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Count SWR 32 violations per well & per operator					*/
/********-*********-*********-*********-*********-*********-*********/
//
// Count SWR 32 Violations Per Operator in 2012
//
cd working
use 32-inspections_20171104
keep uid insp_date swr_no violation_no compliant
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen lSwr32Vio = violation_no
destring lSwr32Vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) lSwr32Vio, by(uid)
label variable lSwr32Vio "number of state wide rule 32 violations at lease in 2012"
notes lSwr32Vio: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save swr32ViolationsByLease
clear
//
// Count SWR 32 Violations Per Operator in 2012
//
use 32-inspections_20171104
keep operator_no uid insp_date swr_no
keep if swr_no == "32"
duplicates drop
gen oSwr32Vio = 1
drop uid insp_date swr_no
collapse (sum) oSwr32Vio, by(operator_no)
label variable oSwr32Vio "number of violations of operator in 2012"
notes oSwr32Vio: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save swr32ViolationsByOperator
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Make Singe Lease Level and Operator Level Files					*/
/********-*********-*********-*********-*********-*********-*********/
//
// Make single lease level file
//
cd working
use generalInspectionsByLease
merge 1:1 uid using swr32InspectionsByLease
replace lSwr32Insp = 0 if _merge == 1
drop _merge
merge 1:1 uid using swr32ViolationsByLease
replace lSwr32Vio = 0 if _merge == 1
drop _merge
sort uid
save leaseInsp2012
clear
//
// Make single operator level file
use generalInspectionsByOperator
merge 1:1 operator_no using swr32InspectionsByOperator
replace oSwr32Insp = 0 if _merge == 1
drop _merge
merge 1:1 operator_no using swr32ViolationsByOperator
replace oSwr32Vio = 0 if _merge == 1
drop _merge
sort operator_no
save operatorInsp2012
clear
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge with Gas Well Data 										*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 31-gasWpermit_20171104
cd ..
cd working
drop uid 
gen uid = district_name + "-" + string(lease_no)
merge m:1 uid using leaseInsp2012
drop if _merge == 2
replace lInsp = 0 if _merge == 1
replace lSwr32Insp = 0 if _merge == 1
replace lSwr32Vio = 0 if _merge == 1
drop _merge
tostring operator_no, replace
merge m:1 operator_no using operatorInsp2012
drop if _merge == 2
replace oInsp = 0 if _merge == 1
replace oSwr32Insp = 0 if _merge == 1
replace oSwr32Vio = 0 if _merge == 1
drop _merge
label data "2012 gas well venting and flaring data with operator, community, inspection and vioilation information"
notes: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save 32-gasWinspect_20171104
cd ..
cd posted
save 32-gasWinspect_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge with Oil Lease Data										*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 31-oilWpermit_20171104
cd ..
cd working
drop uid 
gen uid = district_name + "-" + string(lease_no)
merge m:1 uid using leaseInsp2012
drop if _merge == 2
replace lInsp = 0 if _merge == 1
replace lSwr32Insp = 0 if _merge == 1
replace lSwr32Vio = 0 if _merge == 1
drop _merge
tostring operator_no, replace
merge m:1 operator_no using operatorInsp2012
drop if _merge == 2
replace oInsp = 0 if _merge == 1
replace oSwr32Insp = 0 if _merge == 1
replace oSwr32Vio = 0 if _merge == 1
drop _merge
label data "2012 oil lease venting and flaring data with operator, community, inspection and vioilation information"
notes: "Original Source: Received by Hightail Cloud Service email from Vanessa Burgess to Kate Willyard on June 7, 2017"
save 32-oilWinspect_20171104
cd ..
cd posted
save 32-oilWinspect_20171104
clear
cd ..

//
/********-*********-*********-*********-*********-*********-*********/
/* Make Longitudinal Inspection Files								*/
/********-*********-*********-*********-*********-*********-*********/
//
// Count number of inspections and SWR violations in 2009
//
cd original
import excel "2009 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
gen uid = district_no + "-" + lease_no
gen year = 2009
save 2009
keep uid insp_date year
duplicates drop
gen inspections = 1
drop uid insp_date
collapse (sum) inspections, by(year)
save i2009
clear
use 2009
keep uid insp_date swr_no violation_no compliant year
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen swr32vio = violation_no
destring swr32vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) swr32vio, by(year)
save v2009
merge 1:1 year using i2009
drop _merge
save 2009, replace
clear
cd ..
//
// Count number of inspections and SWR violations in 2010
//
cd original
import excel "2010 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
gen uid = district_no + "-" + lease_no
gen year = 2010
save 2010
keep uid insp_date year
duplicates drop
gen inspections = 1
drop uid insp_date
collapse (sum) inspections, by(year)
save i2010
clear
use 2010
keep uid insp_date swr_no violation_no compliant year
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen swr32vio = violation_no
destring swr32vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) swr32vio, by(year)
save v2010
merge 1:1 year using i2010
drop _merge
save 2010, replace
clear
cd ..
//
//
// Count number of inspections and SWR violations in 2011
//
cd original
import excel "2011 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
gen uid = district_no + "-" + lease_no
gen year = 2011
save 2011
keep uid insp_date year
duplicates drop
gen inspections = 1
drop uid insp_date
collapse (sum) inspections, by(year)
save i2011
clear
use 2011
keep uid insp_date swr_no violation_no compliant year
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen swr32vio = violation_no
destring swr32vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) swr32vio, by(year)
save v2011
merge 1:1 year using i2011
drop _merge
save 2011, replace
clear
cd ..
//
//
// Count number of inspections and SWR violations in 2012
//
cd original
import excel "2012 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
gen uid = district_no + "-" + lease_no
gen year = 2012
save 2012
keep uid insp_date year
duplicates drop
gen inspections = 1
drop uid insp_date
collapse (sum) inspections, by(year)
save i2012
clear
use 2012
keep uid insp_date swr_no violation_no compliant year
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen swr32vio = violation_no
destring swr32vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) swr32vio, by(year)
save v2012
merge 1:1 year using i2012
drop _merge
save 2012, replace
clear
cd ..
//
//
// Count number of inspections and SWR violations in 2013
//
cd original
import excel "2013 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
gen uid = district_no + "-" + lease_no
gen year = 2013
save 2013
keep uid insp_date year
duplicates drop
gen inspections = 1
drop uid insp_date
collapse (sum) inspections, by(year)
save i2013
clear
use 2013
keep uid insp_date swr_no violation_no compliant year
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen swr32vio = violation_no
destring swr32vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) swr32vio, by(year)
save v2013
merge 1:1 year using i2013
drop _merge
save 2013, replace
clear
cd ..
//
//
// Count number of inspections and SWR violations in 2014
//
cd original
import excel "2014 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
gen uid = district_no + "-" + lease_no
gen year = 2014
save 2014
keep uid insp_date year
duplicates drop
gen inspections = 1
drop uid insp_date
collapse (sum) inspections, by(year)
save i2014
clear
use 2014
keep uid insp_date swr_no violation_no compliant year
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen swr32vio = violation_no
destring swr32vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) swr32vio, by(year)
save v2014
merge 1:1 year using i2014
drop _merge
save 2014, replace
clear
cd ..
//
//
// Count number of inspections and SWR violations in 2015
//
cd original
import excel "2015 Inspection Data.xlsx", sheet("Sheet1") firstrow case(lower)
cd ..
cd working
gen uid = district_no + "-" + lease_no
gen year = 2015
save 2015
keep uid insp_date year
duplicates drop
gen inspections = 1
drop uid insp_date
collapse (sum) inspections, by(year)
save i2015
clear
use 2015
keep uid insp_date swr_no violation_no compliant year
keep if swr_no == "32" & compliant == "N"
duplicates drop
gen swr32vio = violation_no
destring swr32vio, replace
drop insp_date swr_no violation_no compliant
collapse (sum) swr32vio, by(year)
save v2015
merge 1:1 year using i2015
drop _merge
save 2015, replace
clear
cd ..
//
//
// Export Longitudinal Inspection files
//
cd working
append using 2009 2010 2011 2012 2013 2014 2015
save 32-inspectionsViolationsByYear_20171104
export delimited using 32-inspectionsViolationsByYear_20171104.csv
cd ..
cd posted
save 32-inspectionsViolationsByYear_20171104
export delimited using 32-inspectionsViolationsByYear_20171104.csv
//
//
