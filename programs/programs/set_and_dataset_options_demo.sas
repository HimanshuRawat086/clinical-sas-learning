/************************************************************
   Clinical SAS — SET Statement & Dataset Options Demo
   Source: SASHELP.CLASS and SASHELP.HEART
************************************************************/

/* 1. Basic SET: copy SASHELP.CLASS to WORK.TEST */
data test;
  set sashelp.class;
run;

proc print data=test;
  title "1) Basic SET: sashelp.class -> work.test";
run;

/* 2. KEEP= : keep only selected variables */
data test;
  set sashelp.class(keep=name age sex);
run;

proc print data=test;
  title "2) KEEP= : name age sex only";
run;

/* 3. DROP= : drop selected variables */
data test;
  set sashelp.class(drop=name age sex);
run;

proc print data=test;
  title "3) DROP= : everything except name age sex";
run;

/* 4. WHERE= : subset rows on input */
data test;
  set sashelp.class(where=(sex="F"));
run;

proc print data=test;
  title "4) WHERE= : only females from sashelp.class";
run;

/* 5. RENAME= : rename columns while reading */
data test;
  set sashelp.class(rename=(name=sname));
run;

proc print data=test;
  title "5) RENAME= : name -> sname";
run;

/* 6. Concatenate two datasets: CLASS and HEART (structure differs) */
data test;
  set sashelp.class sashelp.heart;
run;

proc print data=test(obs=20);
  title "6) SET with two datasets: sashelp.class + sashelp.heart (first 20 obs)";
run;

/* 7. Concatenate the same dataset twice (duplicates rows) */
data test;
  set sashelp.class sashelp.class;
run;

proc print data=test;
  title "7) Concatenating sashelp.class twice (duplicate rows)";
run;

/* 8. Two SET statements in same DATA step (creates Cartesian-like effect) */
data test;
  set sashelp.class;
  set sashelp.class;
run;

proc print data=test(obs=20);
  title "8) Two SET statements in same DATA step";
run;

/* 9. OBS= : read only first 5 observations */
data test;
  set sashelp.class(obs=5);
run;

proc print data=test;
  title "9) OBS=5 : first 5 observations from sashelp.class";
run;

/* 10. FIRSTOBS= and OBS= : rows 5 to 10 */
data test;
  set sashelp.class(firstobs=5 obs=10);
run;

proc print data=test;
  title "10) FIRSTOBS=5 OBS=10 : rows 5–10";
run;

/* 11. FIRSTOBS= only : from row 5 to end */
data test;
  set sashelp.class(firstobs=5);
run;

proc print data=test;
  title "11) FIRSTOBS=5 : from row 5 to end";
run;

/* 12. Full copy again (reset example) */
data test;
  set sashelp.class;
run;

proc print data=test;
  title "12) Full copy of sashelp.class again";
run;

/* 13. Copy sashelp.heart */
data test;
  set sashelp.heart;
run;

proc print data=test(obs=10);
  title "13) Copy of sashelp.heart (first 10 obs)";
run;

/* 14. REPLACE=NO : prevents overwriting an existing dataset of same name
   Note: behavior depends on whether WORK.TEST already exists. */
data test(replace=no);
  set sashelp.heart;
run;

proc print data=test(obs=10);
  title "14) DATA test(REPLACE=NO) from sashelp.heart (first 10 obs)";
run;

/* 15. Password protect dataset with PW= */
data test(pw=abc);
  set sashelp.heart;
run;

/* 16. Password & READ= protection (read-password) */
data test(pw=abc read=xyz);
  set sashelp.heart;
run;

/* 17. Modify dataset password using PROC DATASETS
   Syntax: MODIFY table (PW=old/new); */
proc datasets library=work nolist;
  modify test(pw=abc/naidu);
quit;

/* 18. Remove password (naidu/) */
proc datasets library=work nolist;
  modify test(pw=naidu/);
quit;

/* 19. Assign label to a new dataset ADSL */
data adsl(label="this is my data");
  set sashelp.heart;
run;

proc print data=adsl(obs=10);
  title "19) ADSL with dataset label";
run;

title;
