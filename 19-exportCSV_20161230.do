cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 19-exportCSV_20161230, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		19-exportCSV_20161230.do
// task:		export csv of lat/long NAD83 oil data
//				export csv of lat/long nad27 oil data
// 				export csv of oil data w/o lat/long data
//				export csv of lat/long NAD83 gas data
//				export csv of lat/long nad27 gas data
//				export csv of gas data w/o lat/long data
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 12/28/2016
//
//
/********-*********-*********-*********-*********-*********-*********/
/* Set Settings and Working Directory								*/
/********-*********-*********-*********-*********-*********-*********/
//
clear all
version 13
set more off
cd "C:/Users/TXCRDC/Documents/Research/eocpc"
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of lat/long NAD83 oil data							*/
/********-*********-*********-*********-*********-*********-*********/
//
cd Posted
use 18-oilPOVLGPV_20161220
cd ..
cd Working
drop permitTotal
replace totalVFpermits = 0 if totalVFpermits == .
gen oilUID = _n
label variable oilUID "gas GIS table uid"
notes oilUID: "Gas GIS table uid to match gas well data in the GIS"
notes oilUID: "Variable created in 19-exportCSV_20161230.do"
save oil
keep if prLocMatch == 1 | prAPImatch == 1
keep latitudedatum83 longitudedatum83 oilUID
label data "Location info for producing Oil Wells in 2012 with WGS 83 data"
save 19-oilNAD83latlong_20161230
export delimited using 19-oilNAD83latlong_20161230
cd ..
cd Posted
save 19-oilNAD83latlong_20161230
export delimited using 19-oilNAD83latlong_20161230
cd ..
cd Working
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of lat/long nad27 oil data							*/
/********-*********-*********-*********-*********-*********-*********/
//
use oil 
keep if noLocMatch == 0 & prLocMatch == 0 & prAPImatch == 0
keep latitude longitude oilUID
label data "Location info for producing Oil Wells in 2012 without WGS 83 data but with NAD 27"
save 19-oilNAD27latlong_20161230
export delimited using 19-oilNAD27latlong_20161230
cd ..
cd Posted
save 19-oilNAD27latlong_20161230
export delimited using 19-oilNAD27latlong_20161230
cd ..
cd Working
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of oil data w/o lat/long data							*/
/********-*********-*********-*********-*********-*********-*********/
//
use oil
keep if noGIS == 1
label data "producing Oil Wells in 2012 without WGS 83 or NAD 27 data"
save 19-oilNOlatlong_20161230
export delimited using 19-oilNOlatlong_20161230
cd ..
cd Posted
save 19-oilNOlatlong_20161230
export delimited using 19-oilNOlatlong_20161230
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of oil data											*/
/********-*********-*********-*********-*********-*********-*********/
cd Working
use oil
keep if noGIS != 1
label data "complete producing 2012 oil well data for wells with GIS data"
save 19-oil_20161230
export delimited using 19-oil_20161230
cd ..
cd Posted
save 19-oil_20161230
export delimited using 19-oil_20161230
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of lat/long NAD83 gas data							*/
/********-*********-*********-*********-*********-*********-*********/
//
cd Posted
use 18-gasPOVLGPV_20161220
cd ..
cd Working
drop permitTotal
replace totalVFpermits = 0 if totalVFpermits == .
gen gasUID = _n
label variable gasUID "gas GIS table uid"
notes gasUID: "Gas GIS table uid to match gas well data in the GIS"
notes gasUID: "Variable created in 19-exportCSV_20161230.do"
save gas
keep if prLocMatch == 1 | prAPImatch == 1
keep latitudedatum83 longitudedatum83 gasUID
label data "Location info for producing gas wells in 2012 with WGS 83 data"
save 19-gasNAD83latlong_20161230
export delimited using 19-gasNAD83latlong_20161230
cd ..
cd Posted
save 19-gasNAD83latlong_20161230
export delimited using 19-gasNAD83latlong_20161230
cd ..
cd Working
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of lat/long nad27 gas data							*/
/********-*********-*********-*********-*********-*********-*********/
//
use gas
keep if noLocMatch == 0 & prLocMatch == 0 & prAPImatch == 0
keep latitude longitude gasUID
label data "Location info for producing gas wells in 2012 without WGS 83 data but with NAD 27"
save 19-gasNAD27latlong_20161230
export delimited using 19-gasNAD27latlong_20161230
cd ..
cd Posted
save 19-gasNAD27latlong_20161230
export delimited using 19-gasNAD27latlong_20161230
cd ..
cd Working
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of gas data w/o lat/long data							*/
/********-*********-*********-*********-*********-*********-*********/
//
use gas
keep if noGIS == 1
label data "producing gas wells in 2012 without WGS 83 or NAD 27 data"
save 19-gasNOlatlong_20161230
export delimited using 19-gasNOlatlong_20161230
cd ..
cd Posted
save 19-gasNOlatlong_20161230
export delimited using 19-gasNOlatlong_20161230
cd ..
//
//
/********-*********-*********-*********-*********-*********-*********/
/* export csv of gas data											*/
/********-*********-*********-*********-*********-*********-*********/
cd Working
use gas
keep if noGIS != 1
label data "complete producing 2012 gas well data for wells with GIS data"
save 19-gas_20161230
export delimited using 19-gas_20161230
cd ..
cd Posted
save 19-gas_20161230
export delimited using 19-gas_20161230
cd ..
//
//