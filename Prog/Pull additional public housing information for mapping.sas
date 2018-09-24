/**************************************************************************
 Program:  Pull additional public housing information for mapping.sas
 Library:  Stanc
 Project:  NeighborhoodInfo DC
 Author:   Yipeng Su
 Created:  9/24/18
 Version:  SAS 9.4
 Environment:  Local Windows session
 
 Description:  

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( ACS )
%DCData_lib( prescat )

data projects;
set prescat.Project;
keep proj_name nlihc_id status proj_x proj_y proj_addre proj_units_tot proj_units_assist_max geo2010 tractid;
if subsidized ne 0 then output;
run;

data stancprojects;
set projects;
if geo2010 in ("11001007406","11001007407", "11001007408", "11001007502", "11001007504") then output;
run;

proc sort data=stancprojects;
by nlihc_id;
run;

data subsidy;
set prescat.Subsidy;
keep nlihc_id program subsidy_active units_assist;
run;

proc sort data=subsidy;
by nlihc_id;
run;

data subsidycat;
merge stancprojects subsidy;
by nlihc_id;
if Geo2010 ne "" then output;
run; 
