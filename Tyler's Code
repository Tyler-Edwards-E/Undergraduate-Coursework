
/*Tyler Edwards*/
/*4-18-2019*/
/*PROJECT*/

libname proj "/home/tug374410/sasuser.v94/";

data coke;
	set proj.finalcoke;
run;

proc univariate data = coke normal plot;
	var PS_HAM27;
	qqplot;
	probplot;
run;

proc means data = coke;
	var PS_HAM27;
run;

symbol v=dot c=cyan;
proc gplot data = coke;
	title "Scatter Plot of Weight by Height";
	plot PATNO * PS_HAM27;
run;


proc contents data = coke;
run;

proc corr data = coke;
	var PS_HAM27 PS_HAM17 AGE ALC_SUB ARS BAI BASA BDI BEH_ARS BEL_ARS 
	CENSOR COLD COMPLETE CRACK DAYSUSED DCENSOR DEDAYS DOMI DRU_SUB 
	EDUCATE EMP_SUB EXPL FAM_SUB GENDER GSI GTHS HAM27 IIP INTR JOB 
	LEG_SUB M0ALU30 M0ASIAL M0ASIDR M0ASIEM M0ASIFA M0ASILE M0ASIMD M0ASIPS 
	M0COC30 M0CPI MAR_STAT MED_SUB MONTH NOAS OVNU PATNO PSBDI PSGSI PSY_SUB 
	PS_COLD PS_DOMI PS_EXPL PS_IIP PS_INTR PS_NOAS PS_OVNU PS_SOAV PS_VIND 
	PVDAYS RACE SIGHD17 /*SITE*/ SITES SOAV SUIPU TX_COND VIND ZM0 ps_BEH_ARS ps_BEL_ARS 
	ps_SUIPR ps_SUIPU ps_ars ps_basa;
run;

proc corr data = coke;
	var PS_HAM27 PS_HAM17 ZM0 PSBDI PSGSI HAM27 BDI GSI M0ASIPS; /*Variables with |r| > .4*/
run;

proc reg data = coke;
	model PS_HAM27 = PS_HAM17 ZM0 PSBDI PSGSI HAM27 BDI GSI M0ASIPS;
run; /* R-Square = .9215, Model P-Value < .05,*/

proc reg data = coke;
	model PS_HAM27 = PS_HAM17 PSBDI HAM27 GSI M0ASIPS; /*Removed variables with P-value larger than .05*/
run; /* R-Square = .9210, Model P-Value < .05,*/

proc reg data = coke;
	model PS_HAM27 = PS_HAM17 PSBDI HAM27 M0ASIPS; /*Removed variables with P-value larger than .05*/
run; /* R-Square = .9204, Model P-Value < .05,*/

proc glm data = coke; /* proc glm of same model above */
	model PS_HAM27 = PS_HAM17 PSBDI HAM27 M0ASIPS;
run; /* R-Square = .9204, Model P-Value < .05,*/

/* Modeling Dropped Variables by the selves */
/* ZM0, PSGSI, BDI, GSI */
proc reg data = coke;
	model PS_HAM27 = ZM0;
run; /* R-Square = .5949, Model P-Value < .05,*/
proc reg data = coke;
	model PS_HAM27 = PSGSI;
run; /* R-Square = .3637, Model P-Value < .05,*/
proc reg data = coke;
	model PS_HAM27 = BDI;
run; /* R-Square = .2080, Model P-Value < .05,*/
proc reg data = coke;
	model PS_HAM27 = GSI;
run; /* R-Square = .1819, Model P-Value < .05,*/

/* Modeling Kept Variables by the selves */
/* PS_HAM17 PSBDI HAM27 M0ASIPS */
proc reg data = coke;
	model PS_HAM27 = PS_HAM17;
run; /* R-Square = .9174, Model P-Value < .05,*/
/***** PS_HAM17 should definently be in final model *****/
proc reg data = coke;
	model PS_HAM27 = PSBDI;
run; /* R-Square = .4154, Model P-Value < .05,*/
proc reg data = coke;
	model PS_HAM27 = HAM27;
run; /* R-Square = .3067, Model P-Value < .05,*/
proc reg data = coke;
	model PS_HAM27 = M0ASIPS;
run; /* R-Square = .1895, Model P-Value < .05,*/ 


proc reg data = coke;
	model PS_HAM27 = PS_HAM17 PSBDI HAM27 M0ASIPS ZM0; /*Trying to get ZM0 back in model*/
run; /* R-Square = .9205, Model P-Value < .05, ZM0 P-Value > .05*/

proc reg data = coke;
	model PS_HAM27 = PS_HAM17 HAM27 M0ASIPS ZM0; /*Trying to get ZM0 back in model*/
run; /* R-Square = .9206, Model P-Value < .05, ZM0 P-Value < .05*/
/***** Highest R-Square *****/
proc glm data = coke; /* proc glm of same model above */
	model PS_HAM27 = PS_HAM17 HAM27 M0ASIPS ZM0;
run; /* R-Square = .9206, Model P-Value < .05,*/

proc glm data = coke; /* proc glm of same model above */
	model PS_HAM27 = PS_HAM17 HAM27 M0ASIPS ZM0;
run; /* R-Square = .9206, Model P-Value < .05,*/
