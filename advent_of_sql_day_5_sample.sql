------Trend analysis
select 	production_date,
		toys_produced,
		lag(toys_produced) over (order by production_date) as Previous_day_Production,
		toys_produced - (lag(toys_produced) over (order by production_date)) as Production_change,
		(toys_produced - (lag(toys_produced) over (order by production_date)))::float/(lag(toys_produced) over (order by production_date))::float as production_change_percentage
from toy_production t
order by (toys_produced - (lag(toys_produced) over (order by production_date)))::float/(lag(toys_produced) over (order by production_date))::float desc; 


-------------------DATA------------------
DROP TABLE IF EXISTS toy_production CASCADE;
CREATE TABLE toy_production (
    production_date DATE PRIMARY KEY,
    toys_produced INTEGER
);

INSERT INTO toy_production (production_date, toys_produced) VALUES
('2024-12-18', 500),
('2024-12-19', 550),
('2024-12-20', 525),
('2024-12-21', 600),
('2024-12-22', 580),
('2024-12-23', 620),
('2024-12-24', 610);

