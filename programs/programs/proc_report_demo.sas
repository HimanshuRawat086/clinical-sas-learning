/************************************************************
 Project : PROC REPORT Demo
 Author  : Himanshu Rawat
 Topic   : Reporting on sashelp.class and TRIALS data
************************************************************/

/*===========================================================
  SECTION 1: Basic PROC REPORT on sashelp.class
===========================================================*/

title "PROC REPORT on sashelp.class – default";
proc report data=sashelp.class;
run;

/* NOWD: non-interactive mode */
title "PROC REPORT with NOWD";
proc report data=sashelp.class nowd;
run;

/* Select specific columns */
title "Selected columns: Name Age Sex";
proc report data=sashelp.class nowd;
  column Name age sex;
run;

/* HEADLINE: line under column headers */
title "HEADLINE option demo";
proc report data=sashelp.class nowd headline;
  column Name age sex;
run;

/* HEADLINE + HEADSKIP: line + blank line after header */
title "HEADLINE + HEADSKIP";
proc report data=sashelp.class nowd headline headskip;
  column Name age sex;
run;

/* Grouping columns under a custom label "--" */
title "Grouped under custom label '--'";
proc report data=sashelp.class nowd headline headskip;
  column ("--" Name age sex);
run;

/* COMPUTE AFTER: custom lines after report */
title "COMPUTE AFTER – custom lines";
proc report data=sashelp.class nowd headline headskip;
  column ("--" Name age sex);
  compute after;
    line "--------------------";
    line "--------------------";
  endcomp;
run;

/* COMPUTE AFTER with text */
title "COMPUTE AFTER – thank you message";
proc report data=sashelp.class nowd headline headskip;
  column ("--" Name age sex);
  compute after;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/*===========================================================
  SECTION 2: ORDER, GROUP, HEADERS, SPLIT, BREAK
===========================================================*/

title "ORDER on Sex and Age";
proc report data=sashelp.class nowd headline headskip;
  column ("--" Name age sex);
  define sex / order;
  define age / order;
  compute after;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

title "GROUP on Age, ORDER on Sex";
proc report data=sashelp.class nowd headline headskip;
  column ("--" Name age sex);
  define sex / order;
  define age / group;
  compute after;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/* Sort by descending Sex and use ORDER=DATA */
proc sort data=sashelp.class out=ll;
  by descending sex;
run;

title "ORDER=DATA to keep sorted order";
proc report data=ll nowd headline headskip;
  column ("--" Name age sex);
  define sex / order order=data;
  compute after;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/* Custom labels and widths */
title "Custom labels and widths";
proc report data=ll nowd headline headskip;
  column ("--" Name age sex);
  define sex  / order order=data "Gender" width=10;
  define name / "Student name" width=20;
  compute after;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/* SPLIT option to control header breaks */
title "SPLIT=@ in header";
proc report data=ll nowd headline headskip split="@";
  column ("--" Name age sex);
  define sex  / order order=data "Gender" width=10;
  define name / "Student@name" width=20;
  compute after;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/* BREAK AFTER Sex */
title "BREAK AFTER Sex / SKIP";
proc report data=ll nowd headline headskip split="@";
  column ("--" Name age sex);
  define sex  / order order=data "Gender" width=10;
  define name / "Student@name" width=20;
  break after sex / skip;
  compute after;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/* COMPUTE AFTER Sex group */
title "COMPUTE AFTER Sex group";
proc report data=ll nowd headline headskip split="@";
  column ("--" Name age sex);
  define sex  / order order=data "Gender" width=10;
  define name / "Student@name" width=20;
  break after sex / skip;
  compute after sex;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/*===========================================================
  SECTION 3: Adding Vital Signs (height & weight)
===========================================================*/

title "Adding grouped header for Vital (Height & Weight)";
proc report data=ll nowd headline headskip split="@";
  column ("--" Name age sex ("- Vital - " height weight));
  define sex  / order order=data "Gender" width=10;
  define name / "Student@name" width=20;
  break after sex / skip;
  compute after sex;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/* Filter rows where age > 12 */
title "Filter: Age > 12";
proc report data=ll nowd headline headskip split="@";
  where age > 12;
  column ("--" Name age sex ("- Vital - " height weight));
  define sex  / order order=data "Gender" width=10;
  define name / "Student@name" width=20;
  break after sex / skip;
  compute after sex;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/*===========================================================
  SECTION 4: BY-group Reporting
===========================================================*/

/* Sort by Sex for BY-group reports */
proc sort data=ll;
  by sex;
run;

options nobyline;  /* Suppress BY-line in output */

title "BY Sex, separate report per group (Age > 12)";
proc report data=ll nowd headline headskip split="@";
  where age > 12;
  by sex;
  column ("--" Name age sex ("- Vital - " height weight));
  define sex  / order order=data "Gender" width=10;
  define name / "Student@name" width=20;
  break after sex / skip;
  compute after sex;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/*===========================================================
  SECTION 5: Adding Long Text Column & FLOW
===========================================================*/

data test;
  set sashelp.class;
  x = "My name is Naidu. I am SAS Trainer";
run;

proc sort data=test;
  by sex;
run;

options nobyline;

title "Report including long text column X";
proc report data=test nowd headline headskip split="@";
  where age > 12;
  by sex;
  column ("--" Name age sex ("- Vital - " height weight) x);
  define sex  / order order=data "Gender" width=30;
  define name / "Student@name" width=20 id;
  define x    / width=50;
  break after sex / skip;
  compute after sex;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/* FLOW option to wrap text in X */
title "FLOW option on X (text wrapping)";
proc report data=test nowd headline headskip split="@";
  where age > 12;
  by sex;
  column ("--" Name age sex ("- Vital - " height weight) x);
  define sex  / order order=data "Gender" width=30;
  define name / "Student@name" width=20 id;
  define x    / width=30 flow;
  break after sex / skip;
  compute after sex;
    line 27*"-";
    line "thank you";
    line 27*"-";
  endcomp;
run;

/*===========================================================
  SECTION 6: TRIALS Dataset – GROUP, ACROSS, SUMMARY
===========================================================*/

data trials;
  input pid trial $ sb1 asb sb2 asb2;
cards;
100 p1 123 34 256 67
100 p2 282 67 289 28
200 p1 367 87 284 89
200 p2 678 56 467 36
;
run;

title "TRIALS dataset";
proc print data=trials noobs; run;

/* Simple report grouped by pid */
title "PROC REPORT on TRIALS grouped by PID";
proc report data=trials;
  column pid trial sb1;
  define pid / group;
run;

/* ACROSS on sb1 (demo only – show values across columns) */
title "ACROSS on sb1";
proc report data=trials;
  column pid trial sb1;
  define sb1 / across;
run;

/* Mean of sb1 */
title "Mean of sb1";
proc report data=trials;
  column sb1;
  define sb1 / mean;
run;

/* BREAK and summarize after PID */
title "TRIALS – summary after each PID";
proc report data=trials headline;
  column pid trial sb1 sb2;
  define pid / group;
  break after pid / dul dol summarize;
run;

/************************************************************
 End of PROC REPORT Demo
*************************************************************/```
