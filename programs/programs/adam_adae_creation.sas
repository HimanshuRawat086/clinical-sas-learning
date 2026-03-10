/********************************************************************
Program: adam_adae_creation.sas
Purpose: Create ADAE dataset from AE, ADSL and SUPPAE
Author : Himanshu Rawat
********************************************************************/

/* Clear WORK library */

proc datasets library=work kill;
run;

options validvarname=upcase;


/*------------------------------------------------------------
Create AE Dataset
------------------------------------------------------------*/

data ae;

length USUBJID $10
       AESEQ 8
       AETERM $40
       AEDECOD $40
       AESTDTC $10
       AEENDTC $10;

input USUBJID $
      AESEQ
      AETERM $
      AEDECOD $
      AESTDTC $
      AEENDTC $;

datalines;
SUBJ01 1 HEADACHE HEADACHE 2024-01-01 2024-01-03
SUBJ01 2 NAUSEA NAUSEA 2024-01-05 2024-01-07
SUBJ02 1 FEVER FEVER 2024-01-02 2024-01-04
SUBJ03 1 COUGH COUGH 2024-01-06 2024-01-08
;
run;


/*------------------------------------------------------------
Create ADSL Dataset
------------------------------------------------------------*/

data adsl;

length USUBJID $10
       TRT01P $10
       TRT01A $10;

input USUBJID $
      TRT01P $
      TRT01A $
      TRTSDT
      TRTEDT;

format TRTSDT date9.
       TRTEDT date9.;

datalines;
SUBJ01 DRUGA DRUGA 01JAN2024 10JAN2024
SUBJ02 DRUGB DRUGB 02JAN2024 11JAN2024
SUBJ03 DRUGA DRUGA 03JAN2024 12JAN2024
;
run;


/*------------------------------------------------------------
Create SUPPAE Dataset
------------------------------------------------------------*/

data suppae;

length USUBJID $10
       IDVARVAL 8
       QNAM $20
       QVAL $20;

input USUBJID $
      IDVARVAL
      QNAM $
      QVAL $;

datalines;
SUBJ01 1 AESER Y
SUBJ01 2 AESER N
SUBJ02 1 AESER Y
SUBJ03 1 AESER N
;
run;


/*------------------------------------------------------------
Merge AE with ADSL
------------------------------------------------------------*/

proc sort data=ae; by USUBJID; run;
proc sort data=adsl; by USUBJID; run;

data adae_base;
merge ae adsl;
by USUBJID;
run;


/*------------------------------------------------------------
Transpose SUPPAE
------------------------------------------------------------*/

proc sort data=suppae;
by USUBJID IDVARVAL;
run;

proc transpose data=suppae
               out=suppae_tr;

by USUBJID IDVARVAL;
id QNAM;
var QVAL;

run;


/*------------------------------------------------------------
Merge SUPPAE
------------------------------------------------------------*/

proc sort data=adae_base;
by USUBJID AESEQ;
run;

proc sort data=suppae_tr;
by USUBJID IDVARVAL;
run;

data adae_step1;

merge adae_base
      suppae_tr(rename=(IDVARVAL=AESEQ));

by USUBJID AESEQ;

run;


/*------------------------------------------------------------
Convert Date Variables
------------------------------------------------------------*/

data adae_step2;

set adae_step1;

ASTDT=input(AESTDTC,yymmdd10.);
AENDT=input(AEENDTC,yymmdd10.);

format ASTDT date9.
       AENDT date9.;

run;


/*------------------------------------------------------------
Study Day Derivation
------------------------------------------------------------*/

data adae_step3;

set adae_step2;

ASTDY = ASTDT - TRTSDT + 1;
AENDY = AENDT - TRTSDT + 1;

run;


/*------------------------------------------------------------
AE Duration
------------------------------------------------------------*/

data adae_final;

set adae_step3;

ADURN = AENDT - ASTDT + 1;

run;
