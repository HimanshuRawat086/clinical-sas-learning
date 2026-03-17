data adsl;
length STUDYID $10 USUBJID $12 TRTSDT 8;

format TRTSDT date9.;

input STUDYID $ USUBJID $ TRTSDT :date9.;

datalines;
STUDY01 SUBJ001 01JAN2023
STUDY01 SUBJ002 05JAN2023
STUDY01 SUBJ003 10JAN2023
;
run;


data adrs;

length STUDYID $10 USUBJID $12 PARAMCD $8 AVALC $1 ANL01FL $1;

format ADT date9.;

input STUDYID $ USUBJID $ PARAMCD $ ADT :date9. AVALC $ ANL01FL $ ASEQ;

datalines;
STUDY01 SUBJ001 CRSP 15JAN2023 Y Y 1
STUDY01 SUBJ001 PD   10FEB2023 Y Y 2
STUDY01 SUBJ002 CRSP 20JAN2023 Y Y 1
STUDY01 SUBJ002 LST  15MAR2023 Y Y 2
STUDY01 SUBJ003 CRSP 25JAN2023 Y Y 1
STUDY01 SUBJ003 DEATH 20FEB2023 Y Y 2
;
run;


data adrs_pd adrs_death adrs_lst adrs_crsp;

set adrs;

if PARAMCD="PD" then output adrs_pd;
else if PARAMCD="DEATH" then output adrs_death;
else if PARAMCD="LST" then output adrs_lst;
else if PARAMCD="CRSP" then output adrs_crsp;

run;


proc sort data=adrs_pd; by USUBJID; run;
proc sort data=adrs_death; by USUBJID; run;
proc sort data=adrs_lst; by USUBJID; run;
proc sort data=adrs_crsp; by USUBJID; run;


data adrs_events;

merge adrs_pd(rename=(ADT=ADT_PD))
      adrs_death(rename=(ADT=ADT_DEATH))
      adrs_lst(rename=(ADT=ADT_LST))
      adrs_crsp(rename=(ADT=ADT_CRSP));

by USUBJID;

run;


data adrs_dor;

set adrs_events;

length PARAMCD $8 PARAM $50 CNSR 8 AVAL 8;

PARAMCD="DOR";
PARAM="Duration of Response by Investigator";

STARTDT=ADT_CRSP;

if ADT_PD ne . then do;
ADT=ADT_PD;
CNSR=0;
end;

else if ADT_DEATH ne . then do;
ADT=ADT_DEATH;
CNSR=0;
end;

else if ADT_LST ne . then do;
ADT=ADT_LST;
CNSR=0;
end;

AVAL=(ADT-STARTDT+1)/30.4375;

run;


proc sort data=adsl; by USUBJID; run;
proc sort data=adrs_death; by USUBJID; run;


data adrs_os;

merge adsl(in=a)
      adrs_death(rename=(ADT=ADT_DEATH) in=b);

by USUBJID;

if a;

length PARAMCD $8 PARAM $40 CNSR 8 AVAL 8;

PARAMCD="OS";
PARAM="Overall Survival";

STARTDT=TRTSDT;

if b then do;
ADT=ADT_DEATH;
CNSR=0;
end;

else do;
ADT=today();
CNSR=1;
end;

AVAL=(ADT-STARTDT+1)/30.4375;

run;


data adtte;

set adrs_dor
    adrs_os;

run;
