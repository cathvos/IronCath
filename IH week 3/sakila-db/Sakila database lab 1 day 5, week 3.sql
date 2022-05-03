## Sakila database lab 1 day 5, week 3
use sakila;

# Write a query to display for each store its store ID, city and country.
select store_id, city, country
from store
inner join address
using (address_id)
inner join city
using (city_id)
inner join country
using (country_id)
group by store_id;

# Write a query to display how much benefit amount, in dollars, each store brought in.
select store_id, sum(amount) as benefit_in_USD_per_store
from payment
inner join staff
using (staff_id)
inner join store
using (store_id)
group by store_id;

# What is the average running time of films by category?
select name, avg(length) as avg_running_time
from film
inner join film_category
using (film_id)
inner join category
using (category_id)
group by name;

# Which film categories are longest on average?
select name, avg(length) as avg_running_time
from film
inner join film_category
using (film_id)
inner join category
using (category_id)
group by name
order by avg_running_time desc
limit 3;

# Display the most frequently rented movies in descending order.
select title, count(inventory_id) as frequency_rental
from rental
inner join inventory
using (inventory_id)
inner join film
using (film_id)
group by title
order by frequency_rental desc;

