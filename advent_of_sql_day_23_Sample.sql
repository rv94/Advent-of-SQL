----Code
with st as (
			with t as (	select 	id,
								row_number() over (order by id) as Row_Sequence,
								(row_number() over (order by id)) - id as sequence_difference
						from sequence_table)
			select 	*,
					lag(sequence_difference, 1) over (order by id) as seq_diff_prev,
					case 	when lag(sequence_difference, 1) over (order by id) = sequence_difference then 'No'
							else 'Yes' end as Does_Diff_Exist
			from t
			)
select 	*,
		(seq_diff_prev - sequence_difference) as gap_width,
		id - (seq_diff_prev - sequence_difference) as gap_start,
		id - 1 as gap_end
from st
where 1=1
and does_diff_exist = 'Yes'
and seq_diff_prev is not null;

----Look at table
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