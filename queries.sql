USE imdb;

-- Q1. Find the total number of rows in each table of the schema?
SELECT table_name,
table_rows AS no_of_rows
FROM information_schema.tables
WHERE table_schema='imdb';

-- Q2. Which columns in the movie table have null values?
SELECT
SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id_nulls_count,
SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS title_nulls_count,
SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS year_nulls_count,
SUM(CASE WHEN date_published IS NULL THEN 1 ELSE 0 END) AS date_published_nulls_count,
SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_nulls_count,
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_nulls_count,
SUM(CASE WHEN worlwide_gross_income IS NULL THEN 1 ELSE 0 END) AS worlwide_gross_income_nulls_count,
SUM(CASE WHEN languages IS NULL THEN 1 ELSE 0 END) AS languages_nulls_count,
SUM(CASE WHEN production_company IS NULL THEN 1 ELSE 0 END) AS production_company_nulls_count
FROM movie;

-- Q3. Find the total number of movies released each year? How does the trend look month wise? 
SELECT year, COUNT(*) AS no_of_movies
FROM movie
GROUP BY year;

SELECT MONTH(date_published) AS month_num, COUNT(*) AS no_of_movies
FROM movie
GROUP BY month_num
ORDER BY no_of_movies DESC;

-- Q4. How many movies were produced in the USA or India in the year 2019??
SELECT COUNT(id) AS no_of_movies FROM movie
WHERE year='2019'
AND (country LIKE '%USA%' OR country LIKE '%INDIA%');

-- Q5. Find the unique list of the genres present in the data set?
SELECT DISTINCT genre FROM genre;

-- Q6.Which genre had the highest number of movies produced overall?
SELECT genre, COUNT(movie_id) AS movie_count 
FROM genre
GROUP BY genre
ORDER BY movie_count DESC;

-- Q7. How many movies belong to only one genre?
WITH summary AS (
SELECT movie_id,COUNT(genre) AS genre_count
FROM genre
GROUP BY movie_id
HAVING genre_count=1)
SELECT COUNT(*) AS genre_count FROM summary;

-- Q8.What is the average duration of movies in each genre? 
SELECT genre, ROUND(AVG(duration),2) AS avg_duration FROM movie  m 
INNER JOIN genre g
ON m.id=g.movie_id
GROUP BY genre
ORDER BY avg_duration DESC;

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
WITH genre_summary AS (
SELECT genre, COUNT(movie_id) AS movie_count,
RANK() OVER(ORDER BY COUNT(movie_id) DESC) AS genre_rank
FROM genre
GROUP BY genre)
SELECT * FROM genre_summary
WHERE genre='Thriller';

-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
SELECT MIN(avg_rating) as min_avg_rating,
MAX(avg_rating) AS max_avg_rating,
MIn(total_votes) AS min_total_votes,
MAX(total_votes) AS max_total_votes,
MIN(median_rating) AS min_median_rating,
MAX(median_rating) AS max_median_rating
FROM ratings;

-- Q11. Which are the top 10 movies based on average rating?
WITH summary AS (
SELECT title, avg_rating,
RANK() OVER(ORDER BY avg_rating DESC) AS movie_rank
FROM movie m
INNER JOIN ratings r
ON m.id=r.movie_id)
SELECT * FROM summary
WHERE movie_rank<=10;

-- Q12. Summarise the ratings table based on the movie counts by median ratings
SELECT median_rating, COUNT(movie_id) AS movie_count
FROM ratings
GROUP BY median_rating
ORDER BY movie_count DESC;

USE imdb;

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
WITH prod_summary AS (
SELECT production_company,COUNT(m.id) AS movie_count, 
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS prod_comp_rank
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
WHERE avg_rating>8
AND production_company IS NOT NULL
GROUP BY production_company)
SELECT * FROM prod_summary
WHERE prod_comp_rank=1;

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
SELECT genre, COUNT(m.id) AS movie_count FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN genre g ON g.movie_id=m.id
WHERE date_published BETWEEN '2017-03-01' AND '2017-03-31'
AND country LIKE '%USA%'
AND total_votes>1000
GROUP BY genre
ORDER BY movie_count DESC;

-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
SELECT title,avg_rating, genre FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN genre g ON g.movie_id=m.id
WHERE title LIKE 'The%'
AND avg_rating>8;

-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
SELECT median_rating, COUNT(m.id) AS movie_count FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
WHERE date_published BETWEEN '2018-04-01' AND '2019-04-01'
AND median_rating=8
GROUP BY median_rating;

-- Q18. Which columns in the names table have null values??

select 
      sum(
      case when name is null then 1
     else 0
     end) as name_nulls,
     sum(
     case when height is null then 1
     else 0
     end) as height_nulls,
     sum(
     case when date_of_birth is null then 1
     else 0
     end) as dates,
     sum(
     case when known_for_movies is null then 1
     else 0
     end) as known
     from names;

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
WITH top_three_genres AS (
SELECT genre, COUNT(m.id) AS movie_count, 
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS genre_rank
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN genre g ON g.movie_id=m.id
WHERE avg_rating>8
GROUP BY genre
LIMIT 3)
SELECT n.name AS director_name, COUNT(m.id) AS movie_count FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN genre g ON g.movie_id=m.id
INNER JOIN director_mapping dm ON m.id=dm.movie_id
INNER JOIN names n ON n.id=dm.name_id
INNER JOIN top_three_genres ttg ON ttg.genre=g.genre -- WHERE genre IN (SELECT genre FROM top_three_genres)
WHERE avg_rating>8
GROUP BY director_name
ORDER BY movie_count DESC
LIMIT 3;

-- Q20. Who are the top two actors whose movies have a median rating >= 8?

SELECT n.name AS actor_name, COUNT(m.id) AS movie_count FROM movie m 
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN role_mapping rm ON rm.movie_id=m.id
INNER JOIN names n ON n.id=rm.name_id
WHERE median_rating>=8
AND category='actor'
GROUP BY actor_name
ORDER BY movie_count DESC
LIMIT 2;

SHOW variables LIKE 'sql_mode';
SET global sql_mode='';

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
WITH summary AS (
SELECT production_company, total_votes, COUNT(m.id) AS movie_count, 
RANK() OVER(ORDER BY total_votes DESC) AS prod_comp_rank
FROM movie m 
INNER JOIN ratings r ON m.id=r.movie_id
GROUP BY production_company)
SELECT * FROM summary
WHERE prod_comp_rank<=3;

USE imdb;

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
--  The actor should have acted in at least five Indian movies. 

SELECT n.name AS actor_name, total_votes, COUNT(m.id) AS movie_count, 
ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS actor_avg_rating,
RANK() OVER(ORDER BY ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) DESC) AS actor_rank
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN role_mapping rm ON rm.movie_id=m.id
INNER JOIN names n ON n.id=rm.name_id
WHERE category='actor'
AND country LIKE '%India%'
GROUP BY actor_name
HAVING movie_count>=5;

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
--  The actresses should have acted in at least three Indian movies. 
WITH actress_summary AS (
SELECT n.name AS actress_name, total_votes, COUNT(m.id) AS movie_count, 
ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) AS actress_avg_rating,
RANK() OVER(ORDER BY ROUND(SUM(avg_rating*total_votes)/SUM(total_votes),2) DESC) AS actress_rank
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN role_mapping rm ON rm.movie_id=m.id
INNER JOIN names n ON n.id=rm.name_id
WHERE category='actress'
AND country LIKE '%India%'
AND languages LIKE '%Hindi%'
GROUP BY actress_name
HAVING movie_count>=3)
SELECT * FROM actress_summary
WHERE actress_rank<=5;

/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
SELECT title, avg_rating, 
CASE
    WHEN avg_rating>8 THEN 'Superhit Movie'
    WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit Movie'
    WHEN avg_rating>=5 AND avg_rating<7 THEN 'one_time watch movie'
    ELSE 'Flop Movie'
END AS movie_classification
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN genre g ON g.movie_id=m.id
WHERE genre='Thriller';

-- Q25. What is the genre-wise running total and moving average of the average movie duration?

SELECT genre,AVG(duration) AS avg_duration, 
SUM(AVG(duration)) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS running_total_duration,
AVG(AVG(duration)) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS moving_avg_duration 
FROM movie m  
INNER JOIN genre g ON g.movie_id=m.id
GROUP BY genre;

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
WITH top_three_genres AS (
SELECT genre, COUNT(m.id) AS movie_count, 
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS genre_rank
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN genre g ON g.movie_id=m.id
GROUP BY genre
LIMIT 3), summary AS(
SELECT genre, year, title,
CAST(REPLACE(REPLACE(IFNULL(worlwide_gross_income,0),'$',''),'INR','') AS DECIMAL(10)) AS worlwide_gross_income,
RANK() OVER(PARTITION BY year ORDER BY CAST(REPLACE(REPLACE(IFNULL(worlwide_gross_income,0),'$',''),'INR','') AS DECIMAL(10)) DESC) AS movie_rank
FROM movie m  
INNER JOIN genre g ON g.movie_id=m.id
WHERE genre IN (SELECT genre FROM top_three_genres))
SELECT * FROM summary
WHERE movie_rank<=5;

-- Q27. Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
SELECT production_company, COUNT(m.id) AS movie_count, 
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS prod_comp_rank
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
WHERE POSITIOn(',' IN languages)>0
AND production_company IS NOT NULL
AND median_rating>=8
GROUP BY production_company
LIMIT 2;

USE imdb;

-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
WITH summary AS (
SELECT n.name AS actress_name, SUM(total_votes) AS total_votes,
COUNT(m.id) AS movie_count,
ROUND(SUM(avg_rating * total_votes)/SUM(total_votes),2) AS actress_avg_rating,
RANK() OVER(ORDER BY COUNT(m.id) DESC) AS actress_rank
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN genre g ON g.movie_id=m.id
INNER JOIN role_mapping rm ON m.id=rm.movie_id
INNER JOIN names n ON n.id=rm.name_id
WHERE category='actress'
AND genre='Drama'
AND avg_rating>8
GROUP BY actress_name)
SELECT * FROM summary
WHERE actress_rank<=3;


/* Q29. Top directors based on number of movies and ratings
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations */
WITH summary AS (
SELECT name_id AS director_id, name AS director_name,
dm.movie_id AS movie_id, duration, avg_rating,total_votes,
date_published,
LEAD(date_published,1) OVER(PARTITION BY name ORDER BY date_published) AS next_publish_date
FROM movie m
INNER JOIN ratings r ON m.id=r.movie_id
INNER JOIN director_mapping dm ON dm.movie_id=m.id
INNER JOIN names n ON n.id=dm.name_id)
SELECT 
director_id, director_name, COUNT(movie_id) AS number_of_movies,
ROUND(SUM(datediff(next_publish_date, date_published))/(COUNT(movie_id)-1),2) AS avg_inter_movie_days,
ROUND(SUM(avg_rating * total_votes)/SUM(total_votes),2) AS avg_rating,
SUM(total_votes) AS total_votes,
MIN(avg_rating) AS min_avg_rating,
MAX(avg_rating) AS max_avg_rating,
SUm(duration) AS total_duration
FROM summary
GROUP BY director_id
ORDER BY number_of_movies DESC
LIMIT 9;

