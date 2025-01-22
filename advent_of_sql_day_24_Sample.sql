select 	s.song_title,
		count(up.play_id) as total_plays,
		sum(case 	when (up.duration - s.song_duration) >= 0 or (s.song_duration is null and up.duration is not null) then 0
					else 1 end) as total_skips
from user_plays up
join songs s
	on up.song_id = s.song_id
group by s.song_title
order by 	count(up.play_id) desc,
			sum(case 	when (up.duration - s.song_duration) >= 0 or (s.song_duration is null and up.duration is not null) then 0
						else 1 end);

select 	*,
		case 	when (up.duration - s.song_duration) >= 0 or (s.song_duration is null and up.duration is not null) then 0
				else 1 end
from user_plays up
join songs s
	on up.song_id = s.song_id;	
	
----Look at data
select *
from users;

select *
from songs;

select *
from user_plays;

----Sample tables
drop table if exists users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL
);

drop table if exists songs;
CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(255) NOT NULL,
    song_duration INT  -- Duration in seconds, can be NULL if unknown
);

drop table if exists user_plays;
CREATE TABLE user_plays (
    play_id INT PRIMARY KEY,
    user_id INT,
    song_id INT,
    play_time DATE,
    duration INT,  -- Duration in seconds, can be NULL
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

----Sample data
-- Inserting data into users table
INSERT INTO users (user_id, username) VALUES (1, 'alice');
INSERT INTO users (user_id, username) VALUES (2, 'bob');
INSERT INTO users (user_id, username) VALUES (3, 'carol');

-- Inserting data into songs table, including a song with a NULL duration
INSERT INTO songs (song_id, song_title, song_duration) VALUES (1, 'Jingle Bells', 180);
INSERT INTO songs (song_id, song_title, song_duration) VALUES (2, 'Silent Night', NULL); -- NULL duration
INSERT INTO songs (song_id, song_title, song_duration) VALUES (3, 'Deck the Halls', 150);

-- Inserting example play records into user_plays table, including NULL durations
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (1, 1, 1, '2024-12-22', 180);  -- Full play
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (2, 2, 1, '2024-12-22', 100);  -- Skipped
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (3, 3, 2, '2024-12-22', NULL); -- NULL duration (unknown play)
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (4, 1, 2, '2024-12-23', 180);  -- Valid duration, but song duration unknown
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (5, 2, 2, '2024-12-23', NULL); -- NULL duration
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (6, 3, 3, '2024-12-23', 150);  -- Full play

-- Additional plays with NULLs and shorter durations
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (7, 1, 3, '2024-12-23', 150);  -- Full play
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (8, 2, 3, '2024-12-22', 140);  -- Skipped
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (9, 3, 1, '2024-12-23', NULL); -- NULL duration
INSERT INTO user_plays (play_id, user_id, song_id, play_time, duration) VALUES (10, 1, 3, '2024-12-22', NULL); -- NULL duration