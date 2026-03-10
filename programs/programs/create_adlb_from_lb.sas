data lb;
length STUDYID $10 USUBJID $10 LBTESTCD $8 LBTEST $40 VISIT $20 LBDTC $19;
input STUDYID $ USUBJID $ LBSEQ LBTESTCD $ LBTEST $ LBSTRESN LBSTRESU $ VISIT $ VISITNUM LBDTC $;
datalines;
STUDY1 01 1 ALT Alanine 35 U/L SCREENING 1 2023-01-01T08:00
STUDY1 01 2 ALT Alanine 45 U/L WEEK1 2 2023-01-10T08:30
STUDY1 02 1 ALT Alanine 50 U/L SCREENING 1 2023-01-02T09:00
;
run;

data supplb;
length USUBJID $10 QNAM $20 QVAL $20 IDVARVAL $8;
input USUBJID $ IDVARVAL $ QNAM $ QVAL $;
datalines;
01 1 METHOD HPLC
01 2 METHOD HPLC
02 1 METHOD HPLC
;
run;

data adsl;
length STUDYID $10 USUBJID $10;
input STUDYID $ USUBJID $ TRTSDT : yymmdd10.;
format TRTSDT yymmdd10.;
datalines;
STUDY1 01 2023-01-05
STUDY1 02 2023-01-06
;
run;

data supplb_prep;
set supplb;
LBSEQ=input(IDVARVAL,best.);
run;

proc transpose data=supplb_prep out=supplb_tr(drop=_NAME_);
by USUBJID LBSEQ;
id QNAM;
var QVAL;
run;

proc sort data=lb; by USUBJID LBSEQ; run;
proc sort data=supplb_tr; by USUBJID LBSEQ; run;
proc sort data=adsl; by USUBJID; run;

data adlb_base;
merge lb supplb_tr adsl;
by USUBJID;
run;

data adlb_step5;
set adlb_base;

ADT=input(scan(LBDTC,1,'T'),yymmdd10.);
format ADT yymmdd10.;

ATM=input(scan(LBDTC,2,'T'),time5.);
format ATM time5.;

ADTM=input(LBDTC,is8601dt.);
format ADTM datetime20.;
run;

data adlb_step6;
set adlb_step5;

PARAMCD=LBTESTCD;
PARAM=catx('',LBTEST,'(',LBSTRESU,')');
PARAMN=_N_;
run;

data adlb_step7;
set adlb_step6;

AVAL=LBSTRESN;
AVALC=put(LBSTRESN,best.);
run;

data adam_adlb;
set adlb_step7;

ADY=ADT-TRTSDT;

if ADY>=0 then ADY=ADY+1;

ASEQ=LBSEQ;
run;
