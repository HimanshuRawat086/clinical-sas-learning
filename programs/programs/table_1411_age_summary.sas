/************************************************************
 Project : Table 14.1.1 – Age Summary by Treatment
 Author  : Himanshu Rawat
 Purpose : Generate demographic summary table
 Output  : RTF file
************************************************************/

/*----------------------------------------------------------
  SECTION 1: Create Dummy ADSL Dataset
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
SUBJ01 A 1 Y 45
SUBJ02 A 1 Y 50
SUBJ03 B 2 Y 60
SUBJ04 B 2 Y 55
SUBJ05 C 3 Y 70
SUBJ06 C 3 Y 65
SUBJ07 D 4 Y 75
SUBJ08 D 4 Y 68
SUBJ09 A 1 Y 48
SUBJ10 B 2 Y 52
SUBJ11 C 3 Y 62
;
run;


/*----------------------------------------------------------
  SECTION 2: Filter Safety Population
----------------------------------------------------------*/

data work.adsl2;
  set work.adsl;
  where saffl = "Y";
  keep usubjid trt01a trt01an age;
run;


/*----------------------------------------------------------
  SECTION 3: Create Denominator
----------------------------------------------------------*/

proc sql;
create table work.trt as 
select trt01an,
       trt01a,
       count(distinct usubjid) as denom
from work.adsl2
group by trt01an, trt01a
order by trt01an;
quit;


/*----------------------------------------------------------
  SECTION 4: Descriptive Statistics
----------------------------------------------------------*/

proc summary data=work.adsl2 nway;
class trt01an trt01a;
var age;

output out=work.adsl_sum
       n=n_age
       mean=mean_age
       std=sd_age
       min=min_age
       max=max_age;
run;


/*----------------------------------------------------------
  SECTION 5: Create Row for N (%)
----------------------------------------------------------*/

proc sql;
create table work.row1 as
select trt01an,
       trt01a,
       "Number of Subjects" as rowlabel length=40,
       1 as ord,
       count(distinct usubjid) as n
from work.adsl2
group by trt01an, trt01a;
quit;


/*----------------------------------------------------------
  SECTION 6: Merge Denominator and Create %
----------------------------------------------------------*/

proc sort data=work.row1; by trt01an; run;
proc sort data=work.trt;  by trt01an; run;

data work.with_pct;
merge work.row1 work.trt;
by trt01an;

pct = (n/denom)*100;

pct_char = cats(put(n,3.),
                " (",
                put(pct,5.1),
                "%)");
run;


/*----------------------------------------------------------
  SECTION 7: Transpose
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
  SECTION 8: Generate RTF Table
----------------------------------------------------------*/

ods rtf file="table_1411_age_summary.rtf" style=journal;

proc report data=work.final nowd;

column ord rowlabel Trt_1 Trt_2 Trt_3 Trt_4;

define ord / order noprint;
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
