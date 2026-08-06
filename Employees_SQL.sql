#1
SELECT AVG(salary) AS avg_salary,
YEAR(from_date) AS year_number
FROM salaries
WHERE from_date < '2005-01-01'
GROUP BY YEAR(from_date)
ORDER BY year_number;
#2 
SELECT dept_no, AVG(salary) AS avg_salary
FROM salaries s
INNER JOIN dept_emp de ON s.emp_no=de.emp_no
WHERE CURDATE() BETWEEN s.from_date AND s.to_date
AND CURDATE() BETWEEN de.from_date AND de.to_date
GROUP BY dept_no;
#3
SELECT de.dept_no, AVG(s.salary) AS avg_salary,
YEAR(s.from_date) AS year_number
FROM salaries s
INNER JOIN dept_emp de ON s.emp_no=de.emp_no
WHERE s.from_date BETWEEN de.from_date AND de.to_date
GROUP BY YEAR(s.from_date) , de.dept_no
ORDER BY de.dept_no,year_number;
#4
SELECT dept_no, 
COUNT(de.emp_no) AS count_emp
FROM dept_emp de 
WHERE CURDATE() BETWEEN de.from_date AND de.to_date
GROUP BY dept_no
HAVING COUNT(de.emp_no)>15000;
#5
SELECT dm.emp_no, dm.dept_no, em.hire_date, em.last_name,
TIMESTAMPDIFF(DAY,hire_date,CURDATE()) AS work_experience_days
FROM dept_manager dm 
INNER JOIN employees em ON dm.emp_no=em.emp_no
WHERE CURDATE() BETWEEN dm.from_date AND dm.to_date
AND TIMESTAMPDIFF(DAY, em.hire_date, CURDATE()) = 
(SELECT MAX(TIMESTAMPDIFF(DAY, e.hire_date, CURDATE()))
FROM dept_manager dm2
INNER JOIN employees e ON dm2.emp_no = e.emp_no
WHERE CURDATE() BETWEEN dm2.from_date AND dm2.to_date)
ORDER BY work_experience_days DESC;
#6
WITH emp_salary AS (SELECT de.emp_no, dept_no, salary
FROM salaries s
INNER JOIN dept_emp de ON s.emp_no=de.emp_no
WHERE CURDATE() BETWEEN s.from_date AND s.to_date
AND CURDATE() BETWEEN de.from_date AND de.to_date),
dept_avg AS (SELECT dept_no, AVG(s.salary) AS avg_salary
FROM salaries s
INNER JOIN dept_emp de ON s.emp_no=de.emp_no
WHERE CURDATE() BETWEEN s.from_date AND s.to_date
AND CURDATE() BETWEEN de.from_date AND de.to_date
GROUP BY dept_no)
SELECT es.emp_no, es.dept_no,
es.salary, da.avg_salary,
(es.salary - da.avg_salary) AS diff_sal
FROM dept_avg da
INNER JOIN emp_salary es ON da.dept_no=es.dept_no
ORDER BY diff_sal DESC
LIMIT 10;
#7
WITH ranked_managers AS (
SELECT dept_no,
last_name,first_name, 
hire_date,from_date,
ROW_NUMBER() OVER (PARTITION BY dept_no ORDER BY from_date) AS number_man
FROM dept_manager
INNER JOIN employees e USING(emp_no))
SELECT dept_no,
last_name,first_name,
hire_date,from_date AS hire_date_as_manager
FROM ranked_managers
WHERE number_man = 2;

CREATE DATABASE managment;
SHOW DATABASES;
USE managment;
CREATE TABLE IF NOT EXISTS teachers
(teacher_no INT AUTO_INCREMENT PRIMARY KEY,
 teacher_name VARCHAR(100) NOT NULL,
 phone_no VARCHAR(100) NOT NULL);
DESC teachers;
CREATE TABLE IF NOT EXISTS courses
(course_no INT AUTO_INCREMENT PRIMARY KEY, 
course_name VARCHAR(100) NOT NULL, 
start_date DATE NOT NULL,
end_date DATE NOT NULL);
DESC courses;
CREATE TABLE IF NOT EXISTS students (
student_no INT AUTO_INCREMENT PRIMARY KEY, 
teacher_no INT NOT NULL, 
course_no INT NOT NULL, 
student_name VARCHAR(100) NOT NULL, 
email TEXT NOT NULL, 
birth_date DATE NOT NULL,
FOREIGN KEY (teacher_no) REFERENCES teachers(teacher_no),
FOREIGN KEY (course_no) REFERENCES courses(course_no));
DESC students;
START TRANSACTION;
INSERT INTO teachers (teacher_name, phone_no) VALUES 
('Соломія Петренко', '068-123-4567'),
('Марія Шевченко', '096-765-4321'),
('Олег Гавчак', '050-987-6543'),
('Вероніка Лимар', '063-115-2133'),
('Андрій Пелещишин', '073-434-5567'),
('Максим Кравчук', '096-777-8869'),
('Юрій Мельник', '068-987-4511');
INSERT INTO courses (course_name, start_date, end_date) VALUES 
('SQL для початківців', '2024-01-10', '2024-03-10'),
('Python', '2024-02-01', '2024-04-15'),
('PowerBI з нуля', '2025-03-01', '2025-05-30'),
('Excel за місяць', '2023-04-01', '2023-06-15'),
('Найпоширеніші запити у Python', '2022-05-01', '2022-07-20'),
('Tableau', '2021-06-01', '2021-08-30'),
('SQL для бізнесу', '2020-07-01', '2020-09-15');
INSERT INTO students (teacher_no, course_no, student_name, email, birth_date) VALUES 
(1, 1, 'Олена Тузяк', 'olena.tysak@example.com', '2000-05-15'),
(1, 2, 'Марія Бондар', 'maria.bondar@example.com', '1999-11-20'),
(2, 1, 'Наталія Лисенко', 'natalia.lysenko@example.com', '2001-02-10'),
(2, 3, 'Дмитро Кривоніс', 'dmytro.cryvo@example.com', '2000-08-25'),
(3, 2, 'Катерина Мороз', 'kateryna.moroz@example.com', '1998-12-05'),
(3, 4, 'Вікторія Кравченко', 'viktoria.kravchenko@example.com', '2002-03-17'),
(4, 5, 'Максим Шевчук', 'maksym.shevchuk@example.com', '1999-07-22'),
(5, 6, 'Ірина Молода', 'iryna.tk@example.com', '2001-09-30'),
(6, 7, 'Роман Даниленко', 'roman.danylenko@example.com', '2000-12-12'),
(7, 1, 'Анна Гончар', 'anna.gonchar@example.com', '1998-04-18'),
(1, 1, 'Олена Коваленко', 'olena.kovalenko@example.com', '2000-05-15'),
(1, 1, 'Олена Коваленко', 'olena.kovalenko@example.com', '2000-05-15'),
(1, 1, 'Олена Коваленко', 'olena.kovalenko@example.com', '2000-05-15');
COMMIT;
INSERT INTO students (teacher_no, course_no, student_name, email, birth_date)
SELECT teacher_no, course_no, student_name, email, birth_date
FROM students
LIMIT 3;