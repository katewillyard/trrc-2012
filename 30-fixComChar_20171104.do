cd "C:/Users/katew/Documents/eocpc/posted/logFile"
capture log close master
log using 30-fixComChar_20171104, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		30-fixComChar_20171104.do
// task:		fix and clean oil lease and gas acs code
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
version 13
set more off
cd "C:/Users/katew/Documents/eocpc"
//
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil lease data												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited s29_oilLeaseLvl_20171102, delimiter(",")
cd ..
cd working
rename area aland
label variable aland "land area"
note aland: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_base emp_pop
label variable emp_pop "population count employment table"
note emp_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_unemployed emp_notEmployed
label variable emp_notEmployed "unemployed count"
note emp_notEmployed: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perUnemp = 100 * emp_notEmployed/ emp_pop
label variable perUnemp "percent unemployed"
note perUnemp: "Percent of residents 16 and over that live in block groups whose centroid is within one mile of the well that are not employed"
note perUnemp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename popdens popDens
label variable popDens "people per square meter"
notes popDens: "people per square meter in block groups whose centroid is within one mile of well"
note popDens: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_base age_pop
label variable age_pop "population count age table "
note age_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_old age_65over
label variable age_65over "total individuals 65 or older in block group"
note age_65over: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perold perOld
label variable perOld "percent 65 and older"
note perOld: "Percent of residents that live in block groups whose centroid is within one mile of the well that are 65 or older"
note perOld: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_base educ_pop
label variable educ_pop "population count education table"
note educ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_nodiploma educ_nodip
label variable educ_nodip "individuals 25 and older without a diploma"
note educ_nodip: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peruneducated perUneduc
label variable perUneduc "percent without highschool diploma"
note perUneduc: "Percent of residents 25 and older that live in block groups whose centroid is within one mile of the well that do not have a higschool diploma"
note perUneduc: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_base eth_pop
label variable eth_pop "population count ethnicity table"
note eth_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_white eth_white
label variable eth_white "nonhispanic white count"
note eth_white: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_black eth_black
label variable eth_black "nonhispanic black count"
note eth_black: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_hisp eth_hisp 
label variable eth_hisp "hispanic count"
note eth_hisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perwhitenonhisp perWhite
rename perblack perBlack
gen perHisp = 100 * eth_hisp / eth_pop
label variable perWhite "percent white"
label variable perBlack "percent black"
label variable perHisp "percent hispanic"
note perWhite: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic white"
note perBlack: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic black" 
note perHisp: "Percent of residents that live in block groups whose centroids are within one mile of the well that are hispanic"
note perWhite: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perBlack: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perHisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_base lang_pop
label variable lang_pop "population count language table"
note lang_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_limenglish lang_limenghh
label variable lang_limenghh "limited english speaking household count"
note lang_limenghh: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perLimEng = 100 * lang_limenghh / lang_pop
label variable perLimEng "percent limited english speaking households"
note perLimEng: "percent of households that are within block groups whose centroids are within one mile of the well"
note perLimEng: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_less10k "total households in block group that are valued less than 10k"
note oohu_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_10kto14999 "total households in block group that are valued 10k-14999"
note oohu_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_15kto19999 "total households in block group that are valued 15k-19999"
note oohu_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_20kto24999 "total households in block group that are valued 20k-24999"
note oohu_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_25kto29999 "total households in block group that are valued 25k-29999"
note oohu_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_30kto34999 "total households in block group that are valued 30k-34999"
note oohu_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_35kto39999 "total households in block group that are valued 35k-39999"
note oohu_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_40kto49999 "total households in block group that are valued 40k-49999"
note oohu_40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_50kto59999 "total households in block group that are valued 50k-59999"
note oohu_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_60kto69999 "total households in block group that are valued 60k-69999"
note oohu_60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_70kto79999 "total households in block group that are valued 70k-79999"
note oohu_70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_80kto89999 "total households in block group that are valued 80k-89999"
note oohu_80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_90kto99999 "total households in block group that are valued 90k-99999"
note oohu_90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_100kto124999 "total households in block group that are valued 100k-124999"
note oohu_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_125kto149999 "total households in block group that are valued 125k-149999"
note oohu_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_150kto174999 "total households in block group that are valued 150k-174999"
note oohu_150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_175kto199999 "total households in block group that are valued 175k-199999"
note oohu_175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_200kto249999 "total households in block group that are valued 200k-249999"
note oohu_200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_250kto299999 "total households in block group that are valued 250k-299999"
note oohu_250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_300kto399999 "total households in block group that are valued 300k-399999"
note oohu_300kto399999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_400kto499999 "total households in block group that are valued 400k-499999"
note oohu_400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_500kto749999 "total households in block group that are valued 500k-749999"
note oohu_500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_750kto999999 "total households in block group that are valued 750k-999999"
note oohu_750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_1mmore "total households in block group that are valued more than 1 million"
note oohu_1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_less10k "total households in block group that are valued less than 10k"
note oohu_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_10kto14999 "total households in block group that are valued 10k-14999"
note oohu_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_15kto19999 "total households in block group that are valued 15k-19999"
note oohu_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_20kto24999 "total households in block group that are valued 20k-24999"
note oohu_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_25kto29999 "total households in block group that are valued 25k-29999"
note oohu_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_30kto34999 "total households in block group that are valued 30k-34999"
note oohu_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_35kto39999 "total households in block group that are valued 35k-39999"
note oohu_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_40kto49999 "total households in block group that are valued 40k-49999"
note oohu_40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_50kto59999 "total households in block group that are valued 50k-59999"
note oohu_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_60kto69999 "total households in block group that are valued 60k-69999"
note oohu_60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_70kto79999 "total households in block group that are valued 70k-79999"
note oohu_70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_80kto89999 "total households in block group that are valued 80k-89999"
note oohu_80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_90kto99999 "total households in block group that are valued 90k-99999"
note oohu_90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_100kto124999 "total households in block group that are valued 100k-124999"
note oohu_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_125kto149999 "total households in block group that are valued 125k-149999"
note oohu_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_150kto174999 "total households in block group that are valued 150k-174999"
note oohu_150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_175kto199999 "total households in block group that are valued 175k-199999"
note oohu_175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_200kto249999 "total households in block group that are valued 200k-249999"
note oohu_200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_250kto299999 "total households in block group that are valued 250k-299999"
note oohu_250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_300kto399999 "total households in block group that are valued 300k-399999"
note oohu_300kto399999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_400kto499999 "total households in block group that are valued 400k-499999"
note oohu_400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_500kto749999 "total households in block group that are valued 500k-749999"
note oohu_500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_750kto999999 "total households in block group that are valued 750k-999999"
note oohu_750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_1mmore "total households in block group that are valued more than 1 million"
note oohu_1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen totalhouseholds = oohu_less10k + oohu_10kto14999 + oohu_15kto19999 + ///
	oohu_20kto24999 + oohu_25kto29999 + oohu_30kto34999 + oohu_35kto39999 + ///
	oohu_40kto49999 + oohu_50kto59999 + oohu_60kto69999 + oohu_70kto79999 + ///
	oohu_80kto89999 + oohu_90kto99999 + oohu_100kto124999 + oohu_150kto174999 + ///
	oohu_175kto199999 + oohu_200kto249999 + oohu_250kto299999 + oohu_300kto399999 + ///
	oohu_400kto499999 + oohu_500kto749999 + oohu_750kto999999 + oohu_1mmore
label variable totalhouseholds "total households in block group"
note totalhouseholds: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
rename peroohuless10k perOohuLess10k
label variable perOohuLess10k "percent of owner occupied households valued less than 10K"
notes perOohuLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu10kto14999 perOohu10kto14999
label variable perOohu10kto14999 "percent of owner occupied households valued 10k to 14999"
notes perOohu10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu15kto19999 perOohu15kto19999
label variable perOohu15kto19999 "percent of owner occupied households valued 15k to 19999"
notes perOohu15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu20kto24999 perOohu20kto24999
label variable perOohu20kto24999 "percent of owner occupied households valued 20k to 24999"
notes perOohu20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu25kto29999 perOohu25kto29999
label variable perOohu25kto29999 "percent of owner occupied households valued 25k to 29999"
notes perOohu25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu30kto34999 perOohu30kto34999
label variable perOohu30kto34999 "percent of owner occupied households valued 30k to 34999"
notes perOohu30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu35kto39999 perOohu35kto39999
label variable perOohu35kto39999 "percent of owner occupied households valued 35k to 39999"
notes perOohu35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu40kto49999 perOohu40kto49999
label variable perOohu40kto49999 "percent of owner occupied households valued 40k to 49999"
notes perOohu40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu50kto59999 perOohu50kto59999
label variable perOohu50kto59999 "percent of owner occupied households valued 50k to 59999"
notes perOohu50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu60kto69999 perOohu60kto69999
label variable perOohu60kto69999 "percent of owner occupied households valued 60k to 69999"
notes perOohu60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu70kto79999 perOohu70kto79999
label variable perOohu70kto79999 "percent of owner occupied households valued 70k to 79999"
notes perOohu70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu80kto89999 perOohu80kto89999
label variable perOohu80kto89999 "percent of owner occupied households valued 80k to 89999"
notes perOohu80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu90kto99999 perOohu90kto99999
label variable perOohu90kto99999 "percent of owner occupied households valued 90k to 99999"
notes perOohu90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu100kto124999 perOohu100kto124999
label variable perOohu100kto124999 "percent of owner occupied households valued 100k to 124999"
notes perOohu100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu125kto149999 perOohu125kto149999
label variable perOohu125kto149999 "percent of owner occupied households valued 125k to 149999"
notes perOohu125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu150kto174999 perOohu150kto174999
label variable perOohu150kto174999 "percent of owner occupied households valued 150k to 174999"
notes perOohu150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu175kto199999 perOohu175kto199999
label variable perOohu175kto199999 "percent of owner occupied households valued 175k to 199999"
notes perOohu175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu200kto249999 perOohu200kto249999
label variable perOohu200kto249999 "percent of owner occupied households valued 200k to 249999"
notes perOohu200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu250kto299999 perOohu250kto299999
label variable perOohu250kto299999 "percent of owner occupied households valued 250k to 299999"
notes perOohu250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu300kto39999 perOohu300kto39999
label variable perOohu300kto39999 "percent of owner occupied households valued 300k to 39999"
notes perOohu300kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu400kto499999 perOohu400kto499999
label variable perOohu400kto499999 "percent of owner occupied households valued 400k to 499999"
notes perOohu400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu500kto749999 perOohu500kto749999
label variable perOohu500kto749999 "percent of owner occupied households valued 500k to 7499999"
notes perOohu500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu750kto999999 perOohu750kto999999
label variable perOohu750kto999999 "percent of owner occupied households valued 750k to 999999"
notes perOohu750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu1mmore perOohu1mmore
label variable perOohu1mmore "percent of owner occupied households valued over 1 million"
notes perOohu1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohumedian oohu_median
label variable oohu_median "house median"
gen oohuMedian = .
label variable oohuMedian "median value of owner occupied households"
note oohuMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace oohuMedian = 1 if oohuMedian == . & perOohuLess10k >= 50
label define oohuMedian 1 "median value of owner occupied households is less than 10k"
replace oohuMedian = 2 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 >= 50
label define oohuMedian 2 "median value of owner occupied households is 10k to 14999", add
replace oohuMedian = 3 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 >= 50
label define oohuMedian 3 "median value of owner occupied households is 15k to 14999", add
replace oohuMedian = 4 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 >= 50
label define oohuMedian 4 "median value of owner occupied household is 20k to 24999", add
replace oohuMedian = 5 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 >= 50
label define oohuMedian 5 "median value of owner occupied household is 25 k to 29999", add
replace oohuMedian = 6 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 >= 50
label define oohuMedian 6 "median value of owner occupied household is 30k to 34999", add
replace oohuMedian = 7 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 >= 50
label define oohuMedian 7 "median value of owner occupied household is 35k to 39999", add
replace oohuMedian = 8 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 >= 50
label define oohuMedian 8 "median value of owner occupied household is 40k to 49999", add
replace oohuMedian = 9 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 >= 50
label define oohuMedian 9 "median value of owner occupied household is 50k to 59999", add
replace oohuMedian = 10 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 >= 50
label define oohuMedian 10 "median value of owner occupied household is 60 k to 69999", add
replace oohuMedian = 11 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 >= 50
label define oohuMedian 11 "median value of owner occupied household is 70 k to 79999", add
replace oohuMedian = 12 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 >= 50
label define oohuMedian 12 "median value of owner occupied household is 80k to 89999", add
replace oohuMedian = 13 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 >= 50
label define oohuMedian 13 "median value of owner occupied houseing is 90k to 99999", add
replace oohuMedian = 14 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 >= 50
label define oohuMedian 14 "median value of owner occupied houshold is 100k to 124999", add
replace oohuMedian = 15 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 >= 50
label define oohuMedian 15 "median value of owner occupied household is 125k to 149999", add
replace oohuMedian = 16 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 >= 50
label define oohuMedian 16 "median value of owner occupied household is 150k to 174999", add
replace oohuMedian = 17 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 >= 50
label define oohuMedian 17 "median value of owner occupied household is 175k to 199999", add
replace oohuMedian = 18 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 >= 50
label define oohuMedian 18 "median value of owner occupied household is 200k to 249999", add
replace oohuMedian = 19 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 >= 50
label define oohuMedian 19 "median value of owner occupied household is 250k to 299999", add
replace oohuMedian = 20 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 >= 50
label define oohuMedian 20 "median value of owner occupied household is 300k to 399999", add
replace oohuMedian = 21 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 >= 50
label define oohuMedian 21 "median value of owner occupied household is 400k to 499999", add
replace oohuMedian = 22 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 >= 50
label define oohuMedian 22 "median value of owner occupied household is 500k to 749999", add
replace oohuMedian = 23 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + perOohu750kto999999 >= 50
label define oohuMedian 23 "median value of owner occupied household is 750k to 999999", add
replace oohuMedian = 24 if oohuMedian == . & perOohuLess10k + ///
	perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + ///
	perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + ///
	perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + ///
	perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + ///
	perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + ///
	perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + ///
	perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + ///
	perOohu750kto999999 + perOohu1mmore >= 50
label define oohuMedian 24 "median value of owner occupied household is 1 million or more", add
rename totalhouseholds oohu_pop
rename inc_base totalhouseholds
label variable totalhouseholds "total households in block group"
note totalhouseholds: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
rename perincless10k perIncLess10k 
label variable perIncLess10k "prcent of households whose income is less than 10k"
note perIncLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc10kto14999 perInc10kto14999 
label variable perInc10kto14999 "percent of households whose income is 10k-14999"
note perInc10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc15kto19999 perInc15kto19999
label variable perInc15kto19999 "percent of households whose income is 15k-19999"
note perInc15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc20kto24999 perInc20kto24999
label variable perInc20kto24999 "percent of households whose income is 20k to 24999"
note perInc20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc25kto29999 perInc25kto29999
label variable perInc25kto29999 "percent o fhouseholds whose income is 25k to 29999"
note perInc25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc30kto34999 perInc30kto34999
label variable perInc30kto34999 "percent of households whose income is 30k to 34999"
note perInc30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc35kto39999 perInc35kto39999
label variable perInc35kto39999 "percent of households whose income is 35k to 39999"
note perInc35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc40kto44999  perInc40kto44999 
label variable perInc40kto44999 "percent of households whose income is 40kto44999"
note perInc40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc45kto49999 perInc45kto49999
label variable perInc45kto49999 "percent of households whose income is 45kto 49999"
note perInc45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc50kto59999 perInc50kto59999
label variable perInc50kto59999 "percent of households whose income is 50k to 59999"
note perInc50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc60kto74999 perInc60kto74999 
label variable perInc60kto74999 "percent of households whose income is 60k to 74999"
note perInc60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc75kto99999 perInc75kto99999
label variable perInc75kto99999 "percent of households whose income is 75k to 99999"
note perInc75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc100kto124999 perInc100kto124999
label variable perInc100kto124999 "percent of households whose income is 100 k to 124999"
note perInc100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc125kto149999 perInc125kto149999
label variable perInc125kto149999 "percent of households whose income is 125k to 149999"
note perInc125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc150kto199999 perInc150kto199999
label variable perInc150kto199999 "percent of households whose incoem is 150k to 199999"
note perInc150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perincmore200k perIncMore200k
label variable perIncMore200k "percent of households whose income is more than 200k"
note perIncMore200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename incmedian inc_median
label variable inc_median "median income"
gen incMedian = .
label variable incMedian "median household income"
note incMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace incMedian = 1 if incMedian == . & perIncLess10k >= 50
label define incMedian 1 "median household income is less than 10k"
replace incMedian = 2 if incMedian == . & perIncLess10k + perInc10kto14999 >= 50
label define incMedian 2 "median household income is 10k to 14999", add
replace incMedian = 3 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 >= 50
label define incMedian 3 "median household income is 15k to 19999", add
replace incMedian = 4 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 >= 50
label define incMedian 4 "median household income is 20k to 24999", add
replace incMedian = 5 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 >= 50
label define incMedian 5 "median household income is 25k to 29999", add
replace incMedian = 6 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 >= 50
label define incMedian 6 "median household income is 30k to 34999", add
replace incMedian= 7 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 >= 50
label define incMedian 7 "median household income is 35k to 39999", add
replace incMedian = 8 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 >= 50
label define incMedian 8 "median household income is 40k to 44999", add
replace incMedian = 9 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 >= 50
label define incMedian 9 "median household income is 45k to 49999", add
replace incMedian = 10 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 >= 50
label define incMedian 10 "median household income is 50k to 59999", add
replace incMedian = 11 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 >= 50
label define incMedian 11 "median household income is 60k to 74999", add
replace incMedian = 12 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 >= 50
label define incMedian 12 "median household income is 75k to 99999", add
replace incMedian = 13 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 >= 50
label define incMedian 13 "median household income is 100k to 124999", add
replace incMedian = 14 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 >= 50
label define incMedian 14 "median household income is 125k to 149999", add
replace incMedian = 15 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 >= 50
label define incMedian 15 "median household income is 150k to 199999", add
replace incMedian = 16 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 + perIncMore200k >= 50
label define incMedian 16 "median household income is more than 200k", add
label variable inc_less10k "total households in block group that make less than 10 k"
note inc_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_10kto14999 "total households in block group that make 10k-14999"
note inc_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_15kto19999 "total households in block group that make 15k-19999"
note inc_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable inc_20kto24999 "total households in block group that make 20k-24999"
note inc_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable inc_25kto29999 "total households in block group that make 25k-29999"
note inc_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_30kto34999 "total households in block group that make 30k-34999"
note inc_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_35kto39999 "total households in block group that make 35k-39999"
note inc_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_40kto44999 "total households in block group that make 40k-44999"
note inc_40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_45kto49999 "total households in block group that make 45k-49999"
note inc_45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_50kto59999 "total households in block group that make 50k-59999"
note inc_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_60kto74999 "total households in block group that make 60k-74999"
note inc_60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_75kto99999 "total households in block group that make 75k-99999"
note inc_75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_100kto124999 "total households in block group that make 100k-124999"
note inc_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable inc_125kto149999 "total households in block group that make 125k-149999"
note inc_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_150kto199999 "total households that make 150k-199999"
note inc_150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_more200k "total households in block group that make more than 200k"
note inc_more200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename totalhouseholds inc_pop
rename occ_base occ_pop
label variable occ_pop "population count occupation table"
note occ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename occ_ce occ_ftcm
label variable occ_ftcm "full time construction and mining employment count"
note occ_ftcm: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perconstructextractocc perOccConsMi
label variable perOccConsMi "percent employed in contruction or mining industries"
note perOccConsMi: "percent of people 16 and older that live in block groups whose centroid is within one mile of the well surface location that are employed full time in the construction or mining industries"
note perOccConsMi: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_base pov_pop
label variable pov_pop "population count poverty table"
note pov_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_belowpovertyline pov_bel
label variable pov_bel "households at or below the poverty line"
note pov_bel: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perpoverty perPov
label variable perPov "percent under poverty line"
note perPov: "percent of households that are in block groups whose centroid is within one mile of the well surface location that are living below the poverty line"
save oilLeaseLvl, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil production data										*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 21-oil_20170115
cd ..
cd working
drop segIDg api field_district county_code compl_year_code completion_date well_depth fluid_lvl revoked_date denial_date denial_type api_change correct_api no_api api_change_date permit permit_expired swr13a_exception freshWaterWell plug old_api completion_onfile completion_data_outsource extensionsGranted hb1975_certType dateDesignationEffective dateDesignationRevised designationLetterDate certDate water_land bondedDepth estimatedPlugCost shutIn_date plug_bond wells_shutin becomingActive orphanWell wbCounty ssfNo wbSurveyNo blkNo wbSecName webAltSec altSSFNo wbDistSS1 wbDirSS1 wbDirSS2 wbDistSS2 wbLatWGS84 wbLongWGS84 wbPlaneZone eastCC northCC wbLocVerified leaseName secBlkSrvy milesNearTown dirNearTown nameNearTown distSurveyLines locNearWell segID district well group_unit pi_source rule37except_docketNo prodStateFiled poolAuthFiled plugRptFile_date segIDo shutInYear noWBmatch wellDepth spudDate horizontalWell longitude latitude noLocMatch uid prApiNo district_code well_no_display well_type_name lease_number latitudedatum83 longitudedatum83 permitPRmatch completionYear prLocMatch prAPImatch noGIS odfFlarePermitMatch totalVFpermits fvfMatch oilUID long83 lat83 apiLocMatch nad83lat nad83long no83data
duplicates drop
rename wellOP wellop
keep if (lease_oil_prod_vol > 0 & lease_oil_prod_vol != .) | (lease_csgd_prod_vol > 0 & lease_csgd_prod_vol != .)
sort wellop
save oil, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil density												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited 28-oilDensity_20170424.txt, delimiter(";")
cd ..
cd working
drop v1 v2
rename v3 wellop
sort wellop
quietly by wellop: gen welldens = _N
duplicates drop
label variable welldens "number of wells within one mile of lease"
note welldens: "Created by overlaying buffered multipoints from Texas Railroad Commission Digital Map data with surface location points"
save oilDens, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil pipeline distance										*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited 28-oilNearPipe_20170424.txt, delimiter(";")
cd ..
cd working
drop unnecesary unnecessary 
sort wellop
label variable pipedistft "distance between lease and nearest pipeline"
note pipedistft: "Created by calculating nearest distance between lease surface locations from Texas Railroad Commission Digital Map dta and the EIA's Intrastate and Interstate gas pipelines built as of January 1, 2012"
save oilPipe, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil lease count											*/
/********-*********-*********-*********-*********-*********-*********/
//
cd original 
import delimited s2qpdwell_20170324.csv
cd ..
cd working
keep quid esty 
drop if esty > 2012
save estqy, replace
cd ..
cd original
clear
import delimited s2qpdwcll_20170324.csv
cd ..
cd working
keep if (qsum_oil_prod_tot > 0 & qsum_oil_prod_tot != .) | (qsum_csgd_prod_tot > 0 & qsum_csgd_prod_tot != .)
gen wellopShort = oil_gas_code + string(district_no) + string(lease_no) + string(operator_no)
label variable wellopShort "unique well-operator code"
notes wellopShort: "Unique well operator code: Oil Gas Code + District + Lease + Operator"
drop if cycle_year != 2012
keep wellopShort quid operator_no
sort quid
merge 1:m quid using estqy
drop _merge
gen activeWell = 1
gen wellAge = 2012 - esty
keep if wellAge >= 0 | wellAge == .
gen wellAge0 = .
replace wellAge0 = 1 if wellAge == 0
replace wellAge0 = 0 if wellAge != 0
gen wellAge1 = .
replace wellAge1 = 1 if wellAge == 1
replace wellAge1 = 0 if wellAge != 1
gen wellAge2 = .
replace wellAge2 = 1 if wellAge == 2
replace wellAge2 = 0 if wellAge != 2
gen wellAge3 = .
replace wellAge3 = 1 if wellAge == 3
replace wellAge3 = 0 if wellAge != 3
gen wellAge4 = .
replace wellAge4 = 1 if wellAge == 4
replace wellAge4 = 0 if wellAge != 4
gen wellAge5over = .
replace wellAge5over = 1 if wellAge >= 5
replace wellAge5over = 0 if wellAge < 5
sort wellopShort
save oillc, replace
collapse (sum) wellAge0 wellAge1 wellAge2 wellAge3 wellAge4 wellAge5over, by(wellopShort)
rename wellAge0 leaseWellAge0
label variable leaseWellAge0 "wells born in 2012 on lease"
notes leaseWellAge0: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge1 leaseWellAge1
label variable leaseWellAge1 "wells born in 2011 on lease"
notes leaseWellAge1: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge2 leaseWellAge2
label variable leaseWellAge2 "wells born in 2010 on lease"
notes leaseWellAge2: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge3 leaseWellAge3
label variable leaseWellAge3 "wells born in 2009 on lease"
notes leaseWellAge3: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge4 leaseWellAge4
label variable leaseWellAge4 "wells born in 2008 on lease"
notes leaseWellAge4: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge5over leaseWellAge5over
label variable leaseWellAge5over "wells born in 2007 or later on lease"
notes leaseWellAge5over: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
save oillage, replace
clear
use oillc
collapse (sum) wellAge0 wellAge1 wellAge2 wellAge3 wellAge4 wellAge5over, by(operator_no)
rename wellAge0 opWellAge0
label variable opWellAge0 "wells born in 2012 on leases owned by operator"
notes opWellAge0: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge1 opWellAge1
label variable opWellAge1 "wells born in 2011 on leases owned by operator"
notes opWellAge1: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge2 opWellAge2
label variable opWellAge2 "wells born in 2010 on leases owned by operator"
notes opWellAge2: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge3 opWellAge3
label variable opWellAge3 "wells born in 2009 on leases owned by operator"
notes opWellAge3: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge4 opWellAge4
label variable opWellAge4 "wells born in 2008 on leases owned by operator"
notes opWellAge4: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
rename wellAge5over opWellAge5over
label variable opWellAge5over "wells born in 2007 or later on lease"
notes opWellAge5over: "Original Source: Well_GIS_4.11.txt Programized Request to Texas Railroad Commission"
save oiloage, replace
clear
use oillc 
keep wellop operator_no
sort operator_no
merge m:1 operator_no using oiloage 
drop _merge
sort wellopShort
merge m:1 wellopShort using oillage 
duplicates drop
gen leaseWells = leaseWellAge0 + leaseWellAge1+ leaseWellAge2+ leaseWellAge3 + leaseWellAge4+ leaseWellAge5over
label variable leaseWells "total wells on lease in 2012"
gen opWells = opWellAge0 + opWellAge1 + opWellAge2+ opWellAge3+ opWellAge3+ opWellAge5over
label variable opWells "total wells on producing leases controled by the operator in 2012"
drop _merge
save oilleasecount, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil ngo data												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
use 29-nonCollapsedOil_20170225
cd ..
cd working
keep wellOp county registeredorgs f990orgs countyngorevenue countyngoassets f990norgs f990or990norgs 
rename wellOp wellop
duplicates drop
sort wellop
save oilngo, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil operator data											*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted 
use 21-oil_20170115 
cd ..
cd working
keep if (lease_oil_prod_vol > 0 & lease_oil_prod_vol != .) | (lease_csgd_prod_vol > 0 & lease_csgd_prod_vol != .)
keep operator_no wellOP lease_csgd_prod_vol lease_oil_prod_vol lease_csgd_dispcde04_vol
duplicates drop
collapse (sum) lease_csgd_prod_vol lease_oil_prod_vol lease_csgd_dispcde04_vol, by (operator_no)
rename lease_csgd_prod_vol opCsgdProd
label variable opCsgdProd "total casinghead produced by well operator in Texas"
notes opCsgdProd: "Volume of casinghead gas produced in Texas by the operator (in mcf)"
notes opCsgdProd: "Source: Texas Railroad Commission Production Data Query Dump"
rename lease_oil_prod_vol opOilProd
label variable opOilProd "total oil produced by well operator in Texas"
notes opOilProd: "Volume of oil produced in Texas by the operator (in barrels)"
notes opOilProd: "Source: Texas Railroad Commission Production Data Query Dump"
rename lease_csgd_dispcde04_vol opCsgdVf
label variable opCsgdVf "total asinghead vented or flared by well operator in Texas"
notes opCsgdVf: "Volume of casinghead gas vented or flared in Texas by the operator (in mcf)"
notes opCsgdProd: "Source: Texas Railroad Commission Production Data Query Dump"
sort operator_no
save op, replace
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* merge all oil lease data											*/
/********-*********-*********-*********-*********-*********-*********/
//
cd working 
clear
use oilLeaseLvl
sort wellop
merge 1:1 wellop using oilngo
drop _merge
merge 1:1 wellop using oilPipe
drop _merge
merge 1:1 wellop using oilDens
drop _merge
merge 1:1 wellop using oil
drop _merge
drop operatorRefilingFlag operatorP5status operatorMailHold operatorRenewalCode operatorGathererCode operatorMonthRefile opRefileLetDate opRefileNotDate refileRecDate lastRefileRecDate filingProblemDate filingProblemCode opNoMultiUseFlag id  lease_oil_dispcd00_vol lease_oil_dispcd01_vol lease_oil_dispcd02_vol lease_oil_dispcd03_vol lease_oil_dispcd04_vol lease_oil_dispcd05_vol lease_oil_dispcd06_vol lease_oil_dispcd07_vol lease_oil_dispcd08_vol lease_oil_dispcd09_vol lease_oil_dispcd99_vol lease_gas_dispcd01_vol lease_gas_dispcd02_vol lease_gas_dispcd03_vol lease_gas_dispcd04_vol lease_gas_dispcd05_vol lease_gas_dispcd06_vol lease_gas_dispcd07_vol lease_gas_dispcd08_vol lease_gas_dispcd09_vol lease_gas_dispcd99_vol lease_cond_dispcd00_vol lease_cond_dispcd01_vol lease_cond_dispcd02_vol lease_cond_dispcd03_vol lease_cond_dispcd04_vol lease_cond_dispcd05_vol lease_cond_dispcd06_vol lease_cond_dispcd07_vol lease_cond_dispcd08_vol lease_cond_dispcd99_vol lease_csgd_dispcde01_vol lease_csgd_dispcde02_vol lease_csgd_dispcde03_vol lease_csgd_dispcde05_vol lease_csgd_dispcde06_vol lease_csgd_dispcde07_vol lease_csgd_dispcde08_vol lease_csgd_dispcde99_vol 
rename  lease_csgd_dispcde04_vol vfTot
label variable vfTot "lease-year casinghead vented or flared"
notes vfTot: "Lease year total casignhead gas (in mcf) vented or flared"
notes vfTot: "Original Source: Texas Railroad Commission Production Data Query Dump"
rename lease_oil_prod_vol oilTot
label variable oilTot "lease-year volume of oil produced in barrels"
notes oilTot: "Lease yearly total reported volume of crude oil produced (in barrels)"
notes oilTot: "Original Source: Texas Railroad Commission Production Data Query Dump"
drop lease_oil_allow lease_oil_ending_bal lease_gas_prod_vol lease_gas_allow lease_gas_lift_inj_vol lease_cond_prod_vol lease_cond_limit lease_cond_ending_bal 
rename lease_csgd_prod_vol csgdTot
label variable csgdTot "lease-year volume of casinghead gas produced in mcf"
notes csgdTot: "Lease yearly total reported volume of casinghead gas produced (in mcf)"
drop lease_csgd_limit lease_csgd_gas_lift lease_oil_tot_disp lease_gas_tot_disp lease_cond_tot_disp lease_csgd_tot_disp
label variable wellmonthsDisp "months in year that lease reported disposition records"
notes wellmonthsDisp: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable wellOPmonthsDisp "months in year that the disposition records were submitted for the same operator and lease"
notes wellOPmonthsDisp: "Original Source: Texas Railroad Commissin Production Data Query Dump"
drop repID insMergIdLnoOno insMergIdLnoOna insMergIdLnaOno insMergIdLnaOna violation_no calDispTotalCond difPDdispTotalCond difCondProdDisp difCondPtotDtot disposeMoreProdCond calDispTotalGas difPDdispTotalGas difGasProdDisp difGasPtotDtot disposeMoreProdGas violation_no
sort operator_no
quietly by operator_no: gen opLeases = _N
label variable opLeases "producing oil leases owned by the operating company"
notes opLeases: "Source: Texas Railroad Commission Production Data Query Dump"
gen corporation = .
label variable corporation "operator is a corporation"
note corporation: "Original Source: Texas Railroad Commission Organization Report"
replace corporation = 1 if operatorType == "Corporation"
replace corporation = 0 if operatorType != "Corporation"
gen estate = .
label variable estate "operator is an estate"
note estate: "Original Source: Texas Railroad Commission Organization Report"
replace estate = 1 if operatorType == "Estate"
replace estate = 0 if operatorType != "Estate"
gen joint = .
label variable joint "operator is a joint venture"
note joint: "Original Source: Texas Railroad Commission Organization Report"
replace joint = 1 if operatorType == "Joint Venture"
replace joint = 0 if operatorType != "Joint Venture"
gen llc = .
label variable llc "operator is a limited liability company"
note llc: "Original Source: Texas Railroad Commission Organization Report"
replace llc = 1 if operatorType == "Limited Liability Company (LLC)"
replace llc = 0 if operatorType != "Limited Liability Company (LLC)"
gen lmtpart = .
label variable lmtpart "operator is a limited partnership"
note lmtpart: "Original Source: Texas Railroad Commission Organization Report"
replace lmtpart = 1 if operatorType == "LimitedPartnership"
replace lmtpart = 0 if operatorType != "LimitedPartnership"
gen other = .
label variable other "operator is some other form of organization"
note other: "Original Source: Texas Railroad Commission Organization Report"
replace other = 1 if operatorType == "Other"
replace other = 0 if operatorType != "Other"
gen partnership = .
label variable partnership "operator is a partnership"
note partnership: "Original Source: Texas Railroad Commission Organization Report"
replace partnership = 1 if operatorType == "Partnership"
replace partnership = 0 if operatorType != "Partnership"
gen sole = .
label variable sole "operator is a sole proprietorship"
note sole: "Original Source: Texas Railroad Commission Organization Report"
replace sole = 1 if operatorType == "Sole Proprietorship"
replace sole = 0 if operatorType != "Sole Proprietorship"
gen trust = .
label variable trust "operator is a trust"
note trust: "Original Source: Texas Railroad Commission Organization Report"
replace trust = 1 if operatorType == "Trust"
replace trust = 0 if operatorType != "Trust"
sort operator_no
merge m:1 operator_no using op
drop _merge
sort wellop
label variable lease_name "lease name"
gen operatorFF = substr(operatorDateFirstFiled,1,4)
destring operatorFF, replace
gen operatorRRCage = 2012 - operatorFF
label variable operatorRRCage "operator age with rrc"
notes operatorRRCage: "years between 2012 and the year the organization filed with the RRC"
notes operatorRRCage: "Source: Texas Railraod Commission Organization Report"
drop operatorFF
drop gas_well_no fieldNameMismatch fieldNoMismatch calDispTotalOil ///
	difPDdispTotalOil difOilProdDisp difOilProdDisp difOilPtotDtot ///
	disposeMoreProdOil calDispTotalCsgd difPDdispTotalCsgd ///
	difCsgdProdDisp difCsgdPtotDtot disposeMoreProdCsgd perGasFV 
drop if wellop == ""
keep if (oilTot > 0 & oilTot != .) | (csgdTot > 0 & csgdTot != .)
gen wellopShort = oil_gas_code + string(district_no) + string(lease_no) + string(operator_no)
merge 1:1 wellopShort using oilleasecount
keep if _merge == 3
drop _merge
save 30-oilLease_20171104, replace
cd ..
cd posted
save 30-oilLease_20171104
cd ..
clear
//







/********-*********-*********-*********-*********-*********-*********/
/* clean gas lease data												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited s29_gasLeaseLvl_20171102, delimiter(",")
cd ..
cd working
rename area aland
label variable aland "land area"
note aland: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_base emp_pop
label variable emp_pop "population count employment table"
note emp_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_unemployed emp_notEmployed
label variable emp_notEmployed "unemployed count"
note emp_notEmployed: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perUnemp = 100 * emp_notEmployed/ emp_pop
label variable perUnemp "percent unemployed"
note perUnemp: "Percent of residents 16 and over that live in block groups whose centroid is within one mile of the well that are not employed"
note perUnemp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename popdens popDens
label variable popDens "people per square meter"
notes popDens: "people per square meter in block groups whose centroid is within one mile of well"
note popDens: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_base age_pop
label variable age_pop "population count age table "
note age_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_old age_65over
label variable age_65over "total individuals 65 or older in block group"
note age_65over: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perold perOld
label variable perOld "percent 65 and older"
note perOld: "Percent of residents that live in block groups whose centroid is within one mile of the well that are 65 or older"
note perOld: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_base educ_pop
label variable educ_pop "population count education table"
note educ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_nodiploma educ_nodip
label variable educ_nodip "individuals 25 and older without a diploma"
note educ_nodip: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peruneducated perUneduc
label variable perUneduc "percent without highschool diploma"
note perUneduc: "Percent of residents 25 and older that live in block groups whose centroid is within one mile of the well that do not have a higschool diploma"
note perUneduc: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_base eth_pop
label variable eth_pop "population count ethnicity table"
note eth_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_white eth_white
label variable eth_white "nonhispanic white count"
note eth_white: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_black eth_black
label variable eth_black "nonhispanic black count"
note eth_black: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_hisp eth_hisp 
label variable eth_hisp "hispanic count"
note eth_hisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perwhitenonhisp perWhite
rename perblack perBlack
gen perHisp = 100 * eth_hisp / eth_pop
label variable perWhite "percent white"
label variable perBlack "percent black"
label variable perHisp "percent hispanic"
note perWhite: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic white"
note perBlack: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic black" 
note perHisp: "Percent of residents that live in block groups whose centroids are within one mile of the well that are hispanic"
note perWhite: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perBlack: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perHisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_base lang_pop
label variable lang_pop "population count language table"
note lang_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_limenglish lang_limenghh
label variable lang_limenghh "limited english speaking household count"
note lang_limenghh: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perLimEng = 100 * lang_limenghh / lang_pop
label variable perLimEng "percent limited english speaking households"
note perLimEng: "percent of households that are within block groups whose centroids are within one mile of the well"
note perLimEng: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_less10k "total households in block group that are valued less than 10k"
note oohu_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_10kto14999 "total households in block group that are valued 10k-14999"
note oohu_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_15kto19999 "total households in block group that are valued 15k-19999"
note oohu_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_20kto24999 "total households in block group that are valued 20k-24999"
note oohu_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_25kto29999 "total households in block group that are valued 25k-29999"
note oohu_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_30kto34999 "total households in block group that are valued 30k-34999"
note oohu_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_35kto39999 "total households in block group that are valued 35k-39999"
note oohu_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_40kto49999 "total households in block group that are valued 40k-49999"
note oohu_40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_50kto59999 "total households in block group that are valued 50k-59999"
note oohu_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_60kto69999 "total households in block group that are valued 60k-69999"
note oohu_60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_70kto79999 "total households in block group that are valued 70k-79999"
note oohu_70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_80kto89999 "total households in block group that are valued 80k-89999"
note oohu_80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_90kto99999 "total households in block group that are valued 90k-99999"
note oohu_90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_100kto124999 "total households in block group that are valued 100k-124999"
note oohu_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_125kto149999 "total households in block group that are valued 125k-149999"
note oohu_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_150kto174999 "total households in block group that are valued 150k-174999"
note oohu_150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_175kto199999 "total households in block group that are valued 175k-199999"
note oohu_175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_200kto249999 "total households in block group that are valued 200k-249999"
note oohu_200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_250kto299999 "total households in block group that are valued 250k-299999"
note oohu_250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_300kto399999 "total households in block group that are valued 300k-399999"
note oohu_300kto399999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_400kto499999 "total households in block group that are valued 400k-499999"
note oohu_400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_500kto749999 "total households in block group that are valued 500k-749999"
note oohu_500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_750kto999999 "total households in block group that are valued 750k-999999"
note oohu_750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_1mmore "total households in block group that are valued more than 1 million"
note oohu_1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_less10k "total households in block group that are valued less than 10k"
note oohu_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_10kto14999 "total households in block group that are valued 10k-14999"
note oohu_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_15kto19999 "total households in block group that are valued 15k-19999"
note oohu_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_20kto24999 "total households in block group that are valued 20k-24999"
note oohu_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_25kto29999 "total households in block group that are valued 25k-29999"
note oohu_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_30kto34999 "total households in block group that are valued 30k-34999"
note oohu_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_35kto39999 "total households in block group that are valued 35k-39999"
note oohu_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_40kto49999 "total households in block group that are valued 40k-49999"
note oohu_40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_50kto59999 "total households in block group that are valued 50k-59999"
note oohu_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_60kto69999 "total households in block group that are valued 60k-69999"
note oohu_60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_70kto79999 "total households in block group that are valued 70k-79999"
note oohu_70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_80kto89999 "total households in block group that are valued 80k-89999"
note oohu_80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_90kto99999 "total households in block group that are valued 90k-99999"
note oohu_90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_100kto124999 "total households in block group that are valued 100k-124999"
note oohu_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_125kto149999 "total households in block group that are valued 125k-149999"
note oohu_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_150kto174999 "total households in block group that are valued 150k-174999"
note oohu_150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_175kto199999 "total households in block group that are valued 175k-199999"
note oohu_175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_200kto249999 "total households in block group that are valued 200k-249999"
note oohu_200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_250kto299999 "total households in block group that are valued 250k-299999"
note oohu_250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_300kto399999 "total households in block group that are valued 300k-399999"
note oohu_300kto399999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_400kto499999 "total households in block group that are valued 400k-499999"
note oohu_400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_500kto749999 "total households in block group that are valued 500k-749999"
note oohu_500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_750kto999999 "total households in block group that are valued 750k-999999"
note oohu_750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable oohu_1mmore "total households in block group that are valued more than 1 million"
note oohu_1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen totalhouseholds = oohu_less10k + oohu_10kto14999 + oohu_15kto19999 + ///
	oohu_20kto24999 + oohu_25kto29999 + oohu_30kto34999 + oohu_35kto39999 + ///
	oohu_40kto49999 + oohu_50kto59999 + oohu_60kto69999 + oohu_70kto79999 + ///
	oohu_80kto89999 + oohu_90kto99999 + oohu_100kto124999 + oohu_150kto174999 + ///
	oohu_175kto199999 + oohu_200kto249999 + oohu_250kto299999 + oohu_300kto399999 + ///
	oohu_400kto499999 + oohu_500kto749999 + oohu_750kto999999 + oohu_1mmore
label variable totalhouseholds "total households in block group"
note totalhouseholds: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
rename peroohuless10k perOohuLess10k
label variable perOohuLess10k "percent of owner occupied households valued less than 10K"
notes perOohuLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu10kto14999 perOohu10kto14999
label variable perOohu10kto14999 "percent of owner occupied households valued 10k to 14999"
notes perOohu10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu15kto19999 perOohu15kto19999
label variable perOohu15kto19999 "percent of owner occupied households valued 15k to 19999"
notes perOohu15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu20kto24999 perOohu20kto24999
label variable perOohu20kto24999 "percent of owner occupied households valued 20k to 24999"
notes perOohu20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu25kto29999 perOohu25kto29999
label variable perOohu25kto29999 "percent of owner occupied households valued 25k to 29999"
notes perOohu25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu30kto34999 perOohu30kto34999
label variable perOohu30kto34999 "percent of owner occupied households valued 30k to 34999"
notes perOohu30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu35kto39999 perOohu35kto39999
label variable perOohu35kto39999 "percent of owner occupied households valued 35k to 39999"
notes perOohu35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu40kto49999 perOohu40kto49999
label variable perOohu40kto49999 "percent of owner occupied households valued 40k to 49999"
notes perOohu40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu50kto59999 perOohu50kto59999
label variable perOohu50kto59999 "percent of owner occupied households valued 50k to 59999"
notes perOohu50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu60kto69999 perOohu60kto69999
label variable perOohu60kto69999 "percent of owner occupied households valued 60k to 69999"
notes perOohu60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu70kto79999 perOohu70kto79999
label variable perOohu70kto79999 "percent of owner occupied households valued 70k to 79999"
notes perOohu70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu80kto89999 perOohu80kto89999
label variable perOohu80kto89999 "percent of owner occupied households valued 80k to 89999"
notes perOohu80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu90kto99999 perOohu90kto99999
label variable perOohu90kto99999 "percent of owner occupied households valued 90k to 99999"
notes perOohu90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu100kto124999 perOohu100kto124999
label variable perOohu100kto124999 "percent of owner occupied households valued 100k to 124999"
notes perOohu100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu125kto149999 perOohu125kto149999
label variable perOohu125kto149999 "percent of owner occupied households valued 125k to 149999"
notes perOohu125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu150kto174999 perOohu150kto174999
label variable perOohu150kto174999 "percent of owner occupied households valued 150k to 174999"
notes perOohu150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu175kto199999 perOohu175kto199999
label variable perOohu175kto199999 "percent of owner occupied households valued 175k to 199999"
notes perOohu175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu200kto249999 perOohu200kto249999
label variable perOohu200kto249999 "percent of owner occupied households valued 200k to 249999"
notes perOohu200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu250kto299999 perOohu250kto299999
label variable perOohu250kto299999 "percent of owner occupied households valued 250k to 299999"
notes perOohu250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu300kto39999 perOohu300kto39999
label variable perOohu300kto39999 "percent of owner occupied households valued 300k to 39999"
notes perOohu300kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu400kto499999 perOohu400kto499999
label variable perOohu400kto499999 "percent of owner occupied households valued 400k to 499999"
notes perOohu400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu500kto749999 perOohu500kto749999
label variable perOohu500kto749999 "percent of owner occupied households valued 500k to 7499999"
notes perOohu500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu750kto999999 perOohu750kto999999
label variable perOohu750kto999999 "percent of owner occupied households valued 750k to 999999"
notes perOohu750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename peroohu1mmore perOohu1mmore
label variable perOohu1mmore "percent of owner occupied households valued over 1 million"
notes perOohu1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohumedian oohu_median
label variable oohu_median "house median"
gen oohuMedian = .
label variable oohuMedian "median value of owner occupied households"
note oohuMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace oohuMedian = 1 if oohuMedian == . & perOohuLess10k >= 50
label define oohuMedian 1 "median value of owner occupied households is less than 10k"
replace oohuMedian = 2 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 >= 50
label define oohuMedian 2 "median value of owner occupied households is 10k to 14999", add
replace oohuMedian = 3 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 >= 50
label define oohuMedian 3 "median value of owner occupied households is 15k to 14999", add
replace oohuMedian = 4 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 >= 50
label define oohuMedian 4 "median value of owner occupied household is 20k to 24999", add
replace oohuMedian = 5 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 >= 50
label define oohuMedian 5 "median value of owner occupied household is 25 k to 29999", add
replace oohuMedian = 6 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 >= 50
label define oohuMedian 6 "median value of owner occupied household is 30k to 34999", add
replace oohuMedian = 7 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 >= 50
label define oohuMedian 7 "median value of owner occupied household is 35k to 39999", add
replace oohuMedian = 8 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 >= 50
label define oohuMedian 8 "median value of owner occupied household is 40k to 49999", add
replace oohuMedian = 9 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 >= 50
label define oohuMedian 9 "median value of owner occupied household is 50k to 59999", add
replace oohuMedian = 10 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 >= 50
label define oohuMedian 10 "median value of owner occupied household is 60 k to 69999", add
replace oohuMedian = 11 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 >= 50
label define oohuMedian 11 "median value of owner occupied household is 70 k to 79999", add
replace oohuMedian = 12 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 >= 50
label define oohuMedian 12 "median value of owner occupied household is 80k to 89999", add
replace oohuMedian = 13 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 >= 50
label define oohuMedian 13 "median value of owner occupied houseing is 90k to 99999", add
replace oohuMedian = 14 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 >= 50
label define oohuMedian 14 "median value of owner occupied houshold is 100k to 124999", add
replace oohuMedian = 15 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 >= 50
label define oohuMedian 15 "median value of owner occupied household is 125k to 149999", add
replace oohuMedian = 16 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 >= 50
label define oohuMedian 16 "median value of owner occupied household is 150k to 174999", add
replace oohuMedian = 17 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 >= 50
label define oohuMedian 17 "median value of owner occupied household is 175k to 199999", add
replace oohuMedian = 18 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 >= 50
label define oohuMedian 18 "median value of owner occupied household is 200k to 249999", add
replace oohuMedian = 19 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 >= 50
label define oohuMedian 19 "median value of owner occupied household is 250k to 299999", add
replace oohuMedian = 20 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 >= 50
label define oohuMedian 20 "median value of owner occupied household is 300k to 399999", add
replace oohuMedian = 21 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 >= 50
label define oohuMedian 21 "median value of owner occupied household is 400k to 499999", add
replace oohuMedian = 22 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 >= 50
label define oohuMedian 22 "median value of owner occupied household is 500k to 749999", add
replace oohuMedian = 23 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + perOohu750kto999999 >= 50
label define oohuMedian 23 "median value of owner occupied household is 750k to 999999", add
replace oohuMedian = 24 if oohuMedian == . & perOohuLess10k + ///
	perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + ///
	perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + ///
	perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + ///
	perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + ///
	perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + ///
	perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + ///
	perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + ///
	perOohu750kto999999 + perOohu1mmore >= 50
label define oohuMedian 24 "median value of owner occupied household is 1 million or more", add
rename totalhouseholds oohu_pop
rename inc_base totalhouseholds
label variable totalhouseholds "total households in block group"
note totalhouseholds: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
rename perincless10k perIncLess10k 
label variable perIncLess10k "prcent of households whose income is less than 10k"
note perIncLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc10kto14999 perInc10kto14999 
label variable perInc10kto14999 "percent of households whose income is 10k-14999"
note perInc10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc15kto19999 perInc15kto19999
label variable perInc15kto19999 "percent of households whose income is 15k-19999"
note perInc15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc20kto24999 perInc20kto24999
label variable perInc20kto24999 "percent of households whose income is 20k to 24999"
note perInc20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc25kto29999 perInc25kto29999
label variable perInc25kto29999 "percent o fhouseholds whose income is 25k to 29999"
note perInc25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc30kto34999 perInc30kto34999
label variable perInc30kto34999 "percent of households whose income is 30k to 34999"
note perInc30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc35kto39999 perInc35kto39999
label variable perInc35kto39999 "percent of households whose income is 35k to 39999"
note perInc35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc40kto44999  perInc40kto44999 
label variable perInc40kto44999 "percent of households whose income is 40kto44999"
note perInc40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc45kto49999 perInc45kto49999
label variable perInc45kto49999 "percent of households whose income is 45kto 49999"
note perInc45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc50kto59999 perInc50kto59999
label variable perInc50kto59999 "percent of households whose income is 50k to 59999"
note perInc50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc60kto74999 perInc60kto74999 
label variable perInc60kto74999 "percent of households whose income is 60k to 74999"
note perInc60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc75kto99999 perInc75kto99999
label variable perInc75kto99999 "percent of households whose income is 75k to 99999"
note perInc75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc100kto124999 perInc100kto124999
label variable perInc100kto124999 "percent of households whose income is 100 k to 124999"
note perInc100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc125kto149999 perInc125kto149999
label variable perInc125kto149999 "percent of households whose income is 125k to 149999"
note perInc125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perinc150kto199999 perInc150kto199999
label variable perInc150kto199999 "percent of households whose incoem is 150k to 199999"
note perInc150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perincmore200k perIncMore200k
label variable perIncMore200k "percent of households whose income is more than 200k"
note perIncMore200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename incmedian inc_median
label variable inc_median "median income"
gen incMedian = .
label variable incMedian "median household income"
note incMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace incMedian = 1 if incMedian == . & perIncLess10k >= 50
label define incMedian 1 "median household income is less than 10k"
replace incMedian = 2 if incMedian == . & perIncLess10k + perInc10kto14999 >= 50
label define incMedian 2 "median household income is 10k to 14999", add
replace incMedian = 3 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 >= 50
label define incMedian 3 "median household income is 15k to 19999", add
replace incMedian = 4 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 >= 50
label define incMedian 4 "median household income is 20k to 24999", add
replace incMedian = 5 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 >= 50
label define incMedian 5 "median household income is 25k to 29999", add
replace incMedian = 6 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 >= 50
label define incMedian 6 "median household income is 30k to 34999", add
replace incMedian= 7 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 >= 50
label define incMedian 7 "median household income is 35k to 39999", add
replace incMedian = 8 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 >= 50
label define incMedian 8 "median household income is 40k to 44999", add
replace incMedian = 9 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 >= 50
label define incMedian 9 "median household income is 45k to 49999", add
replace incMedian = 10 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 >= 50
label define incMedian 10 "median household income is 50k to 59999", add
replace incMedian = 11 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 >= 50
label define incMedian 11 "median household income is 60k to 74999", add
replace incMedian = 12 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 >= 50
label define incMedian 12 "median household income is 75k to 99999", add
replace incMedian = 13 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 >= 50
label define incMedian 13 "median household income is 100k to 124999", add
replace incMedian = 14 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 >= 50
label define incMedian 14 "median household income is 125k to 149999", add
replace incMedian = 15 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 >= 50
label define incMedian 15 "median household income is 150k to 199999", add
replace incMedian = 16 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 + perIncMore200k >= 50
label define incMedian 16 "median household income is more than 200k", add
label variable inc_less10k "total households in block group that make less than 10 k"
note inc_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_10kto14999 "total households in block group that make 10k-14999"
note inc_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_15kto19999 "total households in block group that make 15k-19999"
note inc_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable inc_20kto24999 "total households in block group that make 20k-24999"
note inc_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable inc_25kto29999 "total households in block group that make 25k-29999"
note inc_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_30kto34999 "total households in block group that make 30k-34999"
note inc_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_35kto39999 "total households in block group that make 35k-39999"
note inc_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_40kto44999 "total households in block group that make 40k-44999"
note inc_40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_45kto49999 "total households in block group that make 45k-49999"
note inc_45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_50kto59999 "total households in block group that make 50k-59999"
note inc_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_60kto74999 "total households in block group that make 60k-74999"
note inc_60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_75kto99999 "total households in block group that make 75k-99999"
note inc_75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_100kto124999 "total households in block group that make 100k-124999"
note inc_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
label variable inc_125kto149999 "total households in block group that make 125k-149999"
note inc_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_150kto199999 "total households that make 150k-199999"
note inc_150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_more200k "total households in block group that make more than 200k"
note inc_more200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename totalhouseholds inc_pop
rename occ_base occ_pop
label variable occ_pop "population count occupation table"
note occ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename occ_ce occ_ftcm
label variable occ_ftcm "full time construction and mining employment count"
note occ_ftcm: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perconstructextractocc perOccConsMi
label variable perOccConsMi "percent employed in contruction or mining industries"
note perOccConsMi: "percent of people 16 and older that live in block groups whose centroid is within one mile of the well surface location that are employed full time in the construction or mining industries"
note perOccConsMi: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_base pov_pop
label variable pov_pop "population count poverty table"
note pov_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_belowpovertyline pov_bel
label variable pov_bel "households at or below the poverty line"
note pov_bel: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename perpoverty perPov
label variable perPov "percent under poverty line"
note perPov: "percent of households that are in block groups whose centroid is within one mile of the well surface location that are living below the poverty line"
save gasLeaseLvl, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean gas density												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited 28-gasDensity_20170424.txt, delimiter(";")
cd ..
cd working
drop notneeded noneed
sort wellop
quietly by wellop: gen welldens = _N
duplicates drop
label variable welldens "number of wells within one mile of lease"
note welldens: "Created by overlaying buffered multipoints from Texas Railroad Commission Digital Map data with surface location points"
save gasDens, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean gas pipeline distance										*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited 28-gasNearPipe_20170424.txt, delimiter(";")
cd ..
cd working
drop unnecesary unnecessary 
duplicates drop
sort wellop
label variable pipedistft "feet between well and nearest pipeline"
note pipedistft: "Created by calculating nearest distance between well surface location from Texas Railroad Commission Digital Map dta and the EIA's Intrastate and Interstate gas pipelines built as of January 1, 2012"
quietly by wellop: gen dup = cond(_N==1,0,1)
drop if dup == 1
drop dup
save gasPipe, replace 
clear
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* clean gas data												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted
import delimited 19-gas_20161230.csv
cd ..
cd working
keep if (lease_gas_prod_vol > 0 & lease_gas_prod_vol != .) | (lease_cond_prod_vol > 0 & lease_cond_prod_vol != .)
label variable operator_no "operator number"
notes operator_no: "Source: Texas Railroad Commission Organization Report"
rename operatorname operatorName
label variable operatorName "operator name"
notes operatorName: "Source: Texas Railroad Commission Organization Report"
drop operatorrefilingflag operatorp5status operatormailhold operatorrenewalcod 
rename operatororgcode operatorOrgCode 
label variable operatorOrgCode "organization type code"
notes operatorOrgCode: "Source: Texas Railroad Commission Organization Report"
rename operatororgtypecomment operatorOrgTypeComment
label variable operatorOrgTypeComment "other organization type comment"
notes operatorOrgTypeComment: "Source: Texas Railroad Commission Organization Report"
drop operatorgatherercode
rename operatormailaddress1 operatorMailAddress1
label variable operatorMailAddress1 "operator address line 1 - mailing"
notes operatorMailAddress1: "Source: Texas Railroad Commission Organization Report"
rename operatormailaddress2 operatorMailAddress2
label variable operatorMailAddress2 "operator address line 2 - mailing"
notes operatorMailAddress2: "Source: Texas Railroad Commission Organization Report"
rename operatormailcity operatorMailCity
label variable operatorMailCity "operatorcity - mailing"
notes operatorMailCity: "Source: Texas Railroad Commission Organization Report"
rename operatormailstate operatorMailState
label variable operatorMailState "operator state - mailing"
notes operatorMailState: "Source: Texas Railroad Commission Organization Report"
rename operatormailzip operatorMailZip
label variable operatorMailZip "operator zip - mailing"
notes operatorMailZip: "Source: Texas Railroad Commission Organization Report"
rename operatormailzipsuf operatorMailZipSuf
label variable operatorMailZipSuf "operator zip code suffix - mailing"
notes operatorMailZipSuf: "Source: Texas Railroad Commission Organization Report"
rename operatorlocaddress1 operatorLocAddress1
label variable operatorLocAddress1 "operator address line 1 - physical location"
notes operatorLocAddress1: "Source: Texas Railroad Commission Organization Report"
rename operatorlocaddress2 operatorLocAddress2
label variable operatorLocAddress2 "operator address line 2 - physical loccation"
notes operatorLocAddress2: "Source: Texas Railroad Commission Organization Report"
rename operatorloccity operatorLocCity
label variable operatorLocCity "operator city - physical location"
notes operatorLocCity: "Source: Texas Railroad Commission Organization Report"
rename operatorlocstate operatorLocState
label variable operatorLocState "operator state - physical location"
notes operatorLocState: "Source: Texas Railroad Commission Organization Report"
rename operatorloczip operatorLocZip
label variable operatorLocZip "operator zip code - physical location"
notes operatorLocZip: "Source: Texas Railroad Commission Organization Report"
rename operatorloczipsuf operatorLocZipSuf
label variable operatorLocZipSuf "operator zip code suffix - physical location"
notes operatorLocZipSuf: "Source: Texas Railroad Commission Organization Report"
rename operatordatefirstfiled operatorDateFirstFiled
label variable operatorDateFirstFiled "operator first file date"
notes operatorDateFirstFiled: "Source: Texas Railroad Commission Organization Report"
rename operatordateinactive operatorDateInactive
label variable operatorDateInactive "date inactive"
notes operatorDateInactive: "Source: Texas Railroad Commission Organization Report"
rename operatorphone operatorPhone 
label variable operatorPhone "operator phone number"
notes operatorPhone: "Source: Texas Railroad Commission Organization Report"
rename operatorotherno operatorOtherNo
label variable operatorOtherNo "other phone number for the operating organization"
notes operatorOtherNo: "Source: Texas Railroad Commission Organization Report"
rename operatorphoneverified operatorPhoneVerified
label variable operatorPhoneVerified "operator phone number was verified"
notes operatorPhoneVerified: "Source: Texas Railroad Commission Organization Report"
rename oilgathstatus oilGathStatus
label variable oilGathStatus "oil gatherer status"
notes oilGathStatus: "Source: Texas Railroad Commission Organization Report"
rename gasgathstatus gasGathStatus
label variable gasGathStatus "gas gatherer status"
notes gasGathStatus: "Source: Texas Railroad Commission Organization Report"
rename operatortaxcert operatorTaxCert
label variable operatorTaxCert "operator tax certificate on file"
notes operatorTaxCert: "Source: Texas Railroad Commission Organization Report"
rename operatoremergencyphone operatorEmergencyPhone 
label variable operatorEmergencyPhone "emergency phone number"
notes operatorEmergencyPhone: "Source: Texas Railroad Commission Organization Report"
rename operatortype operatorType
label variable operatorType "operator type name"
notes operatorType: "Source: Texas Railroad Commission Organization Report"
rename lease_gas_dispcd04_vol vfTot
label variable vfTot "lease-year gas well gas vented or flared"
notes vfTot: "Lease year total gas (in mcf) vented or flared"
notes vfTot: "Original Source: Texas Railroad Commission Production Data Query Dump"
rename lease_gas_prod_vol gasTot
label variable gasTot "lease-year gas well gas produced"
notes gasTot: "Lease yearly total reported volume of gas well gas produced (in mcf)"
notes gasTot: "Original Source: Texas Railroad Commission Production Data Query Dump"
rename lease_cond_prod_vol condTot
label variable condTot "lease-year condensate produced"
notes condTot: "Lease yearly total reported volume of crude oil produced (in barrels)"
notes condTot: "Original Source: Texas Railroad Commission Production Data Query Dump"
rename wellmonthsdisp wellmonthsDisp
label variable wellmonthsDisp "months in year that the disposition was reported for the well"
notes wellmonthsDisp: "Original Source: Texas Railroad Commission Production Data Query Dump"
rename wellopmonthsdisp wellOPmonthsDisp
label variable wellOPmonthsDisp "months in year that the disposition was reported for the well by the operator"
notes wellOPmonthsDisp: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable oil_gas_code "well type"
notes oil_gas_code: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable district_no "district number"
notes district_no: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable lease_no "lease number"
notes lease_no: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable cycle_year "year"
notes cycle_year: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable field_no "field number"
notes field_no: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable district_name "district name"
notes district_name: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable field_name "field name"
notes field_name: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable operator_name "operator name"
notes operator_name: "Source: Texas Railroad Commission Organization Report"
rename wellid wellID 
label variable wellID "Unique Well Number"
notes wellID: "unique well identifier made up of district and lease number"
notes wellID: "Original Source: Texas Railroad Commission Production Data Query Dump"
rename changeopdisp changeOPdisp
label variable changeOPdisp "Changed operators in disposition records"
notes changeOPdisp: "Original Source: Texas Railroad Commission Production Data Query Dump"
rename nopchangesdisp nOPchangesDisp
label variable nOPchangesDisp "Number of operator changes in 2012"
notes nOPchangesDisp: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable lease_no_district_no "lease district number"
notes lease_no_district_no: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable gas_well_no "gas well number"
notes gas_well_no: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable lease_name "lease name"
notes lease_name: "Original Source: Texas Railroad Commission Production Data Query Dump"
gen perGasFV = .
replace perGasFV = 0 if vfTot == 0
replace perGasFV = 0 if gasTot == 0
replace perGasFV = 100 * vfTot / gasTot if gasTot != 0 | vfTot != 0
label variable perGasFV "percent gas vented or flared"
notes perGasFV: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable wellmonthsDisp "months in year that lease reported disposition records"
notes wellmonthsDisp: "Original Source: Texas Railroad Commission Production Data Query Dump"
label variable wellOPmonthsDisp "months in year that the disposition records were submitted for the same operator and lease"
notes wellOPmonthsDisp: "Original Source: Texas Railroad Commissin Production Data Query Dump"
drop id lease_oil_dispcd00_vol lease_oil_dispcd01_vol ///
	lease_oil_dispcd02_vol lease_oil_dispcd03_vol ///
	lease_oil_dispcd04_vol lease_oil_dispcd05_vol ///
	lease_oil_dispcd06_vol lease_oil_dispcd07_vol ///
	lease_oil_dispcd08_vol lease_oil_dispcd09_vol ///
	lease_oil_dispcd99_vol lease_gas_dispcd01_vol ///
	lease_gas_dispcd02_vol lease_gas_dispcd03_vol ///
	lease_gas_dispcd05_vol lease_gas_dispcd06_vol ///
	lease_gas_dispcd07_vol lease_gas_dispcd08_vol ///
	lease_gas_dispcd09_vol lease_gas_dispcd99_vol ///
	lease_cond_dispcd00_vol lease_cond_dispcd01_vol ///
	lease_cond_dispcd02_vol lease_cond_dispcd03_vol ///
	lease_cond_dispcd04_vol lease_cond_dispcd05_vol ///
	lease_cond_dispcd06_vol lease_cond_dispcd07_vol ///
	lease_cond_dispcd08_vol lease_cond_dispcd99_vol ///
	lease_csgd_dispcde01_vol lease_csgd_dispcde02_vol ///
	lease_csgd_dispcde03_vol lease_csgd_dispcde04_vol ///
	lease_csgd_dispcde05_vol lease_csgd_dispcde06_vol ///
	lease_csgd_dispcde07_vol lease_csgd_dispcde08_vol ///
	lease_csgd_dispcde99_vol lease_oil_prod_vol lease_oil_allow ///
	lease_oil_ending_bal lease_gas_allow lease_gas_lift_inj_vol ///
	lease_cond_limit lease_cond_ending_bal lease_csgd_prod_vol ///
	lease_csgd_limit lease_csgd_gas_lift lease_oil_tot_disp ///
	lease_gas_tot_disp lease_cond_tot_disp lease_csgd_tot_disp ///
	repid caldisptotaloil difpddisptotaloil difoilproddisp ///
	difoilptotdtot disposemoreprodoil caldisptotalgas ///
	difpddisptotalgas difgasproddisp difgasptotdtot disposemoreprodgas ///
	caldisptotalcond difpddisptotalcond difcondproddisp difcondptotdtot ///
	disposemoreprodcond caldisptotalcsgd difpddisptotalcsgd difcsgdproddisp ///
	difcsgdptotdtot disposemoreprodcsgd percsgdfv insmergidlnoono ///
	insmergidlnoona insmergidlnaono insmergidlnaona segidg field_district ///
	county_code fluid_lvl revoked_date denial_date denial_type api_change ///
	correct_api no_api api_change_date permit permit_expired swr13a_exception ///
	plug old_api completion_onfile completion_data_outsource extensionsgranted ///
	hb1975_certtype datedesignationeffective datedesignationrevised ///
	designationletterdate certdate water_land bondeddepth shutin_date ///
	plug_bond wells_shutin becomingactive orphanwell wbcounty ssfno ///
	wbsurveyno blkno wbsecname webaltsec altssfno wbdistss1 wbdirss1 ///
	wbdistss2 wbdirss2 wblatwgs84 wblongwgs84 wbplanezone eastcc ///
	northcc wblocverified leasename secblksrvy milesneartown ///
	dirneartown nameneartown distsurveylines locnearwell segid ///
	district well group_unit pi_source rule37except_docketno ///
	prodstatefiled plugrptfile_date poolauthfiled segido shutinyear ///
	nowbmatch uid prapino district_code well_no_display well_type_name ///
	lease_number latitudedatum83 longitudedatum83 permitprmatch prlocmatch ///
	prapimatch odfflarepermitmatch nogis fvfmatch totalvfpermits gasuid ///
	fieldnamemismatch fieldnomismatch nodispreported noprodreported pergasfv ///
	violation_no compl_year_code completion_date longitude latitude nolocmatch
label variable wellop "unique well operator well id"
notes wellop: "Source: Texas Railroad Commission Production Data Query Dump"
label variable api_no "api number"
notes api_no: "Source: Texas Railroad Commission Full Wellbore Query Data"
label variable well_depth "well depth"
notes well_depth: "Source: Texas Railroad Commission Drilling Permit Master and Trailer Plus Longitudes and Latitudes"
rename freshwaterwell freshWaterWell 
label variable freshWaterWell "fresh water well"
notes freshWaterWell: "Source: Texas Railroad Commission Drilling Permit Master and Trailer Plus Longitudes and Latitudes"
rename estimatedplugcost estimatedPlugCost
label variable estimatedPlugCost "estimated cost to plug the well"
rename welldepth wellDepth 
label variable wellDepth "well depth"
notes wellDepth: "Source: Texas Railroad Commission Drilling Permit Master and Trailer Plus Longitudes and Latitudes"
rename spuddate spudDate
label variable spudDate "spud date"
notes spudDate: "Source: Drilling Permit Master and Trailer Plus Longitudes and Latitudes"
rename horizontalwell horizontalWell
label variable horizontalWell "horizontal well"
notes horizontalWell: "Source: Texas Railroad Commission Drilling Permit Master and Trailer Plus Longitudes and Latitudes"
rename completionyear completionYear
label variable completionYear "completion year"
notes completionYear: "Source: Texas Railroad Commission Full Wellbore Query Data"
sort operator_no
quietly by operator_no: gen opWells = _N
notes opWells: "Source: Texas Railroad Commission Production Data Query Dump"
label variable opWells "producing gas wells owned by operator"
gen corporation = .
label variable corporation "operator is a corporation"
note corporation: "Original Source: Texas Railroad Commission Organization Report"
replace corporation = 1 if operatorType == "Corporation"
replace corporation = 0 if operatorType != "Corporation"
gen estate = .
label variable estate "operator is an estate"
note estate: "Original Source: Texas Railroad Commission Organization Report"
replace estate = 1 if operatorType == "Estate"
replace estate = 0 if operatorType != "Estate"
gen joint = .
label variable joint "operator is a joint venture"
note joint: "Original Source: Texas Railroad Commission Organization Report"
replace joint = 1 if operatorType == "Joint Venture"
replace joint = 0 if operatorType != "Joint Venture"
gen llc = .
label variable llc "operator is a limited liability company"
note llc: "Original Source: Texas Railroad Commission Organization Report"
replace llc = 1 if operatorType == "Limited Liability Company (LLC)"
replace llc = 0 if operatorType != "Limited Liability Company (LLC)"
gen lmtpart = .
label variable lmtpart "operator is a limited partnership"
note lmtpart: "Original Source: Texas Railroad Commission Organization Report"
replace lmtpart = 1 if operatorType == "LimitedPartnership"
replace lmtpart = 0 if operatorType != "LimitedPartnership"
gen other = .
label variable other "operator is some other form of organization"
note other: "Original Source: Texas Railroad Commission Organization Report"
replace other = 1 if operatorType == "Other"
replace other = 0 if operatorType != "Other"
gen partnership = .
label variable partnership "operator is a partnership"
note partnership: "Original Source: Texas Railroad Commission Organization Report"
replace partnership = 1 if operatorType == "Partnership"
replace partnership = 0 if operatorType != "Partnership"
gen sole = .
label variable sole "operator is a sole proprietorship"
note sole: "Original Source: Texas Railroad Commission Organization Report"
replace sole = 1 if operatorType == "Sole Proprietorship"
replace sole = 0 if operatorType != "Sole Proprietorship"
gen trust = .
label variable trust "operator is a trust"
note trust: "Original Source: Texas Railroad Commission Organization Report"
replace trust = 1 if operatorType == "Trust"
replace trust = 0 if operatorType != "Trust"
save gas, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean gas operator data											*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted 
import delimited 19-gas_20161230.csv
cd ..
cd working
keep if (lease_gas_prod_vol > 0 & lease_gas_prod_vol != .) | (lease_cond_prod_vol > 0 & lease_cond_prod_vol != .)
keep operator_no wellop lease_gas_prod_vol lease_cond_prod_vol lease_gas_dispcd04_vol
duplicates drop
collapse (sum) lease_gas_prod_vol lease_cond_prod_vol lease_gas_dispcd04_vol, by (operator_no)
rename lease_gas_prod_vol opGasProd
label variable opGasProd "total gas well gasproduced by well operator in Texas"
notes opGasProd: "Volume of gas well gas produced in Texas by the operator (in mcf)"
notes opGasProd: "Source: Texas Railroad Commission Production Data Query Dump"
rename lease_cond_prod_vol opCondProd
label variable opCondProd "total condensate produced by well operator in Texas"
notes opCondProd: "Volume of condensate produced in Texas by the operator (in barrels)"
notes opCondProd: "Source: Texas Railroad Commission Production Data Query Dump"
rename lease_gas_dispcd04_vol opGasVf
label variable opGasVf "total gas well gas vented or flared by well operator in Texas"
notes opGasVf: "Volume of gas well gas vented or flared in Texas by well operator (in mcf)"
notes opGasVf: "Source: Texas Railroad Commission Production Data Query Dump"
sort operator_no
save opGas, replace
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* match all gas data												*/
/********-*********-*********-*********-*********-*********-*********/
//
cd working 
use gasLeaseLvl
sort wellop
merge 1:1 wellop using gasPipe 
drop _merge
merge 1:1 wellop using gasDens 
drop _merge
merge 1:1 wellop using gas 
drop _merge
sort operator_no
merge m:1 operator_no using opGas
drop _merge
gen wellAge = 2012- completionYear
label variable wellAge "well age (as of 2012)"
notes wellAge: "age of the well as of 2012"
notes wellAge: "Source: Texas Railroad Commission Full Wellbore Query"
tostring operatorDateFirstFiled, replace format(%20.0f)
gen operatorFF = substr(operatorDateFirstFiled,1,4)
destring operatorFF, replace
gen operatorRRCage = 2012 - operatorFF
label variable operatorRRCage "operator age with rrc"
notes operatorRRCage: "years between 2012 and the year the organization filed with the RRC"
notes operatorRRCage: "Source: Texas Railraod Commission Organization Report"
drop operatorFF
sort wellop
keep if (condTot > 0 & condTot != .) | (gasTot > 0 & gasTot != .)
gen missingCom = .
replace missingCom = 1 if aland == .
replace missingCom = 0 if aland != .
label variable missingCom "no block groups identified within one mile of facility"
notes missingCom: "1- acs estimates for block groups within one mile of facility obtained, 0- not"
save 30-gasLease_20171104, replace
cd ..
cd posted
save 30-gasLease_20171104
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean oil block group data										*/
/********-*********-*********-*********-*********-*********-*********/
//
cd posted 
import delimited s29_oilBgLvl_20171102.csv
cd .. 
cd working 
rename bgnearoil bgNearOil
label variable bgNearOil "block group is near oil lease"
notes bgNearOil: "1- block group is within one mile of a producion oil lease, 0- not"


rename bgoillease bgOilLeases
label variable bgOilLeases "oil leases near block group"
notes bgOilLeases: "Count of the number of oil leases with wellbore surface locations within one mile of the block group"
label variable bgOilLeases "number of oil leases"
notes bgOilLeases: "Number of il leases within one mile of block group"
replace bgOilLeases = 0 if bgNearOil == 0
rename gasvf gasVf 
replace gasVf = 0 if bgNearOil == 0
label variable gasVf "gas well gas vented or flared"
notes gasVf: "Volume of gas well gas (in mcf)vented or flared at oil leases with wellbore surface locations within one mile of the block group"
rename csgdvf csgdVf 
replace csgdVf = 0 if bgNearOil == 0
label variable csgdVf "casinghead gas vented or flared"
notes csgdVf: "Volume of casinghead gas (in mcf) vented or flared at oil leases with wellbore surface locations within one mile of the block group"
rename oilprod oilProd
replace oilProd = 0 if bgNearOil == 0
label variable oilProd "oil produced"
notes oilProd: "Volume of oil (in barrels) produce at oil leases with wellbore surface locations within one mile of the block group"
rename gasprod gasProd 
replace gasProd = 0 if bgNearOil == 0
label variable gasProd "gas well gas produced"
notes gasProd: "Volume of gas well gas (in mcf) produced at oil lease with wellbore surface location within one mile of the block group"
rename condprod condProd
replace condProd = 0 if bgNearOil == 0
label variable condProd "condensate produced"
notes condProd: "Volume of condensate (in barrels) produced at oil leases with wellbore surface locations within one mile of the block group"
rename csgdprod csgdProd 
replace csgdProd = 0 if bgNearOil == 0
label variable csgdProd "casinghead produced"
notes csgdProd: "Volume of casinghead gas (in mcf) produced at oil leases with wellbore surface locations within one mile of the block group"
label variable wells "wells"
notes wells: "Number of wellbore surface locations on producing oil leases within one mile of the blcok group"
replace wells = 0 if bgNearOil == 0
rename waterwells waterWells
replace waterWells = 0 if bgNearOil == 0
label variable waterWells "fresh water wells"
notes waterWells: "Number of fresh water oil wells within one mile of the block group"
rename horizontalwells horizontal 
replace horizontal = 0 if bgNearOil == 0
label variable horizontal "horizontal wells"
notes horizontal: "Number of horizontal oil wells within one mile of the block group"
rename newwells newWells 
replace newWells = 0 if bgNearOil == 0
label variable newWells "new wells"
notes newWells: "Number of wellbores completed in 2012 within one mile of the block group"
label variable aland "land area"
note aland: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable emp_pop "population count employment table"
note emp_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_unemployed_sum emp_notEmployed
label variable emp_notEmployed "unemployed count"
note emp_notEmployed: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_unemployed_per perUnemp
label variable perUnemp "percent unemployed"
note perUnemp: "Percent of residents 16 and over that live in block groups whose centroid is within one mile of the well that are not employed"
note perUnemp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen popDens = age_pop / (aland * 0.0000003861022)
label variable popDens "people per square meter"
notes popDens: "people per square meter in block groups whose centroid is within one mile of well"
note popDens: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable age_pop "population count age table "
note age_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_old_sum age_65over
label variable age_65over "total individuals 65 or older in block group"
note age_65over: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_old_per perOld
label variable perOld "percent 65 and older"
note perOld: "Percent of residents that live in block groups whose centroid is within one mile of the well that are 65 or older"
note perOld: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable educ_pop "population count education table"
note educ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_nodiploma_sum educ_nodip
label variable educ_nodip "individuals 25 and older without a diploma"
note educ_nodip: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_nodiploma_per perUneduc
label variable perUneduc "percent without highschool diploma"
note perUneduc: "Percent of residents 25 and older that live in block groups whose centroid is within one mile of the well that do not have a higschool diploma"
note perUneduc: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_pop eth_pop
label variable eth_pop "population count ethnicity table"
note eth_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_white_sum eth_white
label variable eth_white "nonhispanic white count"
note eth_white: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_black_sum eth_black
label variable eth_black "nonhispanic black count"
note eth_black: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_hisp_sum eth_hisp 
label variable eth_hisp "hispanic count"
note eth_hisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_white_per perWhite
rename race_black_per perBlack
rename race_hisp_per perHisp
label variable perWhite "percent white"
label variable perBlack "percent black"
label variable perHisp "percent hispanic"
note perWhite: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic white"
note perBlack: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic black" 
note perHisp: "Percent of residents that live in block groups whose centroids are within one mile of the well that are hispanic"
note perWhite: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perBlack: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perHisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_pop lang_pop
label variable lang_pop "population count language table"
note lang_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_limenglish_sum lang_limenghh
label variable lang_limenghh "limited english speaking household count"
note lang_limenghh: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_limenglish_per perLimEng
label variable perLimEng "percent limited english speaking households"
note perLimEng: "percent of households that are within block groups whose centroids are within one mile of the well"
note perLimEng: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_less10k_sum oohu_less10k
label variable oohu_less10k "total households in block group that are valued less than 10k"
note oohu_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_10kto14999_sum oohu_10kto14999
label variable oohu_10kto14999 "total households in block group that are valued 10k-14999"
note oohu_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_15kto19999_sum oohu_15kto19999
label variable oohu_15kto19999 "total households in block group that are valued 15k-19999"
note oohu_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_20kto24999_sum oohu_20kto24999
label variable oohu_20kto24999 "total households in block group that are valued 20k-24999"
note oohu_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_25kto29999_sum oohu_25kto29999
label variable oohu_25kto29999 "total households in block group that are valued 25k-29999"
note oohu_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_30kto34999_sum oohu_30kto34999
label variable oohu_30kto34999 "total households in block group that are valued 30k-34999"
note oohu_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_35kto39999_sum oohu_35kto39999
label variable oohu_35kto39999 "total households in block group that are valued 35k-39999"
note oohu_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_40kto49999_sum oohu_40kto49999
label variable oohu_40kto49999 "total households in block group that are valued 40k-49999"
note oohu_40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_50kto59999_sum oohu_50kto59999
label variable oohu_50kto59999 "total households in block group that are valued 50k-59999"
note oohu_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_60kto69999_sum oohu_60kto69999
label variable oohu_60kto69999 "total households in block group that are valued 60k-69999"
note oohu_60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_70kto79999_sum oohu_70kto79999
label variable oohu_70kto79999 "total households in block group that are valued 70k-79999"
note oohu_70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_80kto89999_sum oohu_80kto89999
label variable oohu_80kto89999 "total households in block group that are valued 80k-89999"
note oohu_80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_90kto99999_sum oohu_90kto99999
label variable oohu_90kto99999 "total households in block group that are valued 90k-99999"
note oohu_90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_100kto124999_sum oohu_100kto124999
label variable oohu_100kto124999 "total households in block group that are valued 100k-124999"
note oohu_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_125kto149999_sum oohu_125kto149999
label variable oohu_125kto149999 "total households in block group that are valued 125k-149999"
note oohu_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_150kto174999_sum oohu_150kto174999
label variable oohu_150kto174999 "total households in block group that are valued 150k-174999"
note oohu_150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_175kto199999_sum oohu_175kto199999
label variable oohu_175kto199999 "total households in block group that are valued 175k-199999"
note oohu_175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_200kto249999_sum oohu_200kto249999
label variable oohu_200kto249999 "total households in block group that are valued 200k-249999"
note oohu_200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_250kto299999_sum oohu_250kto299999
label variable oohu_250kto299999 "total households in block group that are valued 250k-299999"
note oohu_250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_300kto399999_sum oohu_300kto399999
label variable oohu_300kto399999 "total households in block group that are valued 300k-399999"
note oohu_300kto399999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_400kto499999_sum oohu_400kto499999
label variable oohu_400kto499999 "total households in block group that are valued 400k-499999"
note oohu_400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_500kto749999_sum oohu_500kto749999
label variable oohu_500kto749999 "total households in block group that are valued 500k-749999"
note oohu_500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_750kto999999_sum oohu_750kto999999
label variable oohu_750kto999999 "total households in block group that are valued 750k-999999"
note oohu_750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_1mmore_sum oohu_1mmore
label variable oohu_1mmore "total households in block group that are valued more than 1 million"
note oohu_1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen oohu_pop = oohu_less10k + oohu_10kto14999 + oohu_15kto19999 + ///
	oohu_20kto24999 + oohu_25kto29999 + oohu_30kto34999 + oohu_35kto39999 + ///
	oohu_40kto49999 + oohu_50kto59999 + oohu_60kto69999 + oohu_70kto79999 + ///
	oohu_80kto89999 + oohu_90kto99999 + oohu_100kto124999 + oohu_150kto174999 + ///
	oohu_175kto199999 + oohu_200kto249999 + oohu_250kto299999 + oohu_300kto399999 + ///
	oohu_400kto499999 + oohu_500kto749999 + oohu_750kto999999 + oohu_1mmore
label variable oohu_pop "total households in block group"
note oohu_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
gen perOohuLess10k = 100 * oohu_less10k / oohu_pop
label variable perOohuLess10k "percent of owner occupied households valued less than 10K"
notes perOohuLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu10kto14999 = 100 * oohu_10kto14999 / oohu_pop
label variable perOohu10kto14999 "percent of owner occupied households valued 10k to 14999"
notes perOohu10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu15kto19999 = 100 * oohu_15kto19999 / oohu_pop
label variable perOohu15kto19999 "percent of owner occupied households valued 15k to 19999"
notes perOohu15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu20kto24999 = 100 * oohu_20kto24999 / oohu_pop
label variable perOohu20kto24999 "percent of owner occupied households valued 20k to 24999"
notes perOohu20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu25kto29999 = 100 * oohu_25kto29999 / oohu_pop
label variable perOohu25kto29999 "percent of owner occupied households valued 25k to 29999"
notes perOohu25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu30kto34999 = 100 * oohu_30kto34999 / oohu_pop
label variable perOohu30kto34999 "percent of owner occupied households valued 30k to 34999"
notes perOohu30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu35kto39999 = 100 * oohu_35kto39999 / oohu_pop
label variable perOohu35kto39999 "percent of owner occupied households valued 35k to 39999"
notes perOohu35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu40kto49999 = 100 * oohu_40kto49999 / oohu_pop
label variable perOohu40kto49999 "percent of owner occupied households valued 40k to 49999"
notes perOohu40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu50kto59999 = 100 * oohu_50kto59999 / oohu_pop
label variable perOohu50kto59999 "percent of owner occupied households valued 50k to 59999"
notes perOohu50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu60kto69999 = 100 * oohu_60kto69999 / oohu_pop
label variable perOohu60kto69999 "percent of owner occupied households valued 60k to 69999"
notes perOohu60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu70kto79999 = 100 * oohu_70kto79999 / oohu_pop
label variable perOohu70kto79999 "percent of owner occupied households valued 70k to 79999"
notes perOohu70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu80kto89999 = 100 * oohu_80kto89999 / oohu_pop
label variable perOohu80kto89999 "percent of owner occupied households valued 80k to 89999"
notes perOohu80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu90kto99999 = 100 * oohu_90kto99999 / oohu_pop
label variable perOohu90kto99999 "percent of owner occupied households valued 90k to 99999"
notes perOohu90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu100kto124999 = 100 * oohu_100kto124999 / oohu_pop
label variable perOohu100kto124999 "percent of owner occupied households valued 100k to 124999"
notes perOohu100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu125kto149999 = 100 * oohu_125kto149999 / oohu_pop
label variable perOohu125kto149999 "percent of owner occupied households valued 125k to 149999"
notes perOohu125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu150kto174999 = 100 * oohu_150kto174999 / oohu_pop
label variable perOohu150kto174999 "percent of owner occupied households valued 150k to 174999"
notes perOohu150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu175kto199999 = 100 * oohu_175kto199999 / oohu_pop
label variable perOohu175kto199999 "percent of owner occupied households valued 175k to 199999"
notes perOohu175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu200kto249999 = 100 * oohu_200kto249999 / oohu_pop
label variable perOohu200kto249999 "percent of owner occupied households valued 200k to 249999"
notes perOohu200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu250kto299999 = 100 * oohu_250kto299999 / oohu_pop
label variable perOohu250kto299999 "percent of owner occupied households valued 250k to 299999"
notes perOohu250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu300kto39999 = 100 * oohu_300kto39999 / oohu_pop
label variable perOohu300kto39999 "percent of owner occupied households valued 300k to 39999"
notes perOohu300kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu400kto499999 = 100 * oohu_400kto499999 / oohu_pop
label variable perOohu400kto499999 "percent of owner occupied households valued 400k to 499999"
notes perOohu400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu500kto749999 = 100 * oohu_500kto749999 / oohu_pop
label variable perOohu500kto749999 "percent of owner occupied households valued 500k to 7499999"
notes perOohu500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu750kto999999 = 100 * oohu_750kto999999 / oohu_pop
label variable perOohu750kto999999 "percent of owner occupied households valued 750k to 999999"
notes perOohu750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu1mmore = 100 * oohu_1mmore / oohu_pop
label variable perOohu1mmore "percent of owner occupied households valued over 1 million"
notes perOohu1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_median "median value"
notes oohu_median : "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen oohuMedian = .
label variable oohuMedian "median value of owner occupied households"
note oohuMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace oohuMedian = 1 if oohuMedian == . & perOohuLess10k >= 50
label define oohuMedian 1 "median value of owner occupied households is less than 10k"
replace oohuMedian = 2 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 >= 50
label define oohuMedian 2 "median value of owner occupied households is 10k to 14999", add
replace oohuMedian = 3 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 >= 50
label define oohuMedian 3 "median value of owner occupied households is 15k to 14999", add
replace oohuMedian = 4 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 >= 50
label define oohuMedian 4 "median value of owner occupied household is 20k to 24999", add
replace oohuMedian = 5 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 >= 50
label define oohuMedian 5 "median value of owner occupied household is 25 k to 29999", add
replace oohuMedian = 6 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 >= 50
label define oohuMedian 6 "median value of owner occupied household is 30k to 34999", add
replace oohuMedian = 7 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 >= 50
label define oohuMedian 7 "median value of owner occupied household is 35k to 39999", add
replace oohuMedian = 8 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 >= 50
label define oohuMedian 8 "median value of owner occupied household is 40k to 49999", add
replace oohuMedian = 9 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 >= 50
label define oohuMedian 9 "median value of owner occupied household is 50k to 59999", add
replace oohuMedian = 10 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 >= 50
label define oohuMedian 10 "median value of owner occupied household is 60 k to 69999", add
replace oohuMedian = 11 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 >= 50
label define oohuMedian 11 "median value of owner occupied household is 70 k to 79999", add
replace oohuMedian = 12 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 >= 50
label define oohuMedian 12 "median value of owner occupied household is 80k to 89999", add
replace oohuMedian = 13 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 >= 50
label define oohuMedian 13 "median value of owner occupied houseing is 90k to 99999", add
replace oohuMedian = 14 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 >= 50
label define oohuMedian 14 "median value of owner occupied houshold is 100k to 124999", add
replace oohuMedian = 15 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 >= 50
label define oohuMedian 15 "median value of owner occupied household is 125k to 149999", add
replace oohuMedian = 16 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 >= 50
label define oohuMedian 16 "median value of owner occupied household is 150k to 174999", add
replace oohuMedian = 17 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 >= 50
label define oohuMedian 17 "median value of owner occupied household is 175k to 199999", add
replace oohuMedian = 18 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 >= 50
label define oohuMedian 18 "median value of owner occupied household is 200k to 249999", add
replace oohuMedian = 19 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 >= 50
label define oohuMedian 19 "median value of owner occupied household is 250k to 299999", add
replace oohuMedian = 20 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 >= 50
label define oohuMedian 20 "median value of owner occupied household is 300k to 399999", add
replace oohuMedian = 21 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 >= 50
label define oohuMedian 21 "median value of owner occupied household is 400k to 499999", add
replace oohuMedian = 22 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 >= 50
label define oohuMedian 22 "median value of owner occupied household is 500k to 749999", add
replace oohuMedian = 23 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + perOohu750kto999999 >= 50
label define oohuMedian 23 "median value of owner occupied household is 750k to 999999", add
replace oohuMedian = 24 if oohuMedian == . & perOohuLess10k + ///
	perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + ///
	perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + ///
	perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + ///
	perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + ///
	perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + ///
	perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + ///
	perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + ///
	perOohu750kto999999 + perOohu1mmore >= 50
label define oohuMedian 24 "median value of owner occupied household is 1 million or more", add
rename inc_less10k_sum inc_less10k
label variable inc_less10k "total households in block group that make less than 10 k"
note inc_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_10kto14999_sum inc_10kto14999
label variable inc_10kto14999 "total households in block group that make 10k-14999"
note inc_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_15kto19999_sum inc_15kto19999
label variable inc_15kto19999 "total households in block group that make 15k-19999"
note inc_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename inc_20kto24999_sum inc_20kto24999
label variable inc_20kto24999 "total households in block group that make 20k-24999"
note inc_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename inc_25kto29999_sum inc_25kto29999
label variable inc_25kto29999 "total households in block group that make 25k-29999"
note inc_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_30kto34999_sum inc_30kto34999
label variable inc_30kto34999 "total households in block group that make 30k-34999"
note inc_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_35kto39999_sum inc_35kto39999
label variable inc_35kto39999 "total households in block group that make 35k-39999"
note inc_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_40kto44999_sum inc_40kto44999
label variable inc_40kto44999 "total households in block group that make 40k-44999"
note inc_40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_45kto49999_sum inc_45kto49999
label variable inc_45kto49999 "total households in block group that make 45k-49999"
note inc_45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_50kto59999_sum inc_50kto59999
label variable inc_50kto59999 "total households in block group that make 50k-59999"
note inc_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_60kto74999_sum inc_60kto74999
label variable inc_60kto74999 "total households in block group that make 60k-74999"
note inc_60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_75kto99999_sum inc_75kto99999
label variable inc_75kto99999 "total households in block group that make 75k-99999"
note inc_75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_100kto124999_sum inc_100kto124999
label variable inc_100kto124999 "total households in block group that make 100k-124999"
note inc_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename inc_125kto149999_sum inc_125kto149999
label variable inc_125kto149999 "total households in block group that make 125k-149999"
note inc_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_150kto199999_sum inc_150kto199999
label variable inc_150kto199999 "total households that make 150k-199999"
note inc_150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_more200k_sum inc_more200k
label variable inc_more200k "total households in block group that make more than 200k"
note inc_more200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_pop_sum totalhouseholds
label variable totalhouseholds "total households in block group"
note totalhouseholds: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
gen perIncLess10k = 100 * inc_less10k / totalhouseholds
label variable perIncLess10k "prcent of households whose income is less than 10k"
note perIncLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc10kto14999 = 100 * inc_10kto14999 / totalhouseholds
label variable perInc10kto14999 "percent of households whose income is 10k-14999"
note perInc10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc15kto19999 = 100 * inc_15kto19999 / totalhouseholds
label variable perInc15kto19999 "percent of households whose income is 15k-19999"
note perInc15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc20kto24999 = 100 * inc_20kto24999 / totalhouseholds
label variable perInc20kto24999 "percent of households whose income is 20k to 24999"
note perInc20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc25kto29999 = 100 * inc_25kto29999 / totalhouseholds
label variable perInc25kto29999 "percent o fhouseholds whose income is 25k to 29999"
note perInc25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc30kto34999 = 100 * inc_30kto34999 / totalhouseholds
label variable perInc30kto34999 "percent of households whose income is 30k to 34999"
note perInc30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc35kto39999 = 100 * inc_35kto39999 / totalhouseholds
label variable perInc35kto39999 "percent of households whose income is 35k to 39999"
note perInc35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc40kto44999  = 100 * inc_40kto44999 / totalhouseholds
label variable perInc40kto44999 "percent of households whose income is 40kto44999"
note perInc40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc45kto49999 = 100 * inc_45kto49999 / totalhouseholds
label variable perInc45kto49999 "percent of households whose income is 45kto 49999"
note perInc45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc50kto59999 = 100 * inc_50kto59999 / totalhouseholds
label variable perInc50kto59999 "percent of households whose income is 50k to 59999"
note perInc50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc60kto74999 = 100 * inc_60kto74999 / totalhouseholds
label variable perInc60kto74999 "percent of households whose income is 60k to 74999"
note perInc60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc75kto99999 = 100 * inc_75kto99999 / totalhouseholds
label variable perInc75kto99999 "percent of households whose income is 75k to 99999"
note perInc75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc100kto124999 = 100 * inc_100kto124999 / totalhouseholds
label variable perInc100kto124999 "percent of households whose income is 100 k to 124999"
note perInc100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc125kto149999 = 100 * inc_125kto149999 / totalhouseholds
label variable perInc125kto149999 "percent of households whose income is 125k to 149999"
note perInc125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc150kto199999 = 100 * inc_150kto199999 / totalhouseholds
label variable perInc150kto199999 "percent of households whose incoem is 150k to 199999"
note perInc150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perIncMore200k = 100 * inc_more200k / totalhouseholds 
label variable perIncMore200k "percent of households whose income is more than 200k"
note perIncMore200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_median "median income"
gen incMedian = .
label variable incMedian "median household income"
note incMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace incMedian = 1 if incMedian == . & perIncLess10k >= 50
label define incMedian 1 "median household income is less than 10k"
replace incMedian = 2 if incMedian == . & perIncLess10k + perInc10kto14999 >= 50
label define incMedian 2 "median household income is 10k to 14999", add
replace incMedian = 3 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 >= 50
label define incMedian 3 "median household income is 15k to 19999", add
replace incMedian = 4 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 >= 50
label define incMedian 4 "median household income is 20k to 24999", add
replace incMedian = 5 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 >= 50
label define incMedian 5 "median household income is 25k to 29999", add
replace incMedian = 6 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 >= 50
label define incMedian 6 "median household income is 30k to 34999", add
replace incMedian= 7 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 >= 50
label define incMedian 7 "median household income is 35k to 39999", add
replace incMedian = 8 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 >= 50
label define incMedian 8 "median household income is 40k to 44999", add
replace incMedian = 9 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 >= 50
label define incMedian 9 "median household income is 45k to 49999", add
replace incMedian = 10 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 >= 50
label define incMedian 10 "median household income is 50k to 59999", add
replace incMedian = 11 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 >= 50
label define incMedian 11 "median household income is 60k to 74999", add
replace incMedian = 12 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 >= 50
label define incMedian 12 "median household income is 75k to 99999", add
replace incMedian = 13 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 >= 50
label define incMedian 13 "median household income is 100k to 124999", add
replace incMedian = 14 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 >= 50
label define incMedian 14 "median household income is 125k to 149999", add
replace incMedian = 15 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 >= 50
label define incMedian 15 "median household income is 150k to 199999", add
replace incMedian = 16 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 + perIncMore200k >= 50
label define incMedian 16 "median household income is more than 200k", add
rename totalhouseholds inc_pop
label variable occ_pop "population count occupation table"
note occ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename occ_ce_sum occ_ftcm
label variable occ_ftcm "full time construction and mining employment count"
note occ_ftcm: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename occ_ce_per perOccConsMi
label variable perOccConsMi "percent employed in contruction or mining industries"
note perOccConsMi: "percent of people 16 and older that live in block groups whose centroid is within one mile of the well surface location that are employed full time in the construction or mining industries"
note perOccConsMi: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable pov_pop "population count poverty table"
note pov_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_belowpovertyline_sum pov_bel
label variable pov_bel "households at or below the poverty line"
note pov_bel: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_belowpovertyline_per perPov
label variable perPov "percent under poverty line"
note perPov: "percent of households that are in block groups whose centroid is within one mile of the well surface location that are living below the poverty line"
label variable geoid "geoid"
note geoid: "block group number"
drop gasVf gasProd condProd 
rename wells wells_oil
rename waterWells waterWells_oil
rename horizontal horizontal_oil
rename newWells newWells_oil
save 30-oilBg_20171104, replace
cd ..
cd posted
save 30-oilBg_20171104, replace
cd ..
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* clean gas block group data										*/
/********-*********-*********-*********-*********-*********-*********/
//


cd posted 
import delimited s29_gasBgLvl_20171102.csv
cd .. 
cd working 
rename bgneargas bgNearGas
label variable bgNearGas "block group is near gas lease"
notes bgNearGas: "1- block group is within one mile of a producing gas lease, 0- not"
rename bggaswell bgGasLeases
label variable bgGasLeases "gas leases near block group"
notes bgGasLeases: "Count of the number of gas leases with wellbore surface locations within one mile of the block group"
replace bgGasLeases = 0 if bgNearGas == 0
rename gasvf gasVf 
replace gasVf = 0 if bgNearGas == 0
label variable gasVf "gas well gas vented or flared"
notes gasVf: "Volume of gas well gas (in mcf)vented or flared at gas leases with wellbore surface locations within one mile of the block group"
rename csgdvf csgdVf 
replace csgdVf = 0 if bgNearGas == 0
label variable csgdVf "casinghead gas vented or flared"
notes csgdVf: "Volume of casinghead gas (in mcf) vented or flared at gas leases with wellbore surface locations within one mile of the block group"
rename oilprod oilProd
replace oilProd = 0 if bgNearGas == 0
label variable oilProd "gas produced"
notes oilProd: "Volume of gas (in barrels) produce at gas leases with wellbore surface locations within one mile of the block group"
rename gasprod gasProd 
replace gasProd = 0 if bgNearGas == 0
label variable gasProd "gas well gas produced"
notes gasProd: "Volume of gas well gas (in mcf) produced at gas lease with wellbore surface location within one mile of the block group"
rename condprod condProd
replace condProd = 0 if bgNearGas == 0
label variable condProd "condensate produced"
notes condProd: "Volume of condensate (in barrels) produced at gas leases with wellbore surface locations within one mile of the block group"
rename csgdprod csgdProd 
replace csgdProd = 0 if bgNearGas == 0
label variable csgdProd "casinghead produced"
notes csgdProd: "Volume of casinghead gas (in mcf) produced at gas leases with wellbore surface locations within one mile of the block group"
label variable wells "wells"
notes wells: "Number of wellbore surface locations on producing gas leases within one mile of the blcok group"
replace wells = 0 if bgNearGas == 0
rename waterwells waterWells
replace waterWells = 0 if bgNearGas == 0
label variable waterWells "fresh water wells"
notes waterWells: "Number of fresh water gas wells within one mile of the block group"
rename horizontalwells horizontal 
replace horizontal = 0 if bgNearGas == 0
label variable horizontal "horizontal wells"
notes horizontal: "Number of horizontal gas wells within one mile of the block group"
rename newwells newWells 
replace newWells = 0 if bgNearGas == 0
label variable newWells "new wells"
notes newWells: "Number of wellbores completed in 2012 within one mile of the block group"
label variable aland "land area"
note aland: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable emp_pop "population count employment table"
note emp_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_unemployed_sum emp_notEmployed
label variable emp_notEmployed "unemployed count"
note emp_notEmployed: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename emp_unemployed_per perUnemp
label variable perUnemp "percent unemployed"
note perUnemp: "Percent of residents 16 and over that live in block groups whose centroid is within one mile of the well that are not employed"
note perUnemp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen popDens = age_pop / (aland * 0.0000003861022)
label variable popDens "people per square meter"
notes popDens: "people per square meter in block groups whose centroid is within one mile of well"
note popDens: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable age_pop "population count age table "
note age_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_old_sum age_65over
label variable age_65over "total individuals 65 or older in block group"
note age_65over: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename age_old_per perOld
label variable perOld "percent 65 and older"
note perOld: "Percent of residents that live in block groups whose centroid is within one mile of the well that are 65 or older"
note perOld: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable educ_pop "population count education table"
note educ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_nodiploma_sum educ_nodip
label variable educ_nodip "individuals 25 and older without a diploma"
note educ_nodip: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename educ_nodiploma_per perUneduc
label variable perUneduc "percent without highschool diploma"
note perUneduc: "Percent of residents 25 and older that live in block groups whose centroid is within one mile of the well that do not have a higschool diploma"
note perUneduc: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_pop eth_pop
label variable eth_pop "population count ethnicity table"
note eth_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_white_sum eth_white
label variable eth_white "nonhispanic white count"
note eth_white: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_black_sum eth_black
label variable eth_black "nonhispanic black count"
note eth_black: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_hisp_sum eth_hisp 
label variable eth_hisp "hispanic count"
note eth_hisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename race_white_per perWhite
rename race_black_per perBlack
rename race_hisp_per perHisp
label variable perWhite "percent white"
label variable perBlack "percent black"
label variable perHisp "percent hispanic"
note perWhite: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic white"
note perBlack: "percent of residents that live in block groups whose centroids are within one mile of the well that are non-Hispanic black" 
note perHisp: "Percent of residents that live in block groups whose centroids are within one mile of the well that are hispanic"
note perWhite: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perBlack: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
note perHisp: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_pop lang_pop
label variable lang_pop "population count language table"
note lang_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_limenglish_sum lang_limenghh
label variable lang_limenghh "limited english speaking household count"
note lang_limenghh: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename fluency_limenglish_per perLimEng
label variable perLimEng "percent limited english speaking households"
note perLimEng: "percent of households that are within block groups whose centroids are within one mile of the well"
note perLimEng: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_less10k_sum oohu_less10k
label variable oohu_less10k "total households in block group that are valued less than 10k"
note oohu_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_10kto14999_sum oohu_10kto14999
label variable oohu_10kto14999 "total households in block group that are valued 10k-14999"
note oohu_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_15kto19999_sum oohu_15kto19999
label variable oohu_15kto19999 "total households in block group that are valued 15k-19999"
note oohu_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_20kto24999_sum oohu_20kto24999
label variable oohu_20kto24999 "total households in block group that are valued 20k-24999"
note oohu_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_25kto29999_sum oohu_25kto29999
label variable oohu_25kto29999 "total households in block group that are valued 25k-29999"
note oohu_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_30kto34999_sum oohu_30kto34999
label variable oohu_30kto34999 "total households in block group that are valued 30k-34999"
note oohu_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_35kto39999_sum oohu_35kto39999
label variable oohu_35kto39999 "total households in block group that are valued 35k-39999"
note oohu_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_40kto49999_sum oohu_40kto49999
label variable oohu_40kto49999 "total households in block group that are valued 40k-49999"
note oohu_40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_50kto59999_sum oohu_50kto59999
label variable oohu_50kto59999 "total households in block group that are valued 50k-59999"
note oohu_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_60kto69999_sum oohu_60kto69999
label variable oohu_60kto69999 "total households in block group that are valued 60k-69999"
note oohu_60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_70kto79999_sum oohu_70kto79999
label variable oohu_70kto79999 "total households in block group that are valued 70k-79999"
note oohu_70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_80kto89999_sum oohu_80kto89999
label variable oohu_80kto89999 "total households in block group that are valued 80k-89999"
note oohu_80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_90kto99999_sum oohu_90kto99999
label variable oohu_90kto99999 "total households in block group that are valued 90k-99999"
note oohu_90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_100kto124999_sum oohu_100kto124999
label variable oohu_100kto124999 "total households in block group that are valued 100k-124999"
note oohu_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_125kto149999_sum oohu_125kto149999
label variable oohu_125kto149999 "total households in block group that are valued 125k-149999"
note oohu_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_150kto174999_sum oohu_150kto174999
label variable oohu_150kto174999 "total households in block group that are valued 150k-174999"
note oohu_150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_175kto199999_sum oohu_175kto199999
label variable oohu_175kto199999 "total households in block group that are valued 175k-199999"
note oohu_175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_200kto249999_sum oohu_200kto249999
label variable oohu_200kto249999 "total households in block group that are valued 200k-249999"
note oohu_200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_250kto299999_sum oohu_250kto299999
label variable oohu_250kto299999 "total households in block group that are valued 250k-299999"
note oohu_250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_300kto399999_sum oohu_300kto399999
label variable oohu_300kto399999 "total households in block group that are valued 300k-399999"
note oohu_300kto399999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_400kto499999_sum oohu_400kto499999
label variable oohu_400kto499999 "total households in block group that are valued 400k-499999"
note oohu_400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_500kto749999_sum oohu_500kto749999
label variable oohu_500kto749999 "total households in block group that are valued 500k-749999"
note oohu_500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename oohu_750kto999999_sum oohu_750kto999999
label variable oohu_750kto999999 "total households in block group that are valued 750k-999999"
note oohu_750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename oohu_1mmore_sum oohu_1mmore
label variable oohu_1mmore "total households in block group that are valued more than 1 million"
note oohu_1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen oohu_pop = oohu_less10k + oohu_10kto14999 + oohu_15kto19999 + ///
	oohu_20kto24999 + oohu_25kto29999 + oohu_30kto34999 + oohu_35kto39999 + ///
	oohu_40kto49999 + oohu_50kto59999 + oohu_60kto69999 + oohu_70kto79999 + ///
	oohu_80kto89999 + oohu_90kto99999 + oohu_100kto124999 + oohu_150kto174999 + ///
	oohu_175kto199999 + oohu_200kto249999 + oohu_250kto299999 + oohu_300kto399999 + ///
	oohu_400kto499999 + oohu_500kto749999 + oohu_750kto999999 + oohu_1mmore
label variable oohu_pop "total households in block group"
note oohu_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
gen perOohuLess10k = 100 * oohu_less10k / oohu_pop
label variable perOohuLess10k "percent of owner occupied households valued less than 10K"
notes perOohuLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu10kto14999 = 100 * oohu_10kto14999 / oohu_pop
label variable perOohu10kto14999 "percent of owner occupied households valued 10k to 14999"
notes perOohu10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu15kto19999 = 100 * oohu_15kto19999 / oohu_pop
label variable perOohu15kto19999 "percent of owner occupied households valued 15k to 19999"
notes perOohu15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu20kto24999 = 100 * oohu_20kto24999 / oohu_pop
label variable perOohu20kto24999 "percent of owner occupied households valued 20k to 24999"
notes perOohu20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu25kto29999 = 100 * oohu_25kto29999 / oohu_pop
label variable perOohu25kto29999 "percent of owner occupied households valued 25k to 29999"
notes perOohu25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu30kto34999 = 100 * oohu_30kto34999 / oohu_pop
label variable perOohu30kto34999 "percent of owner occupied households valued 30k to 34999"
notes perOohu30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu35kto39999 = 100 * oohu_35kto39999 / oohu_pop
label variable perOohu35kto39999 "percent of owner occupied households valued 35k to 39999"
notes perOohu35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu40kto49999 = 100 * oohu_40kto49999 / oohu_pop
label variable perOohu40kto49999 "percent of owner occupied households valued 40k to 49999"
notes perOohu40kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu50kto59999 = 100 * oohu_50kto59999 / oohu_pop
label variable perOohu50kto59999 "percent of owner occupied households valued 50k to 59999"
notes perOohu50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu60kto69999 = 100 * oohu_60kto69999 / oohu_pop
label variable perOohu60kto69999 "percent of owner occupied households valued 60k to 69999"
notes perOohu60kto69999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu70kto79999 = 100 * oohu_70kto79999 / oohu_pop
label variable perOohu70kto79999 "percent of owner occupied households valued 70k to 79999"
notes perOohu70kto79999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu80kto89999 = 100 * oohu_80kto89999 / oohu_pop
label variable perOohu80kto89999 "percent of owner occupied households valued 80k to 89999"
notes perOohu80kto89999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu90kto99999 = 100 * oohu_90kto99999 / oohu_pop
label variable perOohu90kto99999 "percent of owner occupied households valued 90k to 99999"
notes perOohu90kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu100kto124999 = 100 * oohu_100kto124999 / oohu_pop
label variable perOohu100kto124999 "percent of owner occupied households valued 100k to 124999"
notes perOohu100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu125kto149999 = 100 * oohu_125kto149999 / oohu_pop
label variable perOohu125kto149999 "percent of owner occupied households valued 125k to 149999"
notes perOohu125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu150kto174999 = 100 * oohu_150kto174999 / oohu_pop
label variable perOohu150kto174999 "percent of owner occupied households valued 150k to 174999"
notes perOohu150kto174999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu175kto199999 = 100 * oohu_175kto199999 / oohu_pop
label variable perOohu175kto199999 "percent of owner occupied households valued 175k to 199999"
notes perOohu175kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu200kto249999 = 100 * oohu_200kto249999 / oohu_pop
label variable perOohu200kto249999 "percent of owner occupied households valued 200k to 249999"
notes perOohu200kto249999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu250kto299999 = 100 * oohu_250kto299999 / oohu_pop
label variable perOohu250kto299999 "percent of owner occupied households valued 250k to 299999"
notes perOohu250kto299999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu300kto39999 = 100 * oohu_300kto39999 / oohu_pop
label variable perOohu300kto39999 "percent of owner occupied households valued 300k to 39999"
notes perOohu300kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu400kto499999 = 100 * oohu_400kto499999 / oohu_pop
label variable perOohu400kto499999 "percent of owner occupied households valued 400k to 499999"
notes perOohu400kto499999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu500kto749999 = 100 * oohu_500kto749999 / oohu_pop
label variable perOohu500kto749999 "percent of owner occupied households valued 500k to 7499999"
notes perOohu500kto749999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu750kto999999 = 100 * oohu_750kto999999 / oohu_pop
label variable perOohu750kto999999 "percent of owner occupied households valued 750k to 999999"
notes perOohu750kto999999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perOohu1mmore = 100 * oohu_1mmore / oohu_pop
label variable perOohu1mmore "percent of owner occupied households valued over 1 million"
notes perOohu1mmore: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable oohu_median "median value"
notes oohu_median : "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen oohuMedian = .
label variable oohuMedian "median value of owner occupied households"
note oohuMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace oohuMedian = 1 if oohuMedian == . & perOohuLess10k >= 50
label define oohuMedian 1 "median value of owner occupied households is less than 10k"
replace oohuMedian = 2 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 >= 50
label define oohuMedian 2 "median value of owner occupied households is 10k to 14999", add
replace oohuMedian = 3 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 >= 50
label define oohuMedian 3 "median value of owner occupied households is 15k to 14999", add
replace oohuMedian = 4 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 >= 50
label define oohuMedian 4 "median value of owner occupied household is 20k to 24999", add
replace oohuMedian = 5 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 >= 50
label define oohuMedian 5 "median value of owner occupied household is 25 k to 29999", add
replace oohuMedian = 6 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 >= 50
label define oohuMedian 6 "median value of owner occupied household is 30k to 34999", add
replace oohuMedian = 7 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 >= 50
label define oohuMedian 7 "median value of owner occupied household is 35k to 39999", add
replace oohuMedian = 8 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 >= 50
label define oohuMedian 8 "median value of owner occupied household is 40k to 49999", add
replace oohuMedian = 9 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 >= 50
label define oohuMedian 9 "median value of owner occupied household is 50k to 59999", add
replace oohuMedian = 10 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 >= 50
label define oohuMedian 10 "median value of owner occupied household is 60 k to 69999", add
replace oohuMedian = 11 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 >= 50
label define oohuMedian 11 "median value of owner occupied household is 70 k to 79999", add
replace oohuMedian = 12 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 >= 50
label define oohuMedian 12 "median value of owner occupied household is 80k to 89999", add
replace oohuMedian = 13 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 >= 50
label define oohuMedian 13 "median value of owner occupied houseing is 90k to 99999", add
replace oohuMedian = 14 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 >= 50
label define oohuMedian 14 "median value of owner occupied houshold is 100k to 124999", add
replace oohuMedian = 15 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 >= 50
label define oohuMedian 15 "median value of owner occupied household is 125k to 149999", add
replace oohuMedian = 16 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 >= 50
label define oohuMedian 16 "median value of owner occupied household is 150k to 174999", add
replace oohuMedian = 17 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 >= 50
label define oohuMedian 17 "median value of owner occupied household is 175k to 199999", add
replace oohuMedian = 18 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 >= 50
label define oohuMedian 18 "median value of owner occupied household is 200k to 249999", add
replace oohuMedian = 19 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 >= 50
label define oohuMedian 19 "median value of owner occupied household is 250k to 299999", add
replace oohuMedian = 20 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 >= 50
label define oohuMedian 20 "median value of owner occupied household is 300k to 399999", add
replace oohuMedian = 21 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 >= 50
label define oohuMedian 21 "median value of owner occupied household is 400k to 499999", add
replace oohuMedian = 22 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 >= 50
label define oohuMedian 22 "median value of owner occupied household is 500k to 749999", add
replace oohuMedian = 23 if oohuMedian == . & perOohuLess10k + perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + perOohu750kto999999 >= 50
label define oohuMedian 23 "median value of owner occupied household is 750k to 999999", add
replace oohuMedian = 24 if oohuMedian == . & perOohuLess10k + ///
	perOohu10kto14999 + perOohu15kto19999 + perOohu20kto24999 + ///
	perOohu25kto29999 + perOohu30kto34999 + perOohu35kto39999 + ///
	perOohu40kto49999 + perOohu50kto59999 + perOohu60kto69999 + ///
	perOohu70kto79999 + perOohu80kto89999 + perOohu90kto99999 + ///
	perOohu100kto124999 + perOohu125kto149999 + perOohu150kto174999 + ///
	perOohu175kto199999 + perOohu200kto249999 + perOohu250kto299999 + ///
	perOohu300kto39999 + perOohu400kto499999 + perOohu500kto749999 + ///
	perOohu750kto999999 + perOohu1mmore >= 50
label define oohuMedian 24 "median value of owner occupied household is 1 million or more", add
rename inc_less10k_sum inc_less10k
label variable inc_less10k "total households in block group that make less than 10 k"
note inc_less10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_10kto14999_sum inc_10kto14999
label variable inc_10kto14999 "total households in block group that make 10k-14999"
note inc_10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_15kto19999_sum inc_15kto19999
label variable inc_15kto19999 "total households in block group that make 15k-19999"
note inc_15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename inc_20kto24999_sum inc_20kto24999
label variable inc_20kto24999 "total households in block group that make 20k-24999"
note inc_20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename inc_25kto29999_sum inc_25kto29999
label variable inc_25kto29999 "total households in block group that make 25k-29999"
note inc_25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_30kto34999_sum inc_30kto34999
label variable inc_30kto34999 "total households in block group that make 30k-34999"
note inc_30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_35kto39999_sum inc_35kto39999
label variable inc_35kto39999 "total households in block group that make 35k-39999"
note inc_35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_40kto44999_sum inc_40kto44999
label variable inc_40kto44999 "total households in block group that make 40k-44999"
note inc_40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_45kto49999_sum inc_45kto49999
label variable inc_45kto49999 "total households in block group that make 45k-49999"
note inc_45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_50kto59999_sum inc_50kto59999
label variable inc_50kto59999 "total households in block group that make 50k-59999"
note inc_50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_60kto74999_sum inc_60kto74999
label variable inc_60kto74999 "total households in block group that make 60k-74999"
note inc_60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_75kto99999_sum inc_75kto99999
label variable inc_75kto99999 "total households in block group that make 75k-99999"
note inc_75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_100kto124999_sum inc_100kto124999
label variable inc_100kto124999 "total households in block group that make 100k-124999"
note inc_100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format" 
rename inc_125kto149999_sum inc_125kto149999
label variable inc_125kto149999 "total households in block group that make 125k-149999"
note inc_125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_150kto199999_sum inc_150kto199999
label variable inc_150kto199999 "total households that make 150k-199999"
note inc_150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_more200k_sum inc_more200k
label variable inc_more200k "total households in block group that make more than 200k"
note inc_more200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename inc_pop_sum totalhouseholds
label variable totalhouseholds "total households in block group"
note totalhouseholds: "Original Source: American Community Survey, 2010-2014, 5 Year Sumary, Geodatabase Format"
gen perIncLess10k = 100 * inc_less10k / totalhouseholds
label variable perIncLess10k "prcent of households whose income is less than 10k"
note perIncLess10k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc10kto14999 = 100 * inc_10kto14999 / totalhouseholds
label variable perInc10kto14999 "percent of households whose income is 10k-14999"
note perInc10kto14999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc15kto19999 = 100 * inc_15kto19999 / totalhouseholds
label variable perInc15kto19999 "percent of households whose income is 15k-19999"
note perInc15kto19999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc20kto24999 = 100 * inc_20kto24999 / totalhouseholds
label variable perInc20kto24999 "percent of households whose income is 20k to 24999"
note perInc20kto24999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc25kto29999 = 100 * inc_25kto29999 / totalhouseholds
label variable perInc25kto29999 "percent o fhouseholds whose income is 25k to 29999"
note perInc25kto29999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc30kto34999 = 100 * inc_30kto34999 / totalhouseholds
label variable perInc30kto34999 "percent of households whose income is 30k to 34999"
note perInc30kto34999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc35kto39999 = 100 * inc_35kto39999 / totalhouseholds
label variable perInc35kto39999 "percent of households whose income is 35k to 39999"
note perInc35kto39999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc40kto44999  = 100 * inc_40kto44999 / totalhouseholds
label variable perInc40kto44999 "percent of households whose income is 40kto44999"
note perInc40kto44999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc45kto49999 = 100 * inc_45kto49999 / totalhouseholds
label variable perInc45kto49999 "percent of households whose income is 45kto 49999"
note perInc45kto49999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc50kto59999 = 100 * inc_50kto59999 / totalhouseholds
label variable perInc50kto59999 "percent of households whose income is 50k to 59999"
note perInc50kto59999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc60kto74999 = 100 * inc_60kto74999 / totalhouseholds
label variable perInc60kto74999 "percent of households whose income is 60k to 74999"
note perInc60kto74999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc75kto99999 = 100 * inc_75kto99999 / totalhouseholds
label variable perInc75kto99999 "percent of households whose income is 75k to 99999"
note perInc75kto99999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc100kto124999 = 100 * inc_100kto124999 / totalhouseholds
label variable perInc100kto124999 "percent of households whose income is 100 k to 124999"
note perInc100kto124999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc125kto149999 = 100 * inc_125kto149999 / totalhouseholds
label variable perInc125kto149999 "percent of households whose income is 125k to 149999"
note perInc125kto149999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perInc150kto199999 = 100 * inc_150kto199999 / totalhouseholds
label variable perInc150kto199999 "percent of households whose incoem is 150k to 199999"
note perInc150kto199999: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
gen perIncMore200k = 100 * inc_more200k / totalhouseholds 
label variable perIncMore200k "percent of households whose income is more than 200k"
note perIncMore200k: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable inc_median "median income"
gen incMedian = .
label variable incMedian "median household income"
note incMedian: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
replace incMedian = 1 if incMedian == . & perIncLess10k >= 50
label define incMedian 1 "median household income is less than 10k"
replace incMedian = 2 if incMedian == . & perIncLess10k + perInc10kto14999 >= 50
label define incMedian 2 "median household income is 10k to 14999", add
replace incMedian = 3 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 >= 50
label define incMedian 3 "median household income is 15k to 19999", add
replace incMedian = 4 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 >= 50
label define incMedian 4 "median household income is 20k to 24999", add
replace incMedian = 5 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 >= 50
label define incMedian 5 "median household income is 25k to 29999", add
replace incMedian = 6 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 >= 50
label define incMedian 6 "median household income is 30k to 34999", add
replace incMedian= 7 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 >= 50
label define incMedian 7 "median household income is 35k to 39999", add
replace incMedian = 8 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 >= 50
label define incMedian 8 "median household income is 40k to 44999", add
replace incMedian = 9 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 >= 50
label define incMedian 9 "median household income is 45k to 49999", add
replace incMedian = 10 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 >= 50
label define incMedian 10 "median household income is 50k to 59999", add
replace incMedian = 11 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 >= 50
label define incMedian 11 "median household income is 60k to 74999", add
replace incMedian = 12 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 >= 50
label define incMedian 12 "median household income is 75k to 99999", add
replace incMedian = 13 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 >= 50
label define incMedian 13 "median household income is 100k to 124999", add
replace incMedian = 14 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 >= 50
label define incMedian 14 "median household income is 125k to 149999", add
replace incMedian = 15 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 >= 50
label define incMedian 15 "median household income is 150k to 199999", add
replace incMedian = 16 if incMedian == . & perIncLess10k + perInc10kto14999 + perInc15kto19999 + perInc20kto24999 + perInc25kto29999 + perInc30kto34999 + perInc35kto39999 + perInc40kto44999 + perInc45kto49999 + perInc50kto59999 + perInc60kto74999 + perInc75kto99999 + perInc100kto124999 + perInc125kto149999 + perInc150kto199999 + perIncMore200k >= 50
label define incMedian 16 "median household income is more than 200k", add
rename totalhouseholds inc_pop
label variable occ_pop "population count occupation table"
note occ_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename occ_ce_sum occ_ftcm
label variable occ_ftcm "full time construction and mining employment count"
note occ_ftcm: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename occ_ce_per perOccConsMi
label variable perOccConsMi "percent employed in contruction or mining industries"
note perOccConsMi: "percent of people 16 and older that live in block groups whose centroid is within one mile of the well surface location that are employed full time in the construction or mining industries"
note perOccConsMi: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
label variable pov_pop "population count poverty table"
note pov_pop: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_belowpovertyline_sum pov_bel
label variable pov_bel "households at or below the poverty line"
note pov_bel: "Original Source: American Community Survey, 2010-2014, 5 Year Summary, Geodatabase Format"
rename pov_belowpovertyline_per perPov
label variable perPov "percent under poverty line"
note perPov: "percent of households that are in block groups whose centroid is within one mile of the well surface location that are living below the poverty line"
label variable geoid "geoid"
note geoid: "block group number"
drop csgdVf oilProd csgdProd 
rename wells wells_gas
rename waterWells waterWells_gas
rename horizontal horizontal_gas
rename newWells newWells_gas
save 30-gasBg_20171104, replace
cd ..
cd posted
save 30-gasBg_20171104, replace
//
//