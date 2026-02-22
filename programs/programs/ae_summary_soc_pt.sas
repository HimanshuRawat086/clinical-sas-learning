/*****************************************************************
Project: AE Summary Table (SOC → PT)
Author : Himanshu Rawat
Purpose: CSR-style Adverse Event Summary
*****************************************************************/

/*--------------------------------------------------------------
STEP 1: Create Dummy ADAE Dataset
--------------------------------------------------------------*/

data adae;

length USUBJID $10
       TRT01AN 8
       TRT01A $10
       AESOC $40
       AEDECOD $40
       TRTEMFL $1;

input USUBJID $
      TRT01AN
      TRT01A $
      AESOC $
      AEDECOD $
      TRTEMFL $;

datalines;
SUBJ01 1 A CARDIAC ARRHYTHMIA Y
SUBJ02 1 A CARDIAC ARRHYTHMIA Y
SUBJ03 1 A GENERAL HEADACHE Y
SUBJ04 2 B CARDIAC ARRHYTHMIA Y
SUBJ05 2 B GENERAL NAUSEA Y
SUBJ06 2 B GENERAL NAUSEA Y
SUBJ07 3 C CARDIAC ARRHYTHMIA Y
SUBJ08 3 C GENERAL HEADACHE Y
SUBJ09 4 D GENERAL NAUSEA Y
SUBJ10 4 D CARDIAC ARRHYTHMIA Y
;
run;


/*--------------------------------------------------------------
STEP 2: Treatment Denominator
--------------------------------------------------------------*/

proc sql;

create table trt as

select TRT01AN,
       TRT01A,
       count(distinct USUBJID) as DENOM

from adae
where TRTEMFL="Y"

group by TRT01AN, TRT01A
order by TRT01AN;

quit;


/*--------------------------------------------------------------
STEP 3: SOC Counts
--------------------------------------------------------------*/

proc sql;

create table soc as

select TRT01AN,
       AESOC,
       AESOC as ROWTEXT length=50,
       1 as LEVEL,
       count(distinct USUBJID) as N

from adae
where TRTEMFL="Y"

group by TRT01AN, AESOC;

quit;


/*--------------------------------------------------------------
STEP 4: PT Counts (Linked to SOC)
--------------------------------------------------------------*/

proc sql;

create table pt as

select TRT01AN,
       AESOC,
       AEDECOD,
       AEDECOD as ROWTEXT length=50,
       2 as LEVEL,
       count(distinct USUBJID) as N

from adae
where TRTEMFL="Y"

group by TRT01AN, AESOC, AEDECOD;

quit;


/*--------------------------------------------------------------
STEP 5: Combine Hierarchy
--------------------------------------------------------------*/

data body;

set soc pt;

if LEVEL=2 then ROWTEXT="   "||strip(ROWTEXT);

run;


/*--------------------------------------------------------------
STEP 6: Merge Denominator and Calculate Percent
--------------------------------------------------------------*/

proc sort data=body; by TRT01AN; run;
proc sort data=trt; by TRT01AN; run;

data pct;

merge body(in=a) trt(in=b);
by TRT01AN;

if a;

if DENOM>0 then PERCENT=(N/DENOM)*100;

DISPLAY = cats(put(N,3.),
               " (",
               put(PERCENT,5.1),
               "%)");

run;


/*--------------------------------------------------------------
STEP 7: Transpose
--------------------------------------------------------------*/

proc sort data=pct;
by LEVEL AESOC ROWTEXT TRT01AN;
run;

proc transpose data=pct
               out=final(drop=_name_)
               prefix=Trt_;

by LEVEL AESOC ROWTEXT;

id TRT01AN;
var DISPLAY;

run;


/*--------------------------------------------------------------
STEP 8: Generate RTF Output
--------------------------------------------------------------*/

ods rtf file="ae_summary.rtf" style=journal;

title1 "AIRIS PHARMA Private Limited.";
title2 "Protocol: 043-1810";
title3 "Adverse Events by SOC and Preferred Term";

proc report data=final nowd;

column ROWTEXT Trt_1 Trt_2 Trt_3 Trt_4;

define ROWTEXT / display "System Organ Class / Preferred Term";
define Trt_1 / display "Drug A";
define Trt_2 / display "Drug B";
define Trt_3 / display "Drug C";
define Trt_4 / display "Drug D";

run;

ods rtf close;

/*****************************************************************
End of Program
*****************************************************************/
