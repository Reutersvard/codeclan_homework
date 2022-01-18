/* MVP */

/* Q1 */
SELECT *
FROM employees
WHERE department = 'Human Resources';

/* Q2 */
SELECT first_name, last_name, country
FROM employees
WHERE department = 'Legal';

/* Q3 */
SELECT 
  COUNT(*) 
FROM employees 
WHERE country = 'Portugal';

/* Q4 */
SELECT 
  COUNT(*) 
FROM employees 
WHERE country = 'Spain' OR country = 'Portugal';


/* Q5 */
SELECT 
  COUNT(*) 
FROM pay_details 
WHERE local_account_no IS NULL; 

/* Q6 */
SELECT
COUNT(*)
FROM pay_details 
WHERE local_account_no IS NULL AND iban IS NULL;

/* Q7 */
SELECT first_name, last_name 
FROM employees
ORDER BY last_name NULLS LAST; 

/* Q8 */
SELECT first_name, last_name, country 
FROM employees
ORDER BY country, last_name;

/* Q9 */
SELECT * 
FROM employees 
ORDER BY salary
LIMIT 10;

/* Q10 */
SELECT first_name, last_name, salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary ASC
LIMIT 1;

/* Q11 */
SELECT
COUNT(*)
FROM employees 
WHERE first_name LIKE 'F%';

/* Q12 */
SELECT * 
FROM employees
WHERE ema	il LIKE '%yahoo%';

/* Q13 */
SELECT
COUNT(*)
FROM employees
WHERE pension_enrol IS TRUE
AND country != 'Germany'
AND country != 'France'; 


/* Q14 */
SELECT 
MAX(salary)
FROM employees 
WHERE department = 'Engineering'
AND fte_hours = 1;

/* Q15 */
SELECT first_name, last_name, fte_hours, salary, 
(fte_hours * salary) AS effective_yearly_salary 
FROM employees