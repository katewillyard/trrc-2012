PROC PRINTTO 
LOG= 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\logFile\29-simpCom_20171102'; 
RUN; 
/********-*********-*********-*********-*********-*********-*********/
/* Description of Program											*/
/********-*********-*********-*********-*********-*********-*********/
* program:		29-simpCom_20171102.SAS ;
* task:			Import block oil and gas community crosswalk data from .txt ;
*				Create single wellop - block group file for the entire state ;
*				Collapse block group data to get data back to well level ;
*				Collapse venting and flaring data to get data to block group level
*				Output data to be uploaded into Stata for analysis ;
* version: 		First Draft;
* project:		EOCPC; 
* author:		Kate Willyard 11/2/2017;
/********-*********-*********-*********-*********-*********-*********/
/* Set Libraries													*/
/********-*********-*********-*********-*********-*********-*********/
LIBNAME postLoc 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted';
LIBNAME workLoc 'D:\Dropbox\Academic\Active\Research\EOCPC\Working';
/********-*********-*********-*********-*********-*********-*********/
/* Import oilBlocks1mi data from .txt								*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.oilCom (KEEP = geoid wellop);
		INFILE 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\oilBlocks1mi.txt' 
		DELIMITER = ','
		MISSOVER 
		DSD 
		LRECL = 32767 
		FIRSTOBS = 2 ;
		INFORMAT objectid $32. ;
		INFORMAT fidb $32. ;
		INFORMAT geoid $15. ;
		INFORMAT fido $32. ;
		INFORMAT wellop $23.;		
		INFORMAT shapeLength $32. ;
		INFORMAT shapeArea $32. ;
		FORMAT objectid $32. ;
		FORMAT fidb $32. ;
		FORMAT geoid $15. ;
		FORMAT fido $32. ;
		FORMAT wellop $23. ;
		FORMAT shapeLength $32. ;
		FORMAT shapeArea $32. ;		
		INPUT
			objectid $
			fidb $
			geoid $
			fido $
			wellop $
			shapeLength $
			shapeArea $ ;
RUN ;
/********-*********-*********-*********-*********-*********-*********/
/* Import gasBlocks1mi data from .txt								*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.gasCom (KEEP = geoid wellop);
		INFILE 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\gasBlocks1mi.txt' 
		DELIMITER = ','
		MISSOVER 
		DSD 
		LRECL = 32767 
		FIRSTOBS = 2 ;
		INFORMAT objectid $32. ;
		INFORMAT fidb $32. ;
		INFORMAT geoid $15. ;
		INFORMAT fido $32. ;
		INFORMAT wellop $23. ;
		INFORMAT shapeLength $32. ;
		INFORMAT shapeArea $32. ;
		FORMAT objectid $32. ;
		FORMAT fidb $32. ;
		FORMAT geoid $15. ;
		FORMAT fido $32. ;
		FORMAT wellop $23. ;
		FORMAT shapeLength $32. ;
		FORMAT shapeArea $32. ;		
		INPUT
			objectid $
			fidb $
			geoid $
			fido $
			wellop $
			shapeLength $
			shapeArea $ ;
RUN ;
/********-*********-*********-*********-*********-*********-*********/
/* Create sorted wellop-blockgroup oil files						*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.oilComBg ;
	SET workLoc.oilCom;
	bgGeoid = substr(geoid, 1, 12);
RUN;
PROC SORT 
	NODUPKEY
	DATA = workLoc.oilComBg;
	BY bgGeoid wellop;
RUN;
DATA workLoc.oilComBgSortGeoid (DROP = bgGeoid);
	SET workLoc.oilComBg (DROP = geoid);
	geoid = bgGeoid;
RUN;
PROC SORT 
	DATA = workLoc.oilComBgSortGeoid;
	BY geoid;
RUN;
DATA workLoc.oilComBgSortWellop (DROP = bgGeoid);
	SET workLoc.oilComBg (DROP = geoid);
	geoid = bgGeoid;
RUN;
PROC SORT 
	DATA = workLoc.oilComBgSortWellop;
	BY wellop ;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create sorted wellop-blockgroup gas files						*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.gasComBg ;
	SET workLoc.gasCom;
	bgGeoid = substr(geoid, 1, 12);
RUN;
PROC SORT 
	NODUPKEY
	DATA = workLoc.gasComBg;
	BY bgGeoid wellop;
RUN;
DATA workLoc.gasComBgSortGeoid (DROP = bgGeoid);
	SET workLoc.gasComBg (DROP = geoid);
	geoid = bgGeoid ;
RUN;
PROC SORT 
	DATA = workLoc.gasComBgSortGeoid ;
	BY geoid;
RUN;

DATA workLoc.gasComBgSortWellop (DROP = bgGeoid);
	SET workLoc.gasComBg (DROP = geoid);
	geoid = bgGeoid ;
RUN;
PROC SORT 
	DATA = workLoc.gasComBgSortWellop ;
	BY wellop;
RUN;

/********-*********-*********-*********-*********-*********-*********/
/* Import and sort ACS data											*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.acs (DROP = objectid shape_length shape_area);
		INFILE 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\28-acsSimp_20170508.txt' 
		DELIMITER = ','
		MISSOVER 
		DSD 
		LRECL = 32767 
		FIRSTOBS = 2 ;
		INFORMAT objectid $32. ;
		INFORMAT geoid $12. ;
		INFORMAT aland best32. ;
		INFORMAT emp_pop best32. ;
		INFORMAT emp_unemployed_sum best32. ;
		INFORMAT emp_unemployed_per best32. ;
		INFORMAT age_pop best32. ;
		INFORMAT age_old_sum best32. ;
		INFORMAT age_old_per best32. ;
		INFORMAT educ_pop  best32. ;
		INFORMAT educ_nodiploma_sum  best32. ;
		INFORMAT educ_nodiploma_per best32. ;
		INFORMAT race_pop best32. ;
		INFORMAT race_white_sum best32. ;
		INFORMAT race_black_sum best32. ;
		INFORMAT race_hisp_sum best32. ;
		INFORMAT race_white_per best32. ;
		INFORMAT race_black_per best32. ;
		INFORMAT race_hisp_per best32. ;
		INFORMAT fluency_pop best32. ;
		INFORMAT fluency_limenglish_sum best32. ;
		INFORMAT fluency_limenglish_per best32. ;
		INFORMAT oohu_less10K_sum best32. ;
		INFORMAT oohu_10Kto14999_sum best32. ;
		INFORMAT oohu_15Kto19999_sum best32. ;
		INFORMAT oohu_20Kto24999_sum best32. ;
		INFORMAT oohu_25Kto29999_sum best32. ;
		INFORMAT oohu_30Kto34999_sum best32. ;
		INFORMAT oohu_35Kto39999_sum best32. ;
		INFORMAT oohu_40Kto49999_sum best32. ;
		INFORMAT oohu_50Kto59999_sum best32. ;
		INFORMAT oohu_60Kto69999_sum best32. ;
		INFORMAT oohu_70Kto79999_sum best32. ;
		INFORMAT oohu_80Kto89999_sum best32. ;
		INFORMAT oohu_90Kto99999_sum best32. ;
		INFORMAT oohu_100Kto124999_sum best32. ;
		INFORMAT oohu_125Kto149999_sum best32. ;
		INFORMAT oohu_150Kto174999_sum best32. ;
		INFORMAT oohu_175Kto199999_sum best32. ;
		INFORMAT oohu_200Kto249999_sum best32. ;
		INFORMAT oohu_250Kto299999_sum best32. ;
		INFORMAT oohu_300Kto399999_sum best32. ;
		INFORMAT oohu_400Kto499999_sum best32. ;
		INFORMAT oohu_500Kto749999_sum best32. ;
		INFORMAT oohu_750Kto999999_sum best32. ;
		INFORMAT oohu_1MMore_sum best32. ;
		INFORMAT oohu_median best32. ;
		INFORMAT inc_pop_sum best32. ;
		INFORMAT inc_less10K_sum best32. ;
		INFORMAT inc_10Kto14999_sum best32. ;
		INFORMAT inc_15Kto19999_sum best32. ;
		INFORMAT inc_20Kto24999_sum best32. ;
		INFORMAT inc_25Kto29999_sum best32. ;
		INFORMAT inc_30Kto34999_sum best32. ;
		INFORMAT inc_35Kto39999_sum best32. ;
		INFORMAT inc_40Kto44999_sum best32. ;
		INFORMAT inc_45Kto49999_sum best32. ;
		INFORMAT inc_50Kto59999_sum best32. ;
		INFORMAT inc_60Kto74999_sum best32. ;
		INFORMAT inc_75Kto99999_sum best32. ;
		INFORMAT inc_100Kto124999_sum best32. ;
		INFORMAT inc_125Kto149999_sum best32. ;
		INFORMAT inc_150Kto199999_sum best32. ;
		INFORMAT inc_more200K_sum best32. ;
		INFORMAT inc_median	best32. ;
		INFORMAT occ_pop best32. ;
		INFORMAT occ_ce_sum best32. ;
		INFORMAT occ_ce_per best32. ;
		INFORMAT pov_pop best32. ;
		INFORMAT pov_belowpovertyline_sum best32. ;
		INFORMAT pov_belowpovertyline_per best32. ;
		INFORMAT shape_length best32. ;
		INFORMAT shape_area best32. ;
		FORMAT objectid $32. ;
		FORMAT geoid $15. ;
		FORMAT aland best32. ;
		FORMAT emp_pop best32. ;
		FORMAT emp_unemployed_sum best32. ;
		FORMAT emp_unemployed_per best32. ;
		FORMAT age_pop best32. ;
		FORMAT age_old_sum best32. ;
		FORMAT age_old_per best32. ;
		FORMAT educ_pop  best32. ;
		FORMAT educ_nodiploma_sum  best32. ;
		FORMAT educ_nodiploma_per best32. ;
		FORMAT race_pop best32. ;
		FORMAT race_white_sum best32. ;
		FORMAT race_black_sum best32. ;
		FORMAT race_hisp_sum best32. ;
		FORMAT race_white_per best32. ;
		FORMAT race_black_per best32. ;
		FORMAT race_hisp_per best32. ;
		FORMAT fluency_pop best32. ;
		FORMAT fluency_limenglish_sum best32. ;
		FORMAT fluency_limenglish_per best32. ;
		FORMAT oohu_less10K_sum best32. ;
		FORMAT oohu_10Kto14999_sum best32. ;
		FORMAT oohu_15Kto19999_sum best32. ;
		FORMAT oohu_20Kto24999_sum best32. ;
		FORMAT oohu_25Kto29999_sum best32. ;
		FORMAT oohu_30Kto34999_sum best32. ;
		FORMAT oohu_35Kto39999_sum best32. ;
		FORMAT oohu_40Kto49999_sum best32. ;
		FORMAT oohu_50Kto59999_sum best32. ;
		FORMAT oohu_60Kto69999_sum best32. ;
		FORMAT oohu_70Kto79999_sum best32. ;
		FORMAT oohu_80Kto89999_sum best32. ;
		FORMAT oohu_90Kto99999_sum best32. ;
		FORMAT oohu_100Kto124999_sum best32. ;
		FORMAT oohu_125Kto149999_sum best32. ;
		FORMAT oohu_150Kto174999_sum best32. ;
		FORMAT oohu_175Kto199999_sum best32. ;
		FORMAT oohu_200Kto249999_sum best32. ;
		FORMAT oohu_250Kto299999_sum best32. ;
		FORMAT oohu_300Kto399999_sum best32. ;
		FORMAT oohu_400Kto499999_sum best32. ;
		FORMAT oohu_500Kto749999_sum best32. ;
		FORMAT oohu_750Kto999999_sum best32. ;
		FORMAT oohu_1MMore_sum best32. ;
		FORMAT oohu_median best32. ;
		FORMAT inc_pop_sum best32. ;
		FORMAT inc_less10K_sum best32. ;
		FORMAT inc_10Kto14999_sum best32. ;
		FORMAT inc_15Kto19999_sum best32. ;
		FORMAT inc_20Kto24999_sum best32. ;
		FORMAT inc_25Kto29999_sum best32. ;
		FORMAT inc_30Kto34999_sum best32. ;
		FORMAT inc_35Kto39999_sum best32. ;
		FORMAT inc_40Kto44999_sum best32. ;
		FORMAT inc_45Kto49999_sum best32. ;
		FORMAT inc_50Kto59999_sum best32. ;
		FORMAT inc_60Kto74999_sum best32. ;
		FORMAT inc_75Kto99999_sum best32. ;
		FORMAT inc_100Kto124999_sum best32. ;
		FORMAT inc_125Kto149999_sum best32. ;
		FORMAT inc_150Kto199999_sum best32. ;
		FORMAT inc_more200K_sum best32. ;
		FORMAT inc_median	best32. ;
		FORMAT occ_pop best32. ;
		FORMAT occ_ce_sum best32. ;
		FORMAT occ_ce_per best32. ;
		FORMAT pov_pop best32. ;
		FORMAT pov_belowpovertyline_sum best32. ;
		FORMAT pov_belowpovertyline_per best32. ;
		FORMAT shape_length best32. ;
		FORMAT shape_area best32. ;
		INPUT
			objectid $
			geoid $ 
			aland  
			emp_pop  
			emp_unemployed_sum  
			emp_unemployed_per  
			age_pop  
			age_old_sum  
			age_old_per  
			educ_pop   
			educ_nodiploma_sum   
			educ_nodiploma_per  
			race_pop  
			race_white_sum  
			race_black_sum  
			race_hisp_sum  
			race_white_per  
			race_black_per  
			race_hisp_per  
			fluency_pop  
			fluency_limenglish_sum  
			fluency_limenglish_per  
			oohu_less10K_sum  
			oohu_10Kto14999_sum  
			oohu_15Kto19999_sum  
			oohu_20Kto24999_sum  
			oohu_25Kto29999_sum  
			oohu_30Kto34999_sum  
			oohu_35Kto39999_sum  
			oohu_40Kto49999_sum  
			oohu_50Kto59999_sum  
			oohu_60Kto69999_sum  
			oohu_70Kto79999_sum  
			oohu_80Kto89999_sum  
			oohu_90Kto99999_sum  
			oohu_100Kto124999_sum  
			oohu_125Kto149999_sum  
			oohu_150Kto174999_sum  
			oohu_175Kto199999_sum  
			oohu_200Kto249999_sum  
			oohu_250Kto299999_sum  
			oohu_300Kto399999_sum  
			oohu_400Kto499999_sum  
			oohu_500Kto749999_sum  
			oohu_750Kto999999_sum  
			oohu_1MMore_sum  
			oohu_median  
			inc_pop_sum  
			inc_less10K_sum  
			inc_10Kto14999_sum  
			inc_15Kto19999_sum  
			inc_20Kto24999_sum  
			inc_25Kto29999_sum  
			inc_30Kto34999_sum  
			inc_35Kto39999_sum  
			inc_40Kto44999_sum  
			inc_45Kto49999_sum  
			inc_50Kto59999_sum  
			inc_60Kto74999_sum  
			inc_75Kto99999_sum  
			inc_100Kto124999_sum  
			inc_125Kto149999_sum  
			inc_150Kto199999_sum
			inc_more200K_sum  
			inc_median	 
			occ_pop  
			occ_ce_sum  
			occ_ce_per  
			pov_pop  
			pov_belowpovertyline_sum  
			pov_belowpovertyline_per  
			shape_length  
			shape_area  ;
RUN ;
PROC SORT 
	NODUPKEY
	DATA = workLoc.acs;
	BY geoid;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Import and sort oil production and disposition data				*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.oilVFwellLvl 
	(KEEP = 
		operator_no  operatorName operatorOrgCode 
		operatorOrgTypeComment operatorMailAddress1 
		operatorMailAddress2 operatorMailCity operatorMailState 
		operatorMailZip  operatorMailZipSuf operatorLocAddress1 
		operatorLocAddress2 operatorLocCity operatorLocState 
		operatorLocZip operatorLocZipSuf  operatorDateFirstFiled  
		operatorPhone  operatorTaxCert operatorEmergencyPhone 
		operatorType lease_gas_dispcd04_vol  lease_csgd_dispcde04_vol 
		lease_oil_prod_vol lease_gas_prod_vol lease_cond_prod_vol 
		lease_csgd_prod_vol wellop oil_gas_code district_no lease_no 
		cycle_year field_no district_name field_name lease_name 
		compl_year_code completion_date well_depth freshWaterWell 
		estimatedPlugCost orphanWell milesNearTown wellDepth  
		spudDate horizontalWell completionYear 
	);
	INFILE 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\21-oil_20170115.csv' 
	DELIMITER = ','
	MISSOVER 
	DSD 
	LRECL = 32767 
	FIRSTOBS = 2 ;
	INFORMAT operator_no best32. ;
	INFORMAT operatorName $34. ;
	INFORMAT operatorRefilingFlag $1. ;
	INFORMAT operatorP5status $1. ;
	INFORMAT operatorMailHold $1. ;
	INFORMAT operatorRenewalCode $1. ;
	INFORMAT operatorOrgCode $1. ;
	INFORMAT operatorOrgTypeComment $1. ;
	INFORMAT operatorGathererCode $5. ;
	INFORMAT operatorMailAddress1 $26. ;
	INFORMAT operatorMailAddress2 $27. ;
	INFORMAT operatorMailCity $10. ;
	INFORMAT operatorMailState $2. ;
	INFORMAT operatorMailZip best32. ;
	INFORMAT operatorMailZipSuf best32. ;
	INFORMAT operatorLocAddress1 $30. ;
	INFORMAT operatorLocAddress2 $27. ;
	INFORMAT operatorLocCity $13. ;
	INFORMAT operatorLocState $2. ;
	INFORMAT operatorLocZip best32. ;
	INFORMAT operatorLocZipSuf best32. ;
	INFORMAT operatorDateFirstFiled best32. ;
	INFORMAT operatorDateInactive best32. ;
	INFORMAT operatorPhone best32. ;
	INFORMAT operatorMonthRefile best32. ;
	INFORMAT opRefileLetDate best32. ;
	INFORMAT opRefileNotDate best32. ;
	INFORMAT refileRecDate best32. ;
	INFORMAT lastRefileRecDate best32. ;
	INFORMAT operatorOtherNo best32. ;
	INFORMAT filingProblemDate best32. ;
	INFORMAT filingProblemCode $1. ;
	INFORMAT operatorPhoneVerified $1. ;
	INFORMAT opNoMultiUseFlag $1. ;
	INFORMAT oilGathStatus $1. ;
	INFORMAT gasGathStatus $1. ;
	INFORMAT operatorTaxCert $1. ;
	INFORMAT operatorEmergencyPhone best32. ;
	INFORMAT id best32. ;
	INFORMAT operatorType $31. ;
	INFORMAT lease_oil_dispcd00_vol best32. ;
	INFORMAT lease_oil_dispcd01_vol best32. ;
	INFORMAT lease_oil_dispcd02_vol best32. ;
	INFORMAT lease_oil_dispcd03_vol best32. ;
	INFORMAT lease_oil_dispcd04_vol best32. ;
	INFORMAT lease_oil_dispcd05_vol best32. ;
	INFORMAT lease_oil_dispcd06_vol best32. ;
	INFORMAT lease_oil_dispcd07_vol best32. ;
	INFORMAT lease_oil_dispcd08_vol best32. ;
	INFORMAT lease_oil_dispcd09_vol best32. ;
	INFORMAT lease_oil_dispcd99_vol best32. ;
	INFORMAT lease_gas_dispcd01_vol best32. ;
	INFORMAT lease_gas_dispcd02_vol best32. ;
	INFORMAT lease_gas_dispcd03_vol best32. ;
	INFORMAT lease_gas_dispcd04_vol best32. ;
	INFORMAT lease_gas_dispcd05_vol best32. ;
	INFORMAT lease_gas_dispcd06_vol best32. ;
	INFORMAT lease_gas_dispcd07_vol best32. ;
	INFORMAT lease_gas_dispcd08_vol best32. ;
	INFORMAT lease_gas_dispcd09_vol best32. ;
	INFORMAT lease_gas_dispcd99_vol best32. ;
	INFORMAT lease_cond_dispcd00_vol best32. ;
	INFORMAT lease_cond_dispcd01_vol best32. ;
	INFORMAT lease_cond_dispcd02_vol best32. ;
	INFORMAT lease_cond_dispcd03_vol best32. ;
	INFORMAT lease_cond_dispcd04_vol best32. ;
	INFORMAT lease_cond_dispcd05_vol best32. ;
	INFORMAT lease_cond_dispcd06_vol best32. ;
	INFORMAT lease_cond_dispcd07_vol best32. ;
	INFORMAT lease_cond_dispcd08_vol best32. ;
	INFORMAT lease_cond_dispcd99_vol best32. ;
	INFORMAT lease_csgd_dispcde01_vol best32. ;
	INFORMAT lease_csgd_dispcde02_vol best32. ;
	INFORMAT lease_csgd_dispcde03_vol best32. ;
	INFORMAT lease_csgd_dispcde04_vol best32. ;
	INFORMAT lease_csgd_dispcde05_vol best32. ;
	INFORMAT lease_csgd_dispcde06_vol best32. ;
	INFORMAT lease_csgd_dispcde07_vol best32. ;
	INFORMAT lease_csgd_dispcde08_vol best32. ;
	INFORMAT lease_csgd_dispcde99_vol best32. ;
	INFORMAT lease_oil_prod_vol best32. ;
	INFORMAT lease_oil_allow best32. ;
	INFORMAT lease_oil_ending_bal best32. ;
	INFORMAT lease_gas_prod_vol best32. ;
	INFORMAT lease_gas_allow best32. ;
	INFORMAT lease_gas_lift_inj_vol best32. ;
	INFORMAT lease_cond_prod_vol best32. ;
	INFORMAT lease_cond_limit best32. ;
	INFORMAT lease_cond_ending_bal best32. ;
	INFORMAT lease_csgd_prod_vol best32. ;
	INFORMAT lease_csgd_limit best32. ;
	INFORMAT lease_csgd_gas_lift best32. ;
	INFORMAT lease_oil_tot_disp best32. ;
	INFORMAT lease_gas_tot_disp best32. ;
	INFORMAT lease_cond_tot_disp best32. ;
	INFORMAT lease_csgd_tot_disp best32. ;
	INFORMAT wellmonthsDisp best32. ;
	INFORMAT wellOPmonthsDisp best32. ;
	INFORMAT wellop $23. ;
	INFORMAT oil_gas_code $1. ;
	INFORMAT district_no best32. ;
	INFORMAT lease_no best32. ;
	INFORMAT cycle_year best32. ;
	INFORMAT field_no best32. ;
	INFORMAT district_name $32. ;
	INFORMAT field_name $22. ;
	INFORMAT operator_name $34. ;
	INFORMAT wellID $15. ;
	INFORMAT changeOPdisp best32. ;
	INFORMAT nOPchangesDisp best32. ;
	INFORMAT lease_no_district_no best32. ;
	INFORMAT  gas_well_no $1. ;
	INFORMAT lease_name $22. ;
	INFORMAT fieldNameMismatch $1. ;
	INFORMAT fieldNoMismatch $1. ;
	INFORMAT repID $1. ;
	INFORMAT noDispReported best32. ;
	INFORMAT noProdReported best32. ;
	INFORMAT calDispTotalOil best32. ;
	INFORMAT difPDdispTotalOil best32. ;
	INFORMAT difOilProdDisp best32. ;
	INFORMAT difOilPtotDtot best32. ;
	INFORMAT disposeMoreProdOil best32. ;
	INFORMAT calDispTotalGas best32. ;
	INFORMAT difPDdispTotalGas best32. ;
	INFORMAT difGasProdDisp best32. ;
	INFORMAT difGasPtotDtot best32. ;
	INFORMAT disposeMoreProdGas best32. ;
	INFORMAT calDispTotalCond best32. ;
	INFORMAT difPDdispTotalCond best32. ;
	INFORMAT difCondProdDisp best32. ;
	INFORMAT difCondPtotDtot best32. ;
	INFORMAT disposeMoreProdCond best32. ;
	INFORMAT  calDispTotalCsgd best32. ;
	INFORMAT difPDdispTotalCsgd best32. ;
	INFORMAT difCsgdProdDisp best32. ;
	INFORMAT difCsgdPtotDtot best32. ;
	INFORMAT disposeMoreProdCsgd best32. ;
	INFORMAT perGasFV $1. ;
	INFORMAT perCsgdFV best32. ;
	INFORMAT insMergIdLnoOno $16. ;
	INFORMAT insMergIdLnoOna $44. ;
	INFORMAT insMergIdLnaOno $32. ;
	INFORMAT insMergIdLnaOna $54. ;
	INFORMAT violation_no best32. ;
	INFORMAT segIDg $14. ;
	INFORMAT api best32. ;
	INFORMAT field_district best32. ;
	INFORMAT county_code best32. ;
	INFORMAT compl_year_code best32. ;
	INFORMAT completion_date best32. ;
	INFORMAT well_depth best32. ;
	INFORMAT fluid_lvl best32. ;
	INFORMAT informat revoked_date best32. ;
	INFORMAT denial_date best32. ;
	INFORMAT denial_type $1. ;
	INFORMAT api_change $1. ;
	INFORMAT correct_api best32. ;
	INFORMAT no_api best32. ;
	INFORMAT api_change_date best32. ;
	INFORMAT permit best32. ;
	INFORMAT permit_expired $1. ;
	INFORMAT swr13a_exception $1. ;
	INFORMAT freshWaterWell $1. ;
	INFORMAT plug $1. ;
	INFORMAT  old_api best32. ;
	INFORMAT  completion_onfile $1. ;
	INFORMAT completion_data_outsource best32. ;
	INFORMAT extensionsGranted best32. ;
	INFORMAT hb1975_certType $1. ;
	INFORMAT dateDesignationEffective best32. ;
	INFORMAT dateDesignationRevised best32. ;
	INFORMAT designationLetterDate best32. ;
	INFORMAT certDate best32. ;
	INFORMAT water_land $1. ;
	INFORMAT bondedDepth best32. ;
	INFORMAT  estimatedPlugCost best32. ;
	INFORMAT shutIn_date best32. ;
	INFORMAT plug_bond best32. ;
	INFORMAT wells_shutin $1. ;
	INFORMAT becomingActive $1. ;
	INFORMAT  orphanWell $1. ;
	INFORMAT  wbCounty best32. ;
	INFORMAT ssfNo $32. ;
	INFORMAT wbSurveyNo $18. ;
	INFORMAT blkNo $1. ;
	INFORMAT  wbSecName $1. ;
	INFORMAT webAltSec $1. ;
	INFORMAT altSSFNo $1. ;
	INFORMAT wbDistSS1 best32. ;
	INFORMAT  wbDirSS1 $2. ;
	INFORMAT wbDistSS2 best32. ;
	INFORMAT wbDirSS2 $5. ;
	INFORMAT wbLatWGS84 $10. ;
	INFORMAT  wbLongWGS84 $10. ;
	INFORMAT wbPlaneZone best32. ;
	INFORMAT eastCC $10. ;
	INFORMAT northCC $10. ;
	INFORMAT  wbLocVerified $32. ;
	INFORMAT leaseName $1. ;
	INFORMAT secBlkSrvy $1. ;
	INFORMAT milesNearTown $1. ;
	INFORMAT dirNearTown $1. ;
	INFORMAT nameNearTown $1. ;
	INFORMAT distSurveyLines $1. ;
	INFORMAT locNearWell $1. ;
	INFORMAT segID $14. ;
	INFORMAT district best32. ;
	INFORMAT well $1. ;
	INFORMAT group_unit $32. ;
	INFORMAT pi_source $1. ;
	INFORMAT rule37except_docketNo $32. ;
	INFORMAT prodStateFiled $1. ;
	INFORMAT poolAuthFiled $1. ;
	INFORMAT plugRptFile_date best32. ;
	INFORMAT segIDo $8. ;
	INFORMAT shutInYear best32. ;
	INFORMAT noWBmatch best32. ;
	INFORMAT wellDepth best32. ;
	INFORMAT spudDate best32. ;
	INFORMAT horizontalWell $1. ;
	INFORMAT longitude best32. ;
	INFORMAT latitude best32. ;
	INFORMAT noLocMatch best32. ;
	INFORMAT uid $8. ;
	INFORMAT prApiNo best32. ;
	INFORMAT district_code $32. ;
	INFORMAT well_no_display $2. ;
	INFORMAT well_type_name $9. ;
	INFORMAT lease_number best32. ;
	INFORMAT latitudedatum83 best32. ;
	INFORMAT longitudedatum83 best32. ;
	INFORMAT permitPRmatch best32. ;
	INFORMAT completionYear best32. ;
	INFORMAT prLocMatch best32. ;
	INFORMAT prAPImatch best32. ;
	INFORMAT noGIS best32. ;
	INFORMAT odfFlarePermitMatch best32. ;
	INFORMAT totalVFpermits best32. ;
	INFORMAT fvfMatch best32. ;
	INFORMAT oilUID best32. ;
	INFORMAT long83 best32. ;
	INFORMAT lat83 best32. ;
	INFORMAT apiLocMatch best32. ;
	INFORMAT nad83lat best32. ;
	INFORMAT  nad83long best32. ;
	INFORMAT no83data best32. ;
		FORMAT operator_no best32. ;
	FORMAT operatorName $34. ;
	FORMAT operatorRefilingFlag $1. ;
	FORMAT operatorP5status $1. ;
	FORMAT operatorMailHold $1. ;
	FORMAT operatorRenewalCode $1. ;
	FORMAT operatorOrgCode $1. ;
	FORMAT operatorOrgTypeComment $1. ;
	FORMAT operatorGathererCode $5. ;
	FORMAT operatorMailAddress1 $26. ;
	FORMAT operatorMailAddress2 $27. ;
	FORMAT operatorMailCity $10. ;
	FORMAT operatorMailState $2. ;
	FORMAT operatorMailZip best32. ;
	FORMAT operatorMailZipSuf best32. ;
	FORMAT operatorLocAddress1 $30. ;
	FORMAT operatorLocAddress2 $27. ;
	FORMAT operatorLocCity $13. ;
	FORMAT operatorLocState $2. ;
	FORMAT operatorLocZip best32. ;
	FORMAT operatorLocZipSuf best32. ;
	FORMAT operatorDateFirstFiled best32. ;
	FORMAT operatorDateInactive best32. ;
	FORMAT operatorPhone best32. ;
	FORMAT operatorMonthRefile best32. ;
	FORMAT opRefileLetDate best32. ;
	FORMAT opRefileNotDate best32. ;
	FORMAT refileRecDate best32. ;
	FORMAT lastRefileRecDate best32. ;
	FORMAT operatorOtherNo best32. ;
	FORMAT filingProblemDate best32. ;
	FORMAT filingProblemCode $1. ;
	FORMAT operatorPhoneVerified $1. ;
	FORMAT opNoMultiUseFlag $1. ;
	FORMAT oilGathStatus $1. ;
	FORMAT gasGathStatus $1. ;
	FORMAT operatorTaxCert $1. ;
	FORMAT operatorEmergencyPhone best32. ;
	FORMAT id best32. ;
	FORMAT operatorType $31. ;
	FORMAT lease_oil_dispcd00_vol best32. ;
	FORMAT lease_oil_dispcd01_vol best32. ;
	FORMAT lease_oil_dispcd02_vol best32. ;
	FORMAT lease_oil_dispcd03_vol best32. ;
	FORMAT lease_oil_dispcd04_vol best32. ;
	FORMAT lease_oil_dispcd05_vol best32. ;
	FORMAT lease_oil_dispcd06_vol best32. ;
	FORMAT lease_oil_dispcd07_vol best32. ;
	FORMAT lease_oil_dispcd08_vol best32. ;
	FORMAT lease_oil_dispcd09_vol best32. ;
	FORMAT lease_oil_dispcd99_vol best32. ;
	FORMAT lease_gas_dispcd01_vol best32. ;
	FORMAT lease_gas_dispcd02_vol best32. ;
	FORMAT lease_gas_dispcd03_vol best32. ;
	FORMAT lease_gas_dispcd04_vol best32. ;
	FORMAT lease_gas_dispcd05_vol best32. ;
	FORMAT lease_gas_dispcd06_vol best32. ;
	FORMAT lease_gas_dispcd07_vol best32. ;
	FORMAT lease_gas_dispcd08_vol best32. ;
	FORMAT lease_gas_dispcd09_vol best32. ;
	FORMAT lease_gas_dispcd99_vol best32. ;
	FORMAT lease_cond_dispcd00_vol best32. ;
	FORMAT lease_cond_dispcd01_vol best32. ;
	FORMAT lease_cond_dispcd02_vol best32. ;
	FORMAT lease_cond_dispcd03_vol best32. ;
	FORMAT lease_cond_dispcd04_vol best32. ;
	FORMAT lease_cond_dispcd05_vol best32. ;
	FORMAT lease_cond_dispcd06_vol best32. ;
	FORMAT lease_cond_dispcd07_vol best32. ;
	FORMAT lease_cond_dispcd08_vol best32. ;
	FORMAT lease_cond_dispcd99_vol best32. ;
	FORMAT lease_csgd_dispcde01_vol best32. ;
	FORMAT lease_csgd_dispcde02_vol best32. ;
	FORMAT lease_csgd_dispcde03_vol best32. ;
	FORMAT lease_csgd_dispcde04_vol best32. ;
	FORMAT lease_csgd_dispcde05_vol best32. ;
	FORMAT lease_csgd_dispcde06_vol best32. ;
	FORMAT lease_csgd_dispcde07_vol best32. ;
	FORMAT lease_csgd_dispcde08_vol best32. ;
	FORMAT lease_csgd_dispcde99_vol best32. ;
	FORMAT lease_oil_prod_vol best32. ;
	FORMAT lease_oil_allow best32. ;
	FORMAT lease_oil_ending_bal best32. ;
	FORMAT lease_gas_prod_vol best32. ;
	FORMAT lease_gas_allow best32. ;
	FORMAT lease_gas_lift_inj_vol best32. ;
	FORMAT lease_cond_prod_vol best32. ;
	FORMAT lease_cond_limit best32. ;
	FORMAT lease_cond_ending_bal best32. ;
	FORMAT lease_csgd_prod_vol best32. ;
	FORMAT lease_csgd_limit best32. ;
	FORMAT lease_csgd_gas_lift best32. ;
	FORMAT lease_oil_tot_disp best32. ;
	FORMAT lease_gas_tot_disp best32. ;
	FORMAT lease_cond_tot_disp best32. ;
	FORMAT lease_csgd_tot_disp best32. ;
	FORMAT wellmonthsDisp best32. ;
	FORMAT wellOPmonthsDisp best32. ;
	FORMAT wellop $23. ;
	FORMAT oil_gas_code $1. ;
	FORMAT district_no best32. ;
	FORMAT lease_no best32. ;
	FORMAT cycle_year best32. ;
	FORMAT field_no best32. ;
	FORMAT district_name $32. ;
	FORMAT field_name $22. ;
	FORMAT operator_name $34. ;
	FORMAT wellID $15. ;
	FORMAT changeOPdisp best32. ;
	FORMAT nOPchangesDisp best32. ;
	FORMAT lease_no_district_no best32. ;
	FORMAT  gas_well_no $1. ;
	FORMAT lease_name $22. ;
	FORMAT fieldNameMismatch $1. ;
	FORMAT fieldNoMismatch $1. ;
	FORMAT repID $1. ;
	FORMAT noDispReported best32. ;
	FORMAT noProdReported best32. ;
	FORMAT calDispTotalOil best32. ;
	FORMAT difPDdispTotalOil best32. ;
	FORMAT difOilProdDisp best32. ;
	FORMAT difOilPtotDtot best32. ;
	FORMAT disposeMoreProdOil best32. ;
	FORMAT calDispTotalGas best32. ;
	FORMAT difPDdispTotalGas best32. ;
	FORMAT difGasProdDisp best32. ;
	FORMAT difGasPtotDtot best32. ;
	FORMAT disposeMoreProdGas best32. ;
	FORMAT calDispTotalCond best32. ;
	FORMAT difPDdispTotalCond best32. ;
	FORMAT difCondProdDisp best32. ;
	FORMAT difCondPtotDtot best32. ;
	FORMAT disposeMoreProdCond best32. ;
	FORMAT  calDispTotalCsgd best32. ;
	FORMAT difPDdispTotalCsgd best32. ;
	FORMAT difCsgdProdDisp best32. ;
	FORMAT difCsgdPtotDtot best32. ;
	FORMAT disposeMoreProdCsgd best32. ;
	FORMAT perGasFV $1. ;
	FORMAT perCsgdFV best32. ;
	FORMAT insMergIdLnoOno $16. ;
	FORMAT insMergIdLnoOna $44. ;
	FORMAT insMergIdLnaOno $32. ;
	FORMAT insMergIdLnaOna $54. ;
	FORMAT violation_no best32. ;
	FORMAT segIDg $14. ;
	FORMAT api best32. ;
	FORMAT field_district best32. ;
	FORMAT county_code best32. ;
	FORMAT compl_year_code best32. ;
	FORMAT completion_date best32. ;
	FORMAT well_depth best32. ;
	FORMAT fluid_lvl best32. ;
	FORMAT FORMAT revoked_date best32. ;
	FORMAT denial_date best32. ;
	FORMAT denial_type $1. ;
	FORMAT api_change $1. ;
	FORMAT correct_api best32. ;
	FORMAT no_api best32. ;
	FORMAT api_change_date best32. ;
	FORMAT permit best32. ;
	FORMAT permit_expired $1. ;
	FORMAT swr13a_exception $1. ;
	FORMAT freshWaterWell $1. ;
	FORMAT plug $1. ;
	FORMAT  old_api best32. ;
	FORMAT  completion_onfile $1. ;
	FORMAT completion_data_outsource best32. ;
	FORMAT extensionsGranted best32. ;
	FORMAT hb1975_certType $1. ;
	FORMAT dateDesignationEffective best32. ;
	FORMAT dateDesignationRevised best32. ;
	FORMAT designationLetterDate best32. ;
	FORMAT certDate best32. ;
	FORMAT water_land $1. ;
	FORMAT bondedDepth best32. ;
	FORMAT  estimatedPlugCost best32. ;
	FORMAT shutIn_date best32. ;
	FORMAT plug_bond best32. ;
	FORMAT wells_shutin $1. ;
	FORMAT becomingActive $1. ;
	FORMAT  orphanWell $1. ;
	FORMAT  wbCounty best32. ;
	FORMAT ssfNo $32. ;
	FORMAT wbSurveyNo $18. ;
	FORMAT blkNo $1. ;
	FORMAT  wbSecName $1. ;
	FORMAT webAltSec $1. ;
	FORMAT altSSFNo $1. ;
	FORMAT wbDistSS1 best32. ;
	FORMAT  wbDirSS1 $2. ;
	FORMAT wbDistSS2 best32. ;
	FORMAT wbDirSS2 $5. ;
	FORMAT wbLatWGS84 $10. ;
	FORMAT  wbLongWGS84 $10. ;
	FORMAT wbPlaneZone best32. ;
	FORMAT eastCC $10. ;
	FORMAT northCC $10. ;
	FORMAT  wbLocVerified $32. ;
	FORMAT leaseName $1. ;
	FORMAT secBlkSrvy $1. ;
	FORMAT milesNearTown $1. ;
	FORMAT dirNearTown $1. ;
	FORMAT nameNearTown $1. ;
	FORMAT distSurveyLines $1. ;
	FORMAT locNearWell $1. ;
	FORMAT segID $14. ;
	FORMAT district best32. ;
	FORMAT well $1. ;
	FORMAT group_unit $32. ;
	FORMAT pi_source $1. ;
	FORMAT rule37except_docketNo $32. ;
	FORMAT prodStateFiled $1. ;
	FORMAT poolAuthFiled $1. ;
	FORMAT plugRptFile_date best32. ;
	FORMAT segIDo $8. ;
	FORMAT shutInYear best32. ;
	FORMAT noWBmatch best32. ;
	FORMAT wellDepth best32. ;
	FORMAT spudDate best32. ;
	FORMAT horizontalWell $1. ;
	FORMAT longitude best32. ;
	FORMAT latitude best32. ;
	FORMAT noLocMatch best32. ;
	FORMAT uid $8. ;
	FORMAT prApiNo best32. ;
	FORMAT district_code $32. ;
	FORMAT well_no_display $2. ;
	FORMAT well_type_name $9. ;
	FORMAT lease_number best32. ;
	FORMAT latitudedatum83 best32. ;
	FORMAT longitudedatum83 best32. ;
	FORMAT permitPRmatch best32. ;
	FORMAT completionYear best32. ;
	FORMAT prLocMatch best32. ;
	FORMAT prAPImatch best32. ;
	FORMAT noGIS best32. ;
	FORMAT odfFlarePermitMatch best32. ;
	FORMAT totalVFpermits best32. ;
	FORMAT fvfMatch best32. ;
	FORMAT oilUID best32. ;
	FORMAT long83 best32. ;
	FORMAT lat83 best32. ;
	FORMAT apiLocMatch best32. ;
	FORMAT nad83lat best32. ;
	FORMAT  nad83long best32. ;
	FORMAT no83data best32. ;
		INPUT
			operator_no
			operatorName $
			operatorRefilingFlag $
			operatorP5status $
			operatorMailHold $
			operatorRenewalCode $
			operatorOrgCode $ 
			operatorOrgTypeComment $
			operatorGathererCode $
			operatorMailAddress1 $
			operatorMailAddress2 $
			operatorMailCity $
			operatorMailState $
			operatorMailZip
			operatorMailZipSuf
			operatorLocAddress1 $
			operatorLocAddress2 $
			operatorLocCity $
			operatorLocState $
			operatorLocZip
			operatorLocZipSuf
			operatorDateFirstFiled
			operatorDateInactive
			operatorPhone
			operatorMonthRefile
			opRefileLetDate
			opRefileNotDate
			refileRecDate
			lastRefileRecDate
			operatorOtherNo
			filingProblemDate
			filingProblemCode $
			operatorPhoneVerified $
			opNoMultiUseFlag $
			oilGathStatus $
			gasGathStatus $
			operatorTaxCert $
			operatorEmergencyPhone
			id
			operatorType $
			lease_oil_dispcd00_vol
			lease_oil_dispcd01_vol
			lease_oil_dispcd02_vol
			lease_oil_dispcd03_vol
			lease_oil_dispcd04_vol
			lease_oil_dispcd05_vol
			lease_oil_dispcd06_vol
			lease_oil_dispcd07_vol
			lease_oil_dispcd08_vol
			lease_oil_dispcd09_vol
			lease_oil_dispcd99_vol
			lease_gas_dispcd01_vol
			lease_gas_dispcd02_vol
			lease_gas_dispcd03_vol
			lease_gas_dispcd04_vol
			lease_gas_dispcd05_vol
			lease_gas_dispcd06_vol
			lease_gas_dispcd07_vol
			lease_gas_dispcd08_vol
			lease_gas_dispcd09_vol
			lease_gas_dispcd99_vol
			lease_cond_dispcd00_vol
			lease_cond_dispcd01_vol
			lease_cond_dispcd02_vol
			lease_cond_dispcd03_vol
			lease_cond_dispcd04_vol
			lease_cond_dispcd05_vol
			lease_cond_dispcd06_vol
			lease_cond_dispcd07_vol
			lease_cond_dispcd08_vol
			lease_cond_dispcd99_vol
			lease_csgd_dispcde01_vol
			lease_csgd_dispcde02_vol
			lease_csgd_dispcde03_vol
			lease_csgd_dispcde04_vol
			lease_csgd_dispcde05_vol
			lease_csgd_dispcde06_vol
			lease_csgd_dispcde07_vol
			lease_csgd_dispcde08_vol
			lease_csgd_dispcde99_vol
			lease_oil_prod_vol
			lease_oil_allow
			lease_oil_ending_bal
			lease_gas_prod_vol
			lease_gas_allow
			lease_gas_lift_inj_vol
			lease_cond_prod_vol
			lease_cond_limit
			lease_cond_ending_bal
			lease_csgd_prod_vol
			lease_csgd_limit
			lease_csgd_gas_lift
			lease_oil_tot_disp
			lease_gas_tot_disp
			lease_cond_tot_disp
			lease_csgd_tot_disp
			wellmonthsDisp
			wellOPmonthsDisp
			wellop $
			oil_gas_code $
			district_no
			lease_no
			cycle_year
			field_no
			district_name $
			field_name $
			operator_name $
			wellID $
			changeOPdisp
			nOPchangesDisp
			lease_no_district_no
			gas_well_no $
			lease_name $
			fieldNameMismatch $
			fieldNoMismatch $
			repID $
			noDispReported
			noProdReported
			calDispTotalOil
			difPDdispTotalOil
			difOilProdDisp
			difOilPtotDtot
			disposeMoreProdOil
			calDispTotalGas
			difPDdispTotalGas
			difGasProdDisp
			difGasPtotDtot
			disposeMoreProdGas
			calDispTotalCond
			difPDdispTotalCond
			difCondProdDisp
			difCondPtotDtot
			disposeMoreProdCond
			calDispTotalCsgd
			difPDdispTotalCsgd
			difCsgdProdDisp
			difCsgdPtotDtot
			disposeMoreProdCsgd
			perGasFV $
			perCsgdFV
			insMergIdLnoOno $
			insMergIdLnoOna $
			insMergIdLnaOno $
			insMergIdLnaOna $
			violation_no
			segIDg $
			api
			field_district
			county_code
			compl_year_code
			completion_date
			well_depth
			fluid_lvl
			revoked_date
			denial_date
			denial_type $
			api_change $
			correct_api
			no_api
			api_change_date
			permit
			permit_expired $
			swr13a_exception $
			freshWaterWell $
			plug $
			old_api
			completion_onfile $
			completion_data_outsource
			extensionsGranted
			hb1975_certType $
			dateDesignationEffective
			dateDesignationRevised
			designationLetterDate
			certDate
			water_land $
			bondedDepth
			estimatedPlugCost
			shutIn_date
			plug_bond
			wells_shutin $
			becomingActive $
			orphanWell $
			wbCounty
			ssfNo $
			wbSurveyNo $
			blkNo $
			wbSecName $
			webAltSec $
			altSSFNo $
			wbDistSS1
			wbDirSS1 $
			wbDistSS2
			wbDirSS2 $
			wbLatWGS84 $
			wbLongWGS84 $
			wbPlaneZone
			eastCC $
			northCC $
			wbLocVerified $
			leaseName $
			secBlkSrvy $
			milesNearTown $
			dirNearTown $
			nameNearTown $
			distSurveyLines $
			locNearWell $
			segID $
			district
			well $
			group_unit $
			pi_source $
			rule37except_docketNo $
			prodStateFiled $
			poolAuthFiled $
			plugRptFile_date
			segIDo $
			shutInYear
			noWBmatch
			wellDepth
			spudDate
			horizontalWell $
			longitude
			latitude
			noLocMatch
			uid $
			prApiNo
			district_code $
			well_no_display $
			well_type_name $
			lease_number
			latitudedatum83
			longitudedatum83
			permitPRmatch
			completionYear
			prLocMatch
			prAPImatch
			noGIS
			odfFlarePermitMatch
			totalVFpermits
			fvfMatch
			oilUID
			long83
			lat83
			apiLocMatch
			nad83lat
			nad83long
			no83data ;
RUN;
DATA workLoc.oilVariants (KEEP = wellop depth water horizontal age new);
	SET workLoc.oilVFwellLvl  ;
	IF well_depth > wellDepth 
		THEN depth = well_depth ;
	IF wellDepth >= well_depth
		THEN depth = wellDepth ;
	IF freshWaterWell = '0' OR freshWaterWel = 'N'
		THEN water = 0 ;
	IF freshWaterWell = '1' OR freshWaterWell = 'Y'
		THEN water = 1 ;
	IF horizontalWell = '0' OR horizontalWell = 'N'
		THEN horizontal = 0 ;
	IF horizontalWell = '1' OR horizontalWell = 'Y'
		THEN horizontal = 1 ;
	age = 2012 - completionYear ;
	IF completionYear = 2012 
		THEN  new = 1 ;
	IF CompletionYear < 2012
		THEN new = 0 ;
RUN;
DATA workLoc.oilCons 
	(DROP = operatorDateFirstFiled operator_date 
		operator_year_str operator_year_num);
	SET workLoc.oilVFwellLvl 
	(KEEP = 
		operator_no  operatorName operatorOrgCode 
		operatorOrgTypeComment operatorMailAddress1 
		operatorMailAddress2 operatorMailCity operatorMailState 
		operatorMailZip  operatorMailZipSuf operatorLocAddress1 
		operatorLocAddress2 operatorLocCity operatorLocState 
		operatorLocZip operatorLocZipSuf  operatorDateFirstFiled  
		operatorPhone  operatorTaxCert operatorEmergencyPhone 
		operatorType lease_gas_dispcd04_vol  lease_csgd_dispcde04_vol 
		lease_oil_prod_vol lease_gas_prod_vol lease_cond_prod_vol 
		lease_csgd_prod_vol wellop oil_gas_code district_no lease_no 
		cycle_year field_no district_name field_name lease_name );
	operator_date = put(operatorDateFirstFiled, 8.);
	operator_year_str = substr(operator_date, 1, 4);
	operator_year_num = input(operator_year_str, 4.);
	operator_age = 2012 - operator_year_num ;
RUN;
PROC SORT 
	NODUPKEY
	DATA = workLoc.oilCons;
	BY wellop;
RUN;
PROC MEANS  
	DATA = workLoc.oilVariants SUM; 
	CLASS wellop; 
	VAR age depth ;
	OUTPUT OUT = workLoc.oilMeans 
	MEAN = avgAge avgDepth; 
RUN; 
PROC MEANS  
	DATA = workLoc.oilVariants SUM; 
	CLASS wellop; 
	VAR water horizontal new ;
	OUTPUT OUT = workLoc.oilSums
	SUM = waterWells horizontalWells newWells; 
RUN; 
DATA workLoc.oilVar ; 
	MERGE  
		workLoc.oilMeans
		workLoc.oilSums; 
	BY wellop; 
RUN; 
DATA workLoc.oilLease ; 
	MERGE  
		workLoc.oilVar
		workLoc.oilCons; 
	BY wellop; 
RUN; 
DATA workLoc.oilVf (DROP = _TYPE_ _FREQ_);
	SET workLoc.oilLease ;
	if _TYPE_ = 1 ;
	leaseWells = _FREQ_ ;
	if lease_oil_prod_vol > 0 OR lease_csgd_prod_vol > 0 ;
RUN;
PROC SORT 
	NODUPKEY
	DATA = workLoc.oilVf;
	BY wellop;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Import and sort gas production and disposition data				*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.gas
	(KEEP = 
		operator_no  operatorName operatorOrgCode 
		operatorOrgTypeComment operatorMailAddress1 
		operatorMailAddress2 operatorMailCity operatorMailState 
		operatorMailZip  operatorMailZipSuf operatorLocAddress1 
		operatorLocAddress2 operatorLocCity operatorLocState 
		operatorLocZip operatorLocZipSuf  operatorDateFirstFiled  
		operatorPhone  operatorTaxCert operatorEmergencyPhone 
		operatorType lease_gas_dispcd04_vol  lease_csgd_dispcde04_vol 
		lease_oil_prod_vol lease_gas_prod_vol lease_cond_prod_vol 
		lease_csgd_prod_vol wellop oil_gas_code district_no lease_no 
		cycle_year field_no district_name field_name lease_name 
		compl_year_code completion_date well_depth freshWaterWell 
		estimatedPlugCost orphanWell milesNearTown wellDepth  
		spudDate horizontalWell completionYear 
	);
	INFILE 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\19-gas_20161230.csv' 
	DELIMITER = ','
	MISSOVER 
	DSD 
	LRECL = 32767 
	FIRSTOBS = 2 ;
	INFORMAT operator_no best32. ;
	INFORMAT operatorName $34. ;
	INFORMAT operatorRefilingFlag $1. ;
	INFORMAT operatorP5status $1. ;
	INFORMAT operatorMailHold $1. ;
	INFORMAT operatorRenewalCode $1. ;
	INFORMAT operatorOrgCode $1. ;
	INFORMAT operatorOrgTypeComment $1. ;
	INFORMAT operatorGathererCode $5. ;
	INFORMAT operatorMailAddress1 $26. ;
	INFORMAT operatorMailAddress2 $27. ;
	INFORMAT operatorMailCity $10. ;
	INFORMAT operatorMailState $2. ;
	INFORMAT operatorMailZip best32. ;
	INFORMAT operatorMailZipSuf best32. ;
	INFORMAT operatorLocAddress1 $30. ;
	INFORMAT operatorLocAddress2 $27. ;
	INFORMAT operatorLocCity $13. ;
	INFORMAT operatorLocState $2. ;
	INFORMAT operatorLocZip best32. ;
	INFORMAT operatorLocZipSuf best32. ;
	INFORMAT operatorDateFirstFiled best32. ;
	INFORMAT operatorDateInactive best32. ;
	INFORMAT operatorPhone best32. ;
	INFORMAT operatorMonthRefile best32. ;
	INFORMAT opRefileLetDate best32. ;
	INFORMAT opRefileNotDate best32. ;
	INFORMAT refileRecDate best32. ;
	INFORMAT lastRefileRecDate best32. ;
	INFORMAT operatorOtherNo best32. ;
	INFORMAT filingProblemDate best32. ;
	INFORMAT filingProblemCode $1. ;
	INFORMAT operatorPhoneVerified $1. ;
	INFORMAT opNoMultiUseFlag $1. ;
	INFORMAT oilGathStatus $1. ;
	INFORMAT gasGathStatus $1. ;
	INFORMAT operatorTaxCert $1. ;
	INFORMAT operatorEmergencyPhone best32. ;
	INFORMAT id best32. ;
	INFORMAT operatorType $31. ;
	INFORMAT lease_oil_dispcd00_vol best32. ;
	INFORMAT lease_oil_dispcd01_vol best32. ;
	INFORMAT lease_oil_dispcd02_vol best32. ;
	INFORMAT lease_oil_dispcd03_vol best32. ;
	INFORMAT lease_oil_dispcd04_vol best32. ;
	INFORMAT lease_oil_dispcd05_vol best32. ;
	INFORMAT lease_oil_dispcd06_vol best32. ;
	INFORMAT lease_oil_dispcd07_vol best32. ;
	INFORMAT lease_oil_dispcd08_vol best32. ;
	INFORMAT lease_oil_dispcd09_vol best32. ;
	INFORMAT lease_oil_dispcd99_vol best32. ;
	INFORMAT lease_gas_dispcd01_vol best32. ;
	INFORMAT lease_gas_dispcd02_vol best32. ;
	INFORMAT lease_gas_dispcd03_vol best32. ;
	INFORMAT lease_gas_dispcd04_vol best32. ;
	INFORMAT lease_gas_dispcd05_vol best32. ;
	INFORMAT lease_gas_dispcd06_vol best32. ;
	INFORMAT lease_gas_dispcd07_vol best32. ;
	INFORMAT lease_gas_dispcd08_vol best32. ;
	INFORMAT lease_gas_dispcd09_vol best32. ;
	INFORMAT lease_gas_dispcd99_vol best32. ;
	INFORMAT lease_cond_dispcd00_vol best32. ;
	INFORMAT lease_cond_dispcd01_vol best32. ;
	INFORMAT lease_cond_dispcd02_vol best32. ;
	INFORMAT lease_cond_dispcd03_vol best32. ;
	INFORMAT lease_cond_dispcd04_vol best32. ;
	INFORMAT lease_cond_dispcd05_vol best32. ;
	INFORMAT lease_cond_dispcd06_vol best32. ;
	INFORMAT lease_cond_dispcd07_vol best32. ;
	INFORMAT lease_cond_dispcd08_vol best32. ;
	INFORMAT lease_cond_dispcd99_vol best32. ;
	INFORMAT lease_csgd_dispcde01_vol best32. ;
	INFORMAT lease_csgd_dispcde02_vol best32. ;
	INFORMAT lease_csgd_dispcde03_vol best32. ;
	INFORMAT lease_csgd_dispcde04_vol best32. ;
	INFORMAT lease_csgd_dispcde05_vol best32. ;
	INFORMAT lease_csgd_dispcde06_vol best32. ;
	INFORMAT lease_csgd_dispcde07_vol best32. ;
	INFORMAT lease_csgd_dispcde08_vol best32. ;
	INFORMAT lease_csgd_dispcde99_vol best32. ;
	INFORMAT lease_oil_prod_vol best32. ;
	INFORMAT lease_oil_allow best32. ;
	INFORMAT lease_oil_ending_bal best32. ;
	INFORMAT lease_gas_prod_vol best32. ;
	INFORMAT lease_gas_allow best32. ;
	INFORMAT lease_gas_lift_inj_vol best32. ;
	INFORMAT lease_cond_prod_vol best32. ;
	INFORMAT lease_cond_limit best32. ;
	INFORMAT lease_cond_ending_bal best32. ;
	INFORMAT lease_csgd_prod_vol best32. ;
	INFORMAT lease_csgd_limit best32. ;
	INFORMAT lease_csgd_gas_lift best32. ;
	INFORMAT lease_oil_tot_disp best32. ;
	INFORMAT lease_gas_tot_disp best32. ;
	INFORMAT lease_cond_tot_disp best32. ;
	INFORMAT lease_csgd_tot_disp best32. ;
	INFORMAT wellmonthsDisp best32. ;
	INFORMAT wellOPmonthsDisp best32. ;
	INFORMAT wellop $23. ;
	INFORMAT oil_gas_code $1. ;
	INFORMAT district_no best32. ;
	INFORMAT lease_no best32. ;
	INFORMAT cycle_year best32. ;
	INFORMAT field_no best32. ;
	INFORMAT district_name $32. ;
	INFORMAT field_name $22. ;
	INFORMAT operator_name $34. ;
	INFORMAT wellID $15. ;
	INFORMAT changeOPdisp best32. ;
	INFORMAT nOPchangesDisp best32. ;
	INFORMAT lease_no_district_no best32. ;
	INFORMAT  gas_well_no $1. ;
	INFORMAT lease_name $22. ;
	INFORMAT fieldNameMismatch $1. ;
	INFORMAT fieldNoMismatch $1. ;
	INFORMAT repID $1. ;
	INFORMAT noDispReported best32. ;
	INFORMAT noProdReported best32. ;
	INFORMAT calDispTotalOil best32. ;
	INFORMAT difPDdispTotalOil best32. ;
	INFORMAT difOilProdDisp best32. ;
	INFORMAT difOilPtotDtot best32. ;
	INFORMAT disposeMoreProdOil best32. ;
	INFORMAT calDispTotalGas best32. ;
	INFORMAT difPDdispTotalGas best32. ;
	INFORMAT difGasProdDisp best32. ;
	INFORMAT difGasPtotDtot best32. ;
	INFORMAT disposeMoreProdGas best32. ;
	INFORMAT calDispTotalCond best32. ;
	INFORMAT difPDdispTotalCond best32. ;
	INFORMAT difCondProdDisp best32. ;
	INFORMAT difCondPtotDtot best32. ;
	INFORMAT disposeMoreProdCond best32. ;
	INFORMAT  calDispTotalCsgd best32. ;
	INFORMAT difPDdispTotalCsgd best32. ;
	INFORMAT difCsgdProdDisp best32. ;
	INFORMAT difCsgdPtotDtot best32. ;
	INFORMAT disposeMoreProdCsgd best32. ;
	INFORMAT perGasFV $1. ;
	INFORMAT perCsgdFV best32. ;
	INFORMAT insMergIdLnoOno $16. ;
	INFORMAT insMergIdLnoOna $44. ;
	INFORMAT insMergIdLnaOno $32. ;
	INFORMAT insMergIdLnaOna $54. ;
	INFORMAT violation_no best32. ;
	INFORMAT segIDg $14. ;
	INFORMAT api best32. ;
	INFORMAT field_district best32. ;
	INFORMAT county_code best32. ;
	INFORMAT compl_year_code best32. ;
	INFORMAT completion_date best32. ;
	INFORMAT well_depth best32. ;
	INFORMAT fluid_lvl best32. ;
	INFORMAT informat revoked_date best32. ;
	INFORMAT denial_date best32. ;
	INFORMAT denial_type $1. ;
	INFORMAT api_change $1. ;
	INFORMAT correct_api best32. ;
	INFORMAT no_api best32. ;
	INFORMAT api_change_date best32. ;
	INFORMAT permit best32. ;
	INFORMAT permit_expired $1. ;
	INFORMAT swr13a_exception $1. ;
	INFORMAT freshWaterWell $1. ;
	INFORMAT plug $1. ;
	INFORMAT  old_api best32. ;
	INFORMAT  completion_onfile $1. ;
	INFORMAT completion_data_outsource best32. ;
	INFORMAT extensionsGranted best32. ;
	INFORMAT hb1975_certType $1. ;
	INFORMAT dateDesignationEffective best32. ;
	INFORMAT dateDesignationRevised best32. ;
	INFORMAT designationLetterDate best32. ;
	INFORMAT certDate best32. ;
	INFORMAT water_land $1. ;
	INFORMAT bondedDepth best32. ;
	INFORMAT  estimatedPlugCost best32. ;
	INFORMAT shutIn_date best32. ;
	INFORMAT plug_bond best32. ;
	INFORMAT wells_shutin $1. ;
	INFORMAT becomingActive $1. ;
	INFORMAT  orphanWell $1. ;
	INFORMAT  wbCounty best32. ;
	INFORMAT ssfNo $32. ;
	INFORMAT wbSurveyNo $18. ;
	INFORMAT blkNo $1. ;
	INFORMAT  wbSecName $1. ;
	INFORMAT webAltSec $1. ;
	INFORMAT altSSFNo $1. ;
	INFORMAT wbDistSS1 best32. ;
	INFORMAT  wbDirSS1 $2. ;
	INFORMAT wbDistSS2 best32. ;
	INFORMAT wbDirSS2 $5. ;
	INFORMAT wbLatWGS84 $10. ;
	INFORMAT  wbLongWGS84 $10. ;
	INFORMAT wbPlaneZone best32. ;
	INFORMAT eastCC $10. ;
	INFORMAT northCC $10. ;
	INFORMAT  wbLocVerified $32. ;
	INFORMAT leaseName $1. ;
	INFORMAT secBlkSrvy $1. ;
	INFORMAT milesNearTown $1. ;
	INFORMAT dirNearTown $1. ;
	INFORMAT nameNearTown $1. ;
	INFORMAT distSurveyLines $1. ;
	INFORMAT locNearWell $1. ;
	INFORMAT segID $14. ;
	INFORMAT district best32. ;
	INFORMAT well $1. ;
	INFORMAT group_unit $32. ;
	INFORMAT pi_source $1. ;
	INFORMAT rule37except_docketNo $32. ;
	INFORMAT prodStateFiled $1. ;
	INFORMAT poolAuthFiled $1. ;
	INFORMAT plugRptFile_date best32. ;
	INFORMAT segIDo $8. ;
	INFORMAT shutInYear best32. ;
	INFORMAT noWBmatch best32. ;
	INFORMAT wellDepth best32. ;
	INFORMAT spudDate best32. ;
	INFORMAT horizontalWell $1. ;
	INFORMAT longitude best32. ;
	INFORMAT latitude best32. ;
	INFORMAT noLocMatch best32. ;
	INFORMAT uid $8. ;
	INFORMAT prApiNo best32. ;
	INFORMAT district_code $32. ;
	INFORMAT well_no_display $2. ;
	INFORMAT well_type_name $9. ;
	INFORMAT lease_number best32. ;
	INFORMAT latitudedatum83 best32. ;
	INFORMAT longitudedatum83 best32. ;
	INFORMAT permitPRmatch best32. ;
	INFORMAT completionYear best32. ;
	INFORMAT prLocMatch best32. ;
	INFORMAT prAPImatch best32. ;
	INFORMAT noGIS best32. ;
	INFORMAT odfFlarePermitMatch best32. ;
	INFORMAT totalVFpermits best32. ;
	INFORMAT fvfMatch best32. ;
	INFORMAT gasUID best32. ;
		FORMAT operator_no best32. ;
	FORMAT operatorName $34. ;
	FORMAT operatorRefilingFlag $1. ;
	FORMAT operatorP5status $1. ;
	FORMAT operatorMailHold $1. ;
	FORMAT operatorRenewalCode $1. ;
	FORMAT operatorOrgCode $1. ;
	FORMAT operatorOrgTypeComment $1. ;
	FORMAT operatorGathererCode $5. ;
	FORMAT operatorMailAddress1 $26. ;
	FORMAT operatorMailAddress2 $27. ;
	FORMAT operatorMailCity $10. ;
	FORMAT operatorMailState $2. ;
	FORMAT operatorMailZip best32. ;
	FORMAT operatorMailZipSuf best32. ;
	FORMAT operatorLocAddress1 $30. ;
	FORMAT operatorLocAddress2 $27. ;
	FORMAT operatorLocCity $13. ;
	FORMAT operatorLocState $2. ;
	FORMAT operatorLocZip best32. ;
	FORMAT operatorLocZipSuf best32. ;
	FORMAT operatorDateFirstFiled best32. ;
	FORMAT operatorDateInactive best32. ;
	FORMAT operatorPhone best32. ;
	FORMAT operatorMonthRefile best32. ;
	FORMAT opRefileLetDate best32. ;
	FORMAT opRefileNotDate best32. ;
	FORMAT refileRecDate best32. ;
	FORMAT lastRefileRecDate best32. ;
	FORMAT operatorOtherNo best32. ;
	FORMAT filingProblemDate best32. ;
	FORMAT filingProblemCode $1. ;
	FORMAT operatorPhoneVerified $1. ;
	FORMAT opNoMultiUseFlag $1. ;
	FORMAT oilGathStatus $1. ;
	FORMAT gasGathStatus $1. ;
	FORMAT operatorTaxCert $1. ;
	FORMAT operatorEmergencyPhone best32. ;
	FORMAT id best32. ;
	FORMAT operatorType $31. ;
	FORMAT lease_oil_dispcd00_vol best32. ;
	FORMAT lease_oil_dispcd01_vol best32. ;
	FORMAT lease_oil_dispcd02_vol best32. ;
	FORMAT lease_oil_dispcd03_vol best32. ;
	FORMAT lease_oil_dispcd04_vol best32. ;
	FORMAT lease_oil_dispcd05_vol best32. ;
	FORMAT lease_oil_dispcd06_vol best32. ;
	FORMAT lease_oil_dispcd07_vol best32. ;
	FORMAT lease_oil_dispcd08_vol best32. ;
	FORMAT lease_oil_dispcd09_vol best32. ;
	FORMAT lease_oil_dispcd99_vol best32. ;
	FORMAT lease_gas_dispcd01_vol best32. ;
	FORMAT lease_gas_dispcd02_vol best32. ;
	FORMAT lease_gas_dispcd03_vol best32. ;
	FORMAT lease_gas_dispcd04_vol best32. ;
	FORMAT lease_gas_dispcd05_vol best32. ;
	FORMAT lease_gas_dispcd06_vol best32. ;
	FORMAT lease_gas_dispcd07_vol best32. ;
	FORMAT lease_gas_dispcd08_vol best32. ;
	FORMAT lease_gas_dispcd09_vol best32. ;
	FORMAT lease_gas_dispcd99_vol best32. ;
	FORMAT lease_cond_dispcd00_vol best32. ;
	FORMAT lease_cond_dispcd01_vol best32. ;
	FORMAT lease_cond_dispcd02_vol best32. ;
	FORMAT lease_cond_dispcd03_vol best32. ;
	FORMAT lease_cond_dispcd04_vol best32. ;
	FORMAT lease_cond_dispcd05_vol best32. ;
	FORMAT lease_cond_dispcd06_vol best32. ;
	FORMAT lease_cond_dispcd07_vol best32. ;
	FORMAT lease_cond_dispcd08_vol best32. ;
	FORMAT lease_cond_dispcd99_vol best32. ;
	FORMAT lease_csgd_dispcde01_vol best32. ;
	FORMAT lease_csgd_dispcde02_vol best32. ;
	FORMAT lease_csgd_dispcde03_vol best32. ;
	FORMAT lease_csgd_dispcde04_vol best32. ;
	FORMAT lease_csgd_dispcde05_vol best32. ;
	FORMAT lease_csgd_dispcde06_vol best32. ;
	FORMAT lease_csgd_dispcde07_vol best32. ;
	FORMAT lease_csgd_dispcde08_vol best32. ;
	FORMAT lease_csgd_dispcde99_vol best32. ;
	FORMAT lease_oil_prod_vol best32. ;
	FORMAT lease_oil_allow best32. ;
	FORMAT lease_oil_ending_bal best32. ;
	FORMAT lease_gas_prod_vol best32. ;
	FORMAT lease_gas_allow best32. ;
	FORMAT lease_gas_lift_inj_vol best32. ;
	FORMAT lease_cond_prod_vol best32. ;
	FORMAT lease_cond_limit best32. ;
	FORMAT lease_cond_ending_bal best32. ;
	FORMAT lease_csgd_prod_vol best32. ;
	FORMAT lease_csgd_limit best32. ;
	FORMAT lease_csgd_gas_lift best32. ;
	FORMAT lease_oil_tot_disp best32. ;
	FORMAT lease_gas_tot_disp best32. ;
	FORMAT lease_cond_tot_disp best32. ;
	FORMAT lease_csgd_tot_disp best32. ;
	FORMAT wellmonthsDisp best32. ;
	FORMAT wellOPmonthsDisp best32. ;
	FORMAT wellop $23. ;
	FORMAT oil_gas_code $1. ;
	FORMAT district_no best32. ;
	FORMAT lease_no best32. ;
	FORMAT cycle_year best32. ;
	FORMAT field_no best32. ;
	FORMAT district_name $32. ;
	FORMAT field_name $22. ;
	FORMAT operator_name $34. ;
	FORMAT wellID $15. ;
	FORMAT changeOPdisp best32. ;
	FORMAT nOPchangesDisp best32. ;
	FORMAT lease_no_district_no best32. ;
	FORMAT  gas_well_no $1. ;
	FORMAT lease_name $22. ;
	FORMAT fieldNameMismatch $1. ;
	FORMAT fieldNoMismatch $1. ;
	FORMAT repID $1. ;
	FORMAT noDispReported best32. ;
	FORMAT noProdReported best32. ;
	FORMAT calDispTotalOil best32. ;
	FORMAT difPDdispTotalOil best32. ;
	FORMAT difOilProdDisp best32. ;
	FORMAT difOilPtotDtot best32. ;
	FORMAT disposeMoreProdOil best32. ;
	FORMAT calDispTotalGas best32. ;
	FORMAT difPDdispTotalGas best32. ;
	FORMAT difGasProdDisp best32. ;
	FORMAT difGasPtotDtot best32. ;
	FORMAT disposeMoreProdGas best32. ;
	FORMAT calDispTotalCond best32. ;
	FORMAT difPDdispTotalCond best32. ;
	FORMAT difCondProdDisp best32. ;
	FORMAT difCondPtotDtot best32. ;
	FORMAT disposeMoreProdCond best32. ;
	FORMAT  calDispTotalCsgd best32. ;
	FORMAT difPDdispTotalCsgd best32. ;
	FORMAT difCsgdProdDisp best32. ;
	FORMAT difCsgdPtotDtot best32. ;
	FORMAT disposeMoreProdCsgd best32. ;
	FORMAT perGasFV $1. ;
	FORMAT perCsgdFV best32. ;
	FORMAT insMergIdLnoOno $16. ;
	FORMAT insMergIdLnoOna $44. ;
	FORMAT insMergIdLnaOno $32. ;
	FORMAT insMergIdLnaOna $54. ;
	FORMAT violation_no best32. ;
	FORMAT segIDg $14. ;
	FORMAT api best32. ;
	FORMAT field_district best32. ;
	FORMAT county_code best32. ;
	FORMAT compl_year_code best32. ;
	FORMAT completion_date best32. ;
	FORMAT well_depth best32. ;
	FORMAT fluid_lvl best32. ;
	FORMAT FORMAT revoked_date best32. ;
	FORMAT denial_date best32. ;
	FORMAT denial_type $1. ;
	FORMAT api_change $1. ;
	FORMAT correct_api best32. ;
	FORMAT no_api best32. ;
	FORMAT api_change_date best32. ;
	FORMAT permit best32. ;
	FORMAT permit_expired $1. ;
	FORMAT swr13a_exception $1. ;
	FORMAT freshWaterWell $1. ;
	FORMAT plug $1. ;
	FORMAT  old_api best32. ;
	FORMAT  completion_onfile $1. ;
	FORMAT completion_data_outsource best32. ;
	FORMAT extensionsGranted best32. ;
	FORMAT hb1975_certType $1. ;
	FORMAT dateDesignationEffective best32. ;
	FORMAT dateDesignationRevised best32. ;
	FORMAT designationLetterDate best32. ;
	FORMAT certDate best32. ;
	FORMAT water_land $1. ;
	FORMAT bondedDepth best32. ;
	FORMAT  estimatedPlugCost best32. ;
	FORMAT shutIn_date best32. ;
	FORMAT plug_bond best32. ;
	FORMAT wells_shutin $1. ;
	FORMAT becomingActive $1. ;
	FORMAT  orphanWell $1. ;
	FORMAT  wbCounty best32. ;
	FORMAT ssfNo $32. ;
	FORMAT wbSurveyNo $18. ;
	FORMAT blkNo $1. ;
	FORMAT  wbSecName $1. ;
	FORMAT webAltSec $1. ;
	FORMAT altSSFNo $1. ;
	FORMAT wbDistSS1 best32. ;
	FORMAT  wbDirSS1 $2. ;
	FORMAT wbDistSS2 best32. ;
	FORMAT wbDirSS2 $5. ;
	FORMAT wbLatWGS84 $10. ;
	FORMAT  wbLongWGS84 $10. ;
	FORMAT wbPlaneZone best32. ;
	FORMAT eastCC $10. ;
	FORMAT northCC $10. ;
	FORMAT  wbLocVerified $32. ;
	FORMAT leaseName $1. ;
	FORMAT secBlkSrvy $1. ;
	FORMAT milesNearTown $1. ;
	FORMAT dirNearTown $1. ;
	FORMAT nameNearTown $1. ;
	FORMAT distSurveyLines $1. ;
	FORMAT locNearWell $1. ;
	FORMAT segID $14. ;
	FORMAT district best32. ;
	FORMAT well $1. ;
	FORMAT group_unit $32. ;
	FORMAT pi_source $1. ;
	FORMAT rule37except_docketNo $32. ;
	FORMAT prodStateFiled $1. ;
	FORMAT poolAuthFiled $1. ;
	FORMAT plugRptFile_date best32. ;
	FORMAT segIDo $8. ;
	FORMAT shutInYear best32. ;
	FORMAT noWBmatch best32. ;
	FORMAT wellDepth best32. ;
	FORMAT spudDate best32. ;
	FORMAT horizontalWell $1. ;
	FORMAT longitude best32. ;
	FORMAT latitude best32. ;
	FORMAT noLocMatch best32. ;
	FORMAT uid $8. ;
	FORMAT prApiNo best32. ;
	FORMAT district_code $32. ;
	FORMAT well_no_display $2. ;
	FORMAT well_type_name $9. ;
	FORMAT lease_number best32. ;
	FORMAT latitudedatum83 best32. ;
	FORMAT longitudedatum83 best32. ;
	FORMAT permitPRmatch best32. ;
	FORMAT completionYear best32. ;
	FORMAT prLocMatch best32. ;
	FORMAT prAPImatch best32. ;
	FORMAT noGIS best32. ;
	FORMAT odfFlarePermitMatch best32. ;
	FORMAT totalVFpermits best32. ;
	FORMAT fvfMatch best32. ;
	FORMAT gasUID best32. ;
		INPUT
			operator_no
			operatorName $
			operatorRefilingFlag $
			operatorP5status $
			operatorMailHold $
			operatorRenewalCode $
			operatorOrgCode $ 
			operatorOrgTypeComment $
			operatorGathererCode $
			operatorMailAddress1 $
			operatorMailAddress2 $
			operatorMailCity $
			operatorMailState $
			operatorMailZip
			operatorMailZipSuf
			operatorLocAddress1 $
			operatorLocAddress2 $
			operatorLocCity $
			operatorLocState $
			operatorLocZip
			operatorLocZipSuf
			operatorDateFirstFiled
			operatorDateInactive
			operatorPhone
			operatorMonthRefile
			opRefileLetDate
			opRefileNotDate
			refileRecDate
			lastRefileRecDate
			operatorOtherNo
			filingProblemDate
			filingProblemCode $
			operatorPhoneVerified $
			opNoMultiUseFlag $
			oilGathStatus $
			gasGathStatus $
			operatorTaxCert $
			operatorEmergencyPhone
			id
			operatorType $
			lease_oil_dispcd00_vol
			lease_oil_dispcd01_vol
			lease_oil_dispcd02_vol
			lease_oil_dispcd03_vol
			lease_oil_dispcd04_vol
			lease_oil_dispcd05_vol
			lease_oil_dispcd06_vol
			lease_oil_dispcd07_vol
			lease_oil_dispcd08_vol
			lease_oil_dispcd09_vol
			lease_oil_dispcd99_vol
			lease_gas_dispcd01_vol
			lease_gas_dispcd02_vol
			lease_gas_dispcd03_vol
			lease_gas_dispcd04_vol
			lease_gas_dispcd05_vol
			lease_gas_dispcd06_vol
			lease_gas_dispcd07_vol
			lease_gas_dispcd08_vol
			lease_gas_dispcd09_vol
			lease_gas_dispcd99_vol
			lease_cond_dispcd00_vol
			lease_cond_dispcd01_vol
			lease_cond_dispcd02_vol
			lease_cond_dispcd03_vol
			lease_cond_dispcd04_vol
			lease_cond_dispcd05_vol
			lease_cond_dispcd06_vol
			lease_cond_dispcd07_vol
			lease_cond_dispcd08_vol
			lease_cond_dispcd99_vol
			lease_csgd_dispcde01_vol
			lease_csgd_dispcde02_vol
			lease_csgd_dispcde03_vol
			lease_csgd_dispcde04_vol
			lease_csgd_dispcde05_vol
			lease_csgd_dispcde06_vol
			lease_csgd_dispcde07_vol
			lease_csgd_dispcde08_vol
			lease_csgd_dispcde99_vol
			lease_oil_prod_vol
			lease_oil_allow
			lease_oil_ending_bal
			lease_gas_prod_vol
			lease_gas_allow
			lease_gas_lift_inj_vol
			lease_cond_prod_vol
			lease_cond_limit
			lease_cond_ending_bal
			lease_csgd_prod_vol
			lease_csgd_limit
			lease_csgd_gas_lift
			lease_oil_tot_disp
			lease_gas_tot_disp
			lease_cond_tot_disp
			lease_csgd_tot_disp
			wellmonthsDisp
			wellOPmonthsDisp
			wellop $
			oil_gas_code $
			district_no
			lease_no
			cycle_year
			field_no
			district_name $
			field_name $
			operator_name $
			wellID $
			changeOPdisp
			nOPchangesDisp
			lease_no_district_no
			gas_well_no $
			lease_name $
			fieldNameMismatch $
			fieldNoMismatch $
			repID $
			noDispReported
			noProdReported
			calDispTotalOil
			difPDdispTotalOil
			difOilProdDisp
			difOilPtotDtot
			disposeMoreProdOil
			calDispTotalGas
			difPDdispTotalGas
			difGasProdDisp
			difGasPtotDtot
			disposeMoreProdGas
			calDispTotalCond
			difPDdispTotalCond
			difCondProdDisp
			difCondPtotDtot
			disposeMoreProdCond
			calDispTotalCsgd
			difPDdispTotalCsgd
			difCsgdProdDisp
			difCsgdPtotDtot
			disposeMoreProdCsgd
			perGasFV $
			perCsgdFV
			insMergIdLnoOno $
			insMergIdLnoOna $
			insMergIdLnaOno $
			insMergIdLnaOna $
			violation_no
			segIDg $
			api
			field_district
			county_code
			compl_year_code
			completion_date
			well_depth
			fluid_lvl
			revoked_date
			denial_date
			denial_type $
			api_change $
			correct_api
			no_api
			api_change_date
			permit
			permit_expired $
			swr13a_exception $
			freshWaterWell $
			plug $
			old_api
			completion_onfile $
			completion_data_outsource
			extensionsGranted
			hb1975_certType $
			dateDesignationEffective
			dateDesignationRevised
			designationLetterDate
			certDate
			water_land $
			bondedDepth
			estimatedPlugCost
			shutIn_date
			plug_bond
			wells_shutin $
			becomingActive $
			orphanWell $
			wbCounty
			ssfNo $
			wbSurveyNo $
			blkNo $
			wbSecName $
			webAltSec $
			altSSFNo $
			wbDistSS1
			wbDirSS1 $
			wbDistSS2
			wbDirSS2 $
			wbLatWGS84 $
			wbLongWGS84 $
			wbPlaneZone
			eastCC $
			northCC $
			wbLocVerified $
			leaseName $
			secBlkSrvy $
			milesNearTown $
			dirNearTown $
			nameNearTown $
			distSurveyLines $
			locNearWell $
			segID $
			district
			well $
			group_unit $
			pi_source $
			rule37except_docketNo $
			prodStateFiled $
			poolAuthFiled $
			plugRptFile_date
			segIDo $
			shutInYear
			noWBmatch
			wellDepth
			spudDate
			horizontalWell $
			longitude
			latitude
			noLocMatch
			uid $
			prApiNo
			district_code $
			well_no_display $
			well_type_name $
			lease_number
			latitudedatum83
			longitudedatum83
			permitPRmatch
			completionYear
			prLocMatch
			prAPImatch
			noGIS
			odfFlarePermitMatch
			totalVFpermits
			fvfMatch
			gasUID;
RUN;
DATA workLoc.gasVf ;
	SET workLoc.gas ;
	if lease_gas_prod_vol > 0 OR lease_cond_prod_vol > 0 ;
RUN;
PROC SORT 
	NODUPKEY
	DATA = workLoc.gasVf;
	BY wellop;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Collapse oil wellop-bgGeoid data by bgGeoid						*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.oilVfWgeoid ;
	MERGE 
		workLoc.oilComBgSortWellop (IN = oc)
		workLoc.oilVf (IN = vf);
	BY wellop;
	bgMatch = vf;
RUN;
PROC MEANS
	DATA = workLoc.oilVfWgeoid SUM;
	CLASS geoid;
	VAR lease_gas_dispcd04_vol  lease_csgd_dispcde04_vol 
		lease_oil_prod_vol lease_gas_prod_vol lease_cond_prod_vol 
		lease_csgd_prod_vol leaseWells waterWells 
		horizontalWells newWells;
	OUTPUT OUT = workLoc.oilSumByGeoid
	SUM = gasVf csgdVf oilProd gasProd condProd csgdProd wells 
		waterWells horizontalWells newWells;
RUN; 
/********-*********-*********-*********-*********-*********-*********/
/* Collapse gas wellop-bgGeoid data by bgGeoid						*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.gasVfWgeoid;
	MERGE 
		workLoc.gasComBgSortWellop (IN = gc)
		workLoc.gasVf (IN = vf);
	BY wellop;
	bgMatch = vf;
	leaseWells = 1 ;
	IF freshWaterWell = '0' OR freshWaterWel = 'N'
		THEN water = 0 ;
	IF freshWaterWell = '1' OR freshWaterWell = 'Y'
		THEN water = 1 ;
	IF horizontalWell = '0' OR horizontalWell = 'N'
		THEN horizontal = 0 ;
	IF horizontalWell = '1' OR horizontalWell = 'Y'
		THEN horizontal = 1 ;
	age = 2012 - completionYear ;
	IF completionYear = 2012 
		THEN  new = 1 ;
	IF CompletionYear < 2012
		THEN new = 0 ;	
RUN;
PROC MEANS
	DATA = workLoc.gasVfWgeoid SUM;
	CLASS geoid;
	VAR lease_gas_dispcd04_vol  lease_csgd_dispcde04_vol 
		lease_oil_prod_vol lease_gas_prod_vol lease_cond_prod_vol 
		lease_csgd_prod_vol leaseWells water 
		horizontal new;
	OUTPUT OUT = workLoc.gasSumByGeoid
	SUM = gasVf csgdVf oilProd gasProd condProd csgdProd wells 
		waterWells horizontalWells newWells;
RUN; 
/********-*********-*********-*********-*********-*********-*********/
/* Collapse oil wellop-bgGeoid data by wellop						*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.oilbg ; 
	MERGE  
		workLoc.oilComBgSortGeoid (IN = oc)
		workLoc.acs (IN = acs); 
	BY geoid; 
	IF oc ;
RUN; 
PROC MEANS  
	DATA = workLoc.oilBg SUM; 
	CLASS wellop; 
	VAR aland emp_pop emp_unemployed_sum age_pop age_old_sum educ_pop 
		educ_nodiploma_sum race_pop race_white_sum race_black_sum 
		race_hisp_sum fluency_pop fluency_limenglish_sum 
		oohu_less10K_sum oohu_10Kto14999_sum oohu_15Kto19999_sum 
		oohu_20Kto24999_sum oohu_25Kto29999_sum oohu_30Kto34999_sum 
		oohu_35Kto39999_sum oohu_40Kto49999_sum oohu_50Kto59999_sum 
		oohu_60Kto69999_sum oohu_70Kto79999_sum oohu_80Kto89999_sum 
		oohu_90Kto99999_sum oohu_100Kto124999_sum  oohu_125Kto149999_sum 
		oohu_150Kto174999_sum oohu_175Kto199999_sum oohu_200Kto249999_sum  
		oohu_250Kto299999_sum oohu_300Kto399999_sum oohu_400Kto499999_sum  
		oohu_500Kto749999_sum oohu_750Kto999999_sum oohu_1MMore_sum  
		inc_pop_sum inc_less10K_sum inc_10Kto14999_sum inc_15Kto19999_sum 
		inc_20Kto24999_sum inc_25Kto29999_sum inc_30Kto34999_sum 
		inc_35Kto39999_sum inc_40Kto44999_sum inc_45Kto49999_sum  
		inc_50Kto59999_sum inc_60Kto74999_sum inc_75Kto99999_sum  
		inc_100Kto124999_sum inc_125Kto149999_sum inc_150Kto199999_sum
		inc_more200K_sum occ_pop occ_ce_sum pov_pop pov_belowpovertyline_sum  ;
	OUTPUT OUT = workLoc.oilSumByWellop 
	SUM = area emp_base emp_unemployed age_base age_old educ_base 
		educ_nodiploma race_base race_white race_black 
		race_hisp fluency_base fluency_limenglish 
		oohu_less10K oohu_10Kto14999 oohu_15Kto19999 
		oohu_20Kto24999 oohu_25Kto29999 oohu_30Kto34999 
		oohu_35Kto39999 oohu_40Kto49999 oohu_50Kto59999 
		oohu_60Kto69999 oohu_70Kto79999 oohu_80Kto89999 
		oohu_90Kto99999 oohu_100Kto124999  oohu_125Kto149999 
		oohu_150Kto174999 oohu_175Kto199999 oohu_200Kto249999  
		oohu_250Kto299999 oohu_300Kto399999 oohu_400Kto499999  
		oohu_500Kto749999 oohu_750Kto999999 oohu_1MMore  
		inc_base inc_less10K inc_10Kto14999 inc_15Kto19999 
		inc_20Kto24999 inc_25Kto29999 inc_30Kto34999 
		inc_35Kto39999 inc_40Kto44999 inc_45Kto49999  
		inc_50Kto59999 inc_60Kto74999 inc_75Kto99999  
		inc_100Kto124999 inc_125Kto149999 inc_150Kto199999 
		inc_more200K occ_base occ_ce pov_base pov_belowpovertyline  ; 
RUN; 
/********-*********-*********-*********-*********-*********-*********/
/* Collapse gas wellop-bgGeoid data by wellop						*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.gasbg ; 
	MERGE  
		workLoc.gasComBgSortGeoid (IN = gc)
		workLoc.acs (IN = acs); 
	BY geoid; 
	IF gc ;
RUN; 
PROC MEANS  
	DATA = workLoc.gasBg SUM; 
	CLASS wellop; 
	VAR aland emp_pop emp_unemployed_sum age_pop age_old_sum educ_pop 
		educ_nodiploma_sum race_pop race_white_sum race_black_sum 
		race_hisp_sum fluency_pop fluency_limenglish_sum 
		oohu_less10K_sum oohu_10Kto14999_sum oohu_15Kto19999_sum 
		oohu_20Kto24999_sum oohu_25Kto29999_sum oohu_30Kto34999_sum 
		oohu_35Kto39999_sum oohu_40Kto49999_sum oohu_50Kto59999_sum 
		oohu_60Kto69999_sum oohu_70Kto79999_sum oohu_80Kto89999_sum 
		oohu_90Kto99999_sum oohu_100Kto124999_sum  oohu_125Kto149999_sum 
		oohu_150Kto174999_sum oohu_175Kto199999_sum oohu_200Kto249999_sum  
		oohu_250Kto299999_sum oohu_300Kto399999_sum oohu_400Kto499999_sum  
		oohu_500Kto749999_sum oohu_750Kto999999_sum oohu_1MMore_sum  
		inc_pop_sum inc_less10K_sum inc_10Kto14999_sum inc_15Kto19999_sum 
		inc_20Kto24999_sum inc_25Kto29999_sum inc_30Kto34999_sum 
		inc_35Kto39999_sum inc_40Kto44999_sum inc_45Kto49999_sum  
		inc_50Kto59999_sum inc_60Kto74999_sum inc_75Kto99999_sum  
		inc_100Kto124999_sum inc_125Kto149999_sum inc_150Kto199999_sum
		inc_more200K_sum occ_pop occ_ce_sum pov_pop pov_belowpovertyline_sum  ;
	OUTPUT OUT = workLoc.gasSumByWellop 
	SUM = area emp_base emp_unemployed age_base age_old educ_base 
		educ_nodiploma race_base race_white race_black 
		race_hisp fluency_base fluency_limenglish 
		oohu_less10K oohu_10Kto14999 oohu_15Kto19999 
		oohu_20Kto24999 oohu_25Kto29999 oohu_30Kto34999 
		oohu_35Kto39999 oohu_40Kto49999 oohu_50Kto59999 
		oohu_60Kto69999 oohu_70Kto79999 oohu_80Kto89999 
		oohu_90Kto99999 oohu_100Kto124999  oohu_125Kto149999 
		oohu_150Kto174999 oohu_175Kto199999 oohu_200Kto249999  
		oohu_250Kto299999 oohu_300Kto399999 oohu_400Kto499999  
		oohu_500Kto749999 oohu_750Kto999999 oohu_1MMore  
		inc_base inc_less10K inc_10Kto14999 inc_15Kto19999 
		inc_20Kto24999 inc_25Kto29999 inc_30Kto34999 
		inc_35Kto39999 inc_40Kto44999 inc_45Kto49999  
		inc_50Kto59999 inc_60Kto74999 inc_75Kto99999  
		inc_100Kto124999 inc_125Kto149999 inc_150Kto199999 
		inc_more200K occ_base occ_ce pov_base pov_belowpovertyline  ; 
RUN; 
/********-*********-*********-*********-*********-*********-*********/
/* Create single gas block group level file							*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s29_gasBgLvl_20171102 (DROP = _TYPE_ _FREQ_); 
	MERGE  
		workLoc.gasSumByGeoid (IN = g)
		workLoc.acs (IN = acs); 
	BY geoid; 
	bgNearGas = g ;
	IF _TYPE_ ~= 0 ;
	bgGasWell = _FREQ_ ;
RUN; 
PROC EXPORT
	DATA = postLoc.s29_gasBgLvl_20171102
	DBMS = CSV
	LABEL
	OUTFILE = 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\s29_gasBgLvl_20171102.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create single oil block group level file							*/
/********-*********-*********-*********-*********-*********-*********/
DATA postLoc.s29_oilBgLvl_20171102 (DROP = _TYPE_ _FREQ_); 
	MERGE  
		workLoc.oilSumByGeoid (IN = o)
		workLoc.acs (IN = acs); 
	BY geoid; 
	bgNearOil = o ;
	IF _TYPE_ ~= 0 ;
	bgOilLease = _FREQ_ ;
RUN;
PROC EXPORT
	DATA = postLoc.s29_oilBgLvl_20171102
	DBMS = CSV
	LABEL
	OUTFILE = 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\postLoc.s29_oilBgLvl_20171102.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create and export single gas wellop level file					*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.gasMerge (DROP = _TYPE_ _FREQ_); 
	MERGE  
		workLoc.gasSumByWellop (IN = g)
		workLoc.gasVf (IN = vf); 
	BY wellop; 
	bgMatch = g ;
	IF _TYPE_ ~= 0 ;
	bg1mi = _FREQ_ ;
RUN;
DATA postLoc.s29_gasLeaseLvl_20171102 ;
	SET workLoc.gasMerge ;
	popDens = age_base / ( area * 0.0000003861022 ); 
	perOld = 100 * age_old / age_base ; 
	perBlack = 100 * race_black / race_base; 
	perWhiteNonhisp = 100 * race_white / race_base; 
	perUneducated = 100 * educ_nodiploma / educ_base; 
	perNonEnglishHh = 100 * fluency_limenglish / fluency_base; 
	perPoverty = 100 * pov_belowpovertyline / pov_base; 
	perIncLess10k = 100 * inc_less10K / inc_base; 
	perInc10Kto14999 = 100 * inc_10Kto14999 / inc_base;  
	perInc15Kto19999 = 100 * inc_15Kto19999 / inc_base;  
	perInc20Kto24999 = 100 * inc_20Kto24999 / inc_base;  
	perInc25Kto29999 = 100 * inc_25Kto29999 / inc_base; 
	perInc30Kto34999 = 100 * inc_30Kto34999 / inc_base; 
	perInc35Kto39999 = 100 * inc_35Kto39999 / inc_base; 
	perInc40Kto44999 = 100 * inc_40Kto44999 / inc_base; 
	perInc45Kto49999 = 100 * inc_45Kto49999 / inc_base; 
	perInc50Kto59999 = 100 * inc_50Kto59999 / inc_base; 
	perInc60Kto74999 = 100 * inc_60Kto74999 / inc_base; 
	perInc75Kto99999 = 100 * inc_75Kto99999 / inc_base; 
	perInc100Kto124999 = 100 * inc_100Kto124999 / inc_base; 
	perInc125Kto149999 = 100 * inc_125Kto149999 / inc_base; 
	perInc150Kto199999 = 100 * inc_150Kto199999 / inc_base; 
	perIncMore200k = 100 * inc_more200k / inc_base;  
	perConstructExtractOcc = 100 * occ_ce / occ_base; 
	oohu_base = oohu_less10K + oohu_10Kto14999 + oohu_15Kto19999 
		+ oohu_20Kto24999 + oohu_25Kto29999 + oohu_30Kto34999 
		+ oohu_35Kto39999 + oohu_40Kto49999 + oohu_50Kto59999 
		+ oohu_60Kto69999 + oohu_70Kto79999 + oohu_80Kto89999 
		+ oohu_90Kto99999 + oohu_100Kto124999  + oohu_125Kto149999 
		+ oohu_150Kto174999 + oohu_175Kto199999 + oohu_200Kto249999  
		+ oohu_250Kto299999 + oohu_300Kto399999 + oohu_400Kto499999  
		+ oohu_500Kto749999 + oohu_750Kto999999 + oohu_1MMore ;
	perOohuLess10k = 100 * oohu_less10k / oohu_base; 
	perOohu10Kto14999 = 100 * oohu_10Kto14999  / oohu_base; 
	perOohu15Kto19999 = 100 * oohu_15Kto19999 / oohu_base; 
	perOohu20Kto24999 = 100 * oohu_20Kto24999 / oohu_base; 
	perOohu25Kto29999 = 100 * oohu_25Kto29999 / oohu_base; 
	perOohu30Kto34999 = 100 * oohu_30Kto34999 / oohu_base; 
	perOohu35Kto39999 = 100 * oohu_35Kto39999 / oohu_base; 
	perOohu40Kto49999 = 100 * oohu_40Kto49999 / oohu_base; 
	perOohu50Kto59999 = 100 * oohu_50Kto59999 / oohu_base; 
	perOohu60Kto69999 = 100 * oohu_60Kto69999 / oohu_base; 
	perOohu70Kto79999 = 100 * oohu_70Kto79999 / oohu_base; 
	perOohu80Kto89999 = 100 * oohu_80Kto89999 / oohu_base; 
	perOohu90Kto99999 = 100 * oohu_90Kto99999 / oohu_base; 
	perOohu100Kto124999 = 100 * oohu_100Kto124999 / oohu_base; 
	perOohu125Kto149999 = 100 * oohu_125Kto149999 / oohu_base; 
	perOohu150Kto174999 = 100 * oohu_150Kto174999 / oohu_base; 
	perOohu175Kto199999 = 100 * oohu_175Kto199999 / oohu_base; 
	perOohu200Kto249999 = 100 * oohu_200Kto249999 / oohu_base; 
	perOohu250Kto299999 = 100 * oohu_250Kto299999 / oohu_base; 
	perOohu300Kto39999 = 100 * oohu_300Kto399999 / oohu_base; 
	perOohu400Kto499999 = 100 * oohu_400Kto499999 / oohu_base; 
	perOohu500Kto749999 = 100 * oohu_500Kto749999 / oohu_base; 
	perOohu750Kto999999 = 100 * oohu_750Kto999999 / oohu_base; 
	perOohu1mmore = 100 * oohu_1mmore / oohu_base; 
	incMedian = . ;
		IF incMedian = . & perIncLess10k >= 50 
			THEN incMedian = 1 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 >= 50 
			THEN incMedian = 2 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 >= 50 
			THEN incMedian = 3 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 >= 50 
			THEN incMedian = 4 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 >= 50 
			THEN incMedian = 5 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 >= 50 
			THEN incMedian = 6 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 >= 50 
			THEN incMedian = 7 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 >= 50 
			THEN incMedian = 8 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 >= 50 
			THEN incMedian = 9 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 >= 50 
			THEN incMedian = 10 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 >= 50 
			THEN incMedian = 11 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 >= 50 
			THEN incMedian = 12 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 >= 50 
			THEN incMedian = 13 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 + perInc125Kto149999 >= 50 
			THEN incMedian = 14 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 + perInc125Kto149999 + perInc150Kto199999 >= 50 
			THEN incMedian = 15 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 + perInc125Kto149999 + perInc150Kto199999 + perIncMore200k >= 50 
			THEN incMedian = 16 ; 
	oohuMedian = . ;
		IF oohuMedian = . & perOohuLess10k >= 50 
			THEN oohuMedian = 1 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 >= 50 
			THEN oohuMedian = 2 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 >= 50 
			THEN oohuMedian = 3 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 >= 50 
			THEN oohuMedian = 4 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 >= 50 
			THEN oohuMedian = 5 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 >= 50 
			THEN oohuMedian = 6 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 >= 50 
			THEN oohuMedian = 7 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 >= 50 
			THEN oohuMedian = 8 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 >= 50 
			THEN oohuMedian = 9 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 >= 50 
			THEN oohuMedian = 10 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 >= 50 
			THEN oohuMedian = 11 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 >= 50 
			THEN oohuMedian = 12 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 >= 50 
			THEN oohuMedian = 13 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 >= 50 
			THEN oohuMedian = 14 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 >= 50 
			THEN oohuMedian = 15 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 >= 50 
			THEN oohuMedian = 16 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 >= 50 
			THEN oohuMedian = 17 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 >= 50 
			THEN oohuMedian = 18 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 >= 50 
			THEN oohuMedian = 19 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 >= 50 
			THEN oohuMedian = 20 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 >= 50 
			THEN oohuMedian = 21 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 + perOohu500Kto749999 >= 50 
			THEN oohuMedian = 22 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 + perOohu500Kto749999 + perOohu750Kto999999 >= 50 
			THEN oohuMedian = 23 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 + perOohu500Kto749999 + perOohu750Kto999999 + perOohu1mmore >= 50 
			THEN oohuMedian = 24 ; 	
		IF lease_gas_prod_vol > 0 OR lease_cond_prod_vol > 0 ;
RUN;
PROC EXPORT
	DATA = postLoc.s29_gasLeaseLvl_20171102
	DBMS = CSV
	LABEL
	OUTFILE = 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\s29_gasLeaseLvl_20171102.csv'
	REPLACE;
RUN;
/********-*********-*********-*********-*********-*********-*********/
/* Create and export single oil wellop level file								*/
/********-*********-*********-*********-*********-*********-*********/
DATA workLoc.oilMerge (DROP = _TYPE_ _FREQ_); 
	MERGE  
		workLoc.oilSumByWellop (IN = o)
		workLoc.oilVf (IN = vf); 
	BY wellop; 
	bgMatch = o ;
	IF _TYPE_ ~= 0 ;
	bg1mi = _FREQ_ ;
RUN;
DATA postLoc.s29_oilLeaseLvl_20171102;
	SET workLoc.oilMerge ;
	popDens = age_base / ( area * 0.0000003861022 ); 
	perOld = 100 * age_old / age_base ; 
	perBlack = 100 * race_black / race_base; 
	perWhiteNonhisp = 100 * race_white / race_base; 
	perUneducated = 100 * educ_nodiploma / educ_base; 
	perNonEnglishHh = 100 * fluency_limenglish / fluency_base; 
	perPoverty = 100 * pov_belowpovertyline / pov_base; 
	perIncLess10k = 100 * inc_less10K / inc_base; 
	perInc10Kto14999 = 100 * inc_10Kto14999 / inc_base;  
	perInc15Kto19999 = 100 * inc_15Kto19999 / inc_base;  
	perInc20Kto24999 = 100 * inc_20Kto24999 / inc_base;  
	perInc25Kto29999 = 100 * inc_25Kto29999 / inc_base; 
	perInc30Kto34999 = 100 * inc_30Kto34999 / inc_base; 
	perInc35Kto39999 = 100 * inc_35Kto39999 / inc_base; 
	perInc40Kto44999 = 100 * inc_40Kto44999 / inc_base; 
	perInc45Kto49999 = 100 * inc_45Kto49999 / inc_base; 
	perInc50Kto59999 = 100 * inc_50Kto59999 / inc_base; 
	perInc60Kto74999 = 100 * inc_60Kto74999 / inc_base; 
	perInc75Kto99999 = 100 * inc_75Kto99999 / inc_base; 
	perInc100Kto124999 = 100 * inc_100Kto124999 / inc_base; 
	perInc125Kto149999 = 100 * inc_125Kto149999 / inc_base; 
	perInc150Kto199999 = 100 * inc_150Kto199999 / inc_base; 
	perIncMore200k = 100 * inc_more200k / inc_base;  
	perConstructExtractOcc = 100 * occ_ce / occ_base; 
	oohu_base = oohu_less10K + oohu_10Kto14999 + oohu_15Kto19999 
		+ oohu_20Kto24999 + oohu_25Kto29999 + oohu_30Kto34999 
		+ oohu_35Kto39999 + oohu_40Kto49999 + oohu_50Kto59999 
		+ oohu_60Kto69999 + oohu_70Kto79999 + oohu_80Kto89999 
		+ oohu_90Kto99999 + oohu_100Kto124999  + oohu_125Kto149999 
		+ oohu_150Kto174999 + oohu_175Kto199999 + oohu_200Kto249999  
		+ oohu_250Kto299999 + oohu_300Kto399999 + oohu_400Kto499999  
		+ oohu_500Kto749999 + oohu_750Kto999999 + oohu_1MMore ;
	perOohuLess10k = 100 * oohu_less10k / oohu_base; 
	perOohu10Kto14999 = 100 * oohu_10Kto14999  / oohu_base; 
	perOohu15Kto19999 = 100 * oohu_15Kto19999 / oohu_base; 
	perOohu20Kto24999 = 100 * oohu_20Kto24999 / oohu_base; 
	perOohu25Kto29999 = 100 * oohu_25Kto29999 / oohu_base; 
	perOohu30Kto34999 = 100 * oohu_30Kto34999 / oohu_base; 
	perOohu35Kto39999 = 100 * oohu_35Kto39999 / oohu_base; 
	perOohu40Kto49999 = 100 * oohu_40Kto49999 / oohu_base; 
	perOohu50Kto59999 = 100 * oohu_50Kto59999 / oohu_base; 
	perOohu60Kto69999 = 100 * oohu_60Kto69999 / oohu_base; 
	perOohu70Kto79999 = 100 * oohu_70Kto79999 / oohu_base; 
	perOohu80Kto89999 = 100 * oohu_80Kto89999 / oohu_base; 
	perOohu90Kto99999 = 100 * oohu_90Kto99999 / oohu_base; 
	perOohu100Kto124999 = 100 * oohu_100Kto124999 / oohu_base; 
	perOohu125Kto149999 = 100 * oohu_125Kto149999 / oohu_base; 
	perOohu150Kto174999 = 100 * oohu_150Kto174999 / oohu_base; 
	perOohu175Kto199999 = 100 * oohu_175Kto199999 / oohu_base; 
	perOohu200Kto249999 = 100 * oohu_200Kto249999 / oohu_base; 
	perOohu250Kto299999 = 100 * oohu_250Kto299999 / oohu_base; 
	perOohu300Kto39999 = 100 * oohu_300Kto399999 / oohu_base; 
	perOohu400Kto499999 = 100 * oohu_400Kto499999 / oohu_base; 
	perOohu500Kto749999 = 100 * oohu_500Kto749999 / oohu_base; 
	perOohu750Kto999999 = 100 * oohu_750Kto999999 / oohu_base; 
	perOohu1mmore = 100 * oohu_1mmore / oohu_base; 
	incMedian = . ;
		IF incMedian = . & perIncLess10k >= 50 
			THEN incMedian = 1 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 >= 50 
			THEN incMedian = 2 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 >= 50 
			THEN incMedian = 3 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 >= 50 
			THEN incMedian = 4 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 >= 50 
			THEN incMedian = 5 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 >= 50 
			THEN incMedian = 6 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 >= 50 
			THEN incMedian = 7 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 >= 50 
			THEN incMedian = 8 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 >= 50 
			THEN incMedian = 9 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 >= 50 
			THEN incMedian = 10 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 >= 50 
			THEN incMedian = 11 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 >= 50 
			THEN incMedian = 12 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 >= 50 
			THEN incMedian = 13 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 + perInc125Kto149999 >= 50 
			THEN incMedian = 14 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 + perInc125Kto149999 + perInc150Kto199999 >= 50 
			THEN incMedian = 15 ; 
		IF incMedian = . & perIncLess10k + perInc10Kto14999 + perInc15Kto19999 + perInc20Kto24999 + perInc25Kto29999 + perInc30Kto34999 + perInc35Kto39999 + perInc40Kto44999 + perInc45Kto49999 + perInc50Kto59999 + perInc60Kto74999 + perInc75Kto99999 + perInc100Kto124999 + perInc125Kto149999 + perInc150Kto199999 + perIncMore200k >= 50 
			THEN incMedian = 16 ; 
	oohuMedian = . ;
		IF oohuMedian = . & perOohuLess10k >= 50 
			THEN oohuMedian = 1 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 >= 50 
			THEN oohuMedian = 2 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 >= 50 
			THEN oohuMedian = 3 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 >= 50 
			THEN oohuMedian = 4 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 >= 50 
			THEN oohuMedian = 5 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 >= 50 
			THEN oohuMedian = 6 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 >= 50 
			THEN oohuMedian = 7 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 >= 50 
			THEN oohuMedian = 8 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 >= 50 
			THEN oohuMedian = 9 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 >= 50 
			THEN oohuMedian = 10 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 >= 50 
			THEN oohuMedian = 11 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 >= 50 
			THEN oohuMedian = 12 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 >= 50 
			THEN oohuMedian = 13 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 >= 50 
			THEN oohuMedian = 14 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 >= 50 
			THEN oohuMedian = 15 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 >= 50 
			THEN oohuMedian = 16 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 >= 50 
			THEN oohuMedian = 17 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 >= 50 
			THEN oohuMedian = 18 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 >= 50 
			THEN oohuMedian = 19 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 >= 50 
			THEN oohuMedian = 20 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 >= 50 
			THEN oohuMedian = 21 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 + perOohu500Kto749999 >= 50 
			THEN oohuMedian = 22 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 + perOohu500Kto749999 + perOohu750Kto999999 >= 50 
			THEN oohuMedian = 23 ; 
		IF oohuMedian = . & perOohuLess10k + perOohu10Kto14999 + perOohu15Kto19999 + perOohu20Kto24999 + perOohu25Kto29999 + perOohu30Kto34999 + perOohu35Kto39999 + perOohu40Kto49999 + perOohu50Kto59999 + perOohu60Kto69999 + perOohu70Kto79999 + perOohu80Kto89999 + perOohu90Kto99999 + perOohu100Kto124999 + perOohu125Kto149999 + perOohu150Kto174999 + perOohu175Kto199999 + perOohu200Kto249999 + perOohu250Kto299999 + perOohu300Kto39999 + perOohu400Kto499999 + perOohu500Kto749999 + perOohu750Kto999999 + perOohu1mmore >= 50 
			THEN oohuMedian = 24 ; 	
		IF lease_oil_prod_vol > 0 OR lease_csgd_prod_vol > 0 ;
RUN;
PROC EXPORT
	DATA = postLoc.s29_oilLeaseLvl_20171102
	DBMS = CSV
	LABEL
	OUTFILE = 'D:\Dropbox\Academic\Active\Research\EOCPC\Posted\s29_oilLeaseLvl_20171102.csv'
	REPLACE;
RUN;

