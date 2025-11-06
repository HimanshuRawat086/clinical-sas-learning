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
- Using `SASHELP` demo tables for safe exports

## Next steps
- Add QA checks (obs counts, column types).
- Add a macro to import all sheets from a workbook.
- Add a data dictionary export (via `PROC CONTENTS`).
