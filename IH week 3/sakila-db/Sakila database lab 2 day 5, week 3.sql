## Sakila database lab 2 day 5, week 3
use sakila;

# How many copies of the film Hunchback Impossible exist in the inventory system?
select inventory_id from inventory where film_id = (
select film_id from film where title = 'Hunchback Impossible');

# List all films whose length is longer than the average of all the films.
select title, length from film where length > (select avg (length) from film);

# Use subqueries to display all actors who appear in the film Alone Trip.
select first_name, last_name from actor where actor_id in 
(select actor_id from film_actor where film_id in 
(select film_id from film where title = 'Alone trip'));

# Sales have been lagging among young families, and you wish to target all family movies for a promotion. **
# Identify all movies categorized as family films.
select title from film where film_id in 
(select film_id from film_category where category_id in 
(select category_id from category where name = 'Family'));

# Get name and email from customers from Canada using subqueries. Do the same with joins. 
select first_name, last_name, email from customer where address_id in 
(select address_id from address where city_id in
(select city_id from city where country_id in 
(select country_id from country where country = 'Canada')));

select first_name, last_name, email
from customer
inner join address using (address_id)
inner join city using (city_id)
inner join country using (country_id)
where country = 'Canada';

# Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
# First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select title from film where film_id in 
(select film_id from film_actor where actor_id =
(select actor_id from
(select count(film_id) as prolificy_actor, actor_id from film_actor group by actor_id order by count(film_id)desc limit 1) s)); # calculate most prolific actor

-- walk trough class
-- outer
# select films ig actor is... filmids
#join to film table to get titles
-- inner 1
# select actor id from ...
# (select * where window function = 1) **this is an option
-- inner 2
# select actor - if that actor has acted in the most fims
#count (films) -  group by actor
# order by no of films, and pick the biggest
-- step 1
select actor_id, count(film_id)
from film_actor
group by actor_id
order by count(film_id) DESC limit 1;
-- step 2
select actor_id from
(select actor_id, count(film_id)
from film_actor
group by actor_id
order by count(film_id) DESC limit 1) af;
-- step 3
select title from film join film_actor using(film_id) where actor_id =
(select actor_id from
(select actor_id, count(film_id)
from film_actor
group by actor_id
order by count(film_id) DESC limit 1) af);

# Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie 
# the customer that has made the largest sum of payments **
select title from film
join inventory using (film_id)
join rental using (inventory_id)
where customer_id =
(select customer_id from
(select customer_id, sum(amount) as total_amount_spend from payment group by customer_id order by sum(amount) desc limit 1)s);

# Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.**
select customer_id, sum(amount) from payment group by customer_id having sum(amount)>
(select avg( total_amount_spend) from
(select customer_id, sum(amount) as total_amount_spend from payment group by customer_id)s);
