cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 12-mergePDwOrgInfo_20161117, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
// program:		12-mergePDwOrgInfo_20161117.do
// task:		clean orgInfo data
//				merge oil pd with orgInfo
//				merge gas pd with orgInfo
//				print summary statistics of org types
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
/* clean orgInfo (04-orf850info) data								*/
/********-*********-*********-*********-*********-*********-*********/
use 04-orf850info_20160824
notes: "Original Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename OPERATOR_NUMBER operator_no
label variable operator_no "operator number"
note operator_no: "organization/operator id number as assigned by the RRC"
notes operator_no: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
destring operator_no, replace
rename REFILING_REQUIRED_FLAG operatorRefilingFlag
label variable operatorRefilingFlag "if refiling of p-5 is required"
note operatorRefilingFlag: "code to indicate if refiling of form p-5 is required, y- yes, n-no"
notes operatorRefilingFlag: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename P_5_STATUS operatorP5status
label variable operatorP5status "status code of annual refiling"
note operatorP5status: "status code of annual refiling, a- active,t-inactive,d-delinquint, s-see remarks"
notes operatorP5status: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename HOLD_MAIL_CODE operatorMailHold
label variable operatorMailHold "mailing status"
note operatorMailHold: "status of address of organization, h-invalid, n-valid"
notes operatorMailHold: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename RENEWAL_LETTER_CODE operatorRenewalCode
label variable operatorRenewalCode "operator renewal code"
note operatorRenewalCode: "renewal letter sent, p-property renewal letter sent, n-nonproperty renewal letter sent"
notes operatorRenewalCode: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORGANIZATION_NAME operatorName
label variable operatorName "operator name"
note operatorName: "name of the operating organization"
notes operatorName: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename GATHERER_CODE operatorGathererCode
label variable operatorGathererCode "operator gatherer code"
note operatorGathererCode: "a unique assigned code that indicates the organization has participated in gathering activities"
notes operatorGathererCode: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORGANIZATION_CODE operatorOrgCode
label variable operatorOrgCode "organization type code"
note operatorOrgCode: "current plan of organization, a-corporation, b-limited partnership, c-sole proprietorship, d-partnership, e-trust, f-joint venure, g-estate, h-llc, i-other"
notes operatorOrgCode: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
gen operatorType = .
tostring operatorType, replace
replace operatorType = "Corporation" if operatorOrgCode == "A"
replace operatorType = "Limited Partnership" if operatorOrgCode == "B"
replace operatorType = "Sole Proprietorship" if operatorOrgCode == "C"
replace operatorType = "Partnership" if operatorOrgCode == "D"
replace operatorType = "Trust" if operatorOrgCode == "E"
replace operatorType = "Joint Venture" if operatorOrgCode == "F"
replace operatorType = "Estate" if operatorOrgCode == "G"
replace operatorType = "Limited Liability Company (LLC)" if operatorOrgCode == "H"
replace operatorType = "Other" if operatorOrgCode == "I"
label variable operatorType "operatore type name"
note operatorType: "name of current plan of organization"
notes operatorType: "Created from 04-extract_orf850_20160824.dta in 12-mergePDwOrgInfo_20161117.do"
notes operatorType: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORGAN_OTHER_COMMENT operatorOrgTypeComment
label variable operatorOrgTypeComment "other organization type comment"
note operatorOrgTypeComment: "if org cod is other (g), this id description of the current plan of organization"
notes operatorOrgTypeComment: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORG_ADDR_LINE1 operatorMailAddress1
label variable operatorMailAddress1 "operator address line 1 - mailing address"
note operatorMailAddress1: "this is the first line of the organization's master mailing address"
notes operatorMailAddress1: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORG_ADDR_LINE2 operatorMailAddress2
label variable operatorMailAddress2 "operator adddress line 2 - mailing address"
note operatorMailAddress2: "this is the second line of the organization's master mailing address"
notes operatorMailAddress2: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORG_ADDR_CITY operatorMailCity
label variable operatorMailCity "operator city - mailing address"
note operatorMailCity: "this is the city of the organization's master mailing address"
notes operatorMailCity: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORG_ADDR_STATE operatorMailState
label variable operatorMailState "operator state - mailing address"
note operatorMailState: "this is the state of the organiation's master mailing address"
notes operatorMailState: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORG_ADDR_ZIP operatorMailZip
label variable operatorMailZip "operator zip - mailing address"
note operatorMailZip: "this is the zip code for the organization's master mailing address"
notes operatorMailZip: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename ORG_ADDR_ZIP_SUFFIX operatorMailZipSuf
label variable operatorMailZipSuf "operator zip code suffix - mailing address"
note operatorMailZipSuf: "this is the zip code suffix for the organization's master mailing address"
notes operatorMailZipSuf: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename LOCATION_ADDR_LINE1 operatorLocAddress1
label variable operatorLocAddress1 "operator address line 1 - physical location"
note operatorLocAddress1: "this is the first line of the organization's physical location address"
notes operatorLocAddress1: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename LOCATION_ADDR_LINE2 operatorLocAddress2
label variable operatorLocAddress2 "operator address line 2 - physical location"
note operatorLocAddress2: "this is the second line of the organization's physical location address"
notes operatorLocAddress2: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename LOCATION_ADDR_CITY operatorLocCity
label variable operatorLocCity "operator city - physical location"
note operatorLocCity: "this is the city of the organization's physical location address"
notes operatorLocCity: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename LOCATION_ADDR_STATE operatorLocState
label variable operatorLocState "operator state - physical location"
note operatorLocState: "this is the state of the organization's physical location address"
notes operatorLocState: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename LOCATION_ADDR_ZIP operatorLocZip
label variable operatorLocZip "operator zip code - physical location"
note operatorLocZip: "this is the zip code for the organization's physical location address"
notes operatorLocZip: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename LOCATION_ADDR_ZIP_SUFFIX operatorLocZipSuf
label variable operatorLocZipSuf "operator zip code suffix - physical location"
note operatorLocZipSuf: "this is the zip code suffix for the organization's phsyical location address"
notes operatorLocZipSuf: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename DATE_BUILT operatorDateFirstFiled
label variable operatorDateFirstFiled "operator first file date"
note operatorDateFirstFiled: "date this organization was first placed on the RRC organization report filed in MMDDYY format"
notes operatorDateFirstFiled: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename DATE_INACTIVE operatorDateInactive
label variable operatorDateInactive "date inactive"
note operatorDateInactive: "date this organization became inactive on the RRC organization report files"
notes operatorDateInactive: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename PHONE_NUMBER operatorPhone
label variable operatorPhone "operator phone number"
note operatorPhone: "phone number of the preparer of the form p-5"
notes operatorPhone: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename REFILE_NOTICE_MONTH operatorMonthRefile
label variable operatorMonthRefile "refile month"
note operatorMonthRefile: "the anniversary month of filing of the form p-5 with the RRC. Refiling must be completed by this month each year"
notes operatorMonthRefile: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename REFILE_LETTER_DATE opRefileLetDate
label variable opRefileLetDate "refile letter date"
note opRefileLetDate: "the date that the annual refiling correspondence was mailed to this organization by the RRC in MMDDYY format"
notes opRefileLetDate: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename REFILE_NOTICE_DATE opRefileNotDate
label variable opRefileNotDate "operator notice letter date"
note opRefileNotDate:  "date that the final notice correspondence was mailed to this organization by the RRC in MMDDYY format"
notes opRefileNotDate: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename REFILE_RECEIVED_DATE refileRecDate
label variable refileRecDate "operator refile received date"
note refileRecDate: "date that the refiled form p-5 was received and processed by the RRC in MMDDYY format"
notes refileRecDate: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename LAST_P_5_RECEIVED_DATE lastRefileRecDate
label variable lastRefileRecDate "last date a form p-5 was received"
note lastRefileRecDate: "date that the last refiled form p-5 was received and processed by the RRC. This includes not just annual refilings, but all filings in MMDDYY format"
notes lastRefileRecDate: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename OTHER_ORGANIZATION_NO operatorOtherNo
label variable operatorOtherNo "other operator organization number"
note operatorOtherNo: "organization number in which this organization relates. this may point to an old name used by this organization"
notes operatorOtherNo: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename FILING_PROBLEM_DATE filingProblemDate
label variable filingProblemDate "filing problem date"
note filingProblemDate: "the form p-5 riled was not correct and a letter was mailed requesting a correct form. This is the date that letter was mailed in MMDDYY format"
notes filingProblemDate: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename FILING_PROBLEM_LTR_CODE filingProblemCode
label variable filingProblemCode "type of filing problem"
note filingProblemCode: "a three digit code to identify the type of filing problem letter that was mailed. see manual for details"
notes filingProblemCode: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename TELEPHONE_VERIFY_FLAG operatorPhoneVerified
label variable operatorPhoneVerified "address verified over phone"
note operatorPhoneVerified: "this flag is used when the location address is questined and the operator is called to verify the address"
notes operatorPhoneVerified: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename OP_NUM_MULTI_USED_FLAG opNoMultiUseFlag
label variable opNoMultiUseFlag "operator number assigned to more than one org"
note opNoMultiUseFlag: "operator number assigned to more than one organization"
notes opNoMultiUseFlag: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename OIL_GATHERER_STATUS oilGathStatus 
label variable oilGathStatus "oil gatherer status"
note oilGathStatus: "n-not used, y-liquid gatherer, i-inactive gatherer, x-invalid gatherer with remarks"
notes oilGathStatus: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename GAS_GATHERER_STATUS gasGathStatus
label variable gasGathStatus "gas gatherer status"
note gasGathStatus: "n-not used, y-gas gatherer, i-inactive gatherer, x-invalid gatherer"
notes gasGathStatus: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename TAX_CERT operatorTaxCert 
label variable operatorTaxCert "operator tax certificate on file"
note operatorTaxCert: "blank- not requested, y-certificate on file, n-certificate not on file, x- certificate not required."
notes operatorTaxCert: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
rename EMER_PHONE_NUMBER operatorEmergencyPhone
label variable operatorEmergencyPhone "emergency phone number"
note operatorEmergencyPhone: "emergency phone number to be used after hours in case of fire, pipeline rupture, etc."
notes operatorEmergencyPhone: "Organization Info table data transformed from orf850txt to 04-orf850info_20160824.dta in 04-extract_orf850_20160824.do"
label variable id "id to link organization (orf850) tables"
label data "Organizations Info Table"
save 12-orf850infoCoded_20161117
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge gas production and dispostion data with the company info	*/
/********-*********-*********-*********-*********-*********-*********/
// merge should result is  some not matched from master 
// merge should result in zero not matched from using
// because not all registered operators owned operating gas wells in 2012
merge 1:m operator_no using 10-gasProdDisp_20161117
drop if _merge == 1
if _merge == 2 {
	display as error "error: some gas production and disposition data not matched to an organization"
	exit
}
drop _merge
label data "2012 Gas Production, Disposition, and Organization Data"
save 12-gasPDwOrgInfo_20161117
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Print summary statistics of gas operator org types 				*/
/********-*********-*********-*********-*********-*********-*********/
// summarize all gas well operator types
use 12-gasPDwOrgInfo_20161117
keep wellID operatorType
duplicates drop
tab operatorType
clear
// summarize venting and flaring gas well operator types
use 12-gasPDwOrgInfo_20161117
keep if lease_gas_dispcd04_vol > 0
keep wellID operatorType 
tab operatorType
clear
// summarize all gas well operators operator types
use 12-gasPDwOrgInfo_20161117
keep operator_no operatorType
duplicates drop
tab operatorType
clear
//
// summarize venting and flaring gas well operators operator types
use 12-gasPDwOrgInfo_20161117
keep if lease_gas_dispcd04_vol > 0
keep operator_no operatorType
duplicates drop
tab operatorType
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge oil production and dispostion data with the company info	*/
/********-*********-*********-*********-*********-*********-*********/
use 12-orf850infoCoded_20161117
// merge should result is  some not matched from master 
// merge should result in zero not matched from using
// because not all registered operators owned oil leases that produced in 2012
merge 1:m operator_no using 10-oilProdDisp_20161117
drop if _merge == 1
if _merge == 2 {
	display as error "error: some gas production and disposition data not matched to an organization"
	exit
}
drop _merge
label data "2012 Oil Production, Disposition, and Organization Data"
save 12-oilPDwOrgInfo_20161117
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Print summary statistics of oil operator org types 				*/
/********-*********-*********-*********-*********-*********-*********/
// summarize all oil leases operator types
use 12-oilPDwOrgInfo_20161117
keep wellID operatorType
duplicates drop
tab operatorType
clear
//
// summarize venting and flaring oil leases operator types
use 12-oilPDwOrgInfo_20161117
keep if lease_csgd_dispcde04_vol > 0 
keep wellID operatorType 
tab operatorType
clear
// summarize all oil lease operators operator types
use 12-oilPDwOrgInfo_20161117
keep operator_no operatorType
duplicates drop
tab operatorType
clear
//
// summarize venting and flaring oil lease operators operator types
use 12-oilPDwOrgInfo_20161117
keep if lease_csgd_dispcde04_vol > 0 
keep operator_no operatorType
duplicates drop
tab operatorType
clear