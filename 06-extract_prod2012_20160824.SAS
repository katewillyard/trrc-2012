/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
* program:		06-extract_prod2012_20160824.SAS;
* YOU MUST FIRST RUN 05-EXTRACT_PDQDSV_20160824.SAS FOR THIS PROGRAM TO WORK;
* task:			Create 2012 production file extracts for production large files;
* version: 		Second Draft;
* project:		EOCPC; 
* author:		Kate Willyard 8/24/2016;
/********-*********-*********-*********-*********-*********-*********/
/* Set Libraries													*/
/********-*********-*********-*********-*********-*********-*********/
LIBNAME orgLoc 'C:\TRRC\Original\PDQ_DSV';
LIBNAME postLoc 'C:\TRRC\Posted';
/********-*********-*********-*********-*********-*********-*********/
/* Create 2012 Production Extracts for s5countyleasecycle.sas		*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s6countyLeaseCycle12;
	SET postLoc.s5countyLeaseCycle;
		WHERE cycle_year = '2012';
RUN;
PROC EXPORT
	DATA = postLoc.s6countyLeaseCycle12
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s6countyLeaseCycle12_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create 2012 Production Extracts for s5leasecycle.sas				*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s6leaseCycle12;
	SET postLoc.s5leaseCycle;
		WHERE cycle_year = '2012';
RUN;
PROC EXPORT
	DATA = postLoc.s6leaseCycle12
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s6leaseCycle12_20160824.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create 2012 Production Extracts for s5leasecycledisp.sas			*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s6leaseCycleDisp12;
	SET postLoc.s5leaseCycleDisp;
		WHERE cycle_year = '2012';
RUN;
PROC EXPORT
	DATA = postLoc.s6leaseCycleDisp12
	DBMS = CSV
	LABEL
	OUTFILE = 'C:\TRRC\Posted\s6leaseCycleDisp12_20160824.csv'
	REPLACE;
RUN;