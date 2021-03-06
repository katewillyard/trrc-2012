cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 38-facReg_20171109, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		38-facReg_20171109.do
// task:		run facility level regressions, community variables only
//				run facility level regressions, community variables with clustering
//				run facility level regressions, all facility variables
//				run facility level regressions, all facility variables with clustering
//				run facility level regressions, most variables
//				run facility level regressions, most variables with clustering
//				run facility level regressions, all variables
//				run facility level regressions, all variables with clustering
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
/* M1- facility-level, community variables only						*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
vif
predict errorM1reg, resid
sum errorM1reg
histogram errorM1reg, percent normal title(Residual Distribution) subtitle(38-m1reg)
graph export 38-m1reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
predict errorM1logit, resid
sum errorM1logit
histogram errorM1logit, percent normal title(Residual Distribution) subtitle(38-m1logit)
graph export 38-m1logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
predict errorM1vf, resid
sum errorM1vf,
histogram errorM1vf, percent normal title(Residual Distribution) subtitle(38-m1vf)
graph export 38-m1vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M2- facility-level, community variables w clustering				*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, vce(cluster operator_no) 
vif
predict errorM2reg, resid
sum errorM2reg
histogram errorM2reg, percent normal title(Residual Distribution) subtitle(38-m2reg)
graph export 38-m2reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, vce(cluster operator_no) 
predict errorM2logit, resid
sum errorM2logit
histogram errorM2logit, percent normal title(Residual Distribution) subtitle(38-m2logit)
graph export 38-m2logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, vce(cluster operator_no)
predict errorM2vf, resid
sum errorM2vf,
histogram errorM2vf, percent normal title(Residual Distribution) subtitle(38-m2vf)
graph export 38-m2vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M3- facility-level, add well-level			*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft, vce(cluster operator_no)  
vif
predict errorM3reg, resid
sum errorM3reg
histogram errorM3reg, percent normal title(Residual Distribution) subtitle(38-m3reg)
graph export 38-m3reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft, vce(cluster operator_no)  
predict errorM3logit, resid
sum errorM3logit
histogram errorM3logit, percent normal title(Residual Distribution) subtitle(38-m3logit)
graph export 38-m3logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft, vce(cluster operator_no) 
vif
predict errorM3vf, resid
sum errorM3vf,
histogram errorM3vf, percent normal title(Residual Distribution) subtitle(38-m3vf)
graph export 38-m3vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M4- run facility level regressions, add state regulation vars	*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs ///
	perBlack perHisp gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio, vce(cluster operator_no) 
vif
predict errorM4reg, resid
sum errorM4reg
histogram errorM4reg, percent normal title(Residual Distribution) subtitle(38-m4reg)
graph export 38-m4reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs ///
	perBlack perHisp gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio, vce(cluster operator_no) 
predict errorM4logit, resid
sum errorM4logit
histogram errorM4logit, percent normal title(Residual Distribution) subtitle(38-m4logit)
graph export 38-m4logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs ///
	perBlack perHisp gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio, vce(cluster operator_no)
vif
predict errorM4vf, resid
sum errorM4vf,
histogram errorM4vf, percent normal title(Residual Distribution) subtitle(38-m4vf)
graph export 38-m4vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M5- run facility level regressions, show rare fac variables		*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs ///
	perBlack perHisp gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio leaseDepthMean  ///
	leaseHorizWells leaseAgeMean, vce(cluster operator_no)
vif
predict errorM5reg, resid
vif
sum errorM5reg
histogram errorM5reg, percent normal title(Residual Distribution) subtitle(38-m5reg)
graph export 38-m5reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs ///
	perBlack perHisp gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio leaseDepthMean  ///
	leaseHorizWells leaseAgeMean, vce(cluster operator_no)
predict errorM5logit, resid
sum errorM5logit
histogram errorM5logit, percent normal title(Residual Distribution) subtitle(38-m5logit)
graph export 38-m5logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio leaseDepthMean  ///
	leaseHorizWells leaseAgeMean, vce(cluster operator_no)
vif
predict errorM5vf, resid
sum errorM5vf,
histogram errorM5vf, percent normal title(Residual Distribution) subtitle(38-m5vf)
graph export 38-m5vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M6- run facility level regressions, common operator	*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	, vce(cluster operator_no) 
vif
predict errorM6reg, resid
sum errorM6reg
histogram errorM6reg, percent normal title(Residual Distribution) subtitle(38-m6reg)
graph export 38-m6reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	, vce(cluster operator_no) 
predict errorM6logit, resid
sum errorM6logit
histogram errorM6logit, percent normal title(Residual Distribution) subtitle(38-m6logit)
graph export 38-m6logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	, vce(cluster operator_no)
predict errorM6vf, resid
sum errorM6vf,
histogram errorM6vf, percent normal title(Residual Distribution) subtitle(38-m6vf)
graph export 38-m6vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M7- run facility level regressions, rare fac w/ operator 		*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio leaseDepthMean leaseHorizWells leaseAgeMean ///
	operatorRRCage opLogWells opGasOilRatio, vce(cluster operator_no)
vif
predict errorM7reg, resid
sum errorM7reg
histogram errorM7reg, percent normal title(Residual Distribution) subtitle(38-m7reg)
graph export 38-m7reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio leaseDepthMean leaseHorizWells leaseAgeMean ///
	operatorRRCage opLogWells opGasOilRatio, vce(cluster operator_no)
predict errorM7logit, resid
sum errorM7logit
histogram errorM7logit, percent normal title(Residual Distribution) subtitle(38-m7logit)
graph export 38-m7logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio leaseDepthMean leaseHorizWells leaseAgeMean ///
	operatorRRCage opLogWells opGasOilRatio, vce(cluster operator_no)
predict errorM7vf, resid
sum errorM7vf,
histogram errorM7vf, percent normal title(Residual Distribution) subtitle(38-m7vf)
graph export 38-m7vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M8- run facility level regressions, common if subsid		*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	opSubsidiary, vce(cluster operator_no)
vif
predict errorM8reg, resid
sum errorM8reg
histogram errorM8reg, percent normal title(Residual Distribution) subtitle(38-m8reg)
graph export 38-m8reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	opSubsidiary, vce(cluster operator_no)
predict errorM8logit, resid
sum errorM8logit
histogram errorM8logit, percent normal title(Residual Distribution) subtitle(38-m8logit)
graph export 38-m8logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	opSubsidiary, vce(cluster operator_no)
predict errorM8vf, resid
sum errorM8vf,
histogram errorM8vf, percent normal title(Residual Distribution) subtitle(38-m8vf)
graph export 38-m8vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M9- run facility level regressions, among mlsf- op vars			*/
/********-*********-*********-*********-*********-*********-*********/
//
use 35-og12_20171109, replace
keep if opMLSF == 1
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	subsidLevel, vce(cluster operator_no) 
vif
predict errorM9reg, resid
sum errorM9reg
histogram errorM9reg, percent normal title(Residual Distribution) subtitle(38-m9reg)
graph export 38-m9reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	subsidLevel, vce(cluster operator_no) 
predict errorM9logit, resid
sum errorM9logit
histogram errorM9logit, percent normal title(Residual Distribution) subtitle(38-m9logit)
graph export 38-m9logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	subsidLevel, vce(cluster operator_no)
predict errorM9vf, resid
sum errorM9vf,
histogram errorM9vf, percent normal title(Residual Distribution) subtitle(38-m9vf)
graph export 38-m9vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M11- run facility level regressions, mlsf w par info				*/
/********-*********-*********-*********-*********-*********-*********/
//
// OIL AND GAS LEASES
//
use 35-og12_20171109, replace
keep if opMLSF == 1
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	opSubsidiary, vce(cluster operator_no)
predict errorM10reg, resid
vif
sum errorM10reg
histogram errorM10reg, percent normal title(Residual Distribution) subtitle(38-m10reg)
graph export 38-m110eg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	opSubsidiary, vce(cluster operator_no)
predict errorM10logit, resid
sum errorM10logit
histogram errorM10logit, percent normal title(Residual Distribution) subtitle(38-m11logit)
graph export 38-m10logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	opSubsidiary, vce(cluster operator_no)
predict errorM10vf, resid
sum errorM10vf,
histogram errorM10vf, percent normal title(Residual Distribution) subtitle(38-m11vf)
graph export 38-m10vf_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* M11- run facility level regressions, mlsf w par info				*/
/********-*********-*********-*********-*********-*********-*********/
//
// OIL AND GAS LEASES
//
use 35-og12_20171109, replace
keep if opMLSF == 1
cd graphs
reg vfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	subsidLevel parSubsid, vce(cluster operator_no)
predict errorM11reg, resid
vif
sum errorM11reg
histogram errorM11reg, percent normal title(Residual Distribution) subtitle(38-m10reg)
graph export 38-m11reg_20171109.pdf, replace
logit vfLease incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	subsidLevel parSubsid, vce(cluster operator_no)
predict errorM11logit, resid
sum errorM11logit
histogram errorM11logit, percent normal title(Residual Distribution) subtitle(38-m11logit)
graph export 38-m11logit_20171109.pdf, replace
keep if vfLease == 1
reg lnVfRate incMedian oohuMedian perPov  ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	gasWell logOilCond logCsgdGas newWells ///
	welldens leaseWells pipedistft permit ///
	lSwr32Vio operatorRRCage opLogWells opGasOilRatio ///
	subsidLevel parSubsid, vce(cluster operator_no)
predict errorM11vf, resid
sum errorM11vf,
histogram errorM11vf, percent normal title(Residual Distribution) subtitle(38-m11vf)
graph export 38-m11vf_20171109.pdf, replace
cd ..
//
//