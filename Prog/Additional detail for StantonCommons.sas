/**************************************************************************
 Program:  Additioanl Detail for Stanton Commons.sas
 Library:  Stanc
 Project:  NeighborhoodInfo DC
 Author:   Yipeng Su
 Created:  9/19/18
 Version:  SAS 9.4
 Environment:  Local Windows session
 
 Description:  

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( ACS )
%DCData_lib( Vital )


** Define time periods  **;
%let _years = 2012_16;
%let year_lbl = 2012-16;

%macro Compile_stanc_data (geo, geosuf);

data compile_stanc_tabs_&geosuf;
	merge 
		ACS.acs_&_years._dc_sum_tr_&geosuf
			(keep= &geo
			      NumMarriedFamRelatedChildrenunder6only_&_years. 
			      NumMarriedFamRelatedChildrenunder6_17_&_years. 
				  NumMarriedFamRelatedChildrenunder17plusonly_&_years. 
				  NumMarriedFamnoRelatedChildren_&_years. 
			      NumFamRelatedChildrenunder6only_mh_&_years. 
			      NumFamRelatedChildrenunder6_17_mh_&_years. 
				  NumFamRelatedChildrenunder17plusonly_mh_&_years. 
				  NumFamnoRelatedChildren_mh_&_years. 
			      NumFamRelatedChildrenunder6only_fh_&_years. 
			      NumFamRelatedChildrenunder6_17_fh_&_years. 
				  NumFamRelatedChildrenunder17plusonly_fh_&_years. 
				  NumFamnoRelatedChildren_fh_&_years.
				)

			Vital.Births_sum_&geosuf
            (keep=&geo

           /*detail on characteristics of mothers by level of prenatal care received*/
			births_prenat_adeq_2016  births_prenat_adeq_15to19_2016 births_prenat_adeq_20to24_2016 births_prenat_adeq_25to29_2016 
			births_prenat_adeq_30to34_2016 births_prenat_adeq_35to39_2015 births_prenat_adeq_40to44_2016 births_prenat_adeq_45plus_2016
			births_prenat_adeq_asn_2016 births_prenat_adeq_blk_2016 births_prenat_adeq_hsp_2016 births_prenat_adeq_oth_2016 
			births_prenat_adeq_wht_2016

            births_prenat_inad_2016 births_prenat_inad_0to14_2016 births_prenat_inad_15to19_2016 births_prenat_inad_20to24_2016
            births_prenat_inad_25to29_2016 births_prenat_inad_30to34_2016 births_prenat_inad_35to39_2016 births_prenat_inad_40to44_2016
            births_prenat_inad_45plus_2016 births_prenat_inad_asn_2016 births_prenat_inad_blk_2016 births_prenat_inad_hsp_2016
            births_prenat_inad_oth_2016 births_prenat_inad_wht_2016
    
			births_prenat_intr_2016 births_prenat_intr_0to14_2016 births_prenat_intr_15to19_2016 births_prenat_intr_20to24_2015
            births_prenat_intr_25to29_2016 births_prenat_intr_30to34_2016 births_prenat_intr_35to39_2016 births_prenat_intr_40to44_2016
            births_prenat_intr_45plus_2016 births_prenat_intr_asn_2016 births_prenat_intr_blk_2016 births_prenat_intr_hsp_2016 
            births_prenat_intr_oth_2016 births_prenat_intr_wht_2016

			births_w_prenat_2016 births_w_prenat_0to14_2016 births_w_prenat_15to19_2016 births_w_prenat_20to24_2016 births_w_prenat_25to29_2016
            births_w_prenat_30to34_2016 births_w_prenat_35to39_2016 births_w_prenat_40to44_2016 births_w_prenat_45plus_2016 births_w_prenat_asn_2016
            births_w_prenat_blk_2016 births_w_prenat_hsp_2016 births_w_prenat_oth_2016 births_w_prenat_wht_2016
       
			   
			   )
;
by &geo.;
format deaths_: suppr5f.;
format births_: suppr5f.;
run;

data calc_stanc_tabs_&geosuf;
	set compile_stanc_tabs_&geosuf;
        /*Population by Age and Sex*/
               PopUnder18Years_&_years. = PopUnder18YearsM_&_years. + PopUnder18YearsF_&_years.;
               Pop18_34Years_&_years. = Pop18_34YearsM_&_years.+ Pop18_34YearsF_&_years.;
               Pop35_64Years_&_years. = Pop35_64YearsM_&_years. + Pop35_64YearsF_&_years.;
               Pop65andOverYears_&_years. = Pop65andOverYearsM_&_years. + Pop65andOverYearsF_&_years.;

			   PopFemale_&_years. = PopUnder18YearsF_&_years.+ Pop18_34YearsF_&_years. + Pop35_64YearsF_&_years. + Pop65andOverYearsF_&_years.;
               PopMale_&_years. = PopUnder18YearsM_&_years.+ Pop18_34YearsM_&_years. + Pop35_64YearsM_&_years. + Pop65andOverYearsM_&_years.;
run;

proc transpose data=calc_stanc_tabs_&geosuf out=stanc_tabs_&geosuf(label="Stanton Commons Additioanl Tabulations, &geo");
	var 	&geo 	

		/*ACS Population 2012-2016*/
			totpop_&_years.
            PopUnder18Years_&_years.
            Pop18_34Years_&_years.
			Pop35_64Years_&_years.
			Pop65andOverYears_&_years.
			PopFemale_&_years.
			PopMale_&_years.
			FamMarriedCouple_&_years.
			FamMaleholder_&_years.
			FamFemaleholder_&_years.
			Nonfamlivingalone_&_years.
			Nonfamnotlivingalone_&_years.

  /*Vital Births and Deaths*/
               /*births_total_2000 births_total_2001 births_total_2002*/ births_total_2003 births_total_2004
			   births_total_2005 births_total_2006 births_total_2007 births_total_2008 births_total_2009
               births_total_2010 births_total_2011 births_total_2012 births_total_2013 births_total_2014
			   births_total_2015 births_total_2016

               /*births_prenat_adeq_2000 births_prenat_adeq_2001 births_prenat_adeq_2002*/ births_prenat_adeq_2003 births_prenat_adeq_2004
			   births_prenat_adeq_2005 births_prenat_adeq_2006 births_prenat_adeq_2007 births_prenat_adeq_2008 births_prenat_adeq_2009
               births_prenat_adeq_2010 births_prenat_adeq_2011 births_prenat_adeq_2012 births_prenat_adeq_2013 births_prenat_adeq_2014
			   births_prenat_adeq_2015 births_prenat_adeq_2016

               /*births_prenat_1st_2000 births_prenat_1st_2001 births_prenat_1st_2002 */ births_prenat_1st_2003 births_prenat_1st_2004
			   births_prenat_1st_2005 births_prenat_1st_2006 births_prenat_1st_2007 births_prenat_1st_2008 births_prenat_1st_2009
               births_prenat_1st_2010 births_prenat_1st_2011 births_prenat_1st_2012 births_prenat_1st_2013 births_prenat_1st_2014
			   births_prenat_1st_2015 births_prenat_1st_2016

			   /*births_low_wt_2000 births_low_wt_2001 births_low_wt_2002*/ births_low_wt_2003 births_low_wt_2004
			   births_low_wt_2005 births_low_wt_2006 births_low_wt_2007 births_low_wt_2008 births_low_wt_2009
               births_low_wt_2010 births_low_wt_2011 births_low_wt_2012 births_low_wt_2013 births_low_wt_2014
			   births_low_wt_2015 births_low_wt_2016

			   /*births_preterm_2000 births_preterm_2001 births_preterm_2002*/ births_preterm_2003 births_preterm_2004
			   births_preterm_2005 births_preterm_2006 births_preterm_2007 births_preterm_2008 births_preterm_2009
               births_preterm_2010 births_preterm_2011 births_preterm_2012 births_preterm_2013 births_preterm_2014
			   births_preterm_2015 births_preterm_2016
		;

id &geo; 
run; 

%File_info( data=compile_stanc_tabs_&geosuf, contents=n, printobs=0 )

proc export data=stanc_tabs_&geosuf
	outfile="L:\Libraries\StanC\Doc\Additional_Stanctabs_format_&geosuf..csv"
	dbms=csv replace;
	run;


%mend Compile_stanc_data;


%Compile_stanc_data (stantoncommons, stanc);
%Compile_stanc_data (ward2012, wd12);
%Compile_stanc_data (city, city);


