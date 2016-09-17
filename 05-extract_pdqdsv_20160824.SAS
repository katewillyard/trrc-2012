/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
* program:		05-extract_pdqdsv_20160824.SAS;
* task:			Create production file extracts using PDQ-DSV TXRRC file (Production Dumpt DSV);
* version: 		Second Draft;
* project:		EOCPC; 
* author:		Kate Willyard 8/24/2016;
/********-*********-*********-*********-*********-*********-*********/
/* Set Libraries													*/
/********-*********-*********-*********-*********-*********-*********/
LIBNAME orgLoc 'C:/TRRC/Original/PDQ_DSV';
LIBNAME postLoc 'C:/TRRC/Posted';
/********-*********-*********-*********-*********-*********-*********/
/* Create GP County Data File										*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5countyCycle;
	INFILE C:\TRRC\Original\PDQ_DSV\PDQ_DSVGP_COUNTY_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat COUNTY_NO $varying3.;
		informat COUNTY_FIPS_CODE $varying3.;
		informat COUNTY_NAME $varying50.;
		informat DISTRICT_NAME $varying50.;
		informat ON_SHORE_FLAG $varying1.;
		informat ONSHORE_ASSC_CNTY_FLAG $varying1.;
	INPUT
		COUNTY_NO $
		COUNTY_FIPS_CODE $
		COUNTY_NAME $
		DISTRICT_NAME $
		ON_SHORE_FLAG $
		ONSHORE_ASSC_CNTY_FLAG $	
	;
RUN;	
PROC EXPORT
	DATA = postLoc.s5countyCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5countyCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create GP Date Range Cycle Data File								*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5dateRangeCycle;
	INFILE "C:\TRRC\Original\PDQ_DSV\GP_DATE_RANGE_CYCLE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OLDEST_PROD_CYCLE_YEAR_MONTH $varying6.;
		informat NEWEST_PROD_CYCLE_YEAR_MONTH $varying6.;
		informat NEWEST_SCHED_CYCLE_YEAR_MONTH $varying6.;
		informat GAS_EXTRACT_DATE $varying7.;
		informat OIL_EXTRACT_DATE $varying7.;
	INPUT
		OLDEST_PROD_CYCLE_YEAR_MONTH $
		NEWEST_PROD_CYCLE_YEAR_MONTH $
		NEWEST_SCHED_CYCLE_YEAR_MONTH $
		GAS_EXTRACT_DATE $
		OIL_EXTRACT_DATE $
	;
RUN;	
PROC EXPORT
	DATA = postLoc.s5dateRangeCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5dateRangeCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create GP District Data File										*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5district;
	INFILE "C:\TRRC\Original\PDQ_DSV\GP_DISTRICT_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat DISTRICT_NO $varying2.;
		informat DISTRICT_NAME $varying50.;
		informat OFFICE_PHONE_NO $varying10.;
		informat OFFICE_LOCATION $varying50.;
	INPUT
		DISTRICT_NO $
		DISTRICT_NAME $
		OFFICE_PHONE_NO $
		OFFICE_LOCATION $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5district
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5district_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG County Cycle Data File									*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5countyCycle;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_COUNTY_CYCLE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat COUNTY_NO $varying3.;
		informat DISTRICT_NO $varying2.;
		informat CYCLE_YEAR $varying4.;
		informat CYCLE_MONTH $varying2.;
		informat CYCLE_YEAR_MONTH $varying6.;
		informat CNTY_OIL_PROD_VOL $varying22.;
		informat CNTY_OIL_ALLOW $varying22.;
		informat CNTY_OIL_ENDING_BAL $varying22.;
		informat CNTY_GAS_PROD_VOL $varying22.;
		informat CNTY_GAS_ALLOW $varying22.;
		informat CNTY_GAS_LIFT_INJ_VOL $varying22.;
		informat CNTY_COND_PROD_VOL $varying22.;
		informat CNTY_COND_LIMIT $varying22.;
		informat CNTY_COND_ENDING_BAL $varying22.;
		informat CNTY_CSGD_PROD_VOL $varying22.;
		informat CNTY_CSGD_LIMIT $varying22.;
		informat CNTY_CSGD_GAS_LIFT $varying22.;
		informat CNTY_OIL_TOT_DISP $varying22.;
		informat CNTY_GAS_TOT_DISP $varying22.;
		informat CNTY_COND_TOT_DISP $varying22.;
		informat CNTY_CSGD_TOT_DISP $varying22.;
		informat COUNTY_NAME $varying50.;
		informat DISTRICT_NAME $varying50.;
		informat OIL_GAS_CODE $varying1.;
	INPUT
		COUNTY_NO $
		DISTRICT_NO $
		CYCLE_YEAR $
		CYCLE_MONTH $
		CYCLE_YEAR_MONTH $
		CNTY_OIL_PROD_VOL $
		CNTY_OIL_ALLOW $
		CNTY_OIL_ENDING_BAL $
		CNTY_GAS_PROD_VOL $
		CNTY_GAS_ALLOW $
		CNTY_GAS_LIFT_INJ_VOL $
		CNTY_COND_PROD_VOL $
		CNTY_COND_LIMIT $
		CNTY_COND_ENDING_BAL $
		CNTY_CSGD_PROD_VOL $
		CNTY_CSGD_LIMIT $
		CNTY_CSGD_GAS_LIFT $
		CNTY_OIL_TOT_DISP $
		CNTY_GAS_TOT_DISP $
		CNTY_COND_TOT_DISP $
		CNTY_CSGD_TOT_DISP $
		COUNTY_NAME $
		DISTRICT_NAME $
		OIL_GAS_CODE $
	;
RUN;	
PROC EXPORT
	DATA = postLoc.s5countyCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5countyCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG County Lease Cycle Data File							*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5countyLeaseCycle;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_COUNTY_LEASE_CYCLE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OIL_GAS_CODE $varying1.;
		informat DISTRICT_NO $varying2.;
		informat LEASE_NO $varying6.;
		informat CYCLE_YEAR $varying4.;
		informat CYCLE_MONTH $varying2.;
		informat COUNTY_NO $varying3.;
		informat OPERATOR_NO $varying6.;
		informat FIELD_NO $varying6.;
		informat CYCLE_YEAR_MONTH $varying2.;
		informat FIELD_TYPE $varying2.;
		informat GAS_WELL_NO $varying6.;
		informat PROD_REPORT_FILED_FLAG $varying1.;
		informat CNTY_LSE_OIL_PROD_VOL $varying9.;
		informat CNTY_LSE_OIL_ALLOW $varying9.;
		informat CNTY_LSE_OIL_ENDING_BAL $varying9.;
		informat CNTY_LSE_GAS_PROD_VOL $varying9.;
		informat CNTY_LSE_GAS_ALLW $varying9.;
		informat CNTY_LSE_GAS_LIFT_INJ_VOL $varying9.;
		informat CNTY_LSE_COND_PROD_VOL $varying9.;
		informat CNTY_LSE_COND_LIMIT $varying9.;
		informat CNTY_LSE_COND_ENDING_BAL $varying9.;
		informat CNTY_LSE_CSGD_PROD_VOL $varying9.;
		informat CNTY_LSE_CSGD_LIMIT $varying9.;
		informat CNTY_LSE_CSGD_GAS_LIFT $varying9.;
		informat CNTY_LSE_OIL_TOT_DISP $varying9.;
		informat CNTY_LSE_GAS_TOT_DISP $varying9.;
		informat CNTY_LSE_COND_TOT_DISP $varying9.;
		informat CNTY_LSE_CSGD_TOT_DISP $varying9.;
		informat DISTRICT_NAME $varying2.;
		informat LEASE_NAME $varying50.;
		informat OPERATOR_NAME $varying50.;
		informat FIELD_NAME $varying50.;
		informat COUNTY_NAME $varying50.;
	INPUT
		OIL_GAS_CODE $
		DISTRICT_NO $
		LEASE_NO $
		CYCLE_YEAR $
		CYCLE_MONTH $
		COUNTY_NO $
		OPERATOR_NO $
		FIELD_NO $
		CYCLE_YEAR_MONTH $
		FIELD_TYPE $
		GAS_WELL_NO $
		PROD_REPORT_FILED_FLAG $
		CNTY_LSE_OIL_PROD_VOL $
		CNTY_LSE_OIL_ALLOW $
		CNTY_LSE_OIL_ENDING_BAL $
		CNTY_LSE_GAS_PROD_VOL $
		CNTY_LSE_GAS_ALLW $
		CNTY_LSE_GAS_LIFT_INJ_VOL $
		CNTY_LSE_COND_PROD_VOL $
		CNTY_LSE_COND_LIMIT $
		CNTY_LSE_COND_ENDING_BAL $
		CNTY_LSE_CSGD_PROD_VOL $
		CNTY_LSE_CSGD_LIMIT $
		CNTY_LSE_CSGD_GAS_LIFT $
		CNTY_LSE_OIL_TOT_DISP $
		CNTY_LSE_GAS_TOT_DISP $
		CNTY_LSE_COND_TOT_DISP $
		CNTY_LSE_CSGD_TOT_DISP $
		DISTRICT_NAME $
		LEASE_NAME $
		OPERATOR_NAME $
		FIELD_NAME $
		COUNTY_NAME $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5countyLeaseCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5countyLeaseCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG District Cycle Data File								*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5districtCycle;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_DISTRICT_CYCLE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat DISTRICT_NO $varying2.;
		informat CYCLE_YEAR $varying4.;
		informat CYCLE_MONTH $varying2.;
		informat CYCLE_YEAR_MONTH $varying6.;
		informat DISTRICT_NAME $varying2.;
		informat DIST_OIL_PROD_VOL $varying22.;
		informat DIST_GAS_PROD_VOL $varying22.;
		informat DIST_COND_PROD_VOL $varying22.;
		informat DIST_CSGD_PROD_VOL $varying22.;
	INPUT
		DISTRICT_NO $
		CYCLE_YEAR $
		CYCLE_MONTH $
		CYCLE_YEAR_MONTH $
		DISTRICT_NAME $
		DIST_OIL_PROD_VOL $
		DIST_GAS_PROD_VOL $
		DIST_COND_PROD_VOL $
		DIST_CSGD_PROD_VOL $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5districtCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5districtCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Field Cycle Data File									*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5fieldCycle;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_FIELD_CYCLE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat DISTRICT_NO $varying2.;
		informat FIELD NO $varying8.;
		informat CYCLE_YEAR $varying4.;
		informat CYCLE_MONTH $varying2.;
		informat CYCLE_YEAR_MONTH $varying6.;
		informat DISTRICT_NAME $varying2.;
		informat FIELD_NAME $varying32.;
		informat FIELD_OIL_PROD_VOL $varying22.;
		informat FIELD_GAS_PROD_VOL $varying22.;
		informat FIELD_COND_PROD_VOL $varying22.;
		informat FIELD_CSGD_PROD_VOL $varying22.;
	INPUT
		DISTRICT_NO $
		FIELD NO $
		CYCLE_YEAR $
		CYCLE_MONTH $
		CYCLE_YEAR_MONTH $
		DISTRICT_NAME $
		FIELD_NAME $
		FIELD_OIL_PROD_VOL $
		FIELD_GAS_PROD_VOL $
		FIELD_COND_PROD_VOL $
		FIELD_CSGD_PROD_VOL $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5fieldCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5fieldCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Field DW Data File										*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5fieldDW;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_FIELD_DW_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat FIELD_NO $varying66.;
		informat FIELD_NAME $varying8.;
		informat DISTRICT_NO $varying1.;
		informat DISTRICT_NAME $varying2.;
		informat FIELD_CLASS $varying1.;
		informat FIELD_H2S_FLAG $varying1.;
		informat FIELD_MANUAL_REV_FLAG $varying32.;
		informat WILDCAT_FLAG $varying7.;
		informat O_DERIVED_RULE_TYPE_CODE $varying7.;
		informat G_DERIVED_RULE_TYPE_CODE $varying7.;
		informat O_RESCIND_DT $varying1.;
		informat G_RESCIND_DT $varying1.;
		informat O_SALT_DOME_FLAG $varying66.;
		informat G_SALT_DOME_FLAG $varying66.;
		informat O_OFFSHORE_CODE $varying7.;
		informat G_OFFSHORE_CODE $varying7.;
		informat O_DONT_PERMIT $varying200.;
		informat G_DONT_PERMIT $varying200.;
		informat O_NOA_MAN_REV_RULE $varying2.;
		informat G_NOA_MAN_REV_RULE $varying2.;
		informat O_COUNTY_NO $varying2.;
		informat G_COUNTY_NO $varying2.;
		informat O_DISCOVERY_DT $varying1.;
		informat G_DISCOVERY_DT $varying1.;
		informat O_SCHED_REMARKS $varying1.;
		informat G_SCHED_REMARKS $varying1.;
		informat O_COMMENTS $varying3.;
		informat G_COMMENTS $varying3.;
		informat CREATE_BY $varying7.;
		informat CREATE_DT $varying2.;
		informat MODIFY_BY $varying7.;
		informat MODIFY_DT $varying66.;
	INPUT
		FIELD_NO $
		FIELD_NAME $
		DISTRICT_NO $
		DISTRICT_NAME $
		FIELD_CLASS $
		FIELD_H2S_FLAG $
		FIELD_MANUAL_REV_FLAG $
		WILDCAT_FLAG $
		O_DERIVED_RULE_TYPE_CODE $
		G_DERIVED_RULE_TYPE_CODE $
		O_RESCIND_DT $
		G_RESCIND_DT $
		O_SALT_DOME_FLAG $
		G_SALT_DOME_FLAG $
		O_OFFSHORE_CODE $
		G_OFFSHORE_CODE $
		O_DONT_PERMIT $
		G_DONT_PERMIT $
		O_NOA_MAN_REV_RULE $
		G_NOA_MAN_REV_RULE $
		O_COUNTY_NO $
		G_COUNTY_NO $
		O_DISCOVERY_DT $
		G_DISCOVERY_DT $
		O_SCHED_REMARKS $
		G_SCHED_REMARKS $
		O_COMMENTS $
		G_COMMENTS $
		CREATE_BY $
		CREATE_DT $
		MODIFY_BY $
		MODIFY_DT $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5fieldDW
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5fieldDW_20160824.csv'
	REPLACE;
RUN;	
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Lease Cycle Data File									*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5leaseCycle;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_LEASE_CYCLE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OIL_GAS_CODE $varying1.;
		informat DISTRICT_NO $varying2.;
		informat LEASE_NO $varying6.;
		informat CYCLE_YEAR $varying4.;
		informat CYCLE_MONTH $varying2.;
		informat CYCLE_YEAR_MONTH $varying6.;
		informat LEASE_NO_DISTRICT_NO $varying22.;
		informat OPERATOR_NO $varying6.;
		informat FIELD_NO $varying8.;
		informat FIELD_TYPE $varying2.;
		informat GAS_WELL_NO $varying6.;
		informat PROD_REPORT_FILED_FLAG $varying1.;
		informat LEASE_OIL_PROD_VOL $varying22.;
		informat LEASE_OIL_ALLOW $varying22.;
		informat LEASE_OIL_ENDING_BAL $varying22.;
		informat LEASE_GAS_PROD_VOL $varying22.;
		informat LEASE_GAS_ALLOW $varying22.;
		informat LEASE_GAS_LIFT_INJ_VOL $varying22.;
		informat LEASE_COND_PROD_VOL $varying22.;
		informat LEASE_COND_LIMIT $varying22.;
		informat LEASE_COND_ENDING_BAL $varying22.;
		informat LEASE_CSGD_PROD_VOL $varying22.;
		informat LEASE_CSGD_LIMIT $varying22.;
		informat LEASE_CSGD_GAS_LIFT $varying22.;
		informat LEASE_OIL_TOT_DISP $varying22.;
		informat LEASE_GAS_TOT_DISP $varying22.;
		informat LEASE_COND_TOT_DISP $varying22.;
		informat LEASE_CSGD_TOT_DISP $varying22.;
		informat DISTRICT_NAME $varying2.;
		informat LEASE_NAME $varying50.;
		informat OPERATOR_NAME $varying50.;
		informat FIELD_NAME $varying32.;
	INPUT
		OIL_GAS_CODE $
		DISTRICT_NO $
		LEASE_NO $
		CYCLE_YEAR $
		CYCLE_MONTH $
		CYCLE_YEAR_MONTH $
		LEASE_NO_DISTRICT_NO $
		OPERATOR_NO $
		FIELD_NO $
		FIELD_TYPE $
		GAS_WELL_NO $
		PROD_REPORT_FILED_FLAG $
		LEASE_OIL_PROD_VOL $
		LEASE_OIL_ALLOW $
		LEASE_OIL_ENDING_BAL $
		LEASE_GAS_PROD_VOL $
		LEASE_GAS_ALLOW $
		LEASE_GAS_LIFT_INJ_VOL $
		LEASE_COND_PROD_VOL $
		LEASE_COND_LIMIT $
		LEASE_COND_ENDING_BAL $
		LEASE_CSGD_PROD_VOL $
		LEASE_CSGD_LIMIT $
		LEASE_CSGD_GAS_LIFT $
		LEASE_OIL_TOT_DISP $
		LEASE_GAS_TOT_DISP $
		LEASE_COND_TOT_DISP $
		LEASE_CSGD_TOT_DISP $
		DISTRICT_NAME $
		LEASE_NAME $
		OPERATOR_NAME $
		FIELD_NAME $
	;
RUN;	
PROC EXPORT
	DATA = postLoc.s5leaseCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5leaseCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Lease Cycle Disposal Data File							*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5leaseCycleDisp;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_LEASE_CYCLE_DISP_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OIL_GAS_CODE $varying22.;
		informat DISTRICT_NO $varying2.;
		informat LEASE_NO $varying6.;
		informat CYCLE_YEAR $varying4.;
		informat CYCLE_MONTH $varying2.;
		informat OPERATOR_NO $varying6.;
		informat FIELD_NO $varying8.;
		informat CYCLE_YEAR_MONTH $varying6.;
		informat LEASE_OIL_DISPCD00_VOL $varying22.;
		informat LEASE_OIL_DISPCD01_VOL $varying22.;
		informat LEASE_OIL_DISPCD02_VOL $varying22.;
		informat LEASE_OIL_DISPCD03_VOL $varying22.;
		informat LEASE_OIL_DISPCD04_VOL $varying22.;
		informat LEASE_OIL_DISPCD05_VOL $varying22.;
		informat LEASE_OIL_DISPCD06_VOL $varying22.;
		informat LEASE_OIL_DISPCD07_VOL $varying22.;
		informat LEASE_OIL_DISPCD08_VOL $varying22.;
		informat LEASE_OIL_DISPCD09_VOL $varying22.;
		informat LEASE_OIL_DISPCD99_VOL $varying22.;
		informat LEASE_GAS_DISPCD01_VOL $varying22.;
		informat LEASE_GAS_DISPCD02_VOL $varying22.;
		informat LEASE_GAS_DISPCD03_VOL $varying22.;
		informat LEASE_GAS_DISPCD04_VOL $varying22.;
		informat LEASE_GAS_DISPCD05_VOL $varying22.;
		informat LEASE_GAS_DISPCD06_VOL $varying22.;
		informat LEASE_GAS_DISPCD07_VOL $varying22.;
		informat LEASE_GAS_DISPCD08_VOL $varying22.;
		informat LEASE_GAS_DISPCD09_VOL $varying22.;
		informat LEASE_GAS_DISPCD99_VOL $varying22.;
		informat LEASE_COND_DISPCD00_VOL $varying22.;
		informat LEASE_COND_DISPCD01_VOL $varying22.;
		informat LEASE_COND_DISPCD02_VOL $varying22.;
		informat LEASE_COND_DISPCD03_VOL $varying22.;
		informat LEASE_COND_DISPCD04_VOL $varying22.;
		informat LEASE_COND_DISPCD05_VOL $varying22.;
		informat LEASE_COND_DISPCD06_VOL $varying22.;
		informat LEASE_COND_DISPCD07_VOL $varying22.;
		informat LEASE_COND_DISPCD08_VOL $varying22.;
		informat LEASE_COND_DISPCD99_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE01_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE02_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE03_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE04_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE05_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE06_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE07_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE08_VOL $varying22.;
		informat LEASE_CSGD_DISPCDE99_VOL $varying22.;
		informat DISTRICT_NAME $varying2.;
		informat FIELD_NAME $varying32.;
		informat OPERATOR_NAME $varying50.;
	INPUT
		OIL_GAS_CODE $
		DISTRICT_NO $
		LEASE_NO $
		CYCLE_YEAR $
		CYCLE_MONTH $
		OPERATOR_NO $
		FIELD_NO $
		CYCLE_YEAR_MONTH 
		LEASE_OIL_DISPCD00_VOL $
		LEASE_OIL_DISPCD01_VOL $
		LEASE_OIL_DISPCD02_VOL $
		LEASE_OIL_DISPCD03_VOL $
		LEASE_OIL_DISPCD04_VOL $
		LEASE_OIL_DISPCD05_VOL $
		LEASE_OIL_DISPCD06_VOL $
		LEASE_OIL_DISPCD07_VOL $
		LEASE_OIL_DISPCD08_VOL $
		LEASE_OIL_DISPCD09_VOL $
		LEASE_OIL_DISPCD99_VOL $
		LEASE_GAS_DISPCD01_VOL $
		LEASE_GAS_DISPCD02_VOL $
		LEASE_GAS_DISPCD03_VOL $
		LEASE_GAS_DISPCD04_VOL $
		LEASE_GAS_DISPCD05_VOL $
		LEASE_GAS_DISPCD06_VOL $
		LEASE_GAS_DISPCD07_VOL $
		LEASE_GAS_DISPCD08_VOL $
		LEASE_GAS_DISPCD09_VOL $
		LEASE_GAS_DISPCD99_VOL $
		LEASE_COND_DISPCD00_VOL $
		LEASE_COND_DISPCD01_VOL $
		LEASE_COND_DISPCD02_VOL $
		LEASE_COND_DISPCD03_VOL $
		LEASE_COND_DISPCD04_VOL $
		LEASE_COND_DISPCD05_VOL $
		LEASE_COND_DISPCD06_VOL $
		LEASE_COND_DISPCD07_VOL $
		LEASE_COND_DISPCD08_VOL $
		LEASE_COND_DISPCD99_VOL $
		LEASE_CSGD_DISPCDE01_VOL $
		LEASE_CSGD_DISPCDE02_VOL $
		LEASE_CSGD_DISPCDE03_VOL $
		LEASE_CSGD_DISPCDE04_VOL $
		LEASE_CSGD_DISPCDE05_VOL $
		LEASE_CSGD_DISPCDE06_VOL $
		LEASE_CSGD_DISPCDE07_VOL $
		LEASE_CSGD_DISPCDE08_VOL $
		LEASE_CSGD_DISPCDE99_VOL $
		DISTRICT_NAME $
		FIELD_NAME $
		OPERATOR_NAME $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5leaseCycleDisp
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5leaseCycleDisp_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Operator Cycle Data File								*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5operatorCycle;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_OPERATOR_CYCLE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OPERATOR_NO $varying6.;
		informat CYCLE_YEAR $varying4.;
		informat CYCLE_MONTH $varying2.;
		informat CYCLE_YEAR_MONTH $varying6.;
		informat OPERATOR_NAME $varying50.;
		informat OPER_OIL_PROD_VOL $varying22.;
		informat OPER_GAS_PROD_VOL $varying22.;
		informat OPER_COND_PROD_VOL $varying22.;
		informat OPER_CSGD_PROD_VOL $varying22.;
	INPUT
		OPERATOR_NO $
		CYCLE_YEAR $
		CYCLE_MONTH $
		CYCLE_YEAR_MONTH $
		OPERATOR_NAME $
		OPER_OIL_PROD_VOL $
		OPER_GAS_PROD_VOL $
		OPER_COND_PROD_VOL $
		OPER_CSGD_PROD_VOL $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5operatorCycle
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5operatorCycle_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Operator DW Data File									*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5operatorDW;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_OPERATOR_DW_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OPERATOR_NO $varying6.;
		informat OPERATOR_NAME $varying50.;
		informat P5_STATUS_CODE $varying4.;
		informat P5_LAST_FILED_DT $varying8.;
		informat OPERATOR_TAX_CERT_FLAG $varying1.;
		informat OPERATOR_SB639_FLAG $varying1.;
		informat FA_OPTION_CODE $varying2.;
		informat RECORD_STATUS_CODE $varying1.;
		informat EFILE_STATUS_CODE $varying4.;
		informat EFILE_EFFECTIVE_DT $varying7.;
		informat CREATE_BY $varying30.;
		informat CREATE_DT $varying7.;
		informat MODIFY_BY $varying30.;
		informat MODIFY_DT $varying7.;
	INPUT
		OPERATOR_NO $
		OPERATOR_NAME $
		P5_STATUS_CODE $
		P5_LAST_FILED_DT $
		OPERATOR_TAX_CERT_FLAG $
		OPERATOR_SB639_FLAG $
		FA_OPTION_CODE $
		RECORD_STATUS_CODE $
		EFILE_STATUS_CODE $
		EFILE_EFFECTIVE_DT $
		CREATE_BY $
		CREATE_DT $
		MODIFY_BY $
		MODIFY_DT $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5operatorDW
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5operatorDW_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Regulatory Lease DW Data File							*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5regulatoryLeaseDW;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_REGULATORY_LEASE_DW_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OIL_GAS_CODE $varying1.;
		informat DISTRICT_NO $varying2.;
		informat LEASE_NO $varying6.;
		informat DISTRICT_NAME $varying2.;
		informat LEASE_NAME $varying50.;
		informat OPERATOR_NO $varying6.;
		informat OPERATOR_NAME $varying50.;
		informat FIELD_NO $varying8.;
		informat FIELD_NAME $varying32.;
		informat WELL_NO $varying6.;
		informat LEASE_OFF_SCHED_FLAG $varying1.;
		informat LEASE_SEVERANCE_FLAG $varying1.;
	INPUT
		OIL_GAS_CODE $
		DISTRICT_NO $
		LEASE_NO $
		DISTRICT_NAME $
		LEASE_NAME $
		OPERATOR_NO $
		OPERATOR_NAME $
		FIELD_NO $
		FIELD_NAME $
		WELL_NO $
		LEASE_OFF_SCHED_FLAG $
		LEASE_SEVERANCE_FLAG $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5regulatoryLeaseDW
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5regulatoryLeaseDW_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Summary Master Large Data File							*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5summaryMasterLarge;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_SUMMARY_MASTER_LARGE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OIL_GAS_CODE $varying1.;
		informat DISTRICT_NO $varying2.;
		informat LEASE_NO $varying6.;
		informat OPERATOR_NO $varying6.;
		informat FIELD_NO $varying8.;
		informat CYCLE_YEAR_MONTH_MIN $varying22.;
		informat CYCLE_YEAR_MONTH_MAX $varying22.;
		informat DISTRICT_NAME $varying2.;
		informat LEASE_NAME $varying50.;
		informat OPERATOR_NAME $varying50.;
		informat FIELD_NAME $varying32.;
	INPUT
		OIL_GAS_CODE $
		DISTRICT_NO $
		LEASE_NO $
		OPERATOR_NO $
		FIELD_NO $
		CYCLE_YEAR_MONTH_MIN $
		CYCLE_YEAR_MONTH_MAX $
		DISTRICT_NAME $
		LEASE_NAME $
		OPERATOR_NAME $
		FIELD_NAME $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5summaryMasterLarge
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5summaryMasterLarge_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Summary Onshore Lease Data File						*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5summaryOnshoreLease;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_SUMMARY_ONSHORE_LEASE_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OIL_GAS_CODE $varying1.;
		informat DISTRICT_NO $varying2.;
		informat LEASE_NO $varying6.;
		informat OPERATOR_NO $varying6.;
		informat FIELD_NO $varying8.;
		informat CYCLE_YEAR_MONTH_MIN $varying22.;
		informat CYCLE_YEAR_MONTH_MAX $varying22.;
		informat LEASE_NAME $varying50.;
		informat OPERATOR_NAME $varying50.;
		informat FIELD_NAME $varying32.;
	INPUT
		OIL_GAS_CODE $
		DISTRICT_NO $
		LEASE_NO $
		OPERATOR_NO $
		FIELD_NO $
		CYCLE_YEAR_MONTH_MIN $
		CYCLE_YEAR_MONTH_MAX $
		LEASE_NAME $
		OPERATOR_NAME $
		FIELD_NAME $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5summaryOnshoreLease
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5summaryOnshoreLease_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create OG Well Completion Data File								*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s5wellCompletion;
	INFILE "C:\TRRC\Original\PDQ_DSV\OG_WELL_COMPLETION_DATA_TABLE.dsv"
		DLM = '}'
		DSD
		FIRSTOBS=2
		MISSOVER
		TRUNCOVER;
		informat OIL_GAS_CODE $varying1.;
		informat DISTRICT_NO $varying2.;
		informat LEASE_NO $varying6.;
		informat WELL_NO $varying6.;
		informat API_COUNTY_CODE $varying3.;
		informat API_UNIQUE_NO $varying5.;
		informat ONSHORE_ASSC_CNTY $varying3.;
		informat DISTRICT_NAME $varying2.;
		informat COUNTY_NAME $varying50.;
		informat OIL_WELL_UNIT_NO $varying6.;
		informat WELL_ROOT_NO $varying8.;
		informat WELLBORE_SHUTIN_DT $varying6.;
		informat WELL_SHUTIN_DT $varying6.;
		informat WELL_14B2_STATUS_CODE $varying1.;
		informat WELL_SUBJECT_14B2_FLAG $varying1.;
		informat WELLBORE_LOCATION_CODE $varying1.;
	INPUT
		OIL_GAS_CODE $
		DISTRICT_NO $
		LEASE_NO $
		WELL_NO $
		API_COUNTY_CODE $
		API_UNIQUE_NO $
		ONSHORE_ASSC_CNTY $
		DISTRICT_NAME $
		COUNTY_NAME $
		OIL_WELL_UNIT_NO $
		WELL_ROOT_NO $
		WELLBORE_SHUTIN_DT $
		WELL_SHUTIN_DT $
		WELL_14B2_STATUS_CODE $
		WELL_SUBJECT_14B2_FLAG $
		WELLBORE_LOCATION_CODE $
	;
RUN;
PROC EXPORT
	DATA = postLoc.s5wellCompletion
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s5wellCompletion_20160824.csv'
	REPLACE;
RUN;