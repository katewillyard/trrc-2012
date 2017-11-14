cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 21-matchApi_20170115, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		21-matchApi_20170115.do
// task:		import Texas Railroad Commission Well GIS data using API
//				merge gas well data, show match, export as csv
//				merge oil well data, show match, export as csv
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 1/15/2017
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
/* merge gas well data, show match, and export as csv				*/
/********-*********-*********-*********-*********-*********-*********/
//
cd Posted
import delimited 20-allWellSurfLoc_20170113.csv
notes: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
cd ..
cd Working
label data "All surface well locations in NAD 83 format and corresponding api numbers from TXRRC GIS data
drop objectid surface_id symnum reliab long27 lat27 wellid
note long83: "Longitude coordinate in NAD 83 datum"
note long83: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
note lat83: "Latitude coordinate in NAD 83 datum"
note lat83: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
duplicates drop
sort api
quietly by api: gen dup = cond(_N==1,0,_n)
drop if dup !=0
drop dup
save allWellSurfLoc
clear
cd ..
cd Posted
use 19-gas_20161230
rename api_no api
destring api, replace
cd ..
cd Working
merge m:1 api using allWellSurfLoc
gen apiLocMatch = .
replace apiLocMatch = 1 if _merge ==3
replace apiLocMatch = 0 if _merge ==1
drop if _merge ==2
drop _merge
label variable apiLocMatch "Has matching gis data using api"
note apiLocMatch: "19-gas20161230 and 20-allWellSurfLoc_20170113.csv appendage has matching gis data using api number"
note apiLocMatch: "Created in 21-matchApi_20170115.do from 19-gas20161230 and 20-allWellSurfLoc_20170113.csv"
note apiLocMatch: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
tab apiLocMatch
gen nad83lat = .
replace nad83lat = lat83 if apiLocMatch == 1
replace nad83lat = latitudedatum83 if apiLocMatch != 1
label variable nad83lat "NAD 83 latitude data"
note nad83lat: "Latitude data in nad83 format from either trrc map data or trrc programmed request data"
note nad83lat: "Created in 21-matchApi_20170115.do from 19-gas20161230 and 20-allWellSurfLoc_20170113.csv"
note nad83lat: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
gen nad83long = .
replace nad83long = long83 if apiLocMatch == 1
replace nad83long = longitudedatum83 if apiLocMatch != 1
gen no83data = .
replace no83data = 1 if nad83long == . | nad83lat == .
replace no83data = 0 if nad83long != . & nad83lat != .
label variable no83data "No NAD 83 latitude data available"
note no83data: "Latitude data in nad83 format from either trrc map data or trrc programmed request data"
note no83data: "Created in 21-matchApi_20170115.do from 19-gas20161230 and 20-allWellSurfLoc_20170113.csv"
note no83data: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
tab no83data
label data "2012 producing gas well Texas Railroad Commission data with nad 83 coordinates in nad83lat nad83long variables"
save 21-gas83_20170115
export delimited using 21-gas83_20170115
cd ..
cd Posted
save 21-gas83_20170115
export delimited using 21-gas83_20170115
cd ..
cd Working
keep if no83data == 1
label data "producing gas wells in 2012 without NAD 83 or NAD 27 data"
sum lease_gas_dispcd04_vol lease_gas_prod_vol lease_cond_prod_vol
save 21-gasNOlatlong_20170115
export delimited using 21-gasNOlatlong_20170115
cd ..
cd Posted
save 21-gasNOlatlong_20170115
export delimited using 21-gasNOlatlong_20170115
cd ..
clear
//
//
/********-*********-*********-*********-*********-*********-*********/
/* merge oil well data, show match, and export as csv				*/
/********-*********-*********-*********-*********-*********-*********/
//
cd Posted
use 19-oil_20161230
rename api_no api
destring api, replace
cd ..
cd Working
merge m:1 api using allWellSurfLoc
gen apiLocMatch = .
replace apiLocMatch = 1 if _merge ==3
replace apiLocMatch = 0 if _merge ==1
drop if _merge ==2
drop _merge
label variable apiLocMatch "Has matching gis data using api"
note apiLocMatch: "19-oil20161230 and 20-allWellSurfLoc_20170113.csv appendage has matching gis data using api number"
note apiLocMatch: "Created in 21-matchApi_20170115.do from 19-oil20161230 and 20-allWellSurfLoc_20170113.csv"
note apiLocMatch: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
tab apiLocMatch
gen nad83lat = .
replace nad83lat = lat83 if apiLocMatch == 1
replace nad83lat = latitudedatum83 if apiLocMatch != 1
label variable nad83lat "NAD 83 latitude data"
note nad83lat: "latitude data in nad83 format from either trrc map data or trrc programmed request data"
note nad83lat: "Created in 21-matchApi_20170115.do from 19-oil20161230 and 20-allWellSurfLoc_20170113.csv"
note nad83lat: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
gen nad83long = .
replace nad83long = long83 if apiLocMatch == 1
replace nad83long = longitudedatum83 if apiLocMatch != 1
gen no83data = .
replace no83data = 1 if nad83long == . | nad83lat == .
replace no83data = 0 if nad83long != . & nad83lat != .
label variable no83data "No NAD 83 latitude data available"
note no83data: "latitude data in nad83 format from either trrc map data or trrc programmed request data"
note no83data: "Created in 21-matchApi_20170115.do from 19-oil20161230 and 20-allWellSurfLoc_20170113.csv"
note no83data: "Original Source: well001b.shp-well507.shp (odd number count) of Digital Map Information Downloaded on January 13, 2017 at ftp://subkac:24data43@ftp.rrc.state.tx.us"
tab no83data
label data "2012 producing oil well Texas Railroad Commission data in NAD 83 format in nad83lat and nad83long variables"
save 21-oil83_20170115
export delimited using 21-oil83_20170115
cd ..
cd Posted
save 21-oil83_20170115
export delimited using 21-oil83_20170115
cd ..
cd Working
keep if no83data == 1
label data "producing oil wells in 2012 without WGS 83 data, but with nad 27 data"
keep if no83data == 1
gen nad27lat = .
destring latitude, replace
replace nad27lat = latitude
label variable nad27lat "NAD 83 latitude data"
note nad27lat: "latitude data in nad27 format from permit data"
note nad27lat: "Created in 21-matchApi_20170115.do from 19-oil20161230"
note nad27lat: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
gen nad27long = .
destring longitude, replace
replace nad27long = longitude 
gen no27data = .
replace no27data = 1 if nad27long == . | nad27lat == .
replace no27data = 0 if nad27long != . & nad27lat != .
label variable no27data "No NAD 27 latitude data available"
note no27data: "latitude data in nad27 format from permit data"
note no27data: "Created in 21-matchApi_20170115.do from 19-oil20161230"
note no27data: "Original Data Source: fvf609 received via email to kate.willyard@tamu.edu entitled FW:IN5524_Cecilia Smith from GIS librarian Cecilia Smith (casmith@library.tamu.edu) on August 10, 2015"
tab no27data
save 21-oil2720170114
export delimited using 21-oil27_20170115
cd ..
cd Posted
save 21-oil27_20170115
export delimited using 21-oil27_20170115
cd ..
//