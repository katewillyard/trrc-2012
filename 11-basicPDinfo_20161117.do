cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 11-basicPDinfo_20161117, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
// program:		11-basicPDinfo_20161117.do
// task:		Show summary statistics for production and disposition data 
//				Compare leases that reported disposition to those that did not
//				Compare leases that reported more disposition than production
//				List production and disposition state totals
//				Compare PDQ data with state records of production and disposition totals
//				Create histograms for production and disposition data
//				Repeat prelim_sumStatistics
//				Find number of wells and operators that flare and vent gas
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
/* Provide summary statistics for production and disposition data	*/
/********-*********-*********-*********-*********-*********-*********/
// gas well production and disposition summary statistics
use 10-gasProdDisp_20161117
codebook
summarize, separator(3)
summarize lease_gas_dispcd04_vol, detail
summarize lease_gas_prod_vol, detail
summarize perGasFV, detail
clear
// oil lease production and disposition summary statistics
use 10-oilProdDisp_20161117
codebook
summarize, separator(3)
summarize lease_csgd_dispcde04_vol, detail
summarize lease_csgd_prod_vol, detail
summarize perCsgdFV, detail
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Tabulate Leases that reported disposition to those that did not	*/
/* Show summary statistics for wells that reported or not			*/
/********-*********-*********-*********-*********-*********-*********/
// characteristics of oil leases that did not report disposition
use 10-oilProdDisp_20161117
tab1 noDispReported
tabstat lease_oil_prod_vol, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistics)
tabstat lease_csgd_prod_vol, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistic)
tabstat lease_oil_tot_disp, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistic)
tabstat lease_csgd_tot_disp, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistic)
clear
//
// characteristics of gas wells that did not report disposition
use 10-gasProdDisp_20161117 
tab1 noDispReported
tabstat lease_gas_prod_vol, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistics)
tabstat lease_cond_prod_vol, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistic)
tabstat lease_gas_tot_disp, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistic)
tabstat lease_cond_tot_disp, statistics(mean median skewness kurtosis) by (noDispReported) columns(statistic)
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Tabulate Leases that reported more disposition than production   */ 
/* to those that did not show summary statistics for wells that 	*/
/* reported or not													*/
/********-*********-*********-*********-*********-*********-*********/
use 10-oilProdDisp_20161117
append using 10-gasProdDisp_20161117
tab1 disposeMoreProdOil
tab1 disposeMoreProdCsgd
tab1 disposeMoreProdGas
tabstat lease_gas_prod_vol, statistics(mean median skewness kurtosis) by (disposeMoreProdGas) columns(statistics)
tabstat lease_cond_prod_vol, statistics(mean median skewness kurtosis) by (disposeMoreProdGas) columns(statistics)
tabstat lease_gas_dispcd04_vol, statistics(mean median skewness kurtosis) by (disposeMoreProdGas) columns(statistics)
tabstat perGasFV, statistics(mean median skewness kurtosis) by (disposeMoreProdGas) columns(statistics)
tab1 disposeMoreProdCond
tabstat lease_gas_prod_vol, statistics(mean median skewness kurtosis) by (disposeMoreProdCond) columns(statistics)
tabstat lease_cond_prod_vol, statistics(mean median skewness kurtosis) by (disposeMoreProdCond) columns(statistics)
tabstat lease_gas_dispcd04_vol, statistics(mean median skewness kurtosis) by (disposeMoreProdCond) columns(statistics)
tabstat perGasFV, statistics(mean median skewness kurtosis) by (disposeMoreProdCond) columns(statistics)
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* List production and disposition state totals 					*/
/********-*********-*********-*********-*********-*********-*********/
use 10-oilProdDisp_20161117
append using 10-gasProdDisp_20161117
egen oil00 = sum(lease_oil_dispcd00_vol)
egen oil01 = sum(lease_oil_dispcd01_vol)
egen oil02 = sum(lease_oil_dispcd02_vol)
egen oil03 = sum(lease_oil_dispcd03_vol)
egen oil04 = sum(lease_oil_dispcd04_vol)
egen oil05 = sum(lease_oil_dispcd05_vol)
egen oil06 = sum(lease_oil_dispcd06_vol)
egen oil07 = sum(lease_oil_dispcd07_vol)
egen oil08 = sum(lease_oil_dispcd08_vol)
egen oil09 = sum(lease_oil_dispcd09_vol)
egen oil99 = sum(lease_oil_dispcd99_vol)
egen gas01 = sum(lease_gas_dispcd01_vol)
egen gas02 = sum(lease_gas_dispcd02_vol)
egen gas03 = sum(lease_gas_dispcd03_vol)
egen gas04 = sum(lease_gas_dispcd04_vol)
egen gas05 = sum(lease_gas_dispcd05_vol)
egen gas06 = sum(lease_gas_dispcd06_vol)
egen gas07 = sum(lease_gas_dispcd07_vol)
egen gas08 = sum(lease_gas_dispcd08_vol)
egen gas09 = sum(lease_gas_dispcd09_vol)
egen gas99 = sum(lease_gas_dispcd99_vol)
egen cond00 = sum (lease_cond_dispcd00_vol)
egen cond01 = sum (lease_cond_dispcd01_vol)
egen cond02 = sum (lease_cond_dispcd02_vol)
egen cond03 = sum (lease_cond_dispcd03_vol)
egen cond04 = sum (lease_cond_dispcd04_vol)
egen cond05 = sum (lease_cond_dispcd05_vol)
egen cond06 = sum (lease_cond_dispcd06_vol)
egen cond07 = sum (lease_cond_dispcd07_vol)
egen cond08 = sum (lease_cond_dispcd08_vol)
egen cond99 = sum (lease_cond_dispcd99_vol)
egen csgd01 = sum (lease_csgd_dispcde01_vol)
egen csgd02 = sum (lease_csgd_dispcde02_vol)
egen csgd03 = sum (lease_csgd_dispcde03_vol)
egen csgd04 = sum (lease_csgd_dispcde04_vol)
egen csgd05 = sum (lease_csgd_dispcde05_vol)
egen csgd06 = sum (lease_csgd_dispcde06_vol)
egen csgd07 = sum (lease_csgd_dispcde07_vol)
egen csgd08 = sum (lease_csgd_dispcde08_vol)
egen csgd99 = sum (lease_csgd_dispcde99_vol)
egen oilProd = sum(lease_oil_prod_vol)
egen oilAllow = sum(lease_oil_allow)
egen oilEndBal = sum(lease_oil_ending_bal)
egen gasProd = sum(lease_gas_prod_vol)
egen gasAllow = sum(lease_gas_allow)
egen gasLift = sum(lease_gas_lift_inj_vol)
egen condProd = sum(lease_cond_prod_vol)
egen condLimit = sum(lease_cond_limit)
egen condEndBal = sum(lease_cond_ending_bal)
egen csgdProd = sum(lease_csgd_prod_vol)
egen csgdLimit = sum(lease_csgd_limit)
egen csgdLift = sum(lease_csgd_gas_lift)
egen oilDispTot = sum(lease_oil_tot_disp)
egen gasDispTot = sum(lease_gas_tot_disp)
egen condDispTot = sum(lease_cond_tot_disp)
egen csgdDispTot = sum(lease_csgd_tot_disp)
keep oil00 oil01 oil02 ///
	oil03 oil04 oil05 ///
	oil06 oil07 oil08 ///
	oil09 oil99 gas01 ///
	gas02 gas03 gas04 ///
	gas05 gas06 gas07 ///
	gas08 gas09 gas99 ///
	cond00 cond01 cond02 ///
	cond03 cond04 cond05 ///
	cond06 cond07 cond08 ///
	cond99 csgd01 csgd02 ///
	csgd03 csgd04 csgd05 ///
	csgd06 csgd07 csgd08 ///
	csgd99 oilProd oilAllow ///
	oilEndBal gasProd gasAllow ///
	gasLift condProd condLimit ///
	condEndBal csgdProd csgdLimit ///
	csgdLift oilDispTot gasDispTot ///
	condDispTot csgdDispTot
duplicates drop 
note oil00: "State year total crude oil (in barrels) disposed by pipeline"
note oil01: "State year total crude oil (in barrels) disposed by truck"
note oil02: "State year total crude oil (in barrels) disposed by tank car or barge"
note oil03: "State year total crude oil (in barrels) disposed by talk cleaning (an adjustment to and/or lease use of production already measured by the operator."
note oil04: "State year total crude oil (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
note oil05: "State year total crude oil (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
note oil06: "State year total crude oil (in barrels) lost due to tank cleaning, basic sediment and water."
note oil07: "State year total crude oil (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
note oil08: "State year total crude oil (in barrels) indirectly disposed by others through a saltwater gathering system. "
note oil09: "State year total crude oil (in barrels) indirectly disposed by others because it left the elase entrained in casinghead gas going to a gas processing plant."
note oil99: "State year total crude oil (in barrels) reportedly disposed without a disposition code"
note gas01: "State year total gas (in mcf) used for field operations"
note gas02: "State year total gas (in mcf) disposed by transmission line"
note gas03: "State year total gas (in mcf) disposed to a processing plant"
note gas04: "State year total gas (in mcf) vented or flared"
note gas05: "State year total gas (in mcf) used for gas lift"
note gas06: "State year total gas (in mcf) used for repressure, or pressure maintenance."
note gas07: "State year total gas (in mcf) delivered to carbon black plant"
note gas08: "State year total gas (in mcf) injected directly into a storage reservoir"
note gas09: "State year total gas (in mcf) lost due to the shrinkage of gas during lease separation methods"
note gas99: "State year total gas (in mcf) reportedly disposed without a disposition code"
note cond00: "State year total gas condensate (in barrels) disposed by pipeline"
note cond01: "State year total gas condensate (in barrels) disposed by truck"
note cond02: "State year total gas condensate (in barrels) disposed by tank car or barge"
note cond03: "State year total gas condensate (in barrels) disposed by talk cleaning (an adjustment to and/or lease use of production already measured by the operator."
note cond04: "State year total gas condensate (in barrels) disposed by circulating oil/condinsate (the operator has measured and released the stated volume to the operator of another well for use as frac liquid on the second lease."
note cond05: "State year total gas condensate (in barrels) lost due to a spill. When there is a spill of any volume with a resulting loss of 5 or more barrels of oil, or when the spill affects a ody of water, a form H-8 must be filed."
note cond06: "State year total gas condensate (in barrels) lost due to tank cleaning, basic sediment and water."
note cond07: "State year total cgas condensate (in barrels) lost from stock adjustments, water bleed-off, lease use, road oil and theft."
note cond08: "State year total gas condensate (in barrels) indirectly disposed by others through a saltwater gathering system. "
note cond99: "State year total gas condensate (in barrels) reportedly disposed without a disposition code."
note csgd01: "State year total casignhead gas (in mcf) used for field operations."
note csgd02: "State year total casignhead gas (in mcf) disposed by transmission line"
note csgd03: "State year total casignhead gas (in mcf) disposed to a processing plant"
note csgd04: "State year total casignhead gas (in mcf) vented or flared"
note csgd05: "State year total casignhead gas (in mcf) used for gas lift"
note csgd06: "State year total casignhead gas (in mcf) used for repressure, or pressure maintenance"
note csgd07: "State year total casignhead gas (in mcf) delivered to carbon black plant"
note csgd08: "State year total casignhead gas (in mcf) injected directly into a storage reservoir"
note csgd99: "State year total casignhead gas (in mcf) reportedly disposed without a disposition code"
label variable oil00 "state-year oil pipeline disposal"
label variable oil01 "state-year oil truck disposal"
label variable oil02 "state-year oil tank disposal"
label variable oil03 "state-year oil tank cleaning disposal"
label variable oil04 "state-year oil disposal for frac liquid on other lease" 
label variable oil05 "state-year oil disposal from spill"
label variable oil06 "state-year oil disposal from basic sediment loss"
label variable oil07 "state-year oil disposal from water bleed-off, lease use, road oil, or theft"
label variable oil08 "state-year oil disposal from saltwater gathering system"
label variable oil09 "state-year oil disposal to gas processing plant"
label variable oil99 "state-year oil disposal without code"
label variable gas01 "state-year gas field use disposal"
label variable gas02 "state-year gas transmission line disposal"
label variable gas03 "state-year gas processing plant disposal"
label variable gas04 "state-year gas vented or flared"
label variable gas05 "state-year gas gas lift disposal"
label variable gas06 "state-year gas pressure maintenance disposal"
label variable gas07 "state-year gas carbon black plant disposal"
label variable gas08 "state-year gas storage reservoir disposal"
label variable gas09 "state-year gas lost due to shrinkage during separation"
label variable gas99 "state-year gas diposal without code"
label variable cond00 "state-year condensate pipeline disposal"
label variable cond01 "state-year condensate truck disposal"
label variable cond02 "state-year condensate tank car disposal"
label variable cond03 "state-year condensate tank cleaning disposal"
label variable cond04 "state-year condensate disposal for frac liquid on other lease"
label variable cond05 "state-year condensate disposal from spill"
label variable cond06 "state-year condensate disposal from basic sediment loss"
label variable cond07 "state-year condensate disposal from water bleed-off, lease use, road oil, or theft"
label variable cond08 "state-year condensate disposal from saltwater gathering system"
label variable cond99 "state-year condensate disposal without code"
label variable csgd01 "state-year casinghead field use disposal"
label variable csgd02 "state-year casinghead transmission line disposal"
label variable csgd03 "state-year casinghead processing plant disposal"
label variable csgd04 "state-year casinghead vented or flared"
label variable csgd05 "state-year casinghead gas lift disposal"
label variable csgd06 "state-year casinghead pressure maintenance disposal"
label variable csgd07 "state-year casinghead carbon black plant disposal"
label variable csgd08 "state-year casinghead storage reservoir disposal"
label variable csgd99 "state-year casinghead disposed without code"
note oilProd: "State total reported volume of crude oil produced (in barrels)"
note oilAllow: "State total sum of oil well allowables (in barrels) by lease for the cycle"
note oilEndBal: "State total stock at hand (in barrels) , computed by adding the oil ending balance from the previous cycle to the oil produced and subtracting the total of all of the liquid dispositions"
note gasProd: "State total reported volument of gas produce (in mcf)"
note gasAllow: "State total sum of the gas well allowables (in mcf) by lease for the cycle"
note gasLift: "State total gas used, given, or sold for gas lift by lease. It does not include gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note condProd: "State total reported volume of condensate gas produced (in barrels)"
note condLimit: "State total sum of condensate limit daily amounts for all prorated wells on the lease"
note condEndBal: "State total stock at hand (in barrels), computed by adding the condensate ending balance from the previous cycle to the condenstate produced and subtracting the total of all of the liquid dispositions"
note csgdProd: "State total reported volume of casinghead gas produced (in mcf)"
note csgdLimit: "State total sum of the casinghead limit daily amounts for all prorated wells on the lease"
note csgdLift: "State total casinghead gas used, given, or solf for gas lift by lease. It does not inlcude gas delivered to pressure maintenance or processing plants, even though the gas may be used for gas lift"
note oilDispTot: "State total barrels of oil disposed"
note gasDispTot: "State total mcf of gas disposed"
note condDispTot: "State total barrels of condensate gas disposed"
note csgdDispTot: "State total mcf of gas disposed"
label variable oilProd "State-year oil producion"
label variable oilAllow "Lease monthly oil allowables"
label variable oilEndBal "Lease monthly oil stock at hand"
label variable gasProd "Lease monthly gas production"
label variable gasAllow "Lease monthly gas allowables"
label variable gasLift "Lease monthly gas used for gas lift"
label variable condProd "Lease monthly condensate production"
label variable condLimit "Lease monthly condensate limit"
label variable condEndBal "Lease monthly condensate stock at hand"
label variable csgdProd "Lease monthly casinghead production"
label variable csgdLimit "Lease monthly casinghead limit"
label variable csgdLift "Lease monthly casinghead used for gas lift"
label variable oilDispTot "Lease monthly total oil disposed"
label variable gasDispTot "Lease monthly total gas disposed"
label variable condDispTot "Lease monthly total total condensate disposed"
label variable csgdDispTot "Lease monthly total total casinghead disposed"
codebook
//
/********-*********-*********-*********-*********-*********-*********/
/* Compare pdq dump data with state records			  				*/
/********-*********-*********-*********-*********-*********-*********/
// compare pdq dump data with yearly state production records found at http://www.rrc.state.tx.us/oil-gas/research-and-statistics/production-data/texas-monthly-oil-gas-production/ on October 24, 2016
gen difStPDQ_oil = 607096453 - oilProd 
label variable difStPDQ_oil "oil yearly state production difference"
note difStPDQ_oil: "Difference between reported state oil production and calcualted state totals (state production - state production calculated from PDQ)"
gen perDifOil = 100 * difStPDQ_oil / 607096453
label variable perDifOil "percent yearly state production difference"
note perDifOil: "Percent difference between reported state oil production and calculated state totals 100 * (state production - state production calculated from PDQ) / state production"
gen difStPDQ_csgd = 1210604280 - csgdProd
label variable difStPDQ_csgd "casinghead yearly state production difference"
note difStPDQ_csgd: "Difference between reported state casinghead gas production and calcualted state totals (state production - state production calculated from PDQ)"
gen perDifCsgd = 100 * difStPDQ_csgd / 607096453
label variable perDifCsgd "percent yearly state casinghead difference"
note perDifCsgd: "Percent difference between reported state casinghead production and calculated state totals 100 * (state production - state production calculated from PDQ) / state production"
gen difStPDQ_gas = 6957008052 - gasProd
label variable difStPDQ_gas "gas yearly state production difference"
note difStPDQ_gas: "Difference between reported state gas well gas production and calcualted state totals (state production - state production calculated from PDQ)"
gen perDifGas = 100 * difStPDQ_gas / 607096453
label variable perDifGas "percent yearly state gas production difference"
note perDifGas: "Percent difference between reported state gas production and calculated state totals 100 * (state production - state production calculated from PDQ) / state production"
gen difStPDQ_cond = 116216821 - condProd
label variable difStPDQ_cond "condensate yearly state production difference"
note difStPDQ_cond: "Difference between reported state condensate production and calcualted state totals (state production - state production calculated from PDQ)"
gen perDifCond = 100 * difStPDQ_cond / 607096453
label variable perDifCond "percenty yearly state condensate production difference"
note difStPDQ_cond: "Percent difference between reported state condensate production and calculated state totals 100 * (state production - state production calculated from PDQ) / state production"
keep difStPDQ_oil perDifOil difStPDQ_csgd perDifCsgd difStPDQ_gas perDifGas difStPDQ_cond perDifCond 
codebook
clear
//
// compare pdq dump data with monthly state oil production records
use 07-disposition_20160824
cd ..
cd Working
sort cycle_month
egen month_gas04 = total(lease_gas_dispcd04_vol), by (cycle_month)
label variable month_gas04 "State monthly total gas (in mcf) vented or flared"
note month_gas04: "State monthly total gas (in mcf) vented or flared"
egen month_csgd04 = total(lease_csgd_dispcde04_vol), by (cycle_month)
label variable month_csgd04 "State monthly total casignhead gas (in mcf) vented or flared"
note month_csgd04: "State monthly total casignhead gas (in mcf) vented or flared"
keep month_gas04 month_csgd04 cycle_month	
duplicates drop 
save dispTotals
cd ..
cd Posted
clear
use 07-production_20160824
cd ..
cd Working
sort cycle_month
egen month_oil = total(lease_oil_prod_vol), by (cycle_month)
label variable month_oil "State monthly total oil produced"
note month_oil: "State monthly total oil produced"
egen month_csgd = total(lease_csgd_prod_vol), by (cycle_month)
label variable month_csgd "State monthly total casinghead gas produced"
note month_csgd: "State monthly total casinghead gas produced"
egen month_gas = total(lease_gas_prod_vol), by (cycle_month)
label variable month_gas "State monthly total gas produced"
note month_gas: "State monthly total gas produced"
egen month_cond = total(lease_cond_prod_vol), by (cycle_month)
label variable month_cond "State monthly total condensate produced"
note month_cond: "State monthly total condensate produced"
keep month_oil month_csgd month_gas month_cond cycle_month
duplicates drop
merge 1:1 cycle_month using dispTotals
gen difStPDQ_oil1 = .
replace difStPDQ_oil1 = 44320770 - month_oil if cycle_month == 1
label variable difStPDQ_oil1 "january state oil production difference"
note difStPDQ_oil1: "Difference between reported state oil production and calcualted state january totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil1 = .
replace perDifStPDQ_oil1 = 100 * month_oil / 44320770 if cycle_month == 1
label variable perDifStPDQ_oil1 "percent january state oil production difference"
note perDifStPDQ_oil1: "Percent difference between reported state oil production and calculated state january totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil2 = .
replace difStPDQ_oil2 = 42830872 - month_oil if cycle_month == 2
label variable difStPDQ_oil2 "february state oil production differences"
note difStPDQ_oil2: "Difference between reported state oil production and calcualted state february totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil2 = .
replace perDifStPDQ_oil2 = 100 * month_oil / 44320770 if cycle_month == 2
label variable perDifStPDQ_oil2 "percent february state oil production difference"
note perDifStPDQ_oil2: "Percent difference between reported state oil production and calculated state february totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil3 = .
replace difStPDQ_oil3 = 46887943 - month_oil if cycle_month == 3
label variable difStPDQ_oil3 "march state oil production differences"
note difStPDQ_oil3: "Difference between reported state oil production and calcualted state march totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil3 = .
replace perDifStPDQ_oil3 = 100 * month_oil / 46887943 if cycle_month == 3
label variable perDifStPDQ_oil3 "percent march state oil production difference"
note perDifStPDQ_oil3: Percent difference between reported state oil production and calcualted state march totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil4 = .
replace difStPDQ_oil4 = 47259188 - month_oil if cycle_month == 4
label variable difStPDQ_oil4 "april state oil production differences"
note difStPDQ_oil4: "Difference between reported state oil production and calcualted state april totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil4 = .
replace perDifStPDQ_oil4 = 100 * month_oil / 47259188 if cycle_month == 4
label variable perDifStPDQ_oil4 "percent april state oil production difference"
note perDifStPDQ_oil4: "Percent difference between reported state oil production and calcualted state april totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil5 = .
replace difStPDQ_oil5 = 49890389 - month_oil if cycle_month == 5
label variable difStPDQ_oil5 "may state oil production difference"
note difStPDQ_oil5: "Difference between reported state oil production and calcualted state may totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil5 = .
replace perDifStPDQ_oil5 = 100 * month_oil / 49890389 if cycle_month == 5
label variable perDifStPDQ_oil5 "percent may state oil production difference"
note perDifStPDQ_oil5: "Percent difference between reported state oil production and calcualted state may totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil6 = .
replace difStPDQ_oil6 = 48999044 - month_oil if cycle_month == 6
label variable difStPDQ_oil6 "june state oil production difference"
note difStPDQ_oil6: "Difference between reported state oil production and calcualted state june totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil7 = .
replace difStPDQ_oil7 = 51990727 - month_oil if cycle_month == 7
label variable difStPDQ_oil7 "july state oil production difference"
note difStPDQ_oil7: "Difference between reported state oil production and calcualted state july totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil8 = .
replace difStPDQ_oil8 = 53431024 - month_oil if cycle_month == 8
label variable difStPDQ_oil8 "august state oil production difference"
note difStPDQ_oil8: "Difference between reported state oil production and calcualted state august totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil9 = .
replace difStPDQ_oil9 = 52402426 - month_oil if cycle_month == 9
label variable difStPDQ_oil9 "september state oil production difference"
note difStPDQ_oil9: "Difference between reported state oil production and calcualted state september totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil10 = .
replace difStPDQ_oil10 = 55806288 - month_oil if cycle_month == 10
label variable difStPDQ_oil10 "october state oil production difference"
note difStPDQ_oil10: "Difference between reported state oil production and calcualted state october totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil11 = .
replace difStPDQ_oil11 = 55467210 - month_oil if cycle_month == 11
label variable difStPDQ_oil11 "november state oil production difference"
note difStPDQ_oil11: "Difference between reported state oil production and calcualted state november totals (state production - state production calculated from PDQ)"
gen difStPDQ_oil12 = .
replace difStPDQ_oil12 = 57810572 - month_oil if cycle_month == 12
label variable difStPDQ_oil12 "december state oil production difference"
note difStPDQ_oil12: "Difference between reported state oil production and calcualted state december totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil6 = .
replace perDifStPDQ_oil6 = 100 * month_oil / 48999044 if cycle_month == 6
label variable perDifStPDQ_oil6 "percent june state oil production difference"
note perDifStPDQ_oil6: "Percent difference between reported state oil production and calcualted state june totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil7 = .
replace perDifStPDQ_oil7 = 100 * month_oil / 51990727 if cycle_month == 7
label variable perDifStPDQ_oil7 "percent july state oil production difference"
note perDifStPDQ_oil7: "Percent difference between reported state oil production and calcualted state july totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil8 = .
replace perDifStPDQ_oil8 = 100 * month_oil / 53431024 if cycle_month == 8
label variable perDifStPDQ_oil8 "percent august state oil production difference"
note perDifStPDQ_oil8: "Percent difference between reported state oil production and calcualted state august totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil9 = .
replace perDifStPDQ_oil9 = 100 * month_oil / 52402426 if cycle_month == 9
label variable perDifStPDQ_oil9 "percent september state oil production difference"
note perDifStPDQ_oil9: "Percent difference between reported state oil production and calcualted state september totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil10 = .
replace perDifStPDQ_oil10 = 100 * month_oil / 55806288 if cycle_month == 10
label variable perDifStPDQ_oil10 "percent october state oil production difference"
note perDifStPDQ_oil10: "Percent difference between reported state oil production and calcualted state october totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil11 = .
replace perDifStPDQ_oil11 = 100 * month_oil / 55467210 if cycle_month == 11
label variable perDifStPDQ_oil11 "percent november state oil production difference"
note perDifStPDQ_oil11: "Percent difference between reported state oil production and calcualted state november totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_oil12 = .
replace perDifStPDQ_oil12 = 100 * month_oil / 57810572 if cycle_month == 12
label variable perDifStPDQ_oil12 "percent december state oil production difference"
note perDifStPDQ_oil12: "Difference between reported state oil production and calcualted state december totals (state production - state production calculated from PDQ)"
sum difStPDQ_oil1 difStPDQ_oil2 difStPDQ_oil3 difStPDQ_oil4 ///
	difStPDQ_oil5 difStPDQ_oil6 difStPDQ_oil7 difStPDQ_oil8 ///
	difStPDQ_oil9 difStPDQ_oil10 difStPDQ_oil11 difStPDQ_oil12 ///
	perDifStPDQ_oil1 perDifStPDQ_oil2 perDifStPDQ_oil3 perDifStPDQ_oil4 ///
	perDifStPDQ_oil5 perDifStPDQ_oil6 perDifStPDQ_oil7 perDifStPDQ_oil8 ///
	perDifStPDQ_oil9 perDifStPDQ_oil10 perDifStPDQ_oil11 perDifStPDQ_oil12, ///
	separator(3)
//
// compare pdq dump data with montlhy state casinghead gas production records
gen difStPDQ_csgd1 = .
replace difStPDQ_csgd1 =83802682 - month_csgd if cycle_month == 1
label variable difStPDQ_csgd1 "january state casinghead production difference"
note difStPDQ_csgd1: "Difference between reported state casinghead gas production and calcualted state january totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd2 = .
replace difStPDQ_csgd2 = 82088474 - month_csgd if cycle_month == 2
label variable difStPDQ_csgd2 "february state casinghead production difference"
note difStPDQ_csgd2: "Difference between reported state casinghead gas production and calcualted state february totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd3 = .
replace difStPDQ_csgd3 = 90547303 - month_csgd if cycle_month == 3
label variable difStPDQ_csgd3 "march state casinghead production difference"
note difStPDQ_csgd3:"Difference between reported state casinghead gas production and calcualted state march totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd4 = .
replace difStPDQ_csgd4 = 91694761 - month_csgd if cycle_month == 4
label variable difStPDQ_csgd4 "april state casinghead production difference"
note difStPDQ_csgd4:"Difference between reported state casinghead gas production and calcualted state april totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd5 = .
replace difStPDQ_csgd5 = 96446995 - month_csgd if cycle_month == 5
label variable difStPDQ_csgd5 "may state casinghead production difference"
note difStPDQ_csgd5: "Difference between reported state casinghead gas production and calcualted state may totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd6 = .
replace difStPDQ_csgd6 = 95700155 - month_csgd if cycle_month == 6
label variable difStPDQ_csgd6 "june state casinghead production difference"
note difStPDQ_csgd6:"Difference between reported state casinghead gas production and calcualted state june totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd7 = .
replace difStPDQ_csgd7 = 106677870 - month_csgd if cycle_month == 7
label variable difStPDQ_csgd7 "july state casinghead production difference"
note difStPDQ_csgd7:"Difference between reported state casinghead gas production and calcualted state july totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd8 = .
replace difStPDQ_csgd8 = 110171451 - month_csgd if cycle_month == 8
label variable difStPDQ_csgd8 "august state casinghead production difference"
note difStPDQ_csgd8: "Difference between reported state casinghead gas production and calcualted state august totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd9 = .
replace difStPDQ_csgd9 = 108714081 - month_csgd if cycle_month == 9
label variable difStPDQ_csgd9 "september state casinghead production difference"
note difStPDQ_csgd9: "Difference between reported state casinghead gas production and calcualted state september totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd10 = .
replace difStPDQ_csgd10 = 113684222 - month_csgd if cycle_month == 10
label variable difStPDQ_csgd10 "october state casinghead production difference"
note difStPDQ_csgd10:"Difference between reported state casinghead gas production and calcualted state october totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd11 = .
replace difStPDQ_csgd11 = 113703658 - month_csgd if cycle_month == 11
label variable difStPDQ_csgd11 "november state casinghead production difference"
note difStPDQ_csgd11: "Difference between reported state casinghead gas production and calcualted state november totals (state production - state production calculated from PDQ)"
gen difStPDQ_csgd12 = .
replace difStPDQ_csgd12 = 117372628 - month_csgd if cycle_month == 12
label variable difStPDQ_csgd12 "december state casinghead production difference"
note difStPDQ_csgd12: "Difference between reported state casinghead gas production and calcualted state december totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd1 = .
replace perDifStPDQ_csgd1 = 100 * month_csgd / 83802682 if cycle_month == 1
label variable perDifStPDQ_csgd1 "percent january state casinghead production difference"
note perDifStPDQ_csgd1: "Percent difference between reported state casinghead gas production and calcualted state january totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd2 = .
replace perDifStPDQ_csgd2 = 100 * month_csgd / 82088474 if cycle_month == 2
label variable perDifStPDQ_csgd2 "percent february state casinghead production difference"
note perDifStPDQ_csgd2:"Percent difference between reported state casinghead gas production and calcualted state february totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd3 = .
replace perDifStPDQ_csgd3 = 100 * month_csgd / 90547303 if cycle_month == 3
label variable perDifStPDQ_csgd3 "percent march state casinghead production difference"
note perDifStPDQ_csgd3:"Percent difference between reported state casinghead gas production and calcualted state march totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd4 = .
replace perDifStPDQ_csgd4 = 100 * month_csgd / 91694761 if cycle_month == 4
label variable perDifStPDQ_csgd4 "percent april state casinghead production difference"
note perDifStPDQ_csgd4:"Percent difference between reported state casinghead gas production and calcualted state april totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd5 = .
replace perDifStPDQ_csgd5 = 100 * month_csgd / 96446995 if cycle_month == 5
label variable perDifStPDQ_csgd5 "percent may state casinghead production difference"
note perDifStPDQ_csgd5:"Percent difference between reported state casinghead gas production and calcualted state may totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd6 = .
replace perDifStPDQ_csgd6 = 100 * month_csgd / 95700155 if cycle_month == 6
label variable perDifStPDQ_csgd6 "percent june state casinghead production difference"
note perDifStPDQ_csgd6: "Percent difference between reported state casinghead gas production and calcualted state june totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd7 = .
replace perDifStPDQ_csgd7 = 100 * month_csgd / 106677870 if cycle_month == 7
label variable perDifStPDQ_csgd7 "percent july state casinghead production difference"
note perDifStPDQ_csgd7: "Percent difference between reported state casinghead gas production and calcualted state july totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd8 = .
replace perDifStPDQ_csgd8 = 100 * month_csgd / 110171451 if cycle_month == 8
label variable perDifStPDQ_csgd8 "percent august state casinghead production difference"
note perDifStPDQ_csgd8: "Percent difference between reported state casinghead gas production and calcualted state august totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd9 = .
replace perDifStPDQ_csgd9 = 100 * month_csgd / 108714081 if cycle_month == 9
label variable perDifStPDQ_csgd9 "percent september state casinghead production difference"
note perDifStPDQ_csgd9:"Percent difference between reported state casinghead gas production and calcualted state september totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd10 = .
replace perDifStPDQ_csgd10 = 100 * month_csgd / 113684222 if cycle_month == 10
label variable perDifStPDQ_csgd10 "percent october state casinghead production difference"
note perDifStPDQ_csgd10: "Percent difference between reported state casinghead gas production and calcualted state october totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd11 = .
replace perDifStPDQ_csgd11 = 100 * month_csgd / 113703658 if cycle_month == 11
label variable perDifStPDQ_csgd11 "percent november state casinghead production difference"
note perDifStPDQ_csgd11: "Percent difference between reported state casinghead gas production and calcualted state november totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_csgd12 = .
replace perDifStPDQ_csgd12 = 100 * month_csgd / 117372628 if cycle_month == 12
label variable perDifStPDQ_csgd12 "percent december state casinghead production difference"
note perDifStPDQ_csgd12: "Percent difference between reported state casinghead gas production and calcualted state december totals (state production - state production calculated from PDQ)"
sum difStPDQ_csgd1 difStPDQ_csgd2 difStPDQ_csgd3 difStPDQ_csgd4 ///
	difStPDQ_csgd5 difStPDQ_csgd6 difStPDQ_csgd7 difStPDQ_csgd8 ///
	difStPDQ_csgd9 difStPDQ_csgd10 difStPDQ_csgd11 difStPDQ_csgd12 ///
	perDifStPDQ_csgd1 perDifStPDQ_csgd2 perDifStPDQ_csgd3 perDifStPDQ_csgd4 ///
	perDifStPDQ_csgd5 perDifStPDQ_csgd6 perDifStPDQ_csgd7 perDifStPDQ_csgd8 ///
	perDifStPDQ_csgd9 perDifStPDQ_csgd10 perDifStPDQ_csgd11 perDifStPDQ_csgd12, ///
	separator(3)
//
// compare pdq dump data with monthly state gas well gas production records
gen difStPDQ_gas1 = .
replace difStPDQ_gas1 = 600778064 - month_gas if cycle_month == 1
label variable difStPDQ_gas1 "january state gas production difference"
note difStPDQ_gas1: "Difference between reported state gas well gas production and calcualted state january totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas2 = .
replace difStPDQ_gas2 = 555795229 - month_gas if cycle_month == 2
label variable difStPDQ_gas2 "february state gas production difference"
note difStPDQ_gas2: "Difference between reported state gas well gas production and calcualted state february totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas3 = .
replace difStPDQ_gas3 = 590459484 - month_gas if cycle_month == 3
label variable difStPDQ_gas3 "march state gas production difference"
note difStPDQ_gas3: "Difference between reported state gas well gas production and calcualted state march totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas4 = .
replace difStPDQ_gas4 = 575694966 - month_gas if cycle_month == 4
label variable difStPDQ_gas4 "april state gas production difference"
note difStPDQ_gas4: "Difference between reported state gas well gas production and calcualted state april totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas5 = .
replace difStPDQ_gas5 = 591868734 - month_gas if cycle_month == 5
label variable difStPDQ_gas5 "may state gas production difference"
note difStPDQ_gas5: "Difference between reported state gas well gas production and calcualted state may totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas6 = .
replace difStPDQ_gas6 = 569148498 - month_gas if cycle_month == 6
label variable difStPDQ_gas6 "june state gas production difference"
note difStPDQ_gas6: "Difference between reported state gas well gas production and calcualted state june totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas7 = .
replace difStPDQ_gas7 = 590491142 - month_gas if cycle_month == 7
label variable difStPDQ_gas7 "july state gas production difference"
note difStPDQ_gas7: "Difference between reported state gas well gas production and calcualted state july totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas8 = .
replace difStPDQ_gas8 = 591949836 - month_gas if cycle_month == 8
label variable difStPDQ_gas8 "august state gas production difference"
note difStPDQ_gas8: "Difference between reported state gas well gas production and calcualted state august totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas9 = .
replace difStPDQ_gas9 = 572595736 - month_gas if cycle_month == 9
label variable difStPDQ_gas9 "september state gas production difference"
note difStPDQ_gas9: "Difference between reported state gas well gas production and calcualted state september totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas10 = .
replace difStPDQ_gas10 = 585950427 - month_gas if cycle_month == 10
label variable difStPDQ_gas10 "october state gas production difference"
note difStPDQ_gas10: "Difference between reported state gas well gas production and calcualted state october totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas11 = .
replace difStPDQ_gas11 = 560932803 - month_gas if cycle_month == 11
label variable difStPDQ_gas11 "november state gas production difference"
note difStPDQ_gas11: "Difference between reported state gas well gas production and calcualted state november totals (state production - state production calculated from PDQ)"
gen difStPDQ_gas12 = .
replace difStPDQ_gas12 = 571343133 - month_gas if cycle_month == 12
label variable difStPDQ_gas12 "december state gas production difference"
note difStPDQ_gas12: "Difference between reported state gas well gas production and calcualted state december totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas1 = .
replace perDifStPDQ_gas1 = 100 * month_gas / 600778064 if cycle_month == 1
label variable perDifStPDQ_gas1 "january state gas production difference"
note perDifStPDQ_gas1: "Percent difference between reported state gas well gas production and calcualted state january totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas2 = .
replace perDifStPDQ_gas2 = 100 * month_gas / 555795229 if cycle_month == 2
label variable perDifStPDQ_gas2 "february state gas production difference"
note perDifStPDQ_gas2: "Percent difference between reported state gas well gas production and calcualted state february totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas3 = .
replace perDifStPDQ_gas3 = 100 * month_gas / 590459484 if cycle_month == 3
label variable perDifStPDQ_gas3 "march state gas production difference"
note perDifStPDQ_gas3: "Percent difference between reported state gas well gas production and calcualted state march totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas4 = .
replace perDifStPDQ_gas4 = 100 * month_gas / 575694966 if cycle_month == 4
label variable perDifStPDQ_gas4 "april state gas production difference"
note perDifStPDQ_gas4: "Percent difference between reported state gas well gas production and calcualted state april totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas5 = .
replace perDifStPDQ_gas5 = 100 * month_gas / 591868734 if cycle_month == 5
label variable perDifStPDQ_gas5 "may state gas production difference"
note perDifStPDQ_gas5: "Percent difference between reported state gas well gas production and calcualted state may totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas6 = .
replace perDifStPDQ_gas6 = 100 * month_gas / 569148498 if cycle_month == 6
label variable perDifStPDQ_gas6 "june state gas production difference"
note perDifStPDQ_gas6: "Percent difference between reported state gas well gas production and calcualted state june totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas7 = .
replace perDifStPDQ_gas7 = 100 * month_gas / 590491142 if cycle_month == 7
label variable perDifStPDQ_gas7 "july state gas production difference"
note perDifStPDQ_gas7: "Percent difference between reported state gas well gas production and calcualted state july totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas8 = .
replace perDifStPDQ_gas8 = 100 * month_gas / 591949836 if cycle_month == 8
label variable perDifStPDQ_gas8 "august state gas production difference"
note perDifStPDQ_gas8: "Percent difference between reported state gas well gas production and calcualted state august totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas9 = .
replace perDifStPDQ_gas9 = 100 * month_gas / 572595736 if cycle_month == 9
label variable perDifStPDQ_gas9 "september state gas production difference"
note perDifStPDQ_gas9: "Percent difference between reported state gas well gas production and calcualted state september totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas10 = .
replace perDifStPDQ_gas10 = 100 * month_gas / 585950427 if cycle_month == 10
label variable perDifStPDQ_gas10 "october state gas production difference"
note perDifStPDQ_gas10: "Percent difference between reported state gas well gas production and calcualted state october totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas11 = .
replace perDifStPDQ_gas11 = 100 * month_gas / 560932803 if cycle_month == 11
label variable perDifStPDQ_gas11 "november state gas production difference"
note perDifStPDQ_gas11: "Percent difference between reported state gas well gas production and calcualted state november totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_gas12 = .
replace perDifStPDQ_gas12 = 100 * month_gas / 571343133 if cycle_month == 12
label variable perDifStPDQ_gas12 "december state gas production difference"
note perDifStPDQ_gas12: "Percent difference between reported state gas well gas production and calcualted state december totals (state production - state production calculated from PDQ)"
sum difStPDQ_gas1 difStPDQ_gas2 difStPDQ_gas3 difStPDQ_gas4 ///
	difStPDQ_gas5 difStPDQ_gas6 difStPDQ_gas7 difStPDQ_gas8 ///
	difStPDQ_gas9 difStPDQ_gas10 difStPDQ_gas11 difStPDQ_gas12 ///
	perDifStPDQ_gas1 perDifStPDQ_gas2 perDifStPDQ_gas3 perDifStPDQ_gas4 ///
	perDifStPDQ_gas5 perDifStPDQ_gas6 perDifStPDQ_gas7 perDifStPDQ_gas8 ///
	perDifStPDQ_gas9 perDifStPDQ_gas10 perDifStPDQ_gas11 perDifStPDQ_gas12, ///
	separator(3)
//
// compare pdq dmp data with montlhy state condensate gas production records
gen difStPDQ_cond1 = .
replace difStPDQ_cond1 =9007517 - month_cond if cycle_month == 1
label variable difStPDQ_cond1 "january state condensate production difference"
note difStPDQ_cond1: "Difference between reported state condensate production and calcualted state january totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond2 = .
replace difStPDQ_cond2 = 8418146 - month_cond if cycle_month == 2
label variable difStPDQ_cond2 "february state condensate production difference"
note difStPDQ_cond2: "Difference between reported state condensate production and calcualted state february totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond3 = .
replace difStPDQ_cond3 = 8833008 - month_cond if cycle_month == 3
label variable difStPDQ_cond3 "march state condensate production difference"
note difStPDQ_cond3: "Difference between reported state condensate production and calcualted state march totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond4 = .
replace difStPDQ_cond4 = 8683841 - month_cond if cycle_month == 4
label variable difStPDQ_cond4 "april state condensate production difference"
note difStPDQ_cond4: "Difference between reported state condensate production and calcualted state april totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond5 = .
replace difStPDQ_cond5 = 9226974 - month_cond if cycle_month == 5
label variable difStPDQ_cond5 "may state condensate production difference"
note difStPDQ_cond5: "Difference between reported state condensate production and calcualted state may totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond6 = .
replace difStPDQ_cond6 = 9302578 - month_cond if cycle_month == 6
label variable difStPDQ_cond6 "june state condensate production difference"
note difStPDQ_cond6: "Difference between reported state condensate production and calcualted state june totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond7 = .
replace difStPDQ_cond7 = 9769855 - month_cond if cycle_month == 7
label variable difStPDQ_cond7 "july state condensate production difference"
note difStPDQ_cond7: "Difference between reported state condensate production and calcualted state july totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond8 = .
replace difStPDQ_cond8 = 10009689 - month_cond if cycle_month == 8
label variable difStPDQ_cond8 "august state condensate production difference"
note difStPDQ_cond8: "Difference between reported state condensate production and calcualted state august totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond9 = .
replace difStPDQ_cond9 = 10113865 - month_cond if cycle_month == 9
label variable difStPDQ_cond9 "september state condensate production difference"
note difStPDQ_cond9: "Difference between reported state condensate production and calcualted state september totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond10 = .
replace difStPDQ_cond10 = 10759148 - month_cond if cycle_month == 10
label variable difStPDQ_cond10 "october state condensate production difference"
note difStPDQ_cond10: "Difference between reported state condensate production and calcualted state october totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond11 = .
replace difStPDQ_cond11 = 10901149 - month_cond if cycle_month == 11
label variable difStPDQ_cond11 "november state condensate production difference"
note difStPDQ_cond11: "Difference between reported state condensate production and calcualted state november totals (state production - state production calculated from PDQ)"
gen difStPDQ_cond12 = .
replace difStPDQ_cond12 = 11191051 - month_cond if cycle_month == 12
label variable difStPDQ_cond12 "december state condensate production difference"
note difStPDQ_cond12: "Difference between reported state condensate production and calcualted state december totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond1 = .
replace perDifStPDQ_cond1 = 100 * month_cond / 9007517 if cycle_month == 1
label variable perDifStPDQ_cond1 "percent january state condensate production difference"
note perDifStPDQ_cond1: "Percent difference between reported state condensate production and calcualted state january totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond2 = .
replace perDifStPDQ_cond2 = 100 * month_cond / 8418146 if cycle_month == 2
label variable perDifStPDQ_cond2 "percent february state condensate production difference"
note perDifStPDQ_cond2: "Percent difference between reported state condensate production and calcualted state february totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond3 = .
replace perDifStPDQ_cond3 = 100 * month_cond / 8833008 if cycle_month == 3
label variable perDifStPDQ_cond3 "percent march state condensate production difference"
note perDifStPDQ_cond3: "Percent difference between reported state condensate production and calcualted state march totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond4 = .
replace perDifStPDQ_cond4 = 100 * month_cond / 8683841 if cycle_month == 4
label variable perDifStPDQ_cond4 "percent april state condensate production difference"
note perDifStPDQ_cond4: "Percent difference between reported state condensate production and calcualted state april totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond5 = .
replace perDifStPDQ_cond5 = 100 * month_cond / 9226974 if cycle_month == 5
label variable perDifStPDQ_cond5 "percent may state condensate production difference"
note perDifStPDQ_cond5: "Percent difference between reported state condensate production and calcualted state may totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond6 = .
replace perDifStPDQ_cond6 = 100 * month_cond / 9302578 if cycle_month == 6
label variable perDifStPDQ_cond6 "percent june state condensate production difference"
note perDifStPDQ_cond6: "Percent difference between reported state condensate production and calcualted state june totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond7 = .
replace perDifStPDQ_cond7 = 100 * month_cond / 9769855 if cycle_month == 7
label variable perDifStPDQ_cond7 "percent july state condensate production difference"
note perDifStPDQ_cond7: "Percent difference between reported state condensate production and calcualted state july totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond8 = .
replace perDifStPDQ_cond8 = 100 * month_cond / 10009689 if cycle_month == 8
label variable perDifStPDQ_cond8 "percent august state condensate production difference"
note perDifStPDQ_cond8: "Percent difference between reported state condensate production and calcualted state august totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond9 = .
replace perDifStPDQ_cond9 = 100 * month_cond / 10113865 if cycle_month == 9
label variable perDifStPDQ_cond9 "percent september state condensate production difference"
note perDifStPDQ_cond9: "Percent difference between reported state condensate production and calcualted state september totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond10 = .
replace perDifStPDQ_cond10 = 100 * month_cond / 10759148 if cycle_month == 10
label variable perDifStPDQ_cond10 "percent october state condensate production difference"
note perDifStPDQ_cond10: "Percent difference between reported state condensate production and calcualted state october totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond11 = .
replace perDifStPDQ_cond11 = 100 * month_cond / 10901149 if cycle_month == 11
label variable perDifStPDQ_cond11 "percent november state condensate production difference"
note perDifStPDQ_cond11: "Percent difference between reported state condensate production and calcualted state november totals (state production - state production calculated from PDQ)"
gen perDifStPDQ_cond12 = .
replace perDifStPDQ_cond12 = 100 * month_cond / 11191051 if cycle_month == 12
label variable perDifStPDQ_cond12 "percent december state condensate production difference"
note perDifStPDQ_cond12: "Percent difference between reported state condensate production and calcualted state december totals (state production - state production calculated from PDQ)"
sum difStPDQ_cond1 difStPDQ_cond2 difStPDQ_cond3 difStPDQ_cond4 ///
	difStPDQ_cond5 difStPDQ_cond6 difStPDQ_cond7 difStPDQ_cond8 ///
	difStPDQ_cond9 difStPDQ_cond10 difStPDQ_cond11 difStPDQ_cond12 ///
	perDifStPDQ_cond1 perDifStPDQ_cond2 perDifStPDQ_cond3 perDifStPDQ_cond4 ///
	perDifStPDQ_cond5 perDifStPDQ_cond6 perDifStPDQ_cond7 perDifStPDQ_cond8 ///
	perDifStPDQ_cond9 perDifStPDQ_cond10 perDifStPDQ_cond11 perDifStPDQ_cond12, ///
	separator(3)
label variable cycle_month "Month of production/disposition"
save monthWellTotals
//
// the rest should be compared to graphs at http://www.rrc.state.tx.us/media/18802/flaring-graph.png on October 24, 2016
// flaring rate should be .35% - .85% according to state produced graph; they do not say if this is just gas well gas, casinghead gas, or both
// print  summary statistics and graph of percentage of gas produced in Texas that was vented or flared for each month in 2012
cd ..
cd Posted
cd figures
gen perGasVF = 100 * month_gas04 / month_gas
label variable perGasVF "Percent gas well gas vented or flared"
note perGasVF: "Percent gas well gas vented or flared"
line perGasVF cycle_month, title(Percent Gas Well Gas Vented or Flared) ///
	subtitle(Each Month in 2012) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-perGasVfLine_20161117.pdf
//
// print  summary statistics and graph of total gas produced in Texas that was vented or flared for each month in 2012
line month_gas04 cycle_month, title(Total Gas Well Gas Vented or Flared In MCF) ///
	subtitle(Each Month in 2012) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasVfLine_20161117.pdf
//
// print summary statistics and graph of percentage casinghead gas produced in Texas that was vented or flared or each month in 2012
gen perCsgdVF = 100 * month_csgd04 / month_csgd
label variable perCsgdVF "Percent condensate gas vented or flared"
note perCsgdVF: "Percent condensate gas vented or flared"
line perCsgdVF cycle_month, title(Percent Casinghead Gas Vented or Flared) ///
	subtitle(Each Month in 2012) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-perCsgdVfLine_20161117.pdf
//
// print summary statistics and graph of total casinghead gas produced in Texas that was vented or flared or each month in 2012
line month_csgd04 cycle_month, title(Total Casinghead Gas Vented or Flared In MCF) ///
	subtitle(Each Month in 2012) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdVfLine_20161117.pdf
//
// print summary statistics and graph of percentage of gas and casinghead gas produced in texas that was flared or vented for each month in 2012
gen perCsgdGasVF = 100 * (month_csgd04 + month_gas04) / (month_csgd + month_gas)
label variable perCsgdGasVF "percent gas and casinghead vented or flared"
note perCsgdGasVF: "Percent gas well and casinghead gas vented or flared"
line perCsgdGasVF cycle_month, title(Percent Casinghead and Gas Well Gas Vented or Flared) ///
	subtitle(Each Month in 2012) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-perCsgdGasVfLine_20161117.pdf
//
// print summary statistics and graph of total casinghead gas and gas produced in Texas that was vented or flared or each month in 2012
gen csgdGasVF = month_csgd04 + month_gas04
label variable csgdGasVF "gas and casinghead vented or flared"
note csgdGasVF: "Total gas well and casinghead gas vented or flared"
line csgdGasVF cycle_month, title(Total Caasinghead and Gas Well Gas Vented or Flared In MCF) ///
	subtitle(Each Month in 2012) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Create histograms for production and disposition  				*/
/********-*********-*********-*********-*********-*********-*********/
// histgrams for oil lease production and disposition
cd ..
use 10-oilProdDisp_20161117
cd figures
histogram lease_oil_dispcd00_vol, percent normal ///
	title(Oil Disposed by Pipeline) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp00Hist_20161117.pdf
histogram lease_oil_dispcd01_vol, percent normal ///
	title(Oil Disposed by Truck) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp01Hist_20161117.pdf
histogram lease_oil_dispcd02_vol, percent normal ///
	title(Oil Disposed by Tank Car or Barge) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp02Hist_20161117.pdf
histogram lease_oil_dispcd03_vol, percent normal ///
	title(Oil Disposed by Tank Cleaning) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp03Hist_20161117.pdf
histogram lease_oil_dispcd04_vol, percent normal ///
	title(Oil Disposed For Frac Liquid At Other Lease) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp04Hist_20161117.pdf
histogram lease_oil_dispcd05_vol, percent normal ///
	title(Oil Disposed from a Spill) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp05Hist_20161117.pdf
histogram lease_oil_dispcd06_vol, percent normal ///
	title(Oil Disposed due to basic sediment loss) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp06Hist_20161117.pdf
histogram lease_oil_dispcd07_vol, percent normal ///
	title(Oil Lost) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp07Hist_20161117.pdf
histogram lease_oil_dispcd08_vol, percent normal ///
	title(Oil Disposed to a saltwater gathering system) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp08Hist_20161117.pdf
histogram lease_oil_dispcd09_vol, percent normal ///
	title(Oil Disposed from a Gas Processing Plant) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp09Hist_20161117.pdf
histogram lease_oil_dispcd99_vol, percent normal ///
	title(Oil Disposed without Disposition Code) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDisp99Hist_20161117.pdf
histogram lease_csgd_dispcde01_vol, percent normal ///
	title(Casinghead Gas Used for Field Operations) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp01Hist_20161117.pdf
histogram lease_csgd_dispcde02_vol, percent normal ///
	title(Casinghead Gas Disposed by Transmission Line) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp02Hist_20161117.pdf
histogram lease_csgd_dispcde03_vol, percent normal ///
	title(Casinghead Gas Disposed to a Processing Plant) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp03Hist_20161117.pdf
histogram lease_csgd_dispcde04_vol, percent normal ///
	title(Casinghead Gas Vented or Flared) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp04Hist_20161117.pdf
histogram lease_csgd_dispcde05_vol, percent normal ///
	title(Casinghead Gas Used for Gas Lift) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp05Hist_20161117.pdf
histogram lease_csgd_dispcde06_vol, percent normal ///
	title(Casinghead Gas Used for Pressure Maintenance) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp06Hist_20161117.pdf
histogram lease_csgd_dispcde07_vol, percent normal ///
	title(Casinghead Gas Delivered to Carbon Black Plant) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp07Hist_20161117.pdf
histogram lease_csgd_dispcde08_vol, percent normal ///
	title(Casinghead Gas Injected to Underground StorageReservoir) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp08Hist_20161117.pdf
histogram lease_csgd_dispcde99_vol, percent normal ///
	title(Casinghead Gas Disposed without Disposition Code) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp99Hist_20161117.pdf
histogram lease_oil_prod_vol, percent normal ///
	title(Volume of Crude Oil Produced) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilProdHist_20161117.pdf
histogram lease_oil_allow, percent normal ///
	title(Sum of Oil Well Allowables) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilAllowHist_20161117.pdf
histogram lease_oil_ending_bal, percent normal ///
	title(Lease Monthly Total Oil Stock at Hand) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilEndBalHist_20161117.pdf
histogram lease_oil_tot_disp, percent normal ///
	title(Total Volume of Crude Oil Disposed) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilDispHist_20161117.pdf
histogram lease_csgd_prod_vol, percent normal ///
	title(Total Volume of Casinghead Gas Produced) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdProdHist_20161117.pdf
histogram lease_csgd_limit, percent normal ///
	title(Sum of the Casinghead Limit Daily Allowables) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdAllowHist_20161117.pdf	 
histogram lease_csgd_gas_lift, percent normal ///
	title(Sum of the Casinghead Gas Used for Gas Lift) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdGasLiftHist_20161117.pdf
histogram lease_csgd_tot_disp, percent normal ///
	title(Total Casinghead Gas Disposed) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDispHist_20161117.pdf
histogram perCsgdFV, percent normal ///
	title(Percent Casinghead Gas Vented or Flared) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdVfHist_20161117.pdf
clear
cd ..
//
// histograms for gas well production and disposition
use 10-gasProdDisp_20161117
cd figures
histogram lease_gas_dispcd01_vol, percent normal ///
	title(Gas Well Gas Used for Field Operations) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp01Hist_20161117.pdf
histogram lease_gas_dispcd02_vol, percent normal ///
	title(Gas Well Gas Disposed by Transmission Line) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp02Hist_20161117.pdf
histogram lease_gas_dispcd03_vol, percent normal ///
	title(Gas Well Gas Disposed to a Processing Plant) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp03Hist_20161117.pdf
histogram lease_gas_dispcd04_vol, percent normal ///
	title(Gas Well Gas Vented or Flared) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp04Hist_20161117.pdf
histogram lease_gas_dispcd05_vol, percent normal ///
	title(Gas Well Gas Used for Gas Lift) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp05Hist_20161117.pdf
histogram lease_gas_dispcd06_vol, percent normal ///
	title(Gas Well Gas Used for Pressure Maintenance) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp06Hist_20161117.pdf
histogram lease_gas_dispcd07_vol, percent normal ///
	title(Gas Well Gas Delivered to Carbon Black Plant) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp07Hist_20161117.pdf
histogram lease_gas_dispcd08_vol, percent normal ///
	title(Gas Well Gas Injected into Underground Storage Reservoir) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp08Hist_20161117.pdf
histogram lease_gas_dispcd09_vol, percent normal ///
	title(Gas Well Gas Lost from Shrinkage During Seperation Methods) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp09Hist_20161117.pdf
histogram lease_gas_dispcd99_vol, percent normal ///
	title(Gas Well Gas Disposed withoud Disposition Code) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp99Hist_20161117.pdf
histogram perGasFV, percent normal ///
	title(Percent Gas Well Gas Vented or Flared) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasVfHist_20161117.pdf
histogram lease_cond_dispcd00_vol, percent normal ///
	title(Condensate Gas Disposed by Pipeline) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp00Hist_20161117.pdf
histogram lease_cond_dispcd01_vol, percent normal ///
	title(Condensate Gas Disposed by Truck) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp01Hist_20161117.pdf
histogram lease_cond_dispcd02_vol, percent normal ///
	title(Condensate Gas Disposed by Tank Car or Barge) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp02Hist_20161117.pdf
histogram lease_cond_dispcd03_vol, percent normal ///
	title(Condensate Gas Disposed by Tank Cleaning) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp03Hist_20161117.pdf
histogram lease_cond_dispcd04_vol, percent normal ///
	title(Condensate Gas Disposed for Use as Frac Liquid at Other Lease) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp04Hist_20161117.pdf
histogram lease_cond_dispcd05_vol, percent normal ///
	title(Condensate Gas Lost from Spill) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp05Hist_20161117.pdf
histogram lease_cond_dispcd06_vol, percent normal ///
	title(Condensate Gas Basic Sediment Loss) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp06Hist_20161117.pdf
histogram lease_cond_dispcd07_vol, percent normal ///
	title(Condensate Gas Lost from Stock Adjustments Water Bleed-off Lease Use Road Oil and Theft) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp07Hist_20161117.pdf
histogram lease_cond_dispcd08_vol , percent normal ///
	title(Condensate Gas Disposed by Others through Saltwater Gathering System) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp08Hist_20161117.pdf
histogram lease_cond_dispcd99_vol, percent normal ///
	title(Condensate Gas Disposed without Disposition Code) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDisp99Hist_20161117.pdf
histogram lease_gas_prod_vol, percent normal ///
	title(Total Volume of Gas Well Gas Produced) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasProdHist_20161117.pdf
histogram lease_gas_allow, percent normal ///
	title(Sum of Gas Well Allowables) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasAllowHist_20161117.pdf
histogram lease_gas_lift_inj_vol, percent normal ///
	title(Total Gas Used Given or Sold for Gas Lift) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasLiftHist_20161117.pdf
histogram lease_gas_tot_disp, percent normal ///
	title(Total Gas Disposed) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDispHist_20161117.pdf
histogram lease_cond_prod_vol, percent normal ///
	title(Total Condensate Gas Produced) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condProdHist_20161117.pdf
histogram lease_cond_limit, percent normal ///
	title(Sum of Condensate Limit Daily Amounts For All Prorated Wells) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condLimitHist_20161117.pdf
histogram lease_cond_ending_bal, percent normal ///
	title(Total Stock at Hand) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condEndBalHist_20161117.pdf
histogram lease_cond_tot_disp, percent normal ///
	title(Total Condensate Disposed) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condDispHist_20161117.pdf 
//
/********-*********-*********-*********-*********-*********-*********/
/* Repeat prelim_sumStatistics						  				*/
/********-*********-*********-*********-*********-*********-*********/
clear
cd ..
// find number of unique gas wells reporting disposition in 2012
use 10-gasProdDisp_20161117
keep wellID
duplicates drop
count
clear 
//
// find number of unique operators reporting disposition in 2012
use 10-gasProdDisp_20161117
keep operator_no 
duplicates drop
count
clear
//
// find summary statistics on the number of wells within operating companines in 2012
use 10-gasProdDisp_20161117
keep wellID operator_no 
sort operator_no wellID
by operator_no: gen opWells = _N
keep operator_no opWells
duplicates drop
summarize opWells
count if opWells <= 5
count if opWells > 5
clear
// find summary statistics on the number of gas wells that vent and flare within operating companies in 2012
use 10-gasProdDisp_20161117
keep if lease_gas_dispcd04_vol > 0
keep wellID operator_no 
sort operator_no wellID
by operator_no: gen opWells = _N
keep operator_no opWells
duplicates drop
summarize opWells
count if opWells <= 5
count if opWells > 5
clear
//
// find number of unique oil leases reporting disposition in 2012
use 10-oilProdDisp_20161117
keep wellID
duplicates drop
count
clear 
//
// find number of unique operators reporting oil disposition in 2012
use 10-oilProdDisp_20161117
keep operator_no 
duplicates drop
count
clear
//
// find summary statistics on the number of oil leases within operating companines in 2012
use 10-oilProdDisp_20161117
keep wellID operator_no 
sort operator_no wellID
by operator_no: gen opWells = _N
keep operator_no opWells
duplicates drop
summarize opWells
count if opWells <= 5
count if opWells > 5
clear
// find summary statistics on the number of gas wells that vent and flare within operating companies in 2012
use 10-oilProdDisp_20161117
keep if lease_csgd_dispcde04_vol > 0
keep wellID operator_no 
sort operator_no wellID
by operator_no: gen opWells = _N
keep operator_no opWells
duplicates drop
summarize opWells
count if opWells <= 5
count if opWells > 5
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Find number of wells and operators that flare or vent gas and 	*/
/* histograms showing variation among polluting wells				*/
/********-*********-*********-*********-*********-*********-*********/
// find count number of oil leases that flare or vent gas
use 10-gasProdDisp_20161117
keep if lease_gas_dispcd04_vol > 0
keep wellID
duplicates drop
count
clear
// find count number of operators that control gas wells that flare or vent gas
use 10-gasProdDisp_20161117
keep if lease_gas_dispcd04_vol > 0
keep operator_no 
duplicates drop
count
clear
//
// find gas well histograms
use 10-gasProdDisp_20161117
cd figures
keep if lease_gas_dispcd04_vol > 0
histogram lease_cond_prod_vol, percent normal ///
	title(Total Condensate Gas Produced Among Wells that Vent and Flare) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-condProdAmongPollutersHist_20161117.pdf
histogram lease_gas_prod_vol, percent normal ///
	title(Total Volume of Gas Well Gas Produced Among Wells that Vent and Flare) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasProdAmongPollutersHist_20161117.pdf
histogram lease_gas_dispcd04_vol, percent normal ///
	title(Gas Well Gas Vented or Flared Gas Among Wells that Vent and Flare) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasDisp04amongPollutersHist_20161117.pdf
histogram perGasFV, percent normal ///
	title(Percent Gas Well Gas Vented or Flared Among Wells that Vent and Flare) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-gasVfAmongPollutersHist_20161117.pdf
cd ..
clear
//
// find count number of oil leases that flare or vent gas
use 10-oilProdDisp_20161117
keep if lease_csgd_dispcde04_vol > 0
keep wellID
duplicates drop
count
clear
// find count number of operators that control oil leases that flare or vent gas
use 10-oilProdDisp_20161117
keep if lease_csgd_dispcde04_vol > 0
keep operator_no 
duplicates drop
count
clear
//
// find oil lease histograms
use 10-oilProdDisp_20161117
cd figures
keep if lease_csgd_dispcde04_vol > 0
histogram lease_oil_prod_vol, percent normal ///
	title(Volume of Crude Oil Produced Among Wells that Vent and Flare) subtitle(In Barrels) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-oilProdAmongHist_20161117.pdf
histogram lease_csgd_prod_vol, percent normal ///
	title(Total Volume of Casinghead Gas Produced Among Wells that Vent and Flare) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdProdAmongPollutersHist_20161117.pdf
histogram lease_csgd_dispcde04_vol, percent normal ///
	title(Casinghead Gas Vented or Flared Among Wells that Vent and Flare) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdDisp04amongPollutersHist_20161117.pdf
histogram perCsgdFV, percent normal ///
	title(Percent Casinghead Gas Vented or Flared Among Wells that Vent and Flare) subtitle(In MCF) ///
	note(Texas Railroad Commission Production Data Query Dump 2012) scheme(sj)
graph export 11-csgdVfAmongPollutersHist_20161117.pdf
clear all