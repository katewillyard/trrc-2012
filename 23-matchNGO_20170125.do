cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 23-matchNGO_20170125, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
//
// program:		23-matchNGO_20170125.do
// task:		clean National Center for Charitable Statistics 2012 data 
//				clean county map data with UID to match with polygons
//				merge ngo data and export as csv
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 1/25/2017
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
/* clean National Center for Charitable Statistics 2012 data 		*/
/********-*********-*********-*********-*********-*********-*********/
//
cd Original 
import excel "nccs_20170111.xlsx", sheet("Sheet1") firstrow
label data "Registered Nonprofit Organizations Established in 2012 by Texas County"
notes: "Source: NCCS data on registered nonprofit organizations in 2012 by Texas County Downloaded at http://nccsweb.urban.org/tablewiz/bmf.php on January 11, 2017"
cd ..
cd Working
drop if County == "-"
rename County county
rename NumberofRegisteredOrganizatio registeredOrgs
rename NumberofOrganizationsFilingF f990Orgs
rename TotalRevenueReportedonForm9 countyNGOrevenue
rename AssetsReportedonForm990 countyNGOassets
rename F f990nOrgs
rename TotalNumberofOrganizationsFi f990or990nOrgs
replace county = subinstr(county," County, TX","",.)
replace county = "DeWitt" if county == "Dewitt"
replace county = "La Salle" if county == "LA Salle"
replace county = "McCulloch" if county == "Mcculloch"
replace county = "McLennan" if county == "Mclennan"
replace county = "McMullen" if county == "Mcmullen"
save nccsCountyNGOs
clear
cd ..
//
/********-*********-*********-*********-*********-*********-*********/
/* clean county map data with polygon UID					 		*/
/********-*********-*********-*********-*********-*********-*********/
//
cd Original
import delimited stratMap_county_poly_dbf.txt
label data "County map polygon identifiers"
notes: "Source: County map polygon identifiers from Political Boundaries map.dbf from https://tnris.org/data-download/#!statewide on January 19, 2017"
cd ..
cd Working
keep fid name 
rename name county
save CountyMapPoly
//
/********-*********-*********-*********-*********-*********-*********/
/* merge NGO data and export at .csv						 		*/
/********-*********-*********-*********-*********-*********-*********/
//
merge 1:1 county using nccsCountyNGOs
drop _merge
save 23-ngo_20170125
export delimited using 23-ngo_20170125
cd ..
cd Posted
save 23-ngo_20170125
export delimited using 23-ngo_20170125
//
//