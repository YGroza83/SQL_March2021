CREATE TABLE titles (
  title_id varchar(5) PRIMARY KEY,
  title VARCHAR(30) NOT NULL
);

CREATE TABLE employees (
  emp_no int PRIMARY KEY,
  emp_title VARCHAR(5) NOT NULL,
  FOREIGN KEY (emp_title) REFERENCES titles(title_id),
  birth_date date not null,
  first_name varchar(30) not null,
  last_name varchar(30) not null,
  sex varchar(1) not null,
  CHECK (sex in ('M','F')),
  hire_date date not null
);

CREATE TABLE salaries (
  emp_no int PRIMARY KEY,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  salary int not null
);

CREATE TABLE departments (
  dept_no varchar(4) PRIMARY KEY,
  dept_name varchar(30) not null
);

CREATE TABLE dept_manager (
  dept_no varchar(4),
  emp_no int not null,
  PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE dept_manager (
  dept_no varchar(4),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  emp_no int not null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE dept_emp (
  emp_no int,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  dept_no varchar(4) not null,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  PRIMARY KEY (emp_no, dept_no)
);

-- 1 List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM salaries
INNER JOIN employees ON employees.emp_no=salaries.emp_no;

-- 2 List first name, last name, and hire date for employees who were hired in 1986.
Select first_name, last_name, hire_date
From employees
where hire_date >= '1986-1-1' and hire_date <= '1986-12-31'

-- 3 List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
INNER JOIN dept_manager ON departments.dept_no=dept_manager.dept_no
INNER JOIN employees ON employees.emp_no=dept_manager.emp_no;

-- 4 List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON departments.dept_no=dept_emp.dept_no;

-- 5 List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
from employees
where first_name = 'Hercules' and LEFT (last_name, 1) = 'B'

-- 6 List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name = 'Sales';

-- 7 List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name = 'Sales' or departments.dept_name = 'Development';

-- 8 In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "last_name_count"
FROM employees
GROUP BY last_name
ORDER BY "last_name_count" DESC;