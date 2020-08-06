-- DELIVERABLE 1

CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no, title, from_date)
);

SELECT * FROM employees;
SELECT * FROM titles;

SELECT emp_no, first_name, last_name
FROM employees;
SELECT title, from_date, to_date
FROM titles;

DROP TABLE retirement_titles CASCADE;

SELECT emp_no,
        first_name, 
        last_name
INTO retirementX_titles
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * FROM retirementX_titles

SELECT retirementX_titles.emp_no,
        retirementX_titles.first_name,
		retirementX_titles.last_name,
		titles.title,
		titles.from_date,
		titles.to_date
INTO retirement_titles
FROM retirementX_titles
LEFT JOIN titles
ON retirementX_titles.emp_no = titles.emp_no
ORDER BY emp_no;
SELECT * FROM retirement_titles

DROP TABLE unique_titles
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, from_date DESC;
SELECT * FROM unique_titles

DROP TABLE retiring_titles
-- Number of titles retiring
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;
SELECT * FROM retiring_titles




-- DELIVERABLE 2

SELECT * FROM employees 

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE dept_employees (
  emp_no INT NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM dept_employees 

SELECT emp_no, 
        first_name, 
        last_name,
		birth_date
INTO table1
FROM employees
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31');
SELECT * FROM table1

SELECT table1.emp_no,
        table1.first_name,
		table1.last_name,
		table1.birth_date,
		dept_employees.from_date,
		dept_employees.to_date,
		titles.title
INTO table2
FROM table1
INNER JOIN titles
ON table1.emp_no = titles.emp_no
INNER JOIN dept_employees
ON table1.emp_no = dept_employees.emp_no
ORDER BY emp_no;
SELECT * FROM table2

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
birth_Date,
from_date,
to_date,
title
INTO mentorship_eligibility
FROM table2
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, from_date DESC;
SELECT * FROM mentorship_eligibility





