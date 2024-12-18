----Query result
select 	g.gift_name as gift_name,
		count(gr.request_id) as RequestCount,
		percent_rank() over (order by count(gr.request_id)) as Percentile
from gifts g 
join gift_requests gr 
	on g.gift_id = gr.gift_id 
group by g.gift_name
order by count(gr.request_id) desc, gift_name;

----Look at tables
select *
from gifts g;

select *
from gift_requests gr; 

-----Sample Data
DROP TABLE gifts CASCADE;
CREATE TABLE gifts (
    gift_id INT PRIMARY KEY,
    gift_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);
DROP TABLE gift_requests CASCADE;
CREATE TABLE gift_requests (
    request_id INT PRIMARY KEY,
    gift_id INT,
    request_date DATE,
    FOREIGN KEY (gift_id) REFERENCES Gifts(gift_id)
);

INSERT INTO gifts VALUES 
(1, 'Robot Kit', 89.99),
(2, 'Smart Watch', 149.99),
(3, 'Teddy', 199.99),
(4, 'Hat', 59.99);

INSERT INTO gift_requests VALUES
(1, 1, '2024-12-25'),
(2, 1, '2024-12-25'),
(3, 1, '2024-12-25'),
(4, 2, '2024-12-25'),
(5, 2, '2024-12-25'),
(6, 2, '2024-12-25'),
(7, 3, '2024-12-25'),
(8, 3, '2024-12-25'),
(9, 3, '2024-12-25'),
(10, 3, '2024-12-25'),
(11, 4, '2024-12-25'),
(12, 4, '2024-12-25'),
(13, 4, '2024-12-25'),
(14, 4, '2024-12-25'),
(15, 4, '2024-12-25');