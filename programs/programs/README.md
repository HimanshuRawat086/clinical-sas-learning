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
