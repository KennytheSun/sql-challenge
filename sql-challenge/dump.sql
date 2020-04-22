-- Create the required tables then import the csv files to the corresponding tables
create table employees (
	emp_no varchar primary key,
	birth_date varchar,
	first_name varchar,
	last_name varchar,
	gender varchar,
	hire_date varchar
);

create table departments(
	dept_no varchar primary key,
	dept_name varchar
);

create table dept_manager (
	dept_no varchar,
	foreign key (dept_no) references departments(dept_no),
	emp_no varchar,
	foreign key (emp_no) references employees(emp_no),
	from_date varchar,
	to_date varchar
);

create table dept_emp(
	emp_no varchar,
	foreign key (emp_no) references employees(emp_no),	
	dept_no varchar,
	foreign key (dept_no) references departments(dept_no),
	from_date varchar,
	to_date varchar
);

create table titles(
	emp_no varchar,
	foreign key (emp_no) references employees(emp_no),
	title varchar,
	from_date varchar,
	to_date varchar
);

create table salaries(
	emp_no varchar,
	foreign key (emp_no) references employees(emp_no),
	salary varchar,
	from_date varchar,
	to_date varchar
);

--List the following details of each employee: employee number, last name, first name, gender, and salary.
select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
from employees 
inner join salaries
on employees.emp_no = salaries.emp_no

--List employees who were hired in 1986
select emp_no, hire_date 
from employees
where hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number,
--last name, first name, and start and end employment dates.
select * from dept_manager
select * from employees
select * from departments

select dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
from dept_manager
inner join employees
on dept_manager.emp_no = employees.emp_no
inner join departments
on dept_manager.dept_no = departments.dept_no

-- List the department of each employee with the following information: employee number, 
-- last name, first name, and department name
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join dept_emp
on dept_emp.emp_no = employees.emp_no
inner join departments
on departments.dept_no = dept_emp.dept_no

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name AS "LAST NAME",
COUNT(last_name) AS "FREQUENCY COUNT OF EMPLOYEE LAST NAMES"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;


