cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 37-comReg_20171109, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		37-comReg_20171109.do
// task:		run community level nbreg
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
/********-*********-*********-*********-*********-*********-*********/
/* m1- county level regressions										*/
/********-*********-*********-*********-*********-*********-*********/
//
use 36-county12_20171109, replace
cd graphs
reg allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp
vif
poisson allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp
estimates store PRM1
nbreg allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
estimates store NBRM1
predict errorM1nbreg, stdp
sum errorM1nbreg,
histogram errorM1nbreg, percent normal title(Residual Distribution) subtitle(37-m1nbreg_20171109)
graph export 37-m1nbreg_20171109.pdf, replace	
estimates table PRM1 NBRM1, b(%9.3f) t drop (lnalpha: _cons)
listcoef incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, help percent
zinb allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, inf ///
	(incMedian oohuMedian perPov perUneduc perLimEng popDensMi ///
	registeredorgs perBlack perHisp)
listcoef, help
countfit allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, ///
	inf(incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp)
graph export 37-countyCountRegCompare_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* m2- blockgroup level regressions									*/
/********-*********-*********-*********-*********-*********-*********/
// 
use 36-bg12_20171109, replace
cd graphs
reg allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
vif
poisson allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
estimates store PRM2
nbreg allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
estimates store NBRM2
predict errorM2nbreg, stdp
sum errorM2nbreg,
histogram errorM2nbreg, percent normal title(Residual Distribution) subtitle(37-m2nbreg_20171109)
graph export 37-m2nbreg_20171109.pdf, replace	
estimates table PRM2 NBRM2, b(%9.3f) t drop (lnalpha: _cons)
listcoef incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, help percent
zinb allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	, inf (incMedian oohuMedian perPov perUneduc perLimEng popDensMi ///
	registeredorgs perBlack perHisp)
estimates store ZINB2
predict errorM2zinb, stdp
sum errorM2zinb,
histogram errorM2zinb, percent normal title(Residual Distribution) subtitle(37-m2zinb_20171109)
graph export 37-m2zinb_20171109.pdf, replace	
listcoef, help
countfit allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	, inf (incMedian oohuMedian perPov perUneduc perLimEng popDensMi ///
	registeredorgs perBlack perHisp)
graph export 37-bgCountRegCompare_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* m3- facility level regressions		 							*/
/********-*********-*********-*********-*********-*********-*********/
//
use 36-fac12_20171109, replace
cd graphs
reg vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
vif
poisson vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
estimates store PRM3
nbreg vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp
	estimates store NBRM3
predict errorM3nbreg, stdp
sum errorM3nbreg,
histogram errorM3nbreg, percent normal title(Residual Distribution) subtitle(37-m3nbreg_20171109)
graph export 37-m3nbreg_20171109.pdf, replace	
estimates table PRM3 NBRM3, b(%9.3f) t drop (lnalpha: _cons)
listcoef incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, help percent
zinb vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	, inf(incMedian oohuMedian perPov perUneduc perLimEng popDensMi ///
	registeredorgs perBlack perHisp)
estimates store ZINB3
predict errorM3zinb, stdp
sum errorM3zinb,
histogram errorM3zinb, percent normal title(Residual Distribution) subtitle(37-m3zinb_20171109)
graph export 37-m3zinb_20171109.pdf, replace	
listcoef, help
countfit vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp ///
	, inf(incMedian oohuMedian perPov perUneduc perLimEng popDensMi ///
	registeredorgs perBlack perHisp)
graph export 37-facCountRegCompare_20171109.pdf, replace
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* m4- facility level regressions, accounting for clustered se		*/
/********-*********-*********-*********-*********-*********-*********/
//
use 36-fac12_20171109, replace
cd graphs
reg vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, ///
	vce(cluster operator_no) 
vif
nbreg vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, ///
	vce(cluster operator_no) 
predict errorM4nbreg, stdp
sum errorM4nbreg,
histogram errorM4nbreg, percent normal title(Residual Distribution) subtitle(37-m4nbreg_20171109)
graph export 37-m4nbreg_20171109.pdf, replace	
cd ..
//
//