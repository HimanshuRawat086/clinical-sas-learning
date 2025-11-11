/******************************************************
   Clinical SAS — PROC FORMAT Demo
   Author: Himanshu Rawat
   Topics: C→N, N→C, N→N, C→C, FMTSEARCH, CNTLOUT/CNTLIN
*******************************************************/

/* ========= C→N : Character → Numeric (map M/F to 1/2) ========= */
title "C→N: Character to Numeric using PROC FORMAT";
data test_cn;
  input pid age sex $ dose $;
  cards;
1 25 M 5MG
2 45 F 10MG
3 78 M 15MG
4 46 F 6MG
;
run;

proc format;
  value $gender
    "M" = 1
    "F" = 2;
run;

/* Apply: printing shows numeric codes via format on a CHAR var */
proc print data=test_cn;
  format sex $gender.;
  title2 "sex displayed as 1/2 via $gender. format";
run;
title; title2;

/* ========= N→C : Numeric → Character (map 1/2 to M/F) ========= */
title "N→C: Numeric to Character using PROC FORMAT";
data test_nc;
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

proc print data=test_nc;
  format sex gnn.;
  title2 "sex displayed as 'M'/'F' via gnn.";
run;
title; title2;

/* ========= N→N : Numeric → Numeric (map pid codes) ========= */
title "N→N: Numeric to Numeric mapping";
data test_nn;
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

proc print data=test_nn;
  format pid nx.;
  title2 "pid values displayed as mapped numeric via nx.";
run;
title; title2;

/* ========= C→C : Character → Character (expand M/F) ========= */
title "C→C: Character to Character mapping";
data test_cc;
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

proc print data=test_cc;
  format sex $ll.;
  title2 "sex displayed as 'Female'/'Male' via $ll.";
run;
title; title2;

/* ========= Permanent format library (SASUSER) =========
   Note: In some environments SASUSER may be read-only.
   Adjust to a writable lib if needed.                     */
title "Permanent format library + FMTSEARCH";
proc format library=sasuser;
  value $ll
    "F" = "Female"
    "M" = "Male";
run;

/* Tell SAS where to search for formats first */
options fmtsearch=(sasuser);

proc print data=test_cc;
  format sex $ll.;
  title2 "Using $ll. from SASUSER via FMTSEARCH";
run;
title; title2;

/* Add multiple libraries to search path */
options fmtsearch=(sasuser kk ll pp jj);

proc print data=test_cc;
  format sex $ll.;
  title2 "FMTSEARCH with multiple libraries";
run;
title; title2;

/* ========= View formats in a library ========= */
title "FMTLIB: list formats available in WORK";
proc format fmtlib library=work;
run;
title;

/* ========= Export / Import formats (CNTLOUT / CNTLIN) ========= */
title "Export (CNTLOUT) and Import (CNTLIN) format definitions";

/* Export all formats in WORK to dataset KK */
proc format fmtlib library=work cntlout=kk;
run;

/* Recreate formats in WORK from dataset KK */
proc format fmtlib library=work cntlin=kk;
run;

proc contents data=kk; run;

title; footnote;
