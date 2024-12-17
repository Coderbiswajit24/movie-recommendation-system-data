--Intermediate Query Questions

--Task 1:- Average Budget per Genre.
--Query:-
select * from genre;

select * from movie_genres;

select * from movie;

select
     g.genre_name,
	 round(avg(m.budget),2) as average_budget
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id
join genre as g on mg.genre_id = g.genre_id
group by g.genre_name
order by average_budget desc;

--Task 2:- Total Revenue by Country.
--Query:-
select * from country;

select * from production_country;

select * from movie;

select
    c.country_name,
	sum(m.revenue) as total_revenue
from movie as m
join production_country as pc on m.movie_id = pc.movie_id
join country as c on pc.country_id = c.country_id
group by c.country_name
order by total_revenue desc;
 --Task 3:- Find Genres with Average Runtime Greater Than 120 Minutes.
 --Query:-
select
      g.genre_name,
	  round(avg(m.runtime),0) as average_movie_duration
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id
join genre as g on mg.genre_id = g.genre_id
group by g.genre_name
having round(avg(m.runtime),0) > 120
order by average_movie_duration desc;

--Task 4:- Find Countries with More Than 100 Movie Productions.
--Query:-
select
     c.country_name,
	 count(distinct m.movie_id) as number_of_movies_produced
from movie as m
join production_country as pc on m.movie_id = pc.movie_id
join country as c on c.country_id = pc.country_id
group by c.country_name
having count(distinct m.movie_id) > 100
order by  count(distinct m.movie_id) desc;

--Task 5:- Find Top 10 Highest-Grossing Movies and Their Genres.
--Query:-
select
     m.title as movie_title,
	 string_agg(g.genre_name , '| ' order by g.genre_name asc) as movie_genre
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id 
join genre as g on g.genre_id = mg.genre_id
group by m.title , m.revenue 
order by m.revenue desc
limit 10;

--Task 6:- Rank Movies by Popularity Within Each Genre.
--Query:-
select
     g.genre_name,
	 m.title,
	 dense_rank() over(partition by g.genre_name order by m.popularity desc ) as movie_popularity_rank
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id 
join genre as g on g.genre_id = mg.genre_id
order by g.genre_name;

--Task 7:- Find the Average Budget and Revenue for Movies Released in Each Decade.
--Query:- 

select
    min(release_date) as first_movie_release_date
from movie;

select 
    max(release_date) as last_movie_release_date
from movie;

select
    t.*
from ((
select
     '1910s' as decade,
	  round(avg(case when release_date between '1910-01-01' and '1919-12-31' then revenue else 0 end),2) as average_revenue,
	  round(avg(case when release_date between '1910-01-01' and '1919-12-31' then budget else 0 end),2) as average_budget
from movie
)
union all
(
select
     '1920s' as decade,
	 round(avg(case when release_date between '1920-01-01' and '1929-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1920-01-01' and '1929-12-31' then budget else 0 end),2) as average_budget
from movie
)
union all
(
select
     '1930s' as decade,
	 round(avg(case when release_date between '1930-01-01' and '1939-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1930-01-01' and '1939-12-31' then budget else 0 end),2) as average_budget
from movie	 
)
union all
(
select
     '1940s' as decade,
	 round(avg(case when release_date between '1940-01-01' and '1949-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1940-01-01' and '1949-12-31' then budget else 0 end),2) as average_budget
from movie	 
)
union all
(
select
     '1950s' as decade,
	 round(avg(case when release_date between '1950-01-01' and '1959-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1950-01-01' and '1959-12-31' then budget else 0 end),2) as average_budget
from movie	 
)
union all
(
select
     '1960s' as decade,
	 round(avg(case when release_date between '1960-01-01' and '1969-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1960-01-01' and '1969-12-31' then budget else 0 end),2) as average_budget
from movie	
)
union all
(
select
     '1970s' as decade,
	 round(avg(case when release_date between '1970-01-01' and '1979-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1970-01-01' and '1979-12-31' then budget else 0 end),2) as average_budget
from movie	
)
union all
(
select
     '1980s' as decade,
	 round(avg(case when release_date between '1980-01-01' and '1989-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1980-01-01' and '1989-12-31' then budget else 0 end),2) as average_budget
from movie	
)
union all
(
select
     '1990s' as decade,
	 round(avg(case when release_date between '1990-01-01' and '1999-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '1990-01-01' and '1999-12-31' then budget else 0 end),2) as average_budget
from movie	
)
union all
(
select
     '2000s' as decade,
	 round(avg(case when release_date between '2000-01-01' and '2009-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '2000-01-01' and '2009-12-31' then budget else 0 end),2) as average_budget
from movie	
)
union all
(
select
     '2010s' as decade,
	 round(avg(case when release_date between '2010-01-01' and '2019-12-31' then revenue else 0 end),2) as average_revenue,
	 round(avg(case when release_date between '2010-01-01' and '2019-12-31' then budget else 0 end),2) as average_budget
from movie	
)) as t
order by t.decade asc;

--Task 8:- Identify the Most Prolific Actors and Directors.
--Query:-

select * from person;

select * from movie_cast

select * from department;
-- Identify Most Profilic Actors.
select
    p.person_id as actor_id,
	p.person_name as actor_name,
	count(distinct m.movie_id) as total_movie_count
from person as p
join movie_cast as mc on p.person_id = mc.person_id
join movie as m on mc.movie_id = m.movie_id
group by p.person_id,p.person_name
order by total_movie_count desc
limit 10;

-- Identify Most Profilic Directors

select * from movie_crew;

select
      p.person_id as director_id,
	  p.person_name as director_name,
	  count(distinct m.movie_id) as total_movie_count
from movie as m
join movie_crew as mc on m.movie_id = mc.movie_id
join person as p on mc.person_id = p.person_id 
where mc.department_id = 2
group by p.person_id , p.person_name
order by total_movie_count desc
limit 10;
     
-- Task 10 :- Find the Most Popular Genre in Each Country.
--Query:-
select
     t.country_name,
	 t.genre_name as popular_genre
from (select
	     c.country_name,
		 g.genre_name,
		 dense_rank() over(partition by c.country_name order by m.popularity desc) as genre_popularity
	from movie as m
	join movie_genres as mg on m.movie_id = mg.movie_id
	join genre as g on mg.genre_id = g.genre_id
	join production_country as pc on m.movie_id = pc.movie_id
	join country as c on pc.country_id = c.country_id 
	order by c.country_name asc) as t
where t.genre_popularity = 1;

--Task 11:- List all movies and their respective genres.
--Query:- 
select * from movie;

select * from genre;

select * from movie_genres;

select
     m.movie_id,
	 m.title as movie_title,
	 string_agg(g.genre_name,'| 'order by g.genre_name asc) as movie_genre
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id
join genre as g on mg.genre_id = g.genre_id
group by m.movie_id, m.title
order by m.movie_id,m.title asc;

--Task 12:- List all movies and their production companies.
--Query:-
select * from movie;

select * from movie_company; 

select * from production_company;

select
     m.movie_id,
	 m.title as movie_title,
	 string_agg(pc.company_name,'| 'order by pc.company_name asc) as movie_production_company
from movie as m
join movie_company as mc on m.movie_id = mc.movie_id
join production_company as pc on mc.company_id = pc.company_id
group by m.movie_id , m.title
order by m.movie_id,m.title asc;

--Task 13:- List all movies and their directors.
--Query:-
select * from movie;

select * from movie_crew;

select * from person;

select * from department;

select
    m.movie_id,
	m.title as movie_title,
	p.person_name as movie_directors_name
from movie as m
join movie_crew as mc on m.movie_id = mc.movie_id
join person as p on mc.person_id = p.person_id
where mc.department_id =2 and job = 'Director'
order by m.movie_id , m.title , p.person_name asc;

--Task 14:- List all movies and their keywords.
--Query:-
select * from movie;

select * from keyword;

select * from movie_keywords;

select
     m.movie_id,
	 m.title as movie_title,
	 string_agg(k.keyword_name,'| 'order by k.keyword_name asc) as movie_keyword
from movie as m
join movie_keywords as mk on m.movie_id = mk.movie_id
join keyword as k on mk.keyword_id = k.keyword_id
group by m.movie_id , m.title
order by m.movie_id , m.title asc;

--Task 15:- Find the top 5 most profitable movies.
--Query:-
select * from movie;

select
     movie_id , 
	 title as movie_title,
	 (revenue - budget) as movie_profit
from movie 
order by movie_profit desc
limit 5;

--Task 16:- Find actors who have appeared in more than 10 movies.
--Query:-
select * from person;

select * from movie_cast;

select * from gender;

select
     p.person_name as Actors
from person as p 
join movie_cast as mc on mc.person_id = p.person_id
where mc.gender_id = (select gender_id from gender where gender = 'Male')
group by p.person_name
having count(distinct mc.movie_id ) > 10
order by Actors asc;

--Task 17:- Rank movies by popularity within each genre.
--Query:-
select * from movie;

select * from genre;

select * from movie_genres;

select
     g.genre_name as movie_genre,
	 m.title,
	 m.popularity,
	 dense_rank() over(partition by g.genre_name order by m.popularity desc) as movie_rank
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id
join genre as g on mg.genre_id = g.genre_id
order by g.genre_name asc;

--Task 18:- Find the top 3 movies for each year based on popularity.
--Query:-
select
    movie_id,
	title,
	extract(year from release_date) as release_year ,
	popularity
from (select
	     movie_id,
		 title,
		 release_date,
		 popularity,
		 dense_rank() over(partition by extract(year from release_date) order by popularity desc) as popularity_rank
	from movie
	order by release_date asc) as t
where t.popularity_rank <= 3
order by release_year asc;

--Task 19:- Most Frequent Collaborations Actors.
--Query:-

with most_frequent_collaboration as (
select
     p1.person_id as actor1_id,
	 p1.person_name as actor1_name,
	 p2.person_id as actor2_id,
	 p2.person_name as actor2_name,
	 count(*) as frequent_collaboration_count
from movie_cast as mc1
join movie_cast as mc2 on mc1.movie_id = mc2.movie_id and mc1.person_id < mc2.person_id
join person as p1 on p1.person_id = mc1.person_id
join person as p2 on p2.person_id = mc2.person_id
group by p1.person_id,p1.person_name , p2.person_id , p2.person_name 

)

select * from most_frequent_collaboration
order by frequent_collaboration_count desc
limit 10;

--Task 20:- Actors with the Most Diverse Roles.
--Query:-
select * from movie_cast;

select * from person;

select
     p.person_name as actor,
	 count(distinct mc.character_name) as count_of_diverse_role
from person as p
join movie_cast as mc on p.person_id = mc.person_id
group by p.person_name
order by count(distinct mc.character_name ) desc
limit 10;

--Task 21:- Find the most frequent collaborations between directors and actors.
--Query:-
select * from movie_crew;

select * from movie_cast;

select * from person;

select
     p1.person_id as Director_id,
     p1.person_name as Director,
	 p2.person_id as Actor_id,
	 p2.person_name as Actor_name,
	 count(*) as frequent_collaboration_count
from movie_cast as mc1
join movie_crew as mc2 on mc1.movie_id = mc2.movie_id and (mc1.person_id < mc2.person_id) and (mc2.department_id = 2 and mc2.job = 'Director')
join person as p2 on mc1.person_id = p2.person_id and mc1.gender_id = (select gender_id from gender where gender = 'Male')
join person as p1 on mc2.person_id = p1.person_id
group by p1.person_id, p1.person_name, p2.person_id,p2.person_name
order by frequent_collaboration_count desc
limit 10 ;

/*--Task 22:- Find all actors who have worked with 
Tom Cruise ,Brad Pitt ,Leonardo DiCaprio ,Julia Roberts , 
Sandra Bullock, Johnny Depp ,Nicole Kidman , Denzel Washington
*/
--Query:-
-- For Brad Pitt
select * from movie;

select * from movie_cast;

select * from person;

select
     p.person_name as co_actors
from person as p
join movie_cast as mc on p.person_id = mc.person_id
join movie as m on mc.movie_id = m.movie_id
where m.movie_id in (select 
                          movie_id
                     from movie_cast
					 join person on movie_cast.person_id = person.person_id
					 where person_name = 'Brad Pitt') 
and p.person_name != 'Brad Pitt' 
and mc.gender_id = (select gender_id from gender where gender ='Male')
order by p.person_name;


--Task 23:- Find all movies that reference other movies.
--Query:-
select * from movie;

select * from movie_keywords;

select * from keyword;

