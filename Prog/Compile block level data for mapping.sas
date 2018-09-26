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
** create age groups based on public health research standards https://ibis.health.state.nm.us/resource/AARate.html  **;
data death;
	set vital.deaths_2016;

	if age_calc < 5 then age_group = 1;
		else if 5 <= age_calc  <18 then age_group = 2;
		else if 18 <= age_calc  <65 then age_group = 3;
        else if age_calc  >= 65 then age_group = 4;
		else age_group = .;

run;

proc sort data = death; by age_group geobg2010; run;

proc summary data=death;
by age_group geobg2010;
var deaths_total;
	output	out=death_age_bg2010	sum= ;
run;
proc sort data= death_age_bg2010;
by  geobg2010;
run;

proc transpose data=death_age_bg2010 out=death_age_bg2010_new prefix = death_age_group_;
var deaths_total; 
by geobg2010;
id age_group; 
run;

/*calculate birth by block group*/

data births;
set vital.births_2016;
run;

proc sort data = births; by geobg2010; run;

proc summary data=births;
by geobg2010;
var births_total;
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

data pop;
merge death_age_bg2010_new births_bg2010 population;
by geobg2010;
run;

proc export data=birth_pop
	outfile="&_dcdata_default_path\Stanc\Prog\pop_birth_blockgroup.csv"
	dbms=csv replace;
run;
