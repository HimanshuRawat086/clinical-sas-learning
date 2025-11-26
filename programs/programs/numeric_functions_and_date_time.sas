/* ===========================================================
   03 – Numeric Functions and Date/Time Handling in SAS
   =========================================================== */

/* ---------------------------
   Basic numeric input and simple functions
   --------------------------- */
data test;
  /* Read a single numeric variable X from datalines */
  input x;
  cards;
10.2
20.4
4.889
-24.5
100
;
run;

proc print; /* print the dataset 'test' */
run;

/* Create derived numeric variables using common numeric functions */
data test1;
  set test;
  x1 = int(x);        /* integer part (truncates toward zero) */
  x2x = round(x);     /* default rounding */
  x2 = round(x, .1);  /* round to nearest 0.1 */
  x3 = ceil(x);       /* ceiling: smallest integer >= x */
  x4 = floor(x);      /* floor: largest integer <= x */
  x5 = dif(x);        /* difference from previous observation (first obs = .) */
  x6 = log(x);        /* natural logarithm (missing for nonpositive x) */
  x7 = log10(x);      /* base-10 logarithm (missing for nonpositive x) */
  x8 = lag(x);        /* value of X from previous observation */
  x9 = mod(x, 2);     /* remainder of x divided by 2 */
run;

proc print;
run;

/* ---------------------------
   Simple statistics across variables
   --------------------------- */
data test;
  /* example with multiple variables v1-v5 for one pid */
  input pid v1-v5;
  cards;
1 20 30 50 64 64
;
run;

proc print;
run;

data test1;
  set test;
  x  = sum(of v1-v5);        /* sum of v1 through v5 (treats missing as 0) */
  x1 = mean(of v1-v5);       /* arithmetic mean of v1-v5 (ignores missing) */
  x2 = std(of v1-v5);        /* standard deviation of v1-v5 */
  x3 = min(of v1-v5);        /* minimum of v1-v5 */
  x4 = max(of v1-v5);        /* maximum of v1-v5 */
  x5 = sum(v1, v2);          /* sum of v1 and v2 (explicit listing) */
run;

proc print;
run;

/* ---------------------------
   Character conversion: PUT and SUBSTR extraction
   --------------------------- */
data test;
  /* Read date as DATE9. informat into jdate and format for display */
  input jdate : date9.;
  format jdate date9.;
  cards;
12dec2028
14Nov2015
;
run;

proc print;
run;

data test1;
  set test;
  x1  = put(jdate, date9.);   /* convert numeric date to character in DATE9. form */
  day = substr(x1, 1, 2);     /* extract day portion as character */
run;

proc print;
run;

/* ---------------------------
   Concatenation and character + numeric mixing
   --------------------------- */
data test;
  input name $ age height;
  cards;
nikita 45 6.5
raju   56 5.4
;
run;

data test1;
  set test;
  /* Build a string: name || age (formatted) || "-" || height (formatted 1 decimal) */
  x1 = name || put(age, 2.) || "-" || put(height, 3.1);
run;

proc print;
run;

/* Alternative: using BEST. format for height */
data test1;
  set test;
  new = cat(name, age);
  x1  = name || put(age, 2.) || "-" || put(height, best.);
run;

proc print;
run;

/* ---------------------------
   Character to numeric and numeric to date conversions
   --------------------------- */
data test;
  input jdate $ 10.;
  cards;
14dec2024
;
run;

proc print;
  format jdate date9.; /* jdate is character here, format has no effect */
run;

data test1;
  set test;
  x = input(jdate, date9.);   /* convert character date to numeric SAS date */
  format x ddmmyy10.;         /* display in DD/MM/YYYY format */
run;

proc print;
run;

/* Example with mm/dd/yyyy input */
data test;
  input jdate $ 10.;
  cards;
12/16/2023
;
run;

proc print;
run;

data test1;
  set test;
  x = input(jdate, mmddyy10.); /* convert mm/dd/yyyy character to SAS date */
  format x ddmmyy10.;
run;

proc print;
run;

/* Converting character numbers to numeric */
data test;
  input x $;
  cards;
10
30
40
;
run;

proc print;
sum x; /* here SUM is just requesting a total line in PROC PRINT */
run;

data test1;
  set test;
  x1 = input(x, best.); /* convert character numeric to numeric using BEST. */
run;

proc print;
sum x1;
run;

/* ---------------------------
   Date arithmetic using simple subtraction and INTCK/INTNX
   --------------------------- */
data test;
  /* Read two dates using DATE9. informat and format */
  input date1 date2;
  informat date1 date2 date9.;
  format date1 date2 date9.;
  /* difference in days and approximations for months/years/weeks */
  days   = date1 - date2;
  months = int(days/30.45);   /* approximate month count (not exact calendar months) */
  years  = int(days/365.25);  /* approximate years (rough leap-year adjustment) */
  weeks  = int(days/7);
  cards;
12dec2024 14feb2022
;
run;

proc print;
run;

/* Better approach using INTCK for exact interval counts */
data test;
  input date1 date2;
  informat date1 date2 date9.;
  format date1 date2 date9.;
  days   = intck('day',  date2, date1);   /* number of day boundaries */
  months = intck('month',date2, date1);   /* number of month boundaries */
  years  = intck('year', date2, date1);   /* number of year boundaries */
  weeks  = intck('week', date2, date1);   /* number of week boundaries */
  cards;
12dec2024 14feb2022
;
run;

proc print;
run;

/* Basic date addition using numeric date + integer (days) */
data test;
  x  = '12feb2025'd; /* literal SAS date constant */
  x1 = x + 30;       /* add 30 days */
  format x date9. x1 date9.;
run;

proc print;
run;

/* Using INTNX to shift dates with alignment */
data test;
  x  = '12feb2025'd;
  x1 = intnx('day', x, 20, 's'); /* add 20 days, 's' = same day-of-period alignment */
  format x1 date9.;
run;

proc print;
run;

data test;
  x  = '12feb2025'd;
  x1 = intnx('month', x, 20, 'e'); /* add 20 months and align to end of month */
  format x1 date9.;
run;

proc print;
run;

/* Extract components from a date value */
data test;
  x  = '12feb2025'd;
  x1 = day(x);   /* day of month */
  x2 = month(x); /* month number */
  x3 = year(x);  /* year */
  x4 = week(x);  /* week number */
run;

proc print;
run;

/* Working with datetime values: extract date and time portions */
data test;
  x  = '12feb2025:12:30:20'dt; /* datetime literal */
  x1 = datepart(x);            /* numeric date extracted from datetime */
  x2 = timepart(x);            /* numeric time-of-day extracted from datetime */
  format x1 date9. x2 time8.;
run;

proc print;
run;
