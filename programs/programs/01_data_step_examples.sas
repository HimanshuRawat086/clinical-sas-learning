/*****************************************************/
/*           SAS DATA STEP – SET Statement Examples  */
/*****************************************************/

/* Basic SET */
data test;
set sashelp.class;
run;

/* KEEP */
data test;
set sashelp.class(keep=name age sex);
run;
proc print data=test; run;

/* DROP */
data test;
set sashelp.class(drop=name age sex);
run;
proc print data=test; run;

/* WHERE */
data test;
set sashelp.class(where=(sex="F"));
run;
proc print data=test; run;

/* RENAME */
data test;
set sashelp.class(rename=(name=sname));
run;
proc print data=test; run;

/* Combine Two Datasets */
data test;
set sashelp.class sashelp.heart;
run;
proc print data=test; run;

/* Duplicate Same Dataset */
data test;
set sashelp.class sashelp.class;
run;
proc print data=test; run;

/* SET the same dataset twice inside same step */
data test;
set sashelp.class;
set sashelp.class;
run;
proc print data=test; run;

/* OBS= */
data test;
set sashelp.class(obs=5);
run;
proc print data=test; run;

/* FIRSTOBS + OBS */
data test;
set sashelp.class(firstobs=5 obs=10);
run;
proc print data=test; run;

/* FIRSTOBS only */
data test;
set sashelp.class(firstobs=5);
run;
proc print data=test; run;

/* SET heart */
data test;
set sashelp.heart;
run;
proc print data=test; run;

/* REPLACE = NO */
data test(replace=no);
set sashelp.heart;
run;
proc print data=test; run;

/* PASSWORD */
data test(pw=abc);
set sashelp.heart;
run;

data test(pw=abc read=xyz);
set sashelp.heart;
run;

/* PROC DATASETS modify */
proc datasets;
modify test(pw=abc/naidu);
run;

proc datasets;
modify test(pw=naidu/);
run;

/* LABEL */
data adsl(label="this is my data");
set sashelp.heart;
run;
