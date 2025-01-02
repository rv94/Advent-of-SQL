----Sample query
with cte as (
		select 	w.*,
				w.business_start_time - tn.utc_offset as business_start_time_utc,
				w.business_end_time - tn.utc_offset as business_end_time_utc
		from workshops w
		join pg_timezone_names tn
			on w.timezone = tn.name
		order by 1
		limit 100)
select 	max(business_start_time_utc) as Time_window_beginning,
		min(business_end_time_utc) as Time_window_end
from cte;

----Look at table
select *
from workshops w;

select *
FROM pg_timezone_names;

----Sample data
CREATE TABLE Workshops (
    workshop_id INT PRIMARY KEY,
    workshop_name VARCHAR(100),
    timezone VARCHAR(50),
    business_start_time TIME,
    business_end_time TIME
);

INSERT INTO Workshops (workshop_id, workshop_name, timezone, business_start_time, business_end_time) VALUES
(1, 'North Pole HQ', 'UTC', '09:00', '17:00'),
(2, 'London Workshop', 'Europe/London', '09:00', '17:00'),
(3, 'New York Workshop', 'America/New_York', '09:00', '17:00');