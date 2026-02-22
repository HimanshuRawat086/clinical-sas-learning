/************************************************************
 Project : Abnormal Lab Listing (CSR Style)
 Author  : Himanshu Rawat
 Purpose : Generate paginated abnormal lab listings
 Output  : RTF files
************************************************************/

/*----------------------------------------------------------
  SECTION 1: Create Dummy ADLB Dataset
----------------------------------------------------------*/

data work.adlb;

length usubjid $10 parcat1 $15 param $15 avisit $20 anrind $1;
format adt yymmdd10.;

input usubjid $
      parcat1 $
      param $
      avisit $
      adt : yymmdd10.
      anrlo anrhi aval anrind $;

datalines;
SUBJ001 CHEMISTRY GLUCOSE Visit1 2024-01-01 70 100 120 H
SUBJ001 CHEMISTRY GLUCOSE Visit2 2024-01-10 70 100 85 N
SUBJ002 CHEMISTRY UREA Visit1 2024-01-05 10 50 60 H
SUBJ003 HEMATOLOGY HGB Visit1 2024-01-02 12 16 10 L
SUBJ004 CHEMISTRY GLUCOSE Visit1 2024-01-07 70 100 95 N
;
run;


/*----------------------------------------------------------
  SECTION 2: Macro Definition
----------------------------------------------------------*/

%macro lab(cat, title_text, listnum, filetag);

/* Filter abnormal values */
data work.lab1;
  set work.adlb;
  where parcat1 = "&cat" and anrind ne "N";
  keep usubjid param avisit adt anrlo anrhi aval anrind;
run;

/* Create display variables */
data work.lab2;
  set work.lab1;

  range     = catx(" - ", put(anrlo,8.), put(anrhi,8.));
  adt_char  = strip(put(adt,yymmdd10.));
  aval_char = strip(put(aval,8.));

  keep usubjid param avisit range adt_char aval_char anrind;
run;

/* Sort for consistent listing order */
proc sort data=work.lab2 out=work.lab_sorted;
  by usubjid param avisit;
run;

/* Pagination logic (20 lines per page) */
data work.lab_final;
  set work.lab_sorted;
  retain line 0 page 1;

  line + 1;

  if line > 20 then do;
     page + 1;
     line = 1;
  end;
run;


/*----------------------------------------------------------
  SECTION 3: ODS RTF Output
----------------------------------------------------------*/

options orientation=landscape;

title1 j=l "AIRIS PHARMA Private Limited.";
title2 j=l "Protocol: 043-1810";
title3 j=c "&listnum &title_text";

ods rtf file="lab_&filetag..rtf" style=journal;


/*----------------------------------------------------------
  SECTION 4: PROC REPORT
----------------------------------------------------------*/

proc report data=work.lab_final nowd split="|";

  column page usubjid param avisit range adt_char aval_char anrind;

  define page      / order noprint;
  define usubjid   / display "Subject|Number";
  define param     / display "Test";
  define avisit    / display "Visit";
  define range     / display "Normal Range";
  define adt_char  / display "Date of Measurement";
  define aval_char / display "Result";
  define anrind    / display "Flag";

  break after page / page;

run;

ods rtf close;

title;
options orientation=portrait;

%mend;


/*----------------------------------------------------------
  SECTION 5: Macro Calls
----------------------------------------------------------*/

%lab(CHEMISTRY,
     Abnormal Biochemistry Values,
     16.2.1.7,
     C);

%lab(HEMATOLOGY,
     Abnormal Hematology Values,
     16.2.1.8,
     H);

/************************************************************
 End of Program
************************************************************/
