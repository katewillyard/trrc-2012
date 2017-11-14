cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 34-addSubsidInfo_20171104, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		34-addSubsidInfo_20171104.do
// task:		add subsidiary info collected by undergrad
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
//
/********-*********-*********-*********-*********-*********-*********/
/* clean first dataset - collection completed 7/5/2017				*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import excel "Finished-32-operator_Complete_20170705.xlsx", sheet("32-operator_20170516.csv") firstrow
cd .. 
cd working
rename opNotes opNotes1
rename opType opType1
rename opTicker opTicker1
rename subsidLevel subsidLevel1
rename parTicker parTicker1
rename parName parName1
rename parSubsid parSubsid1
rename otherNotes otherNotes1
notes: "Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
save subsid1, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean second dataset - collection completed 7/19/2017			*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited 39-orgsToStillFind_20170719
rename operatorname operatorName
rename operatormailaddress1 operatorMailAddress1
rename operatormailaddress2 operatorMailAddress2
rename operatormailcity operatorMailCity
rename operatormailstate operatorMailState
rename operatormailzip operatorMailZip
rename opnotes opNotes2 
rename optype opType2 
rename opticker opTicker2 
tostring opTicker, replace
rename subsidlevel subsidLevel2 
tostring subsidLevel2, replace
rename particker parTicker2 
rename parname parName2 
rename parsubsid parSubsid2 
tostring parSubsid2, replace
rename othernotes otherNotes2
notes: "Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
cd ..
cd working
save subsid2, replace
clear
//
//
/********-*********-*********-*********-*********-*********-*********/
/* clean third dataset - collection completed 7/19/2017			*/
/********-*********-*********-*********-*********-*********-*********/
//
cd ..
cd posted
import excel 32-operatorGoogleMatch_Completed_20170915, firstrow
rename opNotes opNotes3
rename opType opType3
rename opTicker opTicker3
rename subsidLevel subsidLevel3
rename parTicker parTicker3
rename parName parName3
rename parSubsid parSubsid3
rename otherNotes otherNotes3
notes: "Original Source: 32-operatorGoogleMatch_Completed_20170915 collected by Garrison Reed Barrilleaux"
cd ..
cd working
save subsid3, replace
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* merge and clean all subsidiary data collection files				*/
/********-*********-*********-*********-*********-*********-*********/
//
use subsid1, replace
merge 1:1 operator_no using subsid2, force
drop _merge
merge 1:1 operator_no using subsid3, force
drop _merge
replace opNotes3 = "found" if opNotes3 == "Found"
replace opNotes3 = "found" if opNotes3 == "found "
gen opNotes = opNotes1
replace opNotes = opNotes2 if opNotes1 != "found" & opNotes2 == "found"
replace opNotes = opNotes3 if opNotes1 != "found" & opNotes3 == "found"
gen opType = opType1
replace opType = opType2 if opNotes1 != "found" & opNotes2 == "found"
replace opType = opType3 if opNotes1 != "found" & opNotes3 == "found"
gen opTicker = opTicker1
replace opTicker = opTicker2 if opNotes1 != "found" & opNotes2 == "found"
replace opTicker = opTicker3 if opNotes1 != "found" & opNotes3 == "found"
gen subsidLevel = subsidLevel1
replace subsidLevel = subsidLevel2 if opNotes1 != "found" & opNotes2 == "found"
replace subsidLevel = subsidLevel3 if opNotes1 != "found" & opNotes3 == "found"
gen parTicker = parTicker1
replace parTicker = parTicker2 if opNotes1 != "found" & opNotes2 == "found"
replace parTicker = parTicker3 if opNotes1 != "found" & opNotes3 == "found"
gen parName = parName1
replace parName = parName2 if opNotes1 != "found" & opNotes2 == "found"
replace parName = parName3 if opNotes1 != "found" & opNotes3 == "found"
gen parSubsid = parSubsid1
replace parSubsid = parSubsid2 if opNotes1 != "found" & opNotes2 == "found"
replace parSubsid = parSubsid3 if opNotes1 != "found" & opNotes3 == "found"
gen otherNotes = otherNotes1
replace otherNotes = otherNotes2 if opNotes1 != "found" & opNotes2 == "found"
replace otherNotes = otherNotes3 if opNotes1 != "found" & opNotes3 == "found"


drop operatorName operatorMailAddress1 operatorMailAddress2 ///
	operatorMailCity operatorMailState operatorMailZip operatorMailZipSuf
gen opLexNexFound = .
replace opLexNexFound = 1 if opNotes == "Found" | opNotes == "found" | opNotes == "found "
replace opLexNexFound = 0 if opNotes == "notFound"
label variable opLexNexFound "operator found in Lexis Nexis Corporate Affiliations"
notes opLexNexFound: "Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opLexNexFound: "Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
tab opLexNexFound
drop opNotes
gen opOther = .
label variable opOther "operator type, other than private, parent or subsidiary"
notes opOther:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opOther:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
replace opOther = 1 if opType == "Holding" | opType == "branch" | opType == "holding" | opType == "jointVenture" | opType == "non-operatingEntity" | opType == "unit"
replace opOther = 0 if opType == "parent" | opType == "private" | opType == "subsidiary"
gen opParent = .
label variable opParent "operator is an ultimate parent company"
notes opParent:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opParent:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
replace opParent = 1 if opType == "parent"
replace opParent = 0 if opType == "subsidiary" | opOther == 1 | opType == "private"
gen opPrivate = .
label variable opPrivate "operator is a private company"
notes opPrivate:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opPrivate:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
replace opPrivate = 1 if opType == "private"
replace opPrivate = 0 if opOther == 1 | opParent == 1 | opType == "subsidiary"
gen opSubsidiary = .
label variable opSubsidiary "operator is a subsidiary company"
notes opSubsidiary:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opSubsidiary:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
replace opSubsidiary = 1 if opType == "subsidiary"
replace opSubsidiary = 0 if opOther == 1 | opParent == 1 | opPrivate == 1
gen opMLSF = .
label variable opMLSF "operator is a part of a multilayered subsidiary firm"
notes opMLSF:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opMLSF:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
replace opMLSF = 1 if opSubsidiary == 1 | opParent == 1
replace opMLSF = 0 if opOther == 1 | opPrivate == 1
gen opLexNexCat = .
label variable opLexNexCat "operator lexis nexis category"
notes opLexNexCat: "0-other, 1-subsid, 2-parent,3-private"
notes opLexNexCat:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opLexNexCat:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
replace opLexNexCat = 0 if opOther == 1
replace opLexNexCat = 1 if opSubsidiary == 1
replace opLexNexCat = 2 if opParent == 1
replace opLexNexCat = 3 if opPrivate == 1
drop opType
label variable opTicker "operator ticker symbol"
notes opTicker:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes opTicker:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
label variable subsidLevel "operator subsidiary level"
notes subsidLevel:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes subsidLevel:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
label variable parTicker "operator firm nyse ticker"
notes parTicker:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes parTicker:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
label variable parName "operator firm name"
notes parName:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes parName:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
label variable parSubsid "operator firm subsidiary levels"
notes parSubsid:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes parSubsid:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
label variable otherNotes "notes by lexis nexis data collector"
notes otherNotes:"Original Source: Finished-32-operator_Complete_20170705.xlsx collected by Garrison Reed Barrilleaux"
notes otherNotes:"Original Source: 39-orgsToStillFind_20170719.csv collected by Garrison Reed Barrilleaux"
destring parSubsid, replace
destring subsidLevel, replace
save 34-subsid_20171104, replace
cd ..
cd posted
save 34-subsid_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* connect oil lease data with subsidiary info						*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 33-oil_20171104 
cd ..
cd working
destring operator_no, replace
merge m:1 operator_no using 34-subsid_20171104
keep if _merge == 1 | _merge == 3
drop _merge
keep if ( oilTot > 0 & oilTot != .) | ( csgdTot > 0 & csgdTot != .) 
replace vfTot = 0 if vfTot == .
replace vfLease = 1 if vfTot > 0
replace vfLease = 0 if vfTot == 0
drop opVfTot 
sort operator_no
by operator_no: egen opVfTot = sum (vfTot)
label variable opVfTot "operator sum volume of gas vented or flared"
notes opVfTot: "Sum value of gas vented or flared at operator's leases (in mcf)"
notes opVfTot: "Source: Texas Railroad Commission Production Data Dump"
replace opVf = 1 if opVfTot > 0
replace opVf = 0 if opVfTot == 0
replace vfRate = vfTot / csgdTot
replace vfRate = 0 if vfRate == .
gen opVfRate = opVfTot / opCsgd
label variable opVfRate "operator venting and flaring rate"
notes opVfRate: "operator volume of casinghead gas vented or flared / operator volume of casinghead gas produced"
notes opVfRate: "Source: Texas Railroad Commission Production Data Dump"
gen opVfPercent = 100 * opVfTot / opCsgd
label variable opVfPercent "operator venting and flaring percentage"
notes opVfPercent: "100 * operator volume of casinghead gas vented or flared / operator volume of casinghead gas produced"
notes opVfPercent: "Source: Texas Railroad Commission Production Data Dump"
drop opCsgdProd opOilProd 
sort operator_no
quietly by operator_no: egen opmVfRate = mean(vfRate)
label variable opmVfRate "operator mean venting and flaring rate"
notes opmVfRate: "operator mean volume of casinghead  gas vented or flared / operator volume of casinghead gas produced"
notes opmVfRate: "Source: Texas Railroad Commission Production Data Dump"
quietly by operator_no: egen opmVf = mean (vfLease)
label variable opmVf "operator portion of leases that vented or flared"
notes opmVf: "operator portion of leases that vented or flared"
notes opmVf: "Source: Texas Railroad Commission Production Data Dump"
quietly by operator_no: egen opmUneduc = mean(perUneduc)
label variable opmUneduc "operator mean uneducated"
notes opmUneduc: "operator mean value of percent without a highschool diploma surrounding lease"
notes opmUneduc: "Original Source: American Community Survey, 2010-2014"
label variable vfRate "venting and flaring rate" 
label variable vfLease "lease vented or flared"
destring parSubsid, replace
replace opVfRate = 0 if opVfRate == .
replace opVfPercent = 0 if opVfPercent == .
gen opLogWells = log(opWells)
label variable opLogWells "log operator wells"
notes opLogWells: "log number of producing wells controlled by operator"
notes opLogWells: "Source: Texas Railroad Commission Production Data Dump"
save 34-oilWsubsid_20171104, replace
cd ..
cd posted
save 34-oilWsubsid_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* connect gas well data with subsidiary info						*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 33-gas_20171104
cd ..
cd working
replace permit = 0 if vfTempPermits == 0
drop opmPermit
by operator_no: egen opmPermit = mean(permit)
label variable opmPermit "operator fraction leases permitted to vent or flare"
notes opmPermit: "Fraction of the operator's leases that are oil leases"
notes opmPermit: "Source: Texas Railroad Commission Production Data Dump"
destring operator_no, replace
merge m:1 operator_no using 34-subsid_20171104
keep if _merge == 1 | _merge == 3
drop _merge
keep if ( condTot > 0 & condTot != .) | ( gasTot > 0 & gasTot != . )
replace vfTot = 0 if vfTot == .
replace vfLease = 1 if vfTot > 0
replace vfLease = 0 if vfTot == 0
drop opVfTot 
sort operator_no
by operator_no: egen opVfTot = sum (vfTot)
label variable opVfTot "operator sum volume of gas vented or flared"
notes opVfTot: "Sum value of gas vented or flared at operator's wells (in mcf)"
notes opVfTot: "Source: Texas Railroad Commission Production Data Dump"
replace opVf = 1 if opVfTot > 0
replace opVf = 0 if opVfTot == 0
replace vfRate = vfTot / gasTot
replace vfRate = 0 if vfRate == .
gen opVfRate = opVfTot / opGas
label variable opVfRate "operator venting and flaring rate"
notes opVfRate: "operator volume of gas vented or flared / operator volume of gas produced"
notes opVfRate: "Source: Texas Railroad Commission Production Data Dump"
gen opVfPercent = 100 * opVfTot / opGas
label variable opVfPercent "operator venting and flaring percentage"
notes opVfPercent: "100 * operator volume of gas vented or flared / operator volume of gas produced"
notes opVfPercent: "Source: Texas Railroad Commission Production Data Dump"
drop opCondProd opGasProd
sort operator_no
quietly by operator_no: egen opmVfRate = mean(vfRate)
label variable opmVfRate "operator mean venting and flaring rate"
notes opmVfRate: "operator mean volume of gas well gas vented or flared / operator volume of gas well gas produced"
notes opmVfRate: "Source: Texas Railroad Commission Production Data Dump"
quietly by operator_no: egen opmVf = mean (vfLease)
label variable opmVf "operator portion of wells that vented or flared"
notes opmVf: "operator portion of wells that vented or flared"
notes opmVf: "Source: Texas Railroad Commission Production Data Dump"
quietly by operator_no: egen opmUneduc = mean(perUneduc)
label variable opmUneduc "operator mean uneducated"
notes opmUneduc: "operator mean value of percent without a highschool diploma surrounding lease"
notes opmUneduc: "Original Source: American Community Survey, 2010-2014"
label variable vfRate "venting and flaring rate" 
label variable vfLease "well vented or flared"
destring parSubsid, replace
replace opVfRate = 0 if opVfRate == .
replace opVfPercent = 0 if opVfPercent == .
gen opLogWells = log(opWells)
label variable opLogWells "log operator wells"
notes opLogWells: "log number of producing wells controlled by operator"
notes opLogWells: "Source: Texas Railroad Commission Production Data Dump"
save 34-gasWsubsid_20171104, replace
cd ..
cd posted
save 34-gasWsubsid_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* connect oil and gas lease data with subsidiary info				*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 33-oil&gas_20171104
sort operator_no
replace permit = 0 if vfTempPermits == 0
drop opmPermit
by operator_no: egen opmPermit = mean(permit)
label variable opmPermit "operator fraction leases permitted to vent or flare"
notes opmPermit: "Fraction of the operator's leases that are oil leases"
notes opmPermit: "Source: Texas Railroad Commission Production Data Dump"
cd ..
cd working 
destring operator_no, replace
keep if ( oilTot > 0 & oilTot != .) | ( csgdTot > 0 & csgdTot != .) | ( condTot > 0 & condTot != .) | ( gasTot > 0 & gasTot != . )
merge m:1 operator_no using 34-subsid_20171104
save og, replace
keep if _merge == 1 | _merge == 3
drop _merge
replace vfTot = 0 if vfTot == .
replace vfLease = 1 if vfTot > 0
replace vfLease = 0 if vfTot == 0
drop opVfTot 
sort operator_no
by operator_no: egen opVfTot = sum (vfTot)
label variable opVfTot "operator sum volume of gas vented or flared"
notes opVfTot: "Sum value of gas vented or flared at operator's leases (in mcf)"
notes opVfTot: "Source: Texas Railroad Commission Production Data Dump"
replace opVf = 1 if opVfTot > 0
replace opVf = 0 if opVfTot == 0
replace vfRate = 0 if vfRate == .
gen opCsgdGas = opCsgd + opGas
replace opCsgdGas = opCsgd if opGas == . & opCsgd != .
replace opCsgdGas = opGas if opCsgd == . & opGas != .
gen oilCond = oilTot + condTot
replace oilCond = oilTot if condTot == . & oilTot != .
replace oilCond = condTot if oilTot == . & condTot != .
gen csgdGas = gasTot + csgdTot
replace csgdGas = gasTot if csgdTot == . & gasTot != .
replace csgdGas = csgdTot if gasTot == . & csgdTot != .
gen opOilCond = opOil + opCond
replace opOilCond = opOil if opCond == . & opOil != .
replace opOilCond = opCond if opOil == . & opCond != . 
gen opGasCsgd = opGas + opCsgd
replace opGasCsgd = opGas if opCsgd == . & opGas != .
replace opGasCsgd = opCsgd if opGas == . & opCsgd != .
gen oilLease = .
replace oilLease = 1 if oil_gas_code == "O"
replace oilLease = 0 if oil_gas_code == "G"
gen opVfRate = opVfTot / opCsgdGas
label variable opVfRate "operator venting and flaring rate"
notes opVfRate: "operator volume of casinghead or gas well gas vented or flared / operator volume of casinghead or gas well gas produced"
notes opVfRate: "Source: Texas Railroad Commission Production Data Dump"
gen opVfPercent = 100 * opVfTot / opCsgdGas
label variable opVfPercent "operator venting and flaring percentage"
notes opVfPercent: "100 * operator volume of casinghead or gas well gas vented or flared / operator volume of casinghead or gas well gas produced"
notes opVfPercent: "Source: Texas Railroad Commission Production Data Dump"
drop opCsgdProd opOilProd opCondProd opGasProd
replace leaseWells = 1 if leaseWells == . & oil_gas_code == "G"
replace csgdTot = 0 if csgdTot == .
replace oilTot = 0 if oilTot == .
replace gasTot = 0 if gasTot == .
replace csgdTot = 0 if csgdTot == .
gen leaseAgeMean = avgage
replace leaseWellAge0 = 1 if leaseAgeMean == 0 
replace leaseWellAge1 = 1 if leaseAgeMean == 1 
replace leaseWellAge2 = 1 if leaseAgeMean == 2 
replace leaseWellAge3 = 1 if leaseAgeMean == 3 
replace leaseWellAge4 = 1 if leaseAgeMean == 4 
replace leaseWellAge5over = 1 if leaseAgeMean >= 5 
sort operator_no
quietly by operator_no: egen opmVfRate = mean(vfRate)
label variable opmVfRate "operator mean venting and flaring rate"
notes opmVfRate: "operator mean volume of casinghead or gas well gas vented or flared / operator volume of casinghead or gas well gas produced"
notes opmVfRate: "Source: Texas Railroad Commission Production Data Dump"
quietly by operator_no: egen opmVf = mean (vfLease)
label variable opmVf "operator portion of leases that vented or flared"
notes opmVf: "operator portion of leases that vented or flared"
notes opmVf: "Source: Texas Railroad Commission Production Data Dump"
quietly by operator_no: egen opmUneduc = mean(perUneduc)
label variable opmUneduc "operator mean uneducated"
notes opmUneduc: "operator mean value of percent without a highschool diploma surrounding lease"
notes opmUneduc: "Original Source: American Community Survey, 2010-2014"
label variable vfRate "venting and flaring rate"
label variable vfLease "lease vented or flared"  
destring parSubsid, replace
replace opVfRate = 0 if opVfRate == .
replace opVfPercent = 0 if opVfPercent == .
replace opmVfTot = 0 if opmVfTot == .
replace condTot = 0 if condTot == .
gen opLogWells = log(opWells)
label variable opLogWells "log operator wells"
notes opLogWells: "log number of producing wells controlled by operator"
notes opLogWells: "Source: Texas Railroad Commission Production Data Dump"
gen sqrtOilCond = sqrt(oilCond)
label variable sqrtOilCond "squareroot of barrels of condensate or oil produced at lease"
notes sqrtOilCond: "squareroot of barrels of condensate or oil produced at lease"
notes sqrtOilCond: "Source: Texas Railroad Commission Production Data Dump"
gen sqrtCsgdGas = sqrt(csgdGas)
label variable sqrtCsgdGas "squareroot of mcf of casinghead gas or gas well gas produced at lease"
notes sqrtCsgdGas: "squareroot of mcf of casinghead gas or gas well gas produced at lease"
notes sqrtCsgdGas: "Source: Texas Railroad Commission Production Data Dump"
gen opSqrtWells = sqrt(opWells)
label variable opSqrtWells "squareroot number of operator wells"
notes opSqrtWells: "squareroot number of operator wells"
notes opSqrtWells: "Source: Texas Railroad Commission Production Data Dump"
gen opSqrtOilCond = sqrt(opOilCond)
label variable opSqrtOilCond "squareroot of barrels of condensate or oil produced by operator"
notes opSqrtOilCond: "squareroot of barrels of condensate or oil produced by operator"
notes opSqrtOilCond: "Source: Texas Railroad Commission Production Data Dump"
gen opSqrtCsgdGas = sqrt(opCsgdGas)
label variable opSqrtCsgdGas "squareroot of casinghead or gas well gas produced by operator"
notes opSqrtCsgdGas: "squareroot of casinghead or gas well gas produced by operator"
notes opSqrtCsgdGas: "Source: Texas Railroad Commission Production Data Dump"
gen logOilCond = log(oilCond)
label variable logOilCond "log of barrels of oil or condensate produced at lease"
notes logOilCond: "log of barrels of oil or condensate produced at lease"
notes logOilCond: "Source: Texas Railroad Commission Production Data Dump"
gen logCsgdGas = log(csgdGas)
label variable logCsgdGas "log mcf of casinghead or gas well gas produced at lease"
notes logCsgdGas: "log mcf of casinghead or gas well gas produced at lease"
notes logCsgdGas: "Source: Texas Railroad Commission Production Data Dump"
gen opLogOilCond = log(oilCond)
label variable opLogOilCond "log of barrels of condensate or oil produced by operator"
notes opLogOilCond: "log of barrels of condensate or oil produced by operator"
notes opLogOilCond: "Source: Texas Railroad Commission Production Data Dump"
gen opLogCsgdGas = log(csgdGas)
label variable opLogCsgdGas "log of casinghead or gas well gas produced by operator"
notes opLogCsgdGas: "log of casinghead or gas well gas produced by operator"
notes opLogCsgdGas: "Source: Texas Railroad Commission Production Data Dump"
gen opGasOilRatio = (opGas + opCsgd) / (opCond + opOil)
label variable opGasOilRatio "operator oil to gas production ratio
notes opGasOilRatio: "volume of gas well or casinghead gas produced at lease (in mcf) / volume of oil or condensate produced at lease (in barrels)"
notes opGasOilRatio: "Source: Texas Railroad Commission Production Data Dump"
gen lnVfRate = ln(vfRate)
label variable lnVfRate "natural logarithm of lease venting and flaring rate"
notes lnVfRate: "natural log of (casinghead or gas well gas vented or flared / casinghead or gas well gas produced)"
notes lnVfRate: "Source: Texas Railroad Commission Production Data Dump"
gen opLnVfRate = ln(opVfRate)
label variable opLnVfRate "natural logarithm of operator venting and flaring rate"
notes opLnVfRate: "natural logarithm of (casinghead or gas well gas vented or flared / casignhead or gas well gas produced)"
notes opLnVfRate: "Source: Texas Railroad Commission Production Data Dump"
sort operator_no
quietly by operator_no: egen opmLnVfRate = mean(lnVfRate)
label variable opmLnVfRate "mean natural logarithm of the operator's lease venting and flaring rates"
notes opmLnVfRate: "natural log of ( mean (casignehad or gas well gas vented ro flared / casignhead or gas well gas produced, for each lease directly controlled by the operator))"
notes opmLnVfRate: "Source: Texas Railroad Commission Production Data Dump"
egen meanLnVfRate = mean(lnVfRate)
gen grandMcLnVfRate = lnVfRate - meanLnVfRate
drop meanLnVfRate
label variable grandMcLnVfRate "grand center mean of lnVfRate"
notes grandMcLnVfRate: "lnVfRate - mean(lnVfRate)"
notes grandMcLnVfRate: "Source: Texas Railroad Commission Production Data Dump"
gen groupMcLnVfRate = lnVfRate - opmLnVfRate
label variable groupMcLnVfRate "group center mean of lnVfRate"
notes groupMcLnVfRate: "lnVfRate - mean(lnVfRate, by opeartor_no)"
notes groupMcLnVfRate: "Source: Texas Railroad Commission Production Data Dump"
egen meanIncMedian = mean(incMedian)
gen grandMcIncMedian = incMedian - meanIncMedian
drop meanIncMedian
label variable grandMcIncMedian "grand center mean of incMedian"
notes grandMcIncMedian: "incMedian - mean(incMedian)"
notes grandMcIncMedian: "Source: American Community Survey 2010-2014"
gen groupMcIncMedian = incMedian - opmIncMedian
label variable groupMcIncMedian "group center mean of incMedian"
notes groupMcIncMedian: "incMedian - mean(incMedian, by operator_no)"
notes groupMcIncMedian: "Source: American Community Survey 2010-2014"
egen meanOohuMedian = mean(oohuMedian)
gen grandMcOohuMedian = oohuMedian - meanOohuMedian
drop meanOohuMedian
label variable grandMcOohuMedian "grand center mean of oohuMedian"
notes grandMcOohuMedian: "oohuMedian - mean(oohuMedian)"
notes grandMcOohuMedian: "Source: American Community Survey 2010-2014"
gen groupMcOohuMedian = oohuMedian - opmOohuMedian
label variable groupMcOohuMedian "group center mean of oohuMedian"
notes groupMcOohuMedian: "oohuMedian - mean(oohuMedian, by operator_no)"
notes groupMcOohuMedian: "Source: American Community Survey 2010-2014"
egen meanPopDensMi = mean(popDensMi)
gen grandMcPopDensMi = popDensMi - meanPopDensMi
drop meanPopDensMi
label variable grandMcPopDensMi "grand center mean of popDensMi"
notes grandMcPopDensMi: "popDensMi - mean(popDensMi)"
notes grandMcPopDensMi: "Source: American Community Survey 2010-2014"
gen groupMcPopDensMi = popDensMi - opmPopDensMi
label variable groupMcPopDensMi "group center mean of popDensMi"
notes groupMcPopDensMi: "popDensMi - mean(popDensMi, by operator_no)"
notes groupMcPopDensMi: "Source: American Community Survey 2010-2014"
egen meanRegisteredOrgs = mean(registeredorgs)
gen grandMcRegisteredOrgs = registeredorgs - meanRegisteredOrgs
drop meanRegisteredOrgs
label variable grandMcRegisteredOrgs "grand center mean of registeredorgs"
notes grandMcRegisteredOrgs: "registeredorgs - mean(registeredorgs)"
notes grandMcRegisteredOrgs: "Source: National Center for Charitable Statistics"
rename opmRegisteredorgs opmRegisteredOrgs
gen groupMcRegisteredOrgs = registeredorgs - opmRegisteredOrgs
label variable groupMcRegisteredOrgs "group center mean of registeredorgs"
notes groupMcRegisteredOrgs: "registeredorgs - mean(regsiteredorgs, by operator_no)"
notes groupMcRegisteredOrgs: "Source: National Center for Charitable Statistics"
egen meanPerBlack = mean(perBlack)
gen grandMcPerBlack = perBlack - meanPerBlack
drop meanPerBlack
label variable grandMcPerBlack "grand center mean of perBlack"
notes grandMcPerBlack: "perBlack - mean(perBlack)"
notes grandMcPerBlack: "Source: American Community Survey 2010-2014"
gen groupMcPerBlack = perBlack - opmPerBlack 
label variable groupMcPerBlack "group center mean of perBlack"
notes groupMcPerBlack: "perBlack - mean(perBlack, by operator_no)"
notes groupMcPerBlack: "Source: American Community Survey 2010-2014"
egen meanPerHisp = mean(perHisp)
gen grandMcPerHisp = perHisp - meanPerHisp
drop meanPerHisp
label variable grandMcPerHisp "grand center mean of perHisp"
notes grandMcPerHisp: "perHisp - mean(perHisp)"
notes grandMcPerHisp: "Source: American Community Survey 2010-2014"
gen groupMcPerHisp = perHisp - opmPerHisp
label variable groupMcPerHisp "group center mean of perHisp"
notes groupMcPerHisp: "perHisp - mean(perHisp, by operator_no)"
notes groupMcPerHisp: "Source: American Community Survey 2010-2014" 
egen meanPermit = mean(permit)
gen grandMcPermit = permit - meanPermit
drop meanPermit
label variable grandMcPermit "grand center mean of permit"
notes grandMcPermit: "permit - mean(permit)"
notes grandMcPermit: "Source: Texas Railroad Commission"
gen groupMcPermit = permit - opmPermit
label variable groupMcPermit "group center mean of permit"
notes groupMcPermit: "permit - mean(permit, by operator)"
notes groupMcPermit: "source: Texas Railroad Commission"
egen meanLSwr32Vio = mean(lSwr32Vio)
gen grandMcLSwr32Vio = lSwr32Vio - meanLSwr32Vio
drop meanLSwr32Vio
label variable grandMcLSwr32Vio "grand center mean of lSwr32Vio"
notes grandMcLSwr32Vio: "lSwr32Vio - mean(lSwr32Vio)"
notes grandMcLSwr32Vio: "Source: Texas Railroad Commission"
gen groupMcLSwr32Vio = lSwr32Vio - opmLSwr32Vio
label variable groupMcLSwr32Vio "group center mean of lSwr32Vio"
notes groupMcLSwr32Vio: "lSwr32Vio - mean(lSwr32Vio, by operator)"
notes groupMcLSwr32Vio: "Source: Texas Railroad Commission"
egen meanOilLease = mean(oilLease)
gen grandMcOilLease = oilLease - meanOilLease
drop meanOilLease
label variable grandMcOilLease "grand center mean of oil lease"
notes grandMcOilLease: "oilLease - mean(oilLease)"
notes grandMcOilLease: "Source: Texas Railroad Commission"
rename opmLogOil opmLogOilCond
rename opmLogGas opmLogCsgdGas
egen meanLogOilCond = mean(logOilCond)
gen grandMcLogOilCond = logOilCond - meanLogOilCond
drop meanLogOilCond
label variable grandMcLogOilCond "grand center mean of lease log oil and condensate production"
notes grandMcLogOilCond: "logOilCond - mean(logOilCond)"
notes grandMcLogOilCond: "Source: Texas Railroad Commission"
gen groupMcLogOilCond = logOilCond - opmLogOilCond
label variable groupMcLogOilCond "group center mean of lease log oil and condensate production"
notes groupMcLogOilCond: "logOilCond - mean(logOilCond, by operator)"
notes groupMcLogOilCond: "Source: Texas Railroad Commission"
egen meanLogCsgdGas = mean(logCsgdGas)
gen grandMcLogCsgdGas = logCsgdGas - meanLogCsgdGas
drop meanLogCsgdGas
label variable grandMcLogCsgdGas "grand center mean of lease log gas and casinghead production"
notes grandMcLogCsgdGas: "logCsgdGas - mean(logCsgdGas)"
notes grandMcLogCsgdGas: "Source: Texas Railroad Commission"
gen groupMcLogCsgdGas = logCsgdGas - opmLogCsgdGas
label variable groupMcLogCsgdGas "group center mean of lease log gas and casinghead production"
notes groupMcLogCsgdGas: "logCsgdGas - mean(logCsgdGas, by operator)"
notes groupMcLogCsgdGas: "Source: Texas Railroad Commission"
egen meanNewWells = mean(newWells)
gen grandMcNewWells = newWells - meanNewWells
drop meanNewWells
label variable grandMcNewWells "grand center mean of newWells"
notes grandMcNewWells: "newWells - mean(nenwWells)"
notes grandMcNewWells: "Source: Texas Railroad Commission"
gen groupMcNewWells = newWells - opmNewWells
label variable groupMcNewWells "group center mean of newWells"
notes groupMcNewWells: "newWells - mean(newWells, by operator)"
notes groupMcNewWells: "Source: Texas Railroad Commission"
egen meanWellDens = mean(welldens)
label variable opmWellDens "operator mean lease well density"
gen grandMcWellDens = welldens - meanWellDens
drop meanWellDens
label variable grandMcWellDens "grand center mean of welldens"
notes grandMcWellDens: "welldens - mean(welldens, by operator)"
notes grandMcWellDens: "Source: Texas Railroad Commission"
gen groupMcWellDens = welldens - opmWellDens
label variable groupMcWellDens "group center mean of welldens"
notes groupMcWellDens: "welldens - mean(welldens, by operator)"
notes groupMcWellDens: "Source: Texas Railroad Commission"
rename opmWells opmLeaseWells
egen meanLeaseWells = mean(leaseWells)
gen grandMcLeaseWells = leaseWells - meanLeaseWells
drop meanLeaseWells
label variable grandMcLeaseWells "grand center mean of leaseWells"
notes grandMcLeaseWells: "leaseWells - mean(leaseWells)"
notes grandMcLeaseWells: "Source: Texas Railroad Commission" 
gen groupMcLeaseWells = leaseWells - opmLeaseWells
label variable groupMcLeaseWells "group center mean of leaseWells"
notes groupMcLeaseWells: "leaseWells - mean(leaseWells, by operator)"
notes groupMcLeaseWells: "Source: Texas Railroad Commission"
rename opmPipedistft opmPipeDistFt
egen meanPipeDistFt = mean(pipedistft)
gen grandMcPipeDistFt = pipedistft - meanPipeDistFt
drop meanPipeDistFt
label variable grandMcPipeDistFt "grand center mean of distance to nearest pipeline"
notes grandMcPipeDistFt: "pipedistft - mean(pipedistft)"
notes grandMcPipeDistFt: "Source: Texas Railroad Commission and EIA Natural Gas Pipeline Shapefile"
gen groupMcPipeDistFt = pipedistft - opmPipeDistFt
label variable groupMcPipeDistFt "group center mean of distance to nearest pipeline"
notes groupMcPipeDistFt: "pipedistft - mean(pipedistft, by operator)"
notes groupMcPipeDistFt: "Source: Texas Railroad Commission and EIA Natural Gas Pipeline Shapefile"
gen leaseDepthMean = avgdepth
egen meanLeaseDepthMean = mean(leaseDepthMean)
gen grandMcLeaseDepthMean = leaseDepthMean - meanLeaseDepthMean
drop meanLeaseDepthMean
label variable grandMcLeaseDepthMean "grand center mean of leaseDepthMean"
notes grandMcLeaseDepthMean: "leaseDepthMean - mean(leaseDepthMean)"
notes grandMcLeaseDepthMean: "Source: Texas Railroad Commission"
rename opmWellDepth opmLeaseDepthMean
gen groupMcLeaseDepthMean = leaseDepthMean - opmLeaseDepthMean
label variable groupMcLeaseDepthMean "group center mean of leaseDepthMean"
notes groupMcLeaseDepthMean: "leaseDepthMean - mean(leaseDepthMean, by operator)"
notes groupMcLeaseDepthMean: "Source: Texas Railroad Commission" 
egen meanLeaseFreshWells = mean(leaseFreshWells)
gen grandMcLeaseFreshWells = leaseFreshWells - meanLeaseFreshWells
drop meanLeaseFreshWells
label variable grandMcLeaseFreshWells "grand center mean of leaseFreshWells"
notes grandMcLeaseFreshWells: "leaseFreshWells - mean(leaseFreshWells)"
notes grandMcLeaseFreshWells: "Source: Texas Railroad Commission"
rename opmFreshWells opmLeaseFreshWells
label variable opmLeaseFreshWells "operator mean fresh water wells on leases"
gen groupMcLeaseFreshWells = leaseFreshWells - opmLeaseFreshWells
label variable groupMcLeaseFreshWells "group center mean of lease Fresh wells"
notes groupMcLeaseFreshWells: "leaseFreshWells - mean(leaseFreshwells, by operator)"
notes groupMcLeaseFreshWells: "Source: Texas Railroad Commission"
gen leaseHorizWells = horizontalwells
egen meanLeaseHorizWells = mean(leaseHorizWells)
gen grandMcLeaseHorizWells = leaseHorizWells - meanLeaseHorizWells
drop meanLeaseHorizWells
label variable grandMcLeaseHorizWells "grand center mean of leaseHorizWells"
notes grandMcLeaseHorizWells: "leaseHorizWells - mean(leaseHorizWells)"
notes grandMcLeaseHorizWells: "Source: Texas Railroad Commission"
rename opmHorizWells opmLeaseHorizWells
gen groupMcLeaseHorizWells = leaseHorizWells - opmLeaseHorizWells
label variable groupMcLeaseHorizWells "group center eman of lease horizontal wells"
notes groupMcLeaseHorizWells: "leaseHorizWells - mean(leaseHorizWells, by lease)"
notes groupMcLeaseHorizWells: "Source: Texas Railroad Commission" 
gen leaseAgeMean2 = avgage * avgage
egen meanLeaseAgeMean2 = mean(leaseAgeMean2)
gen grandMcLeaseAgeMean2 = leaseAgeMean2 - meanLeaseAgeMean2
drop meanLeaseAgeMean2
label variable grandMcLeaseAgeMean2 "grand center mean of leaseAgeMean2"
notes grandMcLeaseAgeMean2: "leaseAgeMean2 - mean(leaseAgeMean2)
notes grandMcLeaseAgeMean2: "Source: Texas Railroad Commission"
rename opmAge2 opmLeaseAgeMean2
gen groupMcLeaseAgeMean2 = leaseAgeMean2 - opmLeaseAgeMean2
label variable groupMcLeaseAgeMean2 "group center mean of leaseAgeMean2"
notes groupMcLeaseAgeMean2: "leaseAgeMean2 - mean(leaseAgeMean2, by operator)"
notes groupMcLeaseAgeMean2: "Source: Texas Railroad Commission"
gen opmSqrtPermit = sqrt(opmPermit)
label variable opmSqrtPermit "squareroot of the portion of the operators leases that were pemitted to vent or flare"
notes opmSqrtPermit: "squareroot of (number of the operators leases permited to vent or flare / numer of leases controleld by operator"
notes opmSqrtPermit: "Source: Texas Railroad Commission"
gen opSqrtGasOilRatio = sqrt(opGasOilRatio)
label variable opSqrtGasOilRatio "squareroot of the portion of gas produced by the operator compared to oil"
notes  opSqrtGasOilRatio : "squareroot of (volume of gas or casinghead produced by operator / volume of oil or condensate produced by operator)"
notes  opSqrtGasOilRatio : "Source: Texas Railroad Commission"
sort operator_no
save 34-oil&gasWsubsid_20171104, replace
cd ..
cd posted
save 34-oil&gasWsubsid_20171104
clear
cd ..
//
//