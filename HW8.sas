/*Tyler Edwards*/
/*3-28-2019*/
/*H.W.8*/
/* 1 , 2 , 3 */

/*1*/
data city;
	input CITY $ DATE $ CPI;
	format DATE MONYY5.;
datalines;
Chicago JAN90 128.1
Chicago FEB90 129.2
Chicago MAR90 129.5
Chicago APR90 130.4
Chicago MAY90 130.4
Chicago JUN90 131.7
Chicago JUL90 132.0
Los_Angeles JAN90 132.1
Los_Angeles FEB90 133.6
Los_Angeles MAR90 134.5
Los_Angeles APR90 134.2
Los_Angeles MAY90 134.6
Los_Angeles JUN90 135.0
Los_Angeles JUL90 135.6
New_York JAN90 135.1
New_York FEB90 135.3
New_York MAR90 136.6
New_York APR90 137.3
New_York MAY90 137.2
New_York JUN90 137.1
New_York JUL90 138.4
;
run;

proc sort data = city;
	by DATE;
run;

proc transpose data = city out = city2;
	by DATE;
	id CITY;
	var CPI;
run;

data city3;
   set city2(drop = _name_);
    by DATE;
run;

/*2*/
libname New "/home/tug374410/my_courses/jingxiao0/HW Solution";
	/*1*/
PROC SQL;
	select NAME,SEX,AGE,HEIGHT,WEIGHT
	from New.class;
QUIT;
	/*2 and 3*/
data Class;
   set New.class;
   by NAME;
run;

PROC SQL;
	select NAME label = "FIRST NAME",SEX,AGE,HEIGHT,WEIGHT,
	WEIGHT/HEIGHT as WEIGHTtoHEIGHT_RATIO label = "WEIGHT:HEIGHT RATIO" format=5.2
	from New;
QUIT;

/*3*/
	/*1*/	
%MACRO sortclass;
	proc sort data = Class; 
		by SEX NAME;
	run;
%MEND sortclass;

%sortclass
	
	/*2*/	
%MACRO ratio;
	PROC SQL;
	select NAME label = "FIRST NAME",SEX,AGE,HEIGHT,WEIGHT,
	WEIGHT/HEIGHT as RATIO label = "WEIGHT_to_HEIGHT_RATIO" format=5.2
	from New;
	QUIT;
%MEND ratio;
	
%ratio

%MACRO summary;
	proc means data = class min max mean std maxdec = 1;
		var AGE HEIGHT WEIGHT /*RATIO*/;
		by SEX;
	run;
%MEND summary;

%summary%
