-- 1
SELECT employees.emp_no, employees.first_name, employees.last_name,
titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY employees.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT(title) DESC;

-- Retrieve the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name,  
emp.birth_date, dept.from_date, dept.to_date, title
INTO mentorship_eligibilty
FROM employees as emp
LEFT JOIN dept_emp as dept
ON (emp.emp_no = dept.emp_no)
INNER JOIN titles
ON emp.emp_no = titles.emp_no
WHERE (dept.to_date = '9999-01-01') AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;