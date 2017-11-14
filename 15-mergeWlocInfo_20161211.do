cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 15-mergeWlocInfo_20161211, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
// program:		15-mergeWlocInfo_20161211.do
// task:		clean daf802daroot data
//				clean daf802dapermit data
//				clear daf802daw999a1 data
//				merge necessary dbf900 data segments
//				merge oil pd and orgInfo with wellbore info
//				merge gas pd and orgInfo with wellbore info
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 12/11/2016
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
//
/********-*********-*********-*********-*********-*********-*********/
/* clean daf802daroot (03-daf802daroot_20160824) data				*/
/********-*********-*********-*********-*********-*********-*********/
use 03-daf802daroot_20160824
notes: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_STATUS_NUMBER w1Ap_no
label variable w1Ap_no "permit application number"
notes w1Ap_no: "A seven digit number assigned to each w-1 application received at the RRC"
notes w1Ap_no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes w1Ap_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_STATUS_SEQUENCE_NUMBER w1ApAmend_no
label variable w1ApAmend_no "permit application amendment number"
notes w1ApAmend_no: "A two digit number for each amendment to a drilling permit or application"
notes w1ApAmend_no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes w1ApAmend_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_COUNTY_CODE county_code
label variable county_code "county code"
notes county_code: "County code assigned by the TXRRC"
notes county_code: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes county_code: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_LEASE_NAME lease_name
label variable lease_name "lease name"
notes lease_name: "Lease name as it was reported by the operator on the drilling permit application"
notes lease_name: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes lease_name: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_DISTRICT district_no
label variable district_no "district number"
notes district_no: "Two digit district number where drilling is to take place"
notes district_no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes district_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_OPERATOR_NUMBER drillOp_no
label variable drillOp_no "operator number"
notes drillOp_no: "Operator number, as reported on the drilling form"
notes drillOp_no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes drillOp_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_CONVERTED_DATE permitRcvd_date
label variable permitRcvd_date "date permit application was received"
notes permitRcvd_date: "The date the w-1 application was received in austin"
notes permitRcvd_date: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes permitRcvd_date: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_DATE_APP_RECEIVED permitRcvdL_date
label variable permitRcvdL_date "date permit application was received in long format"
notes permitRcvdL_date: "The date the w-1 application "
notes permitRcvdL_date: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes permitRcvdL_date: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_OPERATOR_NAME drillOp_name
label variable drillOp_name "operator name"
notes drillOp_name: "Operator name, as reported on the drilling form"
notes drillOp_name: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes drillOp_name: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_HB1407_PROBLEM_FLAG hb1407_flag
label variable hb1407_flag "house bill 1407 problem flag"
notes hb1407_flag: "House Bill 1407 on water waste problem flag"
notes hb1407_flag: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes hb1407_flag: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_STATUS_OF_APP_FLAG apStatus
label variable apStatus "application status"
notes apStatus: "Status of the application, p-pending, a-approved, w-withdawn, d-dismissed, e-denied, c-closed, o-other"
notes apStatus: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes apStatus: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PROBLEM_FLAG drillPermitProblem_flag
label variable drillPermitProblem_flag "drilling permit problem flag"
notes drillPermitProblem_flag: "Drilling permit problem flag"
notes drillPermitProblem_flag: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes drillPermitProblem_flag: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_TOO_MUCH_MONEY_FLAG permitOverPay
label variable permitOverPay "drilling permit over paid"
notes permitOverPay: "y- indicates that too much money was received with the application, r-the problem has been resolved, n-not applicable"
notes permitOverPay: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes permitOverPay: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_P5_PROBLEM_FLAG invalidP5no
label variable invalidP5no "invalid P5 number"
notes invalidP5no: "y- invalid P-5 number, r- resolved problem"
notes invalidP5no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes invalidP5no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_P12_PROBLEM_FLAG p12Problem_flag
label variable p12Problem_flag "certificate of pooling authority problem"
notes p12Problem_flag: "y- problem with pooling authority certificate, r- resolved problem"
notes p12Problem_flag: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes p12Problem_flag: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PLAT_PROBLEM_FLAG platProblem
label variable platProblem "plat problem"
notes platProblem: "y- plat problem, r-resolved, n-not applicable"
notes platProblem: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes platProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_W1A_PROBLEM_FLAG acreageProblem
label variable acreageProblem "acreage problem"
notes acreageProblem: "y- w-1a problem, r- resolved problem, n- not applicable"
notes acreageProblem: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes acreageProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_OTHER_PROBLEM_FLAG otherPermitProblem
label variable otherPermitProblem "other problem with application"
notes otherPermitProblem: "y- application has some other problem, r- other problem resolved, n-not applicable"
notes otherPermitProblem: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes otherPermitProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RULE37_PROBLEM_FLAG spacingProblem
label variable spacingProblem "spacing problem"
notes spacingProblem: "y-rule 37 spacing problem, r-resolved, n-not applicable"
notes spacingProblem: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes spacingProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RULE38_PROBLEM_FLAG densityProblem
label variable densityProblem "density problem"
notes densityProblem: "y- rule 38 density problem, r- problem resolved, n- not applicable"
notes densityProblem: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes densityProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RULE39_PROBLEM_FLAG contiguousAcreageProblem
label variable contiguousAcreageProblem "contiguous acreage problem"
notes contiguousAcreageProblem: "y- rule 39 contiguous acreage problem, r- problem resolved, n- not applicable"
notes contiguousAcreageProblem: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes contiguousAcreageProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_NO_MONEY_FLAG noMoneyProblem
label variable noMoneyProblem "no money problem"
notes noMoneyProblem: "y- no money was received with the application, n- not applicable"
notes noMoneyProblem: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes noMoneyProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT permit
label variable permit "permit number assigned by the rrc"
notes permit: "Number assigned by the rrc when the drilling application was approved"
notes permit: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes permit: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_ISSUE_DATE permitIssueDate
label variable permitIssueDate "permit issue date"
notes permitIssueDate: "Permit issue date in ccyymmdd format"
notes permitIssueDate: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes permitIssueDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_WITHDRAWN_DATE withdrawnDate
label variable withdrawnDate "application withdrawn date"
notes withdrawnDate: "the date the application was withdrawn in ccyymmdd format"
notes withdrawnDate: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes withdrawnDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_WALKTHROUGH_FLAG apReceiptType
label variable apReceiptType "if application was brought into the autin office personally"
notes apReceiptType: "Whether the application was brought into the autin office personally or if it was mailed"
notes apReceiptType: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes apReceiptType: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_OTHER_PROBLEM_TEXT otherProblemType
label variable otherProblemType "other problem type"
notes otherProblemType: "Description of other drilling permit application problem"
notes otherProblemType: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes otherProblemType: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_WELL_NUMBER well_no
label variable well_no "Well number"
notes well_no: "Well number reported by the operator on the application. The well number is assigned by the operator and generally is not changed when the well is worked over"
notes well_no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes well_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_BUILT_FROM_OLD_MASTER_FLAG oldMasterData
label variable oldMasterData "built from the old drilling permit master file"
notes oldMasterData: "Indicates whether the status record was built from the old drilling permit master file"
notes oldMasterData: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes oldMasterData: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_STATUS_RENUMBERED_TO apNew_no
label variable apNew_no "application renumbered to"
notes apNew_no: "Permit number of an application whose status number was unable to be assigned as the permit number in the new system"
notes apNew_no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes apNew_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_STATUS_RENUMBERED_FROM apOld_no
label variable apOld_no "application renumbered from"
notes apOld_no: "Staatus number of an application whose status number was unable to be assigned as the permit number in the new system"
notes apOld_no: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes apOld_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_APPLICATION_RETURNED_FLAG apReturnedFlag
label variable apReturnedFlag "application returned flag"
notes apReturnedFlag: "Money problem led to application return"
notes apReturnedFlag: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes apReturnedFlag: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_ECAP_FILING_FLAG apEscapeFilingFlag
label variable apEscapeFilingFlag "application escaped filing flag"
notes apEscapeFilingFlag: "Application escaped filing flag"
notes apEscapeFilingFlag: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes apEscapeFilingFlag: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
label variable id "daf802 hierarchical data table connecting identifier"
notes id: "the unique id given to connect hierarchical data seperated into the different daf802 tables"
notes id: "Drilling permit master plus latitudes and longitudes root segment transformed from daf802_II.dat to 03-daf802daroot_20160824.dta in 03-extract_daf802_20160824.do"
notes id: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
save 15-daf802daroot-clean_20161211
cd ..
cd Working
save 15-daf802daroot-clean_20161211
cd ..
cd Posted
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* clean daf802dapermit (03-daf802dapermit_20160824) data			*/
/********-*********-*********-*********-*********-*********-*********/
use 03-daf802dapermit_20160824
notes: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_NUMBER permit_no
label variable permit_no "drilling permit number"
notes permit_no: "Drilling permit number"
notes permit_no: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permit_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_SEQUENCE_NUMBER permitAmendNo
label variable permitAmendNo "permit amendment number"
notes permitAmendNo: "Permit amendment number"
notes permitAmendNo: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitAmendNo: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_COUNTY_CODE county_code
label variable county_code "county code"
notes county_code: "County code"
notes county_code: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes county_code: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_LEASE_NAME lease_name
label variable lease_name "lease name"
notes lease_name: "Lease number"
notes lease_name: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes lease_name: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_DISTRICT district_no
label variable district_no "district number"
notes district_no: "District number"
notes district_no: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes district_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_WELL_NUMBER well_no
label variable well_no "well number"
notes well_no: "Well number"
notes well_no: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes well_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_TOTAL_DEPTH wellDepth
label variable wellDepth "well depth"
notes wellDepth: "Well depth"
notes wellDepth: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes wellDepth: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_OPERATOR_NUMBER operator_no
label variable operator_no "operator number"
notes operator_no: "Operator number"
notes operator_no: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes operator_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_TYPE_APPLICATION apType
label variable apType "application type"
notes apType: "Application type; see codebook II.21 for more details"
notes apType: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes apType: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_OTHER_EXPLANATION apType_otherDesc
label variable apType_otherDesc "description of other application type"
notes apType_otherDesc: "Description of the other application type"
notes apType_otherDesc: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes apType_otherDesc: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_ADDRESS_UNIQUE_NUMBER adInCode
label variable adInCode "internal address retrieval code"
notes adInCode: "Internal RRC code used to retrieve the operators address from the p-5 system"
notes adInCode: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes adInCode: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_ZIP_CODE op_zip
label variable op_zip "operator zip code"
notes op_zip: "First five digits of the zip code for the operator"
notes op_zip: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes op_zip: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_FICHE_SET_NUMBER fiche_no
label variable fiche_no "microfiche number"
notes fiche_no: "Page of microfice on which this permit is printed"
notes fiche_no: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes fiche_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_ONSHORE_COUNTY onshore_county_code
label variable onshore_county_code "onshore county code"
notes onshore_county_code: "Three digit county code which indicates the corresponding onshore county"
notes onshore_county_code: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes onshore_county_code: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RECEIVED_DATE permitRcvd_date
label variable permitRcvd_date "date application received"
notes permitRcvd_date: "Date application was received by the austin RRC office"
notes permitRcvd_date: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitRcvd_date: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_ISSUED_DATE permitIssueDate
label variable permitIssueDate "date permit issued"
notes permitIssueDate: "Date permit issued in CCYYMMDD format"
notes permitIssueDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitIssueDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_AMENDED_DATE permitAmendDate
label variable permitAmendDate "date permit was amended"
notes permitAmendDate: "Date permit was amended in CCYYMMDD format"
notes permitAmendDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitAmendDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_EXTENDED_DATE permitExtendDate
label variable permitExtendDate "date permit was extended"
notes permitExtendDate: "Date permit was extended in CCYYMMDD format"
notes permitExtendDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitExtendDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_SPUD_DATE spudDate
label variable spudDate "date drilling started"
notes spudDate: "Date drilling started in CCYYMMDD format" 
notes spudDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes spudDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_SURFACE_CASING_DATE surfaceCasingDate
label variable surfaceCasingDate "date surface casing was set"
notes surfaceCasingDate: "Date the surface casing was set in the well in CCYYMMDD format"
notes surfaceCasingDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfaceCasingDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_WELL_STATUS wellStatus
label variable wellStatus "well status code"
notes wellStatus: "Status of well, se ApplendixB for meanings"
notes wellStatus: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes wellStatus: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_WELL_STATUS_DATE wellStatusDate
label variable wellStatusDate "well status date"
notes wellStatusDate: "Date of well status in CCYYMMDD format"
notes wellStatusDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes wellStatusDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_EXPIRED_DATE expireDate
label variable expireDate "date permit expires"
notes expireDate: "Date permit expires in CCYYMMDD format"
notes expireDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes expireDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_CANCELLED_DATE permitCancelDate
label variable permitCancelDate "date permit was canceled"
notes permitCancelDate: "Date the permit was cancelled in CCYYMMDD format"
notes permitCancelDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitCancelDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_CANCELLATION_REASON cancelReason
label variable cancelReason "reason for permit canceled"
notes cancelReason: "Reason the permit was cancelled"
notes cancelReason: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes cancelReason: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_P12_FILED_FLAG pooled
label variable pooled "certificate of pooling authority filed"
notes pooled:  "Certificate of pooling authority filed"
notes pooled: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes pooled: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SUBSTANDARD_ACREAGE_FLAG acreageProblem
label variable acreageProblem "acreage problem"
notes acreageProblem: "Permit with substandard acreage"
notes acreageProblem: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes acreageProblem: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RULE_36_FLAG hydrogenSulfideGasFlag
label variable hydrogenSulfideGasFlag "well expected to produce significant quanties of hydrogen sulfide gas"
notes hydrogenSulfideGasFlag: "Indicates whether a well is expected to produce significant quantities of hydrogen sulfide gas"
notes hydrogenSulfideGasFlag: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes hydrogenSulfideGasFlag: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_H9_FLAG h9compliance
label variable h9compliance "certificate of compliance to rule 36"
notes h9compliance: "Indicates whether form h-9 certificate of compliance rule 36, was filed"
notes h9compliance: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes h9compliance: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RULE_37_CASE_NUMBER wellSpacingCaseNo
label variable wellSpacingCaseNo "case number for statewide rule 37 exception appliation"
notes wellSpacingCaseNo: "Case number for a hearing for an exception to statewide rule 37 regarding spacing of wells"
notes wellSpacingCaseNo: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes wellSpacingCaseNo: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RULE_38_DOCKET_NUMBER drillingDensityDocketNo
label variable drillingDensityDocketNo "drilling density docket number"
notes drillingDensityDocketNo: "Docket number for a hearing for an exception to statewide rule 38 regarding drilling density"
notes drillingDensityDocketNo: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes drillingDensityDocketNo: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_LOCATION_FORMATION_FLAG surfHoleLocStorageType
label variable surfHoleLocStorageType "surface hole location storage type"
notes surfHoleLocStorageType: "o-old location forat, n-new storage format"
notes surfHoleLocStorageType: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfHoleLocStorageType: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_OLD_LOCATION oldHoleLoc
label variable oldHoleLoc "old surface location"
notes oldHoleLoc: "Suface loation of the hole (section, block, survey, and abstract) in the old location format"
notes oldHoleLoc: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes oldHoleLoc: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_ACRES lease_acres
label variable lease_acres "lease acres"
notes lease_acres: "umber of acres in the lease"
notes lease_acres: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes lease_acres: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_MILES_FROM_CITY miles2town
label variable miles2town "miles to the nearest town"
notes miles2town: "Number of miles to the nearest town"
notes miles2town: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes miles2town: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_DIRECTION_FROM_CITY dir2town
label variable dir2town "direction to the nearest town"
notes dir2town:  "direction to the nearest town"
notes dir2town: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes dir2town: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_NEAREST_CITY nearCity
label variable nearCity "name of nearest city"
notes nearCity: "Name of the nearest city"
notes nearCity: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes nearCity: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_LEASE_FEET_1 surfLeaseDist1
label variable surfLeaseDist1 "distance from drilling operation and lease line"
notes surfLeaseDist1: "Distance in feet from the drilling operation to the lease line"
notes surfLeaseDist1: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfLeaseDist1: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_LEASE_DIRECTION_1 surfLeaseDir1
label variable surfLeaseDir1 "direction from drilling operation and lease line"
notes surfLeaseDir1: "Direction from the drilling operation to the lease line"
notes surfLeaseDir1: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfLeaseDir1: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_LEASE_FEET_2 surfLeaseDist2
label variable surfLeaseDist2 "distance from drilling operation and lease line"
notes surfLeaseDist2: "Distance in feet from the drilling operation to the lease line"
notes surfLeaseDist2: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfLeaseDist2: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_LEASE_DIRECTION_2 surfLeaseDir2
label variable surfLeaseDir2 "direction from drilling operation and lease line"
notes surfLeaseDir2: "Direction from the drilling operation to the lease line"
notes surfLeaseDir2: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfLeaseDir2: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_SURVEY_FEET_1 surfSurveyDist1
label variable surfSurveyDist1 "distance in feet from the drilling operation to the survey line"
notes surfSurveyDist1: "Distance in feet from the drilling operation to the survey line"
notes surfSurveyDist1: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfSurveyDist1: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_SURVEY_DIRECTION_1 surfSurveyDir1
label variable surfSurveyDir1 "direction from the drilling operation and survey line"
notes surfSurveyDir1: "Direction from the drilling operation and survey line"
notes surfSurveyDir1: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfSurveyDir1: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_SURVEY_FEET_2 surfSurveyDist2
label variable surfSurveyDist2 "distance in feet from the drilling operation to the survey line"
notes surfSurveyDist2: "Distance in feet from the drilling operation to the survey line"
notes surfSurveyDist2: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfSurveyDist2: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURFACE_SURVEY_DIRECTION_2 surfSurveyDir2
label variable surfSurveyDir2 "direction from the drilling operation and survey line"
notes surfSurveyDir2: "Direction from the drilling operation and survey line"
notes surfSurveyDir2: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes surfSurveyDir2: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_NEAREST_WELL nearestWellOldFmt
label variable nearestWellOldFmt "distance and direction of the nearest well"
notes nearestWellOldFmt: "Distance and direction of the nearest well"
notes nearestWellOldFmt: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes nearestWellOldFmt: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_NEAREST_WELL_FORMAT_FLAG nearestWellFmt
label variable nearestWellFmt "nearest well format"
notes : "Nearest well format, o-old, n-new"
notes : "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes : "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_FINAL_UPDATE permitValidatedDate
label variable permitValidatedDate "date permit was validated"
notes permitValidatedDate: "date permit was validated in CCYYMMDD format"
notes permitValidatedDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitValidatedDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_CANCELLED_FLAG cancelFlag
label variable cancelFlag "permit cancelled"
notes cancelFlag: "Whether the permit or a filing was cancelled p-permit cancelled, f-filing cancelled"
notes cancelFlag: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes cancelFlag: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SPUD_IN_FLAG spudDateExists 
label variable spudDateExists "spud in date exists for this application or permit"
notes spudDateExists: "Indicates whether the spud in date exists for this application or permit"
notes spudDateExists: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes spudDateExists: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_DIRECTIONAL_WELL_FLAG directionalWell
label variable directionalWell "directional well"
notes directionalWell: "Indicates whether the well is a directional well. y- yes, n-no"
notes directionalWell: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes directionalWell: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SIDETRACK_WELL_FLAG sidetrackWell
label variable sidetrackWell "sidetrack well"
notes sidetrackWell: "Indicates whether the well is a sidetrack well. y-yes, n-no"
notes sidetrackWell: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes sidetrackWell: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_MOVED_INDICATOR wrongRoot
label variable wrongRoot "associated with the wrong root segment"
notes wrongRoot: "Indicates whether a permit record has been associated with the wrong root segment and will me changed."
notes wrongRoot: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes wrongRoot: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_PERMIT_CONV_ISSUED_DATE permitIssuedDate
label variable permitIssuedDate "permit issued date"
notes permitIssuedDate: "Date permit issued in CCYYMMDD format"
notes permitIssuedDate: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes permitIssuedDate: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_RULE_37_GRANTED_CODE rule37permitGranted
label variable rule37permitGranted "rule 37 permit granted"
notes rule37permitGranted: "Indicates under which rule the permit is granted, a-granded understadwide rule 37(h)(2)(a), b-granded under statewide rule 37(h)(2)(b)"
notes rule37permitGranted: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes rule37permitGranted: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_HORIZONTAL_WELL_FLAG horizontalWell
label variable horizontalWell "horizontal well"
notes horizontalWell: "Indicates whether the well is a horizontal well. y-yes, n or 0- no"
notes horizontalWell: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes horizontalWell: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_DUPLICATE_PERMIT_FLAG duplicatePermit
label variable duplicatePermit "duplicate permit"
notes duplicatePermit: "Indicates whether the permit is a duplicate of a previously issued permit"
notes duplicatePermit: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes duplicatePermit: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_NEAREST_LEASE_LINE nearestLeaseLine
label variable nearestLeaseLine "distance to nearest lease line"
notes nearestLeaseLine: "Distance in feet to nearest lease line"
notes nearestLeaseLine: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes nearestLeaseLine: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename API_NUMBER api_no
label variable api_no "api number"
notes api_no: "API Number"
notes api_no: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes api_no: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
label variable id "daf802 hierarchical data table connecting identifier"
notes id: "the unique id given to connect hierarchical data seperated into the different daf802 tables"
notes id: "Drilling permit master plus latitudes and longitudes permit segment transformed from daf802_II.dat to 03-daf802dapermit_20160824.dta in 03-extract_daf802_20160824.do"
notes id: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
save 15-daf802dapermit-clean_20161211
cd ..
cd Working
save 15-daf802dapermit-clean_20161211
cd ..
cd Posted
clear
//
//
/********-*********-*********-*********-*********-*********-*********/
/* clean daf802daw999a1 (03-daf802daw999a1_20160824) data			*/
/********-*********-*********-*********-*********-*********-*********/
use 03-daf802daw999a1_20160824
notes: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURF_LOC_LONGITUDE longitude
label variable longitude "Wellbore surface location longitude NAD27"
notes longitude: "Wellbore surface location longitude coordinate referenced to NAD27"
notes longitude: "Drilling permit master plus latitudes and longitudes surface location segment transformed from daf802_II.dat to 03-daf802daw999a1_20160824.dta in 03-extract_daf802_20160824.do"
notes longitude: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
rename DA_SURF_LOC_LATITUDE latitude
label variable latitude "Wellbore surface location latitude NAD27"
notes latitude: "Wellbore surface location latitude coordinate referenced to NAD27"
notes latitude: "Drilling permit master plus latitudes and longitudes surface location segment transformed from daf802_II.dat to 03-daf802daw999a1_20160824.dta in 03-extract_daf802_20160824.do"
notes latitude: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
label variable id "daf802 hierarchical data table connecting identifier"
notes id: "the unique id given to connect hierarchical data seperated into the different daf802 tables"
notes id: "Drilling permit master plus latitudes and longitudes surface location segment transformed from daf802_II.dat to 03-daf802daw999a1_20160824.dta in 03-extract_daf802_20160824.do"
notes id: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
save 15-daf802daw999a1-clean_20161211
cd ..
cd Working
save 15-daf802daw999a1-clean_20161211
cd ..
cd Posted
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge necessary daf802 data segments	and prepare for other merge	*/
/********-*********-*********-*********-*********-*********-*********/
cd ..
cd Working
use 15-daf802dapermit-clean_20161211
keep api_no id wellDepth spudDate horizontalWell
merge 1:1 id using 15-daf802daw999a1-clean_20161211
drop if _merge == 1
drop _merge id
duplicates drop
bysort api_no (wellDepth): keep if _n==_N
save daf802dapermit2merge
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge oil data with loc data										*/
/********-*********-*********-*********-*********-*********-*********/
clear
cd ..
cd Posted
use 14-oilPDorgVioWwb_20161211
cd ..
cd Working
// merge should result in some not matched from using
// merge should result in all matched from master
merge m:1 api_no using daf802dapermit2merge
gen noLocMatch = .
replace noLocMatch = 1 if _merge == 1
replace noLocMatch = 0 if _merge == 3
drop if _merge == 2  
drop _merge
label variable noLocMatch "oilPDorgWwb not matched with daf802 long/lat data"
notes noLocMatch: "Data NOT merged with daf802 long/lat data using API"
notes noLocMatch: "Created from merged daf802dapermit and daf802daw999a1 in 14-mergeWlocInfo_20161117"
notes noLocMatch: "Drilling permit master plus latitudes and longitudes surface location segment transformed from daf802_II.dat to 03-daf802daw999a1_20160824.dta in 03-extract_daf802_20160824.do"
notes noLocMatch: "Original drilling permit master data source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes noLocMatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20160824.dta in 02-extract_dbf990_20160824.do"
notes noLocMatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20160824.dta in 02-extract_dbf990_20160824.do"
notes noLocMatch: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes noLocMatch: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes noLocMatch: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20160824.dta in 04-extract_orf850_20160824.do"
notes noLocMatch: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes noLocMatch: "Production and disposition data merged creating 10-oilProdDisp_20161101 from 07-production_20160824.dta and 07-disposition_20160824.dta in 10-manageProductionDisposition_20161101.do"
notes noLocMatch: "Disposition data transformed from s6leaseCycleDisp12_20160824.csv to 07-disposition_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes noLocMatch: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes noLocMatch: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes noLocMatch: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes noLocMatch: "Production data transformed from s6leaseCycle12_20160824.csv to 07-production_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes noLocMatch: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes noLocMatch: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes noLocMatch: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
tab noLocMatch
save 15-oilPDorgVioWLoc_20161211
cd ..
cd Posted
save 15-oilPDorgVioWLoc_20161211
cd ..
cd Working
keep if noWBmatch == 1
save 15-oilPDorgVioWOLoc_20161211
cd ..
cd Posted
save 15-oilPDorgVioWOLoc_20161211
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge gas data with loc data										*/
/********-*********-*********-*********-*********-*********-*********/
clear
cd ..
cd Posted
use 14-gasPDorgVioWwb_20161211
cd ..
cd Working
// merge should result in some not matched from using
// merge should result in all matched from master
merge m:1 api_no using daf802dapermit2merge
gen noLocMatch = .
replace noLocMatch = 1 if _merge == 1
replace noLocMatch = 0 if _merge == 3
drop if _merge == 2  
drop _merge
label variable noLocMatch "gasPDorgWwb not matched with daf802 long/lat data"
notes noLocMatch: "Data NOT merged with daf802 long/lat data using API"
notes noLocMatch: "Created from merged daf802dapermit and daf802daw999a1 in 14-mergeWlocInfo_20161117"
notes noLocMatch: "Drilling permit master plus latitudes and longitudes surface location segment transformed from daf802_II.dat to 03-daf802daw999a1_20160824.dta in 03-extract_daf802_20160824.do"
notes noLocMatch: "Original drilling permit master data source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes noLocMatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20160824.dta in 02-extract_dbf990_20160824.do"
notes noLocMatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20160824.dta in 02-extract_dbf990_20160824.do"
notes noLocMatch: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes noLocMatch: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes noLocMatch: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20160824.dta in 04-extract_orf850_20160824.do"
notes noLocMatch: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes noLocMatch: "Production and disposition data merged creating 10-oilProdDisp_20161101 from 07-production_20160824.dta and 07-disposition_20160824.dta in 10-manageProductionDisposition_20161101.do"
notes noLocMatch: "Disposition data transformed from s6leaseCycleDisp12_20160824.csv to 07-disposition_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes noLocMatch: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes noLocMatch: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes noLocMatch: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes noLocMatch: "Production data transformed from s6leaseCycle12_20160824.csv to 07-production_20160824.dta in 07-extract_productionDisposition12_20160824.do"
notes noLocMatch: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20160824.sas"
notes noLocMatch: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20160824"
notes noLocMatch: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
tab noLocMatch
save 15-gasPDorgVioWLoc_20161211
cd ..
cd Posted
save 15-gasPDorgVioWLoc_20161211
cd ..
cd Working
keep if noWBmatch == 1
save 15-gasPDorgVioWOLoc_20161211
cd ..
cd Posted
save 15-gasPDorgVioWOLoc_20161211
clear
//