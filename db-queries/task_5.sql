-- Вывести топ 3 актеров, которые больше всего появлялись в фильмах в категории “Children”. Если у нескольких актеров одинаковое кол-во фильмов, вывести всех.

select actor.first_name, actor.last_name , count(*) as appearances_count
from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join film on film_actor.film_id = film.film_id
inner join film_category on film.film_id = film_category.film_id
where film_category.category_id = (select category.category_id
						   from category
						   where category.name like '%Children%'
						 )
group by actor.actor_id, actor.first_name, actor.last_name
having count(*) in (select distinct count(*) as appearances_count
								from actor
								inner join film_actor on actor.actor_id = film_actor.actor_id
								inner join film on film_actor.film_id = film.film_id
								inner join film_category on film.film_id = film_category.film_id
								where film_category.category_id = (select category.category_id
														   from category
														   where category.name like '%Children%'
														 )
								group by actor.actor_id, actor.first_name, actor.last_name
								order by appearances_count desc
								limit 3)
order by appearances_count desc