/* ================================================================
   Clinical SAS — Input Methods Demo
   Author: Himanshu Rawat
   Topics: List, Named, Column, Formatted input + pointers & modifiers
   ================================================================= */

/* ------------------------------------------------
   LIST INPUT
   - Space-delimited values in order
   - Use $ after character variables
   ------------------------------------------------ */
title "List Input";
data list_input;
  retain empid ename dept;
  length ename $12 dept $12;
  input empid ename $ dept $;
  datalines;
1 Rick  IT
2 Lata  OPS
3 Tusar IT
4 Pranab OPS
. Raju  Electrical
;
run;
proc print data=list_input; run;

/* ------------------------------------------------
   NAMED INPUT
   - name=value pairs; order does NOT matter
   ------------------------------------------------ */
title "Named Input";
data named_input;
  length ename $12 dept $12;
  input empid= ename=$ dept=$;
  datalines;
EMPID=10 ENAME=Raju   DEPT=IT
EMPID=11 ENAME=M_Raju DEPT=Bank
EMPID=12 ENAME=Jack   DEPT=Finance
EMPID=.  ENAME=Moses  DEPT=Security
;
run;
proc print data=named_input; run;

/* ------------------------------------------------
   COLUMN INPUT (fixed positions)
   - Specify exact column ranges
   - Example: empid 1-3, ename $4-11, dept at column 13+
   ------------------------------------------------ */
title "Column Input (Fixed Positions)";
data column_input;
  length ename $8 dept $10;
  infile datalines truncover;
  input empid 1-3 ename $ 5-12 dept $ 14-23;
  datalines;
014 Rick     IT
241 Dan      OPS
030 Sanvi    IT
410 Chanchal OPS
052 Piyu     FIN
;
run;
proc print data=column_input; run;

/* ------------------------------------------------
   FORMATTED INPUT (fixed + informats, pointer @n)
   - Use @n to start reading at column n
   - Combine with informats for robust parsing
   ------------------------------------------------ */
title "Formatted Input with @n and Informats";
data formatted_input;
  length ename $9 dept $10;
  infile datalines truncover;
  input @1 empid 3.
        @5 ename $9.
        @15 dept $10.;
  datalines;
014 Rick      IT
241 Dan       OPS
030 Sanvi     IT
410 Chanchals OPS
052 Piyu      FIN
;
run;
proc print data=formatted_input; run;

/* ------------------------------------------------
   COLON MODIFIER (:) with informats
   - Reads until delimiter; applies informat (e.g., comma5.)
   - +n skips n columns from the current pointer
   ------------------------------------------------ */
title "Colon Modifier with comma. informat";
data scores_colon;
  infile datalines truncover;
  input name $12. +4 score1 : comma5. +5 score2 : comma5.;
  format score1 score2 comma5.;
  datalines;
Riley       1,132      1,187
Henderson   1,015      1,102
;
run;
proc print data=scores_colon; run;

/* ------------------------------------------------
   CREATE OBS WITHOUT INPUT (using OUTPUT)
   ------------------------------------------------ */
title "Create rows without INPUT";
data no_input;
  length c $20;
  a = 20;  b = 30;  c = "Hi there"; output;
  a = 200; b = 300; c = "Hi here";  output;
run;
proc print data=no_input; run;

/* ------------------------------------------------
   TRAILING POINTERS: @@ and @
   - @@ keeps the same input line to read multiple values
   - @  holds line for additional INPUT statements
   ------------------------------------------------ */

/* Double trailing @@ : read many values from one line */
title "@@ Double Trailing";
data labs;
  input x @@;
  datalines;
100 4 0.5 
101 5 1.0 102 6 0.25 
109 7 1.0
108 9 0.5
111 3 0.7 113 6 1.0 123 7 0.5 126 7 1.0
105 3 0.5
;
run;
proc print data=labs; run;

/* Single trailing @ : hold the line and read multiple vars in steps */
title "@ Single Trailing";
data bank;
  length id $12;
  input id @;       /* hold the line */
  input score @; output;
  input score @; output;
  input score @; output;
  datalines;
111000234 79 82 100
;
run;
proc print data=bank; run;

/* ------------------------------------------------
   MODIFIERS FOR EMBEDDED BLANKS (&) AND PRACTICE
   - $w. reads fixed width
   - $& reads character values with embedded blanks until two+ spaces
   ------------------------------------------------ */
title "Embedded blanks with $& (practice)";
data naidu;
  length name $25 place $20;
  input name $& 25. place $;
  datalines;
Naidu SAS Online Trainer Hyd
Shiva Mumbai
;
run;
proc print data=naidu; run;

/* ------------------------------------------------
   COMMON PITFALL EXAMPLE (overlapping columns)
   - Avoid assigning overlapping column ranges to different variables
   - Below shows a corrected version using non-overlapping spans
   ------------------------------------------------ */
title "Avoid overlapping columns (corrected)";
data employee1;
  length ssn $9 w2amt $12;
  infile datalines truncover;
  /* Example layout: SSN in cols 1-9, W2 amount in cols 11-22 */
  input ssn $ 1-9 @11 w2amt $ 11-22;
  datalines;
234567890  0000000356
345671234  0000012345
;
run;
proc print data=employee1; run;

/* ------------------------------------------------
   POINTER EXAMPLES: @n and +n with embedded blanks
   ------------------------------------------------ */
title "Pointer & width practice";
data scores_ptr1;
  infile datalines truncover;
  input @1 name $12. @15 score1 $5. @22 score2 $6.;
  datalines;
values can contain embedded blanks
;
run;
proc print data=scores_ptr1; run;

data scores_ptr2;
  infile datalines truncover;
  input name $12. +3 score1 $5. +4 score2 $6.;
  datalines;
values can contain embedded blanks
;
run;
proc print data=scores_ptr2; run;

data scores_ptr3;
  infile datalines truncover;
  input name $12. score1 $5. score2 $8.;
  datalines;
values can contain embedded blanks
;
run;
proc print data=scores_ptr3; run;

title; footnote;
