data raw_ae;
length STUDYID $10 SITEID $5 SUBJID $5 AETERM $50;

input STUDYID $ SITEID $ SUBJID $ AETERM $
      ASTDT $ AENDT $ AESER $ AESEV $ AEONGO $;

datalines;
STUDY1 101 001 Headache 2024-01-01 2024-01-05 Y MILD N
STUDY1 101 002 Fever    2024-02-01 2024-02-03 N MODERATE N
STUDY1 102 003 Cough    2024-03-01 .          N SEVERE Y
;
run;


data ae1;
set raw_ae;

DOMAIN = "AE";
USUBJID = catx("-", STUDYID, SITEID, SUBJID);

run;


data ae2;
set ae1;

AETERM = AETERM;
AESEV  = AESEV;
AESER  = AESER;

run;


data ae3;
set ae2;

AESTDTC = ASTDT;
AEENDTC = AENDT;

run;


data ae4;
set ae3;

if AETERM ne "";

run;


data dm;
input USUBJID $ RFSTDTC $;

datalines;
STUDY1-101-001 2024-01-01
STUDY1-101-002 2024-02-01
STUDY1-102-003 2024-03-01
;
run;


proc sort data=ae4; by USUBJID; run;
proc sort data=dm;  by USUBJID; run;


data ae5;
merge ae4 dm;
by USUBJID;

ASTDTN = input(AESTDTC, yymmdd10.);
RFSTDTN = input(RFSTDTC, yymmdd10.);

ASTDY = ASTDTN - RFSTDTN + 1;

run;


data ae6;
set ae5;

AENDTN = input(AEENDTC, yymmdd10.);

if AENDTN ne . then
AEDUR = AENDTN - ASTDTN + 1;

run;


data ae_final;
set ae6;

if AEONGO = "Y" then AEENRF = "Ongoing";

run;
