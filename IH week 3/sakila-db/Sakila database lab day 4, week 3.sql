## Sakila database lab day 4, week 3

use sakila;
# Using the rental table, find out how many rentals were processed by each employee.
SELECT 
    staff_id,
    ROUND(count(rental_id),0) AS rentals_per_employee
FROM
    rental
GROUP BY staff_id;

# Using the film table, find out how many films were released.
select COUNT(release_year) from film;

# Using the film table, find out how many films there are of each rating. Sort the results in descending order of the number of films.
select rating, COUNT(film_id) from film GROUP BY rating;

# Which kind of movies (rating) have a mean duration of more than two hours?
select rating, avg(length) as avg_length from film GROUP BY rating having avg_length >= 120;