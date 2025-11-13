/*******************************************************************************************
*    SAS DATE, TIME, DATETIME, AND NUMERIC FORMATS — EXAMPLES WITH COMMENTS
*    Author: Himanshu Rawat
*    Purpose: Demonstrate reading, storing, and displaying date/time/numeric values
*******************************************************************************************/

/* BASIC DATE INPUT TEST — without informat (will not read correctly) */
data dt_basic;
  input pid jdate;
  cards;
1 10/12/2024
2 01/01/2010
3 01/16/2008
4 01/01/1960
5 01/02/1958
;
run;
proc print data=dt_basic; title "Basic date input (no informat)"; run;

/* Treat jdate as character to avoid numeric errors */
data dt_char;
  input pid jdate $;
  cards;
1 10/12/2024
2 01/01/2010
3 01/16/2008
4 01/01/1960
5 01/02/1958
;
run;
proc print data=dt_char; title "jdate as character"; run;

/* APPLYING DATE INFORMAT (ddmmyy10.) to read properly */
data dt_inform;
  input pid jdate;
  informat jdate ddmmyy10.;
  format jdate ddmmyy10.;
  cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
4 01/01/1960
5 01/02/1958
6 01/02/35
;
run;
proc print data=dt_inform; title "Informat ddmmyy10. & display ddmmyy10."; run;

/* SAME FORMAT BOTH READ & DISPLAY */
data dt_same;
  input pid jdate;
  informat jdate ddmmyy10.;
  format jdate ddmmyy10.;
  cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
4 01/01/1960
5 01/02/1958
6 01/02/35
;
run;
proc print data=dt_same; title "Same read & display format"; run;

/* CHANGE OUTPUT DISPLAY FORMAT (display mmddyy10.) */
data dt_display_change;
  input pid jdate;
  informat jdate ddmmyy10.;
  format jdate mmddyy10.;
  cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
4 01/01/1960
5 01/02/1958
6 01/02/35
;
run;
proc print data=dt_display_change; title "Display mmddyy10."; run;

/* DISPLAY IN YYMMDD FORMAT */
data dt_yymm;
  input pid jdate;
  informat jdate ddmmyy10.;
  format jdate yymmdd10.;
  cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
4 01/01/1960
5 01/02/1958
6 01/02/35
;
run;
proc print data=dt_yymm; title "Display yymmdd10."; run;

/* YEARCUTOFF DEMO (for two-digit years) */
options yearcutoff=2000;
data dt_yc;
  input pid jdate;
  informat jdate ddmmyy10.;
  format jdate yymmdd10.;
  cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
4 01/01/1960
5 01/02/1958
6 01/02/35
;
run;
proc print data=dt_yc; title "Yearcutoff=2000 demo"; run;

/* SHORTER FORMAT (ddmmyy8.) */
data dt_short;
  input pid jdate;
  informat jdate ddmmyy10.;
  format jdate ddmmyy8.;
  cards;
1 10/12/2024
2 01/01/2010
3 16/01/2008
4 01/01/1960
5 01/02/1958
6 01/02/35
;
run;
proc print data=dt_short; title "Display ddmmyy8."; run;

/* DATE9. examples (inline reading) */
data dt_date9;
  input pid jdate;
  informat jdate date9.;
  format jdate date9.;
  cards;
1 01Jan2025
2 02Feb2010
;
run;
proc print data=dt_date9; title "DATE9. examples"; run;

/* COLON modifier with date9. */
data dt_colon;
  input pid jdate : date9.;
  format jdate weekdate36.;
  cards;
1 01Jan2025
2 02Feb2010
;
run;
proc print data=dt_colon; title "Colon modifier with date9."; run;

/* MONTH-YEAR (monyy7.) */
data dt_mon;
  input pid jdate : monyy7.;
  format jdate monyy7.;
  cards;
1 Jan2025
2 Feb2010
;
run;
proc print data=dt_mon; title "monyy7. examples"; run;

/* TIME FORMATS — reading raw time using TIME. informat */
data tm1;
  input pid jtime : time.;
  format jtime timeampm10.;
  cards;
1 12:02PM
2 02:45:30AM
;
run;
proc print data=tm1; title "Time with TIME. informat"; run;

/* TIME8. (hh:mm:ss) */
data tm2;
  input pid jtime : time8.;
  format jtime time10.;
  cards;
1 12:02:05
2 02:45:30
;
run;
proc print data=tm2; title "TIME8. examples"; run;

/* DATETIME example */
data dtm1;
  input pid jdatetime : datetime18.;
  format jdatetime datetime18.;
  cards;
1 12feb2025:12:02:05
;
run;
proc print data=dtm1; title "Datetime example"; run;

/* NUMERIC FORMATS — decimals and BEST. */
data num_basic;
  input x ;
  cards;
10.25
13.46
15.555
;
run;
proc print data=num_basic; title "Numeric basic"; run;

data num_fmt1;
  input x ;
  format x 6.3;
  cards;
10.25
13.46
15.555
;
run;
proc print data=num_fmt1; title "Format 6.3 (width 6, 3 decimals)"; run;

data num_best;
  input x ;
  format x best.;
  cards;
10.25
13.46
15.555
;
run;
proc print data=num_best; title "BEST. format"; run;

/* SUMMARY: Informat = read; Format = display; YEARCUTOFF controls 2-digit year */
