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
			      numfamfhnrkids_&_years. 
			      numfamfhrkids6_17_&_years. 
				  numfamfhrkidsu6u17_&_years. 
				  numfamfhrkidsu6_&_years. 
			      numfammhnrkids_&_years. 
			      numfammhrkids6_17_&_years. 
				  numfammhrkidsu6u17_&_years. 
				  numfammhrkidsu6_&_years. 
			      nummarfamnrkids_&_years. 
			      nummarfamrkids6_17_&_years. 
				  nummarfamrkidsu6u17_&_years. 
				  nummarfamrkidsu6_&_years.
				)

			Vital.Births_sum_&geosuf
            (keep=&geo
           /*detail on characteristics of mothers by level of prenatal care received*/
			births_prenat_adeq_2016  births_prenat_adeq_0to14 births_prenat_adeq_15to19_2016 births_prenat_adeq_20to24_2016 births_prenat_adeq_25to29_2016 
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


proc transpose data=compile_stanc_tabs_&geosuf out=stanc_tabs_&geosuf(label="Stanton Commons Additioanl Tabulations, &geo");
	var 	&geo 	

		/*family type breakdown*/
			     numfamfhnrkids_&_years. 
			      numfamfhrkids6_17_&_years. 
				  numfamfhrkidsu6u17_&_years. 
				  numfamfhrkidsu6_&_years. 
			      numfammhnrkids_&_years. 
			      numfammhrkids6_17_&_years. 
				  numfammhrkidsu6u17_&_years. 
				  numfammhrkidsu6_&_years. 
			      nummarfamnrkids_&_years. 
			      nummarfamrkids6_17_&_years. 
				  nummarfamrkidsu6u17_&_years. 
				  nummarfamrkidsu6_&_years.

  /*Vital Births and Deaths*/
            births_prenat_adeq_2016  births_prenat_adeq_0to14 births_prenat_adeq_15to19_2016 births_prenat_adeq_20to24_2016 births_prenat_adeq_25to29_2016 
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
		;

id &geo; 
run; 

%File_info( data=stanc_tabs_&geosuf, contents=n, printobs=0 )

proc export data=stanc_tabs_&geosuf
	outfile="L:\Libraries\StanC\Doc\Additional_Stanctabs_format_&geosuf..csv"
	dbms=csv replace;
	run;


%mend Compile_stanc_data;


%Compile_stanc_data (stantoncommons, stanc);
%Compile_stanc_data (ward2012, wd12);
%Compile_stanc_data (city, city);


