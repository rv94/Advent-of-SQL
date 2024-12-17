----Look at table
with th as (select 	*,
					case season 
						when 'Spring' then 1
						when 'Summer' then 2
						when 'Fall' then 3
						when 'Winter' then 4 end as season_id
			from TreeHarvests)
select 	*,
		avg(trees_harvested) over (	partition by field_name
									ORDER BY season_id rows between 2 PRECEDING AND CURRENT ROW)
from th
order by avg(trees_harvested) over (	partition by field_name
										ORDER BY season_id rows between 2 PRECEDING AND CURRENT ROW) desc;


------Sample data
CREATE TABLE TreeHarvests (
    field_name VARCHAR(50),
    harvest_year INT,
    season VARCHAR(6),
    trees_harvested INT
);

INSERT INTO TreeHarvests VALUES
('Rudolph Ridge', 2023, 'Spring', 150),
('Rudolph Ridge', 2023, 'Summer', 180),
('Rudolph Ridge', 2023, 'Fall', 220),
('Rudolph Ridge', 2023, 'Winter', 300),
('Dasher Dell', 2023, 'Spring', 165),
('Dasher Dell', 2023, 'Summer', 195),
('Dasher Dell', 2023, 'Fall', 210),
('Dasher Dell', 2023, 'Winter', 285);