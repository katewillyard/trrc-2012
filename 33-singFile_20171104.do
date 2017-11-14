cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 33-singFile_20171104, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		33-singFile_20171104.do
// task:		clean and save gas well file
//				clean and save oil lease file
//				clean and save single oil and gas file
//				find summary statistics and regressions for oil leases
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
/* create single county level file									*/
/********-*********-*********-*********-*********-*********-*********/
//
cd original
use s4countyProd12_20170623 
replace county_name = "Dallam" if county_number == 56
replace county_name = "Fannin" if county_number == 75
replace county_name = "Lampasas" if county_number == 141
replace county_name = "DeWitt" if county_name == "De Witt"
cd ..
cd posted
merge 1:1 county_name using 28-txCountyAcs_20170711
cd ..
cd working
replace gas_vf = 0 if _merge ==2
replace csgd_vf = 0 if _merge == 2
replace oil_prod = 0 if _merge == 2
replace gas_prod = 0 if _merge == 2
replace cond_prod = 0 if _merge ==2
replace csgd_prod = 0 if _merge == 2
replace vf_tot = 0 if _merge == 2
replace newComp = 0 if _merge == 2
drop county_number county_fips _merge
save countyTot
clear
cd ..
cd original
import delimited acs2010_landArea.csv, varnames(1)
cd ..
cd working
rename county county_name
label variable county_name "county name"
notes county_name: "Source: U.S. Census Bureau 2010 Redistricting Data"
label variable squaremiles "county land area (in squaremiles)"
notes squaremiles: "Source: U.S. Census Bureau 2010 Redistricting Data"
replace squaremiles = subinstr(squaremiles,",","",.)
destring squaremiles, replace
save pop
clear
cd ..
cd original
import excel nccs_ngoByCounty_tx_20170111.xlsx, sheet("Sheet1") firstrow
cd ..
cd working
gen county_name = subinstr(County, " County, TX","",.)
drop if county_name == "Total"
replace county_name = "DeWitt" if county_name == "Dewitt"
replace county_name = "McLennan" if county_name == "Mclennan"
replace county_name = "McCulloch" if county_name == "Mcculloch"
replace county_name = "McMullen" if county_name == "Mcmullen"
replace county_name = "La Salle" if county_name == "LA Salle"
label variable county_name "county name"
notes county_name: "Source: National Center for Charitable Statistics"
rename NumberofRegisteredOrganizatio registeredorgs
label variable registeredorgs "number of registered nonprofit organizations in county"
notes registeredorgs : "Source: National Center for Charitable Statistics"
keep county_name registeredorgs
drop if county_name == "-"
save ngo
clear
use countyTot
merge 1:1 county_name using pop
drop _merge
merge 1:1 county_name using ngo
replace registeredorgs = 0 if _merge ==1
drop _merge
gen popDensMi = age_pop / squaremiles
label variable popDensMi "peope per square (land) mile in county"
notes popDensMi: "Source: US Census Bureau 2010 Redistricting Data and ACS County Estimates"
save 33-county_20171104, replace
cd ..
cd posted 
save 33-county_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* create single block group level file								*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 30-gasBg_20171104, replace
merge 1:1 geoid using 30-oilBg_20171104
cd ..
cd working
drop _merge
gen vfTot = .
label variable vfTot "total venting/flaring volume"
notes vfTot: "volume (in mcf) of gas well and casinghead gas vented or flared at leases with wellbore surface locations within one mile"
tostring geoid, replace format("%12.0f")
drop if substr(geoid,1,2) != "48"
save 33-bg_20171104, replace
cd ..
cd posted
save 33-bg_20171104
cd ..
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil lease data												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 32-oilWinspect_20171104
cd .. 
cd working
keep if oilTot > 0 | csgdTot > 0
rename avgage avgage
rename avgdepth avgdepth
rename horizontalwells horizontalwells
rename waterwells leaseFreshWells
gen vfLease = .
label variable vfLease "leased vented or flared"
notes vfLease: "
notes vfLease: "Original Source: Texas Railraod Commission Production Data Query Dump"
replace vfLease = 1 if vfTot > 0
replace vfLease = 0 if vfTot == 0
gen permit = .
label variable permit "lease permitted to vent or flare"
notes permit: "1 - lease permitted to vent or flare, 0 - lease not permitted to vent or flare"
notes permit: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
replace permit = 1 if vfPermPermits > 0  | vfTempPermits > 0
replace permit = 0 if vfPermPermits == 0 & vfTempPermits == 0
gen vfRate = .
label variable vfRate "lease veting and flaring rate"
notes vfRate: "amount vented or flared / amount produced"
notes vfRate: "Original Source: Texas Railraod Commission Production Data Query Dump"
replace vfRate = vfTot / csgdTot if csgdTot != 0 | csgdTot != .
replace vfRate = 0 if csgdTot == 0
gen popDensMi = popDens * 2589988.1
label variable popDensMi "population density"
notes popDensMi: "people per square mile  in blcok groups within one mile of well"
notes popDensMi: "Original Source: American Community Survey, 2009-2014"
sort operator_no
by operator_no: egen  opCsgd= sum (csgdTot)
label variable opCsgd "operator casinghead gas production"
notes opCsgd: "Sum volume of casinghead gas produced by operator (in mcf)"
notes opCsgd: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opCsgd: "Created using operator_no and csgdTot in 36-buildingLev1HurdleAll_20170705.do"
by operator_no: egen  opOil = sum (oilTot)
label variable opOil "operator oil production"
notes opOil: "Sum volume of oil produced by operator (in barrels)"
notes opOil: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opOil: "Created using operator_no and oilTot in 36-buildingLev1HurdleAll_20170705.do"
gen opLogOil = .
label variable opLogOil "log of operator oil production"
notes opLogOil: "Logged operator volume of oil produced at lease in 2012 (in barrels)"
notes opLogOil: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opLogOil: "Created using operator_no, condTot, and oilTot in 36-buildingLev1HurdleAll_20170705.do"
replace opLogOil = log(opOil)
gen opLogCsgd = .
label variable opLogCsgd "log of operator casinghead gas production"
notes opLogCsgd: "Logged operator volume of casinghead gas produced at lease in 2012 (in barrels)"
notes opLogCsgd: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opLogCsgd: "Created using operator_no, and csgdTot in 36-buildingLev1HurdleAll_20170705.do"
replace opLogCsgd = log(opCsgd)
gen newWells = .
label variable newWells "new wells on lease"
notes newWells: "1- new wells were build on lease in 2012, 0 - new wells were not build on lease in 2012"
notes newWells: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
notes newWells: "Created using oil_gas_code, leaseWellAge0 and wellAge in 36-buildingLev1HurdleAll_20170705.do"
replace newWells = 1 if leaseWellAge0 > 0 
replace newWells = 0 if leaseWellAge0 == 0 
gen logCsgd = .
label variable logCsgd "log of casinghead gas production"
notes logCsgd: "Logged volume of casinghead gas or gas well gas produced at lease in 2012 (in mcf)"
notes logCsgd: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes logCsgd: "Created using oil_gas_code, csgdTot, and/or gasTot in 36-buildingLev1HurdleAll_20170705.do"
replace logCsgd = log(csgdTot)
gen logOil = .
label variable logOil "log of oil production"
notes logOil: "Logged volume of oil or gas condensate produced at lease in 2012 (in barrels)"
notes logOil: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes logOil: "Created using oil_gas_code, oilTot, and/or condTot in 36-buildingLev1HurdleAll_20170705.do"
replace logOil = log(oilTot)
sort operator_no
by operator_no: egen opVfTot = sum(vfTot)
label variable opVfTot "operator total venting and flaring volume"
notes opVfTot: "Total volume of casinghead gas vented or flared by operator in 2012 (in mcf)"
notes opVfTot: "Source: Texas Railroad Commission Production Data Dump"
gen opVf = .
label variable opVf "operator vented or flared"
notes opVf: "Operators that vented or flared casinghead or gas well gas in 2012"
notes opVf: "Source: Texas Railroad Commission Production Data Dump"
replace opVf = 1 if opVfTot > 0
replace opVf = 0 if opVfTot == 0
by operator_no: egen opmVfTot = mean (vfTot)
label variable opmVfTot "operator mean lease vent flare volume"
notes opmVfTot: "Average value of gas vented or flared at operator's leases"
notes opmVfTot: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPerPov = mean (perPov)
label variable opmPerPov "operator mean percent poor surrounding lease"
notes opmPerPov: "Average value of the percent in poverty surrounding the operator's leases"
notes opmPerPov: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmIncMedian= mean(incMedian)
label variable opmIncMedian "operator mean lease surrounding income median"
notes opmIncMedian: "Average value of the median incomes surrounding the operator's leases"
notes opmIncMedian: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmOohuMedian = mean(oohuMedian)
label variable opmOohuMedian "operator mean lease surrouding median housing value"
notes opmOohuMedian: "Average value of the median owner occupied household values surrounding the operator's leases"
notes opmOohuMedian: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPerBlack = mean(perBlack)
label variable opmPerBlack "operator mean percent black surrounding lease"
notes opmPerBlack: "Average value of the percent black surrounding the operator's leases"
notes opmPerBlack: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPerHisp = mean(perHisp)
label variable opmPerHisp "operator mean percent hispanic surrounding lease"
notes opmPerHisp: "Average value of the percent hispanic surrounding the operator's leases"
notes opmPerHisp: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPopDensMi = mean(popDensMi)
label variable opmPopDensMi "operator mean population density surrounding lease"
notes opmPopDensMi: "Average population density surrounding the operator's leases"
notes opmPopDensMi: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmRegisteredorgs = mean(registeredorgs)
label variable opmRegisteredorgs "operator mean ngos in lease county"
notes opmRegisteredorgs: "Average number of registered nonprofit organizations surrouding the operator's leases"
notes opmRegisteredorgs: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPermit = mean(permit)
label variable opmPermit "operator fraction leases permitted to vent or flare"
notes opmPermit: "Fraction of the operator's leases that are oil leases"
notes opmPermit: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmLSwr32Vio = mean(lSwr32Vio)
label variable opmLSwr32Vio "operator fraction leases with venting or flaring violations"
notes opmLSwr32Vio: "Average number of venting and flaring violations at the operator's leases"
notes opmLSwr32Vio: "Source: Texas Railroad Commission Production Data Dump" 
by operator_no: egen opmLogOil = mean(logOil)
label variable opmLogOil "operator mean lease log oil produced"
notes opmLogOil: "Average value of the log oil or condensate produced at the operator's leases"
notes opmLogOil: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmLogCsgd = mean(logCsgd)
label variable opmLogCsgd "operator mean lease log casinghead gas produced"
notes opmLogCsgd: "Average value of the log casinghead produced at the operator's leases"
notes opmLogCsgd: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPipedistft = mean(pipedistft)
label variable opmPipedistft "operator mean lease distance to pipeline in ft"
notes opmPipedistft: "Average value of the distance between the lease and the nearest oil and gas pipeline"
notes opmPipedistft: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmNewWells = mean(newWells)
label variable opmNewWells "operator mean lease fraction new wells"
notes opmNewWells: "Average value of the number of new wells build on the operator's leases in 2012"
notes opmNewWells: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmWellDens = mean(welldens)
label variable opmWellDens
notes opmWellDens: "Average value of the well density surrounding the operator's leases"
notes opmWellDens: "Source: Texas Railroad Commission Production Data Dump"
gen avgage2 = avgage * avgage
label variable avgage2 "mean square age of wells on lease"
notes avgage2: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes avgage2: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
by operator_no: egen opmWellDepth = mean(avgdepth)
label variable opmWellDepth "operator mean lease mean well depth"
notes opmWellDepth: "Operator mean lease mean well depth"
notes opmWellDepth: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24da"
by operator_no: egen opmWells = mean(leaseWells)
label variable opmWells "operator mean wells on lease"
notes opmWells: "Operator mean wells on lease"
notes opmWells: "Created in 30-fixComChar_20171104 using 19-gas_20161230.csv"
by operator_no: egen opmHorizWells = mean(horizontalwells)
label variable opmHorizWells "operator mean portion horizontal wells"
notes opmHorizWells: "Operator mean portion horizontal wells"
notes opmHorizWells: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24da"
by operator_no: egen opmFreshWells = mean(leaseFreshWells)
label variable opmFreshWells
notes opmFreshWells: "operator mean portion freshwater wells"
notes opmFreshWells: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24da"
by operator_no: egen opmAge = mean(avgage)
label variable opmAge "operator mean of mean age of wells on lease"
notes opmAge: "Operator mean of mean age of wells on lease"
notes opmAge: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes opmAge: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
by operator_no: egen opmAge2 = mean(avgage2)
label variable opmAge2 "operator mean of mean square age of wells on lease"
notes opmAge2 : "Operator mean of mean square age of wells on lease"
notes opmAge2: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes opmAge2: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label data "2012 Texas oil lease information"
drop if vfTot == . & oilTot == . & csgdTot == .
save 33-oil_20171104, replace
cd ..
cd posted
save 33-oil_20171104 
cd ..
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* clean gas well data												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 30-collapsedGas_20170322
keep wellop registeredorgs county f990orgs countyngorevenue ///
	countyngoassets f990norgs f990or990norgs
sort wellop
quietly by wellop: gen dup = _n
drop if dup > 1
drop dup
merge 1:1 wellop using 32-gasWinspect_20171104
drop _merge
cd .. 
cd working
drop if vfTot == . & lease_gas_prod_vol == . & lease_cond_prod_vol == .
replace horizontalWell = "0" if horizontalWell == "N"
replace horizontalWell = "1" if horizontalWell == "Y"
destring horizontalWell, replace
replace freshWaterWell = "0" if freshWaterWell == "N"
replace freshWaterWell = "1" if freshWaterWell == "Y"
destring freshWaterWell, replace
keep if gasTot > 0 | condTot > 0 
gen vfLease = .
label variable vfLease "leased vented or flared"
notes vfLease: "
notes vfLease: "Original Source: Texas Railraod Commission Production Data Query Dump"
replace vfLease = 1 if vfTot > 0
replace vfLease = 0 if vfTot == 0
gen permit = .
label variable permit "lease permitted to vent or flare"
notes permit: "1 - lease permitted to vent or flare, 0 - lease not permitted to vent or flare"
notes permit: "Original Source: FVPM_fvf615.dat received on April 26, 2016 in an email from Matt Bowman, Railroad Commission of Texas entitled SWR32 Data sent to kate.willyard@tamu.edu"
replace permit = 1 if vfPermPermits > 0  | vfTempPermits > 0
replace permit = 0 if vfPermPermits == 0 & vfTempPermits == 0
gen vfRate = .
label variable vfRate "lease veting and flaring rate"
notes vfRate: "amount vented or flared / amount produced"
notes vfRate: "Original Source: Texas Railraod Commission Production Data Query Dump"
replace vfRate = vfTot / gasTot if gasTot != 0 | gasTot != .
replace vfRate = 0 if gasTot == 0
gen popDensMi = popDens * 2589988.1
label variable popDensMi "population density"
notes popDensMi: "people per square mile  in blcok groups within one mile of well"
notes popDensMi: "Original Source: American Community Survey, 2009-2014"
sort operator_no
by operator_no: egen opGas = sum (gasTot)
label variable opGas "operator gas well gas production"
notes opGas: "Sum volume of gas well gas produced by operator (in mcf)"
notes opGas: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opGas: "Created using operator_no and gasTot in 36-buildingLev1HurdleAll_20170705.do"
by operator_no: egen  opCond= sum (condTot)
label variable opCond "operator condensate gas production"
notes opCond: "Sum volume of condensate gas produced by operator (in barrels)"
notes opCond: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opCond: "Created using operator_no and condTot in 36-buildingLev1HurdleAll_20170705.do"
gen opLogGas = .
label variable opLogGas "log of operator gas well gas production"
notes opLogGas: "Logged operator volume of casinghead and gas well gas produced at lease in 2012 (in barrels)"
notes opLogGas: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opLogGas: "Created using operator_no, csgdTot, and gasTot in 36-buildingLev1HurdleAll_20170705.do"
replace opLogGas = log(opGas)
gen opLogCond = .
label variable opLogCond "log of operator condensate gas production"
notes opLogCond: "Logged operator volume of casinghead and gas well gas produced at lease in 2012 (in barrels)"
notes opLogCond: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes opLogCond: "Created using operator_no, csgdTot, and gasTot in 36-buildingLev1HurdleAll_20170705.do"
replace opLogCond = log(opCond)
gen newWells = .
label variable newWells "new well"
notes newWells: "1- new well was established in 2012, 0 - new well was established before 2012"
notes newWells: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
notes newWells: "Created using oil_gas_code, leaseWellAge0 and wellAge in 36-buildingLev1HurdleAll_20170705.do"
replace newWells = 1 if wellAge == 0 
replace newWells = 0 if wellAge > 0 
gen logGas = .
label variable logGas "log of gas well gas production"
notes logGas: "Logged volume of gas well gas produced at lease in 2012 (in mcf)"
notes logGas: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes logGas: "Created using oil_gas_code, csgdTot, and/or gasTot in 36-buildingLev1HurdleAll_20170705.do"
replace logGas = log(gasTot)
gen logCond = .
label variable logCond "log of condensate gas production"
notes logCond: "Logged volume of condensate gas produced at lease in 2012 (in mcf)"
notes logCond: "Original Source: Texas Railroad Commission Production Data Query Dump"
notes logCond: "Created using oil_gas_code, csgdTot, and/or gasTot in 36-buildingLev1HurdleAll_20170705.do"
replace logCond = log(condTot)
sort operator_no
by operator_no: egen opVfTot = sum (vfTot)
label variable opVfTot "operator total venting and flaring volume"
notes opVfTot: "Total volume of gas well gas vented or flared by operator in 2012 (in mcf)"
notes opVfTot: "Source: Texas Railroad Commission Production Data Dump"
gen opVf = .
label variable opVf "operator vented or flared"
notes opVf: "Operators that vented or flared gas well gas in 2012"
notes opVf: "Source: Texas Railroad Commission Production Data Dump"
replace opVf = 1 if opVfTot > 0
replace opVf = 0 if opVfTot == 0
by operator_no: egen opmVfTot = mean (vfTot)
label variable opmVfTot "operator mean lease vent flare volume"
notes opmVfTot: "Average value of gas vented or flared at operator's leases"
notes opmVfTot: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPerPov = mean (perPov)
label variable opmPerPov "operator mean percent poor surrounding lease"
notes opmPerPov: "Average value of the percent in poverty surrounding the operator's leases"
notes opmPerPov: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmIncMedian= mean(incMedian)
label variable opmIncMedian "operator mean lease surrounding income median"
notes opmIncMedian: "Average value of the median incomes surrounding the operator's leases"
notes opmIncMedian: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmOohuMedian = mean(oohuMedian)
label variable opmOohuMedian "operator mean lease surrouding median housing value"
notes opmOohuMedian: "Average value of the median owner occupied household values surrounding the operator's leases"
notes opmOohuMedian: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPerBlack = mean(perBlack)
label variable opmPerBlack "operator mean percent black surrounding lease"
notes opmPerBlack: "Average value of the percent black surrounding the operator's leases"
notes opmPerBlack: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPerHisp = mean(perHisp)
label variable opmPerHisp "operator mean percent hispanic surrounding lease"
notes opmPerHisp: "Average value of the percent hispanic surrounding the operator's leases"
notes opmPerHisp: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPopDensMi = mean(popDensMi)
label variable opmPopDensMi "operator mean population density surrounding lease"
notes opmPopDensMi: "Average population density surrounding the operator's leases"
notes opmPopDensMi: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmRegisteredorgs = mean(registeredorgs)
label variable opmRegisteredorgs "operator mean ngos in lease county"
notes opmRegisteredorgs: "Average number of registered nonprofit organizations surrouding the operator's leases"
notes opmRegisteredorgs: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmLogGas = mean(logGas)
label variable opmLogGas "operator mean lease log gas produced"
notes opmLogGas: "Average value of the log gas well gas or casinghead gas produced at opereator's leases"
notes opmLogGas: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmLogCond = mean(logCond)
label variable opmLogCond "operator mean lease log cond produced"
notes opmLogCond: "Average value of the log condensate gas produced at opereator's leases"
notes opmLogCond: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmPermit = mean(permit)
label variable opmPermit "operator fraction leases permitted to vent or flare"
notes opmPermit: "Fraction of the operator's leases that are oil leases"
notes opmPermit: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmLSwr32Vio = mean(lSwr32Vio)
label variable opmLSwr32Vio "operator fraction leases with venting or flaring violations"
notes opmLSwr32Vio: "Average number of venting and flaring violations at the operator's leases"
notes opmLSwr32Vio: "Source: Texas Railroad Commission Production Data Dump" 
by operator_no: egen opmPipedistft = mean(pipedistft)
label variable opmPipedistft "operator mean lease distance to pipeline in ft"
notes opmPipedistft: "Average value of the distance between the lease and the nearest oil and gas pipeline"
notes opmPipedistft: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmNewWells = mean(newWells)
label variable opmNewWells "operator mean lease fraction new wells"
notes opmNewWells: "Average value of the number of new wells build on the operator's leases in 2012"
notes opmNewWells: "Source: Texas Railroad Commission Production Data Dump"
by operator_no: egen opmWellDens = mean(welldens)
label variable opmWellDens
notes opmWellDens: "Average value of the well density surrounding the operator's leases"
notes opmWellDens: "Source: Texas Railroad Commission Production Data Dump"
gen wellAge2 = wellAge * wellAge
label variable wellAge2 "square age of well"
notes wellAge2: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes wellAge2: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
by operator_no: egen opmWellDepth = mean(well_depth)
label variable opmWellDepth "operator mean well depth"
notes opmWellDepth: "Operator mean well depth"
notes opmWellDepth: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24da"
by operator_no: egen opmHorizWells = mean(horizontalWell)
label variable opmHorizWells "operator portion horizontal wells"
notes opmHorizWells: "Operator portion horizontal wells"
notes opmHorizWells: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24da"
by operator_no: egen opmFreshWells = mean(freshWaterWell)
label variable opmFreshWells
notes opmFreshWells: "operator portion freshwater wells"
notes opmFreshWells: "Original Data Source: daf802_II.dat obtained from Texas Railroad Commission Digital Download ftp://subkac:24da"
by operator_no: egen opmAge = mean(wellAge)
label variable opmAge "operator mean well age"
notes opmAge: "Operator mean well age"
notes opmAge: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes opmAge: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
by operator_no: egen opmAge2 = mean(wellAge2)
label variable opmAge2 "operator mean of mean square age of wells on lease"
notes opmAge2 : "Operator mean of mean square age of wells on lease"
notes opmAge2: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes opmAge2: "Original Data Source: Well_GIS_4.11 received via email to kate.willyard@tamu.edu entitled IN5524_Well_Org_GIS on April 11, 2016"
label data "2012 Texas gas well information"
save 33-gas_20171104, replace
cd ..
cd posted 
save 33-gas_20171104
cd ..
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil or gas lease data										*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 33-gas_20171104
append using 33-oil_20171104, force
label data "2012 Texas oil and gas lease information"
save 33-oil&gas_20171104, replace
cd ..
clear
//
//