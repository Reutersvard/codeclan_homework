-- MVP

-- Q1
WITH t1 AS (SELECT *
FROM employees
WHERE salary IS NULL AND grade IS NULL)
SELECT COUNT(id)
FROM t1;

-- Q2
SELECT
	CONCAT (first_name, ' ',last_name) AS name,
	department 
FROM employees
ORDER BY department, last_name;

-- Q3
SELECT *
FROM employees
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLS LAST
LIMIT 10;

-- Q4
SELECT
COUNT(*),
department 
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

-- Q5
SELECT COUNT(*) AS num_employees, department, fte_hours 
FROM employees
GROUP BY department, fte_hours
ORDER BY fte_hours;

-- Q6
SELECT pension_enrol, COUNT(*)
FROM employees
GROUP BY pension_enrol;

-- Q7
SELECT *
FROM employees 
WHERE pension_enrol IS FALSE AND department = 'Accounting'
ORDER BY salary DESC NULLS LAST
LIMIT 1;

-- Q8
SELECT country, COUNT(id) AS num_employees, ROUND(AVG(salary)) AS av_salary
FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY av_salary DESC;

-- Q9
SELECT first_name, last_name, fte_hours, salary,
		fte_hours * salary AS effective_yearly_salary
FROM employees
WHERE fte_hours * salary > 30000;

-- Q10
SELECT *
FROM employees
WHERE team_id IN (SELECT id FROM teams WHERE name LIKE 'Data Team%');

-- Q11
SELECT first_name, last_name
FROM employees
WHERE pay_detail_id IN (SELECT id FROM pay_details WHERE local_tax_code IS NULL);

-- Q12
SELECT (48 * 35 * CAST(t.charge_cost AS INT) - e.salary) * e.fte_hours AS expected_profit,
e.id AS employee_id,
e.first_name, e.last_name
FROM teams AS t INNER JOIN employees AS e ON t.id = e.team_id
ORDER BY expected_profit;

-- Q13
WITH fte_count AS (
	SELECT fte_hours, COUNT(*) AS count FROM employees GROUP BY fte_hours
),
min_fte_count AS (
    SELECT MIN(count) AS min_count FROM fte_count
),
most_common_fte AS (
    SELECT fte_hours FROM fte_count WHERE count = (SELECT min_count FROM min_fte_count)
)
SELECT first_name, last_name, salary, fte_hours
FROM employees
WHERE country = 'Japan' AND fte_hours IN (SELECT fte_hours FROM most_common_fte)
ORDER BY salary
LIMIT 1;

-- Q14
SELECT COUNT(*), department 
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, department;

-- Q15
SELECT COUNT(id), first_name
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING COUNT(id) > 1
ORDER BY COUNT(id) DESC, first_name;

-- Q16
WITH table1 AS (SELECT COUNT(*), department, grade
	FROM employees
	WHERE grade IS NOT NULL
	GROUP BY department, grade
	ORDER BY department),
table2 AS (SELECT COUNT(*) AS total_count, department 
	FROM employees
	WHERE grade IS NOT NULL 
	GROUP BY department
	ORDER BY department)
SELECT table1.department,
table1.count,
table2.total_count,
CAST(table1.count AS REAL) / CAST(table2.total_count AS REAL) AS proportion
FROM table1 LEFT JOIN table2
ON table1.department = table2.department
WHERE table1.grade = 1
ORDER BY proportion DESC