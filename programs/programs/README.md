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

# SAS – Looping Concepts (DO, WHILE, UNTIL, Nested DO)

## 📌 Objective
This project demonstrates different types of loops in SAS using clinical-style examples.  
Covered topics:
- `DO WHILE`
- `DO` (simple, conditional, backward)
- `Nested DO` loops
- `DO UNTIL`
- Use of `IF`, `DO`, `ELSE`

---

## 📂 Files Included
| File | Description |
|------|-------------|
| `looping_concepts.sas` | Main SAS program with all loop examples |
| `README.md` | Explanation + execution guide |

---

## ▶ How to Run
1. Open SAS.
2. Copy & run the `looping_concepts.sas` file.
3. Check results in **Work Library** and **PROC PRINT outputs**.

---

## 🧠 Concepts Demonstrated

### 🔹 DO WHILE
- Condition is checked **before** entering loop.
- Used to stop when condition becomes FALSE.

### 🔹 Simple DO Loops
- `1 to 10`, `by 2`, backward loops.
- Use of `IF…DO` to apply logic.

### 🔹 Nested DO Loops
- Used for combinations (e.g., patient visits / repeated measures).

### 🔹 DO UNTIL
- Always runs **at least once**.
- Condition checked **after** loop ends.

---

## 📌 Clinical Use Cases (Real Industry Logic)
| Type of Loop | Real Use Case |
|--------------|------------------------------|
| DO WHILE | Generate patient records until visit date > cutoff |
| Nested DO | Create patient × visit combinations |
| DO UNTIL | Run until drug dose reaches target |
| IF–DO Block | Assign treatment arm based on age |

---

## 🚀 Next Extensions
Possible future improvements:
- Generate random age using `RAND()`
- Create `Patient_ID`, `Visit`, `Dose`
- Export results to CSV
- Use macros to repeat logic

---

**Author**: *Himanshu Rawat*  
_Clinical Programming (SAS + R)_  


# Arrays & Missing-Value Handling (SAS)

## Objective
Demonstrate common array techniques and patterns for handling missing values and bulk transformations in SAS:
- Replace missing values (single variables and via arrays)
- Use array ranges and different replacement rules
- Apply arithmetic and functions to array elements
- Work with all character / numeric variables using `_character_` and `_numeric_`
- Compute and use row-wise mean to impute missing values

## Files
- `arrays_missing_handling.sas` — Complete SAS script with all examples

## How to run
1. Open SAS.
2. Run `arrays_missing_handling.sas`.
3. Inspect resulting datasets (`WORK.`) using `PROC PRINT` or Viewtable.

## Notes / Caveats
- Example steps intentionally re-use dataset names like `test1` for demonstration; when producing final analysis, use descriptive dataset names to avoid accidental overwrites.
- Step that uses an array of character variables (`array abc (6) ll nn ...`) is illustrative — ensure the target dataset has corresponding character variables before running.
- For clinical workflows, prefer creating final cleaned datasets with meaningful names and keep raw source data unchanged.

## Author
Himanshu Rawat — Clinical Programming (SAS + R)

# Merging in SAS (One-to-One, One-to-Many, Many-to-Many)

## Objective
This project demonstrates how to combine datasets in SAS using the `MERGE` statement:

- One-to-one merges
- Using `IN=` flags for inner / left / right / anti joins
- One-to-many merges (parent–child)
- Many-to-many merges (AE–CM example) and why they are tricky

## Files
- `demo_merging.sas` – Main SAS program with all examples

## How to run
1. Open SAS.
2. Run `demo_merging.sas`.
3. View created datasets in the WORK library and the printed outputs.

## Key ideas
- Datasets must be **sorted by BY variables** before using `MERGE`.
- Use `IN=` flags to control which records to keep:
  - `if a and b;` → inner join
  - `if a;` → left join
  - `if b;` → right join
  - `if a and not b;` → left-only
  - `if b and not a;` → right-only
- For **many-to-many** joins, `MERGE` may not give all combinations; `PROC SQL` is often better.

# PROC REPORT Demo – Reporting on CLASS & TRIALS Data

## Objective
This project demonstrates how to use `PROC REPORT` in SAS for tabular reporting, including:

- Basic `PROC REPORT` usage (`NOWD`, `HEADLINE`, `HEADSKIP`)
- Selecting and labeling columns
- Ordering and grouping with `DEFINE`
- BREAK and COMPUTE blocks (custom lines, summaries)
- BY-group reporting
- Text wrapping with `FLOW`
- Simple `ACROSS` reports and summaries

## Datasets Used

- `sashelp.class` – Built-in SAS demo dataset (students' age, sex, height, weight).
- `test` – Derived from `sashelp.class` with an extra text variable.
- `trials` – Custom dataset with patient trial readings (sb1/sb2).

## File

- `proc_report_demo.sas` – Full script containing all `PROC REPORT` examples.

## How to Run

1. Open SAS.
2. Run `proc_report_demo.sas`.
3. View:
   - Output window for reports.
   - WORK library for created datasets (`ll`, `test`, `trials`, etc.).

## Key Concepts Shown

- `NOWD` for non-interactive reports.
- `HEADLINE` & `HEADSKIP` for header formatting.
- Group/Order variables with `DEFINE ... / GROUP` and `DEFINE ... / ORDER`.
- Custom labels, widths, and header splitting with `SPLIT=`.
- `BREAK AFTER` and `COMPUTE AFTER` for group-wise lines/summaries.
- `FLOW` for wrapping long text in a column.
- `ACROSS` for transposing values across columns.
- Using `DUL`, `DOL`, and `SUMMARIZE` for group summaries.

## Author

Himanshu Rawat — Clinical Programming (SAS + R)

# PROC TRANSPOSE Demo – Narrow ↔ Wide Data

## Objective

This project demonstrates how to reshape data using `PROC TRANSPOSE` in SAS:

- Converting **narrow → wide** (one row per pet / owner to one row per owner)
- Converting **wide → narrow** (multiple pet columns to multiple rows)
- Using options and statements:
  - `PREFIX=`
  - `NAME=`
  - `VAR`
  - `ID`
  - `BY`

## Datasets

- `narrow_file1` – simple narrow file with one row per owner–pet.
- `narrow_file2` – narrow file with **multiple rows per owner**.
- `wide_file3` – wide file with one row per owner (cat, dog, fish, bird).

## File

- `proc_transpose_dem


# PROC SQL in SAS – Complete Demo

## Objective
This project demonstrates how to use **PROC SQL in SAS** for data creation,
querying, joining, aggregation, and advanced transformations.

The script covers SQL concepts commonly used in:
- Clinical programming
- Data analysis
- Reporting and ETL workflows

---

## Topics Covered

### 1. Dataset Creation
- Creating datasets using DATA step
- Using dates, formats, and character variables

### 2. Basic SQL Queries
- SELECT *
- WHERE, ORDER BY
- DISTINCT
- LIKE, BETWEEN, IN
- IS NULL / IS NOT NULL

### 3. Joining Tables
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL JOIN
- UNION, INTERSECT, EXCEPT

### 4. Subqueries
- Subqueries in SELECT
- Subqueries in WHERE

### 5. Aggregate Functions & Grouping
- SUM, AVG, COUNT, MIN, MAX
- GROUP BY
- HAVING
- Summary reports

### 6. Updating & Deleting Records
- UPDATE statements
- DELETE statements

### 7. Views & Indexes
- CREATE VIEW
- CREATE INDEX

### 8. Advanced SQL Functions
- CASE WHEN
- Date functions (INTCK, INTNX)
- String functions (CATS, LENGTH)
- Pivoting and unpivoting data

---

## Files
- `proc_sql_demo.sas` – Full PROC SQL demo with examples

---

## How to Run
1. Open SAS.
2. Run `proc_sql_demo.sas`.
3. Review results in the **Results window** and datasets in the **WORK library**.

---

## Clinical Relevance
- Creating analysis datasets
- Joining subject-level and visit-level data
- Generating summary tables
- Preparing reports for listings and outputs

---

## Author
**Himanshu Rawat**  
Clinical Programming (SAS & R)

# SAS Macros – Complete Demo

## Objective
This project demonstrates the use of **SAS Macros** to automate tasks,
create dynamic programs, and control execution flow.

Macros are heavily used in:
- Clinical programming
- Reusable reporting code
- Parameterized analysis programs

---

## Topics Covered

### 1. Basic Macro Creation
- Defining macros with `%macro` / `%mend`
- Passing parameters (keyword & positional)

### 2. Macro Variables
- `%let` to create macro variables
- Resolving macro variables in DATA & PROC steps
- Appending text before and after macro variables

### 3. Macro Loops
- `%do %to` loops
- Generating multiple datasets dynamically

### 4. PROC SQL INTO
- Creating macro variables using `SELECT INTO :`
- Using macro variables in titles and WHERE clauses

### 5. CALL SYMPUT / CALL SYMPUTX
- Creating macro variables from DATA steps
- Difference between `symput` and `symputx`

### 6. Macro Scope
- `%local` vs `%global`
- Understanding variable scope

### 7. Conditional Logic
- `%if %then %else`
- Using automatic macro variables like `&SYSDAY`

### 8. Debugging & Quoting
- `%put`, `_USER_`, `_AUTOMATIC_`
- Macro quoting: `%str`, `%nrstr`, `%bquote`

---

## File
- `macros_demo.sas` – Complete macro examples and demonstrations

---

## How to Run
1. Open SAS.
2. Run `macros_demo.sas`.
3. Check:
   - LOG window for macro execution (`MPRINT`, `MLOGIC`)
   - WORK library for generated datasets

---

## Clinical Relevance
- Automating repetitive summaries
- Parameterized reporting
- Dynamic titles and filters
- Scalable clinical reporting programs

---

## Author
**Himanshu Rawat**  
Clinical Programming (SAS & R)

# INFILE & Raw Data Handling in SAS

## Objective
This project demonstrates how to read, control, and clean raw data files
using the `INFILE` statement in SAS.

It focuses on handling:
- Missing values
- Irregular records
- Different delimiters
- Partial file reads
- Complex clinical-style raw datasets

---

## Topics Covered

### 1. Handling Missing Data
- Reading missing numeric and character values
- Effects of missing raw data on DATA step processing

### 2. INFILE Options
- `MISSOVER`
- `FLOWOVER` (default behavior)
- `STOPPEDOVER`
- `TRUNCOVER`
- `FIRSTOBS=` and `OBS=`

### 3. Delimiters
- `DLM=` for custom delimiters
- Tab-delimited files (`'09'x`)
- Multiple delimiters in one program

### 4. DSD (Data-Sensitive Delimiter)
- Handling CSV files
- Treating consecutive delimiters as missing
- Removing single and double quotes automatically

### 5. Reading Portions of Raw Data
- Column pointers
- `@` line pointer control
- Selective scanning of raw data

### 6. Clinical-Style Raw Data
- Large variable lists
- Structured lab and vitals data
- Comparison of `INFILE` vs `PROC IMPORT`

---

## File
- `infile_options_demo.sas` – Complete demonstration of INFILE options

---

## How to Run
1. Open SAS.
2. Update file paths to match your local system if needed.
3. Run `infile_options_demo.sas`.
4. Inspect datasets created in the WORK library.

---

## Clinical Relevance
- Reading vendor-supplied raw text files
- Handling missing and malformed records
- Importing lab, vitals, and listing data
- Greater control than `PROC IMPORT`

---

## Author
**Himanshu Rawat**  
Clinical Programming (SAS & R)

# RETAIN Statement in SAS – Cumulative & Group Processing

## Objective
This project demonstrates the use of the **RETAIN** statement in SAS to
carry values across iterations of the DATA step.

RETAIN is a **critical concept in clinical programming**, especially for:
- Cumulative calculations
- Serial numbers
- By-group processing
- LOCF (Last Observation Carried Forward)

---

## Topics Covered

### 1. Basics of RETAIN
- Prevents variables from resetting to missing
- Retains values across DATA step iterations

### 2. Serial Number Generation
- Using `RETAIN`
- Using implicit retain (`+1`)
- Using automatic variable `_N_`

### 3. Cumulative Calculations
- Running totals
- Group-wise cumulative sums

### 4. BY-Group Processing
- `FIRST.` and `LAST.` logic
- Resetting retained variables correctly

### 5. Multiple Grouping Variables
- Handling more than one BY variable safely

### 6. Clinical Example – LOCF
- Carrying forward last non-missing lab value
- Avoiding value carryover across subjects or tests

---

## File
- `retain_statement_demo.sas` – Complete RETAIN examples

---

## How to Run
1. Open SAS.
2. Run `retain_statement_demo.sas`.
3. Review:
   - Output datasets in WORK library
   - PROC PRINT results

---

## Clinical Relevance
- Visit-wise cumulative metrics
- Subject-level summaries
- LOCF derivations (ADaM datasets)
- Preventing data leakage across subjects/tests

⚠️ **Important Warning**  
Always reset retained variables correctly when using BY groups, or values
may incorrectly carry across patients or parameters.

---

## Author
**Himanshu Rawat**  
Clinical Programming (SAS & R)

# Clinical Listing using PROC REPORT + ODS RTF

## Objective

This project demonstrates how to create a clinical-style subject listing
and export it to an RTF (Word) file using:

- DATA step
- PROC REPORT
- Titles and page setup
- ODS RTF output

This mimics real-world regulatory clinical reporting.

---

## Dataset

- ADSL (Subject-Level Analysis Dataset)
- Flags included:
  - SAFFL      → Safety Population
  - DLTEVLFL   → DLT Evaluable Population
  - PKEVLFL    → PK Evaluable Population
  - ENRLFL     → Enrolled Population

---

## Topics Covered

- Creating subject-level dataset
- Using KEEP statement
- PROC REPORT column formatting
- SPLIT option for multi-line headers
- Page orientation control
- TITLE statements (left and center justification)
- ODS RTF file generation
- Clean-up of titles and options

---

## Output

The program generates:

`l_16211_practise.rtf`

This is a Word-compatible listing file.

---

## Clinical Relevance

This type of listing is commonly found in:

- CSR (Clinical Study Report)
- 16.2.x listings
- Subject-level population summaries
- Regulatory submission outputs

---

## Author

Himanshu Rawat  
Clinical Programming (SAS & R)

# Abnormal Laboratory Listing (Macro-Driven, CSR Style)

## Objective

This project demonstrates how to generate clinical-style abnormal laboratory listings
using:

- ADLB-like dataset
- Filtering abnormal values
- Derived display variables
- Pagination logic
- PROC REPORT
- ODS RTF output
- Parameterized macro execution

This mimics real Clinical Study Report (CSR) listing programming.

---

## Dataset

ADLB-style structure including:

- USUBJID   – Subject ID
- PARCAT1   – Parameter Category
- PARAM     – Test Name
- AVISIT    – Visit
- ADT       – Analysis Date
- ANRLO     – Lower Normal Range
- ANRHI     – Upper Normal Range
- AVAL      – Result
- ANRIND    – Abnormality Flag (H/L/N)

---

## Features Implemented

### 1. Abnormal Filtering
- Excludes normal (ANRIND = "N")
- Filters by parameter category (CHEMISTRY / HEMATOLOGY)

### 2. Derived Display Variables
- Combined Normal Range
- Character Date variable
- Character Result variable

### 3. Manual Pagination Logic
- Maximum 20 lines per page
- RETAIN used for page counter
- BREAK AFTER PAGE

### 4. Macro-Driven Execution
Macro parameters:
- Category
- Listing title
- Listing number
- File tag

Allows reuse for multiple lab categories.

---

## Output

Generates RTF files:

- lab_C.rtf
- lab_H.rtf

Each containing properly paginated abnormal listings.

---

## Clinical Relevance

- CSR Section 16.2.x listings
- Abnormal laboratory value reporting
- Population safety review
- Regulatory submission formatting

---

## Author

Himanshu Rawat  
Clinical Programming (SAS & R)

# Table 14.1.1 – Subject Disposition (N and %)

## Objective

This project demonstrates how to generate a clinical summary table
showing subject counts and percentages by treatment group.

The table includes:

- Subjects Planned for Treatment
- Subjects Withdrawn

Counts are displayed as:

N (percentage)

Example:
5 (62.5%)

---

## Dataset Used

ADSL-like subject-level dataset including:

- USUBJID  – Subject ID
- TRT01A   – Treatment Name
- TRT01AN  – Treatment Number
- SAFFL    – Safety Population Flag
- EOSSTT   – End of Study Status
- DISREAS  – Discontinuation Reason

---

## Programming Steps

1. Filter Safety Population (SAFFL = "Y")
2. Create Denominator (Total N per Treatment)
3. Create Row 1 (Subjects Planned)
4. Create Row 2 (Subjects Withdrawn)
5. Merge Denominator
6. Calculate Percentage
7. Format as "N (XX.X%)"
8. Transpose Treatments to Columns
9. Generate Final Table using PROC REPORT
10. Export to RTF

---

## Output

Generates:

Table_1411.rtf

---

## Clinical Relevance

This structure is used in:

- CSR Section 14.x Tables
- Subject Disposition Summary
- Regulatory Submission Tables
- Safety Population Reporting

---

## Techniques Demonstrated

- PROC SQL aggregation
- Distinct subject counting
- Merging denominators
- Percentage calculation
- PROC TRANSPOSE for column layout
- PROC REPORT for final table
- ODS RTF export

---

## Author

Himanshu Rawat  
Clinical Programming (SAS & R)

# Table 14.1.1 – Age Summary by Treatment

## Objective

This project demonstrates how to create a clinical-style demographic
summary table showing subject counts and descriptive statistics by
treatment group.

This mimics a standard CSR baseline table.

---

## Dataset Used

ADSL-like dataset including:

- USUBJID  – Subject ID
- TRT01A   – Treatment Name
- TRT01AN  – Treatment Number
- SAFFL    – Safety Population Flag
- AGE      – Subject Age

---

## Programming Steps

1. Filter Safety Population
2. Create Denominator per Treatment
3. Generate Descriptive Statistics (N, Mean, SD, Min)
4. Calculate N (%) rows
5. Merge denominators
6. Format N (%)
7. Transpose Treatments to Columns
8. Generate RTF Table

---

## Techniques Demonstrated

- PROC SQL (denominator creation)
- PROC SUMMARY (descriptive stats)
- Percentage calculation
- PROC TRANSPOSE
- PROC REPORT
- ODS RTF output

---

## Clinical Relevance

Used in:
- Demographic summary tables
- Baseline characteristic tables
- Regulatory CSR submissions

---

## Author

Himanshu Rawat  
Clinical Programming (SAS & R)

# Table 14.1.2 – Age Summary (Continuous Variable)

## Objective

Generate a clinical-style demographics table summarizing Age by treatment group.

Statistics included:

- N
- Mean (SD)
- Median
- Minimum, Maximum

Output formatted for CSR-style table using:
- PROC SUMMARY
- Data step formatting
- PROC TRANSPOSE
- PROC REPORT
- ODS RTF

---

## Dataset

ADSL-like dataset including:
- USUBJID
- TRT01A / TRT01AN
- SAFFL
- AGE

---

## Programming Flow

1. Filter Safety Population
2. Create Denominator
3. Generate Descriptive Statistics (PROC SUMMARY)
4. Format rows:
   - N
   - Mean (SD)
   - Median
   - Min, Max
5. Stack rows
6. Transpose treatments to columns
7. Generate RTF output

---

## Clinical Relevance

Used in:
- Demographics Tables
- Baseline Characteristics
- Regulatory CSR Table 14.x

---

## Author

Himanshu Rawat  
Clinical Programming (SAS & R)

# Adverse Event Summary Table (SOC → PT)

## 📌 Objective

To generate a CSR-style Adverse Event summary table displaying:

- System Organ Class (SOC)
- Preferred Term (PT)
- Subject counts and percentages
- Treatment-wise columns

---

## 📊 Table Structure

System Organ Class  
   → Preferred Term  

Each cell displays:

N (Percentage)

---

## 🧠 Programming Concepts Used

- PROC SQL (denominator + counts)
- Distinct subject counting
- Hierarchical table structure (SOC → PT)
- Percentage calculation
- PROC TRANSPOSE
- PROC REPORT
- ODS RTF export

---

## 📂 Input Dataset

Dummy ADAE dataset with:

- USUBJID
- TRT01AN / TRT01A
- AESOC
- AEDECOD
- TRTEMFL

---

## 🚀 Output

RTF file:
`ae_summary.rtf`

---

## 📈 Clinical Relevance

This table is commonly used in:

- Clinical Study Reports (CSR)
- Safety Summaries
- Regulatory Submissions
- Phase II / Phase III studies

---

## 👨‍💻 Author

Himanshu Rawat  
Clinical SAS Programming Portfolio

# Vital Signs Summary Table (Observed & Change from Baseline)

## 📌 Objective

Generate a CSR-style Vital Signs summary table showing:

- Observed values
- Change from baseline
- Treatment group comparison
- Visit-wise statistics

Statistics Included:

- N
- Mean
- Median
- Standard Deviation
- Minimum
- Maximum

---

## 📊 Dataset Used

Dummy ADVS dataset containing:

- USUBJID
- PARAM (HEIGHT / WEIGHT)
- TRTPN / TRTP
- AVISITN / AVISIT
- AVAL (Observed value)
- CHG (Change from baseline)
- SAFFL (Safety flag)

---

## 🧠 Programming Techniques Used

- Safety population filtering
- PROC SUMMARY (dual analysis)
- Separate AVAL and CHG statistics
- Dataset merge by class variables
- Multi-level PROC REPORT columns
- ODS RTF export
- Page break by parameter

---

## 🚀 Output

RTF file:
`Vital_signs_table.rtf`

---

## 📈 Clinical Relevance

Used in:

- CSR Section 14.x
- Vital Signs Tables
- Efficacy / Safety summaries
- Regulatory submission outputs

---

## 👨‍💻 Author

Himanshu Rawat  
Clinical SAS Programming Portfolio

# Adverse Event Table (Full Hierarchy: TEAE → SOC → PT)

## 📌 Objective

Generate a CSR-style Adverse Event summary table including:

- Subjects with ≥1 TEAE
- System Organ Class (SOC)
- Preferred Term (PT)
- N (%)
- Treatment group comparison

---

## 📊 Table Structure

Subjects with ≥1 TEAE  
   → System Organ Class  
      → Preferred Term  

Each cell displays:

N (Percentage)

---

## 🧠 Programming Techniques Used

- Safety population filtering
- ADAE–ADSL merge
- Distinct subject counting
- Denominator calculation
- Hierarchical row construction
- Indentation logic
- Percentage formatting
- PROC TRANSPOSE
- PROC REPORT
- ODS RTF export

---

## 📂 Datasets

### ADSL
- USUBJID
- TRTPN / TRTP
- SAFFL

### ADAE
- USUBJID
- AEBODSYS (SOC)
- AEDECOD (PT)
- TRTEMFL

---

## 📈 Clinical Relevance

Represents CSR Section 14.x safety table:

- Required for regulatory submissions
- Used in Phase II & Phase III trials
- Core safety programming skill

---

## 👨‍💻 Author

Himanshu Rawat  
Clinical SAS Programming Portfolio

# Shift Table (Baseline → Post-Baseline Category)

## 📌 Objective

Generate a CSR-style Shift Table showing movement of subjects from:

Baseline Category → Post-Baseline Category

Categories:

- LOW
- NORMAL
- HIGH
- MISSING

---

## 📊 Table Structure

Treatment | Parameter | Baseline | LOW | NORMAL | HIGH | MISSING

Each cell represents subject count.

---

## 🧠 Programming Concepts Used

- Baseline vs Post-baseline identification
- Category variable (BNRIND / ANRIND)
- Cross-tabulation logic
- PROC FREQ / PROC SUMMARY
- PROC TRANSPOSE
- Pivot-style table generation
- PROC REPORT layout
- ODS RTF export

---

## 📂 Typical Dataset Structure (ADLB)

- USUBJID
- TRTPN
- PARAM
- AVISITN
- BNRIND (Baseline flag)
- ANRIND (Analysis category)

---

## 📈 Clinical Relevance

Shift tables are used in:

- Lab summary tables
- Safety analysis
- Regulatory CSR submissions
- Phase II & III studies

---

## 👨‍💻 Author

Himanshu Rawat  
Clinical SAS Programming Portfolio

# Time-to-Event Analysis (Overall Survival)

## 📌 Objective

Generate a CSR-style Time-to-Event (TTE) summary including:

- Kaplan–Meier Median Survival
- 95% Confidence Interval
- Log-Rank p-value
- Hazard Ratio (Cox Model)
- 95% CI for HR

---

## 📊 Analysis Performed

1. Safety population filtering (ADSL)
2. Merge with ADTTE
3. Kaplan–Meier survival analysis (PROC LIFETEST)
4. Median survival extraction
5. Log-rank p-value extraction
6. Cox proportional hazards model (PROC PHREG)
7. Hazard Ratio with CI
8. Structured RTF output

---

## 📂 Datasets Used

### ADSL
- USUBJID
- TRT01P
- SAFFL

### ADTTE
- USUBJID
- AVAL (Time)
- CNSR (Censor flag)
- PARAMCD (OS)

---

## 📈 Clinical Relevance

Time-to-event analysis is used in:

- Oncology trials
- Survival endpoints
- Regulatory submissions
- CSR Section 14.x

---

## 👨‍💻 Author

Himanshu Rawat  
Clinical SAS Programming Portfolio

# Mean ± Standard Error Plot (Error Bar Graph)

## 📌 Objective

Create a treatment comparison graph displaying:

- Mean values
- Standard Error (SE)
- Error bars (Mean ± SE)

---

## 📊 Dataset

Dummy dataset containing:

- GROUP (A, B, C)
- VALUE (numeric measurement)

---

## 🧠 Programming Techniques Used

- PROC MEANS
- Standard Error calculation
- Data step derivation
- PROC SGPLOT
- Error bar plotting (YERRORUPPER / YERRORLOWER)
- ODS Graphics

---

## 📈 Clinical Relevance

Used in:

- Efficacy summaries
- Dose comparison studies
- Clinical presentations
- Statistical reports

---

## 👨‍💻 Author

Himanshu Rawat  
Clinical SAS Programming Portfolio

# Objective Response Rate (ORR) Analysis

## 📌 Objective

To calculate Objective Response Rate (ORR) by treatment group including:

- N (%)
- Exact Binomial 95% Confidence Interval
- Risk Difference (Treatment Comparison)
- Chi-square p-value

---

## 📊 Definition

ORR = Subjects with CR or PR / Total Subjects

Where:

- CR = Complete Response
- PR = Partial Response

---

## 🧠 Programming Techniques Used

- Binary endpoint derivation
- PROC FREQ
- Exact binomial CI
- Risk difference calculation
- Chi-square test
- ODS OUTPUT extraction
- Dataset merging
- CSR-style table preparation

---

## 📈 Clinical Relevance

ORR is commonly used in:

- Oncology trials
- Phase II studies
- Regulatory submissions
- Efficacy endpoints

---

## 👨‍💻 Author

Himanshu Rawat  
Clinical SAS Programming Portfolio
