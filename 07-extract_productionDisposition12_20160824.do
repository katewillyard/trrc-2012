// program:		07-extract_productionDisposition12_20160824.do
// task:		Create stata file using s6leaseCycleDisp12.csv and 66leaseCycle12.csv created in program 06.
// version: 	Second Draft
// project:		EOCPC 
// author:		Kate Willyard 8/24/2016
//
// set settings and working directory
cd "C:/TRRC"
capture log close master
log using 07-extract_productionDisposition12_20160824, name(master) replace text
clear all
version 13
set more off
cd "C:/TRRC"
cd Posted
//
// import and create stata file for s6leaseCycleDisp12.csv
import delim using s6leaseCycleDisp12_20160824.csv
save 07-disposition_20160824, replace
clear
//
// import and create stata file for s6leaseCycleDisp12.csv 
import delim using s6leaseCycle12_20160824.csv
save 07-production_20160824, replace
clear