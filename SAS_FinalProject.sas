
proc import
	datafile = "C:\Users\skadav\Downloads\Part_1_ELSI_School_Enroll_2005_2017_Clean.xlsx"
	out = School_Orig
	dbms = xlsx replace;
run;

%macro transpose;
    data School_Panel;
	set School_Orig;
	array Total_Enroll{13} Total_Enroll_2005-Total_Enroll_2017;
	array White_Students{13} White_2005-White_2017;
	array Black_Students{13} Black_2005-Black_2017;
	array Hispanic_Students{13} Hispanic_2005-Hispanic_2017;
	%do i = 1 %to 13;
		Year = 2004 + &i;
		TotalEnroll = Total_Enroll[&i];
		White = White_Students[&i];
		Black = Black_Students[&i];   
		Hispanic = Hispanic_Students[&i];
		output;
	%end;
	drop Total_Enroll_: White_: Black_: Hispanic_:;
	run;
%mend;

%transpose;

libname down "C:\Users\skadav\Downloads";
run;

data Crime_Orig;
set down.crime_predictors_1990_2015;
run;

proc import
	datafile = "C:\Users\skadav\Downloads\All_School_Coordinates_2016_ELSI.xlsx"
	out = School_Coordinates_Orig
	dbms = xlsx replace;
run;

data School_Coordinates;
set School_Coordinates_Orig;
School_ID = School_ID_NCES + 0;
stco_fips = County_Number + 0;
drop School_ID_NCES FIPS_State year County_Number;
run;

proc sort data = School_Coordinates; by School_ID; run;

proc sort data = School_Panel; by School_ID; run;

data School_Merged;
merge School_Coordinates (in = a) School_Panel (in = b);
by School_ID;
if a and b then output;
run;

data School_Data;
set School_Merged;
Total_Enroll = TotalEnroll + 0;
keep School_ID stco_fips year Total_Enroll;
run;

proc sort data = School_Data; by stco_fips year; run;

proc means data = School_Data;
class stco_fips year;
var Total_Enroll;
output out = Aggreg_School;
run;

data School_Clean;
set Aggreg_School;
where _TYPE_ = 3 AND _STAT_ = "MEAN";
drop _TYPE_ _FREQ_ _STAT_;
run;

data Crime_Data;
set Crime_Orig;
keep stco_fips year violent_crime_rate employ_county percap_income_county total_officers;
run;

proc sort data = Crime_Data; by stco_fips year; run;

proc means data = Crime_Data;
class stco_fips year;
var violent_crime_rate;
output out = Aggreg_Crime_VCR;
run;

data Crime_Clean_VCR;
set Aggreg_Crime_VCR;
where _TYPE_ = AND _STAT_ = "MEAN";
drop _TYPE_ _FREQ_ _STAT_;
run;

proc means data = Crime_Data;
class stco_fips year;
var employ_county;
output out = Aggreg_Crime_Employ;
run;

data Crime_Clean_Employ;
set Aggreg_Crime_Employ;
where _TYPE_ = AND _STAT_ = "MEAN";
drop _TYPE_ _FREQ_ _STAT_;
run;

proc means data = Crime_Data;
class stco_fips year;
var percap_income_county;
output out = Aggreg_Crime_PCI;
run;

data Crime_Clean_PCI;
set Aggreg_Crime_PCI;
where _TYPE_ = AND _STAT_ = "MEAN";
drop _TYPE_ _FREQ_ _STAT_;
run;

proc means data = Crime_Data;
class stco_fips year;
var total_officers;
output out = Aggreg_Crime_TO;
run;

data Crime_Clean_TO;
set Aggreg_Crime_TO;
where _TYPE_ = AND _STAT_ = "MEAN";
drop _TYPE_ _FREQ_ _STAT_;
run;

proc sort data = Crime_Clean_VCR; by stco_fips year; run;

proc sort data = Crime_Clean_Employ; by stco_fips year; run;

proc sort data = Crime_Clean_PCI; by stco_fips year; run;

proc sort data = Crime_Clean_TO; by stco_fips year; run;

data Crime_Clean;
merge Crime_Clean_VCR (in = a) Crime_Clean_Employ (in = b) Crime_Clean_PCI (in = c) Crime_Clean_TO (in = d);
by stco_fips year;
if a and b and c and d then output;
run;

proc sort data = Crime_Clean; by stco_fips year; run;

proc sort data = School_Clean; by stco_fips year; run;

data combo_crime_school;
merge Crime_Clean (in = a) School_Clean (in = b);
by stco_fips year;
if a and b then output;
run;

proc reg data = combo_crime_school plots = none;
model Total_Enroll = employ_county percap_income_county total_officers violent_crime_rate;
run; quit;
