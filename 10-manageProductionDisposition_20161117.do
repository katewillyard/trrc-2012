cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 10-manageProductionDisposition_20161117, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
// program:		10-manageProductionDisposition_20161117.do
// task:		Create disposion variables for if the well/lease changes operators within the year, number of changes, number of months reported for each well/lease, and number of months reported for each unique well/lease operator
//				Create disposition records for each unique well/lease operator for entire year
//				Create production variables for if the well/lease changes operators within the year, number of changes, number of months reported for each well/lease, and number of months reported for each unique well/lease operator
//				Create production records for each unique well/lease operator for entire year
//				Merge production and disposition
//				Find any records where production is less than disposition
//				Make percent gas well gas flared variable
//				Make percent casinghead gas flared variable
//				Create separate oil and gas production and disposition files
//				Check no production or disposition data was dropped
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
/* Creae new variables for disposition file							*/
/********-*********-*********-*********-*********-*********-*********/
use 07-disposition_20160824
cd ..
cd Working
gen fieldNoStr = field_no
tostring fieldNoStr, replace
gen wellID = oil_gas_code + string(district_no) + fieldNoStr + /// 
	string(lease_no)
label variable wellID "Unique Well Number"
note wellID: "(Oil Gas Code + District + Field + Lease)"
gen n = 1
egen wellmonthsDisp = total(n), by (wellID)
label variable wellmonthsDisp "months disposition reported"
note wellmonthsDisp: "Number of months disposition reported for each well/lease"
gen wellOP = oil_gas_code + string(district_no) + fieldNoStr + ///
	string(lease_no) + string(operator_no)
label variable wellOP "Unique Well-Operator Number"
note wellOP: "(Oil Gas Code + District + Field + Lease + Operator)"
egen wellOPmonthsDisp = total(n), by (wellOP)
label variable wellOPmonthsDisp "months operator disposition reported"
note wellOPmonthsDisp: "Number of months disposition reported for each	unique well/lease by operator"
gen changeOPdisp = .
label variable changeOPdisp "Changed operators in disposition record"
note changeOPdisp: "Wells/Leases that changed operators in 2012 according to disposition report"
replace changeOPdisp = 0 if wellmonthsDisp == wellOPmonthsDisp
replace changeOPdisp = 1 if wellmonthsDisp != wellOPmonthsDisp
egen tag = tag(wellOP wellID)
egen distinct = total(tag), by(wellID)
gen nOPchangesDisp = distinct - 1
label variable nOPchangesDisp "Number of operator changes in disposition report"
note nOPchangesDisp: "Number of times the well/lease changed owners in 2012 according to disposition report"
// verify all wells that have multiple operators are correctly identified
// after running test, if all are not equal to one, some are not correctly identified
gen test = .
replace test = 1 if changeOPdisp == 1 & nOPchangesDisp > 0
replace test = 1 if changeOPdisp == 0 & nOPchangesDisp ==0
sum test
drop test n tag distinct fieldNoStr
label variable lease_oil_dispcd00_vol "lease-month oil pipeline disposal"
note lease_oil_dispcd00_vol: "Lease month total crude oil (in barrels) disposed by pipeline"
label variable lease_oil_dispcd01_vol "lease-month oil truck disposal"
note lease_oil_dispcd01_vol: "Lease month total crude oil (in barrels) disposed by truck"
label variable lease_oil_dispcd02_vol "lease-month oil tank disposal"
note lease_oil_dispcd02_vol: "Lease month total crude oil (in barrels) disposed by tank car or barge"
label variable lease_oil_dispcd03_vol "lease-month oil tank cleaning disposal"
note lease_oil_dispcd03_vol: "Lease month total crude oil (in barrels) disposed by tank cleaning (an adjustment to and/or lease use of production already measured by the operator."
label variable lease_oil_dispcd04_vol "lease-month oil disposal for frac liquid on other lease" 
note lease_oil_dispcd04_vol: "Lease month total crude oil (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
label variable lease_oil_dispcd05_vol "lease-month oil disposal from spill"
note lease_oil_dispcd05_vol: "Lease month total crude oil (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
label variable lease_oil_dispcd06_vol "lease-month oil disposal from basic sediment loss"
note lease_oil_dispcd06_vol: "Lease month total crude oil (in barrels) lost due to tank cleaning, basic sediment and water."
label variable lease_oil_dispcd07_vol "lease-month oil disposal from water bleed-off, lease use, road oil, or theft"
note lease_oil_dispcd07_vol: "Lease month total crude oil (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
label variable lease_oil_dispcd08_vol "lease-month oil disposal from saltwater gathering system"
note lease_oil_dispcd08_vol: "Lease month total crude oil (in barrels) indirectly disposed by others through a saltwater gathering system. "
label variable lease_oil_dispcd09_vol "lease-month oil disposal to gas processing plant"
note lease_oil_dispcd09_vol: "Lease month total crude oil (in barrels) indirectly disposed by others because it left the lease entrained in casinghead gas going to a gas processing plant."
label variable lease_oil_dispcd99_vol "lease-month oil disposal without code"
note lease_oil_dispcd99_vol: "Lease month total crude oil (in barrels) reportedly disposed without a disposition code"
label variable lease_gas_dispcd01_vol "lease-month gas field use disposal"
note lease_gas_dispcd01_vol: "Lease month total gas (in mcf) used for field operations"
label variable lease_gas_dispcd02_vol "lease-month gas transmission line disposal"
note lease_gas_dispcd02_vol: "Lease month total gas (in mcf) disposed by transmission line"
label variable lease_gas_dispcd03_vol "lease-month gas processing plant disposal"
note lease_gas_dispcd03_vol: "Lease month total gas (in mcf) disposed to a processing plant"
label variable lease_gas_dispcd04_vol "lease-month gas vented or flared"
note lease_gas_dispcd04_vol: "Lease month total gas (in mcf) vented or flared"
label variable lease_gas_dispcd05_vol "lease-month gas gas lift disposal"
note lease_gas_dispcd05_vol: "Lease month total gas (in mcf) used for gas lift"
label variable lease_gas_dispcd06_vol "lease-month gas pressure maintenance disposal"
note lease_gas_dispcd06_vol: "Lease month total gas (in mcf) used for repressure, or pressure maintenance."
label variable lease_gas_dispcd07_vol "lease-month gas carbon black plant disposal"
note lease_gas_dispcd07_vol: "Lease month total gas (in mcf) delivered to carbon black plant"
label variable lease_gas_dispcd08_vol "lease-month gas storage reservoir disposal"
note lease_gas_dispcd08_vol: "Lease month total gas (in mcf) injected directly into a storage reservoir"
label variable lease_gas_dispcd09_vol "lease-month gas lost due to shrinkage during separation"
note lease_gas_dispcd09_vol: "Lease month total gas (in mcf) lost due to the shrinkage of gas during lease separation methods"
label variable lease_gas_dispcd99_vol "lease-month gas diposal without code"
note lease_gas_dispcd99_vol: "Lease month total gas (in mcf) reportedly disposed without a disposition code"
label variable lease_cond_dispcd00_vol "lease-month condensate pipeline disposal"
note lease_cond_dispcd00_vol: "Lease month total gas condensate (in barrels) disposed by pipeline"
label variable lease_cond_dispcd01_vol "lease-month condensate truck disposal"
note lease_cond_dispcd01_vol: "Lease month total gas condensate (in barrels) disposed by truck"
label variable lease_cond_dispcd02_vol "lease-month condensate tank car disposal"
note lease_cond_dispcd02_vol: "Lease month total gas condensate (in barrels) disposed by tank car or barge"
label variable lease_cond_dispcd03_vol "lease-month condensate tank cleaning disposal"
note lease_cond_dispcd03_vol: "Lease month total gas condensate (in barrels) disposed by tank cleaning (an adjustment to and/or lease use of production already measured by the operator."
label variable lease_cond_dispcd04_vol "lease-month condensate disposal for frac liquid on other lease"
note lease_cond_dispcd04_vol: "Lease month total gas condensate (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
label variable lease_cond_dispcd05_vol "lease-month condensate disposal from spill"
note lease_cond_dispcd05_vol: "Lease month total gas condensate (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
label variable lease_cond_dispcd06_vol "lease-month condensate disposal from basic sediment loss"
note lease_cond_dispcd06_vol: "Lease month total gas condensate (in barrels) lost due to tank cleaning, basic sediment and water."
label variable lease_cond_dispcd07_vol "lease-month condensate disposal from water bleed-off, lease use, road oil, or theft"
note lease_cond_dispcd07_vol: "Lease month total cgas condensate (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
label variable lease_cond_dispcd08_vol "lease-month condensate disposal from saltwater gathering system"
note lease_cond_dispcd08_vol: "Lease month total gas condensate (in barrels) indirectly disposed by others through a saltwater gathering system. "
label variable lease_cond_dispcd99_vol "lease-month condensate disposal without code"
note lease_cond_dispcd99_vol: "Lease month total gas condensate (in barrels) reportedly disposed without a disposition code."
label variable lease_csgd_dispcde01_vol "lease-month casinghead field use disposal"
note lease_csgd_dispcde01_vol: "Lease month total casignhead gas (in mcf) used for field operations."
label variable lease_csgd_dispcde02_vol "lease-month casinghead transmission line disposal"
note lease_csgd_dispcde02_vol: "Lease month total casignhead gas (in mcf) disposed by transmission line"
label variable lease_csgd_dispcde03_vol "lease-month casinghead processing plant disposal"
note lease_csgd_dispcde03_vol: "Lease month total casignhead gas (in mcf) disposed to a processing plant"
label variable lease_csgd_dispcde04_vol "lease-month casinghead vented or flared"
note lease_csgd_dispcde04_vol: "Lease month total casignhead gas (in mcf) vented or flared"
label variable lease_csgd_dispcde05_vol "lease-month casinghead gas lift disposal"
note lease_csgd_dispcde05_vol: "Lease month total casignhead gas (in mcf) used for gas lift"
label variable lease_csgd_dispcde06_vol "lease-month casinghead pressure maintenance disposal"
note lease_csgd_dispcde06_vol: "Lease month total casignhead gas (in mcf) used for repressure, or pressure maintenance"
label variable lease_csgd_dispcde07_vol "lease-month casinghead carbon black plant disposal"
note lease_csgd_dispcde07_vol: "Lease month total casignhead gas (in mcf) delivered to carbon black plant"
label variable lease_csgd_dispcde08_vol "lease-month casinghead storage reservoir disposal"
note lease_csgd_dispcde08_vol: "Lease month total casignhead gas (in mcf) injected directly into a storage reservoir"
label variable lease_csgd_dispcde99_vol "lease-month casinghead disposed without code"
note lease_csgd_dispcde99_vol: "Lease month total casignhead gas (in mcf) reportedly disposed without a disposition code"
// clean data
label variable oil_gas_code "well type"
note oil_gas_code: "Code that denote Oil or Gas (O = Oil and G = Gas)"
label variable district_no "district number"
note district_no: "One of the 14 primary RRC district of permit"
label variable lease_no "lease number"
note lease_no: "RRC assinged number, uniqe within district"
label variable cycle_year "Year"
note cycle_year: "The production year in YYYY format"
label variable cycle_month "Month"
note cycle_month: "The production month in MM format"
label variable operator_no "operator number"
note operator_no: "Organization/Operator ID number assigned by the RRC"
label variable field_no "field number"
note field_no: "8 digit number assinged to a field by the field designation section of the oil and gas division at the railroad commission"
label variable cycle_year_month "Year Month"
note cycle_year_month: "The production year-month YYYYMM"
label variable district_name "district name"
note district_name: "The primary RRC district of the permit"
label variable field_name "field name"
note field_name: "A field name made up of a word chosen by the operator"
label variable operator_name "operator name"
note operator_name: "Name of the operator as filed on the RRC Organization Report"
save disposeByMonth
cd ..
cd Posted 
save 10-disposeByMonth_20161117
cd ..
cd Working
// make disposal totals to ensure data isn't lost upon collapse and merge
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
keep preMergSum_oil00 preMergSum_oil01 preMergSum_oil02 ///
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
gen n = _n
save preMergDispTotals
clear
/********-*********-*********-*********-*********-*********-*********/
/* Create records for each unique well/lease operator for each year */
/********-*********-*********-*********-*********-*********-*********/
use disposeByMonth
keep oil_gas_code district_no lease_no cycle_year operator_no ///
	field_no district_name field_name operator_name wellID wellmonthsDisp ///
	wellOP wellOPmonthsDisp changeOPdisp nOPchangesDisp
duplicates drop
sort wellOP
save constantDispWellInfo
clear
use disposeByMonth
keep wellOP lease_oil_dispcd00_vol lease_oil_dispcd01_vol ///
	lease_oil_dispcd02_vol lease_oil_dispcd03_vol ///
	lease_oil_dispcd04_vol lease_oil_dispcd05_vol ///
	lease_oil_dispcd06_vol lease_oil_dispcd07_vol ///
	lease_oil_dispcd08_vol lease_oil_dispcd09_vol ///
	lease_oil_dispcd99_vol lease_gas_dispcd01_vol ///
	lease_gas_dispcd02_vol lease_gas_dispcd03_vol ///
	lease_gas_dispcd04_vol lease_gas_dispcd05_vol ///
	lease_gas_dispcd06_vol lease_gas_dispcd07_vol ///
	lease_gas_dispcd08_vol lease_gas_dispcd09_vol ///
	lease_gas_dispcd99_vol lease_cond_dispcd00_vol ///
	lease_cond_dispcd01_vol lease_cond_dispcd02_vol ///
	lease_cond_dispcd03_vol lease_cond_dispcd04_vol ///
	lease_cond_dispcd05_vol lease_cond_dispcd06_vol ///
	lease_cond_dispcd07_vol lease_cond_dispcd08_vol ///
	lease_cond_dispcd99_vol lease_csgd_dispcde01_vol ///
	lease_csgd_dispcde02_vol lease_csgd_dispcde03_vol ///
	lease_csgd_dispcde04_vol lease_csgd_dispcde05_vol ///
	lease_csgd_dispcde06_vol lease_csgd_dispcde07_vol ///
	lease_csgd_dispcde08_vol lease_csgd_dispcde99_vol 
collapse (sum) lease_oil_dispcd00_vol lease_oil_dispcd01_vol ///
	lease_oil_dispcd02_vol lease_oil_dispcd03_vol ///
	lease_oil_dispcd04_vol lease_oil_dispcd05_vol ///
	lease_oil_dispcd06_vol lease_oil_dispcd07_vol ///
	lease_oil_dispcd08_vol lease_oil_dispcd09_vol ///
	lease_oil_dispcd99_vol lease_gas_dispcd01_vol ///
	lease_gas_dispcd02_vol lease_gas_dispcd03_vol ///
	lease_gas_dispcd04_vol lease_gas_dispcd05_vol ///
	lease_gas_dispcd06_vol lease_gas_dispcd07_vol ///
	lease_gas_dispcd08_vol lease_gas_dispcd09_vol ///
	lease_gas_dispcd99_vol lease_cond_dispcd00_vol ///
	lease_cond_dispcd01_vol lease_cond_dispcd02_vol ///
	lease_cond_dispcd03_vol lease_cond_dispcd04_vol ///
	lease_cond_dispcd05_vol lease_cond_dispcd06_vol ///
	lease_cond_dispcd07_vol lease_cond_dispcd08_vol ///
	lease_cond_dispcd99_vol lease_csgd_dispcde01_vol ///
	lease_csgd_dispcde02_vol lease_csgd_dispcde03_vol ///
	lease_csgd_dispcde04_vol lease_csgd_dispcde05_vol ///
	lease_csgd_dispcde06_vol lease_csgd_dispcde07_vol ///
	lease_csgd_dispcde08_vol lease_csgd_dispcde99_vol ///
	, by (wellOP)
label variable lease_oil_dispcd00_vol "lease-year oil pipeline disposal"
notes replace lease_oil_dispcd00_vol in 1: "Lease year total crude oil (in barrels) disposed by pipeline"
label variable lease_oil_dispcd01_vol "lease-year oil truck disposal"
notes replace lease_oil_dispcd01_vol in 1: "Lease year total crude oil (in barrels) disposed by truck"
label variable lease_oil_dispcd02_vol "lease-year oil tank disposal"
notes replace lease_oil_dispcd02_vol in 1: "Lease year total crude oil (in barrels) disposed by tank car or barge"
label variable lease_oil_dispcd03_vol "lease-year oil tank cleaning disposal"
notes replace lease_oil_dispcd03_vol in 1: "Lease year total crude oil (in barrels) disposed by tank cleaning (an adjustment to and/or lease use of production already measured by the operator."
label variable lease_oil_dispcd04_vol "lease-year oil disposal for frac liquid on other lease" 
notes replace lease_oil_dispcd04_vol in 1: "Lease year total crude oil (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
label variable lease_oil_dispcd05_vol "lease-year oil disposal from spill"
notes replace lease_oil_dispcd05_vol in 1: "Lease year total crude oil (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
label variable lease_oil_dispcd06_vol "lease-year oil disposal from basic sediment loss"
notes replace lease_oil_dispcd06_vol in 1: "Lease year total crude oil (in barrels) lost due to tank cleaning, basic sediment and water."
label variable lease_oil_dispcd07_vol "lease-year oil disposal from water bleed-off, lease use, road oil, or theft"
notes replace lease_oil_dispcd07_vol in 1: "Lease year total crude oil (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
label variable lease_oil_dispcd08_vol "lease-year oil disposal from saltwater gathering system"
notes replace lease_oil_dispcd08_vol in 1: "Lease year total crude oil (in barrels) indirectly disposed by others through a saltwater gathering system. "
label variable lease_oil_dispcd09_vol "lease-year oil disposal to gas processing plant"
notes replace lease_oil_dispcd09_vol in 1: "Lease year total crude oil (in barrels) indirectly disposed by others because it left the lease entrained in casinghead gas going to a gas processing plant."
label variable lease_oil_dispcd99_vol "lease-year oil disposal without code"
notes replace lease_oil_dispcd99_vol in 1: "Lease year total crude oil (in barrels) reportedly disposed without a disposition code"
label variable lease_gas_dispcd01_vol "lease-year gas field use disposal"
notes replace lease_gas_dispcd01_vol in 1: "Lease year total gas (in mcf) used for field operations"
label variable lease_gas_dispcd02_vol "lease-year gas transmission line disposal"
notes replace lease_gas_dispcd02_vol in 1: "Lease year total gas (in mcf) disposed by transmission line"
label variable lease_gas_dispcd03_vol "lease-year gas processing plant disposal"
notes replace lease_gas_dispcd03_vol in 1: "Lease year total gas (in mcf) disposed to a processing plant"
label variable lease_gas_dispcd04_vol "lease-year gas vented or flared"
notes replace lease_gas_dispcd04_vol in 1: "Lease year total gas (in mcf) vented or flared"
label variable lease_gas_dispcd05_vol "lease-year gas gas lift disposal"
notes replace lease_gas_dispcd05_vol in 1: "Lease year total gas (in mcf) used for gas lift"
label variable lease_gas_dispcd06_vol "lease-year gas pressure maintenance disposal"
notes replace lease_gas_dispcd06_vol in 1: "Lease year total gas (in mcf) used for repressure, or pressure maintenance."
label variable lease_gas_dispcd07_vol "lease-year gas carbon black plant disposal"
notes replace lease_gas_dispcd07_vol in 1: "Lease year total gas (in mcf) delivered to carbon black plant"
label variable lease_gas_dispcd08_vol "lease-year gas storage reservoir disposal"
notes replace lease_gas_dispcd08_vol in 1: "Lease year total gas (in mcf) injected directly into a storage reservoir"
label variable lease_gas_dispcd09_vol "lease-year gas lost due to shrinkage during separation"
notes replace lease_gas_dispcd09_vol in 1: "Lease year total gas (in mcf) lost due to the shrinkage of gas during lease separation methods"
label variable lease_gas_dispcd99_vol "lease-year gas diposal without code"
notes replace lease_gas_dispcd99_vol in 1: "Lease year total gas (in mcf) reportedly disposed without a disposition code"
label variable lease_cond_dispcd00_vol "lease-year condensate pipeline disposal"
notes replace lease_cond_dispcd00_vol in 1: "Lease year total gas condensate (in barrels) disposed by pipeline"
label variable lease_cond_dispcd01_vol "lease-year condensate truck disposal"
notes replace lease_cond_dispcd01_vol in 1: "Lease year total gas condensate (in barrels) disposed by truck"
label variable lease_cond_dispcd02_vol "lease-year condensate tank car disposal"
notes replace lease_cond_dispcd02_vol in 1: "Lease year total gas condensate (in barrels) disposed by tank car or barge"
label variable lease_cond_dispcd03_vol "lease-year condensate tank cleaning disposal"
notes replace lease_cond_dispcd03_vol in 1: "Lease year total gas condensate (in barrels) disposed by tank cleaning (an adjustment to and/or lease use of production already measured by the operator."
label variable lease_cond_dispcd04_vol "lease-year condensate disposal for frac liquid on other lease"
notes replace lease_cond_dispcd04_vol in 1: "Lease year total gas condensate (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
label variable lease_cond_dispcd05_vol "lease-year condensate disposal from spill"
notes replace lease_cond_dispcd05_vol in 1: "Lease year total gas condensate (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
label variable lease_cond_dispcd06_vol "lease-year condensate disposal from basic sediment loss"
notes replace lease_cond_dispcd06_vol in 1: "Lease year total gas condensate (in barrels) lost due to tank cleaning, basic sediment and water."
label variable lease_cond_dispcd07_vol "lease-year condensate disposal from water bleed-off, lease use, road oil, or theft"
notes replace lease_cond_dispcd07_vol in 1: "Lease year total cgas condensate (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
label variable lease_cond_dispcd08_vol "lease-year condensate disposal from saltwater gathering system"
notes replace lease_cond_dispcd08_vol in 1: "Lease year total gas condensate (in barrels) indirectly disposed by others through a saltwater gathering system. "
label variable lease_cond_dispcd99_vol "lease-year condensate disposal without code"
notes replace lease_cond_dispcd99_vol in 1: "Lease year total gas condensate (in barrels) reportedly disposed without a disposition code."
label variable lease_csgd_dispcde01_vol "lease-year casinghead field use disposal"
notes replace lease_csgd_dispcde01_vol in 1: "Lease year total casignhead gas (in mcf) used for field operations."
label variable lease_csgd_dispcde02_vol "lease-year casinghead transmission line disposal"
notes replace lease_csgd_dispcde02_vol in 1: "Lease year total casignhead gas (in mcf) disposed by transmission line"
label variable lease_csgd_dispcde03_vol "lease-year casinghead processing plant disposal"
notes replace lease_csgd_dispcde03_vol in 1: "Lease year total casignhead gas (in mcf) disposed to a processing plant"
label variable lease_csgd_dispcde04_vol "lease-year casinghead vented or flared"
notes replace lease_csgd_dispcde04_vol in 1: "Lease year total casignhead gas (in mcf) vented or flared"
label variable lease_csgd_dispcde05_vol "lease-year casinghead gas lift disposal"
notes replace lease_csgd_dispcde05_vol in 1: "Lease year total casignhead gas (in mcf) used for gas lift"
label variable lease_csgd_dispcde06_vol "lease-year casinghead pressure maintenance disposal"
notes replace lease_csgd_dispcde06_vol in 1: "Lease year total casignhead gas (in mcf) used for repressure, or pressure maintenance"
label variable lease_csgd_dispcde07_vol "lease-year casinghead carbon black plant disposal"
notes replace lease_csgd_dispcde07_vol in 1: "Lease year total casignhead gas (in mcf) delivered to carbon black plant"
label variable lease_csgd_dispcde08_vol "lease-year casinghead storage reservoir disposal"
notes replace lease_csgd_dispcde08_vol in 1: "Lease year total casignhead gas (in mcf) injected directly into a storage reservoir"
label variable lease_csgd_dispcde99_vol "lease-year casinghead disposed without code"
notes replace lease_csgd_dispcde99_vol in 1: "Lease year total casignhead gas (in mcf) reportedly disposed without a disposition code"
// merge, all should be matched, or error occured
merge 1:1 wellOP using constantDispWellInfo
drop _merge
save wellDisposition
clear
/********-*********-*********-*********-*********-*********-*********/
/* Create new variables for production file							*/
/********-*********-*********-*********-*********-*********-*********/
cd ..
cd Posted
use 07-production_20160824
cd ..
cd Working
gen fieldNoStr = field_no
tostring fieldNoStr, replace
gen wellID = oil_gas_code + string(district_no) + fieldNoStr + /// 
	string(lease_no)
label variable wellID "unique well number"
note wellID: "Unique Well Number (Oil Gas Code + District + Field + Lease)"
gen n = 1
egen wellmonthsProd = total(n), by (wellID)
label variable wellmonthsProd "months production reported"
note wellmonthsProd: "Number of months production reported for each well/lease"
gen wellOP = oil_gas_code + string(district_no) + fieldNoStr + ///
	string(lease_no) + string(operator_no)
label variable wellOP "unique well operator number"
note wellOP: "Unique Well-Operator Number (Oil Gas Code + District + Field + Lease + Operator)"
egen wellOPmonthsProd = total(n), by (wellOP)
label variable wellOPmonthsProd "months operator reported production"
note wellOPmonthsProd: "Number of months production reported for each	unique well/lease by operator"
gen changeOPprod = .
label variable changeOPprod "Changed operators in production records"
note changeOPprod: "Wells/Leases that changed operators in 2012 according to production report"
replace changeOPprod = 0 if wellmonthsProd == wellOPmonthsProd
replace changeOPprod = 1 if wellmonthsProd != wellOPmonthsProd
egen tag = tag(wellOP wellID)
egen distinct = total(tag), by(wellID)
gen nOPchangesProd = distinct - 1
label variable nOPchangesProd "Number of operator changes in production report"
note nOPchangesProd: "Number of times the well/lease changed owners in 2012 according to production report"
// verify all wells that have multiple operators are correctly identified
// after running test, if all are not equal to one, some are not correctly identified
gen test = .
replace test = 1 if changeOPprod == 1 & nOPchangesProd > 0
replace test = 1 if changeOPprod == 0 & nOPchangesProd ==0
sum test
drop test n tag distinct fieldNoStr
note lease_oil_prod_vol: "Lease monthly total reported volume of crude oil produced (in barrels)"
note lease_oil_allow: "Lease monthly total sum of oil well allowables (in barrels) by lease for the cycle"
note lease_oil_ending_bal: "Lease monthly total stock at hand (in barrels) , computed by adding the oil ending balance from the previous cycle to the oil produced and subtracting the total of all of the liquid dispositions"
note lease_gas_prod_vol: "Lease monthly total reported volument of gas produce (in mcf)"
note lease_gas_allow: "Lease monthly total sum of the gas well allowables (in mcf) by lease for the cycle"
note lease_gas_lift_inj_vol: "Lease monthly total gas used, given, or sold for gas lift by lease. It does not include gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note lease_cond_prod_vol: "Lease monthly total reported volume of condensate gas produced (in barrels)"
note lease_cond_limit: "Lease monthly total sum of condensate limit daily amounts for all prorated wells on the lease"
note lease_cond_ending_bal: "Lease monthly total stock at hand (in barrels), computed by adding the condensate ending balance from the previous cycle to the condenstate produced and subtracting the total of all of the liquid dispositions"
note lease_csgd_prod_vol: "Lease monthly total reported volume of casinghead gas produced (in mcf)"
note lease_csgd_limit: "Lease monthly total sum of the casinghead limit daily amounts for all prorated wells on the lease"
note lease_csgd_gas_lift: "Lease monthly total casinghead gas used, given, or solf for gas lift by lease. It does not inlcude gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note lease_oil_tot_disp: "Lease monthly total total barrels of oil disposed"
note lease_gas_tot_disp: "Lease monthly total total mcf of gas disposed"
note lease_cond_tot_disp: "Lease monthly total total barrels of condensate gas disposed"
note lease_csgd_tot_disp: "Lease monthly total total mcf of gas disposed"
label variable lease_oil_prod_vol "Lease monthly oil producion"
label variable lease_oil_allow "Lease monthly oil allowables"
label variable lease_oil_ending_bal "Lease monthly oil stock at hand"
label variable lease_gas_prod_vol "Lease monthly gas production"
label variable lease_gas_allow "Lease monthly gas allowables"
label variable lease_gas_lift_inj_vol "Lease monthly gas used for gas lift"
label variable lease_cond_prod_vol "Lease monthly condensate production"
label variable lease_cond_limit "Lease monthly condensate limit"
label variable lease_cond_ending_bal "Lease monthly condensate stock at hand"
label variable lease_csgd_prod_vol "Lease monthly casinghead production"
label variable lease_csgd_limit "Lease monthly casinghead limit"
label variable lease_csgd_gas_lift "Lease monthly casinghead used for gas lift"
label variable lease_oil_tot_disp "Lease monthly total oil disposed"
label variable lease_gas_tot_disp "Lease monthly total gas disposed"
label variable lease_cond_tot_disp "Lease monthly total total condensate disposed"
label variable lease_csgd_tot_disp "Lease monthly total total casinghead disposed"
// clean data
label variable oil_gas_code "well type"
note oil_gas_code: "Code that denote Oil or Gas (O = Oil and G = Gas)"
label variable district_no "district number"
note district_no: "One of the 14 primary RRC district of permit"
label variable lease_no "lease number"
note lease_no: "RRC assinged number, uniqe within district"
label variable cycle_year "Year"
note cycle_year: "The production year in YYYY format"
label variable cycle_month "Month"
note cycle_month: "The production month in MM format"
label variable cycle_year_month "Cycle Year Month"
note cycle_year_month: "The production year month in YYYYMM format"
label variable lease_no_district_no "Lease district number"
note lease_no_district_no: "Lease district number"
label variable operator_no "operator number"
note operator_no: "Organization/Operator ID number assigned by the RRC"
label variable field_no "field number"
note field_no: "8 digit number assinged to a field by the field designation section of the oil and gas division at the railroad commission"
label variable field_type "Field Type"
note cycle_year_month: "Field Type"
label variable gas_well_no "Gas well number"
note gas_well_no: "Gas well number"
label variable prod_report_filed_flag "report filed"
note prod_report_filed_flag: "Production report filed"
label variable field_name "field name"
note field_name: "Field name"
label variable district_name "district name"
note district_name: "The primary RRC district of the permit"
label variable field_name "field name"
note field_name: "A field name made up of a word chosen by the operator"
label variable operator_name "operator name"
note operator_name: "Name of the operator as filed on the RRC Organization Report"
save productionByMonth
cd ..
cd Posted
save 10-productionByMonth_20161117
cd ..
cd Working
// make totals to ensure data isn't lost upon collapse and merge
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
	preMergSum_csgdDispTot
duplicates drop 
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
save preMergProdTotals
clear
/********-*********-*********-*********-*********-*********-*********/
/* Create records for each unique well/lease operator for each year */
/********-*********-*********-*********-*********-*********-*********/
use productionByMonth
keep wellOP oil_gas_code district_no lease_no cycle_year lease_no_district_no operator_no ///
	field_no gas_well_no district_name lease_name operator_name field_name
duplicates drop
sort wellOP
save constantProdWellInfo
clear
use productionByMonth
keep wellOP lease_oil_prod_vol lease_oil_allow lease_oil_ending_bal ///
	lease_gas_prod_vol lease_gas_allow lease_gas_lift_inj_vol ///
	lease_cond_prod_vol lease_cond_limit lease_cond_ending_bal ///
	lease_csgd_prod_vol lease_csgd_limit lease_csgd_gas_lift ///
	lease_oil_tot_disp lease_gas_tot_disp lease_cond_tot_disp ///
	lease_csgd_tot_disp
collapse (sum) lease_oil_prod_vol lease_oil_allow lease_oil_ending_bal ///
	lease_gas_prod_vol lease_gas_allow lease_gas_lift_inj_vol ///
	lease_cond_prod_vol lease_cond_limit lease_cond_ending_bal ///
	lease_csgd_prod_vol lease_csgd_limit lease_csgd_gas_lift ///
	lease_oil_tot_disp lease_gas_tot_disp lease_cond_tot_disp ///
	lease_csgd_tot_disp, by (wellOP)
notes replace lease_oil_prod_vol in 1: "Lease yearly total reported volume of crude oil produced (in barrels)"
notes replace lease_oil_allow in 1: "Lease yearly total sum of oil well allowables (in barrels) by lease for the cycle"
notes replace lease_oil_ending_bal in 1: "Lease yearly total stock at hand (in barrels) , computed by adding the oil ending balance from the previous cycle to the oil produced and subtracting the total of all of the liquid dispositions"
notes replace lease_gas_prod_vol in 1: "Lease myearly total reported volument of gas produce (in mcf)"
notes replace lease_gas_allow in 1: "Lease yearly total sum of the gas well allowables (in mcf) by lease for the cycle"
notes replace lease_gas_lift_inj_vol in 1: "Lease yearly total gas used, given, or sold for gas lift by lease. It does not include gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
notes replace lease_cond_prod_vol in 1: "Lease yearly total reported volume of condensate gas produced (in barrels)"
notes replace lease_cond_limit in 1: "Lease yearly total sum of condensate limit daily amounts for all prorated wells on the lease"
notes replace lease_cond_ending_bal in 1: "Lease yearly total stock at hand (in barrels), computed by adding the condensate ending balance from the previous cycle to the condenstate produced and subtracting the total of all of the liquid dispositions"
notes replace lease_csgd_prod_vol in 1: "Lease yearly total reported volume of casinghead gas produced (in mcf)"
notes replace lease_csgd_limit in 1: "Lease yearly total sum of the casinghead limit daily amounts for all prorated wells on the lease"
notes replace lease_csgd_gas_lift in 1: "Lease yearly total casinghead gas used, given, or solf for gas lift by lease. It does not inlcude gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
notes replace lease_oil_tot_disp in 1: "Lease yearly total total barrels of oil disposed"
notes replace lease_gas_tot_disp in 1: "Lease yearly total total mcf of gas disposed"
notes replace lease_cond_tot_disp in 1: "Lease yearly total total barrels of condensate gas disposed"
notes replace lease_csgd_tot_disp in 1: "Lease yearly total total mcf of casinghead gas disposed"
label variable lease_oil_prod_vol "Lease yearly oil produced"
label variable lease_oil_allow "Lease yearly oil allowables"
label variable lease_oil_ending_bal "Lease yearly oil stock at hand"
label variable lease_gas_prod_vol "Lease yearly gas produced"
label variable lease_gas_allow "Lease yearly gas allowables"
label variable lease_gas_lift_inj_vol "Lease yearly gas used for gas lift"
label variable lease_cond_prod_vol "Lease yearly condensate produced"
label variable lease_cond_limit "Lease yearly condensate limit"
label variable lease_cond_ending_bal "Lease yearly stock at hand"
label variable lease_csgd_prod_vol "Lease yearly casinghead gas produced"
label variable lease_csgd_limit "Lease yearly casinghead limit"
label variable lease_csgd_gas_lift "Lease yearly total casinghead gas used for gas lift"
label variable lease_oil_tot_disp "Lease yearly total oil disposed"
label variable lease_gas_tot_disp "Lease yearly total gas disposed"
label variable lease_cond_tot_disp "Lease yearly total condensate disposed"
label variable lease_csgd_tot_disp "Lease yearly total casinghead gas disposed"
// merge, all should be matched, or error occured
merge 1:1 wellOP using constantProdWellInfo
drop _merge
save wellProduction
clear
/********-*********-*********-*********-*********-*********-*********/
/* Merge production and disposition								    */
/********-*********-*********-*********-*********-*********-*********/
use wellDisposition
merge 1:1 wellOP using wellProduction
gen noDispReported = 0
replace noDispReported = 1 if _merge == 2
label variable noDispReported "no disposition reported"
note noDispReported: "wellOP from 07-production_20160824 does not have a match in 07-disposition_20160824"
note noDispReported: "Variable created from 07-production_20160824 and 07-disposition_20160824 in 10-manageProductionDisposition_20161117.do"
gen noProdReported = 0
replace noProdReported = 1 if _merge == 1
label variable noProdReported "no production reported"
note noProdReported: "wellOP from 07-disposition_20160824 does not have a match in 07-production_20160824"
note noProdReported: "Variable created from 07-production_20160824 and 07-disposition_20160824 in 10-manageProductionDisposition_20161117.do"
drop _merge
gen transDistName = ""
replace transDistName = "01" if district_no == 1
replace transDistName = "02" if district_no == 2
replace transDistName = "03" if district_no == 3
replace transDistName = "04" if district_no == 4
replace transDistName = "05" if district_no == 5
replace transDistName = "06" if district_no == 6
replace transDistName = "6E" if district_no == 7
replace transDistName = "7B" if district_no == 8
replace transDistName = "7C" if district_no == 9
replace transDistName = "08" if district_no == 10
replace transDistName = "8A" if district_no == 11
replace transDistName = "8B" if district_no == 12
replace transDistName = "09" if district_no == 13
replace transDistName = "10" if district_no == 14
gen insMergIdLnoOno = transDistName + "-" + string(lease_no, "%06.0f") + "-" + string(operator_no, "%06.0f")
label variable insMergIdLnoOno "Unique Well-Operator Number"
gen matchID = oil_gas_code + insMergIdLnoOno 
sort matchID
quietly by matchID: gen dup = cond(_N==1,0,_n)
save prodDisp
keep if dup == 0
save prodDispNoDup
clear
use prodDisp
keep if dup != 0
gen fieldNameMismatch = .
label variable fieldNameMismatch "reported incorrect field name in monthly production report"
notes fieldNameMismatch: "Operator reported incorrect field name in one or more of its monthly production reports"
sort field_name 
quietly by field_name: gen rep = cond(_N==1,0,_n)
replace fieldNameMismatch = 1 if rep > 0
replace fieldNameMismatch = 0 if rep == 0
drop rep 
gen fieldNoMismatch = .
label variable fieldNoMismatch "reported incorrect field number in monthly production report"
notes fieldNoMismatch: "Operator reported incorrect field number in one or more of its monthly production reports"
sort field_no 
quietly by field_no: gen rep = cond(_N==1,0,_n)
replace fieldNoMismatch = 1 if rep > 0
replace fieldNoMismatch = 0 if rep == 0
drop rep 
save dupInfo
keep wellOP wellID matchID changeOPdisp nOPchangesDisp	///
	oil_gas_code district_no ///
	lease_no cycle_year lease_no_district_no operator_no ///
	operator_name field_no gas_well_no district_name ///
	lease_name operator_name field_name insMergIdLnoOno  ///
	fieldNoMismatch fieldNameMismatch 
duplicates drop
sort matchID
quietly by matchID: gen repID = cond(_N==1,0,_n)
drop if repID != 1
save constantDupInfo
clear
use dupInfo
keep matchID lease_oil_prod_vol lease_oil_allow lease_oil_ending_bal ///
	lease_gas_prod_vol lease_gas_allow lease_gas_lift_inj_vol ///
	lease_cond_prod_vol lease_cond_limit lease_cond_ending_bal ///
	lease_csgd_prod_vol lease_csgd_limit lease_csgd_gas_lift ///
	lease_oil_tot_disp lease_gas_tot_disp lease_cond_tot_disp ///
	lease_csgd_tot_disp lease_oil_dispcd00_vol lease_oil_dispcd01_vol ///
	lease_oil_dispcd02_vol lease_oil_dispcd03_vol ///
	lease_oil_dispcd04_vol lease_oil_dispcd05_vol ///
	lease_oil_dispcd06_vol lease_oil_dispcd07_vol ///
	lease_oil_dispcd08_vol lease_oil_dispcd09_vol ///
	lease_oil_dispcd99_vol lease_gas_dispcd01_vol ///
	lease_gas_dispcd02_vol lease_gas_dispcd03_vol ///
	lease_gas_dispcd04_vol lease_gas_dispcd05_vol ///
	lease_gas_dispcd06_vol lease_gas_dispcd07_vol ///
	lease_gas_dispcd08_vol lease_gas_dispcd09_vol ///
	lease_gas_dispcd99_vol lease_cond_dispcd00_vol ///
	lease_cond_dispcd01_vol lease_cond_dispcd02_vol ///
	lease_cond_dispcd03_vol lease_cond_dispcd04_vol ///
	lease_cond_dispcd05_vol lease_cond_dispcd06_vol ///
	lease_cond_dispcd07_vol lease_cond_dispcd08_vol ///
	lease_cond_dispcd99_vol lease_csgd_dispcde01_vol ///
	lease_csgd_dispcde02_vol lease_csgd_dispcde03_vol ///
	lease_csgd_dispcde04_vol lease_csgd_dispcde05_vol ///
	lease_csgd_dispcde06_vol lease_csgd_dispcde07_vol ///
	lease_csgd_dispcde08_vol lease_csgd_dispcde99_vol ///
	wellmonthsDisp wellOPmonthsDisp
collapse (sum) lease_oil_dispcd00_vol lease_oil_dispcd01_vol ///
	lease_oil_dispcd02_vol lease_oil_dispcd03_vol ///
	lease_oil_dispcd04_vol lease_oil_dispcd05_vol ///
	lease_oil_dispcd06_vol lease_oil_dispcd07_vol ///
	lease_oil_dispcd08_vol lease_oil_dispcd09_vol ///
	lease_oil_dispcd99_vol lease_gas_dispcd01_vol ///
	lease_gas_dispcd02_vol lease_gas_dispcd03_vol ///
	lease_gas_dispcd04_vol lease_gas_dispcd05_vol ///
	lease_gas_dispcd06_vol lease_gas_dispcd07_vol ///
	lease_gas_dispcd08_vol lease_gas_dispcd09_vol ///
	lease_gas_dispcd99_vol lease_cond_dispcd00_vol ///
	lease_cond_dispcd01_vol lease_cond_dispcd02_vol ///
	lease_cond_dispcd03_vol lease_cond_dispcd04_vol ///
	lease_cond_dispcd05_vol lease_cond_dispcd06_vol ///
	lease_cond_dispcd07_vol lease_cond_dispcd08_vol ///
	lease_cond_dispcd99_vol lease_csgd_dispcde01_vol ///
	lease_csgd_dispcde02_vol lease_csgd_dispcde03_vol ///
	lease_csgd_dispcde04_vol lease_csgd_dispcde05_vol ///
	lease_csgd_dispcde06_vol lease_csgd_dispcde07_vol ///
	lease_csgd_dispcde08_vol lease_csgd_dispcde99_vol ///
	lease_oil_prod_vol lease_oil_allow lease_oil_ending_bal ///
	lease_gas_prod_vol lease_gas_allow lease_gas_lift_inj_vol ///
	lease_cond_prod_vol lease_cond_limit lease_cond_ending_bal ///
	lease_csgd_prod_vol lease_csgd_limit lease_csgd_gas_lift ///
	lease_oil_tot_disp lease_gas_tot_disp lease_cond_tot_disp ///
	lease_csgd_tot_disp wellmonthsDisp wellOPmonthsDisp, by (matchID)
merge 1:1 matchID using constantDupInfo
append using prodDispNoDup
drop dup matchID _merge
/********-*********-*********-*********-*********-*********-*********/
/* Find any records where production is less than disposition 		*/
/********-*********-*********-*********-*********-*********-*********/
gen calDispTotalOil = lease_oil_dispcd00_vol + lease_oil_dispcd01_vol ///
	+ lease_oil_dispcd02_vol + lease_oil_dispcd03_vol + ///
	lease_oil_dispcd04_vol + lease_oil_dispcd05_vol + ///
	lease_oil_dispcd06_vol + lease_oil_dispcd07_vol + ///
	lease_oil_dispcd08_vol + lease_oil_dispcd09_vol + lease_oil_dispcd99_vol 
label variable calDispTotalOil "total calculated lease-year oil disposal"
note calDispTotalOil: "Summary of lease yearly oil disposal total reported in disposition file"
gen difPDdispTotalOil = lease_oil_tot_disp - calDispTotalOil
label variable difPDdispTotalOil "difference between oil production & disposition disposition reports"
note difPDdispTotalOil: "Difference between total oil disposal calculated from disposal records and total disposal recorded in production file (production disposal total - calculated disposal total)"
gen difOilProdDisp = lease_oil_prod_vol - lease_oil_tot_disp
label variable difOilProdDisp "difference between oil production & disposition using production records"
note difOilProdDisp: "Difference between total oil disposal and production reported in production file"
gen difOilPtotDtot = lease_oil_prod_vol - calDispTotalOil 
label variable difOilPtotDtot "difference between oil production & disposition using disposition and production records"
note difOilPtotDtot: "Difference between total oil disposal reported in disposal file and total oil produced"
gen disposeMoreProdOil = .
replace disposeMoreProdOil = 1 if difOilPtotDtot < 0
replace disposeMoreProdOil = 0 if difOilPtotDtot >= 0
label variable disposeMoreProdOil "more oil disposed than produced"
note disposeMoreProdOil: "Calculated oil disposed is greater than production"
gen calDispTotalGas = lease_gas_dispcd01_vol + lease_gas_dispcd02_vol ///
	+ lease_gas_dispcd03_vol + 	lease_gas_dispcd04_vol + lease_gas_dispcd05_vol ///
	+ lease_gas_dispcd06_vol + lease_gas_dispcd07_vol ///
	+ lease_gas_dispcd08_vol + lease_gas_dispcd09_vol ///
	+ lease_gas_dispcd99_vol 
label variable calDispTotalGas "total calculated lease-year gas disposal"
note calDispTotalGas: "Summary of lease yearly gas disposal total reported in disposition file"
gen difPDdispTotalGas = lease_gas_tot_disp - calDispTotalGas
label variable difPDdispTotalGas "difference between gas production & disposition disposition reports"
note difPDdispTotalGas: "Difference between total gas disposal calculated from disposal records and total disposal recorded in production file (production disposal total - calculated disposal total)"
gen difGasProdDisp = lease_gas_prod_vol - lease_gas_tot_disp
label variable difGasProdDisp "difference between gas production & disposition using production records"
note difGasProdDisp: "Difference between total gas disposal and production reported in production file"
gen difGasPtotDtot = lease_gas_prod_vol - calDispTotalGas 
label variable difGasPtotDtot "difference between gas production & disposition using disposition and production records"
note difGasPtotDtot: "Difference between total gas disposal reported in disposal file and total gas produced"
gen disposeMoreProdGas = .
replace disposeMoreProdGas = 1 if difGasPtotDtot < 0
replace disposeMoreProdGas = 0 if difGasPtotDtot >= 0
label variable disposeMoreProdGas "more gas disposed than produced"
note disposeMoreProdGas: "Calculated gas disposed is greater than production"
gen calDispTotalCond = lease_cond_dispcd00_vol + lease_cond_dispcd01_vol ///
	+ lease_cond_dispcd02_vol + lease_cond_dispcd03_vol + lease_cond_dispcd04_vol ///
	+ lease_cond_dispcd05_vol + lease_cond_dispcd06_vol ///
	+ lease_cond_dispcd07_vol + lease_cond_dispcd08_vol ///
	+ lease_cond_dispcd99_vol 
label variable calDispTotalCond "total calculated lease-year condensate disposal"
note calDispTotalCond: "Summary of lease yearly condensate disposal total reported in disposition file"
gen difPDdispTotalCond = lease_cond_tot_disp - calDispTotalCond
label variable difPDdispTotalCond "difference between gas production & disposition disposition reports"
note difPDdispTotalCond: "Difference between total condensate disposal calculated from disposal records and total disposal recorded in production file (production disposal total - calculated disposal total)"
gen difCondProdDisp = lease_cond_prod_vol - lease_cond_tot_disp
label variable difCondProdDisp "difference between condensate production & disposition using production records"
note difCondProdDisp: "Difference between total condensate disposal and production reported in production file"
gen difCondPtotDtot = lease_cond_prod_vol - calDispTotalCond
label variable difCondPtotDtot "difference between condensate production & disposition using disposition and production records"
note difCondPtotDtot: "Difference between total condensate disposal reported in disposal file and total oil produced"
gen disposeMoreProdCond = .
replace disposeMoreProdCond = 1 if difCondPtotDtot < 0
replace disposeMoreProdCond = 0 if difCondPtotDtot >= 0
label variable disposeMoreProdCond "Calculated condensate disposed is greater than production"
gen calDispTotalCsgd = lease_csgd_dispcde01_vol + lease_csgd_dispcde02_vol ///
	+ lease_csgd_dispcde03_vol + lease_csgd_dispcde04_vol + lease_csgd_dispcde05_vol ///
	+ lease_csgd_dispcde06_vol + lease_csgd_dispcde07_vol ///
	+ lease_csgd_dispcde08_vol + lease_csgd_dispcde99_vol 
label variable calDispTotalCsgd "total calcualted lease-year casinghead production"
note calDispTotalCsgd: "Summary of lease yearly casinghead gas disposal total reported in disposition file"
gen difPDdispTotalCsgd = lease_csgd_tot_disp - calDispTotalCsgd
label variable difPDdispTotalCsgd "difference between casinghead production & disposition disposition reports"
note difPDdispTotalCsgd: "Difference between total casinghead gas disposal calculated from disposal records and total disposal recorded in production file (production disposal total - calculated disposal total)"
gen difCsgdProdDisp = lease_csgd_prod_vol - lease_csgd_tot_disp
label variable difCsgdProdDisp "difference between casinghead production & disposition using production records"
note difCsgdProdDisp: "Difference between total casinghead gas disposal and production reported in production file"
gen difCsgdPtotDtot = lease_csgd_prod_vol - calDispTotalCsgd 
label variable difCsgdPtotDtot "difference between casinghead production & disposition using disposition and production records"
note difCsgdPtotDtot: "Difference between total casinghead disposal reported in disposal file and total oil produced"
gen disposeMoreProdCsgd = .
replace disposeMoreProdCsgd = 1 if difCsgdPtotDtot < 0
replace disposeMoreProdCsgd = 0 if difCsgdPtotDtot >= 0
label variable disposeMoreProdCsgd "calculated casinghead disposed is greater than production"
note disposeMoreProdCsgd: "Calculated casinghead gas disposed is greater than production"
/********-*********-*********-*********-*********-*********-*********/
/* Make percent gas well gas flared or vented variable				*/
/********-*********-*********-*********-*********-*********-*********/
gen perGasFV = lease_gas_dispcd04_vol / lease_gas_prod_vol
label variable perGasFV "percent gas vented or flared"
note perGasFV: "Percent of gas vented or flared (amount in mcf gas vented or flared / amount in mcf gas produced)"
/********-*********-*********-*********-*********-*********-*********/
/* Make percent casignhead gas flared or vented variable			*/
/********-*********-*********-*********-*********-*********-*********/
gen perCsgdFV = lease_csgd_dispcde04_vol / lease_csgd_prod_vol
label variable perCsgdFV "percent casinghead vented or flared"
note perCsgdFV: "Percent of casinghead gas vented or flared (amount in mcf casinghead vented or flared / amount in mcf casinghad gas produced)"
save wellProdDisp
/********-*********-*********-*********-*********-*********-*********/
/* Create separate oil and gas production and disposition files     */
/********-*********-*********-*********-*********-*********-*********/
keep if oil_gas_code == "O"
save oilProdDisp
cd ..
cd Posted
save 10-oilProdDisp_20161117
cd ..
cd Working
clear
use wellProdDisp
keep if oil_gas_code == "G"
save gasProdDisp
cd ..
cd Posted
save 10-gasProdDisp_20161117
cd ..
cd Working
/********-*********-*********-*********-*********-*********-*********/
/* Compare production and disposition data before collapse to	 	*/
/* verify that no production or disposition data was lost			*/
/********-*********-*********-*********-*********-*********-*********/
append using oilProdDisp
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
merge 1:1 n using preMergProdTotals 
drop _merge
// should have 100% match
merge 1:1 n using preMergDispTotals
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