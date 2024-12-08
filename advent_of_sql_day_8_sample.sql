----------------Generate chain
----Table
select *
from staff;

----Chain of command
WITH RECURSIVE employee_hierarchy AS (
	----CEO Level
	SELECT  staff_id,
	        staff_name,
	        manager_id,
	        1 as level,
	        ARRAY[staff_id] AS path
	from staff
	where 1=1
	and manager_id IS null
	
	UNION all
	
	----All other employees
	SELECT      e.staff_id,
		        e.staff_name,
		        e.manager_id,
		        h.level + 1 as level,
		        h.path || e.staff_id as path
	FROM staff e
	JOIN employee_hierarchy h 
		ON e.manager_id = h.staff_id
	)

select 	staff_id,
	    staff_name,
	    level,
	    path::text
FROM employee_hierarchy
order by level desc;

-----------------Sample Data
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Staff(staff_id)
);

INSERT INTO staff (staff_id, staff_name, manager_id) VALUES
    (1, 'Santa Claus', NULL),                -- CEO level
    (2, 'Head Elf Operations', 1),           -- Department Head
    (3, 'Head Elf Logistics', 1),            -- Department Head
    (4, 'Senior Toy Maker', 2),              -- Team Lead
    (5, 'Senior Gift Wrapper', 2),           -- Team Lead
    (6, 'Inventory Manager', 3),             -- Team Lead
    (7, 'Junior Toy Maker', 4),              -- Staff
    (8, 'Junior Gift Wrapper', 5),           -- Staff
    (9, 'Inventory Clerk', 6),               -- Staff
    (10, 'Apprentice Toy Maker', 7);         -- Entry Level