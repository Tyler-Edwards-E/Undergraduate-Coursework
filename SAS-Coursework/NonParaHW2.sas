/*Tyler Edwards*/ 
/*10-3-2019*/ 
/*H.W.2*/ 
 
/*2.2*/ 
data p1; 
	input ID CONTACT $ HAPPY @@; 
	datalines; 
1 LETTER 0.4 1 PHONE 0.3 1 TEXT 0.1 
2 LETTER 0.8 2 PHONE 0.4 2 TEXT 0.3 
3 LETTER 0.5 3 PHONE 0.4 3 TEXT 0.1 
4 LETTER 0.7 4 PHONE 0.6 4 TEXT 0.2 
5 LETTER 0.6 5 PHONE 0.3 5 TEXT 0.2 
6 LETTER 0.6 6 PHONE 0.5 6 TEXT 0.4 
7 LETTER 0.6 7 PHONE 0.4 7 TEXT 0.3 
8 LETTER 0.7 8 PHONE 0.6 8 TEXT 0.2 
; 
run; 
 
PROC SORT data=p1; 
BY ID; 
RUN; 
 
PROC RANK DATA=p1 OUT=p1Rank; 
VAR HAPPY; 
BY ID; 
RANKS rank; 
RUN; 
 
PROC FREQ data=p1Rank; 
TABLE ID*CONTACT*rank/ NOPRINT CMH; 
RUN; 

/*2.3*/ 
data p2; 
input Pond $ Lead @@; 
datalines; 
A 3 A 4 A 4 A 5 A 7 A 8 
B 10 B 11 B 11 B 12 B 15 B 18 
C 4 C 5 C 6 C 6 C 9 C 10 
; 
 
proc npar1way data=p2 wilcoxon; 
class Pond; 
var Lead; 
exact; 
run; 
 
/*3.3*/ 
data p3; 
input Year Points; 
datalines; 
2000 1938 
2001 2019 
2002 2461 
2003 1557 
2004 1819 
2005 2832 
2006 2430 
2007 2323 
2008 2201 
2009 1970 
2010 2078 
;

PROC FREQ DATA=p3; 
	TABLE Year*Points; 
	EXACT SCORR; 
RUN; 
/* Spearman = 0.2091 */ 
/* ASE = 0.2633 */ 
 
/*3.5*/ 
data p4; 
	input Gender $ Choice $ @@; 
datalines; 
Boy Studying Boy Studying Boy Studying Boy Studying Boy Studying 
Boy Studying Boy Studying Boy Studying Boy Studying Boy Studying 
Boy Studying Boy Studying Boy Sports Boy Sports Boy Sports 
Boy Sports Boy Sports Boy Sports Boy Sports Boy Sports Boy Sports 
Boy Sports Boy Sports Boy Friends Boy Friends Boy Friends Boy Friends 
Girl Studying Girl Studying Girl Studying Girl Studying Girl Studying 
Girl Studying Girl Studying Girl Studying Girl Sports Girl Sports 
Girl Friends Girl Friends Girl Friends Girl Friends Girl Friends 
Girl Friends Girl Friends Girl Friends Girl Friends Girl Friends 
Girl Friends Girl Friends 
; 
run; 
 
PROC FREQ DATA=p4; 
	TABLE Gender * Choice; 
	exact fisher; 
RUN; 
