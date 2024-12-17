-----Drinks by date
select 	date,
		sum(case 	when drink_name = 'Eggnog' then quantity
					else 0 end) as eggnog,
		sum(case 	when drink_name = 'Hot Cocoa' then quantity
					else 0 end) as hot_cocoa,
		sum(case 	when drink_name = 'Peppermint Schnapps' then quantity
					else 0 end) as peppermint_schnapps
from drinks
group by date
order by date;

----Table
select *
from drinks d;

-----Sample data
DROP TABLE IF EXISTS Drinks CASCADE;
CREATE TABLE Drinks (
    drink_id SERIAL PRIMARY KEY,
    drink_name VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    quantity INTEGER NOT NULL
);

INSERT INTO Drinks (drink_name, date, quantity) VALUES
    ('Eggnog', '2024-12-24', 50),
    ('Eggnog', '2024-12-25', 60),
    ('Hot Cocoa', '2024-12-24', 75),
    ('Hot Cocoa', '2024-12-25', 80),
    ('Peppermint Schnapps', '2024-12-24', 30),
    ('Peppermint Schnapps', '2024-12-25', 40);