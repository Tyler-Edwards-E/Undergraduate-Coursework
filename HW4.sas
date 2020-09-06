/*Tyler Edwards*/ 
/*2-14-2019*/ 
/*H.W.4*/ 
/* 14.6, 14.10, 6.7 */ 
 
/*6.7*/ 
proc format; 
	value GROUP 0 = "A" 1 = "B" 2 = "C"; 
run; 
 
data P1; 
	input SUBJ@@; 
	RAND = ranuni(3); 
datalines; 
001 137 454 343 257 876 233 165 002 
; 
 
proc rank data=P1 out=P1new GROUP=3; /*****/ 
	var RAND; 
run; 
 
proc sort data=P1new; 
	by SUBJ; 
run; 
 
proc print data=P1new; 
	format RAND GROUP.; 
	id SUBJ; 
	var RAND; 
run; 

/*14.6*/ 
data TEMP; 
	if _N_ = 1 then DATE = "01JAN2004"D; 
	else DATE + 1; 
	format DATE MMDDYY10.; 
	input T @@; 
datalines; 
30 32 28 26 25 12 18 20 22 24 36 38 38 39 44 
; 
run; 
 
data MI; 
	if _N_ = 1 then DATE = "01JAN2004"D; 
	else DATE + 1; 
	format DATE MMDDYY10.; 
	input T @@; 
datalines; 
9 7 11 12 15 23 20 18 8 9 13 12 14 13 14 
; 
run;

proc sort data=temp; 
	by DATE; 
run; 
proc sort data=MI; 
	by DATE; 
run; 
 
data BOTH; 
	merge temp MI; 
	by DATE; 
run; 

/*14.10*/ 
data PRICES; 
	input PART_NUMBER QUANTITY PRICE @@; 
datalines; 
100 23 29.95 102 12 9.95 103 21 15.99 123 9 119.95 113 40 56.66 
111 55 39.95 105 500 .59 
; 
 
data upPRICES; 
	input PART_NUMBER QUANTITY PRICE @@; 
datalines; 
103 31 18.99 111 45 29.95 113 35 56.66 123 9 129.96 
; 
run;

proc sort data=PRICES; 
	by PART_NUMBER; 
run; 
proc sort data=upPRICES; 
	by PART_NUMBER; 
run; 
 
data newPRICES; 
	merge PRICES upPRICES; 
	by PART_NUMBER; 
run; 
