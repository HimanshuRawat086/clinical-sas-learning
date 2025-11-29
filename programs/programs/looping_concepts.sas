/***************************************************
   SAS PROGRAM: LOOPING CONCEPTS
   Includes:
   - DO WHILE loops
   - DO loops (simple, conditional, nested)
   - DO UNTIL loops
***************************************************/


/******************** DO WHILE ********************/

/* Condition checked before loop begins */
data test;
x = 1;
do while (x < 10);
    x = x + 1;
    output;
end;
run;
proc print; run;

/* Output first, then increment */
data test;
x = 1;
do while (x < 10);
    output;
    x = x + 1;
end;
run;
proc print; run;

/* Increment by 2 */
data test;
x = 1;
do while (x < 10);
    output;
    x = x + 2;
end;
run;
proc print; run;

/* Decrement loop */
data test;
x = 100;
do while (x > 50);
    x = x - 2;
    output;
end;
run;
proc print; run;


/*********************** DO ************************/

/* IF without DO block (incorrect grouping) */
data test;
set sashelp.class;
if age = 14 then city = "HYD";
school = "DP";    /* Always assigned */
grade  = "A";     /* Always assigned */
run;
proc print; run;

/* Proper IF–DO block */
data test;
set sashelp.class;
if age = 14 then do;
    city = "HYD";
    school = "DP";
    grade = "A";
end;
run;
proc print; run;


/*********************** IF–ELSE *******************/

data test;
set sashelp.class;
length school $20;

if age = 14 then do;
    city = "HYD";
    school = "DP";
    grade = "A";
end;
else if age = 15 then do;
    city = "NYK";
    school = "ABC";
    grade = "B";
end;
else do;
    city = "ZZZZ";
    school = "XYZ";
    grade = "C";
end;
run;
proc print; run;


/******************** SIMPLE DO LOOP ****************/

data test;
do i = 1 to 10;
    output;
end;
run;
proc print; run;

data test;
do i = 1 to 10 by 2;    /* Step = 2 */
    output;
end;
run;
proc print; run;

data test;
do i = 100 to 10 by -2; /* Backward count */
    output;
end;
run;
proc print; run;


/******************** NESTED DO LOOP ****************/

data test;
do i = 1 to 10;         /* Outer loop */
    do pid = 1 to 3;    /* Inner loop */
        output;
    end;
end;
run;
proc print; run;


/******************** DO UNTIL **********************/

data test;
x = 50;
do until (x > 100);   /* Always runs once */
    output;
    x = x + 2;
end;
run;
proc print; run;


/*************** END OF PROGRAM *********************/
