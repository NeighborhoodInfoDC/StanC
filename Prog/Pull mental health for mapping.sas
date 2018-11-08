/**************************************************************************
 Program:  Pull CDC 500 data for mapping.sas
 Library:  Stanc
 Project:  NeighborhoodInfo DC
 Author:   Yipeng Su
 Created:  11/7/18
 Version:  SAS 9.4
 Environment:  Windows with SAS/Connect
 
 Description:  Pull mental health not good for adult for creating maps for Stanton Commons

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( CDC500 )

data mental;
set Cdc500.Cdc500_2017_sum_tr10;
keep geo2010 geoid mhlth_crudeprev;
geoid=geo2010;
run;

proc export data=mental
	outfile="&_dcdata_default_path\Stanc\Prog\mentalhealth_tract.csv"
	dbms=csv replace;
run;
