/******************************************************
   Example : SAS PROC FORMAT — Character & Numeric Formats
   Author: Himanshu Rawat
******************************************************/
/* C → N : Character to Numeric mapping example */
data fmt_cn;
  input pid age sex $ dose $;
  cards;
1 25 M 5MG
2 45 F 10MG
3 78 M 15MG
4 46 F 6MG
;
run;
proc print data=fmt_cn; title "Original C→N example"; run;

proc format;
  value $gender
    "M" = 1
    "F" = 2;
run;
proc print data=fmt_cn; format sex $gender.; title "Applied $gender. format"; run;

/* N → C : Numeric to Character */
data fmt_nc;
  input pid age sex dose $;
  cards;
1 25 1 5MG
2 45 2 10MG
3 78 1 15MG
4 46 2 6MG
;
run;
proc format;
  value gnn
    1 = "M"
    2 = "F";
run;
proc print data=fmt_nc; format sex gnn.; title "Numeric → Character using gnn."; run;

/* N → N : Numeric to Numeric mapping */
data fmt_nn;
  input pid age sex dose $;
  cards;
1 25 1 5MG
2 45 2 10MG
3 78 1 15MG
4 46 2 6MG
;
run;
proc format;
  value nx
    1 = 10
    2 = 20
    3 = 30
    4 = 40;
run;
proc print data=fmt_nn; format pid nx.; title "Numeric→Numeric mapping"; run;

/* C → C : Character to Character */
data fmt_cc;
  input pid age sex $ dose $;
  cards;
1 25 M 5MG
2 45 F 10MG
3 78 M 15MG
4 46 F 6MG
;
run;
proc format;
  value $ll
    "F" = "Female"
    "M" = "Male";
run;
proc print data=fmt_cc; format sex $ll.; title "Character→Character mapping"; run;

/* Create permanent formats in sasuser and set fmtsearch */
proc format library=sasuser;
  value $ll
    "F" = "Female"
    "M" = "Male";
run;
options fmtsearch=(sasuser);
proc print data=fmt_cc; format sex $ll.; title "Using permanent formats (sasuser)"; run;

/* View formats in a library */
proc format fmtlib library=work; run;

/* Export formats to dataset (CNTLOUT) and recreate (CNTLIN) */
proc format fmtlib library=work cntlout=kk; run;
proc format fmtlib library=work cntlin=kk; run;
