----Required query
with t as 	(select 	*,
					unnest(email_Addresses) as Email_Unnested,
					position('@' in unnest(email_Addresses)) as Position_At,
					right(unnest(email_Addresses), length(unnest(email_Addresses)) - position('@' in unnest(email_Addresses))) as Domain_Name
			from contact_list)
select 	domain_name as domain,
		count(distinct name) as Total_Users,
		'{' || string_agg(Email_Unnested, ', ') || '}' as Users 
from t
group by domain_name
order by count(distinct name) desc;

----Look at data
select *
from contact_list
limit 100;

-----Sample data
CREATE TABLE contact_list (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email_addresses TEXT[] NOT NULL
);

INSERT INTO contact_list (name, email_addresses) VALUES
('Santa Claus', 
 ARRAY['santa@northpole.com', 'kringle@workshop.net', 'claus@giftsrus.com']),
('Head Elf', 
 ARRAY['supervisor@workshop.net', 'elf1@northpole.com', 'toys@workshop.net']),
('Grinch', 
 ARRAY['grinch@mountcrumpit.com', 'meanie@whoville.org']),
('Rudolph', 
 ARRAY['red.nose@sleigh.com', 'rudolph@northpole.com', 'flying@reindeer.net']);