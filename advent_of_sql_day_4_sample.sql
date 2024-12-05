----Sample result
select 	toy_id,
		concat('{', string_agg(added_tags, ','), '}') as Added_Tags,
		concat('{', string_agg(unchanged_tags, ','), '}') as unchanged_Tags,
		concat('{', string_agg(removed_tags, ','), '}') as removed_Tags
from 	(SELECT  	toy_id,
			    	unnest(ARRAY(SELECT UNNEST(new_tags) EXCEPT SELECT UNNEST(previous_tags))) AS added_tags,
			   		unnest(ARRAY(SELECT UNNEST(new_tags) intersect SELECT UNNEST(previous_tags))) AS unchanged_tags,
			    	unnest(ARRAY(SELECT UNNEST(previous_tags) EXCEPT SELECT UNNEST(new_tags))) AS removed_tags
		from toy_production) s
group by toy_id
order by toy_id;

DROP TABLE IF EXISTS toy_production CASCADE;
CREATE TABLE toy_production (
  toy_id INT,
  toy_name VARCHAR(100),
  previous_tags TEXT[],
  new_tags TEXT[]
);

INSERT INTO toy_production VALUES
(1, 'Robot', ARRAY['fun', 'battery'], ARRAY['smart', 'battery', 'educational', 'scientific']),
(2, 'Doll', ARRAY['cute', 'classic'], ARRAY['cute', 'collectible', 'classic']),
(3, 'Puzzle', ARRAY['brain', 'wood'], ARRAY['educational', 'wood', 'strategy']);

----Look at data
select 	*,
		UNNEST(previous_tags),
		UNNEST(new_tags)
from toy_production tp;




