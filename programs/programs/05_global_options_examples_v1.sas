/*****************************************************/
/*         SAS Global OPTIONS  EXAMPLES               */
/*         Author: Himanshu Rawat                     */
/*****************************************************/

/* Titles and Footnotes */
proc print data=sashelp.class; title "this is my sas dataset"; run;
proc print data=sashelp.heart; title "this is your data"; run;
proc print data=sashelp.heart; title; run; /* clear title */

proc print data=sashelp.class;
  title1 "Subject Demographics and Baseline Characteristics";
  title2 "Safety Population";
run;

/* Footnotes */
proc print data=sashelp.class;
  footnote1 "Reference: Listing 16.2.4.1";
  footnote2 "a  Percentages are based on the number of subjects in the population.";
run;
proc print; title; footnote; run; /* clear both */

/* SYSTEM OPTIONS examples */
proc print data=sashelp.class; run;
options nodate; proc print data=sashelp.class; run;
options nonumber; proc print data=sashelp.class; run;
options nocenter; proc print data=sashelp.class; run;

options obs=5; proc print data=sashelp.class; run;
options firstobs=5 obs=10; proc print data=sashelp.class; run;
options obs=max; proc print data=sashelp.heart; run;

/* Variable names & formatting */
options firstobs=1 caps;
data tmp1; input x $ y; cards; abc 20 ; run; proc print data=tmp1; run;

options nocaps; options validvarname=upcase;
data tmp2; input x $ y; cards; abc 20 ; run; proc print data=tmp2; run;

options number date; proc print data=sashelp.class; run;
/* Line size */
options ls=200; proc print data=sashelp.heart; run;

/* LOG CONTROL */
proc print data=sashelp.class;
  options nosource nonotes;
run;
proc print data=sashelp.class; options notes source; run;

/* LIBRARY / EXPLORER SETTINGS */
data tmp3; input x $ y; cards; abc 20 ; run; proc print data=tmp3; run;
options user=sasuser; data tmp4; input x $ y; cards; abc 20 ; run; proc print data=tmp4; run;
options user=work; data tmp5; input x $ y; cards; abc 20 ; run; proc print data=tmp5; run;
