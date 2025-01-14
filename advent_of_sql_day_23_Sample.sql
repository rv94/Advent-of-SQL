----Look at data
select *
from sequence_table;

----Sample data
drop table if exists sequence_table;
CREATE TABLE sequence_table (
    id INT PRIMARY KEY
);

INSERT INTO sequence_table (id) VALUES 
    (1),
    (2),
    (3),
    (7),
    (8),
    (9),
    (11),
    (15),
    (16),
    (17),
    (22);