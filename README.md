# 📊 SQL Practice Project — Employee Analytics & School Database

Hi! 👋 This repo is a collection of SQL practice exercises. It has **two parts**:

1. 🧮 **Smart queries** about employees — salaries, departments, and managers.
2. 🏫 **A brand-new database** for a small school — teachers, courses, and students.

No prior context needed — everything you need to know is below.

---

## 📂 What's in this repo

| File | What it is |
|---|---|
| `Employees_SQL.sql` | The main SQL file — all the queries and table setup |
| `README.md` | This guide |

---

## 🧮 Part 1: Employee Salary & Department Queries

This part answers questions about a company's employees, using a well-known practice database called `employees` (it has tables for `employees`, `salaries`, `dept_emp`, and `dept_manager`).

Here's what each query answers, in plain English:

| # | Question it answers |
|---|---|
| 1 | 💰 What was the average salary each year, before 2005? |
| 2 | 🏢 What's the average salary in each department right now? |
| 3 | 📈 How did each department's average salary change over the years? |
| 4 | 👥 Which departments have more than 15,000 employees today? |
| 5 | 🏆 Who is the manager with the most years of experience? |
| 6 | ⭐ Who are the top 10 employees earning the most *above* their department's average? |
| 7 | 🔁 Who was the *second* manager ever assigned to each department? |

You don't need to know advanced SQL to use this — just run each numbered block one at a time and read the results.

---

## 🏫 Part 2: A Simple School Database

This part builds a small database called `managment` from scratch — perfect if you want to see how tables connect to each other.

It creates 3 tables:

- 👩‍🏫 **`teachers`** — name and phone number
- 📚 **`courses`** — course name and start/end dates
- 🎓 **`students`** — name, email, birthday, and which teacher/course they belong to

It also adds some example data (teachers, courses, and students) so you can try out queries right away.

> 💡 **Heads up:** A few student rows are duplicated on purpose (or maybe by accident!) — great for practicing how to find and remove duplicate data.

---

## ▶️ How to Run This

1. First, install the `employees` sample database (needed for Part 1). Get it here → [MySQL employees sample DB](https://github.com/datacharmer/test_db)
2. Open `Employees_SQL.sql` and run the queries marked `#1` to `#7` one by one.
3. The second half of the file (starting at `CREATE DATABASE managment;`) works completely on its own — no extra setup needed.

**You'll need:** MySQL 8.0 or newer (or MariaDB 10.2+).

---

## 📌 A Few Files to Add (to make this repo complete)

| File to add | Why it helps |
|---|---|
| **`.gitignore`** | Keeps messy local files (logs, exports) out of your repo |
| **`LICENSE`** | Lets others know if/how they can reuse your code |
| **`schema/employees_schema.sql`** | So people don't have to hunt for the `employees` database structure themselves |
| **An ER diagram (image)** | A simple picture showing how `teachers`, `courses`, and `students` connect — makes the schema instantly easier to understand |
| **Sample results (`.csv` or screenshots)** *(optional)* | Lets people see what a query returns without running it |

The first two are the easiest wins. The `employees_schema.sql` one matters most — without it, Part 1 won't work for anyone else who downloads your repo.
