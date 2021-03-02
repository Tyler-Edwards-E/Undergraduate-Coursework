/*Tyler Edwards*/
/*3-20-2019*/
/*H.W.5*/
/* 17.1, 17.4, 17.7, 17.9, 17.10 */

/*17.1*/
data HOSP;
	informat ID $3. GENDER $1. DOB DOS MMDDYY8.;
	input ID GENDER DOB DOS LOS SBP DBP HP;
	format DOB DOS MMDDYY10.;
	datalines;
1 M 10/21/46 3/17/97 3 130 90 68
2 F 11/1/55 3/1/97 5 120 70 72
3 M 6/6/90 1/1/97 100 102 64 88
4 F 12/21/20 2/12/97 10 180 110 86
;

data NEW_HOSP;
	set HOSP;
		/*a.*/
	LOG_LOS = log10(LOS);
		/*b.*/
	AGE_LAST = int(yrdif(DOB,DOS,'Actual'));
		/*c.*/
	X = round(sqrt(mean(of SBP DBP)),.1);
run;

/*17.4*/
data BIG;
	do SUBJ = 1 to 100;
		X = int(ranuni(123)*100 + 1);
		output;
	end;
run;
data RANDOM;
	do i = 1 to 10;
		SUBJ = int((1 + 99*RANUNI(0)));
		output;
	end;
run;

proc sort data = BIG;
	by SUBJ;
run;
proc sort data = RANDOM;
	by SUBJ;
run;

data TEN_PERCENT;
	merge BIG RANDOM;
	if i;
run;
	
/*17.7*/
proc format;
	value DAYfmt 1 = 'SUN' 2 = 'MON' 3 = 'TUE' 4 = 'WED' 5 = 'THUR' 6 = 'FRI' 7 = 'SAT';
run;
data HOSP_DATES;
	set HOSP;
	DAY = WEEKDAY(DOS);
	MONTH = MONTH(DOS);
	format DAY DAYfmt.;
run;

Proc gchart data = HOSP_DATES;
	vbar DAY MONTH / discrete;
run;
										/*PRINT CHART*/

/*17.9*/
data MIXED;
	input X Y A $ B $;
	datalines;
1 2 3 4
5 6 7 8
;

data NUMS;
	set MIXED;
	new_A = input(A,8.);
	new_A = input(B,8.);
	drop A B;
run;

/*17.10*/
data NUM_CHAR;
	input X $ Y $ Z $ DATE : $10. NUMERAL DOB : DATE9.;
	format DOB MMDDYY10.;
	datalines;
10 20 30 10/21/1946 123 09SEP2004
1 2 3 11/11/2004 999 01JAN1960
;

data CORRECT;
	set NUM_CHAR;
	X = input(X,8.);
	Y = input(Y,8.);
	Z = input(Z,8.);
	format DATE DOB MMDDYY10.;
	NUMERAL = put(NUMERAL,8.);
	CHAR_DATE = put(DOB,MMDDYY10.);
run;
