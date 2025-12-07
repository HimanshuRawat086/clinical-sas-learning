/************************************************************
 Project : PROC TRANSPOSE Demo
 Author  : Himanshu Rawat
 Topic   : Narrow ↔ Wide reshaping with PROC TRANSPOSE
************************************************************/

/****************************************************
* NARROW FILE 1 AND RESULTING TRANSPOSED WIDE FILES *
****************************************************/

data narrow_file1;
  infile cards;
  length pet_owner $10 pet $4 population 4;
  input pet_owner $1-10 pet $ population;
cards;
Mr. Black dog 2
Mr. XXX   bird 1
Mrs. Green fish 5
Mr. White cat 3
;
run;

title "NARROW_FILE1 – original";
proc print data=narrow_file1 noobs; run;

/* 1. Simple transpose (no VAR, no ID) */
title "NARROW_FILE1 – simple PROC TRANSPOSE (default)";
proc transpose data=narrow_file1
               out=narrow_file1_transp_default;
run;

/* 2. Using PREFIX= */
title "NARROW_FILE1 – PROC TRANSPOSE with PREFIX=";
proc transpose data=narrow_file1
               out=narrow_file1_transp_prefix
               prefix=pet_count;
run;

/* 3. Using NAME= to capture source variable name */
title "NARROW_FILE1 – PREFIX + NAME";
proc transpose data=narrow_file1
               out=narrow_file1_transp_prefix_name
               name=x
               prefix=pet_count;
run;

/* 4. Using ID to turn PET values into column names */
title "NARROW_FILE1 – ID PET, one row per observation";
proc transpose data=narrow_file1
               out=narrow_file1_transp_id
               name=x;
  id pet;
run;

/* 5. Using VAR to transpose only selected variables */
title "NARROW_FILE1 – VAR PET POPULATION";
proc transpose data=narrow_file1
               out=narrow_file1_transp_var;
  var pet population;
run;

/* 6. VAR + ID together */
title "NARROW_FILE1 – VAR + ID";
proc transpose data=narrow_file1
               out=narrow_file1_transp_id_var
               name=x;
  var pet population;
  id pet;
run;

/***********************************************************
* NARROW FILE 2 (MANY ROWS PER OWNER) → WIDE TRANSPOSED    *
************************************************************/

data narrow_file2;
  infile cards;
  length pet_owner $10 pet $4 population 4;
  input pet_owner $1-10 pet $ population;
cards;
Mr. Black dog 2
Mr. Black cat 1
Mrs. Brown dog 1
Mrs. Brown cat 0
Mrs. Green fish 5
Mr. White fish 7
Mr. White dog 1
Mr. White cat 3
;
run;

title "NARROW_FILE2 – original";
proc print data=narrow_file2 noobs; run;

/* 1. Simple transpose */
title "NARROW_FILE2 – simple TRANSPOSE (all variables)";
proc transpose data=narrow_file2
               out=narrow_file2_transp_default;
run;

/* 2. VAR statement */
title "NARROW_FILE2 – VAR PET POPULATION";
proc transpose data=narrow_file2
               out=narrow_file2_transp_var
               name=x;
  var pet population;
run;

/* 3. BY statement: group-wise transpose by pet_owner */
proc sort data=narrow_file2
          out=sorted_narrow_file2;
  by pet_owner;
run;

title "NARROW_FILE2 – BY PET_OWNER";
proc transpose data=sorted_narrow_file2
               out=narrow_file2_transp_by
               name=x;
  by pet_owner;
run;

/* 4. BY + ID: create one row per owner with pet columns */
title "NARROW_FILE2 – BY PET_OWNER + ID PET";
proc transpose data=sorted_narrow_file2
               out=narrow_file2_transp_id_by
               name=x;
  by pet_owner;
  id pet;
run;

/*********************************************
* WIDE FILE → NARROW FILES (TRANSPOSED)      *
**********************************************/

data wide_file3;
  infile cards missover;
  length pet_owner $10 cat 4 dog 4 fish 4 bird 4;
  input pet_owner $1-10 cat dog fish bird;
cards;
Mr. Black  1 2 . 0
Mrs. Brown 0 1 0 1
Mrs. Green . 0 5 .
Mr. White  3 1 7 2
;
run;

title "WIDE_FILE3 – original";
proc print data=wide_file3 noobs; run;

/* 1. Simple transpose (wide → narrow) */
title "WIDE_FILE3 – simple TRANSPOSE (default)";
proc transpose data=wide_file3
               out=wide_file3_transp_default;
run;

/* 2. NAME + PREFIX options */
title "WIDE_FILE3 – NAME + PREFIX=pet_count";
proc transpose data=wide_file3
               out=wide_file3_transp_name_prefix
               name=x
               prefix=pet_count;
run;

/* 3. ID pet_owner (transpose to have one row per variable and columns as owner) */
title "WIDE_FILE3 – ID PET_OWNER";
proc transpose data=wide_file3
               out=wide_file3_transp_id
               name=x;
  id pet_owner;
run;

/************************************************************
 End of PROC TRANSPOSE demo
************************************************************/

