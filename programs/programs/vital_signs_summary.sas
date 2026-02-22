/*****************************************************************
Project : Vital Signs Summary Table
Author  : Himanshu Rawat
Purpose : Observed & Change from Baseline Summary
*****************************************************************/

/*------------------------------------------------------------
STEP 1 – Create Dummy ADVS Dataset
------------------------------------------------------------*/

data work.advs;

length usubjid $10 
       param $30 
       trtp $20 
       avisit $20 
       saffl $1;

input usubjid $
      param $
      trtpn
      trtp $
      avisitn
      avisit $
      aval
      chg
      saffl $;

datalines;
01 HEIGHT 1 Placebo 1 Screening 170 . Y
01 HEIGHT 1 Placebo 2 Week1 171 1 Y
01 HEIGHT 1 Placebo 3 Final 172 2 Y
02 HEIGHT 2 DrugA   1 Screening 168 . Y
02 HEIGHT 2 DrugA   2 Week1 169 1 Y
02 HEIGHT 2 DrugA   3 Final 170 2 Y
01 WEIGHT 1 Placebo 1 Screening 70 . Y
01 WEIGHT 1 Placebo 2 Week1 71 1 Y
01 WEIGHT 1 Placebo 3 Final 72 2 Y
02 WEIGHT 2 DrugA   1 Screening 75 . Y
02 WEIGHT 2 DrugA   2 Week1 76 1 Y
02 WEIGHT 2 DrugA   3 Final 78 3 Y
;
run;


/*------------------------------------------------------------
STEP 2 – Safety Population
------------------------------------------------------------*/

data advs_safety;
set work.advs;
where saffl="Y";
run;


/*------------------------------------------------------------
STEP 3 – Observed Value Statistics
------------------------------------------------------------*/

proc summary data=advs_safety nway;
class param trtpn trtp avisitn avisit;
var aval;

output out=aval_stats
n=aval_n
mean=aval_mean
median=aval_median
std=aval_std
min=aval_min
max=aval_max;
run;


/*------------------------------------------------------------
STEP 4 – Change from Baseline Statistics
------------------------------------------------------------*/

proc summary data=advs_safety nway;
class param trtpn trtp avisitn avisit;
var chg;

output out=chg_stats
n=chg_n
mean=chg_mean
median=chg_median
std=chg_std
min=chg_min
max=chg_max;
run;


/*------------------------------------------------------------
STEP 5 – Merge Statistics
------------------------------------------------------------*/

proc sort data=aval_stats; by param trtpn avisitn; run;
proc sort data=chg_stats; by param trtpn avisitn; run;

data final_stats;
merge aval_stats chg_stats;
by param trtpn avisitn;
run;


/*------------------------------------------------------------
STEP 6 – Generate RTF Output
------------------------------------------------------------*/

ods rtf file="Vital_signs_table.rtf" style=journal;

title1 "AIRIS PHARMA Private Limited.";
title2 "Protocol: 043-1810";
title3 "Vital Signs Summary (Observed and Change from Baseline)";

proc report data=final_stats nowd;

column param trtp avisit
       ("Observed"
           aval_n aval_mean aval_median aval_std aval_min aval_max)
       ("Change from Baseline"
           chg_n chg_mean chg_median chg_std chg_min chg_max);

define param / group noprint;
define trtp / group "Treatment";
define avisit / group "Visit";

define aval_n / "N";
define aval_mean / format=8.1 "Mean";
define aval_median / format=8.1 "Median";
define aval_std / format=8.2 "Std";
define aval_min / format=8.1 "Min";
define aval_max / format=8.1 "Max";

define chg_n / "N";
define chg_mean / format=8.1 "Mean";
define chg_median / format=8.1 "Median";
define chg_std / format=8.2 "Std";
define chg_min / format=8.1 "Min";
define chg_max / format=8.1 "Max";

break after param / page;

run;

ods rtf close;

/*****************************************************************
End of Program
*****************************************************************/
