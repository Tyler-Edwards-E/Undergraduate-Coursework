/*Tyler Edwards*/ 
/*12-5-2019*/ 
/*H.W.4*/ 
 
/*8.1*/ 
data P1; 
	input min @@; 
	datalines; 
65 82 84 54 85 58 79 57 88 68 76 78 74 85 75 
65 76 58 83 50 87 78 78 74 66 84 84 98 93 59 
; 
run; 
 
proc univariate data = P1; 
	var min; 
	output out = P1out n = n_obs mean = P1Mean; 
run; 
 
proc print data = P1out; 
run; 
	 
data _null_; 
	set P1out; 
	call symput ('n_obs', n_obs); 
	call symput ("P1Mean", P1Mean); 
run; 
 
data jackknife_samples; 
	do sample = 1 to &n_obs; 
		do record = 1 to &n_obs; 
			set P1 point = record; 
				if sample ne record then output; 
		end; 
	end; 
		stop; 
run;

proc univariate data = jackknife_samples; 
	var min; 
		by sample; 
	output out=jackknife_replicates mean = mean_revenue; 
run; 
 
 
data jackknife_replicates; 
	set jackknife_replicates; 
		pseudomean=&n_obs*&P1Mean-(&n_obs-1)*mean_revenue; 
	by sample; 
		keep pseudomean; 
run; 
 
proc means data=jackknife_replicates; 
	var pseudomean; 
	output out=CI LCLM=CI_95_lower UCLM=CI_95_upper; 
run; 
 
proc print data = CI; 
run; 
/* [70.1424, 79.2576] */ 

/*8.6*/ 
data P2; 
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

proc surveyselect data = P2 out = bootstrap_samples 
	outhits seed=234567 method=urs samprate=1 rep=5000; 
run; 
 
proc corr noprint data=bootstrap_samples 
	outs=bootstrap_replicates; 
	var Husband Wife; 
	by replicate; 
run; 
 
data bootstrap_replicates; 
	set bootstrap_replicates; 
	if(_type_='CORR' and _name_='Husband'); 
		spearman_corr = Wife; 
	keep spearman_corr; 
run; 
 
proc univariate data=bootstrap_replicates; 
	var spearman_corr; 
	output out=CI2 pctlpre=CI_99_ pctlpts=0.5 99.5 
		pctlname=lower upper; 
run; 

	/*a*/
proc phreg data = P4 outest=betas;
	model LifeSpan*Assasinated(1) = InagurationAge StartYear InOffice;
	baseline out = outdata survival = Sbar;
run;
/* Years in office and the year the were sworn into office aren't significant varibles in the model. */

	/*b*/
proc phreg data = P4 outest=betas2;
	model LifeSpan*Assasinated(1) = InagurationAge;
	baseline out = outdata2 survival = Sbar2;
run;
/* Hazard of Dying = exp(-0.13058(InagurationAge - 55.3895 */
/* A person's hazard of dying decreases by 12.24% for every year they've been alive. */

	/*c*/
/* 	P(Jefferson living past 83.2 Years) = 0.20635
 
proc print data=CI2; 
run; 

/*6.2*/ 
	/*b*/ 
data P3; 
	input years censored @@; 
	datalines; 
1.1 0 2.6 0 2.8 0 3.1 0 3.4 0 3.5 0 3.5 0  
3.6 0 3.7 0 3.8 0 3.8 0 4.0 0 4.1 0 5.6 0 
; 
 
symbol color=black; 
proc lifetest data = P3 plots=(survival); 
	time years*censored(1); 
run; 
 
	/*c*/ 
/* 3.5 Years, About 2.5 years*/

/*6.5*/ 
data P4; 
	input FirstName $ LastName $ InagurationAge StartYear InOffice LifeSpan Assasinated @@; 
	datalines; 
Washington George 57.2 1789 7.8 67.8 0 
Adams John 61.3 1797 4.0 90.7 0 
Jefferson Thomas 57.9 1801 8.0 83.2 0 
Madison James 58.0 1809 8.0 85.3 0 
Monroe James 58.8 1817 8.0 73.2 0 
Adams Quincy 57.6 1825 4.0 80.6 0 
Jackson Andrew 62.0 1829 8.0 78.2 0 
VanBuren Martin 54.2 1837 4.0 79.6 0 
Harrison William 68.1 1841 0.1 68.1 0 
Tyler John 51.0 1841 3.9 71.8 0 
Polk James 49.3 1845 4.0 53.6 0 
Taylor Zachary 64.3 1849 1.3 65.6 0 
Fillmore Millard 50.5 1850 2.7 74.2 0 
Pierce Franklin 48.3 1853 4.0 64.9 0 
Buchanan James 65.9 1857 4.0 77.1 0 
Lincoln Abraham 52.1 1861 4.1 56.2 1 
Johnson Andrew 56.3 1865 3.9 66.6 0 
Grant Ulysses 46.9 1869 8.0 63.2 0 
Hayes Rutherford 54.4 1877 4.0 70.3 0 
Garfield James 49.3 1881 0.5 49.8 1 
Arthur Chester 52.0 1881 3.5 57.1 0 
Cleveland Grover 48.0 1885 8.0 71.3 0 
Harrison Benjamin 55.5 1889 4.0 67.6 0 
McKinley William 54.1 1897 4.5 58.6 1 
Roosevelt Theodore 42.9 1901 7.5 60.2 0 
Taft William 51.5 1909 4.0 72.5 0 
Wilson Woodrow 56.2 1913 8.0 67.1 0 
Harding Warren 55.3 1921 2.4 57.7 0 
Coolidge Calvin 51.1 1923 5.6 60.5 0 
Hoover Herbert 54.6 1929 4.0 90.2 0 
Roosevelt Franklin 51.1 1933 12.1 63.2 0 
Truman Harry 60.9 1945 7.8 88.6 0 
Eisenhower Dwight 62.3 1953 8.0 78.5 0 
; 
run; 
