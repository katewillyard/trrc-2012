cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 13-mergePDorgWInspections_20161117, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
// program:		13-mergePDorgWInspections_20161117.do
// task:		clean inspections data
// 				prepare inspection data for merge 
//				merge pd & orgInfo with inspections data
//				print summary statistics of inspections
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 11/17/2016
//
/********-*********-*********-*********-*********-*********-*********/
/* Set Settings and Working Directory								*/
/********-*********-*********-*********-*********-*********-*********/
clear all
version 13
set more off
cd "C:/Users/TXCRDC/Documents/Research/eocpc"
cd Posted
//
/********-*********-*********-*********-*********-*********-*********/
/* clean inspections (08-inspections) data							*/
/********-*********-*********-*********-*********-*********-*********/
use 08-inspections_20160824
notes: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable district_no "district number"
notes district_no: "District number as assigned by the RRC"
notes district_no: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes district_no: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable operator_name "operator name"
notes operator_name: "Operator name"
notes operator_name: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes operator_name: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable operator_no "Operator number"
notes operator_no: "Operator number assigned by the RRC"
notes operator_no: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes operator_no: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
rename lease_facility lease_name
label variable lease_name "lease name"
notes lease_name: "Lease name"
notes lease_name: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes lease_name: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable lease_no "lease number"
notes lease_no: "Lease number assigned by RRC"
notes lease_no: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes lease_no: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable field "field name"
notes field: "Field name given by operator"
notes field: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes field: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable county "county name"
notes county: "County name"
notes county: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes county: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable insp_date "inspection date"
notes insp_date: "Inspection date in M/D/YYYY 0:00:00 format"
notes insp_date: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes insp_date: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable swr_no "statewide rule"
notes swr_no: "Statewide Rule Inspected"
notes swr_no: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes swr_no: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
rename compliant complaint
label variable complaint "complaint number"
notes complaint: "Complaint number inspection responded to (if applicable)"
notes complaint: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes complaint: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable violation_no "number of violations"
notes violation_no: "Number of violations to the inspected statewide rule"
notes violation_no: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes violation_no: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable new_violations_no "number of new violations"
notes new_violations_no: "Number of new violations to the statewide rule"
notes new_violations_no: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes new_violations_no: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label variable comp_no "compliance number"
notes comp_no: "Compliance number"
notes comp_no: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes comp_no: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
label data "2012 Inspections Data"
cd ..
cd Working
save 13-inspectionsCoded_20161117
cd ..
cd Posted
save 13-inspectionsCoded_20161117
cd ..
cd Working
//
/********-*********-*********-*********-*********-*********-*********/
/* Prepare Data for Merge											*/
/********-*********-*********-*********-*********-*********-*********/
// find total venting and flaring inspections
keep if swr_no == "32"
count
//
// find total venting and flaring violations
drop if violation_no == .
count
//
// find number of inspections that identified a venting and flaring 
// violation that does not have lease number
gen noLeaseNo = .
label variable noLeaseNo "inspection record has no lease number"
notes noLeaseNo: "Inspection records that have no lease number"
notes noLeaseNo: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes noLeaseNo: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes noLeaseNo: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
notes noLeaseNo: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
replace noLeaseNo = 1 if lease_no == .
replace noLeaseNo = 0 if lease_no != .
tab noLeaseNo
//
// find number of inspections that identified a venting and 
// flaring violation that does not have a lease name
gen noLeaseName = .
label variable noLeaseName "inspection record has no lease name"
notes noLeaseName: "Inspection records that have no lease name"
notes noLeaseName: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes noLeaseName: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes noLeaseName: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
notes noLeaseName: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
replace noLeaseName = 1 if lease_name == ""
replace noLeaseName = 0 if lease_name != ""
tab noLeaseName
// find number of inspections that identified a venting and flaring 
// violation that does not have an operator number
//
gen noOperatorNo = .
label variable noOperatorNo "inspection record has no operator number"
notes noOperatorNo: "Inspection records that have no operator number"
notes noOperatorNo: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes noOperatorNo: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes noOperatorNo: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
notes noOperatorNo: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
replace noOperatorNo = 1 if operator_no == .
replace noOperatorNo = 0 if operator_no != .
tab noOperatorNo
//
// find number of inspections that identified a venting and flaring 
// violation that does not have an operator name
gen noOperatorName = .
label variable noOperatorName "inspection record has no operator name"
notes noOperatorName: "Inspection records that have no operator name"
notes noOperatorName: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes noOperatorName: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes noOperatorName: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
notes noOperatorName: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
replace noOperatorName = 1 if operator_name == ""
replace noOperatorName = 0 if operator_name != ""
tab noOperatorName
//
// find number of inspections that identified a venting and flaring 
// violation that does not have a district number
gen noDistrictNo = .
label variable noDistrictNo "inspection record has no district number"
notes noDistrictNo: "Inspection records that have no district number"
notes noDistrictNo: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes noDistrictNo: "Data transformed from table-Inspections.txt to 08-inspections_20160824.dta in 08-extract_tableInspections_20160824.do"
notes noDistrictNo: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
notes noDistrictNo: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
replace noDistrictNo = 1 if district_no == ""
replace noDistrictNo = 0 if district_no != ""
tab noDistrictNo
save vfViolations
//
// find sum of total venting and flaring violations before collapse and 
// merge, to verify no data is lost
egen nVFviol = total(violation_no)
keep nVFviol
duplicates drop
gen n = _n
save preMergVFviolTot
clear
//
// make file of data without lease, field, or operator name
// which is the minimimum information necessary to merge data
use vfViolations
keep if noLeaseName == 1 | noOperatorName == 1 | noDistrictNo == 1
gen newLeaseNo = string(lease_no, "%06.0f")
gen newOpNo = string(operator_no, "%06.0f")
gen insMergIdLnoOno = district_no + "-" + newLeaseNo + "-" + newOpNo
label variable insMergIdLnoOno "Unique Well-Operator Number without oil gas code"
notes insMergIdLnoOno: "(District Number + Lease Number + Operator Number)"
notes insMergIdLnoOno: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergIdLnoOno: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
gen insMergIdLnoOna = district_no + "-" + newLeaseNo + "-" + operator_name
label variable insMergIdLnoOna "Unique Well-Operator Number without oil gas code"
notes insMergIdLnoOna: "(District Number + Lease Number + Operator Name)"
notes insMergIdLnoOna: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergIdLnoOna: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
gen insMergIdLnaOno = district_no + "-" + lease_name + "-" + newOpNo
label variable insMergIdLnaOno "Unique Well-Operator Number without oil gas code"
notes insMergIdLnaOno: "(District Number + Lease Name + Operator Number)"
notes insMergIdLnaOno: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergIdLnaOno: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
gen insMergIdLnaOna = district_no + "-" + lease_name + "-" + operator_name
label variable insMergIdLnaOna "Unique Well-Operator Number without oil gas code"
notes insMergIdLnaOna: "(District Number + Lease Name + Operator Name)"
notes insMergIdLnaOna: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergIdLnaOna: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
gen insMergWOid = district_no + "-" + newLeaseNo + lease_name + "-" + newOpNo + "-" + operator_name
label variable insMergWOid "Unique Well-Operator Number without oil gas code"
notes insMergWOid: "(District Number + Lease Number + Lease Name + Operator Number + Operator Name)"
notes insMergWOid: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergWOid: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
drop newLeaseNo newOpNo
save vfViolWOid
keep insMergWOid insMergIdLnoOno insMergIdLnoOna insMergIdLnaOno insMergIdLnaOna ///
	district_no operator_name operator_no lease_name lease_no county 
duplicates drop
save vfViolWOidConstant
clear
use vfViolWOid
sort insMergWOid
collapse (sum) violation_no, by (insMergWOid)
merge 1:1 insMergWOid using vfViolWOidConstant
if _merge != 3 {
	display "error: file with unique district, lease, and operator name connector collapsed data did not adequately merge with constant data"
	exit
}
drop _merge
save 13-vfViolByWell-woUID_20161117
cd ..
cd Posted 
save 13-vfViolByWell-woUID_20161117
cd ..
cd Working
clear
//
// make files of data with unique identifiers
// make file of data with district numbers, lease numbers, operator numbers, lease names, and operator numbers
// using unique district number, lease number, and operator number
use vfViolations
keep if noDistrictNo == 0 & noLeaseNo == 0 & noOperatorNo == 0 & noLeaseName == 0 & noOperatorName == 0
gen newLeaseNo = string(lease_no, "%06.0f")
gen newOpNo = string(operator_no, "%06.0f")
gen insMergIdLnoOno = district_no + "-" + newLeaseNo + "-" + newOpNo
label variable insMergIdLnoOno "Unique Well-Operator Number without oil gas code"
notes insMergIdLnoOno: "(District Number + Lease Number + Operator Number)"
notes insMergIdLnoOno: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergIdLnoOno: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
drop newLeaseNo newOpNo
collapse (sum) violation_no, by (insMergIdLnoOno)
save vfViolLnoOnoLnaOna
clear
// make file of data with district numbers, operator numbers, operator names, lease names, and no lease numbers
use vfViolations
keep if noDistrictNo == 0 & noLeaseNo == 1 & noOperatorNo == 0 & noLeaseName == 0 & noOperatorName == 0
gen newOpNo = string(operator_no, "%06.0f")
gen insMergIdLnaOno = district_no + "-" + lease_name + "-" + newOpNo
label variable insMergIdLnaOno "Unique Well-Operator Number for inspections at wells"
notes insMergIdLnaOno: "(District Number + Lease Name + Operator Number) for inspections at wells with district numbers, operator numbers, and lease names, but no lease numbers"
notes insMergIdLnaOno: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergIdLnaOno: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
collapse (sum) violation_no, by (insMergIdLnaOno)
save vfViolOnoLnaOna
clear
// make file of data with district numbers, operator names, lease names, and no lease numbers or operator number
use vfViolations
keep if noDistrictNo == 0 & noLeaseNo == 1 & noOperatorNo == 1 & noLeaseName == 0 & noOperatorName == 0
gen insMergIdLnaOna = district_no + "-" + lease_name + "-" + operator_name
label variable insMergIdLnaOna "Unique Well-Operator Number for inspections at wells"
notes insMergIdLnaOna: "(District Number + Lease Name + Operator Number) for inspections at wells with district numbers, operator numbers, and lease names, but no lease numbers"
notes insMergIdLnaOna: "Created from 08-inspections_20160824.dta in 15-mergePDorgWInspections_20161117.do"
notes insMergIdLnaOna: "Original Data Source: table-Inspections.txt obtained from Texas Railroad Commission, Legal Assistant, Office of General Counsel, Karen Sanchez on July 26, 2016"
collapse (sum) violation_no, by (insMergIdLnaOna)
save vfViolLnaOna
clear
// create single oil and gasPDwOrgInfo file with unique identifiers
cd ..
cd Posted
use 12-gasPDwOrgInfo_20161117
append using 12-oilPDwOrgInfo_20161117
cd ..
cd Working
drop insMergIdLnoOno
gen newLeaseNo = string(lease_no, "%06.0f")
gen newOpNo = string(operator_no, "%06.0f")
gen insMergIdLnoOno = transDistName + "-" + newLeaseNo + "-" + newOpNo
label variable insMergIdLnoOno "Unique Well-Operator Number for leases with duplicate names for different numbers"
notes insMergIdLnoOno: "Unique well operator: District Number + Lease Number + Operator Number"
notes insMergIdLnoOno: "Created from 12-oilPDwOrgInfo_20161030 in 15-mergePDorgWInspections_20161117"
notes insMergIdLnoOno: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes insMergIdLnoOno: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20160824.dta in 04-extract_orf850_20160824.do"
notes insMergIdLnoOno: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes insMergIdLnoOno: "Production and disposition data merged creating 10-oilProdDisp_20161117 from 07-production_20160824.dta and 07-disposition_20160824.dta in 10-manageProductionDisposition_20161117.do"
notes insMergIdLnoOno: "Disposition data transformed from s6leaseCycleDisp12_20160824.csv to 07-disposition_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnoOno: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnoOno: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnoOno: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes insMergIdLnoOno: "Production data transformed from s6leaseCycle12_20160824.csv to 07-production_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnoOno: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnoOno: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnoOno: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
gen insMergIdLnoOna = transDistName + "-" + newLeaseNo + "-" + operatorName
label variable insMergIdLnoOna "Unique Well-Operator Number for leases with duplicate names for different numbers"
notes insMergIdLnoOna: "Unique well operator: District Number + Lease Number + Operator Name"
notes insMergIdLnoOna: "Created from 12-oilPDwOrgInfo_20161030 in 15-mergePDorgWInspections_20161117"
notes insMergIdLnoOna: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes insMergIdLnoOna: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20160824.dta in 04-extract_orf850_20160824.do"
notes insMergIdLnoOna: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes insMergIdLnoOna: "Production and disposition data merged creating 10-oilProdDisp_20161117 from 07-production_20160824.dta and 07-disposition_20160824.dta in 10-manageProductionDisposition_20161117.do"
notes insMergIdLnoOna: "Disposition data transformed from s6leaseCycleDisp12_20160824.csv to 07-disposition_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnoOna: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnoOna: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnoOna: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes insMergIdLnoOna: "Production data transformed from s6leaseCycle12_20160824.csv to 07-production_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnoOna: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnoOna: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnoOna: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
gen insMergIdLnaOno = transDistName + "-" + lease_name + "-" + newOpNo
label variable insMergIdLnaOno "Unique Well-Operator Number"
notes insMergIdLnaOno: "Unique well operator: District Number + Lease Number + Operator Number"
notes insMergIdLnaOno: "Created from 12-oilPDwOrgInfo_20161030 in 15-mergePDorgWInspections_20161117"
notes insMergIdLnaOno: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes insMergIdLnaOno: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20160824.dta in 04-extract_orf850_20160824.do"
notes insMergIdLnaOno: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes insMergIdLnaOno: "Production and disposition data merged creating 10-oilProdDisp_20161117 from 07-production_20160824.dta and 07-disposition_20160824.dta in 10-manageProductionDisposition_20161117.do"
notes insMergIdLnaOno: "Disposition data transformed from s6leaseCycleDisp12_20160824.csv to 07-disposition_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnaOno: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnaOno: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnaOno: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes insMergIdLnaOno: "Production data transformed from s6leaseCycle12_20160824.csv to 07-production_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnaOno: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnaOno: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnaOno: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
gen insMergIdLnaOna = transDistName + "-" + lease_name + "-" + operatorName
label variable insMergIdLnaOna "Unique Well-Operator Number for leases with duplicate names for different numbers"
notes insMergIdLnaOna: "Unique well operator: District Number + Lease Name + Operator Name"
notes insMergIdLnaOna: "Created from 12-oilPDwOrgInfo_20161030 in 15-mergePDorgWInspections_20161117"
notes insMergIdLnaOna: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes insMergIdLnaOna: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20160824.dta in 04-extract_orf850_20160824.do"
notes insMergIdLnaOna: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes insMergIdLnaOna: "Production and disposition data merged creating 10-oilProdDisp_20161117 from 07-production_20160824.dta and 07-disposition_20160824.dta in 10-manageProductionDisposition_20161117.do"
notes insMergIdLnaOna: "Disposition data transformed from s6leaseCycleDisp12_20160824.csv to 07-disposition_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnaOna: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnaOna: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnaOna: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes insMergIdLnaOna: "Production data transformed from s6leaseCycle12_20160824.csv to 07-production_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes insMergIdLnaOna: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes insMergIdLnaOna: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes insMergIdLnaOna: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
drop transDistName newOpNo newLeaseNo
save oilGasPDO
//
//
// make disposition and production totals to ensure data isn't lost upon collapses and merges
egen preMergSum_oil00 = sum(lease_oil_dispcd00_vol)
egen preMergSum_oil01 = sum(lease_oil_dispcd01_vol)
egen preMergSum_oil02 = sum(lease_oil_dispcd02_vol)
egen preMergSum_oil03 = sum(lease_oil_dispcd03_vol)
egen preMergSum_oil04 = sum(lease_oil_dispcd04_vol)
egen preMergSum_oil05 = sum(lease_oil_dispcd05_vol)
egen preMergSum_oil06 = sum(lease_oil_dispcd06_vol)
egen preMergSum_oil07 = sum(lease_oil_dispcd07_vol)
egen preMergSum_oil08 = sum(lease_oil_dispcd08_vol)
egen preMergSum_oil09 = sum(lease_oil_dispcd09_vol)
egen preMergSum_oil99 = sum(lease_oil_dispcd99_vol)
egen preMergSum_gas01 = sum(lease_gas_dispcd01_vol)
egen preMergSum_gas02 = sum(lease_gas_dispcd02_vol)
egen preMergSum_gas03 = sum(lease_gas_dispcd03_vol)
egen preMergSum_gas04 = sum(lease_gas_dispcd04_vol)
egen preMergSum_gas05 = sum(lease_gas_dispcd05_vol)
egen preMergSum_gas06 = sum(lease_gas_dispcd06_vol)
egen preMergSum_gas07 = sum(lease_gas_dispcd07_vol)
egen preMergSum_gas08 = sum(lease_gas_dispcd08_vol)
egen preMergSum_gas09 = sum(lease_gas_dispcd09_vol)
egen preMergSum_gas99 = sum(lease_gas_dispcd99_vol)
egen preMergSum_cond00 = sum (lease_cond_dispcd00_vol)
egen preMergSum_cond01 = sum (lease_cond_dispcd01_vol)
egen preMergSum_cond02 = sum (lease_cond_dispcd02_vol)
egen preMergSum_cond03 = sum (lease_cond_dispcd03_vol)
egen preMergSum_cond04 = sum (lease_cond_dispcd04_vol)
egen preMergSum_cond05 = sum (lease_cond_dispcd05_vol)
egen preMergSum_cond06 = sum (lease_cond_dispcd06_vol)
egen preMergSum_cond07 = sum (lease_cond_dispcd07_vol)
egen preMergSum_cond08 = sum (lease_cond_dispcd08_vol)
egen preMergSum_cond99 = sum (lease_cond_dispcd99_vol)
egen preMergSum_csgd01 = sum (lease_csgd_dispcde01_vol)
egen preMergSum_csgd02 = sum (lease_csgd_dispcde02_vol)
egen preMergSum_csgd03 = sum (lease_csgd_dispcde03_vol)
egen preMergSum_csgd04 = sum (lease_csgd_dispcde04_vol)
egen preMergSum_csgd05 = sum (lease_csgd_dispcde05_vol)
egen preMergSum_csgd06 = sum (lease_csgd_dispcde06_vol)
egen preMergSum_csgd07 = sum (lease_csgd_dispcde07_vol)
egen preMergSum_csgd08 = sum (lease_csgd_dispcde08_vol)
egen preMergSum_csgd99 = sum (lease_csgd_dispcde99_vol)
egen preMergSum_oilProd = sum(lease_oil_prod_vol)
egen preMergSum_oilAllow = sum(lease_oil_allow)
egen preMergSum_oilEndBal = sum(lease_oil_ending_bal)
egen preMergSum_gasProd = sum(lease_gas_prod_vol)
egen preMergSum_gasAllow = sum(lease_gas_allow)
egen preMergSum_gasLift = sum(lease_gas_lift_inj_vol)
egen preMergSum_condProd = sum(lease_cond_prod_vol)
egen preMergSum_condLimit = sum(lease_cond_limit)
egen preMergSum_condEndBal = sum(lease_cond_ending_bal)
egen preMergSum_csgdProd = sum(lease_csgd_prod_vol)
egen preMergSum_csgdLimit = sum(lease_csgd_limit)
egen preMergSum_csgdLift = sum(lease_csgd_gas_lift)
egen preMergSum_oilDispTot = sum(lease_oil_tot_disp)
egen preMergSum_gasDispTot = sum(lease_gas_tot_disp)
egen preMergSum_condDispTot = sum(lease_cond_tot_disp)
egen preMergSum_csgdDispTot = sum(lease_csgd_tot_disp)
keep preMergSum_oilProd preMergSum_oilAllow preMergSum_oilEndBal ///
	preMergSum_gasProd preMergSum_gasAllow preMergSum_gasLift ///
	preMergSum_condProd preMergSum_condLimit preMergSum_condEndBal ///
	preMergSum_csgdProd preMergSum_csgdLimit preMergSum_csgdLift ///
	preMergSum_oilDispTot preMergSum_gasDispTot preMergSum_condDispTot ///
	preMergSum_csgdDispTot preMergSum_oilProd preMergSum_oilAllow preMergSum_oilEndBal ///
	preMergSum_gasProd preMergSum_gasAllow preMergSum_gasLift ///
	preMergSum_condProd preMergSum_condLimit preMergSum_condEndBal ///
	preMergSum_csgdProd preMergSum_csgdLimit preMergSum_csgdLift ///
	preMergSum_oilDispTot preMergSum_gasDispTot preMergSum_condDispTot ///
	preMergSum_csgdDispTot preMergSum_oil00 preMergSum_oil01 preMergSum_oil02 ///
	preMergSum_oil03 preMergSum_oil04 preMergSum_oil05 ///
	preMergSum_oil06 preMergSum_oil07 preMergSum_oil08 ///
	preMergSum_oil09 preMergSum_oil99 preMergSum_gas01 ///
	preMergSum_gas02 preMergSum_gas03 preMergSum_gas04 ///
	preMergSum_gas05 preMergSum_gas06 preMergSum_gas07 ///
	preMergSum_gas08 preMergSum_gas09 preMergSum_gas99 ///
	preMergSum_cond00 preMergSum_cond01 preMergSum_cond02 ///
	preMergSum_cond03 preMergSum_cond04 preMergSum_cond05 ///
	preMergSum_cond06 preMergSum_cond07 preMergSum_cond08 ///
	preMergSum_cond99 preMergSum_csgd01 preMergSum_csgd02 ///
	preMergSum_csgd03 preMergSum_csgd04 preMergSum_csgd05 ///
	preMergSum_csgd06 preMergSum_csgd07 preMergSum_csgd08 ///
	preMergSum_csgd99	
duplicates drop 
note preMergSum_oil00: "State year total crude oil (in barrels) disposed by pipeline"
note preMergSum_oil01: "State year total crude oil (in barrels) disposed by truck"
note preMergSum_oil02: "State year total crude oil (in barrels) disposed by tank car or barge"
note preMergSum_oil03: "State year total crude oil (in barrels) disposed by talk cleaning (an adjustment to and/or lease use of production already measured by the operator."
note preMergSum_oil04: "State year total crude oil (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
note preMergSum_oil05: "State year total crude oil (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
note preMergSum_oil06: "State year total crude oil (in barrels) lost due to tank cleaning, basic sediment and water."
note preMergSum_oil07: "State year total crude oil (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
note preMergSum_oil08: "State year total crude oil (in barrels) indirectly disposed by others through a saltwater gathering system. "
note preMergSum_oil09: "State year total crude oil (in barrels) indirectly disposed by others because it left the elase entrained in casinghead gas going to a gas processing plant."
note preMergSum_oil99: "State year total crude oil (in barrels) reportedly disposed without a disposition code"
note preMergSum_gas01: "State year total gas (in mcf) used for field operations"
note preMergSum_gas02: "State year total gas (in mcf) disposed by transmission line"
note preMergSum_gas03: "State year total gas (in mcf) disposed to a processing plant"
note preMergSum_gas04: "State year total gas (in mcf) vented or flared"
note preMergSum_gas05: "State year total gas (in mcf) used for gas lift"
note preMergSum_gas06: "State year total gas (in mcf) used for repressure, or pressure maintenance."
note preMergSum_gas07: "State year total gas (in mcf) delivered to carbon black plant"
note preMergSum_gas08: "State year total gas (in mcf) injected directly into a storage reservoir"
note preMergSum_gas09: "State year total gas (in mcf) lost due to the shrinkage of gas during lease separation methods"
note preMergSum_gas99: "State year total gas (in mcf) reportedly disposed without a disposition code"
note preMergSum_cond00: "State year total gas condensate (in barrels) disposed by pipeline"
note preMergSum_cond01: "State year total gas condensate (in barrels) disposed by truck"
note preMergSum_cond02: "State year total gas condensate (in barrels) disposed by tank car or barge"
note preMergSum_cond03: "State year total gas condensate (in barrels) disposed by talk cleaning (an adjustment to and/or lease use of production already measured by the operator."
note preMergSum_cond04: "State year total gas condensate (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
note preMergSum_cond05: "State year total gas condensate (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
note preMergSum_cond06: "State year total gas condensate (in barrels) lost due to tank cleaning, basic sediment and water."
note preMergSum_cond07: "State year total cgas condensate (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
note preMergSum_cond08: "State year total gas condensate (in barrels) indirectly disposed by others through a saltwater gathering system. "
note preMergSum_cond99: "State year total gas condensate (in barrels) reportedly disposed without a disposition code."
note preMergSum_csgd01: "State year total casignhead gas (in mcf) used for field operations."
note preMergSum_csgd02: "State year total casignhead gas (in mcf) disposed by transmission line"
note preMergSum_csgd03: "State year total casignhead gas (in mcf) disposed to a processing plant"
note preMergSum_csgd04: "State year total casignhead gas (in mcf) vented or flared"
note preMergSum_csgd05: "State year total casignhead gas (in mcf) used for gas lift"
note preMergSum_csgd06: "State year total casignhead gas (in mcf) used for repressure, or pressure maintenance"
note preMergSum_csgd07: "State year total casignhead gas (in mcf) delivered to carbon black plant"
note preMergSum_csgd08: "State year total casignhead gas (in mcf) injected directly into a storage reservoir"
note preMergSum_csgd99: "State year total casignhead gas (in mcf) reportedly disposed without a disposition code"
label variable preMergSum_oil00 "state-year oil pipeline disposal"
label variable preMergSum_oil01 "state-year oil truck disposal"
label variable preMergSum_oil02 "state-year oil tank disposal"
label variable preMergSum_oil03 "state-year oil tank cleaning disposal"
label variable preMergSum_oil04 "state-year oil disposal for frac liquid on other lease" 
label variable preMergSum_oil05 "state-year oil disposal from spill"
label variable preMergSum_oil06 "state-year oil disposal from basic sediment loss"
label variable preMergSum_oil07 "state-year oil disposal from water bleed-off, lease use, road oil, or theft"
label variable preMergSum_oil08 "state-year oil disposal from saltwater gathering system"
label variable preMergSum_oil09 "state-year oil disposal to gas processing plant"
label variable preMergSum_oil99 "state-year oil disposal without code"
label variable preMergSum_gas01 "state-year gas field use disposal"
label variable preMergSum_gas02 "state-year gas transmission line disposal"
label variable preMergSum_gas03 "state-year gas processing plant disposal"
label variable preMergSum_gas04 "state-year gas vented or flared"
label variable preMergSum_gas05 "state-year gas gas lift disposal"
label variable preMergSum_gas06 "state-year gas pressure maintenance disposal"
label variable preMergSum_gas07 "state-year gas carbon black plant disposal"
label variable preMergSum_gas08 "state-year gas storage reservoir disposal"
label variable preMergSum_gas09 "state-year gas lost due to shrinkage during separation"
label variable preMergSum_gas99 "state-year gas diposal without code"
label variable preMergSum_cond00 "state-year condensate pipeline disposal"
label variable preMergSum_cond01 "state-year condensate truck disposal"
label variable preMergSum_cond02 "state-year condensate tank car disposal"
label variable preMergSum_cond03 "state-year condensate tank cleaning disposal"
label variable preMergSum_cond04 "state-year condensate disposal for frac liquid on other lease"
label variable preMergSum_cond05 "state-year condensate disposal from spill"
label variable preMergSum_cond06 "state-year condensate disposal from basic sediment loss"
label variable preMergSum_cond07 "state-year condensate disposal from water bleed-off, lease use, road oil, or theft"
label variable preMergSum_cond08 "state-year condensate disposal from saltwater gathering system"
label variable preMergSum_cond99 "state-year condensate disposal without code"
label variable preMergSum_csgd01 "state-year casinghead field use disposal"
label variable preMergSum_csgd02 "state-year casinghead transmission line disposal"
label variable preMergSum_csgd03 "state-year casinghead processing plant disposal"
label variable preMergSum_csgd04 "state-year casinghead vented or flared"
label variable preMergSum_csgd05 "state-year casinghead gas lift disposal"
label variable preMergSum_csgd06 "state-year casinghead pressure maintenance disposal"
label variable preMergSum_csgd07 "state-year casinghead carbon black plant disposal"
label variable preMergSum_csgd08 "state-year casinghead storage reservoir disposal"
label variable preMergSum_csgd99 "state-year casinghead disposed without code"
note preMergSum_oilProd: "State total reported volume of crude oil produced (in barrels)"
note preMergSum_oilAllow: "State total sum of oil well allowables (in barrels) by lease for the cycle"
note preMergSum_oilEndBal: "State total stock at hand (in barrels) , computed by adding the oil ending balance from the previous cycle to the oil produced and subtracting the total of all of the liquid dispositions"
note preMergSum_gasProd: "State total reported volument of gas produce (in mcf)"
note preMergSum_gasAllow: "State total sum of the gas well allowables (in mcf) by lease for the cycle"
note preMergSum_gasLift: "State total gas used, given, or sold for gas lift by lease. It does not include gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note preMergSum_condProd: "State total reported volume of condensate gas produced (in barrels)"
note preMergSum_condLimit: "State total sum of condensate limit daily amounts for all prorated wells on the lease"
note preMergSum_condEndBal: "State total stock at hand (in barrels), computed by adding the condensate ending balance from the previous cycle to the condenstate produced and subtracting the total of all of the liquid dispositions"
note preMergSum_csgdProd: "State total reported volume of casinghead gas produced (in mcf)"
note preMergSum_csgdLimit: "State total sum of the casinghead limit daily amounts for all prorated wells on the lease"
note preMergSum_csgdLift: "State total casinghead gas used, given, or solf for gas lift by lease. It does not inlcude gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note preMergSum_oilDispTot: "State total barrels of oil disposed"
note preMergSum_gasDispTot: "State total mcf of gas disposed"
note preMergSum_condDispTot: "State total barrels of condensate gas disposed"
note preMergSum_csgdDispTot: "State total mcf of gas disposed"
label variable preMergSum_oilProd "State-year oil producion"
label variable preMergSum_oilAllow "Lease monthly oil allowables"
label variable preMergSum_oilEndBal "Lease monthly oil stock at hand"
label variable preMergSum_gasProd "Lease monthly gas production"
label variable preMergSum_gasAllow "Lease monthly gas allowables"
label variable preMergSum_gasLift "Lease monthly gas used for gas lift"
label variable preMergSum_condProd "Lease monthly condensate production"
label variable preMergSum_condLimit "Lease monthly condensate limit"
label variable preMergSum_condEndBal "Lease monthly condensate stock at hand"
label variable preMergSum_csgdProd "Lease monthly casinghead production"
label variable preMergSum_csgdLimit "Lease monthly casinghead limit"
label variable preMergSum_csgdLift "Lease monthly casinghead used for gas lift"
label variable preMergSum_oilDispTot "Lease monthly total oil disposed"
label variable preMergSum_gasDispTot "Lease monthly total gas disposed"
label variable preMergSum_condDispTot "Lease monthly total total condensate disposed"
label variable preMergSum_csgdDispTot "Lease monthly total total casinghead disposed"
note preMergSum_oilProd: "State total reported volume of crude oil produced (in barrels)"
note preMergSum_oilAllow: "State total sum of oil well allowables (in barrels) by lease for the cycle"
note preMergSum_oilEndBal: "State total stock at hand (in barrels) , computed by adding the oil ending balance from the previous cycle to the oil produced and subtracting the total of all of the liquid dispositions"
note preMergSum_gasProd: "State total reported volument of gas produce (in mcf)"
note preMergSum_gasAllow: "State total sum of the gas well allowables (in mcf) by lease for the cycle"
note preMergSum_gasLift: "State total gas used, given, or sold for gas lift by lease. It does not include gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note preMergSum_condProd: "State total reported volume of condensate gas produced (in barrels)"
note preMergSum_condLimit: "State total sum of condensate limit daily amounts for all prorated wells on the lease"
note preMergSum_condEndBal: "State total stock at hand (in barrels), computed by adding the condensate ending balance from the previous cycle to the condenstate produced and subtracting the total of all of the liquid dispositions"
note preMergSum_csgdProd: "State total reported volume of casinghead gas produced (in mcf)"
note preMergSum_csgdLimit: "State total sum of the casinghead limit daily amounts for all prorated wells on the lease"
note preMergSum_csgdLift: "State total casinghead gas used, given, or solf for gas lift by lease. It does not inlcude gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note preMergSum_oilDispTot: "State total barrels of oil disposed"
note preMergSum_gasDispTot: "State total mcf of gas disposed"
note preMergSum_condDispTot: "State total barrels of condensate gas disposed"
note preMergSum_csgdDispTot: "State total mcf of gas disposed"
label variable preMergSum_oilProd "State-year oil producion"
label variable preMergSum_oilAllow "Lease monthly oil allowables"
label variable preMergSum_oilEndBal "Lease monthly oil stock at hand"
label variable preMergSum_gasProd "Lease monthly gas production"
label variable preMergSum_gasAllow "Lease monthly gas allowables"
label variable preMergSum_gasLift "Lease monthly gas used for gas lift"
label variable preMergSum_condProd "Lease monthly condensate production"
label variable preMergSum_condLimit "Lease monthly condensate limit"
label variable preMergSum_condEndBal "Lease monthly condensate stock at hand"
label variable preMergSum_csgdProd "Lease monthly casinghead production"
label variable preMergSum_csgdLimit "Lease monthly casinghead limit"
label variable preMergSum_csgdLift "Lease monthly casinghead used for gas lift"
label variable preMergSum_oilDispTot "Lease monthly total oil disposed"
label variable preMergSum_gasDispTot "Lease monthly total gas disposed"
label variable preMergSum_condDispTot "Lease monthly total total condensate disposed"
label variable preMergSum_csgdDispTot "Lease monthly total total casinghead disposed"
gen n = _n
save preMergPDTotals
clear
/********-*********-*********-*********-*********-*********-*********/
/* merge pd & orgInfo with all inspections data	and make oil and 	*/
/* gas files														*/
/********-*********-*********-*********-*********-*********-*********/
// merge should result in some not matched from master 
// merge can result in zero not matched from using because well did 
//   not produce or dispose 
// make file of inspections without connecting well data to compare with
//   public records to verify well did not produce in 2012
//
// attempt oil and gas merge with inspection data with uid by insMergIdLnoOno
// ERROR IN THE MERGE SECTION
use oilGasPDO
sort insMergIdLnoOno
quietly by insMergIdLnoOno: gen dup = cond(_N==1,0,_n)
save insMergIdLnoOnoDID
keep if dup != 0
save insMergIdLnoOnoDup
clear
use insMergIdLnoOnoDID
keep if dup == 0
merge 1:1 insMergIdLnoOno using vfViolLnoOnoLnaOna, force
save pdmerge1
keep if _merge == 2
drop _merge
save pdmerge1noMatch
clear
use pdmerge1 
keep if _merge == 3
drop _merge
save pdmerge1match
//
// attempt oil and gas merge with inspection data with uid by insMergIdLnaOno
use pdmerge1
keep if _merge == 1 
drop _merge dup
sort insMergIdLnaOno
quietly by insMergIdLnaOno: gen dup = cond(_N==1,0,_n)
save insMergIdLnaOnoDID
keep if dup != 0
save insMergIdLnaOnoDup
clear
use insMergIdLnaOnoDID
keep if dup == 0
drop violation_no
merge 1:1 insMergIdLnaOno using vfViolOnoLnaOna, force
save pdmerge2
keep if _merge == 2
drop _merge dup
save pdmerge2noMatch
clear
use pdmerge2
keep if _merge == 3
drop _merge
save pdmerge2match
//
// attempt oil and gas merge with inspection data with uid by insMergIdLnaOna
clear
use pdmerge2
keep if _merge == 1  
drop _merge dup
sort insMergIdLnaOna
quietly by insMergIdLnaOna: gen dup = cond(_N==1,0,_n)
save insMergIdLnaOnaDID
keep if dup != 0
save insMergIdLnaOnaDup
clear
use insMergIdLnaOnaDID
keep if dup == 0
drop violation_no
merge 1:1 insMergIdLnaOna using vfViolLnaOna, force
save pdmerge3
keep if _merge == 2
drop _merge
save pdmerge3noMatch
clear
use pdmerge3
keep if _merge == 3
drop _merge
save pdmerge3match
//
// compile unmatched violators without production data
// export as .csv to compare with PDQ specific lease public viewer
// at http://webapps2.rrc.texas.gov/EWA/specificLeaseQueryAction.do
clear
use pdmerge1noMatch
append using pdmerge2noMatch pdmerge3noMatch
label data "Leases that obtained a venting and flaring violation that did not have a matching production record"
count
keep insMergIdLnoOno insMergIdLnoOna insMergIdLnaOno insMergIdLnaOna violation_no
save 13-vfViolWOpd_20161117
export excel using 13-vfViolWOpd_20161117
cd ..
cd Posted 
save 13-vfViolWOpd_20161117
export excel using 13-vfViolWOpd_20161117
cd ..
cd Working
//
// make complete oil and gas production and disposition, 
//      operator, and inspection file
use pdmerge3
keep if _merge == 1
append using pdmerge1match pdmerge2match pdmerge3match ///
	insMergIdLnoOnoDup insMergIdLnaOnoDup insMergIdLnaOnaDup
replace violation_no = 0 if violation_no == .
drop _merge
save pdoi
keep if oil_gas_code == "O"
label data "2012 Oil Production, Disposition, Organization and Inspection Data"
save 13-oilPDOrgInsp_20161117
cd ..
cd Posted
save 13-oilPDOrgInsp_20161117
cd ..
cd Working
clear
use pdoi
keep if oil_gas_code == "G"
label data "2012 Gas Production, Disposition, Organization and Inspection Data"
save 13-gasPDOrgInsp_20161117
cd ..
cd Posted
save 13-gasPDOrgInsp_20161117
cd ..
cd Working
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* make sure no inspections or production data was lost 			*/
/********-*********-*********-*********-*********-*********-*********/
// inspections data should be split among 13-gasPDOrgInsp_20161117, 
//     13-oilPDOrgInsp_20161117, 13-vfViolWOpd_20161117, and
//     13-vfViolByWell-woUID_20161117
use 13-gasPDOrgInsp_20161117
append using 13-oilPDOrgInsp_20161117 13-vfViolWOpd_20161117 ///
	13-vfViolByWell-woUID_20161117, force
egen nVFviolPost = total(violation_no)
keep nVFviolPost
duplicates drop
gen n = _n
// should have 100% match
merge 1:1 n using preMergVFviolTot
drop _merge n
gen inspComp =nVFviolPost - nVFviol
// all comparisons should be equal to 0
sum inspComp 
clear
//
// production data should be split among 13-gasPDOrgInsp_20161117, 
//     and 13-oilPDOrgInsp_20161117
use 13-gasPDOrgInsp_20161117
append using 13-oilPDOrgInsp_20161117
egen postMergSum_oilProd = sum(lease_oil_prod_vol)
egen postMergSum_oilAllow = sum(lease_oil_allow)
egen postMergSum_oilEndBal = sum(lease_oil_ending_bal)
egen postMergSum_gasProd = sum(lease_gas_prod_vol)
egen postMergSum_gasAllow = sum(lease_gas_allow)
egen postMergSum_gasLift = sum(lease_gas_lift_inj_vol)
egen postMergSum_condProd = sum(lease_cond_prod_vol)
egen postMergSum_condLimit = sum(lease_cond_limit)
egen postMergSum_condEndBal = sum(lease_cond_ending_bal)
egen postMergSum_csgdProd = sum(lease_csgd_prod_vol)
egen postMergSum_csgdLimit = sum(lease_csgd_limit)
egen postMergSum_csgdLift = sum(lease_csgd_gas_lift)
egen postMergSum_oilDispTot = sum(lease_oil_tot_disp)
egen postMergSum_gasDispTot = sum(lease_gas_tot_disp)
egen postMergSum_condDispTot = sum(lease_cond_tot_disp)
egen postMergSum_csgdDispTot = sum(lease_csgd_tot_disp)
egen postMergSum_oil00 = sum(lease_oil_dispcd00_vol)
egen postMergSum_oil01 = sum(lease_oil_dispcd01_vol)
egen postMergSum_oil02 = sum(lease_oil_dispcd02_vol)
egen postMergSum_oil03 = sum(lease_oil_dispcd03_vol)
egen postMergSum_oil04 = sum(lease_oil_dispcd04_vol)
egen postMergSum_oil05 = sum(lease_oil_dispcd05_vol)
egen postMergSum_oil06 = sum(lease_oil_dispcd06_vol)
egen postMergSum_oil07 = sum(lease_oil_dispcd07_vol)
egen postMergSum_oil08 = sum(lease_oil_dispcd08_vol)
egen postMergSum_oil09 = sum(lease_oil_dispcd09_vol)
egen postMergSum_oil99 = sum(lease_oil_dispcd99_vol)
egen postMergSum_gas01 = sum(lease_gas_dispcd01_vol)
egen postMergSum_gas02 = sum(lease_gas_dispcd02_vol)
egen postMergSum_gas03 = sum(lease_gas_dispcd03_vol)
egen postMergSum_gas04 = sum(lease_gas_dispcd04_vol)
egen postMergSum_gas05 = sum(lease_gas_dispcd05_vol)
egen postMergSum_gas06 = sum(lease_gas_dispcd06_vol)
egen postMergSum_gas07 = sum(lease_gas_dispcd07_vol)
egen postMergSum_gas08 = sum(lease_gas_dispcd08_vol)
egen postMergSum_gas09 = sum(lease_gas_dispcd09_vol)
egen postMergSum_gas99 = sum(lease_gas_dispcd99_vol)
egen postMergSum_cond00 = sum (lease_cond_dispcd00_vol)
egen postMergSum_cond01 = sum (lease_cond_dispcd01_vol)
egen postMergSum_cond02 = sum (lease_cond_dispcd02_vol)
egen postMergSum_cond03 = sum (lease_cond_dispcd03_vol)
egen postMergSum_cond04 = sum (lease_cond_dispcd04_vol)
egen postMergSum_cond05 = sum (lease_cond_dispcd05_vol)
egen postMergSum_cond06 = sum (lease_cond_dispcd06_vol)
egen postMergSum_cond07 = sum (lease_cond_dispcd07_vol)
egen postMergSum_cond08 = sum (lease_cond_dispcd08_vol)
egen postMergSum_cond99 = sum (lease_cond_dispcd99_vol)
egen postMergSum_csgd01 = sum (lease_csgd_dispcde01_vol)
egen postMergSum_csgd02 = sum (lease_csgd_dispcde02_vol)
egen postMergSum_csgd03 = sum (lease_csgd_dispcde03_vol)
egen postMergSum_csgd04 = sum (lease_csgd_dispcde04_vol)
egen postMergSum_csgd05 = sum (lease_csgd_dispcde05_vol)
egen postMergSum_csgd06 = sum (lease_csgd_dispcde06_vol)
egen postMergSum_csgd07 = sum (lease_csgd_dispcde07_vol)
egen postMergSum_csgd08 = sum (lease_csgd_dispcde08_vol)
egen postMergSum_csgd99 = sum (lease_csgd_dispcde99_vol)
keep postMergSum_oil00 postMergSum_oil01 postMergSum_oil02 ///
	postMergSum_oil03 postMergSum_oil04 postMergSum_oil05 ///
	postMergSum_oil06 postMergSum_oil07 postMergSum_oil08 ///
	postMergSum_oil09 postMergSum_oil99 postMergSum_gas01 ///
	postMergSum_gas02 postMergSum_gas03 postMergSum_gas04 ///
	postMergSum_gas05 postMergSum_gas06 postMergSum_gas07 ///
	postMergSum_gas08 postMergSum_gas09 postMergSum_gas99 ///
	postMergSum_cond00 postMergSum_cond01 postMergSum_cond02 ///
	postMergSum_cond03 postMergSum_cond04 postMergSum_cond05 ///
	postMergSum_cond06 postMergSum_cond07 postMergSum_cond08 ///
	postMergSum_cond99 postMergSum_csgd01 postMergSum_csgd02 ///
	postMergSum_csgd03 postMergSum_csgd04 postMergSum_csgd05 ///
	postMergSum_csgd06 postMergSum_csgd07 postMergSum_csgd08 ///
	postMergSum_csgd99 postMergSum_oilProd postMergSum_oilAllow ///
	postMergSum_oilEndBal postMergSum_gasProd postMergSum_gasAllow ///
	postMergSum_gasLift postMergSum_condProd postMergSum_condLimit ///
	postMergSum_condEndBal postMergSum_csgdProd ///
	postMergSum_csgdLimit postMergSum_csgdLift ///
	postMergSum_oilDispTot postMergSum_gasDispTot postMergSum_condDispTot ///
	postMergSum_csgdDispTot	
note postMergSum_oil00: "State year total crude oil (in barrels) disposed by pipeline"
note postMergSum_oil01: "State year total crude oil (in barrels) disposed by truck"
note postMergSum_oil02: "State year total crude oil (in barrels) disposed by tank car or barge"
note postMergSum_oil03: "State year total crude oil (in barrels) disposed by talk cleaning (an adjustment to and/or lease use of production already measured by the operator."
note postMergSum_oil04: "State year total crude oil (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
note postMergSum_oil05: "State year total crude oil (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
note postMergSum_oil06: "State year total crude oil (in barrels) lost due to tank cleaning, basic sediment and water."
note postMergSum_oil07: "State year total crude oil (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
note postMergSum_oil08: "State year total crude oil (in barrels) indirectly disposed by others through a saltwater gathering system. "
note postMergSum_oil09: "State year total crude oil (in barrels) indirectly disposed by others because it left the elase entrained in casinghead gas going to a gas processing plant."
note postMergSum_oil99: "State year total crude oil (in barrels) reportedly disposed without a disposition code"
note postMergSum_gas01: "State year total gas (in mcf) used for field operations"
note postMergSum_gas02: "State year total gas (in mcf) disposed by transmission line"
note postMergSum_gas03: "State year total gas (in mcf) disposed to a processing plant"
note postMergSum_gas04: "State year total gas (in mcf) vented or flared"
note postMergSum_gas05: "State year total gas (in mcf) used for gas lift"
note postMergSum_gas06: "State year total gas (in mcf) used for repressure, or pressure maintenance."
note postMergSum_gas07: "State year total gas (in mcf) delivered to carbon black plant"
note postMergSum_gas08: "State year total gas (in mcf) injected directly into a storage reservoir"
note postMergSum_gas09: "State year total gas (in mcf) lost due to the shrinkage of gas during lease separation methods"
note postMergSum_gas99: "State year total gas (in mcf) reportedly disposed without a disposition code"
note postMergSum_cond00: "State year total gas condensate (in barrels) disposed by pipeline"
note postMergSum_cond01: "State year total gas condensate (in barrels) disposed by truck"
note postMergSum_cond02: "State year total gas condensate (in barrels) disposed by tank car or barge"
note postMergSum_cond03: "State year total gas condensate (in barrels) disposed by talk cleaning (an adjustment to and/or lease use of production already measured by the operator."
note postMergSum_cond04: "State year total gas condensate (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
note postMergSum_cond05: "State year total gas condensate (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
note postMergSum_cond06: "State year total gas condensate (in barrels) lost due to tank cleaning, basic sediment and water."
note postMergSum_cond07: "State year total cgas condensate (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
note postMergSum_cond08: "State year total gas condensate (in barrels) indirectly disposed by others through a saltwater gathering system. "
note postMergSum_cond99: "State year total gas condensate (in barrels) reportedly disposed without a disposition code."
note postMergSum_csgd01: "State year total casignhead gas (in mcf) used for field operations."
note postMergSum_csgd02: "State year total casignhead gas (in mcf) disposed by transmission line"
note postMergSum_csgd03: "State year total casignhead gas (in mcf) disposed to a processing plant"
note postMergSum_csgd04: "State year total casignhead gas (in mcf) vented or flared"
note postMergSum_csgd05: "State year total casignhead gas (in mcf) used for gas lift"
note postMergSum_csgd06: "State year total casignhead gas (in mcf) used for repressure, or pressure maintenance"
note postMergSum_csgd07: "State year total casignhead gas (in mcf) delivered to carbon black plant"
note postMergSum_csgd08: "State year total casignhead gas (in mcf) injected directly into a storage reservoir"
note postMergSum_csgd99: "State year total casignhead gas (in mcf) reportedly disposed without a disposition code"
label variable postMergSum_oil00 "state-year oil pipeline disposal"
label variable postMergSum_oil01 "state-year oil truck disposal"
label variable postMergSum_oil02 "state-year oil tank disposal"
label variable postMergSum_oil03 "state-year oil tank cleaning disposal"
label variable postMergSum_oil04 "state-year oil disposal for frac liquid on other lease" 
label variable postMergSum_oil05 "state-year oil disposal from spill"
label variable postMergSum_oil06 "state-year oil disposal from basic sediment loss"
label variable postMergSum_oil07 "state-year oil disposal from water bleed-off, lease use, road oil, or theft"
label variable postMergSum_oil08 "state-year oil disposal from saltwater gathering system"
label variable postMergSum_oil09 "state-year oil disposal to gas processing plant"
label variable postMergSum_oil99 "state-year oil disposal without code"
label variable postMergSum_gas01 "state-year gas field use disposal"
label variable postMergSum_gas02 "state-year gas transmission line disposal"
label variable postMergSum_gas03 "state-year gas processing plant disposal"
label variable postMergSum_gas04 "state-year gas vented or flared"
label variable postMergSum_gas05 "state-year gas gas lift disposal"
label variable postMergSum_gas06 "state-year gas pressure maintenance disposal"
label variable postMergSum_gas07 "state-year gas carbon black plant disposal"
label variable postMergSum_gas08 "state-year gas storage reservoir disposal"
label variable postMergSum_gas09 "state-year gas lost due to shrinkage during separation"
label variable postMergSum_gas99 "state-year gas diposal without code"
label variable postMergSum_cond00 "state-year condensate pipeline disposal"
label variable postMergSum_cond01 "state-year condensate truck disposal"
label variable postMergSum_cond02 "state-year condensate tank car disposal"
label variable postMergSum_cond03 "state-year condensate tank cleaning disposal"
label variable postMergSum_cond04 "state-year condensate disposal for frac liquid on other lease"
label variable postMergSum_cond05 "state-year condensate disposal from spill"
label variable postMergSum_cond06 "state-year condensate disposal from basic sediment loss"
label variable postMergSum_cond07 "state-year condensate disposal from water bleed-off, lease use, road oil, or theft"
label variable postMergSum_cond08 "state-year condensate disposal from saltwater gathering system"
label variable postMergSum_cond99 "state-year condensate disposal without code"
label variable postMergSum_csgd01 "state-year casinghead field use disposal"
label variable postMergSum_csgd02 "state-year casinghead transmission line disposal"
label variable postMergSum_csgd03 "state-year casinghead processing plant disposal"
label variable postMergSum_csgd04 "state-year casinghead vented or flared"
label variable postMergSum_csgd05 "state-year casinghead gas lift disposal"
label variable postMergSum_csgd06 "state-year casinghead pressure maintenance disposal"
label variable postMergSum_csgd07 "state-year casinghead carbon black plant disposal"
label variable postMergSum_csgd08 "state-year casinghead storage reservoir disposal"
label variable postMergSum_csgd99 "state-year casinghead disposed without code"
note postMergSum_oilProd: "State total reported volume of crude oil produced (in barrels)"
note postMergSum_oilAllow: "State total sum of oil well allowables (in barrels) by lease for the cycle"
note postMergSum_oilEndBal: "State total stock at hand (in barrels) , computed by adding the oil ending balance from the previous cycle to the oil produced and subtracting the total of all of the liquid dispositions"
note postMergSum_gasProd: "State total reported volument of gas produce (in mcf)"
note postMergSum_gasAllow: "State total sum of the gas well allowables (in mcf) by lease for the cycle"
note postMergSum_gasLift: "State total gas used, given, or sold for gas lift by lease. It does not include gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note postMergSum_condProd: "State total reported volume of condensate gas produced (in barrels)"
note postMergSum_condLimit: "State total sum of condensate limit daily amounts for all prorated wells on the lease"
note postMergSum_condEndBal: "State total stock at hand (in barrels), computed by adding the condensate ending balance from the previous cycle to the condenstate produced and subtracting the total of all of the liquid dispositions"
note postMergSum_csgdProd: "State total reported volume of casinghead gas produced (in mcf)"
note postMergSum_csgdLimit: "State total sum of the casinghead limit daily amounts for all prorated wells on the lease"
note postMergSum_csgdLift: "State total casinghead gas used, given, or solf for gas lift by lease. It does not inlcude gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note postMergSum_oilDispTot: "State total barrels of oil disposed"
note postMergSum_gasDispTot: "State total mcf of gas disposed"
note postMergSum_condDispTot: "State total barrels of condensate gas disposed"
note postMergSum_csgdDispTot: "State total mcf of gas disposed"
label variable postMergSum_oilProd "State-year oil producion"
label variable postMergSum_oilAllow "Lease monthly oil allowables"
label variable postMergSum_oilEndBal "Lease monthly oil stock at hand"
label variable postMergSum_gasProd "Lease monthly gas production"
label variable postMergSum_gasAllow "Lease monthly gas allowables"
label variable postMergSum_gasLift "Lease monthly gas used for gas lift"
label variable postMergSum_condProd "Lease monthly condensate production"
label variable postMergSum_condLimit "Lease monthly condensate limit"
label variable postMergSum_condEndBal "Lease monthly condensate stock at hand"
label variable postMergSum_csgdProd "Lease monthly casinghead production"
label variable postMergSum_csgdLimit "Lease monthly casinghead limit"
label variable postMergSum_csgdLift "Lease monthly casinghead used for gas lift"
label variable postMergSum_oilDispTot "Lease monthly total oil disposed"
label variable postMergSum_gasDispTot "Lease monthly total gas disposed"
label variable postMergSum_condDispTot "Lease monthly total total condensate disposed"
label variable postMergSum_csgdDispTot "Lease monthly total total casinghead disposed"
duplicates drop
gen n = _n
// should have 100% match
merge 1:1 n using preMergPDTotals
drop _merge n
gen oilProd_comp = postMergSum_oilProd - preMergSum_oilProd
gen oilAllow_comp = postMergSum_oilAllow - preMergSum_oilAllow
gen oilEndBal_comp = postMergSum_oilEndBal - preMergSum_oilEndBal 
gen gasProd_comp = postMergSum_gasProd - preMergSum_gasProd
gen gasAllow_comp = postMergSum_gasAllow - preMergSum_gasAllow
gen gasLift_comp = postMergSum_gasLift - preMergSum_gasLift
gen ondProd_comp = postMergSum_condProd - preMergSum_condProd
gen condLimit_comp = postMergSum_condLimit - preMergSum_condLimit
gen condEndBal_comp = postMergSum_condEndBal - preMergSum_condEndBal
gen csgdProd_comp = postMergSum_csgdProd - preMergSum_csgdProd
gen csgdLimit_comp = postMergSum_csgdLimit - preMergSum_csgdLimit
gen csgdLift_comp = postMergSum_csgdLift - preMergSum_csgdLift
gen oilDispTot_comp = postMergSum_oilDispTot - preMergSum_oilDispTot 
gen gasDispTot_comp = postMergSum_gasDispTot - preMergSum_gasDispTot 
gen condDispTot_comp = postMergSum_condDispTot - preMergSum_condDispTot
gen csgdDispTot_comp = postMergSum_csgdDispTot - preMergSum_csgdDispTot
gen oil00_comp = postMergSum_oil00 - preMergSum_oil00 
gen oil01_comp = postMergSum_oil01 - preMergSum_oil01
gen oil02_comp = postMergSum_oil02 - preMergSum_oil02
gen oil03_comp = postMergSum_oil03 - preMergSum_oil03
gen oil04_comp = postMergSum_oil04 - preMergSum_oil04
gen oil05_comp = postMergSum_oil05 - preMergSum_oil05
gen oil06_comp = postMergSum_oil06 - preMergSum_oil06
gen oil07_comp = postMergSum_oil07 - preMergSum_oil07
gen oil08_comp = postMergSum_oil08 - preMergSum_oil08
gen oil09_comp = postMergSum_oil09 - preMergSum_oil09
gen oil99_comp = postMergSum_oil99 - preMergSum_oil99
gen gas01_comp = postMergSum_gas01 - preMergSum_gas01
gen gas02_comp = postMergSum_gas02 - preMergSum_gas02
gen gas03_comp = postMergSum_gas03 - preMergSum_gas03
gen gas04_comp = postMergSum_gas04 - preMergSum_gas04
gen gas05_comp = postMergSum_gas05 - preMergSum_gas05
gen gas06_comp = postMergSum_gas06 - preMergSum_gas06
gen gas07_comp = postMergSum_gas07 - preMergSum_gas07
gen gas08_comp = postMergSum_gas08 - preMergSum_gas08
gen gas09_comp = postMergSum_gas09 - preMergSum_gas09
gen gas99_comp = postMergSum_gas99 - preMergSum_gas99
gen cond00_comp = postMergSum_cond00 - preMergSum_cond00
gen cond01_comp = postMergSum_cond01 - preMergSum_cond01
gen cond02_comp = postMergSum_cond02 - preMergSum_cond02
gen cond03_comp = postMergSum_cond03 - preMergSum_cond03
gen cond04_comp = postMergSum_cond04 - preMergSum_cond04
gen cond05_comp = postMergSum_cond05 - preMergSum_cond05
gen cond06_comp = postMergSum_cond06 - preMergSum_cond06
gen cond07_comp = postMergSum_cond07 - preMergSum_cond07
gen cond08_comp = postMergSum_cond08 - preMergSum_cond08
gen cond99_comp = postMergSum_cond99 - preMergSum_cond99
gen csgd01_comp = postMergSum_csgd01 - preMergSum_csgd01
gen csgd02_comp = postMergSum_csgd02 - preMergSum_csgd02
gen csgd03_comp = postMergSum_csgd03 - preMergSum_csgd03
gen csgd04_comp = postMergSum_csgd04 - preMergSum_csgd04
gen csgd05_comp = postMergSum_csgd05 - preMergSum_csgd05
gen csgd06_comp = postMergSum_csgd06 - preMergSum_csgd06
gen csgd07_comp = postMergSum_csgd07 - preMergSum_csgd07
gen csgd08_comp = postMergSum_csgd08 - preMergSum_csgd08
gen csgd99_comp = postMergSum_csgd99 - preMergSum_csgd99
// all comparisons should be equal to 0
sum oil00_comp  
sum oil01_comp
sum oil02_comp
sum oil03_comp 
sum oil04_comp 
sum oil05_comp 
sum oil06_comp 
sum oil07_comp 
sum oil08_comp
sum oil09_comp 
sum oil99_comp 
sum gas01_comp 
sum gas02_comp 
sum gas03_comp 
sum gas04_comp 
sum gas05_comp 
sum gas06_comp 
sum gas07_comp 
sum gas08_comp 
sum gas09_comp 
sum gas99_comp 
sum cond00_comp
sum cond01_comp
sum cond02_comp
sum cond03_comp
sum cond04_comp
sum cond05_comp
sum cond06_comp 
sum cond07_comp
sum cond08_comp 
sum cond99_comp 
sum csgd01_comp 
sum csgd02_comp 
sum csgd03_comp 
sum csgd04_comp 
sum csgd05_comp
sum csgd06_comp 
sum csgd07_comp 
sum csgd08_comp 
sum csgd99_comp 
// all production comparisons should be equal to 0
sum oilAllow_comp 
sum oilEndBal_comp 
sum gasProd_comp 
sum gasAllow_comp 
sum gasLift_comp 
sum ondProd_comp 
sum condLimit_comp
sum condEndBal_comp 
sum csgdProd_comp 
sum csgdLimit_comp 
sum csgdLift_comp 
sum oilDispTot_comp
sum gasDispTot_comp 
sum condDispTot_comp
sum csgdDispTot_comp 
save prodComp
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* print summary statistics of gas well venting and flaring			*/
/* violations														*/
/********-*********-*********-*********-*********-*********-*********/
// summarize all gas well venting and flaring violations
use 13-gasPDOrgInsp_20161117
tab violation_no
su violation_no
di r(sum)
clear
//
// summarize gas well venting and flaring violations by percentFlared
use 13-gasPDOrgInsp_20161117
tabulate violation_no, summarize (perGasFV)
clear
// summarize gas well venting and flaring violations by organization type
use 13-gasPDOrgInsp_20161117
replace violation_no = . if violation_no == 0
tabulate operatorType, summarize (violation_no)
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* print summary statistics of oil lease venting and flaring 		*/
/* violations 														*/
/********-*********-*********-*********-*********-*********-*********/
// summarize all oil lease venting and flaring violations
use 13-oilPDOrgInsp_20161117
tab violation_no
su violation_no
di r(sum)
clear
//
// summarize oil lease venting and flaring violations by percentFlared
use 13-oilPDOrgInsp_20161117
tabulate violation_no, summarize (perCsgdFV)
clear
// summarize oil lease venting and flaring violations by organization type
use 13-oilPDOrgInsp_20161117
replace violation_no = . if violation_no == 0
tabulate operatorType, summarize (violation_no)
clear
//