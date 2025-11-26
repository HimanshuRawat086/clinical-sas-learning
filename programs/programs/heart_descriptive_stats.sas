/************************************************************
 Project  : Descriptive Statistics on SASHELP.HEART
 Topic    : PROC MEANS & PROC FREQ (Clinical Programming Style)
 Author   : Himanshu Rawat
*************************************************************/

/*-----------------------------------------------------------
  1. BASIC PROC MEANS – all numeric variables
-----------------------------------------------------------*/
proc means data = sashelp.heart n mean std min max;
run;

/*-----------------------------------------------------------
  2. Single variable (AgeAtStart)
-----------------------------------------------------------*/
proc means data = sashelp.heart median;
    var AgeAtStart;
run;

/*-----------------------------------------------------------
  3. Multiple statistics on AgeAtStart
-----------------------------------------------------------*/
proc means data = sashelp.heart
    n mean std min max stderr uclm lclm q1 q3 median;
    var AgeAtStart;
run;

/*-----------------------------------------------------------
  4. CLASS (No sorting needed)
-----------------------------------------------------------*/
proc means data = sashelp.heart n mean median;
    var AgeAtStart;
    class Status Sex;
run;

/*-----------------------------------------------------------
  5. Using BY (Sorting required)
-----------------------------------------------------------*/
proc sort data = sashelp.heart out = heart_sorted;
    by Status Sex;
run;

proc means data = heart_sorted;
    var AgeAtStart;
    by Status Sex;
run;

/*-----------------------------------------------------------
  6. Output dataset using AUTONAME
-----------------------------------------------------------*/
proc means data = heart_sorted noprint;
    var AgeAtStart;
    by Status Sex;
    output out = means_output
        n= mean= median= std= / autoname;
run;

/*-----------------------------------------------------------
  7. PROC FREQ – one-way & two-way tables
-----------------------------------------------------------*/
proc freq data = sashelp.heart;
    tables Status Sex Status*Sex;
run;

/* Save frequency output to dataset */
proc freq data = sashelp.heart noprint;
    tables Status*Sex / out = freq_status_sex;
run;
