---Get count
with t as (	select 	*,
					trim(regexp_split_to_table(skills, ',')) AS individual_skill
			from elves
			where 1=1)
select *
from t
where 1=1
and individual_skill = 'SQL';

----Look at tables
select 	*,
		trim(regexp_split_to_table(skills, ',')) AS individual_skill
from elves
where 1=1;

----Sample data
DROP TABLE IF EXISTS elves CASCADE;
    CREATE TABLE elves (
      id SERIAL PRIMARY KEY,
      elf_name VARCHAR(255) NOT NULL,
      skills TEXT NOT NULL
    );
    
   
 INSERT INTO elves (elf_name, skills)
VALUES 
    ('Eldrin', 'Elixir,Python,C#,JavaScript,MySQL'),           -- 4 programming skills
    ('Faenor', 'C++,Ruby,Kotlin,Swift,Perl'),          -- 5 programming skills
    ('Luthien', 'PHP,TypeScript,Go,SQL');              -- 4 programming skills