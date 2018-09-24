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
keep proj_name status proj_x proj_y proj_addre proj_units_tot proj_units_assist_max geo2010;
if subsidized ne 0 then output;
run;

data stancprojects;
set projects;
if geo2010 in ("DC Tract 74.06","DC Tract 74.07", "DC Tract 74.08", "DC Tract 75.02", "DC Tract 75.04"  ) then output;
run;

