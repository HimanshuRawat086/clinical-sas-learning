/******************************************************************
Program: adam_adsl_creation.sas
Purpose: Create ADaM ADSL dataset from DM and DS datasets
Author : Himanshu Rawat
******************************************************************/

options validvarname=upcase;

/*------------------------------------------------------------
Create DM Dataset
------------------------------------------------------------*/

data dm;

length USUBJID $10
       RFXSTDTC $20
       RFICDTC $20
       DTHDTC $20
       TRT01P $5
       TRT01A $5;

input USUBJID $
      RFXSTDTC $
      RFICDTC $
      DTHDTC $
      TRT01P $
      TRT01A $;

datalines;
SUBJ01 2022-01-01T08:00 2021-12-20 . 1 1A
SUBJ02 2022-01-05T09:00 2021-12-21 . 1A 1A
SUBJ03 . 2021-12-25 . 2A 2A
SUBJ04 2022-01-10T10:30 2021-12-28 2022-02-01 3A 3A
;
run;


/*------------------------------------------------------------
Create DS Dataset
------------------------------------------------------------*/

data ds;

length USUBJID $10
       DSCAT $40
       DSDECOD $40
       DSTERM $40
       DSSTDTC $20;

input USUBJID $
      DSCAT $
      DSDECOD $
      DSTERM $
      DSSTDTC $;

datalines;
SUBJ01 STUDY_DISCONTINUATION COMPLETED . 2022-02-10
SUBJ02 STUDY_DISCONTINUATION ADVERSE_EVENT . 2022-02-12
SUBJ03 TREATMENT_TERMINATION OTHER PATIENT_REQUEST 2022-01-20
SUBJ04 TREATMENT_TERMINATION COMPLETED . 2022-02-01
;
run;


/*------------------------------------------------------------
ADSL Derivation
------------------------------------------------------------*/

data adsl_step1;

set dm;

/* Screened flag */

if RFXSTDTC ne "" then SCFL="Y";
else SCFL="N";

/* PK flag */

PKFL=SCFL;

run;


/* Convert dates */

data adsl_step2;

set adsl_step1;

RFICDT=input(RFICDTC,yymmdd10.);
format RFICDT date9.;

DTHDT=input(DTHDTC,yymmdd10.);
format DTHDT date9.;

run;


/* Planned Treatment Numeric */

data adsl_step3;

set adsl_step2;

select(TRT01P);
when("1") TRT01PN=1;
when("1A") TRT01PN=2;
when("2A") TRT01PN=3;
when("3A") TRT01PN=4;
otherwise TRT01PN=.;
end;

run;


/* Actual Treatment Numeric */

data adsl_step4;

set adsl_step3;

select(TRT01A);
when("1") TRT01AN=1;
when("1A") TRT01AN=2;
when("2A") TRT01AN=3;
when("3A") TRT01AN=4;
otherwise TRT01AN=.;
end;

run;


/* Enrolled flag */

data adsl_step5;

set adsl_step4;

if RFICDT ne . then ENRLFL="Y";
else ENRLFL="N";

run;


/*------------------------------------------------------------
Merge DS dataset
------------------------------------------------------------*/

proc sort data=ds;
by USUBJID;
run;

proc sort data=adsl_step5;
by USUBJID;
run;

data adsl_final;

merge adsl_step5 ds;

by USUBJID;

/* End of Study Status */

if DSCAT="STUDY_DISCONTINUATION" then EOSSTT="Discontinued";
else EOSSTT="Ongoing";

/* End of Study Date */

EOSDT=input(DSSTDTC,yymmdd10.);
format EOSDT date9.;

run;
