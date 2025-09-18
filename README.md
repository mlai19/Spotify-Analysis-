# Spotify Analysis

## Project Overview  
**Project Title**: Spotify Analysis  
**Database**: spotify_db [Kaggle]

<img width="1280" height="670" alt="image" src="https://github.com/user-attachments/assets/98644574-a580-480c-b38b-8a919e292dc4" />

<br>
<br>

****Overview****
<br>

This project focuses on analyzing a Spotify dataset that includes details about tracks, albums, and artists using SQL. It walks through the full process of normalizing a raw dataset, writing queries at different levels of complexity, and improving query performance. The main purpose is to strengthen advanced SQL skills while generating meaningful insights from the data.
<br>
<br>
```sql
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
```

**Project Steps**
---
**1. Data Exploration** 
Before starting with SQL, it helps to get familiar with the dataset. It includes details like:
- Artist: the performer of the track
- Track: the song title
- Album: the album the track belongs to
- Album type: whether it’s a single or a full album
- Audio features: metrics such as danceability, energy, loudness, tempo, and more

**2. Data Querying** 
Once the data is loaded, I begin writing SQL queries to explore and analyze it. The queries are organized into easy, medium, and advanced levels to build SQL skills step by step.


- Easy queries: focus on simple retrieval, filtering, and basic aggregations
- Medium queries: involve grouping, aggregation functions, and joins
- Advanced queries: cover nested subqueries, window functions, CTEs, and query optimization

**Practice Questions**  
---

**Easy Level**  
Retrieve the names of all tracks that have more than 1 billion streams.  
List all albums along with their respective artists.  
Get the total number of comments for tracks where licensed = TRUE.  
Find all tracks that belong to the album type single.  
Count the total number of tracks by each artist.

**Medium Level**    
Calculate the average danceability of tracks in each album.  
Find the top 5 tracks with the highest energy values.  
List all tracks along with their views and likes where official_video = TRUE.  
For each album, calculate the total views of all associated tracks.  
Retrieve the track names that have been streamed on Spotify more than YouTube.

**Advanced Level**  
Find the top 3 most-viewed tracks for each artist using window functions.  
Write a query to find tracks where the liveness score is above the average.  
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

**Query Optimization**  
---

**Before optimization:**
To improve query performance, I first analyzed how the query was running using the EXPLAIN function. The test query retrieved tracks by artist, and the initial performance metrics showed an execution time of 7 ms and a planning time of 0.17 ms.

  
<img width="675" height="267" alt="Screenshot 2025-09-18 at 11 22 37 AM" src="https://github.com/user-attachments/assets/a9dc8d5c-4dc1-4870-99ee-8a1c9fe9d77d" />  

<br>
<br>

**CHANGE:**
I improved performance by creating an index on the artist column. This made retrieving rows by artist significantly faster.

```sql
CREATE INDEX idex_artist ON spotify_tracks(artist);
```
<br>


**After Optimization**
After adding the index, I reran the query and saw a clear improvement. Execution time dropped to 0.153 ms and planning time to 0.152 ms.

<img width="687" height="341" alt="Screenshot 2025-09-18 at 11 25 42 AM" src="https://github.com/user-attachments/assets/d4169277-5304-491e-9417-e22fee7689d6" />

---
**Optimizing queries matters because it makes working with data faster and more efficient. Even small improvements can add up, especially when queries are run often or on large datasets. Better performance not only saves time and resources but also makes the analysis process smoother.**



**Next steps**
---
**Visualize the data:** build dashboards in tools like Tableau or Power BI using the query results  


**Expand the dataset:** add more rows to enable broader analysis and test scalability  


**Advance querying:** continue exploring optimization techniques and evaluate performance on larger datasets  


