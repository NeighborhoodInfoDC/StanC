/**************************************************************************
 Program:  Compile block group level data for mapping.sas
 Library:  Stanc
 Project:  NeighborhoodInfo DC
 Author:   Yipeng Su
 Created:  9/26/18
 Version:  SAS 9.4
 Environment:  Windows with SAS/Connect
 
 Description:  Summarize total population age group and geograpy for creating maps for Stanton Commons

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Vital )
%DCData_lib( Census )

/*calculate birth by block group*/

data births;
set vital.births_2016;
keep geobg2010 bgid births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
bgid = geobg2010+0;
run;

proc sort data = births; by geobg2010; run;

proc summary data=births;
by geobg2010;
var births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm bgid;
output	out=births_bg2010	sum= ;
run;

proc sort data = births_bg2010;
by geobg2010;
run;

** Repeat for census population data as denominator  **;
data population (where=(geobg2010 ne ''));
keep geobg2010 agegroup_1 agegroup_2 agegroup_3 agegroup_4;
	set census.Census_sf1_2010_dc_blks;
        agegroup_1= sum(p12ai27, p12ai3);
		agegroup_2= sum(p12ai28, p12ai4, p12ai29,p12ai5, p12ai30, p12ai6 );
		agegroup_3= sum(p12ai7, p12ai31, p12ai32,p12ai8,p12ai9, p12ai33, p12ai34,p12ai35, p12ai36, p12ai37,p12ai38, p12ai39, p12ai40, p12ai41, p12ai42, p12ai43,p12ai10, p12ai11, p12ai12, p12ai13,p12ai14,p12ai15,p12ai16, p12ai17, p12ai18, p12ai19 );
		agegroup_4= sum(p12ai20,p12ai21, p12ai22, p12ai23, p12ai24,p12ai25,p12ai44, p12ai45, p12ai46,p12ai47, p12ai48, p12ai49 );

;
	 label agegroup_1="0-5 year old";
        label   agegroup_2= "5 - 17 Years old";
       label    agegroup_3= "18 - 64 Years old";
       label    agegroup_4= "65 and older";

run;

proc sort data= population;
by geobg2010;
run;

proc summary data=population;
by geobg2010;
var agegroup_1 agegroup_2 agegroup_3 agegroup_4;
output	out=pop_bg2010	sum= ;
run;

data pop;
merge births_bg2010 pop_bg2010;
by geobg2010;
run;
/*
data pop;
set pop;
if geo2010 in ("11001007406","11001007407", "11001007408", "11001007502", "11001007504") then stanc = "1";
run;
*/

proc export data=pop
	outfile="&_dcdata_default_path\Stanc\Prog\pop_map_blockgroup.csv"
	dbms=csv replace;
run;


/*by census tract*/

data births_tract;
set vital.births_2016;
keep geo2010 tractid births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
tractid = geo2010+0;
run;

proc sort data = births_tract; by geo2010; run;

proc summary data=births_tract;
by geo2010;
var births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm tractid;
output	out=births_tract	sum= ;
run;

proc sort data = births_tract;
by geo2010;
run;

** Repeat for census population data as denominator  **;
data population_tract (where=(geo2010 ne ''));
keep geo2010 agegroup_1 agegroup_2 agegroup_3 agegroup_4;
	set census.Census_sf1_2010_dc_ph;
        agegroup_1= sum(p12ai27, p12ai3);
		agegroup_2= sum(p12ai28, p12ai4, p12ai29,p12ai5, p12ai30, p12ai6 );
		agegroup_3= sum(p12ai7, p12ai31, p12ai32,p12ai8,p12ai9, p12ai33, p12ai34,p12ai35, p12ai36, p12ai37,p12ai38, p12ai39, p12ai40, p12ai41, p12ai42, p12ai43,p12ai10, p12ai11, p12ai12, p12ai13,p12ai14,p12ai15,p12ai16, p12ai17, p12ai18, p12ai19 );
		agegroup_4= sum(p12ai20,p12ai21, p12ai22, p12ai23, p12ai24,p12ai25,p12ai44, p12ai45, p12ai46,p12ai47, p12ai48, p12ai49 );

;
	 label agegroup_1="0-5 year old";
        label   agegroup_2= "5 - 17 Years old";
       label    agegroup_3= "18 - 64 Years old";
       label    agegroup_4= "65 and older";

run;

proc sort data= population_tract;
by geo2010;
run;

proc summary data=population_tract;
by geo2010;
var agegroup_1 agegroup_2 agegroup_3 agegroup_4;
output	out=pop_tract2010	sum= ;
run;

data pop_tract;
merge births_tract pop_tract2010;
by geo2010;
run;

data pop_tract;
set pop_tract;
if geo2010 in ("11001007406","11001007407", "11001007408", "11001007502", "11001007504") then stanc = "1";
run;


proc export data=pop_tract
	outfile="&_dcdata_default_path\Stanc\Prog\pop_map_tract.csv"
	dbms=csv replace;
run;
