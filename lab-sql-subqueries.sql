-- Write SQL queries to perform the following tasks using the Sakila database:

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select  temp.title , count(inventory_id) as num_copies
from inventory
join (select title, film_id from film where title = "Hunchback Impossible") as temp
on temp.film_id = inventory.film_id
group by temp.film_id;
-- i think i made it too complicated below is a simpler version

select count(inventory_id) as num_copies
from inventory where film_id = (select film_id from film where title = "Hunchback Impossible");

-- List all films whose length is longer than the average length of all the films in the Sakila database.

select title, length
from film
where length > (select avg(length) from film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".

select actor_id, first_name, last_name 
from actor
where actor_id in (select actor_id from film_actor where film_id in
													(select film_id from film where title = 'Alone Trip'));
                                                    

                                                    
-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

select title
from film 
where film_id in (select film_id from film_category where category_id in
											(select category_id from category where name = "Family"));

-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
select cust.first_name, cust.last_name,  cust.email
from customer as cust
left join address as a
on cust.address_id = a.address_id
 left join city as c
on a.city_id = c.country_id
where country_id in (select country_id from country where country = "Canada");
-- there's one person?

-- select *
-- from customer as cust
-- left join address as a
-- on cust.address_id = a.address_id
-- left join city as c
-- on a.city_id = c.country_id
-- left join country as country
-- on country.country_id = c.country_id
-- order by country  ;

-- Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.
select title from film;

-- 107 actor id

select title from film as f
join film_actor as fa
on f.film_id = fa.film_id
where fa.actor_id = "107" 
;

select count(fa.actor_id) as apps, a.actor_id
from film_actor as fa
join actor as a 
on a.actor_id = fa.actor_id
group by a.actor_id
order by apps desc
;


-- Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.



-- Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.
select customer_id, total_spent
from 
	(select customer_id, sum(amount) as total_spent
	from payment
	group by customer_id) as client_spending
	where total_spent > 
								(select avg(total_spent) 
                                from 
									(select customer_id, sum(amount) as total_spent 
                                    from payment
									group by customer_id) as avg_spending);


