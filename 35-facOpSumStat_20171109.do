cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 35-facOpSumStat_20171109, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		35-facOpSumStat_20171109.do
// task:		find summary statistics for both gas and oil leases
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 11/9/2017
//
//
/********-*********-*********-*********-*********-*********-*********/
/* Set Settings and Working Directory								*/
/********-*********-*********-*********-*********-*********-*********/
//
clear all
version 14
set more off
cd "C:/Users/katew/Documents/eocpc/posted"
//
/********-*********-*********-*********-*********-*********-*********/
/* oil and gas lease summary statistics								*/
/********-*********-*********-*********-*********-*********-*********/
//
// category summary statistics
use 34-oil&gasWsubsid_20171104, replace
drop popDens popDensMi
gen popDens = age_pop / aland 
label variable popDens "people per square meter"
gen popDensMi = popDens * 2589988.11
label variable popDensMi "people per square mile"
label variable popDensMi
drop if perBlack == .
gen gasWell = .
replace gasWell = 1 if oilLease == 0
replace gasWell = 0 if oilLease == 1
label variable gasWell "gas lease"
notes gasWell: "facility is a gas well"
sort operator_no
quietly by operator_no: egen opmPerUneduc = mean(perUneduc)
label variable opmPerUneduc "percent without highschool diploma"
notes opmPerUneduc: "mean operator lease surrounding individuals 25 and older without a higschool diploma"
quietly by operator_no: egen opmPerLimEng = mean(perLimEng)
label variable opmPerLimEng "percent with limited english"
notes opmPerLimEng: "mean operator lease surrounding housheholds with limited english"
quietly by operator_no: egen opmGasWells = mean(gasWell)
label variable opmGasWells "portion of leases that are gas wells"
notes opmGasWells: "mean operator leases that are gas wells"
gen inc_category = .
replace inc_category = 1 if incMedian <= 7 & incMedian != .
replace inc_category = 2 if incMedian >= 8 & incMedian <= 12 & incMedian != .
replace inc_category = 3 if incMedian >= 13 & incMedian != .
label variable inc_category "housheold income category"
notes inc_category: "1: less than 35K, 2: 35K - Less than 100K, 3: 100K or more"
sort inc_category
by inc_category: sum vfTot
gen oohu_category = .
replace oohu_category = 1 if oohuMedian <= 13 & oohuMedian != .
replace oohu_category = 2 if oohuMedian >= 14 & oohuMedian <= 18 & oohuMedian != .
replace oohu_category = 3 if oohuMedian >= 19 & oohuMedian != .
label variable oohu_category "owner occupied household value"
notes oohu_category: "1: less than 100K, 2: 100K - Less than 250K, 3: 250K or More"
sort oohu_category
by oohu_category: sum vfTot
gen educ_category = .
replace educ_category = 1 if perUneduc < 14 & perUneduc != .
replace educ_category = 2 if perUneduc >= 14 & perUneduc <= 25 & perUneduc != .
replace educ_category = 3 if perUneduc > 25 & perUneduc != .
label variable educ_category "education category"
notes educ_category: "1: less than 14% are uneducated, 2: 14-25% are uneducated, 3: more than 25% uneducated"
sort educ_category
by educ_category: sum vfTot 
gen popDens_category = .
replace popDens_category = 1 if popDensMi < 3 & popDensMi != .
replace popDens_category = 2 if popDensMi >= 3 & popDensMi <=30 & popDensMi != .
replace popDens_category = 3 if popDensMi > 30 & popDensMi != .
label variable popDens_category "population density category"
notes popDens_category: "1: less than 3 people per square mile. 2: 3-30 people per square mile, 3: more than 30 people per square mile"
sort popDens_category
by popDens_category: sum vfTot
gen org_category = .
replace org_category = 1 if registeredorgs < 30 & registeredorgs != .
replace org_category = 2 if registeredorgs >= 30 & registeredorgs <= 200 & registeredorgs != .
replace org_category = 3 if registeredorgs > 200 & registeredorgs != .
label variable org_category "organizational capacity category"
notes org_category: "1: less than 30 ngos registered in county, 2: 30-200 ngo registered in county. 3: more than 200 ngos registered in county"
sort org_category
by org_category: sum vfTot
gen race_category = .
replace race_category = 1 if perWhite > 50 & perWhite != .
replace race_category = 2 if perBlack > 50 & perBlack != .
replace race_category = 3 if perHisp > 50 & perHisp != .
label variable race_category "racial majority category"
notes race_category: "1- majority white. 2- majority black. 3- majority hispanic"
sort race_category
by race_category: sum vfTot
replace leasewells = 1 if gasWell == 1
replace opGasOilRatio = opCsgdGas / opOilCond
sort operator_no
drop opmLogCsgdGas
quietly by operator_no: egen opmLogCsgdGas = mean(logCsgdGas)
drop opGasOilRatio
gen opGasOilRatio = opCsgdGas / opOilCond
save 35-og12_20171109
// cross tabulations
tab vfLease opVf
tab vfLease opLexNexCat
// summary statistics
sum vfLease vfTot lnVfRate incMedian oohuMedian  ///
	popDensMi registeredorgs perBlack perHisp permit ///
	lSwr32Vio gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft avgdepth leaseFreshWells ///
	horizontalwells avgage operatorRRCage ///
	opLogWells opGasOilRatio ///
	opSubsidiary subsidLevel parSubsid opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs opmPerBlack ///
	opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens opmLeaseWells ///
	opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells opmLeaseHorizWells ///
	opmLeaseAgeMean2 
sort vfLease 
by vfLease: sum vfTot lnVfRate incMedian oohuMedian  ///
	popDensMi registeredorgs perBlack perHisp permit ///
	lSwr32Vio gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft avgdepth leaseFreshWells ///
	horizontalwells avgage operatorRRCage ///
	opLogWells opGasOilRatio ///
	opSubsidiary subsidLevel parSubsid opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs opmPerBlack ///
	opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens opmLeaseWells ///
	opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells opmLeaseHorizWells ///
	opmLeaseAgeMean2
sum vfLease
// correlations all leases
pwcorr vfTot vfLease lnVfRate incMedian oohuMedian  ///
	popDensMi registeredorgs perBlack perHisp permit ///
	lSwr32Vio gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft avgdepth leaseFreshWells ///
	horizontalwells avgage operatorRRCage ///
	opLogWells opGasOilRatio ///
	opSubsidiary subsidLevel parSubsid opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs opmPerBlack ///
	opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens opmLeaseWells ///
	opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells opmLeaseHorizWells ///
	opmLeaseAgeMean2, sig
// correlations leases that vent or flare
keep if vfLease == 1
pwcorr vfTot lnVfRate incMedian oohuMedian  ///
	popDensMi registeredorgs perBlack perHisp permit ///
	lSwr32Vio gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft avgdepth leaseFreshWells ///
	horizontalwells avgage operatorRRCage ///
	opLogWells opGasOilRatio ///
	opSubsidiary subsidLevel parSubsid opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs opmPerBlack ///
	opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens opmLeaseWells ///
	opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells opmLeaseHorizWells ///
	opmLeaseAgeMean2, sig
// detailed dependent variable summary statistics
use 35-og12_20171109, replace
tabstat vfLease, statistics(mean median skewness kurtosis) by (vfLease) columns(statistics)
tabstat vfTot, statistics(mean median skewness kurtosis) by (vfLease) columns(statistics)
tabstat vfRate, statistics(mean median skewness kurtosis) by (vfLease) columns(statistics)
cd graphs
histogram vfLease, percent normal ///
	title(Venting and Flaring Leases Distribution) subtitle(All Texas Producing Oil and Gas Leases In 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfLeaseHist_20171109.pdf, replace
replace vfTot = vfTot /1000
label variable vfTot "gas vented or flared in thousand mcf (thousand cubic feet)"
label variable vfRate "venting and flaring rate" 
histogram vfTot, percent normal ///
	title(Facility Venting and Flaring Volume Distribution) subtitle(All Texas Producing Oil and Gas Leases In 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfTotAllHist_20171109.pdf, replace
histogram vfRate, percent normal ///
	title(Facility Venting and Flaring Rate Distribution) subtitle(All Texas Producing Oil and Gas Leases In 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfRateAllHist_20171109.pdf, replace
keep if vfLease == 1
histogram vfTot, percent normal ///
	title(Facility Venting and Flaring Volume Distribution) subtitle(Producing Texas Oil and Gas Leases that Vented or Flared in 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfTotVfHist_20171109.pdf, replace
histogram vfRate, percent normal ///
	title(Venting and Flaring Rate Distribution) subtitle(Producing Texas Oil and Gas Leases that Vented or Flared in 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfRateVfHist_20171109.pdf, replace
cd ..
// dispersion of number of leases owned by operators with at lease one well that vents or flares
sort operator_no
quietly by operator_no: egen opVfWells = sum(vfLease)
keep operator_no opVfWells
duplicates drop
tabstat opVfWells, statistics(n mean sd min max median skewness kurtosis) columns(statistics)
count if opVfWells == 1
count if opVfWells == 2
count if opVfWells == 3
count if opVfWells == 4
count if opVfWells == 5
count if opVfWells > 5
clear
// dispersion of number of leases owned by overators with at lease one producing well
use 35-og12_20171109, replace
tabstat opWells, statistics(n mean sd min max median skewness kurtosis) columns(statistics)
count if opWells == 1
count if opWells == 2
count if opWells == 3
count if opWells == 4
count if opWells == 5
count if opWells > 5
// state total amount produced by lease that vented or flared
sort vfLease
quietly by vfLease: egen totGasProd = total(gasTot)
quietly by vfLease: egen totCsgdProd = total(csgdTot)
gen totGasCsgdProd = totGasProd + totCsgdProd
quietly by vfLease: egen totOilProd = total(oilTot)
quietly by vfLease: egen totCondProd = total(condTot)
gen totOilCondProd = totOilProd + totCondProd
by vfLease: sum totGasCsgdProd
by vfLease: sum totOilCondProd
//
//















//
/********-*********-*********-*********-*********-*********-*********/
/* operator summary statistics								*/
/********-*********-*********-*********-*********-*********-*********/
//
// category summary statistics
use 35-og12_20171109, replace
count
keep operator_no opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs opmPerBlack ///
	opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens opmLeaseWells ///
	opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells opmLeaseHorizWells ///
	opmLeaseAgeMean2 operatorRRCage opLogWells opGasOilRatio opSubsidiary ///
	subsidLevel parSubsid  opLexNexCat opLexNexFound
duplicates drop
count
// cross tabulations
tab opVf opLexNexFound
tab opVf opLexNexCat
// summary statistics
sum opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs ///
	opmPerBlack opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens ///
	opmLeaseWells opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells ///
	opmLeaseHorizWells opmLeaseAgeMean2 operatorRRCage ///
	opLogWells opGasOilRatio opSubsidiary subsidLevel parSubsid  
sort opVf
by opVf: sum opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs ///
	opmPerBlack opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens ///
	opmLeaseWells opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells ///
	opmLeaseHorizWells opmLeaseAgeMean2 operatorRRCage ///
	opLogWells opGasOilRatio opSubsidiary subsidLevel parSubsid
sum opVf
// correlations all operators
pwcorr opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs ///
	opmPerBlack opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens ///
	opmLeaseWells opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells ///
	opmLeaseHorizWells opmLeaseAgeMean2 operatorRRCage ///
	opLogWells opGasOilRatio opSubsidiary subsidLevel parSubsid, sig
// correlations leases that vent or flare
keep if opVf == 1
pwcorr opVf opVfTot opVfRate ///
	opmVf opmVfTot opmVfRate opmIncMedian opmOohuMedian opmPerPov ///
	opmPerUneduc opmPerLimEng opmPopDensMi opmRegisteredOrgs ///
	opmPerBlack opmPerHisp opmPermit opmLSwr32Vio opmGasWell ///
	opmLogOilCond opmLogCsgdGas opmNewWells opmWellDens ///
	opmLeaseWells opmPipeDistFt opmLeaseDepthMean opmLeaseFreshWells ///
	opmLeaseHorizWells opmLeaseAgeMean2 operatorRRCage ///
	opLogWells opGasOilRatio opSubsidiary subsidLevel parSubsid, sig
// detailed dependent variable summary statistics
use 35-og12_20171109, replace
tabstat opVf, statistics(mean median skewness kurtosis) by (opVf) columns(statistics)
tabstat opVf, statistics(mean median skewness kurtosis) by (opVf) columns(statistics)
cd graphs
histogram opVf, percent normal ///
	title(Venting and Flaring Operator Distribution) subtitle(All Oprators of Producing Oil and Gas Leases in Texas in 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfOpHist_20171109.pdf, replace
replace opVfTot = vfTot /1000
label variable opVfTot "gas vented or flared in thousand mcf (thousand cubic feet)"
label variable opVfRate "venting and flaring rate" 
histogram opVfTot, percent normal ///
	title(Operator Venting and Flaring Volume Distribution) subtitle(All Oprators of Producing Oil and Gas Leases in Texas in 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfTotAllOpHist_20171109.pdf, replace
histogram vfRate, percent normal ///
	title(Operator Venting and Flaring Rate Distribution) subtitle(All Oprators of Producing Oil and Gas Leases in Texas in 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfRateAllOpHist_20171109.pdf, replace
keep if opVf == 1
histogram opVfTot, percent normal ///
	title(Operator Venting and Flaring Volume Distribution) subtitle(All Oprators of Producing Oil and Gas Leases that Vented or Flared in Texas in 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfTotVfOpHist_20171109.pdf, replace
histogram opVfRate, percent normal ///
	title(Venting and Flaring Rate Distribution) subtitle(All Oprators of Producing Oil and Gas Leases that Vented or Flared in Texas in 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 35-oil&gasVfRateVfOpHist_20171109.pdf, replace
cd ..
//
//