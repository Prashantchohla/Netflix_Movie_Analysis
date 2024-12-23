select * from netflix;

-- 1. Count the number of Movies vs TV Shows
select type1,count(type1)
from netflix
group by 1;

-- 2. Find the most common rating for movies and TV shows
select type1, rating 
from
(select *,
rank() over (partition by type1 order by rating1 desc)
from
(select type1, rating, count(*) as rating1
from netflix
group by 1,2) as p)as m
where rank = 1;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT *
FROM netflix
WHERE release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix
with splitcountry as 
(
select
TRIM(country) as country1
from
	(
	select unnest(string_to_array(country, ',')) as country
	from netflix
	) as subquery
)
select 
	country1,
	count(*) as country_count
from
	splitcountry
group by country1
order by country_count desc;

-- 5. Identify the longest movie
SELECT *
FROM netflix
where type1 = 'Movie' and duration is not null
order by split_part(duration,' ',1):: INT desc;

-- 6. Find content added in the last 5 years
select *
FROM netflix
where release_year BETWEEN 
(
select max(release_year)-5
from netflix
)
and 
(
select max(release_year)
from netflix
)
order by release_year;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select *
from
(SELECT *, unnest(string_to_array(director,',')) as director_name
FROM netflix) as p
where director_name = 'Rajiv Chilaka';

-- 8. List all TV shows with more than 5 seasons
SELECT *
FROM netflix
where type1 = 'TV Show'
and
split_part(show_id,'s',2):: INT > 5
;

-- 9. Count the number of content items in each genre
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(*) as total_content
FROM netflix
GROUP BY 1;

-- 10.Find each year and the average numbers of content release in India on netflix.
-- return top 5 year with highest avg content release!
select country, release_year, count(release_year) as number
from
(SELECT *, UNNEST(STRING_TO_ARRAY(country,',')) as country_name
from netflix) 
where country_name = 'India'
group by release_year, country
order by number desc
limit 5;


-- 11. List all movies that are documentaries
SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries';

-- 12. Find all content without a director
SELECT * FROM netflix
WHERE director IS NULL;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select *
from netflix
where
	casts like '%Salman Khan%'
and
	release_year > extract(year from current_date) - 10;
	
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select UNNEST(STRING_TO_ARRAY(casts, ',')) as actor, COUNT(*) as count1
from
(SELECT *, UNNEST(STRING_TO_ARRAY(country,',')) as country_name
from netflix) as p
where country = 'India'
group by actor
order by count1 desc
limit 10;


-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

SELECT 
    category,
	TYPE1,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2;
