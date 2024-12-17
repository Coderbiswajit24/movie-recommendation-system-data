-- Basic Query
-- Task 1:-  List all movies released in 2013.
--Query:-
select
     *
from movie
where extract(year from release_date) = 2013;


--Task 2: - List all movies with a budget greater than 100 million.
--Query:-
select
    *
from movie
where budget > 100000000;

--Task 3:- List all movies with a runtime greater than 180 minutes.
--Query:-
select
    *
from movie
where runtime > 180;

--Task 4:- List all movies directed by 'Christopher Nolan'.
--Query:-
select * from movie; 

select * from movie_crew;

select 
     *
from person
where person_name ='Christopher Nolan' ;


select * from department;

select 
     *
from movie
where movie_id in (select movie_id from movie_crew where department_id = 2 and person_id = (select person_id from person where person_name = 'Christopher Nolan'));


--Task 5:- Find all movies with the word 'Alien' in their title.
--Query:-
select
     *
from movie
where title like '%Alien%';

--Task 6:- Find all movies with a runtime between 120 and 180 minutes.
--Query:-
select
    *
from movie
where runtime between 120 and 180;

--Task 7:- Find all movies with a budget greater than twice the average budget.
--Query:-
select
    *
from movie
where budget > 2*(select avg(budget) from movie);

--Task 8:- Find all movies with a popularity score more than 10 points higher than the average popularity score.
--Query:-
select
    *
from movie
where popularity > (select avg(popularity) from movie) + 10 ;

--Task 9:- Categorize movies based on their budget.
--Query:-
select
    movie_id,
	title,
	(case
	    when budget > 100000000 then 'High Budget'
		when budget > 50000000 then 'Medium Budget'
		else 'Low Budget'
	end ) as budget_category
from movie;	

--Task 10:- Find all movies released in the month of July.
--Query:-
select
     * 
from movie
where extract(month from release_date) = 7;

--Task 11:- List all the movies of genre crime , drama , thriller , Mystery.
--Query:-
select * from movie_genres;

select * from genre;

select
    *
from movie
where movie_id in 
(select movie_id from movie_genres where genre_id in (select genre_id from genre where genre_name in ('Crime','Drama','Thriller','Mystery')));

-- Task 12:- List all movies name , lead actors or actress  name , their gender , and charcter name in that movie release between 2010 and 2014.  
--Query:-
select * from movie;

select * from movie_cast;

select * from person;

select * from gender;

select
    m.title as "Movie Name",
	p.person_name as "Lead Actor/Actress Name",
	g.gender as "Gender",
	mc.character_name as "Movie Character Name"
from movie as m
join movie_cast as mc on m.movie_id = mc.movie_id
join gender as g on mc.gender_id = g.gender_id
join person as p on mc.person_id = p.person_id
where (extract(year from m.release_date) between 2010 and 2014) and mc.cast_order = 0;


-- Task 13:- Count the number big budget movies for each production company. Big budget means when movie budget more than 100 millions.
--Query:-

select * from production_company;

select * from movie_company;

select * from movie;

select 
     pc.company_name,
	 count(m.movie_id) as count_of_big_budget_movie
from production_company as pc
join movie_company as mc on pc.company_id = mc.company_id
join movie as m on mc.movie_id = m.movie_id
where m.budget > 100000000
group by pc.company_name
order by count_of_big_budget_movie desc;

--Task 14:- Find movies that are in both 'Action' and 'Sci-Fi' genres.
--Query:-
select * from movie;

select * from genre;

select * from movie_genres;

select
     m.movie_id,
	 m.title
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id
join genre as g on mg.genre_id = g.genre_id
where g.genre_name in ('Action','Science Fiction')
group by m.movie_id,m.title
having count(distinct g.genre_name) >= 2

--Task 15:- Find movies that are in either 'Drama' or 'Comedy' genres.
--Query:-
select * from movie;

select * from genre;

select * from movie_genres;

select
     m.movie_id,
	 m.title
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id
join genre as g on mg.genre_id = g.genre_id
where g.genre_name in ('Drama','Comedy')
group by m.movie_id,m.title
having count(distinct g.genre_name) <= 1;

--Task 16:- Find movies that are not in the 'Horror' genre.
--Query:-
select * from movie;

select * from movie_genres;

select * from genre;

select
    distinct  m.movie_id,
	 m.title
from movie as m
join movie_genres as mg on m.movie_id = mg.movie_id
join genre as g on mg.genre_id = g.genre_id
where m.movie_id not in (select
                              movie_id
						from movie_genres
						join genre on movie_genres.genre_id = genre.genre_id
						where genre_name = 'Horror')
order by m.movie_id , m.title asc;


--Task 17:- Find all 90's movies that have a higher budget than all movies released between '2000-01-01' and '2020-12-31'.
--Query:-
select
     movie_id,
	 title
from movie
where budget > all (select budget from movie where release_date between '2000-01-01' and '2020-12-31') 
and release_date between '1990-01-01' and '1999-12-31';


--Task 18:- Find The Busy Year for Julia Roberts.
--Query:-
select * from person;

select * from movie_cast;

select * from movie;

select
     extract(year from m.release_date) as busy_year
from movie	as m
join movie_cast as mc on m.movie_id = mc.movie_id
join person as p on mc.person_id = p.person_id
where p.person_name ='Julia Roberts'
group by extract(year from m.release_date)
order by count(distinct m.movie_id) desc
limit 1;


--Task 19:- Classify movies based on their genre and rating.
--Query:-
select
     title,
	 genre_name,
	 vote_average,
	 rating_category,
	 concat(genre_name , '- ',rating_category) as category
from (select
		     m.title,
			 g.genre_name,
			 m.vote_average,
			 (case
			     when m.vote_average >= 8.0 then 'High'
				 when m.vote_average >= 6.0 then 'Medium'
				 else 'Low'
			 end )as rating_category
	  from movie as m
	  join movie_genres as mg on m.movie_id = mg.movie_id
	  join genre as g on mg.genre_id = g.genre_id) as t
order by title  asc;	  