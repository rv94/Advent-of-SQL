----Sample query
with cte as 	(select 	*,
						split_part(url, '?', 2),
						unnest(regexp_split_to_array(split_part(url, '?', 2), '&')) as extracted_elements
				from web_requests
				where 1=1
				and url ilike '%utm_source=advent-of-sql%')	----URL source
select 	request_id,
		url,
		'{' || string_agg(extracted_elements, ', ') || '}' as Key_Value_Pairs,
		count(*) as count_params
from cte
group by 	request_id,
			url
order by count(*) desc, url;		

----Look at tables
select *
from web_requests; 

---Sample data
drop table if exists web_requests;
CREATE TABLE web_requests (
    request_id SERIAL PRIMARY KEY,
  url TEXT NOT NULL
);

INSERT INTO web_requests (url) VALUES
('http://example.com/page?param1=value1¶m2=value2'),
('https://shop.example.com/items?item=toy&color=red&size=small&ref=google&utm_source=advent-of-sql'),
('http://news.example.org/article?id=123&source=rss&author=jdoe&utm_source=advent-of-sql'),
('https://travel.example.net/booking?dest=paris&date=2024-12-19&class=business'),
('http://music.example.com/playlist?genre=pop&duration=long&listener=guest&utm_source=advent-of-sql');