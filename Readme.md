# SQL Practice: Employees Analytics & School Database

SQL practice project in two independent parts: salary and tenure analysis on the MySQL `employees` sample database, and a small school database built from scratch.

## Task

**Part 1: Employees analytics.** Answer business questions about pay and management:
- How does the average salary change over time and across departments?
- Which departments are the largest (more than 15,000 current employees)?
- Who is the longest-serving manager?
- Who earns the most above their department's average?
- Who was the second manager in each department's history?

**Part 2: School database.** Design a relational schema for teachers, courses and students, load sample data safely and practice data cleaning (de-duplication).

## Dataset

- **Part 1:** the classic MySQL `employees` sample database ([datacharmer/test_db](https://github.com/datacharmer/test_db)). It is not included in this repo and must be loaded first.
- **Part 2:** created from scratch in the database `managment` (the typo is kept on purpose, it matches the file):
  - `teachers`: name, phone
  - `courses`: name, start date, end date
  - `students`: name, email, birth date, linked to a teacher and a course via foreign keys
- Sample data is inserted inside a transaction. It includes 3 deliberate duplicate rows (`Олена Коваленко` x3) for later de-duplication practice.

## Approach

- **JOIN + GROUP BY**: average salary by year and by department, department headcount (queries #1 to #4)
- **HAVING**: filter departments with more than 15,000 people (#4)
- **Correlated subquery**: the longest-serving manager (#5)
- **CTEs (two)**: employees earning the most above their department average, top 10 (#6)
- **Window function `ROW_NUMBER()`**: the second manager of each department (#7)
- **DDL**: `CREATE DATABASE`, `CREATE TABLE`, primary and foreign keys (Part 2)
- **Transactions**: sample data inserted in one transaction
- **`INSERT ... SELECT`**: copying existing students into 3 new rows

## Insight

- Average salary before 2005: [N], growing from [N] to [N] by year
- Highest average department salary: [department], [N]; lowest: [department], [N]
- Departments with more than 15,000 current employees: [list], largest is [department] with [N]
- Longest-serving manager: [name], since [date] ([N] years)
- Biggest gap above department average: [name], +[N] ([department])

## Files

| File | Description |
|------|-------------|
| `[filename].sql` | Part 1: queries #1 to #7 on the `employees` DB. Part 2: school schema, sample data, `INSERT ... SELECT` test |
| `README.md` | Project description |

## How to run

1. Load the `employees` sample database (needed for Part 1 only).
2. Run blocks `#1` to `#7` one at a time; they are independent.
3. Everything from `CREATE DATABASE managment;` onward is self-contained, run it top to bottom.

Tested on MySQL 8.0. Should also work on MariaDB 10.2+ (uses only CTEs and `ROW_NUMBER()`).

## Possible improvements

- Add a `.gitignore` and a license
- Include the `employees` schema or a more prominent link to it
- Add an ER diagram for `teachers` / `courses` / `students`
- Simplify the correlated subquery in #5
