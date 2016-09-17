// program:		08-extract_tableInspections_20160824.do
// task:		Create stata file using Export table-Inspections, a file obtained from Karen Sanchez on July 26, 2016 after I submitted a request on June 24.
// version: 	Second Draft
// project:		EOCPC 
// author:		Kate Willyard 8/24/2016
//
// set settings and working directory
cd "C:/TRRC"
capture log close master
log using 08-extract_tableInspections_20160824, name(master) replace text
clear all
version 13
set more off
cd "C:/TRRC"
cd Original
//
import delim using table-Inspections.txt, delimiters ("}")
cd ..
cd Posted
save 08-inspections_20160824, replace
export delimited 08-inspections_20160824
clear