/************************************************************
 Project : SAS Macros Demo
 Author  : Himanshu Rawat
 Topic   : Macro variables, loops, SQL INTO, scope & quoting
************************************************************/

/*===========================================================
  SECTION 1: BASIC MACRO WITH PARAMETERS
===========================================================*/

%macro kk (inds=, vr1=, vr2=, ods=, ods2=);

  proc print data=&inds;
  run;

  proc means data=&inds noprint;
    class &vr1;
    var &vr2;
    output out=&ods;
  run;

  proc freq data=&inds noprint;
    tables &vr1 / out=&ods2;
  run;

%mend;

%kk(inds=sashelp.class, vr1=sex, vr2=age, ods=naidu, ods2=ganesh);


/*===========================================================
  SECTION 2: MACRO VARIABLES USING %LET
===========================================================*/

%let x = 20;
%let city = HYD;

data &city;
  set sashelp.class;
  abc = "&x";
  &city = &x;
  xyz = &x * 2;
run;

title "This data is of city &city around &x people data";
proc print data=&city; run;


/* Reassign macro variables */
%let x = 200;
%let city = BNG;

data &city;
  set sashelp.class;
  abc = "&x";
  &city = &x;
  xyz = &x * 2;
run;

title "This data is of city &city around &x people data";
proc print data=&city; run;


/*===========================================================
  SECTION 3: MACRO LOOPS
===========================================================*/

%macro create_sets;
  %do i = 1 %to 10;
    data test&i;
      set sashelp.class;
      x = &i;
    run;
  %end;
%mend;

%create_sets;


/*===========================================================
  SECTION 4: PROC SQL INTO MACRO VARIABLES
===========================================================*/

proc sql noprint;
  select count(sex) into :x1
  from sashelp.class
  where age > 12 and sex = "F";

  select count(sex) into :x2
  from sashelp.class
  where age > 12 and sex = "M";
quit;

%put &=x1 &=x2;

title "This data has males=&x2 and females=&x1";
proc print data=sashelp.class;
  where age > 12;
run;


/*===========================================================
  SECTION 5: CALL SYMPUT & SYMPUTX
===========================================================*/

proc freq data=sashelp.class noprint;
  tables sex / out=kk;
  where age > 12;
run;

data _null_;
  set kk;
  if sex = "F" then call symputx('F', count);
  if sex = "M" then call symputx('M', count);
run;

%put &=F &=M;

title "This data has males=&M and females=&F";
proc print data=sashelp.class;
  where age > 12;
run;


/*===========================================================
  SECTION 6: %LOCAL and %GLOBAL
===========================================================*/

%let a = 20;
%put Global A = &a;

%macro scope_test;
  %local a;
  %let a = 200;
  %put Local A = &a;
%mend;

%scope_test;
%put Global A after macro = &a;


/*===========================================================
  SECTION 7: CONDITIONAL MACROS
===========================================================*/

%macro weekday_logic;

  %if &sysday = Sunday %then %do;
    proc means data=sashelp.class; run;
  %end;
  %else %if &sysday = Thursday %then %do;
    proc freq data=sashelp.class; run;
  %end;
  %else %do;
    proc print data=sashelp.class; run;
  %end;

%mend;

options mlogic;
%weekday_logic;


/*===========================================================
  SECTION 8: POSITIONAL VS KEYWORD PARAMETERS
===========================================================*/

/* Positional */
%macro mn_pos(x, y, z);
  proc means data=&x;
    class &y;
    var &z;
  run;
%mend;

%mn_pos(sashelp.class, sex, age);


/* Keyword */
%macro mn_kw(inds=, cls=, avr=, tl=);
  proc means data=&inds;
    class &cls;
    var &avr;
    title "&tl";
  run;
%mend;

options mprint symbolgen;

%mn_kw(inds=sashelp.class, cls=sex, avr=age,
       tl=%str(This is my student data));

%mn_kw(inds=sashelp.class, cls=sex, avr=age,
       tl=%nrstr(This is my student data, of today&tom));

%mn_kw(inds=sashelp.class, cls=sex, avr=age,
       tl=%bquote(%nrstr(This is my "student" data, of today&tom)));

/************************************************************
 End of SAS Macros Demo
************************************************************/
