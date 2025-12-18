/************************************************************
 Project : INFILE Options & Raw Data Handling
 Author  : Himanshu Rawat
 Topic   : MISSOVER, TRUNCOVER, DLM, DSD, FIRSTOBS
************************************************************/

/*===========================================================
  SECTION 1: Missing Data Handling
===========================================================*/

data trials;
  input center $ trial $ sub;
cards;
appolo phase1 78
nims      .    89
care   phase3 56
appolo phase2  .
nims   phase2 79
care   phase3  .
;
run;

proc print data=trials noobs; title "Missing values demo"; run;

/*===========================================================
  SECTION 2: MISSOVER
===========================================================*/

data missing;
  infile datalines missover;
  input x 1-2 y z;
datalines;
11 1 78
12 2 89
   3 56
14 2
15 2 79
16 3
;
run;

proc print data=missing noobs; title "MISSOVER option"; run;

/*===========================================================
  SECTION 3: FLOWOVER (Default Behavior)
===========================================================*/

data numbers_flowover;
  input TestNumber xx;
cards;
22
333
4444
55555
;
run;

proc print data=numbers_flowover noobs;
title "FLOWOVER (default behavior)";
run;

/*===========================================================
  SECTION 4: STOPPEDOVER
===========================================================*/

data numbers_stopover;
  infile "New Text Document.txt" stopover;
  input TestNumber 3.;
run;

proc print data=numbers_stopover noobs;
title "STOPPEDOVER option";
run;

/*===========================================================
  SECTION 5: MISSOVER vs TRUNCOVER
===========================================================*/

data numbers_missover;
  infile "New Text Document.txt" missover;
  input TestNumber 4.;
run;

data numbers_truncover;
  infile "New Text Document.txt" truncover;
  input TestNumber 5.;
run;

proc print data=numbers_missover noobs;
title "MISSOVER example";
run;

proc print data=numbers_truncover noobs;
title "TRUNCOVER example";
run;

/*===========================================================
  SECTION 6: DLM – Custom Delimiters
===========================================================*/

data clin_dlm;
  infile cards dlm=',&$ ';
  input pid name $ age gender $;
cards;
123,kiran$24&male
145&kumar,25 male
134 ramya$25$female
;
run;

proc print data=clin_dlm noobs;
title "DLM with multiple delimiters";
run;

/*===========================================================
  SECTION 7: DSD – Data Sensitive Delimiter
===========================================================*/

data clin_dsd;
  infile cards dsd;
  input pid name $ age gender $;
cards;
123,kiran,24,male
145,,,male
134,ramya,25,female
;
run;

proc print data=clin_dsd noobs;
title "DSD handling missing and quotes";
run;

/* Removing quotes automatically */
data clinical_quotes;
  infile cards dsd;
  input pid name $ age gender $;
cards;
134,'kiran',56,male
167,kumar,26,"male"
156,"ramya",45,female
;
run;

proc print data=clinical_quotes noobs;
title "DSD removing quotes";
run;

/*===========================================================
  SECTION 8: Reading Partial Data
===========================================================*/

data lab;
  input @ 'Care' trial $ sub;
cards;
appolo phase1 78
nims   phase1 45
Care   phase1 89.2
appolo phase2 45
nims   phase2 67
Care   phase2 89
nims   phase3 46
;
run;

proc print data=lab noobs;
title "Scanning raw data using pointer control";
run;

/*===========================================================
  SECTION 9: FIRSTOBS
===========================================================*/

data blood1;
  infile "blood.txt" firstobs=5;
  input pid gender $ bloodtype $ agegroup $ wbc rbc chole;
run;

proc print data=blood1 noobs;
title "FIRSTOBS example";
run;

/*===========================================================
  SECTION 10: Clinical-Style Raw Data Example
===========================================================*/

data rawdata;
  infile "rawdata.csv" dlm=',' firstobs=2;
  input CONTROL_NO $11. DOSE $ PATNO $13.
        VISIT BMI ECG HR RESP S_BP D_BP
        WBC RBC HEMOGLOBIN PLATELET_COUNT;
run;

/*===========================================================
  SECTION 11: INFILE vs PROC IMPORT (Conceptual)
===========================================================*/
/*
INFILE:
- Full control
- Faster for large files
- Handles irregular formats

PROC IMPORT:
- Easy to use
- Best for Excel and standard CSV
- Less control
*/

/************************************************************
 End of INFILE & Raw Data Handling Demo
************************************************************/
