-- MVP

-- Q1 Find the first name, last name and team name of employees who are members of teams
SELECT e.first_name, e.last_name, t.name
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id;

-- Q1 (b). Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.
SELECT e.first_name, e.last_name, t.name
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
WHERE e.pension_enrol = TRUE;

-- Q1 (c). Find the first name, last name and team name of employees who are members of teams, where their team has a charge cost greater than 80.
SELECT e.first_name, e.last_name, t.name
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
WHERE CAST(t.charge_cost AS int) > 80;


-- Q2 Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.
SELECT e.*, p.local_account_no, p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;

-- Q2 (b). Amend your query above to also return the name of the team that each employee belongs to.
SELECT e.*,
	p.local_account_no,
	p.local_sort_code,
	t.name
FROM (employees AS e LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id) FULL JOIN teams AS t
ON e.team_id = t.id;

-- Q3 (a). Make a table, which has each employee id along with the team that employee belongs to.
SELECT e.id, t.name 
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id

-- Q3 (b). Breakdown the number of employees in each of the teams.\
SELECT t.name, COUNT(e.id)
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name

-- (c) . Order the table above by so that the teams with the least employees come first.
SELECT t.name, COUNT(e.id)
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name
ORDER BY count ASC

-- Q4 (a). Create a table with the team id, team name and the count of the number of employees in each team.
SELECT t.id AS team_id, t.name AS team_name, COUNT (e.id) AS employee_count
FROM teams AS t INNER JOIN employees AS e
ON t.id  = e.team_id 
GROUP BY t.id

-- Q4 (b). The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. Calculate the total_day_charge for each team. 
SELECT t.id AS team_id,
		t.name AS team_name,
		COUNT (e.id) AS employee_count,
		CAST(charge_cost AS int) * COUNT(e.id) AS total_day_charge
FROM teams AS t INNER JOIN employees AS e
ON t.id  = e.team_id 
GROUP BY t.id

-- Q4 (c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000?
SELECT * 
FROM (SELECT t.id AS team_id,
		t.name AS team_name,
		COUNT (e.id) AS employee_count,
		CAST(charge_cost AS int) * COUNT(e.id) AS total_day_charge
FROM teams AS t INNER JOIN employees AS e
ON t.id  = e.team_id
GROUP BY t.id) AS apples
WHERE apples.total_day_charge > 5000

