# SQL Practice: Employee Analytics & School Database

SQL project in two independent parts: salary, department and manager analysis on the MySQL `employees` sample database, and a small school database built from scratch.

## Task

**Part 1: Employee analytics.** Answer business questions about pay and management:
- How did the average salary change each year (before 2005)?
- What is the average salary per department, now and year by year?
- Which departments have more than 15,000 current employees?
- Who is the manager with the longest tenure?
- Who earns the most above their department's average?
- Who was the second manager ever assigned to each department?

**Part 2: School database.** Design a relational schema for teachers, courses and students, load sample data and practice finding duplicates.

## Dataset

- **Part 1:** the MySQL `employees` sample database ([datacharmer/test_db](https://github.com/datacharmer/test_db)). Tables used: `employees`, `salaries`, `departments`, `dept_emp`, `dept_manager`. The database is not included in this repo and must be loaded first.
- **Part 2:** created from scratch in the database `managment`:
  - `teachers`: name, phone
  - `courses`: name, start date, end date
  - `students`: name, email, birth date, linked to a teacher and a course via foreign keys
- Sample data is inserted in a transaction and includes a few duplicate student rows, kept on purpose for de-duplication practice.

## Approach

- **JOIN + GROUP BY**: average salary by year and by department (#1 to #3)
- **HAVING**: departments with more than 15,000 employees (#4)
- **Correlated subquery**: manager with the longest tenure (#5)
- **CTEs**: top 10 employees by salary above department average (#6)
- **Window function `ROW_NUMBER()`**: second manager of each department (#7)
- **DDL and constraints**: `CREATE DATABASE`, `CREATE TABLE`, primary and foreign keys (Part 2)
- **Transactions and `INSERT ... SELECT`**: loading and copying sample data (Part 2)

## Insight

- Average salary before 2005: [N] in [year], rising to [N] in [year]
- Highest average salary by department: [department], [N]; lowest: [department], [N]
- Departments with more than 15,000 current employees: [list], the largest is [department] with [N]
- Longest-serving manager: [name], [N] years
- Employee furthest above their department average: [name], +[N] ([department])

## Files

| File | Description |
|------|-------------|
| `Employees_SQL.sql` | Part 1: queries #1 to #7 on the `employees` DB. Part 2: school schema, sample data, `INSERT ... SELECT` test |
| `README.md` | Project description |

## How to run

1. Load the `employees` sample database (needed for Part 1 only).
2. Run blocks `#1` to `#7` one at a time; they are independent.
3. The second half of the file (from `CREATE DATABASE managment;`) is self-contained, run it top to bottom.

Requires MySQL 8.0+ or MariaDB 10.2+.

## Possible improvements

- Add `.gitignore` and `LICENSE`
- Add `schema/employees_schema.sql` so Part 1 runs without hunting for the source database
- Add an ER diagram for `teachers` / `courses` / `students`
- Add sample query results (CSV or screenshots)
