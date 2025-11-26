# Clinical SAS — Import & Export Examples

This repo contains SAS programs that demonstrate importing and exporting common file types used in clinical/biostat work.

## What’s here
- **programs/01_import_export_demo.sas** – end-to-end examples of:
  - Importing: `.xls`, `.xlsx`, `.csv`, tab-delimited, space-delimited
  - Options: `sheet=`, `range=`, `getnames=`, `datarow=`, `replace`
  - Exporting: Excel/CSV/TAB with `DROP=` and `LABEL` handling

## Folder structure
- **data/** – place your local test files here (e.g., `mydata1.xls`, `coma.txt`, `raw.txt`, `tabfile.txt`, `myfile.csv`)
- **programs/** – SAS code
- **outputs/** – exported files created by the code (Excel/CSV/TXT)

> 🔒 **Privacy:** Never commit real patient/PHI data. Use dummy/mock datasets.

## How to run
1. Download/clone the repo.
2. Put your sample files in `data/`.
3. Open `programs/01_import_export_demo.sas` in SAS (EG/Studio/On-Prem).
4. Update the `root` path macro variable to your local folder.
5. Run the program. Exports will appear in `outputs/`.

## Topics covered
- `PROC IMPORT` with `DBMS=XLS/XLSX/CSV/TAB/DLM`
- `SHEET=`, `RANGE=`, `GETNAMES=`, `DATAROW=`, `REPLACE`
- `PROC EXPORT` to Excel and delimited formats

- # Clinical SAS — Input Methods (List, Named, Column, Formatted)

This project demonstrates **how to read raw data into SAS** using common input techniques:
- **List input** (space-delimited)
- **Named input** (name=value pairs, order not important)
- **Column input** (fixed columns)
- **Formatted input** (fixed columns + informats)
- Pointer controls: `@`, `@@`, `@n`, `+n`
- Modifiers: `&` (embedded blanks), `:` (informats w/ delimiters)

The code is **self-contained** using `DATALINES`, so you can run it directly.

## Files
- `programs/02_input_methods_demo.sas` — all examples in one runnable script

## How to run
1. Open the `.sas` file in SAS (EG/Studio/On-Prem).
2. Run the whole script.
3. Check the `PROC PRINT` outputs in the Results window.

## Notes
- Examples avoid external data files to keep the project portable.
- Comments call out common pitfalls (e.g., overlapping columns, missing headers).
- Never commit real patient/PHI data to GitHub.

- Using `SASHELP` demo tables for safe exports

## Next steps
- Add QA checks (obs counts, column types).
- Add a macro to import all sheets from a workbook.
- Add a data dictionary export (via `PROC CONTENTS`).

- ## 03 — Date, Time, Datetime, and Numeric Formats

This project demonstrates how SAS reads and displays date, time, datetime, and numeric values using INFORMAT (input interpretation) and FORMAT (output display). It includes examples of:

- Reading raw date strings using `ddmmyy10.` and `date9.`
- Displaying dates in multiple formats such as `ddmmyy10.`, `mmddyy10.`, `yymmdd10.`, and `weekdate36.`
- Reading and formatting month-year values using `monyy7.`
- Reading time and datetime values using `time.`, `time8.`, `timeampm10.`, and `datetime18.`
- Applying numeric display formats such as `6.3` and `best.`

**Program:** `programs/03_date_time_formats_demo.sas`

# Clinical SAS — PROC FORMAT (Character & Numeric)

This project demonstrates `PROC FORMAT` use-cases:
- Character → Numeric (C→N)
- Numeric → Character (N→C)
- Numeric → Numeric (N→N)
- Character → Character (C→C)
- Permanent format libraries (`FMTSEARCH`)
- Export/Import format catalogs with `CNTLOUT / CNTLIN`
- Viewing formats with `FMTLIB`

## File
- `programs/03_proc_format_demo.sas` — end-to-end runnable examples with `DATALINES`.

## How to run
1. Open the `.sas` file in SAS (EG/Studio/On-Prem).
2. Run the whole script.
3. Review printed outputs and format listings.

## Notes
- Examples use WORK library by default; a `SASUSER` example is included.
- Never commit real PHI/patient data.

# Clinical SAS Examples

This repository contains short, self-contained SAS example scripts for clinical programming learning.

## Contents
- `programs/01_import_export_demo_v1.sas` — Import & Export examples (xls, xlsx, csv, tab, dlm)
- `programs/02_input_methods_demo_v1.sas` — Input methods: List, Named, Column, Formatted, pointers (@, @@), & modifiers
- `programs/03_date_time_numeric_formats_v1.sas` — Date, Time, Datetime, and Numeric format/informat examples
- `programs/04_proc_format_examples_v1.sas` — PROC FORMAT examples (C→N, N→C, N→N, C→C), fmtlib, cntlout/cntlin
- `programs/05_global_options_examples_v1.sas` — SAS global options examples (title, footnote, options, log control, library settings)

## How to use
1. Open the `.sas` file in SAS (Enterprise Guide / Base SAS).
2. Run the file. All scripts are self-contained (use DATALINES or SASHELP) and safe to run.
3. Do **not** commit any real patient/PHI data to this repo.

## Notes
- Filenames include `_v1` to avoid overwrite conflicts. Rename as needed.
- If you already have a file with the same name, create a new file with a different suffix (e.g., `_v2`).
- 
# SAS DATA STEP – SET Statement Examples

This project contains SAS programs demonstrating different ways of using the SET statement in the DATA step. Topics include:

- Basic SET statement  
- KEEP and DROP  
- WHERE filtering  
- RENAME  
- Combining datasets  
- DUPLICATE SET  
- FIRSTOBS / OBS options  
- Dataset options (PW, READ=, REPLACE=)  
- LABEL assignment  
- PROC DATASETS modify  

All code is located in `programs/01_data_step_examples.sas`.

Run the file directly in SAS to see outputs.

# Clinical SAS — PROC PRINT & PROC SORT Examples

This repository contains practice programs for `PROC PRINT` and `PROC SORT` in SAS
using sample datasets such as `sashelp.class`, `sashelp.heart`, and small demo
datasets created with `DATALINES`.

## Contents

- `programs/03_proc_print_sort_demo.sas`  
  - Basic `PROC PRINT`
  - Selecting variables with `VAR`
  - Dropping variables
  - `WHERE` filtering
  - `SUM` statement
  - Using `LABEL`, `SPLIT`, `HEADING=VERTICAL`, and `DOUBLE`
  - Basic `PROC SORT` (BY, OUT=, KEEP=)
  - Sorting with `DESCENDING`
  - `NODUPKEY`, `DUPLICATE` handling with `DUPOUT=`
  - Sorting character data and using `BY` + `ID`

## How to run

1. Open `03_proc_print_sort_demo.sas` in SAS (EG/Studio/Base).
2. Submit the whole program.
3. Check the `PROC PRINT` and `PROC SORT` outputs in the Results window.

> Note: All examples use demo data. Do not use real patient data in public repos.

# Clinical SAS — SET Statement & Dataset Options

This project demonstrates how to use the `SET` statement and common dataset options in SAS.  
All examples use `SASHELP.CLASS` and `SASHELP.HEART` so the code can run on any SAS installation.

## Topics covered

- Basic `SET` statement
- `KEEP=` and `DROP=` dataset options
- `WHERE=` dataset option on input
- `RENAME=` dataset option
- Concatenating multiple datasets with `SET`
- Using `OBS=` and `FIRSTOBS=` on input datasets
- Output dataset options:
  - `REPLACE=NO`
  - Password protection with `PW=` and `READ=`
  - Modifying password with `PROC DATASETS`
- Assigning dataset label in the `DATA` statement

## File

- `programs/03_set_and_dataset_options_demo.sas`  
  Contains all examples in a single runnable script.

## How to run

1. Open the `.sas` file in SAS (EG / Studio / Base).
2. Run the whole script.
3. Check the `PROC PRINT` output windows to see how each option behaves.

# Clinical SAS — Character Functions & COALESCE

This project demonstrates commonly used **character functions** and **missing-value handling** in SAS, using simple examples.

## Topics Covered

- Case conversion: `UPCASE`, `LOWCASE`, `PROPCASE`
- Space and character cleanup: `COMPBL`, `COMPRESS`
- Search functions: `FIND`, `INDEX`, `INDEXW`
- Substring extraction: `SUBSTR`
- Word extraction: `SCAN`
- String joining and concatenation: `CAT`, `CATS`, `CATT`, `CATX`, `||`, `STRIP`, `TRIM`
- Length and word count: `LENGTH`, `LENGTHM`, `COUNTW`, `REVERSE`
- First non-missing value selection: `COALESCE`

All examples use either `DATALINES` or `SASHELP` sample datasets (`SASHELP.CLASS`, `SASHELP.HEART`, `SASHELP.AIR`).

## File

- `programs/06_character_functions_and_coalesce.sas`  
  Contains all the code examples for character handling and `COALESCE`.

## How to Run

1. Download or clone the repository.
2. Open `programs/06_character_functions_and_coalesce.sas` in SAS (EG / Studio / Base SAS).
3. Run the whole script or run each section step-by-step.
4. Check the `PROC PRINT` outputs to see how each function behaves.

> Note: All data is demo data from `SASHELP` or inline `DATALINES`. No real patient data is used.

## 03 – Numeric Functions, Conversions, and Date/Time Handling in SAS

This program demonstrates:

- Basic numeric input and functions  
  - `INT`, `ROUND`, `CEIL`, `FLOOR`, `DIF`, `LAG`, `LOG`, `LOG10`, `MOD`
- Row-wise statistics across variables  
  - `SUM`, `MEAN`, `STD`, `MIN`, `MAX`
- Character ↔ numeric conversion  
  - `PUT` and `INPUT`
- Working with date values  
  - Reading dates with `DATE9.` and `MMDDYY10.` informats  
  - Displaying dates with `DDMMYY10.`  
- Character to date and string concatenation using `||` and `CAT`
- Date arithmetic  
  - Direct subtraction of dates  
  - `INTCK` for exact interval counts (day, week, month, year)  
  - `INTNX` for shifting dates (days/months) with alignment
- Date and datetime components  
  - `DAY`, `MONTH`, `YEAR`, `WEEK`, `DATEPART`, `TIMEPART`

# Clinical SAS — WHERE, IF, AND LOGICAL OPERATORS

This project demonstrates how to filter and manipulate data in SAS using:

- `WHERE` vs `IF`
- Logical operators: `AND`, `OR`, `IN`
- Pattern matching: `LIKE`
- Missing value checks: `IS MISSING`, `= .`, `= ""`
- Conditional output to multiple datasets
- `LENGTH` for character variables
- `PROC SORT` with `NODUPKEY`, and BY-group processing using `FIRST.` and `LAST.`

All examples use built-in SAS sample datasets: `sashelp.heart` and `sashelp.class`.

## File

- `programs/01_where_if_demo.sas` — runnable demo covering:
  - Basic `WHERE` filters
  - Multiple conditions with `AND` / `OR` / `IN`
  - Range checks on numeric variables
  - Handling missing numeric and character values
  - `LIKE` patterns for character variables
  - `IF` vs `WHERE` in DATA steps
  - `OUTPUT` to multiple datasets
  - `LENGTH` for character variables and re-mapping `sex`
  - `PROC SORT`, `NODUPKEY`, and BY-group logic (`FIRST.` / `LAST.`)

## How to run

1. Copy `01_where_if_demo.sas` into your SAS environment (EG / Studio / Display Manager).
2. Submit the full program.
3. Review the `PROC PRINT` outputs to see how each filter and condition changes the results.

# PROC MEANS & PROC FREQ Demo (SASHELP.HEART)

This folder contains a small demo of descriptive statistics on the
`SASHELP.HEART` dataset using `PROC MEANS` and `PROC FREQ`.

## Files
- `demo_heart_stats.sas` – SAS code for summaries of AgeAtStart, Status, and Sex.

## How to run
1. Open SAS.
2. Ensure `SASHELP.HEART` is available.
3. Run `demo_heart_stats.sas`.
4. Check the Results window and created output datasets.
