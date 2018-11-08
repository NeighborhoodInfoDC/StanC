/**************************************************************************
 Program:  Compile block group level data 3 year births data for mapping.sas
 Library:  Stanc
 Project:  NeighborhoodInfo DC
 Author:   Yipeng Su
 Created:  11/7/18
 Version:  SAS 9.4
 Environment:  Windows with SAS/Connect
 
 Description:  Summarize total population age group and geograpy for creating maps for Stanton Commons

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Vital )
%DCData_lib( Census )
%DCData_lib( ACS )

%let _years=2012_16;

/*calculate birth by block group*/

data births2016;
set vital.births_2016;
keep geobg2010 bgid births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
run;

proc sort data = births2016; by geobg2010; run;

proc summary data=births2016;
by geobg2010;
var births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
output	out=births2016_bg2010	sum= ;
run;

proc sort data = births2016_bg2010;
by geobg2010;
run;

data births2016_bg2010;
set births2016_bg2010;
bgid= geobg2010;
run;

proc export data=births2016_bg2010
	outfile="&_dcdata_default_path\Stanc\Prog\birth_blockgrp_2016.csv"
	dbms=csv replace;
run;

data births2015;
set vital.births_2015;
bgid = geobg2010;
keep geobg2010 bgid births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
run;

proc sort data = births2015; by geobg2010; run;

proc summary data=births2015;
by geobg2010;
var births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
output	out=births2015_bg2010	sum= ;
run;

proc sort data = births2015_bg2010;
by geobg2010;
run;

data births2015_bg2010;
set births2015_bg2010;
bgid=geobg2010;
run;

proc export data=births2015_bg2010
	outfile="&_dcdata_default_path\Stanc\Prog\birth_blockgrp_2015.csv"
	dbms=csv replace;
run;

data births2014;
set vital.births_2014;
bgid = geobg2010;
keep geobg2010 bgid births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
run;

proc sort data = births2014; by geobg2010; run;

proc summary data=births2014;
by geobg2010;
var births_total births_prenat_adeq births_prenat_inad births_low_wt births_preterm;
output	out=births2014_bg2010	sum= ;
run;

proc sort data = births2014_bg2010;
by geobg2010;
run;

data births2014_bg2010;
set  births2014_bg2010;
bgid=geobg2010;
run;

proc export data=births2014_bg2010
	outfile="&_dcdata_default_path\Stanc\Prog\birth_blockgrp_2014.csv"
	dbms=csv replace;
run;
