/************************************************************
 Project : Table 14.1.2 – Age Summary
 Author  : Himanshu Rawat
 Purpose : Continuous demographic summary table
************************************************************/

/*----------------------------------------------------------
  SECTION 1: Create Fake ADSL
----------------------------------------------------------*/

data work.adsl;

length usubjid $10
       trt01a   $10
       trt01an  8
       saffl    $1
       age      8;

input usubjid $
      trt01a $
      trt01an
      saffl $
      age;

datalines;
SUBJ001 A 1 Y 65
SUBJ002 A 1 Y 70
SUBJ003 A 1 Y 59
SUBJ004 B 2 Y 62
SUBJ005 B 2 Y 75
SUBJ006 B 2 Y 68
SUBJ007 C 3 Y 55
SUBJ008 C 3 Y 72
SUBJ009 C 3 Y 60
SUBJ010 D 4 Y 66
SUBJ011 D 4 Y 73
;
run;


/*----------------------------------------------------------
  SECTION 2: Safety Population
----------------------------------------------------------*/

data work.adsl2;
  set work.adsl;
  where saffl="Y";
  keep usubjid trt01a trt01an age;
run;


/*----------------------------------------------------------
  SECTION 3: Descriptive Statistics
----------------------------------------------------------*/

proc summary data=work.adsl2 nway;
class trt01an trt01a;
var age;

output out=work.age_stats
n     = n
mean  = mean
std   = sd
median= median
min   = min
max   = max;
run;


/*----------------------------------------------------------
  SECTION 4: Create Display Rows
----------------------------------------------------------*/

data work.rows;
  set work.age_stats;

  length rowlabel $40 value $30;

  /* Row 1: N */
  rowlabel = "N";
  value = strip(put(n,3.));
  ord=1; output;

  /* Row 2: Mean (SD) */
  rowlabel = "Mean (SD)";
  value = cats(put(mean,5.1),
               " (",
               put(sd,5.1),
               ")");
  ord=2; output;

  /* Row 3: Median */
  rowlabel = "Median";
  value = strip(put(median,5.1));
  ord=3; output;

  /* Row 4: Min, Max */
  rowlabel = "Min, Max";
  value = cats(put(min,5.1),
               ", ",
               put(max,5.1));
  ord=4; output;

  keep trt01an trt01a rowlabel value ord;
run;


/*----------------------------------------------------------
  SECTION 5: Transpose
----------------------------------------------------------*/

proc sort data=work.rows;
by ord rowlabel trt01an;
run;

proc transpose data=work.rows
               out=work.final(drop=_name_)
               prefix=Trt_;
by ord rowlabel;
id trt01an;
var value;
run;


/*----------------------------------------------------------
  SECTION 6: Generate RTF Table
----------------------------------------------------------*/

ods rtf file="Table_1412.rtf" style=journal;

proc report data=work.final nowd;

column ord rowlabel Trt_1 Trt_2 Trt_3 Trt_4;

define ord / order noprint;
define rowlabel / display "Age (Years)";

define Trt_1 / display "Drug A";
define Trt_2 / display "Drug B";
define Trt_3 / display "Drug C";
define Trt_4 / display "Drug D";

run;

ods rtf close;

/************************************************************
 End of Program
************************************************************/
