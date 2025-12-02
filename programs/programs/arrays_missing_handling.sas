/*************************************************************
 Project : Arrays & Missing-Value Handling in SAS
 Topic   : Arrays, loops, _numeric_, _character_, mean(of ...)
 Author  : Himanshu Rawat
*************************************************************/

/* -------------------------
  Create sample subj_bp data
  ------------------------- */
data subj_bp;
  input subjid $ sbp1-sbp6;
cards;
P101 230 340 210 220 210 240
P102 310 .   200 .   230 250
.    .   210 210 220 .   210
P104 220 250 .   210 200 .
;
run;

proc print data=subj_bp noobs; title "Original subj_bp"; run;

/* -------------------------------------------------------
  Step 2: Replace missing values with 0 using IF statements
  ------------------------------------------------------- */
data step2_if_replace;
  set subj_bp;
  if sbp1 = . then sbp1 = 0;
  if sbp2 = . then sbp2 = 0;
  if sbp3 = . then sbp3 = 0;
  if sbp4 = . then sbp4 = 0;
  if sbp5 = . then sbp5 = 0;
  if sbp6 = . then sbp6 = 0;
run;
proc print data=step2_if_replace noobs; title "Step2: IF-based replace missing -> 0"; run;

/* --------------------------------------------------------
  Step 3: Replace missing values using ARRAY + DO loop
  (demonstrates vectorized approach)
  -------------------------------------------------------- */
data step3_array_replace;
  set subj_bp;
  array sbps {*} sbp1-sbp6;
  do i = 1 to dim(sbps);
    if sbps[i] = . then sbps[i] = 0;
  end;
  drop i;
run;
proc print data=step3_array_replace noobs; title "Step3: Array replace missing -> 0"; run;

/* --------------------------------------------------------
  Step 4: Replace first 3 missing with 0, last 3 missing with 10
  -------------------------------------------------------- */
data step4_array_ranges;
  set subj_bp;
  array sbps{6} sbp1-sbp6;

  /* sbp1 - sbp3: missing -> 0 */
  do i = 1 to 3;
    if sbps{i} = . then sbps{i} = 0;
  end;

  /* sbp4 - sbp6: missing -> 10 */
  do i = 4 to 6;
    if sbps{i} = . then sbps{i} = 10;
  end;

  drop i;
run;
proc print data=step4_array_ranges noobs; title "Step4: Array ranges replacement"; run;

/* --------------------------------------------------------
  Step 5: Replace missing with 10, multiply non-missing by 2,
          then apply MOD(value,3) to each element
  -------------------------------------------------------- */
data step5_transform_mod;
  set subj_bp;
  array sbps {*} sbp1-sbp6;

  do i = 1 to dim(sbps);
    if sbps{i} = . then sbps{i} = 10;        /* replace missing */
    /* multiply original non-missing values by 2; for replaced values we already set 10 */
    sbps{i} = sbps{i} * 2;
    /* apply modulus 3 */
    sbps{i} = mod(sbps{i}, 3);
  end;

  drop i;
run;
proc print data=step5_transform_mod noobs; title "Step5: Replace->10, *2, mod 3"; run;

/* --------------------------------------------------------
  Step 6: Convert all character variables to uppercase
           (using _character_)
  -------------------------------------------------------- */
data step6_upcase_chars;
  set sashelp.heart; /* using sashelp.heart as demo source that has character vars */
  array cabc {*} _character_;
  do i = 1 to dim(cabc);
    /* Only update non-missing strings */
    if cabc{i} ne "" then cabc{i} = upcase(cabc{i});
  end;
  drop i;
run;
proc print data=step6_upcase_chars(obs=10) noobs; title "Step6: Uppercase all char vars (sashelp.heart sample)"; run;

/* --------------------------------------------------------
  Step 7: Uppercase characters and replace missing numerics with 0
  -------------------------------------------------------- */
data step7_upcase_and_fillnum;
  set sashelp.heart;
  /* Uppercase all character variables */
  array cabc {*} _character_;
  do i = 1 to dim(cabc);
    if cabc{i} ne "" then cabc{i} = upcase(cabc{i]);
  end;

  /* Replace missing numeric variables with 0 */
  array nabc {*} _numeric_;
  do j = 1 to dim(nabc);
    if nabc{j} = . then nabc{j} = 0;
  end;

  drop i j;
run;
proc print data=step7_upcase_and_fillnum(obs=10) noobs; title "Step7: Uppercase chars + fill numeric missings with 0"; run;

/* --------------------------------------------------------
  Step 8: Calculate row mean of sbp1-sbp6 and impute missing with mean
  -------------------------------------------------------- */
data step8_impute_with_mean;
  set subj_bp;
  /* compute mean ignoring missing by default */
  row_mean = mean(of sbp1-sbp6);

  array sbps {*} sbp1-sbp6;
  do i = 1 to dim(sbps);
    if sbps{i} = . then sbps{i} = row_mean;
  end;

  drop i;
run;
proc print data=step8_impute_with_mean noobs; title "Step8: Impute missing with row-wise mean"; run;

/* --------------------------------------------------------
  Step 9: Replace missing using mean(of ...) inline (equivalent)
  Also mark missing subjid as "Missing" (illustrative)
  -------------------------------------------------------- */
data step9_inline_mean;
  set subj_bp;
  array sbps {*} sbp1-sbp6;
  do i = 1 to dim(sbps);
    if sbps{i} = . then sbps{i} = mean(of sbp1-sbp6);
  end;

  /* handle missing subjid */
  if subjid = "" or subjid = "." then subjid = "Missing"; /* note: '.' is numeric missing; using string check for safety */

  drop i;
run;
proc print data=step9_inline_mean noobs; title "Step9: Inline mean replace + handle subjid"; run;

/* --------------------------------------------------------
  Step 10: Example showing character-array replacement
  NOTE: Make sure the dataset has those character vars before running
  -------------------------------------------------------- */
data step10_char_array_demo;
  set subj_bp;
  /* This array is illustrative — subj_bp has only one character var (subjid);
     if you want to replace multiple char vars, create them first or use _character_. */
  length ll $20 nn $20 kk $20 dd $20 hh $20 zz $20;
  array chars {*} ll nn kk dd hh zz;
  do i = 1 to dim(chars);
    if chars{i} = "" then chars{i} = "missing";
  end;
  drop i;
run;
proc print data=step10_char_array_demo noobs; title "Step10: Character-array demo (illustrative)"; run;

/* -----------------------
  End of arrays & missing handling examples
  ----------------------- */
