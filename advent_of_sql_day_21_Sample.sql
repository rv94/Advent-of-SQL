----Query for problem
with cte as 
	(with quarter_Summary as 
			(	select 	*,
						EXTRACT(year from sale_date) as year,
						EXTRACT(quarter from sale_date) as quarter,
						concat(EXTRACT(year from sale_date), '0', EXTRACT(quarter from sale_date)) as Year_Quarter
				from sales)
	select 	Year_Quarter,
			lag(year_quarter) over (order by Year_Quarter) as Previous_Quarter, 
			sum(amount) as total_Sales
	from quarter_Summary
	group by 	Year_Quarter)
select 	p.*,
		o.total_sales as sales_previous_quarter,
		(p.total_sales - o.total_sales)/nullif(o.total_sales, 0) as Growth_Rate
from cte p
left join cte o
	on p.previous_quarter = o.year_quarter
order by (p.total_sales - o.total_sales)/nullif(o.total_sales, 0) desc;

----Look at table
select 	*
from sales;

----Sample Data
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO sales (sale_date, amount) VALUES ('2024-01-10', 3500.25);
INSERT INTO sales (sale_date, amount) VALUES ('2023-01-15', 1500.50);
INSERT INTO sales (sale_date, amount) VALUES ('2023-04-20', 2000.00);
INSERT INTO sales (sale_date, amount) VALUES ('2023-07-12', 2500.75);
INSERT INTO sales (sale_date, amount) VALUES ('2023-10-25', 3000.00);

