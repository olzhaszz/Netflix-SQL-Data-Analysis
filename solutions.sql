-- creating Netflix table

drop table if exists netflix_data;

create table netflix_data(
show_id varchar(6),
type varchar(10),
title varchar(150),
director varchar(250),
casts varchar(1000),
country varchar(200),
date_added varchar(50),
release_year int,
rating varchar(50),
duration varchar(50),
listed_in varchar(50),
description varchar (300)
);

-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows

select 
	type,
	count(*) as total_content
from netflix_titles
group by type


--2. Find the most common rating for movies and TV shows

select
	type,
	rating
from 
(
	select
		type,
		rating,
		count(*) as count,
		rank() over(partition by type order by count(*) desc) as ranking
	from netflix_titles
	group by type, rating
) as t1
where ranking = 1

--3. List all movies released in a specific year (e.g., 2020)

select * from  netflix_titles
where
	type = 'Movie'
	and
	release_year = 2020

--4. Find the top 5 countries with the most content on Netflix

with splitcountries as (
    select 
        show_id,
        ltrim(rtrim(value)) as new_country
    from netflix_titles
    cross apply string_split(country, ',')
    where country is not null
)
select 
    new_country,
    count(show_id) as total_content
from splitcountries
group by new_country
order by total_content desc
offset 0 rows fetch next 5 rows only;


--5. Identify the longest movie

select * from netflix_titles
where 
	type = 'Movie'
	and
	duration = (select MAX(duration) from netflix_titles)

--6. Find content added in the last 5 years

select
    *
from netflix_titles
where 
    try_cast(date_added as date) >= dateadd(year, -5, getdate());


--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select
    *
from netflix_titles
where lower(director) = 'rajiv chilaka';


--8. List all TV shows with more than 5 seasons

select
    *
from netflix_titles
where 
    type = 'TV Show'
    and try_cast(replace(replace(duration, ' Seasons', ''), ' Season', '') as int) > 5;


--9. Count the number of content items in each genre

with genres as (
    select
        ltrim(rtrim(value)) as genre
    from netflix_titles
    cross apply string_split(listed_in, ',')
    where listed_in is not null
)
select 
    genre,
    count(*) as total_content
from genres
group by genre
order by total_content desc;


--10.Find each year and the average numbers of content release in India on netflix. 
--return top 5 year with highest avg content release!

with india_content as (
    select
        release_year
    from netflix_titles
    where country like '%India%'
        and release_year is not null
),
yearly_counts as (
    select
        release_year,
        count(*) as total_content
    from india_content
    group by release_year
)
select top 5
    release_year,
    total_content as avg_content_release
from yearly_counts
order by avg_content_release desc;


--11. List all movies that are documentaries

select
    *
from netflix_titles
where 
    type = 'Movie'
    and listed_in like '%Documentaries%';


--12. Find all content without a director

select
    *
from netflix_titles
where 
    director is null
    or ltrim(rtrim(director)) = '';


--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

select
    count(*) as total_movies
from netflix_titles
where 
    type = 'Movie'
    and cast like '%Salman Khan%'
    and release_year >= year(getdate()) - 10;


--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

with indian_movies as (
    select cast
    from netflix_titles
    where 
        type = 'Movie'
        and country like '%India%'
        and cast is not null
),
actor_list as (
    select 
        ltrim(rtrim(value)) as actor
    from indian_movies
    cross apply string_split(cast, ',')
),
actor_counts as (
    select 
        actor,
        count(*) as movie_count
    from actor_list
    group by actor
)
select top 10
    actor,
    movie_count
from actor_counts
order by movie_count desc;


--15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

select 
    case 
        when description like '%kill%' or description like '%violence%' then 'Bad'
        else 'Good'
    end as content_category,
    count(*) as total_items
from netflix_titles
where description is not null
group by 
    case 
        when description like '%kill%' or description like '%violence%' then 'Bad'
        else 'Good'
    end;
