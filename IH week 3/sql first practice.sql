use bank; # setting schema to default

SELECT * FROM bank.trans;  # * means select all
select account_id, amount, balance from bank.trans limit 10;
# select, from, where, group by, having, order by, limit most important queries to learn this week
select account_id as id, amount as amnt, balance, amount-balance  #arbitrary sum
as difference # give it an alias 
from bank.trans # the table
order by account_id DESC# default is asc desc if you want desc if wanted
limit 10; # pick top 10


# count the number of records in a table -> count (distinct ) only count a repeated record once.

select count(*) from trans;
select count(distinct account_id) from trans;

select distinct operation from trans; # likt the unique values function in python

## excercise ##

# Use the select statement to perform a simple mathematical calculation to add two numbers.
select account_id, amount, balance, amount+balance  #arbitrary sum
as sum # give it an alias 
from bank.trans; # the table

# Use an appropriate select statement to retrieve a list of unique card types from the bank database, 
# table card. (Hint: You can use the DISTINCT function here.)
select distinct card.type from card;


# Get a list of all the district names in the bank database. A suggestion is to use the files_for_activities/case_study_extended here to 
# work out which column is required here because we are looking for the names of places, not just the IDs. You should have 77 rows.
select * from district;
select distinct A2 from district;

# Bonus: Revise your query to also show the Region, and limit the results to just 30 rows.
select distinct A2,A3 from district limit 30;

# Get again the district names and the regions but use aliases to display the corresponding 
# columns as district_name and region_name respectively. Limit the query to the first 30 rows.
select distinct A2 as district_name ,A3 as region_name from district limit 30;

# Get all the types of the card as type_of_card and the issue date as issue_date from card client and alias the table as bc.
select type as type_of_card, issued as issue_date from card as bc;

# operators and logical clauses
# + - * /
# ==         >= <=.       != <> different from/ is not
# WHERE

# from the bank loan, get loan_id and amount in thousands
select loan_id, amount/1000 as amountk from loan;

# only loans where status is A or B
select * from loan where status = 'A'or status = 'B';

# only loans where status is A or B
select * from loan where status in ('A','B');

# only loans where status is not A or B
select * from loan where status <>'A' and status <> 'B';

# lets add an AND to our WHERE
# only loans where status is B and amount >100,000
select * from loan where status = 'B' and amount > 100000 order by amount desc;

# duration is less or equal 24 months
select * from loan where status = 'B' and amount > 100000 and duration <=24 order by amount desc;

# ceiling, floor, round, min max
# the biggest and smallest transaction
select max(amount), min(amount) from loan;

## average order amount
select avg(amount)from bank.order;
select round(avg(amount),2), ceiling (avg(amount)), floor(avg(amount)) from bank.order;

# useful string functions _ lower upper length concat left right ltrim rtrim
select A2, left (A2,5) from district;

#Select districts and salaries (from the district table) where salary is greater than 10000. Return columns as district_name and average_salary.
select A2 as district_name, A11 as average_salary from district where A11 > 10000;

#Select those loans whose contracts finished and were not paid. Hint: You should be looking at the loan column and you will need the extended 
#case study information to tell you which value of status is required.
select * from loan where status = 'B';

#Select cards of type junior. Return just the first 10 in your query.
select * from card where type = 'junior' limit 10;


#Select those loans whose contract is finished and not paid back. Return the debt value from the status you identified in the last activity, 
#together with loan id and account id.
select loan_id, account_id, payments from loan where status = 'B';

#Calculate the urban population for all districts. Hint: You are looking for the number of inhabitants and the % of urban inhabitants in each 
#district. Return columns as district_name and urban_population.
select A2, A4, A10,round((A4* A10)/100)as urban_population from district;


#On the previous query result - rerun it but filter out districts where the rural population is greater than 50%.
select A2, A4, A10,round((A4* A10)/100)as urban_population from district where A10 <=50;

# dates convert(int,date), substring_index(), date_format()
select *, convert(account.date,date) as mydate from bank.account;
select *, convert(substring_index(issued, ' ',1),date)as new_date from bank.card;
select *, date_format(convert(loan.date,date),'%y-%m-%d') as newdate from bank.loan;

# nulls is null(), where is not null

#case - we have done in tableau CASE WHEN THEN ELSE END
# in loan table replace ABCD with A=finished, no problem, B=finished, client in debt, C= running, no problems, D=running, client in debt
select*, CASE status 
when 'A' then 'finished, no problem' 
when 'B' then 'finished, client in debt' 
when 'C' then 'running, no problems'
when 'D' then 'running, client in debt'
end as description from loan;

# Day 3
# ORDER BY
use bank;

select * from trans order by date DESC;

select * from trans order by date, amount; # create a partition inside the results

select * from trans where k_symbol='UROK' order by date, amount; # where before order by

select * from trans where k_symbol='UROK' and operation <> '' order by date, amount; # blanks in operation

# LIKE '%' (sub) string - wildcard
select * from district where A2 like '%u%' or A2 like 'U%'; # all containing a u at the beginning or middle

select * from district where A2 REGEXP'[u]';  # looking for u anywhere
select * from district where A2 REGEXP'[uxy]';  # looking for u, x of y anywhere
select * from district where A2 REGEXP'pra?';  # looking for characters in this order anywhere
select * from district where A2 REGEXP'[:digit:]';  # looking for numbers

select * from district where A2 like '_____'; # all that has 5 caracters

# Get transactions in the first 15 days of 1993.
select * from trans where  date(date) between date ('930101') AND date ('930115');

# Find the different values from the field A2 that start with the letter 'M'.
select * from district where A2 like 'm%' or A2 like 'M%';

# Find the different values from the field A2 that end with the letter 'M'.
 select * from district where A2 like '%m' or A2 like '%M';

# group by - aggregate the data by ... something
# aggregations: count, dount distinct,sum, min, max, average
select sum(amount), duration, status from loan group by duration, status;

SELECT 
    account_id,
    COUNT(order_id) AS no_orders,
    ROUND(SUM(amount), 2) AS total
FROM
    bank.order
GROUP BY account_id
HAVING COUNT(order_id) > 1 # when using group by you can´t use where on these results, you´ll have to use having
ORDER BY COUNT(order_id) DESC;


use sakila;
# Get the total rental revenue using the column amount from table payment. Display it as Total_revenue.
select round(sum(amount),2) as total_revenue from payment;
# Get the total rental revenue by customer_id sorted by total benefit in descending order.
SELECT 
    customer_id,
    ROUND(SUM(amount), 2) AS total_rev
FROM
    payment
GROUP BY customer_id
ORDER BY total_rev DESC;

# less flexible - more like SQL
SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY';
SELECT @@GLOBAL.sql_mode;

use bank;
# window functions - aggregatetion - but you don´t want a summary table
select district_id, count(account_id) from account
group by district_id;

select * , round(avg(amount)over(),2) as avg_amount
from loan
where duration = 12; # the over function allows you to create a new column assigning the new number to all lines

# partition by duration
select * , round(avg(amount)over(partition by duration),0) as avgbydur
from loan; # average calculated based on all 12 month loans

select * , round(avg(amount)over(partition by status, duration),0) as avgbydur
from loan;# average calculated based on all 12 month A, B or C loans

select account_id, date,amount,round(sum(amount) over(partition by account_id order by date),0)as running_sum
 from trans where account_id in (1,2,3); # creating a cummulative sum column.
 
#Create a query to show for each rating the average movie length (displayed as Mean_length). Sort the results in descending order of Mean_length.
use sakila;

SELECT 
    rating,
    ROUND(AVG(length), 2) AS mean_length
FROM
    film
GROUP BY film_id
ORDER BY mean_length DESC;

# Create a query to show for each movie the following data (in this order):
# rating,title, length
# mean length by rating displayed as Mean_length_by_rating
# ranking displayed as Ranking (showing from the longest to the shortest movie within the same rating).
# This means sorting the results by rating and descending order of movie length.
 
select rating, title, length , round(avg(length)over(partition by rating),0) as mean_length_by_rating
,rank() over(partition by rating order by length DESC)as ranking
from film; # using rank

select rating, title, length , round(avg(length)over(partition by rating),0) as mean_length_by_rating
,dense_rank() over(partition by rating order by length DESC)as ranking
from film; # using dense rank

# Day 4
 use bank;
 # join function / it can help to alias the tables to understand what is what (c. is client d. is district
 # how many clients we have per district?
 select d.A2 as district_name, d.A3 as region_name, count(distinct client_id) as nr_of_clients
 from district d # left table
 left join client c #right table and join table
 on d.A1 = c.district_id # join clause(s)
 # using() if the fields are named the same
 group by d.A2,d.A3;
 
 # how many loans and avg amount per account
 select a.account_id, a.date, count(l.loan_id), avg(l.amount)
 from loan l# left table
 inner join account a # right table
 using (account_id) # join clause
 group by a.account_id, a.date; # aggreg process
 
## excersise
# Get a list of districts ordered by the number of clients (descending order). Name the columns as: 
# District_name and Number_of_clients respectively.
select d.A2 as district_name, count(distinct client_id) as number_of_clients
from district d # left table
inner join client c #right table and join table
on d.A1 = c.district_id # join clause(s)
# using() if the fields are named the same
group by d.A2
order by number_of_clients DESC;

# Get a list of regions ordered by the number of clients (descending order). Name the columns as: 
# Region_name and Number_of_clients respectively.
select d.A3 as region_name, count(distinct client_id) as nr_of_clients
 from district d # left table
 left join client c #right table and join table
 on d.A1 = c.district_id # join clause(s)
 # using() if the fields are named the same
 group by d.A3
 order by nr_of_clients desc;
 
# Get the number of accounts opened by district and year. Name the columns as: 
# District_name, Year and Accounts_opened. Order the results by District_name and Year.
select d.A2 as district_name, extract(YEAR FROM a.date) as year, count(distinct a.account_id) as accounts_opened
from district d # left table
inner join account a #right table and join table
on d.A1 = a.district_id # join clause(s)
# using() if the fields are named the same
group by d.A2, extract(YEAR FROM a.date)
order by d.A2, extract(YEAR FROM a.date);

# example where left and right matters
# from account to loan
select * from account
inner join loan
using(account_id);

select * from account # you can have an account without a loan
left join loan
using(account_id);

select * from account # you can´t have a loan without an account
right join loan
using(account_id);

# example of using multiple tables - joining 3 tables loan, account, district
# how many loans per region
select d.A3 as region, count(l.loan_id) as noofloans, count(a.account_id) as noonaccounts
from loan l
inner join account a
using (account_id)
inner join district d
on a.district_id = d.A1
group by A3;

# Extend the query below and list district_name, client_id, and account_id for those clients who are the owner of the account. 
# Order the results by district_name:

select da.A2 as district_name, c.client_id, d.account_id  
from bank.disp d
join bank.client as c using(client_id)
join bank.district as da on c.district_id =da.A1
inner join account a
using (account_id)
order by da.A2; ## not working yet need to check solution

# DDL(definition) data definition language and DML(manipulate)
# create alter drop truncate rename update

create database booksauthors;
use booksauthors;

-- create the needed tables
drop table if exists authors;
create table authors
(author_id INT AUTO_INCREMENT NOT NULL, author_name VARCHAR(30) DEFAULT NULL, country VARCHAR (30) DEFAULT NULL, PRIMARY KEY (author_id));

drop table if exists books;
create table books
(book_id INT AUTO_INCREMENT NOT NULL,
author_id INT NOT NULL, 
book_name VARCHAR(50) DEFAULT NULL, 
PRIMARY KEY (book_id), KEY idx_fk_author_id (author_id), 
constraint fk_author_id foreign key(author_id)references authors(author_id) on delete restrict on update cascade);

-- insert data into tables
insert into authors (author_name, country)
values ('Aja Barber', 'USA'), ('Robin Wall Kimmerer', 'USA'), ('Noah Gordon', 'USA'), ('Nazanine Hozar', 'Iran'), ('Mark Manson', 'USA');

select * from authors;
# UPDATE authors set country = 'U.S.A' where author_id in (1,2,3,5);
# you can use the update function to correct any mistakes

# INSERT INTO authors()...

insert into books (author_id,book_name)
values (1,'Consumed'), (2,'Braiding sweetgrass'), (3,'La bodega'), (4,'Aria'), (5,'The subtle art of not giving a f*ck');

select * from books;

select * from books
right join authors 
using(author_id);

# CTE´S - common table expressions
# we want to join x + y but x does not exist
-- transactions table - get the total amount for each account and any acc info
-- then draw on that table to get information
-- use that table to join to another table

with cte_loan as ( select*from loan)
select loan_id from cte_loan
where status = 'B';

# subqueries - a query inside a query
# step 1 write your inner query and check if it works, step 2 write your out query after and check it
# question is; which loans are bigger then the average?
select avg (amount) from loan; # sub query
select * from loan where amount > (select avg (amount) from loan); # full query
-- one value(==>), a column of values (IN), a table of values (sub query needs an alias)

# Find out the average of the number of transactions by account.
# Hint: Compute first the number of transactions by account.

select account_id, count(trans_id) as transact from trans group by account_id; # sub query

select avg (transact) from
(select account_id, count(trans_id) as transact from trans group by account_id) s; # full query


# Get a list of accounts from Central Bohemia using a subquery
select A1 from district where A3 LIKE '%Bohemia'; # sub query
select account_id from account where district_id in (select A1 from district where A3 LIKE 'Central Bohemia'); # full query

# views - ready made queries
select * from sakila.sales_by_film_category;
## 
use bank;
create view clients_loans_combo  as
select c.client_id, c.district_id, l.loan_id, l.status, l.amount, l.duration, l.payments, l.date as loan_date 
from client c
join disp dp using (client_id)
join account a using (account_id)
join loan l using (account_id)
where dp.type = 'OWNER';

select * from bank.clients_loans_combo;

# more window fx - optional

use sakila;
select * from rental;












