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
keep proj_name status proj_x proj_y proj_addre proj_units_tot proj_units_assist_max geo2010 tractid;
if subsidized ne 0 then output;
run;

data stancprojects;
set projects;
if geo2010 in ("1100107406","1100107407", "1100107408", "1100107502", "1100107504") then output;
run;

