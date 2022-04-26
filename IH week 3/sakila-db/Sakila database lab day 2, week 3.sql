## Sakila database lab day 2, week 3

# Get all the data from tables actor, film and customer.
select * from actor;

# Get film titles.
select title from film;

# Get unique list of film languages under the alias language. Note that we are not asking you to obtain the language per each film, 
# but this is a good time to think about how you might get that information in the future.
select distinct name as language from sakila.language;

# Find out how many stores does the company have?
select count(distinct store_id) from sakila.store;

# Find out how many employees staff does the company have?
select count(distinct staff_id) from sakila.staff;

# Return a list of employee first names only?
select first_name from staff;
