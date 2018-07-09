/**************************************************************************
 Program:  StanCPresentationResults.sas
 Library:  Stanc
 Project:  NeighborhoodInfo DC
 Author:   Yipeng and Rob
 Created:  6/23/18
 Version:  SAS 9.4
 Environment:  Local Windows session
 
 Description:  

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

libname ys "S:\YS";

** Define libraries ;
/*%DCData_lib( work )*/


%macro Compile_stanc_data (geo, geosuf);

data compile_stanc_tabs_&geosuf._olddata;
	merge    
			ys.Births_sum_&geosuf._olddata
            (keep=&geo
               births_total_2000 births_total_2001 births_total_2002 

               births_prenat_adeq_2000 births_prenat_adeq_2001 births_prenat_adeq_2002 

               births_prenat_1st_2000 births_prenat_1st_2001 births_prenat_1st_2002

			   births_low_wt_2000 births_low_wt_2001 births_low_wt_2002 

			   births_preterm_2000 births_preterm_2001 births_preterm_2002
			   )

             ys.Deaths_sum_&geosuf._olddata
            (keep=&geo
               deaths_total_2000 deaths_total_2001 deaths_total_2002 deaths_total_2003 deaths_total_2004
			   deaths_total_2005 deaths_total_2006 deaths_total_2007 

               deaths_15to19_2000 deaths_15to19_2001 deaths_15to19_2002 deaths_15to19_2003 deaths_15to19_2004 deaths_15to19_2005 
               deaths_15to19_2006 deaths_15to19_2007 

               deaths_20to24_2000 deaths_20to24_2001 deaths_20to24_2002 deaths_20to24_2003 deaths_20to24_2004 deaths_20to24_2005 
               deaths_20to24_2006 deaths_20to24_2007 

               deaths_adult_2000 deaths_adult_2001 deaths_adult_2002 deaths_adult_2003 deaths_adult_2004 deaths_adult_2005 
               deaths_adult_2006 deaths_adult_2007 

			   deaths_accident_2000 deaths_accident_2001 deaths_accident_2002 deaths_accident_2003 deaths_accident_2004 deaths_accident_2005 
               deaths_accident_2006 deaths_accident_2007 

               deaths_cancer_2000 deaths_cancer_2001 deaths_cancer_2002 deaths_cancer_2003 deaths_cancer_2004 deaths_cancer_2005 
               deaths_cancer_2006 deaths_cancer_2007 

               deaths_cereb_2000 deaths_cereb_2001 deaths_cereb_2002 deaths_cereb_2003 deaths_cereb_2004 deaths_cereb_2005 
               deaths_cereb_2006 deaths_cereb_2007 

			   deaths_diabetes_2000 deaths_diabetes_2001 deaths_diabetes_2002 deaths_diabetes_2003 deaths_diabetes_2004 deaths_diabetes_2005 
               deaths_diabetes_2006 deaths_diabetes_2007 

               deaths_heart_2000 deaths_heart_2001 deaths_heart_2002 deaths_heart_2003 deaths_heart_2004 deaths_heart_2005 
               deaths_heart_2006 deaths_heart_2007 

               deaths_hiv_2000 deaths_hiv_2001 deaths_hiv_2002 deaths_hiv_2003 deaths_hiv_2004 deaths_hiv_2005 
               deaths_hiv_2006 deaths_hiv_2007 

			   deaths_homicide_2000 deaths_homicide_2001 deaths_homicide_2002 deaths_homicide_2003 deaths_homicide_2004 deaths_homicide_2005 
               deaths_homicide_2006 deaths_homicide_2007 

			   deaths_hypert_2000 deaths_hypert_2001 deaths_hypert_2002 deaths_hypert_2003 deaths_hypert_2004 deaths_hypert_2005 
               deaths_hypert_2006 deaths_hypert_2007 

               deaths_liver_2000 deaths_liver_2001 deaths_liver_2002 deaths_liver_2003 deaths_liver_2004 deaths_liver_2005 
               deaths_liver_2006 deaths_liver_2007

               deaths_oth_caus_2000 deaths_oth_caus_2001 deaths_oth_caus_2002 deaths_oth_caus_2003 deaths_oth_caus_2004 deaths_oth_caus_2005 
               deaths_oth_caus_2006 deaths_oth_caus_2007 

			   deaths_suicide_2000 deaths_suicide_2001 deaths_suicide_2002 deaths_suicide_2003 deaths_suicide_2004 deaths_suicide_2005 
               deaths_suicide_2006 deaths_suicide_2007 
			   )
;
by &geo.;
format deaths_: suppr5f.;
format births_: suppr5f.;
run;

data calc_stanc_tabs_&geosuf._olddata;
	set compile_stanc_tabs_&geosuf._olddata;
run;

proc transpose data=calc_stanc_tabs_&geosuf._olddata out=stanc_tabs_&geosuf._olddata(label="Stanton Commons Tabulations, &geo");
	var 	&geo 	


  /*Vital Births and Deaths*/
               births_total_2000 births_total_2001 births_total_2002

               births_prenat_adeq_2000 births_prenat_adeq_2001 births_prenat_adeq_2002

               births_prenat_1st_2000 births_prenat_1st_2001 births_prenat_1st_2002 

			   births_low_wt_2000 births_low_wt_2001 births_low_wt_2002

			   births_preterm_2000 births_preterm_2001 births_preterm_2002

               deaths_total_2000 deaths_total_2001 deaths_total_2002 deaths_total_2003 deaths_total_2004
			   deaths_total_2005 deaths_total_2006 deaths_total_2007

               deaths_15to19_2000 deaths_15to19_2001 deaths_15to19_2002 deaths_15to19_2003 deaths_15to19_2004 deaths_15to19_2005 
               deaths_15to19_2006 deaths_15to19_2007 

               deaths_20to24_2000 deaths_20to24_2001 deaths_20to24_2002 deaths_20to24_2003 deaths_20to24_2004 deaths_20to24_2005 
               deaths_20to24_2006 deaths_20to24_2007 

               deaths_adult_2000 deaths_adult_2001 deaths_adult_2002 deaths_adult_2003 deaths_adult_2004 deaths_adult_2005 
               deaths_adult_2006 deaths_adult_2007 

			   deaths_accident_2000 deaths_accident_2001 deaths_accident_2002 deaths_accident_2003 deaths_accident_2004 deaths_accident_2005 
               deaths_accident_2006 deaths_accident_2007 

               deaths_cancer_2000 deaths_cancer_2001 deaths_cancer_2002 deaths_cancer_2003 deaths_cancer_2004 deaths_cancer_2005 
               deaths_cancer_2006 deaths_cancer_2007 

               deaths_cereb_2000 deaths_cereb_2001 deaths_cereb_2002 deaths_cereb_2003 deaths_cereb_2004 deaths_cereb_2005 
               deaths_cereb_2006 deaths_cereb_2007 

			   deaths_diabetes_2000 deaths_diabetes_2001 deaths_diabetes_2002 deaths_diabetes_2003 deaths_diabetes_2004 deaths_diabetes_2005 
               deaths_diabetes_2006 deaths_diabetes_2007 

               deaths_heart_2000 deaths_heart_2001 deaths_heart_2002 deaths_heart_2003 deaths_heart_2004 deaths_heart_2005 
               deaths_heart_2006 deaths_heart_2007 

               deaths_hiv_2000 deaths_hiv_2001 deaths_hiv_2002 deaths_hiv_2003 deaths_hiv_2004 deaths_hiv_2005 
               deaths_hiv_2006 deaths_hiv_2007 

			   deaths_homicide_2000 deaths_homicide_2001 deaths_homicide_2002 deaths_homicide_2003 deaths_homicide_2004 deaths_homicide_2005 
               deaths_homicide_2006 deaths_homicide_2007 

			   deaths_hypert_2000 deaths_hypert_2001 deaths_hypert_2002 deaths_hypert_2003 deaths_hypert_2004 deaths_hypert_2005 
               deaths_hypert_2006 deaths_hypert_2007 

               deaths_liver_2000 deaths_liver_2001 deaths_liver_2002 deaths_liver_2003 deaths_liver_2004 deaths_liver_2005 
               deaths_liver_2006 deaths_liver_2007 

               deaths_oth_caus_2000 deaths_oth_caus_2001 deaths_oth_caus_2002 deaths_oth_caus_2003 deaths_oth_caus_2004 deaths_oth_caus_2005 
               deaths_oth_caus_2006 deaths_oth_caus_2007 

			   deaths_suicide_2000 deaths_suicide_2001 deaths_suicide_2002 deaths_suicide_2003 deaths_suicide_2004 deaths_suicide_2005 
               deaths_suicide_2006 deaths_suicide_2007 
		;

id &geo; 
run; 

%File_info( data=stanc_tabs_&geosuf._olddata, contents=n, printobs=0 )

proc export data=stanc_tabs_&geosuf._olddata
	outfile="L:\Libraries\StanC\Doc\Stanctabs_format_earlyyears_&geosuf..csv"
	dbms=csv replace;
	run;


%mend Compile_stanc_data;


%Compile_stanc_data (stantoncommons, stanc);
%Compile_stanc_data (ward2012, wd12);
%Compile_stanc_data (city, city);


