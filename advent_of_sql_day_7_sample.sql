----------------Sample code-------------------------
select 	t.primary_skill,
		max(t.elf_1_id) as elf_1_id,
		max(t.elf_2_id) as elf_2_id
from 	(with s as (select 	*,
							min(years_experience) over (partition by primary_skill) as Min_Experience,
							max(years_experience) over (partition by primary_skill) as Max_Experience
					from workshop_elves)
		select 	primary_skill,
				case 	when years_experience = max_experience then elf_id
						else 0 end as elf_1_id,
				case 	when years_experience = min_experience then elf_id
						else 0 end as elf_2_id
		from s) t
group by t.primary_skill;

select *
from workshop_elves;

-----------------DATA------------------
DROP TABLE workshop_elves CASCADE;
CREATE TABLE workshop_elves (
    elf_id SERIAL PRIMARY KEY,
    elf_name VARCHAR(100) NOT NULL,
    primary_skill VARCHAR(50) NOT NULL,
    years_experience INTEGER NOT NULL
);

INSERT INTO workshop_elves (elf_name, primary_skill, years_experience) VALUES
    ('Tinker', 'Toy Making', 150),
    ('Sparkle', 'Gift Wrapping', 75),
    ('Twinkle', 'Toy Making', 90),
    ('Holly', 'Cookie Baking', 200),
    ('Jolly', 'Gift Wrapping', 85),
    ('Berry', 'Cookie Baking', 120),
    ('Star', 'Toy Making', 95);