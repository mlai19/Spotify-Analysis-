-- SQL Project - Spotify Datasets

-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);


-- eda

SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify; 

SELECT DISTINCT album_type FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT MIN(duration_min) FROM spotify;

SELECT * FROM spotify
WHERE duration_min = 0 

DELETE FROM spotify 
WHERE duration_min = 0;
SELECT * FROM spotify
WHERE duration_min = 0;


SELECT DISTINCT channel FROM spotify;

SELECT DISTINCT most_played_on FROM spotify;


-- DATA ANALYSIS - EASY QUESTIONS

-- 1. Retrieve the names of all tracks that have more than 1 billion streams.
SELECT *
FROM spotify
WHERE stream > 1000000000;

-- 2. List all albums along with their respective artists.
SELECT DISTINCT album, artist
FROM spotify
ORDER BY album;

-- 3. Get the total number of comments for tracks where licensed = TRUE.
SELECT SUM(comments) AS total_comments
FROM spotify
WHERE licensed = 'true';

-- 4. Find all tracks that belong to the album type single.
SELECT *
FROM spotify
WHERE album_type = 'single';

-- 5. Count the total number of tracks by each artist.
SELECT artist, COUNT(*) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks DESC;

-- DATA ANALYSIS -- MEDIUM QUESTIONS

-- 1. Calculate the average danceability of tracks in each album.
SELECT album, AVG(danceability)
FROM spotify
GROUP BY album
ORDER BY AVG(danceability) DESC;

-- 2. Find the top 5 tracks with the highest energy values.
SELECT track, MAX(energy)
FROM spotify
GROUP BY track
ORDER BY MAX(energy) DESC 
LIMIT 5;

-- 3. List all tracks along with their views and likes where official_video = TRUE.
SELECT track, SUM(views) AS total_views, SUM(likes) AS total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY track
ORDER BY total_views DESC;


-- 4. For each album, calculate the total views of all associated tracks.
SELECT album, track, SUM(views) AS total_views
FROM spotify
GROUP BY album, track
ORDER BY total_views DESC;

-- 5. Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT *
FROM
(SELECT track, 
	COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END), 0) AS streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END), 0) AS streamed_on_spotify
FROM spotify
GROUP BY track) AS t1
WHERE  streamed_on_spotify > streamed_on_youtube AND streamed_on_youtube <> 0;



-- DATA ANALYSIS: ADVANCED QUESTIONS

-- 1. Find the top 3 most-viewed tracks for each artist using window functions.
WITH ranking_artist
AS
	(SELECT
		artist, 
		track,
		SUM (views) as total_view, 
		DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) as rank
	FROM spotify
	GROUP BY artist, track
	ORDER BY artist, total_view DESC
)
SELECT * FROM ranking_artist
WHERE rank <= 3;

-- Write a query to find tracks where the liveness score is above the average.
SELECT track, artist, liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);


-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
WITH cte
AS
(	
	SELECT 
		album,
		MAX(energy) as highest_energy,
		MIN(energy) as lowest_energery
	FROM spotify
	GROUP BY album
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY energy_diff DESC
















