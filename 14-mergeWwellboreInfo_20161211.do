cd "C:/Users/TXCRDC/Documents/Research/eocpc/posted/logFile"
capture log close master
log using 14-mergeWwellboreInfo_20161211, name(master) replace text
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
// program:		14-mergeWwellboreInfo_20161211.do
// task:		clean dbf900wbroot data
//				clean dbf900wbcomp data
//				clean dbf900wbnewloc data
//				clean dbf900wboldloc data
//				merge necessary dbf900 data segments
//				merge oil pd and orgInfo with wellbore info
//				merge gas pd and orgInfo with wellbore info
// version: 	First Draft
// project:		EOCPC 
// author:		Kate Willyard 12/11/2016
//
/********-*********-*********-*********-*********-*********-*********/
/* Set Settings and Working Directory								*/
/********-*********-*********-*********-*********-*********-*********/
clear all
version 13
set more off
cd "C:/Users/TXCRDC/Documents/Research/eocpc"
cd Posted
//
//
/********-*********-*********-*********-*********-*********-*********/
/* clean dbf990wbroot (02-dbf990wbroot_20161129) data				*/
/********-*********-*********-*********-*********-*********-*********/
use 02-dbf900wbroot_20161129
notes: "Original Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_API_NUMBER api_no
label variable api_no "api number"
notes api_no: "County code (3 digit) followed by api number (5 digit)"
notes api_no: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes api_no: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
drop WB_NXT_AVAIL_SUFFIX
drop WB_NXT_AVAIL_HOLE_CHG_NBR
rename WB_FIELD_DISTRICT field_district
label variable field_district "field district"
notes field_district: "District in which the field is located"
notes field_district: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes field_district: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_RES_CNTY_CODE county_code
label variable county_code "county code"
notes county_code: "county code"
notes county_code: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes county_code: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_ORIG_COMPL_CC compl_year_code
label variable compl_year_code "completion century code"
notes compl_year_code: "Century code for the completion date. 19th C = 1. 20th C = 2. 21st C = 3."
notes compl_year_code: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes compl_year_code: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_ORIG_COMPL_DATE completion_date
label variable completion_date "completion date"
notes completion_date: "Completion date reported on W-2 or G-1 in CCYYMMDD format"
notes completion_date: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes completion_date: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_TOTAL_DEPTH well_depth
label variable well_depth "well depth"
notes well_depth: "Maximum depth of well bore"
notes well_depth: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes well_depth: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_VALID_FLUID_LEVEL fluid_lvl
label variable fluid_lvl "fluid level"
notes fluid_lvl: "In H-15 testing, a valid distance in feet determined by the commission between the bottom of usable water in the area and top of fluid in wellbore if that distance is different than the standard 250"
notes fluid_lvl: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes fluid_lvl: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_CERTIFICATION_REVOKED_DATE revoked_date
label variable revoked_date "date HB 1975 cert revoked"
notes revoked_date: "date the house bill 1975 certification was revoked in CCYYMMDD format"
notes revoked_date: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes revoked_date: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_CERTIFICATION_DENIAL_DATE denial_date
label variable denial_date "date HB1975 cert denied"
notes denial_date: "Date the house bill 1975 certification was denied in CCYYMMDD format"
notes denial_date: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes denial_date: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DENIAL_REASON_FLAG denial_type
label variable denial_type "denial type"
notes denial_type: "This flag will be set to A if it was automatically denied certification for housebill 1975. This flag will be set to M if it was manually (online) denied certification for house bill 1975. This flag will be set to zero or space if it has not been denied certification for house bill 1975"
notes denial_type: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes denial_type: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_ERROR_API_ASSIGN_CODE api_change
label variable api_change "API changed"
notes api_change: "Indicates that API previously assigned has changed."
notes api_change: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes api_change: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_REFER_CORRECT_API_NBR correct_api
label variable correct_api "correect api"
notes correct_api: "Indicates most recent resolution of API or correct assignment." 
notes correct_api: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes correct_api: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DUMMY_API_NUMBER no_api
label variable no_api "no api"
notes no_api: "80,000-range numbers assinged to bores without api numbers as of december 1983 and to bores which are identified later as having been drilled before 1966 and having no api"
notes no_api: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes no_api: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DATE_DUMMY_REPLACED api_change_date
label variable api_change_date "date api changed"
notes api_change_date: "Date that api is replaced by another api number in CCYYMMDD format. not in use as of january 1984."
notes api_change_date: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes api_change_date: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_NEWEST_DRL_PMT_NBR permit
label variable permit "drill permit"
notes permit: "Indicates date of permit to drill issued most recently in a particular bore"
notes permit: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes permit: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_CANCEL_EXPIRE_CODE permit_expired
label variable permit_expired "permit expired"
notes permit_expired: "Indicates whether newest drilling permit was cancelled or expired, as opposed to having been used."
notes permit_expired: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes permit_expired: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_EXCEPT_13_A swr13a_exception
label variable swr13a_exception "SWR 13A exception given."
notes swr13a_exception: "Indicates whether or not operator was granted an exception to swr 13A. Y- Filed, N-Not filed"
notes swr13a_exception: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes swr13a_exception: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_PLUG_FLAG plug
label variable plug "wellbore plugged"
notes plug: "Indicates whether or not well bore has been plugged, Y- plugged"
notes plug: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes plug: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_FRESH_WATER_FLAG freshWaterWell
label variable freshWaterWell "fresh water well"
notes freshWaterWell: "Indicates whether or not well has been converted to a fresh water well. y- fresh water well"
notes freshWaterWell: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes freshWaterWell: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_PREVIOUS_API_NBR old_api
label variable old_api "previous api number"
notes old_api: "Indicates the api number previously assigned to the bore, which was later found to be an incorrect assignment"
notes : "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes : "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_COMPLETION_DATA_IND completion_onfile
label variable completion_onfile "completion information onfile"
notes completion_onfile: "Indicates whether or not well bore completion information is on file for a particular well. y- data onfile, n-data not onfile"
notes completion_onfile: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes completion_onfile: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_HIST_DATE_SOURCE_FLAG completion_data_outsource
label variable completion_data_outsource "data from non-rrc source"
notes completion_data_outsource: "Indicates where original well bore completion date came from a non-rrc source"
notes completion_data_outsource: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes completion_data_outsource: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_EX14B2_COUNT extensionsGranted
label variable extensionsGranted "number of extensions granted"
notes extensionsGranted: "Number of W-1x 14B2 extensions granted for the wellbore"
notes extensionsGranted: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes extensionsGranted: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DESIGNATION_HB_1975_FLAG hb1975_certType
label variable hb1975_certType "hb 1975 certification type"
notes hb1975_certType: "A- the wellbore was automatically certified for House Bill 1975 by the monthly computer run. M- the wellbore was manually certified for house bill 1975 by the operator filing an st2 form. zeros or spaced- the wellbore is not certified for house bill 1975."
notes hb1975_certType: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes hb1975_certType: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DESIGNATION_EFFECTIVE_DATE dateDesignationEffective
label variable dateDesignationEffective "data well becomes eligible for tax exemption"
notes dateDesignationEffective: "this data item is a six charcter date representing the first date the well becomes eligible for certification for taxx exemption in CCYYMM format"
notes dateDesignationEffective: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes dateDesignationEffective: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DESIGNATION_REVISED_DATE dateDesignationRevised
label variable dateDesignationRevised "data well designation revised"
notes dateDesignationRevised: "This is a manual modification for the autonomatically generated wb-designation-effective-date in ccyymm format"
notes dateDesignationRevised: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes dateDesignationRevised: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DESIGNATION_LETTER_DATE designationLetterDate
label variable designationLetterDate "date letter on hb1975 eligible sent"
notes designationLetterDate: "This is a the date that a letter was sent to notify the operator that his wellbore is a candidate for house bill 1975 certification in CCYYMMDD format"
notes designationLetterDate: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes designationLetterDate: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_CERTIFICATION_EFFECT_DATE certDate
label variable certDate "date wellbore tax credit under hb1975 certified"
notes certDate: "This data item is the date the wellbore was certified to receive a tax credit for house bill 1975 in CCYYMM format"
notes certDate: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes certDate: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_WATER_LAND_CODE water_land
label variable water_land "water or land location of wellbore"
notes water_land: "This data item holds a 1-byte code detailing the water or land location of the wellbore. O-Offshore, B- Bay/Estuary, I- Inland waterway, L- Land"
notes water_land: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes water_land: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_OVERRIDE_EST_PLUG_COST estimatedPlugCost
label variable estimatedPlugCost "estimated cost to plug wellbore"
notes estimatedPlugCost: "This data item holds the amount that is required to plug a wellbore. This amount takes precedence over any of the computed depth amounts. This data is used in the 14B2 system as the amount required for an individual well bond when a well has been inactive for more than 36 months"
notes estimatedPlugCost: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes estimatedPlugCost: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_SHUT_IN_DATE shutIn_date
label variable shutIn_date "date wellbore became inactive"
notes shutIn_date: "This data item reflects the date that all wells in a wellbore have been inactive."
notes shutIn_date: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes shutIn_date: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_OVERRIDE_BONDED_DEPTH plug_bond
label variable plug_bond "required bond amount for plugging wellbore"
notes plug_bond: "This data item is used to compute the required bond amount for plugging the wellbore. This data item when present is used instead of the total depth or total bonded depth"
notes plug_bond: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes plug_bond: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_SUBJ_TO_14B2_FLAG wells_shutin
label variable wells_shutin "wells shut in for one year and subject to rule 14B2"
notes wells_shutin: "this data item is set when all the wells in the wellbore have been shut in for one year and one well is subject to rule 14B2"
notes wells_shutin: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wells_shutin: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_PEND_REMOVAL_14B2_FLAG becomingActive
label variable becomingActive "wellbores subject to 14B2 that are active"
notes becomingActive: "This data item is used for wellbores subject to 14B2 that are becoming active by producing for three consecutive months"
notes becomingActive: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes becomingActive: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_TOTAL_BONDED_DEPTH bondedDepth
label variable bondedDepth "total bonded depth"
notes bondedDepth: "Item not described in Oil and Gas Well Bore System Magnetic Tape User's Guide"
notes bondedDepth: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes bondedDepth: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_ORPHAN_WELL_HOLD_FLAG orphanWell
label variable orphanWell "orphan well flag"
notes orphanWell: "Item not described in Oil and Gas Well Bore System Magnetic Tape User's Guide"
notes orphanWell: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes orphanWell: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
label variable id "dbf990 hierarchical data table connecting identifier"
notes id: "the unique id given to connect hierarchical data seperated into the different dbf990 tables"
notes id: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes id: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
save 14-dbf990wbroot-clean_20161211
cd ..
cd Working
save 14-dbf990wbroot-clean_20161211
cd ..
cd Posted
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* clean dbf990wbnewloc (02-dbf990wbnewloc_20161129) data			*/
/********-*********-*********-*********-*********-*********-*********/
use 02-dbf900wbnewloc_20161129
rename WB_LOC_COUNTY wbCounty
label variable wbCounty "county"
notes wbCounty: "Indicates county in which well is located"
notes wbCounty: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbCounty: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_ABSTRACT ssfNo
label variable ssfNo "summary statement of facts number"
notes ssfNo: "Number assinged to summary statement of facts on which the person's land title rests"
notes ssfNo: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes ssfNo: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_SURVEY wbSurveyNo
label variable wbSurveyNo "survey number"
notes wbSurveyNo: "Name associated with the boundaries to a portion of land"
notes wbSurveyNo: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbSurveyNo: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_BLOCK_NUMBER blkNo
label variable blkNo "block number"
notes blkNo: "Identifying number associated with a square portion of land"
notes blkNo: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes blkNo: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_SECTION wbSecName
label variable wbSecName "subdivision name"
notes wbSecName: "Name of subdivision of land that is one mile square, containing approximately 640 acres"
notes wbSecName: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbSecName: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_ALT_SECTION webAltSec
label variable webAltSec "alternative subdivision name"
notes webAltSec: "When more than one section is reported, alternative name of subidivion"
notes webAltSec: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes webAltSec: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_ALT_ABSTRACT altSSFNo
label variable altSSFNo "alternative summary statement of facts number"
notes altSSFNo: "When more than one abstract is reported"
notes altSSFNo: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes altSSFNo: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_FEET_FROM_SUR_SECT_1 wbDistSS1
label variable wbDistSS1 "survey line 1 distance in feet"
notes wbDistSS1: "Distance of well (in feet) from designated survey or section line"
notes wbDistSS1: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbDistSS1: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DIREC_FROM_SUR_SECT_1 wbDirSS1
label variable wbDirSS1 "survey line 1 direction"
notes wbDirSS1: "Direction from which measurements from designated survey or section line were taken"
notes wbDirSS1: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbDirSS1: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_FEET_FROM_SUR_SECT_2 wbDistSS2
label variable wbDistSS2 "survey line distance 2 in feet"
notes wbDistSS2: "Distance of well (in feet) from designated survey or section line"
notes wbDistSS2: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbDistSS2: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DIREC_FROM_SUR_SECT_2 wbDirSS2
label variable wbDirSS2 "survey line 2 direction"
notes wbDirSS2: "Direction from which measurements from designated survey or section line were taken"
notes wbDirSS2: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbDirSS2: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_WGS84_LATITUDE wbLatWGS84
label variable wbLatWGS84 "latitude in WGS84"
notes wbLatWGS84: "Location of well according to system of spherical coordinates of the earth which run east and west"
notes wbLatWGS84: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbLatWGS84: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_WGS84_LONGITUDE wbLongWGS84
label variable wbLongWGS84 "longitude in WGS84"
notes wbLongWGS84: "Location of well according to system of spherical coordinates of the earth which run north and sourth"
notes wbLongWGS84: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbLongWGS84: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_PLANE_ZONE wbPlaneZone
label variable wbPlaneZone "plane zone"
notes wbPlaneZone: "Cartesian Coordinate System for the area where well is located"
notes wbPlaneZone: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbPlaneZone: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_PLANE_COORDINATE_EAST eastCC
label variable eastCC "east cartesian coordinates"
notes eastCC: "Location of well according to east coordinate of cartesian coordinate system"
notes eastCC: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes eastCC: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_PLANE_COORDINATE_NORTH northCC
label variable northCC "north cartesian coordiantes"
notes northCC: "Location of well according to north coordinate of cartesian coordinate system"
notes northCC: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes northCC: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_VERIFICATION_FLAG wbLocVerified
label variable wbLocVerified "new location verified flag"
notes wbLocVerified: "New location verified flag. N- new location not verified. Y- new location verified. C-New lcoation verified change."
notes wbLocVerified: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes wbLocVerified: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
label variable id "dbf990 hierarchical data table connecting identifier"
notes id: "the unique id given to connect hierarchical data seperated into the different dbf990 tables"
notes id: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes id: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
save 14-dbf990wbnewloc-clean_20161211
cd ..
cd Working
save 14-dbf990wbnewloc-clean_20161211
cd ..
cd Posted
clear
/********-*********-*********-*********-*********-*********-*********/
/* clean dbf990wboldloc (02-dbf990wboldloc_20161129) data			*/
/********-*********-*********-*********-*********-*********-*********/
use 02-dbf900wboldloc_20161129
rename WB_LEASE_NAME leaseName
label variable leaseName "lease name"
notes leaseName: "Name of lease in which well is located"
notes leaseName: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes leaseName: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_SEC_BLK_SURVEY_LOC secBlkSrvy
label variable secBlkSrvy "section-block-survey"
notes secBlkSrvy: "Name of section, block and survey in which well is located"
notes secBlkSrvy: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes secBlkSrvy: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_WELL_LOC_MILES milesNearTown
label variable milesNearTown "miles to nearest town"
notes milesNearTown: "Number of miles from nearest town to well"
notes milesNearTown: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes milesNearTown: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_WELL_LOC_DIRECTION dirNearTown
label variable dirNearTown "direction to nearest town"
notes dirNearTown: "Direction from which measurement from town was taken"
notes dirNearTown: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes dirNearTown: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_WELL_LOC_NEAREST_TOWN nameNearTown
label variable nameNearTown "name of the nearest town"
notes nameNearTown: "Name of town nearest well"
notes nameNearTown: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes nameNearTown: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DIST_FROM_SURVEY_LINES distSurveyLines
label variable distSurveyLines "distance from survey lines"
notes distSurveyLines: "Distance from particular survey lines from which measurements were taken "
notes distSurveyLines: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes distSurveyLines: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_DIST_DIRECT_NEAR_WELL locNearWell
label variable locNearWell "location of nearest well"
notes locNearWell: "Distance from and direction of nearest well"
notes locNearWell: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes locNearWell: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
label variable id "dbf990 hierarchical data table connecting identifier"
notes id: "the unique id given to connect hierarchical data seperated into the different dbf990 tables"
notes id: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes id: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
save 14-dbf990wboldloc-clean_20161211
cd ..
cd Working
save 14-dbf990wboldloc-clean_20161211
cd ..
cd Posted
clear
/********-*********-*********-*********-*********-*********-*********/
/* clean dbf990wbcomp (02-dbf990wbcomp_20161211) data				*/
/********-*********-*********-*********-*********-*********-*********/
use 02-dbf900wbcomp_20161129
notes: "Original Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WELL_BORE_COMPLETION_SEG segID
label variable segID "segment identifier"
notes segID: "[Oil Code] + [Oil District] + [Oil Lease] + [Oil Well] or [Gas Code] + [Gas ID number]"
notes segID: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes segID: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_GAS_DIST district
label variable district "gas district"
notes district: "District in which gas well is located"
notes district: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes district: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_GAS_WELL_NO well
label variable well "gas well number"
notes well: "Well number of completed gas well"
notes well: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes well: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_MULTI_WELL_REC_NBR group_unit
label variable group_unit "well group id"
notes group_unit: "indicates the unit or group of wells within the lease that the completed oil well is in"
notes group_unit: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes group_unit: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
drop WB_API_SUFFIX WB_ACTIVE_INACTIVE_CODE WB_DWN_HOLE_COMMINGLE_CODE
rename WB_CREATED_FROM_PI_FLAG pi_source
label variable pi_source "pi files sole source"
notes pi_source: "Indicates whether PI Files are the sole source of informatin on well being added to the well bore files. Shown on suspense cards created for central records"
notes pi_source: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes pi_source: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_RULE_37_NBR rule37except_docketNo
label variable rule37except_docketNo "rule 37 exception docket number"
notes rule37except_docketNo: "Docket number assigned to well completed under rule 37 exception"
notes rule37except_docketNo: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes rule37except_docketNo: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_P_15 prodStateFiled
label variable prodStateFiled "productivity statement filed"
notes prodStateFiled: "indicates whether or not statement of productivity of acreage was filed. y- yes, n-no"
notes : "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes : "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_P_12 poolAuthFiled
label variable poolAuthFiled "pooling authority filed"
notes poolAuthFiled: "Indicates whether or not certificate of pooling authority was filed"
notes poolAuthFiled: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes poolAuthFiled: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
rename WB_PLUG_DATE_POINTER plugRptFile_date
label variable plugRptFile_date "plugging report filed dated"
notes plugRptFile_date: "Indicates date that plugging report was filed on completed well in CCYYMMDD format"
notes plugRptFile_date: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes plugRptFile_date: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
label variable id "dbf990 hierarchical data table connecting identifier"
notes id: "the unique id given to connect hierarchical data seperated into the different dbf990 tables"
notes id: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes id: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
save 14-dbf900wbcomp-clean_20161211
cd ..
cd Working
save 14-dbf900wbcomp-clean_20161211
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge necessary dbf990 data segments								*/
/********-*********-*********-*********-*********-*********-*********/
use 14-dbf990wbroot-clean_20161211
merge 1:1 id using 14-dbf990wbnewloc-clean_20161211
drop _merge
merge 1:1 id using 14-dbf990wboldloc-clean_20161211
drop _merge
merge 1:m id using 14-dbf900wbcomp-clean_20161211
drop _merge
save dbf990-merged
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge gas data with wellbore data								*/
/********-*********-*********-*********-*********-*********-*********/
gen segIDg = segID
drop if segIDg == ""
label variable segIDg "gas wellbore unique identifier for merge with PD&Org Info"
notes segIDg: "[Gas Code] + [Gas Lease Number]"
notes segIDg: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes segIDg: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
gen segIDo = substr(segID,1,8)
label variable segIDo "oil lease unique identifier for wellbore merge with PD&Org Info"
notes segIDo: "[Oil Code] + [Oil District] + [Oil Lease]"
notes segIDo: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes segIDo: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
//
// drop wellbores shut in before 2012
gen shutInYear = substr(shutIn_date,1,4)
destring shutInYear, replace
keep if shutInYear == 0 | shutInYear >= 2012
save dbf990WsegID
cd ..
cd Posted
use 13-gasPDOrgInsp_20161117
cd ..
cd Working
gen segIDg = "G" + string(lease_no, "%06.0f")
// merge should result in some not matched from using
// merge can result in some not matched from master 
//       (If no corresponding wellbore data)
merge m:1 segIDg using dbf990WsegID
gen noWBmatch = .
replace noWBmatch = 1 if _merge == 1
replace noWBmatch = 0 if _merge == 3
drop if _merge == 2
drop _merge
label variable noWBmatch "gasPDwOrgInfo not matched with dbf990 wellbore data"
notes noWBmatch: "Wellbore system data NOT merged with unique well operator: Gas Code + Lease Number"
notes noWBmatch: "Created from merged dbf990wbroot and dbf990wbcomp in 13-mergeWwellboreInfo_20161129"
notes noWBmatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes noWBmatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes noWBmatch: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes noWBmatch: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes noWBmatch: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20161129.dta in 04-extract_orf850_20161129.do"
notes noWBmatch: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes noWBmatch: "Production and disposition data merged creating 10-oilProdDisp_20161101 from 07-production_20161129.dta and 07-disposition_20161129.dta in 10-manageProductionDisposition_20161101.do"
notes noWBmatch: "Disposition data transformed from s6leaseCycleDisp12_20161129.csv to 07-disposition_20161129.dta in 07-extract_productionDisposition12_20161129.do"
notes noWBmatch: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20161129.sas"
notes noWBmatch: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20161129"
notes noWBmatch: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes noWBmatch: "Production data transformed from s6leaseCycle12_20161129.csv to 07-production_20161129.dta in 07-extract_productionDisposition12_20161129.do"
notes noWBmatch: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20161129.sas"
notes noWBmatch: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20161129"
notes noWBmatch: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
tab noWBmatch
save 14-gasPDorgVioWwb_20161211
cd ..
cd Posted
save 14-gasPDorgVioWwb_20161211
cd ..
cd Working
keep if noWBmatch == 1
save 14-gasPDworgVioWOwbMatch_20161211
cd ..
cd Posted
save 14-gasPDworgVioWOwbMatch_20161211
clear
//
/********-*********-*********-*********-*********-*********-*********/
/* Merge oil data with wellbore data								*/
/********-*********-*********-*********-*********-*********-*********/
use 13-oilPDOrgInsp_20161117
cd ..
cd Working
gen segIDo = "O" + string(district_no, "%02.0f") + string(lease_no, "%05.0f")
// merge should result in some not matched from using
// merge can result in some not matched from master 
//       (If no corresponding wellcbore data)
merge m:m segIDo using dbf990WsegID
gen noWBmatch = .
replace noWBmatch = 1 if _merge == 1
replace noWBmatch = 0 if _merge == 3
drop if _merge == 2
drop _merge
label variable noWBmatch "oilPDwOrgInfo not matched with dbf990 wellbore data"
notes noWBmatch: "Wellbore system data NOT merged with unique well operator: Oil Code + District Number + Lease Number + Well"
notes noWBmatch: "Created from merged dbf990wbroot and dbf990wbcomp in 13-mergeWwellboreInfo_20161129"
notes noWBmatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbroot_20161129.dta in 02-extract_dbf990_20161129.do"
notes noWBmatch: "Well bore technical data root segment transformed from dbf990.txt to 02-dbf990wbcomp_20161129.dta in 02-extract_dbf990_20161129.do"
notes noWBmatch: "Original Well Bore System Data Source: dbf990.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp-e.rrc.state.tx.us on May 6, 2016"
notes noWBmatch: "Production and Disposition data merged with orgInfo creating 12-oilPDwOrgInfo_20161030"
notes noWBmatch: "OrgInfo data transformed from orf850.txt to 04-extract_orf850_20161129.dta in 04-extract_orf850_20161129.do"
notes noWBmatch: "Original OrgInfo Data Source: orf850.txt obtained from Texas Railroad Commission Digital Download ftp://subkac:24data43@ftp.rrc.state.tx.us on May 6, 2016"
notes noWBmatch: "Production and disposition data merged creating 10-oilProdDisp_20161101 from 07-production_20161129.dta and 07-disposition_20161129.dta in 10-manageProductionDisposition_20161101.do"
notes noWBmatch: "Disposition data transformed from s6leaseCycleDisp12_20161129.csv to 07-disposition_20161129.dta in 07-extract_productionDisposition12_20161129.do"
notes noWBmatch: "2012 disposition data clipped from s5leaseCycleDisp.sas to s6leaseCycleDisp12.sas7bdat in 06-extract_prod2012_20161129.sas"
notes noWBmatch: "Disposition data transformed from OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20161129"
notes noWBmatch: "Original Disposition Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
notes noWBmatch: "Production data transformed from s6leaseCycle12_20161129.csv to 07-production_20161129.dta in 07-extract_productionDisposition12_20161129.do"
notes noWBmatch: "2012 production data clipped from s5leaseCycle.sas to s6leaseCycle12.sas7bdat in 06-extract_prod2012_20161129.sas"
notes noWBmatch: "Production data transformed from OG_LEASE_CYCLE_DATA_TABLE.dsv to s5leaseCycle.sas7bdat in 05-extract_pdqdsv_20161129"
notes noWBmatch: "Original Production Data Source: PDQ_DSV.zip/OG_LEASE_CYCLE_DATA_TABLE obtained from Texas Railroad Commission, Digital Data Coordinator, Ernest Oviedo on June 27, 2016"
tab noWBmatch
save 14-oilPDorgVioWwb_20161211
cd ..
cd Posted
save 14-oilPDorgVioWwb_20161211
cd ..
cd Working
keep if noWBmatch == 1
save 14-oilPDworgVioWOwbMatch_20161211
cd ..
cd Posted
save 14-oilPDworgVioWOwbMatch_20161211
clear
//