-- SQL Assignment 3: Joins and Subqueries

-- #1 List all customers who live in Texas (use JOINs)

select customer_id as "Customer ID", first_name as "First Name", last_name as "Last Name", district as "State"
from customer
left join address
on customer.address_id = address.address_id
where district = 'Texas'


-- 2. Get all payments above $6.99 with the Customer's Full Name

select customer.customer_id as "Customer ID", payment_id as "Payment ID", first_name as "First Name", last_name as "Last Name", amount as "Amount"
from customer
left join payment
on customer.customer_id = payment.customer_id 
where amount > 6.99

-- 3. Show all customers names who have made payments over $175 (use subqueries)

select first_name as "First Name", last_name as "Last Name", amount as "Amount"
from customer
full join payment
on customer.customer_id = payment.customer_id 
where amount in (
	select amount
	from payment
	-- I checked the payment table and the highest value for a payment is $129.99 so this won't return anything
	where amount > 175
);

-- Only one payment exceeds $129
select * from payment p 
where p.amount > 129

-- 4. List all customers that live in Nepal (use the city table)

select first_name as "First Name", last_name as "Last Name", city as "City"
from customer c
full join address a
on c.address_id = a.address_id 
full join city ci
on a.city_id = ci.city_id
-- Don't know if this was just an old assignment, but there's no Nepal in the city table. I tested with other cities and it worked
where city = 'Nepal'


-- 5. Which staff member had the most transactions?

select first_name, last_name, sum(rental_id) as "Number of Rentals Transactions"
from staff s 
left join rental r 
on s.staff_id = r.staff_id 
group by first_name, last_name
order by sum(rental_id) desc

-- 6. How many movies of each rating are there?

select rating as "Rating", count(f.film_id) as "# of Films"
from film_category fc 
left join film f 
on fc.film_id = f.film_id 
group by f.rating 
order by count(f.film_id) desc

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)

select first_name as "First Name", last_name as "Last Name", count(payment_id) as "# of Single Payments above $6.99"
from customer c 
left join payment p 
on c.customer_id = p.customer_id 
where amount in(
	select amount
	from payment
	where amount > 6.99
)
group by first_name, last_name 
order by count(payment_id) desc;


-- 8. How many free rentals did our stores give away?

select count(distinct rental_id) as "Number of Free Movies Given Away"
from payment p
where amount = 0
group by amount

-- Or more specifically, who got the free movies, what were they titled, and what the customer should've paid

select first_name, last_name, title as "Movie Title", rental_rate as "Amount They Should've Paid", amount as "Amount They Paid :("
from customer
left join payment
on customer.customer_id = payment.customer_id
left join rental
on payment.rental_id = rental.rental_id
left join inventory
on rental.inventory_id = inventory.inventory_id 
right join film 
on inventory.film_id = film.film_id 
where amount = 0















