🎬 RSVP Movies SQL Analysis

📌 Project Overview



This project analyzes movie data using SQL to extract meaningful insights related to genres, actors, production houses, and movie trends. The analysis helps in understanding patterns in the film industry and supports data-driven decision-making.



🎯 Business Objective



The objective of this project is to help RSVP Movies identify the best genre, actors, directors, and production strategies to successfully launch a movie for a global audience.



📌 Problem Statement



RSVP Movies is an Indian film production company that has produced several successful movies. Traditionally, the company has focused on the Indian audience. However, for their next project, they plan to release a movie for a global audience.



To support this goal, the company wants to analyze past movie data and identify key insights related to:



Movie genres

Release trends

Actors and actresses

Production houses

Revenue patterns



This project focuses on extracting these insights using SQL.



🛠️ Tools Used

MySQL Workbench

SQL (CTEs, Joins, Window Functions, Aggregations)

GitHub

📊 Analysis \& Insights

Q3. Movie Release Trends (Year \& Month)

!\[Q3 Output](q3\_movie\_release\_trends\_1.png)



Insight: Movie production was highest in 2017 and slightly decreased in 2018, followed by a significant drop in 2019. This declining trend indicates a possible slowdown in movie releases, which RSVP Movies should consider while planning their future production strategy.







!\[Q3 Output](q3\_movie\_release\_trends\_2.png)

!\[Q3 Output](q3\_movie\_release\_trends\_3.png)

Insight: Movie releases are not evenly distributed across months. March has the highest number of releases, followed by September and January, indicating that early and mid-year periods are preferred for movie releases. On the other hand, December has the lowest number of releases, suggesting reduced activity towards the end of the year.





Q6. Which genre had the highest number of movies produced overall?

!\[Q6 Output](q6\_most\_popular\_genre.png)



Insight: Drama is the most produced genre with 4,285 movies, indicating strong audience demand and popularity. RSVP Movies can consider focusing on the Drama genre for their upcoming project to maximize reach and success.



Q8. What is the average duration of movies in each genre?



!\[Q8 Output](q8\_average\_movie\_duration\_by\_genre\_1.png)

!\[Q8 Output](q8\_average\_movie\_duration\_by\_genre\_2.png)



Insight:Action movies have the highest average duration (\~113 minutes), followed by Romance and Crime, while genres like Horror and Sci-Fi have shorter durations. Drama, being the most popular genre, has an average duration of around 107 minutes, suggesting an optimal movie length for audience engagement.





Q11. Which are the top 10 movies based on average rating?



!\[Q11 Output](q11\_top\_rated\_movies.png)



Insight: The top-rated movies have exceptionally high average ratings, with multiple movies scoring close to or equal to 10. This indicates that highly rated movies are well-received by audiences, and focusing on strong storytelling and quality content can significantly improve a movie’s success for RSVP Movies' global strategy.





Q13. Which production house has produced the most number of hit movies (average rating > 8)?



!\[Q13 Output](q13\_top\_production\_house\_hit\_movies.png)



Insight: Dream Warrior Pictures and National Theatre Live are the top production houses, each producing the highest number of hit movies (3). This indicates their strong track record in delivering high-quality content, making them potential partners for RSVP Movies' upcoming project.



Q22. Top actors in Indian movies based on average ratings



!\[Q22 Output](q22\_top\_ranked\_indian\_actors.png)



Insight: Vijay Sethupathi ranks as the top actor with the highest weighted average rating (8.42), followed by Fahadh Faasil and Yogi Babu. This indicates that these actors consistently deliver high-performing movies, making them strong candidates for RSVP Movies' upcoming project targeting Indian and global audiences.





Q23. Top actresses in Hindi movies based on average ratings



!\[Q23 Output](q23\_top\_actresses\_hindi.png)



Insight: Taapsee Pannu ranks as the top actress with the highest average rating (7.74), followed by Kriti Sanon and Divya Dutta. This highlights their consistent performance in Hindi movies, making them strong choices for RSVP Movies to attract the Indian audience.



Q26. Highest-grossing movies in top genres

!\[Q26 Output](q26\_highest\_grossing\_movies\_1.png)

!\[Q26 Output](q26\_highest\_grossing\_movies\_2.png)



Insight: High-grossing movies are consistently from top genres like Drama, Comedy, and Thriller. Blockbusters such as \*Avengers: Endgame\* and \*The Lion King\* generated massive revenue, highlighting that focusing on popular genres with large-scale production can significantly improve global box office success for RSVP Movies.





Q27. Top production houses for multilingual hit movies



!\[Q27 Output](q27\_multilingual\_hit\_production\_houses.png)



Insight: Star Cinema and Twentieth Century Fox lead in producing multilingual hit movies, indicating their strong capability to appeal to diverse audiences. Partnering with such production houses can help RSVP Movies succeed in both Pan-India and international markets.



Q29. Top directors based on performance and output



!\[Q29 Output](q29\_top\_directors\_summary\_1.png)

!\[Q29 Output](q29\_top\_directors\_summary\_2.png)



Insight: A.L. Vijay has directed the highest number of movies among the top directors, while directors like Steven Soderbergh stand out with higher average ratings and total votes. This indicates that both consistency (more movies) and quality (higher ratings) are important factors when selecting a director for RSVP Movies' upcoming project.



📁 Project Files

queries.sql → Contains all SQL queries





📌 Final Conclusion

Drama, Comedy, and Thriller are the most impactful genres and should be prioritized.

Top actors like Vijay Sethupathi and strong Hindi actresses can attract wider audiences.

Partnering with production houses like Dream Warrior Pictures, Star Cinema, and Twentieth Century Fox increases success chances.

High-budget, high-quality movies in popular genres drive global revenue.

Choosing experienced directors ensures both consistency and quality.



👉 Overall: RSVP Movies should focus on popular genres, strong talent, and strategic partnerships to successfully launch a global movie.

