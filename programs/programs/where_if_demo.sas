/**************************************************************
   Clinical SAS — WHERE, IF, and Logical Operators Demo
   Uses: sashelp.heart, sashelp.class
**************************************************************/

/*-------------------------------------------------------------
  Simple filter: keep observations where Status = "Dead"
-------------------------------------------------------------*/
data test;
  set sashelp.heart;
  where Status = "Dead";
run;

/*-------------------------------------------------------------
  Notes about operators (for reference only in comments)
    - Comparison: >  <  >=  <=  ^=  NE  =
    - Logical: AND, OR, NOT, IN
    - Membership: IN ("A","B","C")
    - LIKE: % (0+ chars), _ (exactly 1 char)
    - Missing numeric: .   or  is missing
    - Missing character: ""  or  is missing
-------------------------------------------------------------*/

/*-------------------------------------------------------------
  Multiple AND conditions (Cancer deaths, female, age > 60)
-------------------------------------------------------------*/
data test;
  set sashelp.heart;
  where Status     = "Dead"
    and DeathCause = "Cancer"
    and Sex        = "Female"
    and AgeAtStart > 60;
run;

/*-------------------------------------------------------------
  Use IN for multiple values (Smoking status)
-------------------------------------------------------------*/
data test;
  set sashelp.heart;
  where Status = "Alive"
    and Sex   = "Male"
    and AgeAtStart > 60
    and Smoking_Status in ("Heavy (16-25)", "Very Heavy (> 25)");
run;

/*-------------------------------------------------------------
  Same logic using explicit OR (with parentheses)
-------------------------------------------------------------*/
data test;
  set sashelp.heart;
  where Status = "Alive"
    and Sex   = "Male"
    and AgeAtStart > 60
    and (Smoking_Status = "Heavy (16-25)"
         or Smoking_Status = "Very Heavy (> 25)");
run;

/*-------------------------------------------------------------
  Combined OR / AND logic: two alternative condition blocks
-------------------------------------------------------------*/
data test;
  set sashelp.heart;
  where (Status     = "Dead"
         and DeathCause = "Cancer"
         and Sex        = "Female"
         and AgeAtStart > 60)
     or (Status     = "Alive"
         and Sex        = "Male"
         and AgeAtStart > 60
         and Smoking_Status in ("Heavy (16-25)", "Very Heavy (> 25)"));
run;

/*-------------------------------------------------------------
  Numeric range and comparison examples (sashelp.class)
  Correct way: use AND instead of chained inequality
-------------------------------------------------------------*/
data test;
  set sashelp.class;
  /* 13 < age < 16  --> age > 13 and age < 16 */
  where age > 13 and age < 16;
run;
proc print data=test; run;

/* age LE 15 */
data test;
  set sashelp.class;
  where age le 15;   /* le = <= */
run;
proc print data=test; run;

/* age GT 15 */
data test;
  set sashelp.class;
  where age gt 15;   /* gt = > */
run;
proc print data=test; run;

/*-------------------------------------------------------------
  Missing value examples (sashelp.heart)
  Numeric: AgeAtDeath
-------------------------------------------------------------*/
data test;
  set sashelp.heart;
  where AgeAtDeath is missing;   /* preferred */
run;

data test;
  set sashelp.heart;
  where AgeAtDeath = .;          /* equivalent */
run;

/* Character missing example: Smoking_Status = "" */
data test;
  set sashelp.heart;
  where Smoking_Status = "";
run;

/*-------------------------------------------------------------
  LIKE examples (character pattern matching) — sashelp.class
-------------------------------------------------------------*/

/* Names starting with 'A' */
data test;
  set sashelp.class;
  where name like 'A%';
run;
proc print data=test; run;

/* Names ending with 'a' */
data test;
  set sashelp.class;
  where name like '%a';
run;
proc print data=test; run;

/* Names containing 'a' */
data test;
  set sashelp.class;
  where name like '%a%';
run;
proc print data=test; run;

/* Second letter is 'a' */
data test;
  set sashelp.class;
  where name like '_a%';
run;
proc print data=test; run;

/*-------------------------------------------------------------
  WHERE vs IF
  - WHERE filters before DATA step executes
  - IF filters after the row is in the PDV
-------------------------------------------------------------*/

/* WHERE */
data test;
  set sashelp.class;
  where sex = "F";
run;
proc print data=test; run;

/* IF (same result here) */
data test;
  set sashelp.class;
  if sex = "F";
run;
proc print data=test; run;

/* IF used to create new variable only for females */
data test;
  set sashelp.class;
  if sex = "F" then x = 1;
run;
proc print data=test; run;

/* IF used to modify age only for females */
data test;
  set sashelp.class;
  if sex = "F" then age = age + 10;
run;
proc print data=test; run;

/*-------------------------------------------------------------
  Output to different datasets using OUTPUT
-------------------------------------------------------------*/
data mx fx;
  set sashelp.class;
  if sex = "F" then output fx;
  if sex = "M" then output mx;
run;
proc print data=mx; run;
proc print data=fx; run;

/*-------------------------------------------------------------
  IF / ELSE examples
-------------------------------------------------------------*/
data test;
  set sashelp.class;
  if sex = "F" then age = age + 10;
  else age = age + 20;
run;
proc print data=test; run;

data test;
  set sashelp.class;
  if sex = "F" then age1 = age + 10;
  else if sex = "M" and age > 14 then age1 = age + 5;
  else age1 = age + 20;
run;
proc print data=test; run;

/*-------------------------------------------------------------
  LENGTH statement — must appear before first reference
-------------------------------------------------------------*/

/* Overwriting existing sex variable with longer values */
data test;
  length sex $ 10;      /* define length BEFORE SET */
  set sashelp.class;
  if sex = "F" then sex = "Female";
run;
proc print data=test; run;

/* Creating a new variable sex1 instead of overwriting */
data test;
  set sashelp.class;
  length sex1 $ 10;
  if sex = "F" then sex1 = "Female";
  else sex1 = "Male";
run;
proc print data=test; run;

/* Demo: trailing blanks in character values */
data test;
  set sashelp.class;
  if sex = "F" then sex1 = "F        ";
  else sex1 = "Male";
run;
proc print data=test; run;

/* Better: concise values with controlled length */
data test;
  set sashelp.class;
  length sex1 $ 10;
  if sex = "F" then sex1 = "F";
  else sex1 = "Male";
run;
proc print data=test; run;

/*-------------------------------------------------------------
  SORT and BY-group processing (FIRST./LAST.)
-------------------------------------------------------------*/

/* Sort by age */
proc sort data=sashelp.class out=test;
  by age;
run;

/* Sort by age, keep first row per age (NODUPKEY) */
proc sort data=sashelp.class out=test nodupkey;
  by age;
run;

/* FIRST.age example: keep first obs in each age group */
data test1;
  set test;
  by age;
  if first.age;
run;
proc print data=test1; run;

/* LAST.age example: keep last obs in each age group */
data test1;
  set test;
  by age;
  if last.age;
run;
proc print data=test1; run;

/* Split into datasets with first and last per age */
data f l;
  set test;
  by age;
  if first.age then output f;
  if last.age then output l;
run;
proc print data=f; run;
proc print data=l; run;
