/************************************************************
 Project : PROC SQL in SAS
 Author  : Himanshu Rawat
 Topic   : SQL Queries, Joins, Aggregation & Advanced Logic
************************************************************/

/*===========================================================
  SECTION 1: DATASET CREATION
===========================================================*/

data employees;
  infile datalines dsd;
  input name $ age salary department_id
        hire_date :yymmdd10.
        birth_date :yymmdd10.
        gender $ manager_id;
  format hire_date birth_date yymmdd10.;
datalines;
John,28,55000,1,2015-01-01,1985-01-01,Male,.
Jane,34,65000,2,2016-01-01,1986-01-01,Female,1
Alice,29,70000,1,2016-12-31,1987-01-01,Female,1
Bob,40,80000,3,2017-12-31,1988-01-01,Male,3
Charlie,37,45000,2,2018-12-31,1988-12-31,Male,2
David,25,62000,3,2019-12-31,1989-12-31,Male,3
Eva,32,73000,1,2020-12-30,1990-12-31,Female,1
Frank,30,54000,2,2021-12-30,1991-12-31,Male,2
Grace,26,50000,1,2022-12-30,1992-12-30,Female,1
Hannah,35,68000,3,2023-12-30,1993-12-30,Female,3
;
run;

data departments;
  infile datalines dsd;
  input department_id department $ location $;
datalines;
1,HR,New York
2,Sales,Los Angeles
3,IT,New York
4,Finance,Chicago
;
run;

data contractors;
  infile datalines dsd;
  input name $ salary department_id;
datalines;
John,70000,1
Helen,72000,2
Ian,68000,3
Jake,75000,2
;
run;

data sales;
  infile datalines dsd;
  input name $ q1_sales q2_sales q3_sales q4_sales;
datalines;
John,10000,12000,13000,14000
Jane,15000,16000,17000,18000
Alice,20000,21000,22000,23000
;
run;

data sales_data;
  infile datalines dsd;
  length product_category $9;
  input product_category $ year sales;
datalines;
CategoryA,2021,50000
CategoryB,2021,60000
CategoryC,2021,70000
CategoryA,2022,80000
CategoryB,2022,90000
CategoryC,2022,100000
;
run;

/*===========================================================
  SECTION 2: BASIC SQL QUERIES
===========================================================*/

proc sql;
  select * from employees;
quit;

proc sql;
  select name, age, salary
  from employees
  where age > 30;
quit;

proc sql;
  select distinct department_id
  from employees;
quit;

/*===========================================================
  SECTION 3: JOINS
===========================================================*/

proc sql;
  select a.name, a.salary, b.department
  from employees as a
  inner join departments as b
  on a.department_id = b.department_id;
quit;

proc sql;
  select a.name, a.salary, b.department
  from employees as a
  left join departments as b
  on a.department_id = b.department_id;
quit;

/*===========================================================
  SECTION 4: SUBQUERIES & AGGREGATION
===========================================================*/

proc sql;
  select name, salary
  from employees
  where salary > (select avg(salary) from employees);
quit;

proc sql;
  select department_id,
         count(*) as Emp_Count,
         avg(salary) as Avg_Salary
  from employees
  group by department_id
  having count(*) > 3;
quit;

/*===========================================================
  SECTION 5: UPDATES & DELETES
===========================================================*/

proc sql;
  update employees
  set salary = salary * 2;
quit;

proc sql;
  delete from employees
  where salary < 120000;
quit;

/*===========================================================
  SECTION 6: VIEWS & INDEXES
===========================================================*/

proc sql;
  create view high_earners as
  select name, salary
  from employees
  where salary > 50000;
quit;

/*===========================================================
  SECTION 7: ADVANCED SQL
===========================================================*/

proc sql;
  select name,
         case
           when salary < 50000 then 'Low'
           when salary between 50000 and 70000 then 'Medium'
           else 'High'
         end as Salary_Range
  from employees;
quit;

proc sql;
  select department_id,
         sum(case when gender='Male' then 1 else 0 end) as Males,
         sum(case when gender='Female' then 1 else 0 end) as Females
  from employees
  group by department_id;
quit;

/************************************************************
 End of PROC SQL Demo
************************************************************/
