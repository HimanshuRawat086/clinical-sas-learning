/*******************************************************
   Clinical SAS — PROC PRINT & PROC SORT Examples
*******************************************************/

/********************************* PROC PRINT ***********************************/
proc print data=sashelp.class;
run;

proc print data=sashelp.class;
  var name age sex;
run;

proc print data=sashelp.class;
  var sex name age;
run;

proc print data=sashelp.class;
  var name age height weight;
run;

/* Drop a variable in PROC PRINT */
proc print data=sashelp.class(drop=sex);
run;

/* SUM statement */
proc print data=sashelp.class;
  sum age;
run;

/* WHERE clause */
proc print data=sashelp.class;
  where age > 13;
run;

/* Full width, no observation numbers */
proc print data=sashelp.class width=full noobs;
  where age > 13;
run;

/* LABEL in DATA step, default print */
data test;
  set sashelp.class;
  label name = "Student Name"
        sex  = "Student Gender";
run;

proc print data=test;
run;

/* LABEL option in PROC PRINT */
proc print data=test label;
run;

/* More descriptive labels */
data test;
  set sashelp.class;
  label name = "Name of the Student"
        sex  = "Gender of the Student";
run;

proc print data=test label;
run;

/* Using SPLIT= with # in labels */
data test;
  set sashelp.class;
  label name = "Name#of the#Student"
        sex  = "Gender#of the#Student";
run;

proc print data=test split="#";
run;

/* SPLIT in PROC PRINT instead of DATA step order */
data test;
  set sashelp.class;
run;

proc print data=test split="#";
  label name = "Name#of the#Student"
        sex  = "Gender#of the#Student";
run;

/* DOUBLE option for double spacing */
data test;
  set sashelp.class;
run;

proc print data=test split="#" double;
  label name = "Name#of the#Student"
        sex  = "Gender#of the#Student";
run;

/* HEADING=VERTICAL */
data test;
  set sashelp.class;
run;

proc print data=test heading=vertical;
run;

/********************************* PROC SORT ***********************************/

/* Simple sort in-place (overwrites sashelp.class in WORK only if copied) */
proc sort data=sashelp.class;
  by age;
run;

/* Sort with OUT= */
proc sort data=sashelp.class out=naidu;
  by age;
run;

/* Sort with OUT= and KEEP= */
proc sort data=sashelp.class out=naidu(keep=name sex);
  by age;
run;

/* Sort by multiple variables */
proc sort data=sashelp.class out=naidu;
  by sex age;
run;

proc print data=naidu;
run;

/* Sort in descending order */
proc sort data=sashelp.class out=naidu;
  by descending sex age;
run;

proc print data=naidu;
run;

/* Sort with both variables in DESCENDING */
proc sort data=sashelp.class out=naidu;
  by descending sex descending age;
run;

proc print data=naidu;
run;

/* Small numeric + character example */
data test;
  input x y$;
  cards;
1 20
. 10
20 .
;
run;

proc print data=test;
run;

/* Character sort example */
data test;
  input x$;
  cards;
20
30
.
-2
$
hyd
Hyd
mum
NyK
TKO
;
run;

proc sort data=test;
  by x;
run;

proc print data=test;
run;

/* NODUPKEY examples */
proc sort data=sashelp.class out=test nodupkey;
  by age;
run;

/* Further sort with NODUPKEY by sex */
proc sort data=test nodupkey;
  by sex;
run;

/* BY-group printing */
proc sort data=sashelp.class out=test;
  by sex;
run;

proc print data=test;
  by sex;
run;

proc print data=test;
run;

/* NODUPKEY with DUPOUT= */
proc sort data=sashelp.class out=test nodupkey dupout=abc;
  by age;
run;

/* Keep only age in output, unique ages */
proc sort data=sashelp.class out=test(keep=age) nodupkey;
  by age;
run;

/********************************* CLINICAL-LIKE DATA **************************/
data clinical;
  input pid center $ year age;
  cards;
123 appolo 1999 56
134 nims   1998 60
123 appolo 1999 56
167 nims   1994 89
189 care   1889 90
167 nims   1994 56
178 care   1997 87
;
run;

/* NODUPKEY NOEQUALS */
proc sort data=clinical out=medi nodupkey noequals;
  by pid;
run;

/* NODUPKEY with DUPOUT= */
proc sort data=clinical out=medi nodupkey dupout=ll;
  by pid;
run;

/* NODUPREC example */
proc sort data=clinical out=medi noduprec dupout=ll;
  by pid;
run;

/* NODUPKEY by all variables */
proc sort data=clinical out=medi nodupkey;
  by _all_;
run;

proc print data=medi;
run;

/********************************* EMPLOY DATA EXAMPLE *************************/
data Employ;
  input Eid Desg $ Salary;
  cards;
101 Tester  3400
102 Progmer 4500
103 tester  3400
104 analyst 2400
105 Analyst 3000
;
run;

/* Sort by designation */
proc sort data=Employ out=Employ2;
  by Desg;
run;

proc print data=Employ2;
  by Desg;
  id Desg;
run;

/* SASHELP.CLASS sorted and printed by sex */
proc sort data=sashelp.class out=Employ2;
  by sex;
run;

proc print data=Employ2;
  by sex;
  id sex;
run;
