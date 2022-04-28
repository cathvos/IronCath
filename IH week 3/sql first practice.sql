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













