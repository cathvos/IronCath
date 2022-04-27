## Sakila database lab day 3, week 3

# Select all the actors with the first name "Scarlett".
select * from actor where first_name = "Scarlett";

# How many films (movies) are available for rent and how many films have been rented?
select count(distinct inventory_id), count(distinct rental_date) from rental;

# What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select max(length) as max_duration, min(length) as min_duration from film;

# What's the average movie duration expressed in format (hours, minutes)?
select sec_to_time(avg(length)) from film;
#or
select floor(avg(length) /60) as hours, round(avg(length) % 60) as minutes from sakila.film;

select MOD (115,60);
select 115%60;

# How many distinct (different) actors' last names are there?
select count(distinct last_name) from actor;

# Since how many days has the company been operating (check DATEDIFF() function)? 
SELECT DATEDIFF(MAX(last_update),MIN(rental_date)) as comp_operating
FROM rental;

# Show rental info with additional columns month and weekday. Get 20 results.
SELECT DATE_FORMAT(rental_date, "%M") as month, DATE_FORMAT(rental_date, "%d") as weekday FROM rental limit 20;

# Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT CASE DATE_FORMAT(rental_date, "%a")
when 'Sun' or 'Sat' then 'weekend' 
else 'workday'
end as day_type from rental;

# How many rentals were in the last month of activity?
select date (max(RENTAL_DATE))-INTERVAL 30 DAY, DATE (MAX(RENTAL_DATE)) FROM RENTAL;

select count(*) from rental where  date(rental_date) between date ('2006-01-15') AND date ('2006-02-14');

# or with sub query
select count(*)
from rental where (rental_date)
>=( select max(rental_date)-interval 30 day
from rental)

