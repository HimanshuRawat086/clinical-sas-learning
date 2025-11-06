/* ================================
   Clinical SAS — Import & Export Demo
   Author: Himanshu Rawat
   Description: Examples for common imports/exports
   ================================= */

/* >>>>> EDIT THIS PATH <<<<<
   Set this to the local path of your cloned repo */
%let root = C:\Users\YOURNAME\Documents\clinical-sas-import-export;

/* Convenience paths */
%let datadir   = &root.\data;
%let outdir    = &root.\outputs;

/* Create outputs folder if missing (Windows) */
options noxwait;
x "if not exist ""&outdir."" mkdir ""&outdir.""";

/* Safer defaults */
options validvarname=any;
options dlcreatedir;

/* ========== IMPORTS ========== */

/* 1) XLS (legacy Excel) */
proc import datafile="&datadir.\mydata1.xls"
    out=work.test_xls dbms=xls replace;
run;

proc print data=work.test_xls(obs=10); run;

/* 2) XLS with REPLACE explicitly */
proc import datafile="&datadir.\mydata1.xls"
    out=work.test_xls2 dbms=xls replace;
run;

/* 3) XLS with specific SHEET */
proc import datafile="&datadir.\mydata1.xls"
    out=work.test_sheet dbms=xls replace;
    sheet='uuu';
run;

/* 4) XLS with GETNAMES=NO */
proc import datafile="&datadir.\mydata1.xls"
    out=work.test_nohdr dbms=xls replace;
    getnames=no;
    sheet='uuu';
run;

/* 5) XLS with RANGE = 'Sheet$A1:D10' */
proc import datafile="&datadir.\mydata1.xls"
    out=work.test_range dbms=xls replace;
    getnames=no;
    range='uuu$A1:D10';
run;

/* 6) XLS with DATAROW start */
proc import datafile="&datadir.\mydata1.xls"
    out=work.test_datarow dbms=xls replace;
    getnames=no;
    sheet='uuu';
    datarow=20;
run;

/* 7) Import to a specific library example (creates WORK lib if not assigned) */
/* In modern projects, prefer WORK or a project lib instead of SASUSER */
libname proj work;
proc import datafile="&datadir.\mydata1.xls"
    out=proj.test_lib dbms=xls replace;
    getnames=no;
    sheet='uuu';
    datarow=20;
run;

/* 8) XLSX modern Excel */
proc import datafile="&datadir.\mydata1.xlsx"
    out=work.test_xlsx dbms=xlsx replace;
run;

/* 9) CSV (comma-delimited) */
proc import datafile="&datadir.\coma.txt"
    out=work.csv_nohdr dbms=csv replace;
    getnames=no;
run;

proc import datafile="&datadir.\myfile.csv"
    out=work.csv_default dbms=csv replace;
run;

/* 10) Space-delimited TXT */
proc import datafile="&datadir.\raw.txt"
    out=work.space_txt dbms=dlm replace;
    delimiter=' ';
    guessingrows=max;
run;

/* 11) Tab-delimited TXT */
proc import datafile="&datadir.\tabfile.txt"
    out=work.tab_txt dbms=tab replace;
    getnames=no;
run;

/* Quick peek */
title "Row counts after import";
proc sql;
  select "test_xls"      as table, count(*) as n from work.test_xls
  union all select "test_xls2",      count(*) from work.test_xls2
  union all select "test_sheet",     count(*) from work.test_sheet
  union all select "test_nohdr",     count(*) from work.test_nohdr
  union all select "test_range",     count(*) from work.test_range
  union all select "test_datarow",   count(*) from work.test_datarow
  union all select "test_lib",       count(*) from proj.test_lib
  union all select "test_xlsx",      count(*) from work.test_xlsx
  union all select "csv_nohdr",      count(*) from work.csv_nohdr
  union all select "csv_default",    count(*) from work.csv_default
  union all select "space_txt",      count(*) from work.space_txt
  union all select "tab_txt",        count(*) from work.tab_txt
  ;
quit;
title;

/* ========== EXPORTS ========== */
/* Uses SASHELP datasets to avoid sharing real data */

/* 1) Export to legacy Excel .xls */
proc export outfile="&outdir.\report.xls"
    data=sashelp.class dbms=xls replace;
run;

/* 2) Export to .xlsx with DROP columns */
proc export outfile="&outdir.\report.xlsx"
    data=sashelp.heart(drop=sex height) dbms=xlsx replace;
run;

/* 3) Export to .xlsx preserving labels */
proc export outfile="&outdir.\report_with_labels.xlsx"
    data=sashelp.heart(drop=sex height label="Framingham Heart Study subset")
    dbms=xlsx replace label;
run;

/* 4) Export multiple sheets to same workbook */
proc export outfile="&outdir.\multi_sheet.xlsx"
    data=sashelp.class dbms=xlsx replace label;
    sheet="class";
run;

proc export outfile="&outdir.\multi_sheet.xlsx"
    data=sashelp.heart dbms=xlsx label;
    sheet="heart";
run;

/* 5) Export to CSV (comma) */
proc export outfile="&outdir.\class.csv"
    data=sashelp.class dbms=csv replace;
run;

/* 6) Export CSV as .txt (comma-delimited) */
proc export outfile="&outdir.\class_comma.txt"
    data=sashelp.class dbms=csv replace;
run;

/* 7) Export TAB-delimited TXT */
proc export outfile="&outdir.\class_tab.txt"
    data=sashelp.class dbms=tab replace;
run;

/* 8) Export space-delimited TXT (DLM) */
proc export outfile="&outdir.\class_space.txt"
    data=sashelp.class dbms=dlm replace;
    delimiter=' ';
run;

title "Export complete — files written to &outdir.";
proc datasets library=work nolist; quit;
