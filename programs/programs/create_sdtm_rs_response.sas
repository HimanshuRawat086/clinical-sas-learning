data resist;

length STUDYID $10 SITEID $5 SUBJID $5 
       TRGRESP $10 NTRGRESP $10 OVRRESP $10;

input STUDYID $ SITEID $ SUBJID $
      TRGRESP $ NTRGRESP $ OVRRESP $;

datalines;
STUDY1 101 001 CR PR CR
STUDY1 101 002 PD SD PD
;
run;


data rs;

set resist;

DOMAIN = "RS";

USUBJID = catx("-", STUDYID, SITEID, SUBJID);


/* Target Response */
RSTESTCD = "TRG";
RSTEST   = "Target Response";
RSORRES  = TRGRESP;
RSSTRESC = TRGRESP;
output;


/* Non-Target Response */
RSTESTCD = "NTRG";
RSTEST   = "Non-Target Response";
RSORRES  = NTRGRESP;
RSSTRESC = NTRGRESP;
output;


/* Overall Response */
RSTESTCD = "OVR";
RSTEST   = "OVERALL RESPONSE";
RSORRES  = OVRRESP;
RSSTRESC = OVRRESP;
output;

run;


proc sort data = rs;
by USUBJID;
run;


data rs_final;

set rs;

by USUBJID;

if first.USUBJID then RSSEQ = 1;
else RSSEQ + 1;

run;
