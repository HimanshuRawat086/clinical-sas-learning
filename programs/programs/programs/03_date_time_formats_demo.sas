/*******************************************************************************************
*    SAS DATE, TIME, DATETIME, AND NUMERIC FORMATS — EXAMPLES
*******************************************************************************************/

data test;
input pid jdate;
cards;
1 10/12/2024
2 01/01/2010
3 01/16/2008
4 01/01/1960
5 01/02/1958
;
run;
proc print data=test;
run;

data test;
input pid jdate$;
cards;
1 10/12/2024
2 01/01/2010
3 01/16/2008
4 01/01/1960
5 01/02/1958
;
run;
proc print data=test;
run;

data test;
input pid jdate;
informat jdate ddmmyy10.;
cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
4 01/01/1960
5 01/02/1958
6 01/02/35
;
run;
proc print data=test;
format jdate ddmmyy10.;
run;

data test;
input pid jdate;
informat jdate ddmmyy10.;
format jdate mmddyy10.;
cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
;
run;
proc print data=test;
run;

data test;
input pid jdate;
informat jdate ddmmyy10.;
format jdate yymmdd10.;
cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
;
run;
proc print data=test;
run;

options yearcutoff=2000;

data test;
input pid jdate;
informat jdate ddmmyy10.;
format jdate yymmdd10.;
cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
6 01/02/35
;
run;
proc print data=test;
run;

data test;
input pid jdate : date9.;
cards;
1  01Jan2025
2  02Feb2010
;
run;
proc print data=test;
format jdate date9.;
run;

data test;
input pid jdate : monyy7.;
format jdate monyy7.;
cards;
1 Jan2025
2 Feb2010
;
run;
proc print data=test;
run;

data test;
input pid jtime : time.;
cards;
1 12:02PM
2 02:45:30AM
;
run;
proc print data=test;
format jtime timeampm10.;
run;

data test;
input pid jdatetime : datetime18.;
cards;
1 12feb2025:12:02:05
;
run;
proc print data=test;
format jdatetime datetime18.;
run;

data test;
input x;
format x 6.3;
cards;
10.25
13.46
15.555
;
run;
proc print;
run;
