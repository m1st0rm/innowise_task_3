-- Вывести 10 актеров, чьи фильмы большего всего арендовали, отсортировать по убыванию.

select actor.first_name, actor.last_name, sum(t1.film_rentals_count) as actor_film_borrow_count
from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join (select film.film_id, count(*) as film_rentals_count
					from film
					inner join inventory on film.film_id = inventory.film_id
					inner join rental on inventory.inventory_id = rental.inventory_id
					group by film.film_id
					order by film_rentals_count desc
) t1 on film_actor.film_id = t1.film_id
group by film_actor.actor_id, actor.first_name, actor.last_name
order by actor_film_borrow_count desc
limit 10