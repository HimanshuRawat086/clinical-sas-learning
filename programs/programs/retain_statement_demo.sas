/************************************************************
 Project : RETAIN Statement Demo
 Author  : Himanshu Rawat
 Topic   : RETAIN, cumulative logic & BY-group processing
************************************************************/

/*===========================================================
  SECTION 1: Basic RETAIN Usage
===========================================================*/

data kk;
  retain name age height weight sex;
  set sashelp.class;
run;


/*===========================================================
  SECTION 2: Sample Data
===========================================================*/

data abcd;
  input x y;
cards;
1 25
1 28
1 27
2 23
2 35
2 34
3 25
3 29
;
run;

proc print data=abcd noobs; run;


/*===========================================================
  SECTION 3: Serial Number Generation
===========================================================*/

/* Using RETAIN */
data aaa;
  set abcd;
  retain z 0;
  z = z + 1;
run;
proc print data=aaa noobs; run;

/* Implicit retain using +1 */
data aaa;
  set abcd;
  z + 1;
run;
proc print data=aaa noobs; run;

/* Using automatic variable _N_ */
data aaa;
  set abcd;
  z = _n_;
run;
proc print data=aaa noobs; run;


/*===========================================================
  SECTION 4: Cumulative Score
===========================================================*/

data aaa;
  set abcd;
  retain z 0;
  z = z + y;
run;
proc print data=aaa noobs; run;


/*===========================================================
  SECTION 5: Group-wise Serial Number
===========================================================*/

proc sort data=abcd;
  by x;
run;

data aaa;
  set abcd;
  by x;
  retain z;
  if first.x then z = 1;
  else z = z + 1;
run;
proc print data=aaa noobs; run;


/*===========================================================
  SECTION 6: Group-wise Cumulative Score
===========================================================*/

data aaa1;
  set abcd;
  by x;
  retain z1;
  if first.x then z1 = y;
  else z1 = z1 + y;
run;
proc print data=aaa1 noobs; run;


/*===========================================================
  SECTION 7: Cumulative Salary by Gender
===========================================================*/

data abcd;
  input gender $ salary;
cards;
M 25
M 26
M 27
F 23
F 24
F 25
;
run;

proc sort data=abcd;
  by gender;
run;

data temp;
  set abcd;
  by gender;
  retain tot;
  if first.gender then tot = salary;
  else tot = tot + salary;
  if last.gender;
  drop salary;
run;

proc print data=temp noobs; run;


/*===========================================================
  SECTION 8: Multiple Group Variables
===========================================================*/

data temp;
  input ID ID1 Score;
cards;
1 1 25
1 1 26
1 2 27
1 2 29
2 1 28
2 1 29
2 2 31
;
run;

proc sort data=temp;
  by ID ID1;
run;

data temp2;
  set temp;
  by ID ID1;
  if first.ID or first.ID1 then N = 1;
  else N + 1;
run;

proc print data=temp2 noobs; run;


/*===========================================================
  SECTION 9: Clinical Example – LOCF
===========================================================*/

data lab;
  input usubjid $ lbtestcd $ avisitn aval;
cards;
101-1001 WBC 0 10
101-1001 WBC 1 20
101-1001 WBC 2 30
101-1001 WBC 3 .
101-1001 WBC 4 .
101-1001 RBC 0 100
101-1001 RBC 1 200
101-1001 RBC 2 300
101-1001 RBC 3 .
101-1001 RBC 4 400
;
run;

proc sort data=lab;
  by usubjid lbtestcd avisitn;
run;

data test;
  set lab;
  by usubjid lbtestcd avisitn;
  retain x;
  if aval ne . then x = aval;
  new_aval = x;
run;

proc print data=test noobs;
title "LOCF using RETAIN";
run;

/************************************************************
 End of RETAIN Statement Demo
************************************************************/
