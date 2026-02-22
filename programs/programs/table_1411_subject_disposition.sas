/************************************************************
 Project : Table 14.1.1 – Subject Disposition
 Author  : Himanshu Rawat
 Purpose : Generate N (%) summary table by treatment
 Output  : RTF Table
************************************************************/

/*----------------------------------------------------------
  SECTION 1: Create Dummy ADSL Dataset
----------------------------------------------------------*/

data work.adsl;

length usubjid $10
       trt01a   $10
       saffl    $1
       eosstt   $15
       disreas  $20;

input usubjid $
      trt01a $
      trt01an
      saffl $
      eosstt $
      disreas $;

datalines;
SUBJ001 DrugA 1 Y COMPLETED NA
SUBJ002 DrugA 1 Y DISCONTINUED AE
SUBJ003 DrugA 1 Y DISCONTINUED WITHDRAWAL
SUBJ004 DrugB 2 Y COMPLETED NA
SUBJ005 DrugB 2 Y DISCONTINUED AE
SUBJ006 DrugB 2 N COMPLETED NA
SUBJ007 DrugC 3 Y COMPLETED NA
SUBJ008 DrugC 3 Y DISCONTINUED AE
SUBJ009 DrugC 3 Y COMPLETED NA
SUBJ010 DrugD 4 Y COMPLETED NA
SUBJ011 DrugD 4 Y DISCONTINUED WITHDRAWAL
;
run;


/*----------------------------------------------------------
  SECTION 2: Filter Safety Population
----------------------------------------------------------*/

data work.adsl1;
  set work.adsl;
  where saffl = "Y";
  keep usubjid trt01a trt01an eosstt disreas;
run;


/*----------------------------------------------------------
  SECTION 3: Create Denominator (Capital N)
----------------------------------------------------------*/

proc sql;
  create table work.trt as
  select trt01an,
         trt01a,
         count(distinct usubjid) as denom
  from work.adsl1
  group by trt01an, trt01a
  order by trt01an;
quit;


/*----------------------------------------------------------
  SECTION 4: Row 1 – Subjects Planned
----------------------------------------------------------*/

proc sql;
  create table work.row1 as
  select trt01an,
         trt01a,
         "Subjects Planned for Treatment" as rowlabel length=50,
         1 as ord,
         count(distinct usubjid) as n
  from work.adsl1
  group by trt01an, trt01a;
quit;


/*----------------------------------------------------------
  SECTION 5: Row 2 – Subjects Withdrawn
----------------------------------------------------------*/

proc sql;
  create table work.row2 as
  select trt01an,
         trt01a,
         "Subjects Withdrawn" as rowlabel length=50,
         2 as ord,
         count(distinct usubjid) as n
  from work.adsl1
  where eosstt = "DISCONTINUED"
  group by trt01an, trt01a;
quit;


/*----------------------------------------------------------
  SECTION 6: Combine Rows
----------------------------------------------------------*/

data work.all_rows;
  set work.row1 work.row2;
run;


/*----------------------------------------------------------
  SECTION 7: Merge Denominator & Calculate %
----------------------------------------------------------*/

proc sort data=work.all_rows; by trt01an; run;
proc sort data=work.trt;      by trt01an; run;

data work.with_pct;
  merge work.all_rows work.trt;
  by trt01an;

  pct = (n / denom) * 100;

  pct_char = cats(put(n,3.), " (",
                  put(pct,5.1), "%)");
run;


/*----------------------------------------------------------
  SECTION 8: Transpose to Treatment Columns
----------------------------------------------------------*/

proc sort data=work.with_pct;
  by ord rowlabel trt01an;
run;

proc transpose data=work.with_pct
               out=work.final(drop=_name_)
               prefix=Trt_;
  by ord rowlabel;
  id trt01an;
  var pct_char;
run;


/*----------------------------------------------------------
  SECTION 9: Generate RTF Table
----------------------------------------------------------*/

ods rtf file="Table_1411.rtf" style=journal;

proc report data=work.final nowd;

  column ord rowlabel Trt_1 Trt_2 Trt_3 Trt_4;

  define ord      / order noprint;
  define rowlabel / display "Population";

  define Trt_1 / display "Drug A";
  define Trt_2 / display "Drug B";
  define Trt_3 / display "Drug C";
  define Trt_4 / display "Drug D";

run;

ods rtf close;

/************************************************************
 End of Program
************************************************************/
