/*Tyler Edwards*/ 
/*10-3-2019*/ 
/*H.W.3*/ 
 
/*5.2*/ 
data P1; 
input Gender $ Interv $ Age Adher $ @@; 
datalines; 
F no 10 yes F yes 8 yes 
F no 9 yes F yes 10 yes 
M yes 8 yes M yes 11 yes 
M yes 11 yes F yes 8 yes 
F yes 10 yes M yes 6 no 
F yes 7 no F yes 12 yes 
M no 6 no M no 7 no 
M no 6 no F no 12 no 
M yes 7 no F no 11 no 
M yes 12 yes M yes 6 no 
M yes 10 yes F no 12 no 
F yes 8 yes F no 11 no 
M no 7 no F yes 10 yes 
F yes 6 yes M no 11 no 
M no 12 no M no 9 no 
F yes 7 yes M no 10 no 
M no 8 yes M yes 6 yes 
M no 6 no F no 10 no 
F no 8 no M yes 6 no 
M yes 10 yes M yes 8 yes 
; 
 
 
	/*a*/ 
proc gam data=P1; 
	class Gender Interv; 
	model Adher(event = "yes") = param(Gender Interv) spline(Age)/link=logist dist=binomial; 
	output out = P1Result pred; 
 
run;

proc print data = P1Result; 
run; 
 
/* Intervention(no) and Age are both significant predictors. */ 
/* Adherance = -4.60560 + 1.05928Gender(F) - 5.40983Intervention(no) + 0.75363Age */ 
 
	/*b*/ 
proc sort data = P1Result; 
	by Gender Interv; 
run; 
 
symbol1 color=black value=none interpol=join line=1; 
proc gplot data = P1Result; 
	plot P_Adher * Age / name = "P1Graph"; 
	by GendeR Interv; 
run; 
 
proc greplay igout = work.gseg tc = sashelp.templt template = l2r2 
	nofs; 
	treplay 1:graph1 2:graph2 3:graph3 4:graph4; 
run; 
 
/*The graphs between gender look similar. With intervention or not the probability increases around age 8 to 10*/ 

/*5.4*/ 
data P2; 
input TimeDirection $ Sunlight Accidents @@; 
datalines; 
MEast 5 4 MEast 6 3 
MWest 5 1 MWest 6 0 
AEast 4 3 AEast 5 1 
AWest 4 5 AWest 5 3 
MEast 2 2 MEast 7 4 
MWest 2 0 MWest 7 3 
AEast 5 3 AEast 4 3 
AWest 5 6 AWest 4 2 
MEast 6 1 MEast 7 2 
MWest 6 1 MWest 7 0 
AEast 4 4 AEast 5 1 
AWest 4 4 AWest 5 3 
MEast 8 5 MEast 8 5 
MWest 8 3 MWest 8 4 
AEast 3 2 AEast 5 3 
AWest 3 3 AWest 5 4 
MEast 4 5 MEast 4 4 
MWest 4 3 MWest 4 3 
AEast 5 4 AEast 4 1 
AWest 5 8 AWest 4 5 
; 
run; 
 
	/*a*/ 
proc sort data = P2; 
	by descending TimeDirection; 
run; 
 
proc gam data = P2; 
	class TimeDirection (order = data); 
	model Accidents = param(TimeDirection) spline(Sunlight)/link=log 
	dist=poisson; 
	output out = P2Result pred; 
run;

proc print data = P2Result; 
run; 
/* Accidents = 0.60244 - 0.24996*MorningWest + 0.41501*MorningEast + 0.54232*AfternoonWest + 0.06060*Sunlight */ 
/* Only AfternoonWest is a significant variable in the most, which doesn't support the hyothesis because sunlight 
		is not a significant predictor. The hypothesis of interest was that there were more accidents when people were 
		driving west in the afternoon because of the sun but the model doesn't compeltely support that idea since it says 
		sunlight is insignificant. */ 
	 
	/*b*/ 
proc sort data = P2Result; 
	by descending TimeDirection; 
run; 
 
proc gam data = P2Result; 
	class TimeDirection (order = data); 
	model P_Accidents = param(TimeDirection) spline(Sunlight) spline(P_Sunlight)/link=log 
	dist = poisson; 
	output out = P2Result2 pred; 
run; 
 
proc print data = P2Result2; 
run; 
 
/* Accidents = 0.35249+0 + 24996∗AfternoonEast + 0.79228∗AfternoonWest + 0.66498∗MorningEast + 0.06060*Sunlight + P_Sunlight */ 
/* Only P_Sunlight is a significant variable in this model which supports the hypothesis. */ 

/*7.2*/ 
	/*a*/ 
data P3; 
	input Husband Wife @@; 
	Diff = Husband - Wife; 
	datalines; 
66 63 64 68 77 67 
66 65 76 67 64 66 
75 62 69 67 72 68 
64 68 68 64 68 65 
80 71 72 62 76 68 
72 69 62 62 65 66 
72 66 76 69 68 66 
78 70 83 70 77 66 
65 61 66 66 77 63 
73 70 70 64 75 66 
63 63 63 65 73 70 
70 68 70 63 76 62 
75 69 67 61 64 64 
79 66 75 68 77 65 
77 64 76 62 63 66 
73 70 76 62 74 63 
69 68 69 64 80 64 
67 70 72 62 64 61 
77 71 70 61 69 70 
72 62 74 63 79 64 
; 
run; 
 
proc univariate data = P3; 
	histogram Diff/midpercents cfill = cyan; 
run; 
/* The histogram is unimodal and is very symmetric. */

	/*b*/ 
title 'c=0.4'; 
proc univariate data = P3; 
	histogram Diff / cfill = cyan 
	kernel(c = 0.4 k = normal quadratic triangular color = red 
	l=1 2 3) name = 'P3BGraph'; 
run; 
/* I prefer the normal kernel model because it's simple but accurate, while the others 
		seem overcomplicated for the data. */ 
		 
