cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 36-comSumStat_20171109, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		36-comSumStat_20171109.do
// task:		show summary statistics
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
/* county level summary statistics									*/
/********-*********-*********-*********-*********-*********-*********/
//
use 33-county_20171104, replace
rename vf_tot allVfTot
gen allVfCounty = .
replace allVfCounty = 1 if allVfTot > 0 & allVfTot != .
replace allVfCounty = 0 if allVfTot == 0 & allVfTot != .
label variable allVfCounty "well in county vented or flared in 2012"
notes allVfCounty: "lease with wellbore surface location in county vented or flared in 2012"
sum allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
sort allVfCounty
by allVfCounty: sum allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
pwcorr allVfCounty allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp , sig
tabstat allVfTot, statistics(mean median skewness kurtosis) by (allVfCounty) columns(statistics)
cd graphs
replace allVfTot = allVfTot / 1000000
label variable allVfTot "gas vented or flared in million mcf (thousand cubic feet)"
histogram allVfTot, percent normal ///
	title(County Total Venting and Flaring Volume Distribution) subtitle(All Texas Counties In 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 36-allVfTotcountyHist_20171109.pdf, replace
//
// community summary statistics
cd ..
use 33-county_20171104, replace
rename vf_tot allVfTot
gen allVfCounty = .
replace allVfCounty = 1 if allVfTot > 0 & allVfTot != .
replace allVfCounty = 0 if allVfTot == 0 & allVfTot != .
label variable allVfCounty "well in county vented or flared in 2012"
notes allVfCounty: "lease with wellbore surface location in county vented or flared in 2012"
gen inc_category = .
replace inc_category = 1 if incMedian <= 7 & incMedian != .
replace inc_category = 2 if incMedian >= 8 & incMedian <= 12 & incMedian != .
replace inc_category = 3 if incMedian >= 13 & incMedian != .
label variable inc_category "housheold income category"
notes inc_category: "1: less than 35K, 2: 35K - Less than 100K, 3: 100K or more"
sort inc_category
by inc_category: sum allVfTot
gen oohu_category = .
replace oohu_category = 1 if oohuMedian <= 13 & oohuMedian != .
replace oohu_category = 2 if oohuMedian >= 14 & oohuMedian <= 18 & oohuMedian != .
replace oohu_category = 3 if oohuMedian >= 19 & oohuMedian != .
label variable oohu_category "owner occupied household value"
notes oohu_category: "1: less than 100K, 2: 100K - Less than 250K, 3: 250K or More"
sort oohu_category
by oohu_category: sum allVfTot
gen pov_category = .
replace pov_category = 1 if perPov < 8 & perPov != .
replace pov_category = 2 if perPov <= 18 & perPov >=8 & perPov != .
replace pov_category = 3 if perPov > 18 & perPov != .
label variable pov_category "poverty category"
notes pov_category: "1: 0-8, 2: 8-18, 3: over 18"
sort pov_category
by pov_category: sum allVfTot 
gen educ_category = .
replace educ_category = 1 if perUneduc < 14 & perUneduc != .
replace educ_category = 2 if perUneduc >= 14 & perUneduc <= 25 & perUneduc != .
replace educ_category = 3 if perUneduc > 25 & perUneduc != .
label variable educ_category "education category"
notes educ_category: "1: less than 14% are uneducated, 2: 14-25% are uneducated, 3: more than 25% uneducated"
sort educ_category
by educ_category: sum allVfTot
gen lang_category = .
replace lang_category = 0 if perLimEng == 0 & perLimEng != .
replace lang_category = 1 if perLimEng > 0 & perLimEng <= 6 & perLimEng != .
replace lang_category = 2 if perLimEng > 6 & perLimEng != .
label variable lang_category "english fluency category"
notes lang_category: "1: 0 , 2: 0-10, 3: 10 or more"
sort lang_category
by lang_category: sum allVfTot 
gen popDens_category = .
replace popDens_category = 1 if popDensMi < 3 & popDensMi != .
replace popDens_category = 2 if popDensMi >= 3 & popDensMi <=30 & popDensMi != .
replace popDens_category = 3 if popDensMi > 30 & popDensMi != .
label variable popDens_category "population density category"
notes popDens_category: "1: less than 3 people per square mile. 2: 3-30 people per square mile, 3: more than 30 people per square mile"
sort popDens_category
by popDens_category: sum allVfTot
gen org_category = .
replace org_category = 1 if registeredorgs < 30 & registeredorgs != .
replace org_category = 2 if registeredorgs >= 30 & registeredorgs <= 200 & registeredorgs != .
replace org_category = 3 if registeredorgs > 200 & registeredorgs != .
label variable org_category "organizational capacity category"
notes org_category: "1: less than 30 ngos registered in county, 2: 30-200 ngo registered in county. 3: more than 200 ngos registered in county"
sort org_category
by org_category: sum allVfTot
gen race_category = .
replace race_category = 1 if perWhite > 50 & perWhite != .
replace race_category = 2 if perBlack > 50 & perBlack != .
replace race_category = 3 if perHisp > 50 & perHisp != .
label variable race_category "racial majority category"
notes race_category: "1- majority white. 2- majority black. 3- majority hispanic"
sort race_category
by race_category: sum allVfTot
save 36-county12_20171109
//
/********-*********-*********-*********-*********-*********-*********/
/* blockgroup level summary statistics 								*/
/********-*********-*********-*********-*********-*********-*********/
//
keep county geoid registeredorgs
gen sub = substr(geoid,8,5)
cd ..
cd working
save ngos
cd ..
cd posted
clear
use 33-bg_20171104
gen sub = substr(geoid,1,5)
cd ..
cd working
merge m:1 sub using ngos
cd ..
cd posted
drop _merge
count
drop if perBlack == .
count
drop popDens 
gen popDens = age_pop / aland 
label variable popDens "people per square meter"
gen popDensMi = popDens * 2589988.11
label variable popDensMi "people per square mile"
label variable popDensMi
gen allVfTot = gasVf + csgdVf
label variable allVfTot "total venting/flaring volume"
notes allVfTot: "Volume (in mcf) of gas well or casinghead gas vented or flared on leases with wellbore surface locations within one mile of the facility"
replace allVfTot = gasVf if gasVf != . & csgdVf == .
replace allVfTot = csgdVf if csgdVf != . & gasVf == .
replace allVfTot = 0 if gasVf == . & csgdVf == .
gen allVfBg = .
label variable allVfBg "venting/flaring occurred"
notes allVfBg: "1- venting/flaring occurred at lease with wellbore surface locations within one mile of the block group, 0-not"
replace allVfBg = 1 if allVfTot > 0 & allVfTot != .
replace allVfBg = 0 if allVfTot == 0
sum allVfBg allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp 
sort allVfBg
by allVfBg: sum allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp
pwcorr allVfBg allVfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, sig
tabstat allVfTot, statistics(mean median skewness kurtosis) by (allVfBg) columns(statistics)
cd graphs
replace allVfTot = allVfTot / 1000000
label variable allVfTot "gas vented or flared in million mcf (thousand cubic feet)"
histogram allVfTot, percent normal ///
	title(Block Group Venting and Flaring Volume Distribution) subtitle(All Texas Block Groups In 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 36-allVfTotBgHist_20171109.pdf, replace
cd ..
//
// community summary statistics
clear
use 33-bg_20171104
gen sub = substr(geoid,1,5)
cd ..
cd working
merge m:1 sub using ngos
drop _merge
cd ..
cd posted
count
drop if perBlack == .
count
drop popDens 
gen popDens = age_pop / aland 
label variable popDens "people per square meter"
gen popDensMi = popDens * 2589988.11
gen allVfTot = gasVf + csgdVf
label variable allVfTot "total venting/flaring volume"
notes allVfTot: "Volume (in mcf) of gas well or casinghead gas vented or flared on leases with wellbore surface locations within one mile of the facility"
replace allVfTot = gasVf if gasVf != . & csgdVf == .
replace allVfTot = csgdVf if csgdVf != . & gasVf == .
replace allVfTot = 0 if gasVf == . & csgdVf == .
gen allVfBg = .
label variable allVfBg "venting/flaring occurred"
notes allVfBg: "1- venting/flaring occurred at lease with wellbore surface locations within one mile of the block group, 0-not"
replace allVfBg = 1 if allVfTot > 0 & allVfTot != .
replace allVfBg = 0 if allVfTot == 0
gen inc_category = .
replace inc_category = 1 if incMedian <= 7 & incMedian != .
replace inc_category = 2 if incMedian >= 8 & incMedian <= 12 & incMedian != .
replace inc_category = 3 if incMedian >= 13 & incMedian != .
label variable inc_category "housheold income category"
notes inc_category: "1: less than 35K, 2: 35K - Less than 100K, 3: 100K or more"
sort inc_category
by inc_category: sum allVfTot
gen oohu_category = .
replace oohu_category = 1 if oohuMedian <= 13 & oohuMedian != .
replace oohu_category = 2 if oohuMedian >= 14 & oohuMedian <= 18 & oohuMedian != .
replace oohu_category = 3 if oohuMedian >= 19 & oohuMedian != .
label variable oohu_category "owner occupied household value"
notes oohu_category: "1: less than 100K, 2: 100K - Less than 250K, 3: 250K or More"
sort oohu_category
by oohu_category: sum allVfTot
gen pov_category = .
replace pov_category = 1 if perPov < 8 & perPov != .
replace pov_category = 2 if perPov <= 18 & perPov >=8 & perPov != .
replace pov_category = 3 if perPov > 18 & perPov != .
label variable pov_category "poverty category"
notes pov_category: "1: 0-8, 2: 8-18, 3: over 18"
sort pov_category
by pov_category: sum allVfTot 
gen educ_category = .
replace educ_category = 1 if perUneduc < 14 & perUneduc != .
replace educ_category = 2 if perUneduc >= 14 & perUneduc <= 25 & perUneduc != .
replace educ_category = 3 if perUneduc > 25 & perUneduc != .
label variable educ_category "education category"
notes educ_category: "1: less than 14% are uneducated, 2: 14-25% are uneducated, 3: more than 25% uneducated"
sort educ_category
by educ_category: sum allVfTot
gen lang_category = .
replace lang_category = 0 if perLimEng == 0 & perLimEng != .
replace lang_category = 1 if perLimEng > 0 & perLimEng <= 6 & perLimEng != .
replace lang_category = 2 if perLimEng > 6 & perLimEng != .
label variable lang_category "english fluency category"
notes lang_category: "1: 0 , 2: 0-10, 3: 10 or more"
sort lang_category
by lang_category: sum allVfTot 
gen popDens_category = .
replace popDens_category = 1 if popDensMi < 3 & popDensMi != .
replace popDens_category = 2 if popDensMi >= 3 & popDensMi <=30 & popDensMi != .
replace popDens_category = 3 if popDensMi > 30 & popDensMi != .
label variable popDens_category "population density category"
notes popDens_category: "1: less than 3 people per square mile. 2: 3-30 people per square mile, 3: more than 30 people per square mile"
sort popDens_category
by popDens_category: sum allVfTot
gen org_category = .
replace org_category = 1 if registeredorgs < 30 & registeredorgs != .
replace org_category = 2 if registeredorgs >= 30 & registeredorgs <= 200 & registeredorgs != .
replace org_category = 3 if registeredorgs > 200 & registeredorgs != .
label variable org_category "organizational capacity category"
notes org_category: "1: less than 30 ngos registered in county, 2: 30-200 ngo registered in county. 3: more than 200 ngos registered in county"
sort org_category
by org_category: sum allVfTot
gen race_category = .
replace race_category = 1 if perWhite > 50 & perWhite != .
replace race_category = 2 if perBlack > 50 & perBlack != .
replace race_category = 3 if perHisp > 50 & perHisp != .
label variable race_category "racial majority category"
notes race_category: "1- majority white. 2- majority black. 3- majority hispanic"
sort race_category
by race_category: sum allVfTot
save 36-bg12_20171109
//
/********-*********-*********-*********-*********-*********-*********/
/* facility level summary statistics 								*/
/********-*********-*********-*********-*********-*********-*********/
//
use 34-oil&gasWsubsid_20171104, replace
count
drop if perBlack == .
count
drop popDens popDensMi
gen popDens = age_pop / aland 
label variable popDens "people per square meter"
gen popDensMi = popDens * 2589988.11
label variable popDensMi "people per square mile"
label variable popDensMi
sum vfLease vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp
sort vfLease
by vfLease: sum vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp
pwcorr vfLease vfTot incMedian oohuMedian perPov ///
	perUneduc perLimEng popDensMi registeredorgs perBlack perHisp, sig
tabstat vfTot, statistics(mean median skewness kurtosis) by (vfLease) columns(statistics)
cd graphs
histogram vfTot, percent normal ///
	title(Block Group Venting and Flaring Volume Distribution) subtitle(All Texas Block Groups In 2012) ///
	note(Source: Texas Railroad Commission Production Data Query Dump) scheme(sj)
graph export 36-allVfTotBgHist_20171109.pdf, replace
cd ..
//
// community summary statistics
use 34-oil&gasWsubsid_20171104, replace
drop popDens popDensMi
gen popDens = age_pop / aland 
label variable popDens "people per square meter"
gen popDensMi = popDens * 2589988.11
label variable popDensMi "people per square mile"
label variable popDensMi
drop if perBlack == .
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
gen pov_category = .
replace pov_category = 1 if perPov < 8 & perPov != .
replace pov_category = 2 if perPov <= 18 & perPov >= 8 & perPov != .
replace pov_category = 3 if perPov > 18 & perPov != .
label variable pov_category "poverty category"
notes pov_category: "1: 0-8, 2: 8-18, 3: over 18"
sort pov_category
by pov_category: sum vfTot 
gen educ_category = .
replace educ_category = 1 if perUneduc < 14 & perUneduc != .
replace educ_category = 2 if perUneduc >= 14 & perUneduc <= 25 & perUneduc != .
replace educ_category = 3 if perUneduc > 25 & perUneduc != .
label variable educ_category "education category"
notes educ_category: "1: less than 14% are uneducated, 2: 14-25% are uneducated, 3: more than 25% uneducated"
sort educ_category
by educ_category: sum vfTot
gen lang_category = .
replace lang_category = 0 if perLimEng == 0 & perLimEng != .
replace lang_category = 1 if perLimEng > 0 & perLimEng <= 6 & perLimEng != .
replace lang_category = 2 if perLimEng > 6 & perLimEng != .
label variable lang_category "english fluency category"
notes lang_category: "1: 0 , 2: 0-10, 3: 10 or more"
sort lang_category
by lang_category: sum vfTot 
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
save 36-fac12_20171109
cd ..
//
//