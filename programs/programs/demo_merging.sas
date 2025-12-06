/*******************************************************
 Demo: Merging in SAS
 Includes:
 - One-to-one merges
 - One-to-many merges
 - Many-to-many merge example (AE–CM)
*******************************************************/

/*============================================*
 *           ONE-TO-ONE MERGE                *
 *============================================*/

/* DADS dataset */
data dads; 
  input famid name $ inc x; 
cards; 
2 Art  22000 10
1 Bill 30000 10
3 Paul 25000 10
5 Jack 25000 10
; 
run;

/* FAMINC dataset */
data faminc; 
  input famid faminc96 faminc97 faminc98 x; 
cards; 
3 75000 76000 77000 20
1 40000 40500 41000 20
2 45000 45400 45800 20
4 45000 45400 45800 20
;
run;

/* Just stacking (not merge) */
data stacked;
  set dads faminc;
run;
title "Stacked dads + faminc (SET)";
proc print data=stacked noobs; run;

/* Sort both before MERGE */
proc sort data=dads   out=dad;  by famid; run;
proc sort data=faminc out=fam;  by famid; run;

/* Simple merge with rename of x to avoid name clash */
data dadfam_rename;
  merge dad fam (rename=(x = x_fam));
  by famid;
run;
title "One-to-one MERGE with RENAME";
proc print data=dadfam_rename noobs; run;

/* Same merge but dropping x from fam (keep x from dads) */
data dadfam_drop;
  merge dad fam (drop = x);
  by famid;
run;
title "One-to-one MERGE dropping x from fam";
proc print data=dadfam_drop noobs; run;

/* Inner join: records present in both */
data dadfam_inner;
  merge dad(in=a) fam(in=b);
  by famid;
  if a and b;
run;
title "Inner join (a and b)";
proc print data=dadfam_inner noobs; run;

/* Non-matching (anti full join) */
data dadfam_mismatch;
  merge dad(in=a) fam(in=b);
  by famid;
  if a ne b;
run;
title "Records present in only one dataset (mismatch)";
proc print data=dadfam_mismatch noobs; run;

/* Left join: all from dad */
data dadfam_left;
  merge dad(in=a) fam(in=b);
  by famid;
  if a;
run;
title "Left join (all from dads)";
proc print data=dadfam_left noobs; run;

/* Right join: all from fam */
data dadfam_right;
  merge dad(in=a) fam(in=b);
  by famid;
  if b;
run;
title "Right join (all from faminc)";
proc print data=dadfam_right noobs; run;

/* Left-only */
data dadfam_leftonly;
  merge dad(in=a) fam(in=b);
  by famid;
  if a and not b;
run;
title "Left-only (in dads, not in faminc)";
proc print data=dadfam_leftonly noobs; run;

/* Right-only */
data dadfam_rightonly;
  merge dad(in=a) fam(in=b);
  by famid;
  if b and not a;
run;
title "Right-only (in faminc, not in dads)";
proc print data=dadfam_rightonly noobs; run;

/*============================================*
 *           ONE-TO-MANY MERGE               *
 *============================================*/

/* Parent dataset: one row per famid */
data dady; 
  input famid name $ inc; 
cards; 
2 Art  22000 
1 Bill 30000 
3 Paul 25000 
4 Jack 25000 
; 
run;

/* Child dataset: many rows per famid */
data kids; 
  input famid kidname $ birth age wt sex $; 
cards; 
1 Beth 1 9 60 f 
1 Bob  2 6 40 m 
1 Barb 3 3 20 f 
2 Andy 1 8 80 m 
2 Al   2 6 50 m 
2 Ann  3 2 20 f 
3 Pete 1 6 60 m 
3 Pam  2 4 40 f 
3 Phil 3 2 20 m 
5 Pet  5 3 20 M
; 
run;

/* Sort before merging */
proc sort data=dady out=dady1; by famid; run;
proc sort data=kids out=kids1; by famid; run;

/* One-to-many merge: repeat parent row for each kid */
data dadkid;
  merge dady1(in=a) kids1(in=b);
  by famid;
  if b;  /* keep only rows that come from kids (with parent data if available) */
run;
title "One-to-many merge: parent (dady) + children (kids)";
proc print data=dadkid noobs; run;

/*============================================*
 *           MANY-TO-MANY MERGE              *
 *============================================*/

/* AE: Adverse Events */
data ae;
  input ptnum $ 1-3 @5 date date9. event $ 15-35;
  format date date9.;
cards;
001 16NOV2009 Nausea
002 17NOV2009 Heartburn
002 16NOV2009 Acid Indigestion
002 18NOV2009 Nausea
003 17NOV2009 Fever
003 18NOV2009 Fever
005 17NOV2009 Fever
;
run;

/* CM: Concomitant Medications */
data cm;
  infile cards;
  input ptnum $ 1-3 @5 date date9. medication $ 15-35;
  format date date9.;
cards;
001 16NOV2009 Dopamine
002 17NOV2009 Antacid
002 16NOV2009 Sodium bicarbonate
002 18NOV2009 Dopamine
003 18NOV2009 Asprin
004 19NOV2009 Asprin
005 17NOV2009 Asprin
;
run;

title "AE dataset";
proc print data=ae noobs; run;

title "CM dataset";
proc print data=cm noobs; run;

/* Sort by patient and date */
proc sort data=ae; by ptnum date; run;
proc sort data=cm; by ptnum date; run;

/* Many-to-many MERGE by ptnum & date
   Only events with exactly the same ptnum+date will align */
data ae_cm_merge;
  merge ae cm;
  by ptnum date;
run;

title "Many-to-many MERGE by ptnum & date";
proc print data=ae_cm_merge noobs; run;

/* Note:
   For complex many-to-many situations (all combinations, time windows),
   PROC SQL joins are usually preferred.
*/

/*************** END OF PROGRAM ***************/
