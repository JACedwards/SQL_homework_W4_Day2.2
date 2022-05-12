--Question 1:  How many actors are there with the last name ‘Wahlberg’?

select count(last_name)
from actor
where last_name = 'Wahlberg';

--Answer:  There are 2 actors named 'Wahlberg.'


--Question 2: How many payments were made between $3.99 and $5.99?

select count(amount)
from payment
where amount > 3.98 and amount <6.00;

--Answer: There are 5,561 payments between #3.99 and $5.99.


--Question 3: What film does the store have the most of?
select film_id, count(inventory_id)
from inventory
group by film_id

	--Answer 3:  Closest I could come was using the above code and then clicking the "count" button and filtering by what it said was the highest number.  That resulted in what looked like 70 films all having a count of 8, so assume I'm doing something(s) wrong still.


--Question 4: How many customers have the last name ‘William’?

select last_name
from customers
where last_name = 'William'

	--Answer 4:  0 customers with last name 'William." I think there are some 'Williams,' but no 'William' for last name. (I searched every table that had "customer/s" somewhere in its name and found 0 customers who have the last name 'William.'  The code above is just one of these searches, I subsituted all the tables with costumer/s in the name where "customers" is in this search.)


--Question 5: What store employee (get the id) sold the most rentals?

select staff_id, count(staff_id)
from payment
group by staff_id 
order by count(staff_id)
	--Answer 5:  Staff with id 2 sold the most rentals.


--Question 6: How many different district names are there?

select Count (distinct district) as "Number of districts"
from address;

	--Answer to Question 6:  378 different district names.


--Question 7: What film has the most actors in it? (use film_actor table and get film_id)

select film_id, count(actor_id)
from film_actor
group by film_id

	--Answer 7:  Film 508 has the most actors in it.  I couldn't figure out how to get this directly, so I used the code above and then hit the sort button in the count column.


--Question 8: From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)

select store_id, last_name
from customer
where store_id = 1 and last_name like '%es'
--Answer:  There are 13 customers whose name ends in 'es' at stor_id 1.  Closest I could come was code above which gave me all the names of the cusomers, ending in "es," but couldn't figure out how to return the count of those names.  There were few enough that I just manually counted (or scrolled down and looked at row number next to last name)


--Question 9: How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
--with ids between 380 and 430? (use group by and having > 250)

select rental_id, customer_id, amount
from payment
group by amount, rental_id, customer_id
having rental_id > 250 and customer_id >379 and customer_id < 431
order by amount;

--Answer 9: The above is the closest I could get.


--Question 10--part 1: Within the film table, how many rating categories are there? 


select Count(distinct rating)
from film
	--Answer to 10--part 1 is 5


--Question 10 -- Part 2:  And what rating has the most movies total?

select rating, count(title)
from film
group by rating

--Answer to 10 -- Part 2:
	--PG-13	223
	--NC-17	209
	--G	179
	--PG	194
	--R	195

























--SAM'S LECTURE NOTES BEGIN HERE

-- Two dashes is a single line comment
-- Hello SQL World!

-- Today we will be discussing DQL - data query language
-- specifically, simple select statements

-- The "hello, world" program of SQL: select all rows and all columns from a table
select *
from actor;

-- A select statement needs at minimum two clauses:
-- a select clause to specify which columns are being selected
-- and a from clause to specify which table we are selecting from

-- select * from <table>; commonly used as an exploratory query
-- to show you (the developer) what information exists within a table
select * from customer;


-- what if I didnt want every column in a table
-- just specify the columns you'd like to query/select in the select clause
select first_name, last_name
from actor;

-- WHERE clause
-- filter our results by a condition- this will alter the rows that get returned
select first_name, last_name
from actor
where first_name = 'Nick';

-- The order of clauses in a statement matters
-- As we discuss more clauses I'll lay out the specific order but it generally follows the rule
-- Column selection -> Table selection -> Modifiers -> Grouping -> Ordering

-- when writing a where clause with a string - you can use the LIKE operator
-- this enables the use of wildcards aka regex-like patterns
select first_name, last_name
from actor
where last_name like 'Wahlberg';

-- wildcards:
-- % and _
-- % represents any number of characters (could be 0, could be 15000000129301)
-- _ represents a single instance of a character
select first_name, last_name
from actor
where last_name like 'W%';

select first_name, last_name
from actor
where first_name like 'A___';

select first_name, last_name
from actor
where first_name like '%nn%';

-- We've seen a where clause with strings (aka varchars)
-- how do where clauses work for numerical data?
-- Comparison operators:
-- Greater than >
-- Less than <
-- = like shown above
-- Greater or equal >=
-- Less or equal <=
-- Not equal <>

-- explore my data with a SELECT ALL query
select * from payment;

-- query for all payments greater than $10
select customer_id, amount
from payment
where amount > 10;

-- combining operators in our where clause
-- just like python we can combine multiple conditionals with and/or 
select customer_id, amount
from payment
where amount < 0.5 or amount > 300;

-- an alternative to values falling within a range:
-- between operator
-- optional not to flip the behaviour
select customer_id, amount
from payment
where amount not between 10 and 20;


-- can combine conditionals in different columns into one where clause
-- don't need to select a column in order to use that column in the where clause
select first_name, last_name
from actor
where first_name like 'K%' and actor_id > 100;

-- ORDER BY clause
-- let's us sort our results
-- default is ascending order
-- can specify descending with DESC
select customer_id, amount
from payment
where amount > 0
order by amount DESC;

-- Order of the clauses we've discussed so far:
-- select <columns>
-- from <table>
-- where <conditional>
-- order by <column>;

-- The use of SQL aggregations -> aka how we take many rows of data and condense them
-- into a single easy to digest piece of information
SELECT *
FROM payment
WHERE amount = 0.99;
-- How many $0.99 payments have I received
-- we can find the answer by looking at total rows in a normal query
-- or we can run an aggregate as part of our query
-- and get the actual number as a result

-- instead of selecting a column, I can select an aggregate function
-- Option for aggregates: COUNT(), SUM(), AVG(), MIN(), MAX()
select count(amount)
from payment
where amount = 0.99;
-- 2,683 payments of $0.99

-- How much money did we make from 2683 payments of $0.99
select sum(amount)
from payment
where amount = 0.99;
-- $2,656.17

select * FROM actor;

-- What was the average payment amount?
select avg(amount)
from payment;
-- $3.01

-- What if I want to select other columns in addition to my aggregate result
-- I can't without another clause
-- use the GROUP BY clause to specify how non-aggregates should behave when used alongside an aggregate
-- I want to know the number of payments of each amount
select count(amount), amount
from payment
group by amount;

-- which payment amount have we made the most money off of?
select amount, sum(amount)
from payment
group by amount
order by sum(amount) desc;
-- we've made the most money off of $4.99 sales

-- Which customer spent the most money?
select customer_id, sum(amount)
from payment
group by customer_id
order by sum(amount) desc;
-- customer_id 6 spent the most money

-- how was customer 6's spending distributed?
-- we can do a multiple group by
-- aka we can primarily group by customer_id and secondarily group by amount
-- I can include a where clause with my aggregate
select customer_id, amount, count(amount), sum(amount)
from payment
where customer_id = 6
group by customer_id, amount;

-- Which of my customers have spent more than $1000?
-- To answer this question, we essentially need to apply a conditional to our aggregate
-- HAVING clause
-- the HAVING clause performs the conditional role for AGGREGATES
-- just like the WHERE clause is the conditional clause for regular columns
select customer_id, sum(amount)
from payment
group by customer_id
having sum(amount) > 1000
order by customer_id;
-- Two customers spent more than $1000
-- customer_id 5 and customer_id 6

-- Who are customer 5 and customer 6?
select *
from customer
where customer_id = 5 or customer_id = 6;

-- What if I wanted to write a query to directly in one query access the names and emails of my best customers along with the amount they spent?
-- In other words, how do I get results from two tables at once?
-- I can combine queries in multiple tables with a join
-- If we have two tables with a shared column
-- such as customer_id in both the customer and payment table
-- we can combine data from both tables by joining it on that shared column 
-- in order to perform a join you need a JOIN clause and an ON clause

-- SELECT <columns>
-- FROM <primary table>
-- JOIN <secondary table>
-- ON <primary_table.column> = <secondary_table.column>;
select payment.customer_id, first_name, last_name, sum(amount)
from payment
join customer
on payment.customer_id = customer.customer_id
group by payment.customer_id, first_name, last_name
having sum(amount) > 1000;

-- Two separate tables:
select * from customer;
select * from payment;
-- they share the customer_id column
-- If we need to answer a question about data in both tables
-- We can join them together on that shared column 
-- and access information from both tables in a single query