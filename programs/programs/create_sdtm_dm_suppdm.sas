/* ========================= */
/* STEP 1: RAW DATA          */
/* ========================= */

data raw_dm;
length STUDYID $10 SITEID 8 SUBJID $5 AGE 8 SEX $1 RACE $20 ETHNIC $20;
input STUDYID $ SITEID SUBJID $ AGE SEX $ RACE $ ETHNIC $;
datalines;
STUDY01 101 001 35 M WHITE HISPANIC
STUDY01 102 002 42 F ASIAN NON-HISPANIC
STUDY01 103 003 50 M OTHER UNKNOWN
;
run;

data raw_ds_ic;
length STUDYID $10 SITEID 8 SUBJID $5 RFICDAT 8;
format RFICDAT date9.;
input STUDYID $ SITEID SUBJID $ RFICDAT :date9.;
datalines;
STUDY01 101 001 01JAN2023
STUDY01 102 002 03JAN2023
STUDY01 103 003 05JAN2023
;
run;

data raw_dth;
length STUDYID $10 SITEID 8 SUBJID $5 DTHDAT 8;
format DTHDAT date9.;
input STUDYID $ SITEID SUBJID $ DTHDAT :date9.;
datalines;
STUDY01 103 003 20FEB2023
;
run;

data raw_ex;
length STUDYID $10 SITEID 8 SUBJID $5 EXSTDAT EXENDAT 8 EXTRT $3;
format EXSTDAT EXENDAT date9.;
input STUDYID $ SITEID SUBJID $ EXSTDAT :date9. EXENDAT :date9. EXTRT $;
datalines;
STUDY01 101 001 10JAN2023 20JAN2023 1
STUDY01 102 002 15JAN2023 25JAN2023 2A
STUDY01 103 003 18JAN2023 28JAN2023 3A
;
run;

data raw_sv;
length STUDYID $10 SITEID 8 SUBJID $5 VISDAT 8;
format VISDAT date9.;
input STUDYID $ SITEID SUBJID $ VISDAT :date9.;
datalines;
STUDY01 101 001 20JAN2023
STUDY01 102 002 25JAN2023
STUDY01 103 003 28JAN2023
;
run;


/* ========================= */
/* STEP 2: DM BASE           */
/* ========================= */

data dm_base;
set raw_dm;

DOMAIN = "DM";

SITEID_C = put(SITEID, best.);
USUBJID = catx("-", STUDYID, SITEID_C, SUBJID);

AGEU = "YEARS";

run;


/* ========================= */
/* STEP 3: CONSENT           */
/* ========================= */

data ic;
set raw_ds_ic;

SITEID_C = put(SITEID, best.);
USUBJID = catx("-", STUDYID, SITEID_C, SUBJID);

RFICDTC = put(RFICDAT, yymmdd10.);

keep USUBJID RFICDTC;

run;


/* ========================= */
/* STEP 4: DEATH             */
/* ========================= */

data dth;
set raw_dth;

SITEID_C = put(SITEID, best.);
USUBJID = catx("-", STUDYID, SITEID_C, SUBJID);

DTHDTC = put(DTHDAT, yymmdd10.);
DTHFL = "Y";

keep USUBJID DTHDTC DTHFL;

run;


/* ========================= */
/* STEP 5: EXPOSURE          */
/* ========================= */

proc sort data=raw_ex; by STUDYID SITEID SUBJID EXSTDAT; run;

data ex_dates;
set raw_ex;
by STUDYID SITEID SUBJID;

SITEID_C = put(SITEID, best.);
USUBJID = catx("-", STUDYID, SITEID_C, SUBJID);

if first.SUBJID then RFXSTDTC = put(EXSTDAT, yymmdd10.);
if last.SUBJID then RFXENDTC = put(EXENDAT, yymmdd10.);

retain RFXSTDTC RFXENDTC;

if last.SUBJID;

keep USUBJID RFXSTDTC RFXENDTC EXTRT;

run;


/* ========================= */
/* STEP 6: REFERENCE DATES   */
/* ========================= */

data rf;
set ex_dates;

RFSTDTC = RFXSTDTC;
RFENDTC = RFXENDTC;

keep USUBJID RFSTDTC RFENDTC;

run;


/* ========================= */
/* STEP 7: LAST VISIT        */
/* ========================= */

proc sort data=raw_sv; by STUDYID SITEID SUBJID VISDAT; run;

data sv_last;
set raw_sv;
by STUDYID SITEID SUBJID;

SITEID_C = put(SITEID, best.);
USUBJID = catx("-", STUDYID, SITEID_C, SUBJID);

if last.SUBJID;

RFENDTC = put(VISDAT, yymmdd10.);

keep USUBJID RFENDTC;

run;


/* ========================= */
/* STEP 8: ARM               */
/* ========================= */

data arm;
set ex_dates;

if EXTRT="1" then do; ARM="1"; ACTARM="1"; end;
if EXTRT="2A" then do; ARM="2A"; ACTARM="2A"; end;
if EXTRT="3A" then do; ARM="3A"; ACTARM="3A"; end;

keep USUBJID ARM ACTARM;

run;


/* ========================= */
/* STEP 9: FINAL DM          */
/* ========================= */

proc sort data=dm_base; by USUBJID; run;
proc sort data=ic; by USUBJID; run;
proc sort data=dth; by USUBJID; run;
proc sort data=rf; by USUBJID; run;
proc sort data=sv_last; by USUBJID; run;
proc sort data=arm; by USUBJID; run;

data dm;
merge dm_base ic dth rf sv_last arm;
by USUBJID;
run;


/* ========================= */
/* STEP 10: SUPPDM           */
/* ========================= */

data suppdm;
set dm;

if RACE="OTHER";

RDOMAIN="DM";
QNAM="RACEOTH";
QLABEL="Race Other";
QVAL=RACE;

keep STUDYID RDOMAIN USUBJID QNAM QLABEL QVAL;

run;
