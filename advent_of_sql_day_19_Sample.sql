----Sample query
with cte as (select employee_id,
					name,
					salary,
					year_End_performance_Scores[array_length(year_end_performance_Scores, 1)] as Last_Score,	----Extract last element of the array
					AVG(year_End_performance_Scores[array_length(year_end_performance_Scores, 1)]) over () as Average_Score
			from employees)
select 	*,
		case 	when last_Score > Average_Score then 1.15 * salary
				else salary end as Salary_Final,
		sum(case 	when last_Score > Average_Score then 1.15 * salary
					else salary end) over () as Total_Salary_Final
from cte;

----Look at data
select *
from employees;

----Sample data
drop table if exists employees;
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    year_end_performance_scores INTEGER[] NOT NULL
);

INSERT INTO employees (name, salary, year_end_performance_scores) VALUES
('Alice Johnson', 75000.00, ARRAY[85, 90, 88, 92]),
('Bob Smith', 68000.00, ARRAY[78, 82, 80, 81]),
('Charlie Brown', 72000.00, ARRAY[91, 89, 94, 96]),
('Dana White', 64000.00, ARRAY[70, 75, 73, 72]),
('Eliot Green', 70000.00, ARRAY[88, 85, 90, 87]);