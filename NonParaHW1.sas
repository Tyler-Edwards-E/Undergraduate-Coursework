/*Tyler Edwards*/ 
/*9-19-2019*/ 
/*H.W.1*/ 
 
/*1.1*/ 
data p1; 
	input Start TwoWeeks; 
	Diff = Start - TwoWeeks; 
	datalines; 
22.125 23.375 
23.500 23.125 
23.500 24.750 
25.875 25.750 
26.375 26.750 
21.375 22.625 
28.875 29.000 
24.625 24.000 
23.125 24.125 
25.000 27.250 
; 
run; 
 
proc univariate data = p1; 
	var Diff; 
run; 
 
/*1.3*/ 
data p2; 
	input Day$ Week1 Week2; 
	Diff = Week1 - Week2; 
	datalines; 
Mon 405.65 403.02 
Tue 400.51 399.49 
Wed 408.25 396.10 
Thu 401.34 403.59 
Fri 409.09 405.68 
; 
run; 
 
/*1.4*/ 
proc univariate data = p2; 
	var Diff; 
run; 
 
/*1.7*/ 
data p4; 
	input group $ Days @@; 
	datalines; 
Tx 5 Tx 4 Tx 6 Tx 4 Tx 3 Tx 4 Tx 4 Tx 3 Tx 5 Tx 5 
Cx 7 Cx 8 Cx 12 Cx 10 Cx 8 Cx 9 Cx 10 
; 
run; 
 
proc npar1way data=p4 wilcoxon; 
	class group; 
	var Days; 
	exact; 
run; 
 
/*1.10*/ 
	/*a*/ 
data p5; 
	input group $ Hours @@; 
	datalines; 
Work 1 Work 4 Work 14 Work 7 Work 11 Work 1 Work 8 Work 10 
Home 1 Home 3 Home 5 Home 5 Home 4 Home 3 Home 4 Home 5 
; 
run; 

proc npar1way data=p5 wilcoxon; 
	class group; 
	var Hours; 
	exact; 
run; 
 
	/*b*/ 
proc npar1way data=p5 ab; 
	class group; 
	var Hours; 
	exact; 
run; 
 
/*1.12*/ 
data p6; 
	input group $ Score @@; 
	datalines; 
Tx 2.1 Tx 1.6 Tx 3.5 Tx 3.2 Tx 4.0 
Cx 3.7 Cx 7.2 Cx 2.8 Cx 5.3 Cx 8.6 
; 
run; 
 
proc npar1way data=p6; 
	class group; 
	var Score; 
	exact; 
run; 
