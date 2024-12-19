-----Look at records
with cte as (select *,
					jsonb_array_elements(cleaning_receipts)->>'color' as color,
					jsonb_array_elements(cleaning_receipts)->>'garment' as garment,
					jsonb_array_elements(cleaning_receipts)->>'drop_off' as Drop_off
			from SantaRecords
			where 1=1)
select *
from cte
where 1=1
and garment = 'suit'
and color = 'green';

-----Sample Data
CREATE TABLE SantaRecords (
    record_id INT PRIMARY KEY,
    record_date DATE,
    cleaning_receipts JSONB
);

INSERT INTO SantaRecords (record_id, record_date, cleaning_receipts) VALUES 
(1, '2024-11-25', '[
    {
        "receipt_id": "R120",
        "garment": "hat",
        "color": "red",
        "cost": 15.99,
        "drop_off": "2024-11-25",
        "pickup": "2024-11-27"
    },
    {
        "receipt_id": "R121",
        "garment": "mittens",
        "color": "white",
        "cost": 12.99,
        "drop_off": "2024-11-25",
        "pickup": "2024-11-27"
    }
]');

INSERT INTO SantaRecords (record_id, record_date, cleaning_receipts) VALUES 
(2, '2024-12-01', '[
    {
        "receipt_id": "R122",
        "garment": "suit",
        "color": "red",
        "cost": 25.99,
        "drop_off": "2024-12-01",
        "pickup": "2024-12-03"
    },
    {
        "receipt_id": "R123",
        "garment": "boots",
        "color": "black",
        "cost": 18.99,
        "drop_off": "2024-12-01",
        "pickup": "2024-12-03"
    }
]');

-- Here's the record with the green suit
INSERT INTO SantaRecords (record_id, record_date, cleaning_receipts) VALUES 
(3, '2024-12-10', '[
    {
        "receipt_id": "R124",
        "garment": "suit",
        "color": "green",
        "cost": 29.99,
        "drop_off": "2024-12-10",
        "pickup": "2024-12-12"
    },
    {
        "receipt_id": "R125",
        "garment": "scarf",
        "color": "green",
        "cost": 10.99,
        "drop_off": "2024-12-10",
        "pickup": "2024-12-12"
    }
]');