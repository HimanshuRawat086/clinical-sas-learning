data rs;
length STUDYID $10 USUBJID $10 RSTESTCD $8 RSEVAL $20 RSSTRESC $5 RSDTC $10;

input STUDYID $ USUBJID $ RSSEQ RSTESTCD $ RSEVAL $ RSSTRESC $ RSDTC $;

datalines;
STUDY1 01 1 OVR INVESTIGATOR PR 2023-01-10
STUDY1 01 2 OVR INVESTIGATOR SD 2023-01-15
STUDY1 02 1 OVR INVESTIGATOR PD 2023-01-12
STUDY1 03 1 OVR INVESTIGATOR CR 2023-01-18
;
run;


data adsl;
length STUDYID $10 USUBJID $10;

input STUDYID $ USUBJJID $ TRTSDT : yymmdd10. DTHDT : yymmdd10.;

format TRTSDT yymmdd10. DTHDT yymmdd10.;

datalines;
STUDY1 01 2023-01-05 .
STUDY1 02 2023-01-05 2023-02-01
STUDY1 03 2023-01-05 .
;
run;


proc sort data=rs;
by USUBJID;
run;

proc sort data=adsl;
by USUBJID;
run;


data rs_adsl;
merge rs(in=a) adsl(in=b);
by USUBJID;
if a;
run;


data ovr;
set rs_adsl;

if RSTESTCD="OVR" and RSEVAL="INVESTIGATOR";

PARAMCD="OVR";
PARAM="Overall response by Investigator";

PARCAT1="Tumor Response";
PARCAT3="RECIST 1.1";

AVALC=RSSTRESC;

if AVALC="CR" then AVAL=1;
else if AVALC="PR" then AVAL=2;
else if AVALC="SD" then AVAL=3;
else if AVALC="PD" then AVAL=4;
else if AVALC="NE" then AVAL=5;

run;


data ovr2;
set ovr;

ADT=input(RSDTC,yymmdd10.);
format ADT yymmdd10.;

ADY=ADT-TRTSDT;
if ADY>=0 then ADY=ADY+1;

ASEQ=RSSEQ;

run;


proc sort data=ovr2;
by USUBJID ADT AVAL;
run;


data ovr_final;
set ovr2;
by USUBJID ADT;

if last.ADT then ANL01FL="Y";

run;


data death;
set adsl;

PARAMCD="DEATH";
PARAM="Death";

PARCAT1="Reference Event";

if not missing(DTHDT) then do;
AVALC="Y";
AVAL=1;
ADT=DTHDT;
end;

else do;
AVALC="N";
AVAL=0;
end;

run;


data adrs;
set ovr_final death;
run;
