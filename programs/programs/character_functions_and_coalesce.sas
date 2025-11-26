/*******************************************************
   Clinical SAS — Character Functions & COALESCE
   File   : 06_character_functions_and_coalesce.sas
*******************************************************/

/*======================================================
  1. CHANGE CASE: UPCASE / LOWCASE / PROPCASE
=======================================================*/

data case_up;
  set sashelp.class;
  name_upper = upcase(name);
run;

data case_low;
  set sashelp.class;
  name_lower = lowcase(name);
run;

data case_prop1;
  set sashelp.class;
  x = "my name is naidu";
  x_proper = propcase(x);    /* Capitalize words using default delimiters */
run;

data case_prop2;
  x = "my name is naidu";
  x_proper = propcase(x, "/");  /* Example with custom delimiter list */
run;

/*******************************************************
  2. SPACE HANDLING: COMPBL & COMPRESS
*******************************************************/

data compbl_example;
  x  = "my        name       is       naidu";
  x1 = compbl(x);                     /* collapse multiple blanks to a single space */
run;
proc print data=compbl_example; run;

data compbl_upcase_example;
  x  = "my        name       is       naidu";
  x1 = upcase(compbl(x));             /* collapse blanks + convert to upper case */
run;
proc print data=compbl_upcase_example; run;

data compress_all_spaces;
  x  = "my        name       is       naidu";
  x1 = compress(x);                   /* remove all spaces */
run;
proc print data=compress_all_spaces; run;

data compress_remove_a;
  x  = "my        name       is       naidu";
  x1 = compress(x, "a");              /* remove all 'a' characters */
run;
proc print data=compress_remove_a; run;

data compress_remove_a_and_space;
  x  = "my        name       is       naidu";
  x1 = compress(x, "a ");             /* remove 'a' and space */
run;
proc print data=compress_remove_a_and_space; run;

data compress_keep_digits;
  x  = "my        name       is       naidu +91 9642359790";
  /* 'KD' => keep digits (K) and delete listed chars (D) */
  x1 = compress(x, " ", 'KD');
run;
proc print data=compress_keep_digits; run;

data compress_delete_spaces_only;
  x  = "my        name       is       naidu +91 9642359790";
  /* 'D' => delete listed characters */
  x1 = compress(x, " ", 'D');
run;
proc print data=compress_delete_spaces_only; run;

/*******************************************************
  3. FIND / INDEX / INDEXW
*******************************************************/

data find_disease;
  set sashelp.heart;
  x = find(DeathCause, "Disease");
  keep x DeathCause;
  if x > 1;
run;

data where_in_example;
  set sashelp.heart;
  where DeathCause in ("Coronary Heart Disease"
                       "Cerebral Vascular Disease");
run;

data male female;
  set sashelp.heart;
  if find(sex, "F") = 1 then output female;
  if find(sex, "M") = 1 then output male;
run;

data male2 female2;
  set sashelp.heart;
  if index(sex, "F") = 1 then output female2;
  if index(sex, "M") = 1 then output male2;
run;

/* Simple find with starting positions */
data find_simple1;
  x  = "my name is naidu. i am sas trainer";
  x1 = find(x, "a");           /* first 'a' */
run;
proc print data=find_simple1; run;

data find_simple2;
  x  = "my name is naidu. i am sas trainer";
  x1 = find(x, "a", 6);        /* from position 6 */
run;
proc print data=find_simple2; run;

data find_simple3;
  x  = "my name is naidu. i am sas trainer";
  x1 = find(x, "a", 14);       /* from position 14 */
run;
proc print data=find_simple3; run;

/* INDEXW finds whole words only */
data indexw_example;
  x  = "my name is naidu. i am sas trainer";
  x1 = indexw(x, "am");
run;
proc print data=indexw_example; run;

/*******************************************************
  4. SUBSTR EXAMPLES
*******************************************************/

data substr_simple;
  x = "my name is naidu";
  name = substr(x, 11);         /* from position 11 to end */
run;
proc print data=substr_simple; run;

/* Split a datetime-like string into date and time portions */
data substr_datetime;
  datetime = "12oct2025:12:20:45 PM";
  date = substr(datetime, 1, 9);
  time = substr(datetime, 11);
run;
proc print data=substr_datetime; run;

/* Use SUBSTR on formatted dates */
data substr_air;
  set sashelp.air;
  x    = put(date, date5.);
  day  = substr(x, 1, 2);
  month= substr(x, 3);
run;

/* Extract country code suffix / prefix using LENGTH */
data substr_suffix_prefix;
  input x $10.;
  kk = length(x);
  x1 = substr(x, kk-1);              /* last 2 chars */
  x2 = substr(x, 1, length(x)-2);    /* all but last 2 */
  datalines;
japanJN
IndiaIN
AmericaUS
;
run;
proc print data=substr_suffix_prefix; run;

/*******************************************************
  5. SCAN EXAMPLES
*******************************************************/

data scan_second;
  x  = "My name is naidu";
  x1 = scan(x, 2);        /* 2nd word */
run;
proc print data=scan_second; run;

data scan_third;
  x  = "My name is naidu";
  x1 = scan(x, 3);        /* 3rd word */
run;
proc print data=scan_third; run;

data scan_negative;
  x  = "My name is naidu";
  x1 = scan(x, -3);       /* from the right side */
run;
proc print data=scan_negative; run;

/*******************************************************
  6. JOINING STRINGS: CAT / CATS / CATT / CATX / || 
*******************************************************/

data join_raw;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = "    I am in india    ";
  x4 = "I am from great online Training";
run;
proc print data=join_raw; run;

/* CAT: concatenates without trimming */
data join_cat;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "   I am from great online Training   ";
  x5 = cat(x1, x2, x3, x4);
run;
proc print data=join_cat; run;

/* CATS: trims trailing blanks of all arguments */
data join_cats;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "   I am from great online Training   ";
  x5 = cats(x1, x2, x3, x4);
run;
proc print data=join_cats; run;

/* CATT: removes trailing blanks only */
data join_catt;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = "I am in india    ";
  x4 = "I am from great online Training   ";
  x5 = catt(x1, x2, x3, x4);
run;
proc print data=join_catt; run;

/* CATX: join with a delimiter and trimming */
data join_catx_space;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "   I am from great online Training   ";
  x5 = catx(" ", x1, x2, x3, x4);
run;
proc print data=join_catx_space; run;

data join_catx_dotspace;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "   I am from great online Training   ";
  x5 = catx(". ", x1, x2, x3, x4);
run;
proc print data=join_catx_dotspace; run;

data join_catx_colon;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "   I am from great online Training   ";
  x5 = catx(":", x1, x2, x3, x4);
run;
proc print data=join_catx_colon; run;

data join_catx_dash;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "   I am from great online Training   ";
  x5 = catx("-", x1, x2, x3, x4);
run;
proc print data=join_catx_dash; run;

/* Direct concatenation with || */
data join_double_pipe;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "I am from great online Training";
  x5 = x1 || x2 || x3 || x4;
run;
proc print data=join_double_pipe; run;

/* Using STRIP to remove leading & trailing blanks before concatenation */
data join_strip;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "I am from great online Training";
  x5 = strip(x1) || strip(x2) || strip(x3) || strip(x4);
run;
proc print data=join_strip; run;

/* With custom separators and TRIM */
data join_strip_with_punctuation;
  x1 = "My name is naidu";
  x2 = "    i am SAS programmer";
  x3 = " I am in india    ";
  x4 = "I am from great online Training";
  x5 = strip(x1) || " "
       || strip(x2) || " "
       || trim(x3)  || "?"
       || strip(x4);
run;
proc print data=join_strip_with_punctuation; run;

/*******************************************************
  7. LENGTH, LENGTHM, COUNTW, REVERSE
*******************************************************/

data length_basic;
  x  = "my name is naidu";
  x1 = length(x);     /* length without trailing blanks */
run;
proc print data=length_basic; run;

data length_with_trailing_blanks;
  x  = "my name is naidu                           ";
  x1 = length(x);
run;
proc print data=length_with_trailing_blanks; run;

data lengthm_example;
  x  = "my name is naidu                           ";
  x1 = lengthm(x);   /* includes trailing blanks */
run;
proc print data=lengthm_example; run;

data length_leading_space;
  x  = "  my name is naidu";
  x1 = length(x);
run;
proc print data=length_leading_space; run;

data countw_example;
  x  = "my name is naidu";
  x1 = countw(x);     /* number of words */
run;
proc print data=countw_example; run;

data reverse_example;
  x  = "my name is naidu";
  x1 = reverse(x);    /* reverse string */
run;
proc print data=reverse_example; run;

/*******************************************************
  8. COALESCE: FIRST NON-MISSING VALUE
*******************************************************/

data test_coalesce;
  input Pid V1 V2 V3;
  datalines;
1 10 .  60
2 . 50  85
3 40 20 .
;
run;

data ll;
  set test_coalesce;
  firstdose = coalesce(V1, V2, V3);  /* first non-missing value from V1–V3 */
run;
proc print data=ll; run;

/* End of file */
