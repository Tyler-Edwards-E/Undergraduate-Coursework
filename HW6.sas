/*Tyler Edwards*/
/*3-28-2019*/
/*H.W.6*/
/* 15.2, 15.3, 15.7, 15.8 */

/*15.2*/
data TEMPERATURE;
	input TF1-TF10 TC1-TC10;
	array TC(10) TC1-TC10;
	do i = 1 to 10;
		TC(i) = 5/9*(TC(i) - 32);
	drop i;
	end;
	datalines;
32 212 -40 10 20 30 40 50 60 70    32 212 -40 10 20 30 40 50 60 70
-10 0 10 20 30 40 50 60 70 80      -10 0 10 20 30 40 50 60 70 80
;

proc print data = TEMPERATURE NOOBS;
	TITLE "Listing of Data Set TEMPERATURE";
run;

/*15.3*/
data OLDMISS;
	input A B C X1-X3 Y1-Y3;
	array v(9) A B C X1-X3 Y1-Y3;
	do i = 1 to 9;
		if v(i) = 999 then v(i) = .;
		else if v(i) = 777 then v(i) = .; 
	end;
	drop i;
datalines;
1 2 3 4 5 6 7 8 9
999 4 999 999 5 999 777 7 7
;

/*15.7*/
data PROB15_7;
	length C1-C5 $ 2;
	input C1-C5 $ X1-X5 Y1-Y5;
	array C(5) C1-C5;
	array X(5) X1-X5;
	array Y(5) Y1-Y5;
	do i = 1 to 5;
		if C(i) = "NA" then C(i) = " " ;
		if X(i) = 999 then X(i) = . ; 
		if Y(i) = 999 then Y(i) = . ; 
	end;
	drop i;
datalines;
AA BB CC DD EE 1 2 3 4 5 6 7 8 9 10
NA XX NA YY NA 999 2 3 4 999 999 4 5 6 7
;

/*15.8*/
data EXPER;
	input TIME0-TIME4;
datalines;
100 200 300 400 500
55 110 130 150 170
;

data EXPERmin;
	set EXPER;
	array MINv(5) TIME0 - TIME4;
	do i = 1 to 5;
		MINv(i) = round(MINv(i)/ 60, .1);
	end;
	drop i;
run;
