/************************************************************
 Project : Assignment to Analysis Populations Listing
 Author  : Himanshu Rawat
 Purpose : Create clinical-style listing using PROC REPORT
 Output  : RTF file
************************************************************/

/*----------------------------------------------------------
  SECTION 1: Create Sample ADSL Dataset
----------------------------------------------------------*/

data work.adsl;

  length usubjid $10
         saffl dltevlfl pkevlfl enrlfl $1;

  input usubjid $
        saffl $
        dltevlfl $
        pkevlfl $
        enrlfl $;

datalines;
SUBJ001 Y N Y Y
SUBJ002 Y Y N Y
SUBJ003 N N N N
SUBJ004 Y N Y N
;
run;


/*----------------------------------------------------------
  SECTION 2: Prepare Listing Dataset
----------------------------------------------------------*/

data work.l_16211;
  set work.adsl;
  keep usubjid saffl dltevlfl pkevlfl enrlfl;
run;


/*----------------------------------------------------------
  SECTION 3: Page Setup
----------------------------------------------------------*/

options orientation=landscape;

title1 j=l "AIRIS PHARMA Private Limited.";
title2 j=l "Protocol: 043-1810";
title3 j=c "16.2.1.1 Assignment to Analysis Populations";


/*----------------------------------------------------------
  SECTION 4: Start RTF Output
----------------------------------------------------------*/

ods rtf file="l_16211_practise.rtf" style=journal;


/*----------------------------------------------------------
  SECTION 5: Generate Listing using PROC REPORT
----------------------------------------------------------*/

proc report data=work.l_16211 nowd split='|';

  column usubjid saffl dltevlfl pkevlfl enrlfl;

  define usubjid  / display "Subject|Number" width=15;
  define saffl    / display "Safety|Population" width=15 center;
  define dltevlfl / display "DLT Evaluable|Population" width=20 center;
  define pkevlfl  / display "PK Evaluable|Population" width=20 center;
  define enrlfl   / display "Enrolled|Population" width=15 center;

run;


/*----------------------------------------------------------
  SECTION 6: Close RTF Output
----------------------------------------------------------*/

ods rtf close;


/*----------------------------------------------------------
  SECTION 7: Reset Environment
----------------------------------------------------------*/

title;
options orientation=portrait;

/************************************************************
 End of Program
************************************************************/
