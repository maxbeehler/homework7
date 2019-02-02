create database hw;
use hw;

#1
select first_name, last_name from sakila.actor;

select concat(first_name, ' ', last_name) as "Actor Name" from sakila.actor;

#2
select * from sakila.actor
where first_name = "joe";

select * from sakila.actor
where last_name like "%GEN%";

select * from sakila.actor
where last_name like "%LI%"
order by last_name asc;

select country_id, country from sakila.country
where country in ("Afghanistan", "Bangladesh", "China");

#3
alter table sakila.actor
add description blob;

alter table sakila.actor
drop description;

select * from sakila.actor;

#4
select last_name, count(last_name) from sakila.actor
group by last_name;

select last_name, count(last_name) as "Number of Actors" from sakila.actor
group by last_name
having count(last_name) > 1;

update sakila.actor
set first_name = 'Groucho'
where first_name = 'Harpo';

update sakila.actor
set first_name = 'Harpo'
where first_name = 'Groucho';

#5
describe sakila.address;

select * from sakila.staff;
select * from sakila.address;

#6
use sakila;

select s.first_name, s.last_name, a.address
from staff s
join address a on s.address_id = a.address_id;

select * from payment;
select * from staff;

select staff.first_name, staff.last_name, sum(payment.amount) as 'total amount'
from staff join payment on staff.staff_id = payment.staff_id and payment.payment_date like '2005-08%'
group by staff.first_name, staff.last_name;

#6c
#select * from film_actor;
#select * from film;

select title, count(actor_id) as "# of Actors"
from film join film_actor on film.film_id = film_actor.film_id
group by title;

#6d
#select * from inventory;

select title, count(inventory_id) as "# of Copies" from film
join inventory on film.film_id = inventory.film_id
where title = "Hunchback Impossible";

#6e
#select * from payment;
#select * from customer;

select first_name, last_name, sum(amount) as "amount"
from payment join customer on payment.customer_id = customer.customer_id
group by payment.customer_id;

#7a
#select * from film;
#select * from language;

select title
from film
where title like 'K%' or title like 'Q%'
and
language_id = 1;

#7b
#select * from actor;
#select * from film_actor;

select first_name, last_name
from actor
where actor_id in 
(select actor_id from film_actor where film_id in 
(select film_id from film where title = "Alone Trip"));

#7c
#select * from customer;
#select * from address;
#select * from city;
#select * from country;

select first_name, last_name, email from customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;

#7d
#select * from category;
#select * from film_category;
#select * from film;

select title from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id and category.name = 'family';

#7e
#select * from rental;
#select * from inventory;
#select * from film;

select title, count(film.film_id) from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by title order by count(film.film_id) desc;

#7f
select * from payment;
select * from store;

select staff.store_id, sum(payment.amount) from payment
join staff on payment.staff_id = staff.staff_id group by store_id;

#7g
#select * from store;

select store_id, city, country from store
join address on store.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;

#7h

#select * from inventory;
#select * from category;
#select * from film_category;
#select * from payment;
#select * from rental;

select category.name, sum(payment.amount) from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id group by category.name;

#8a
create view homework as
select category.name, sum(payment.amount) from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id group by category.name;

#8b
select * from homework;

#8c
drop view homework;