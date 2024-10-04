-- Вывести топ 3 актеров, которые больше всего появлялись в фильмах в категории “Children”. Если у нескольких актеров одинаковое кол-во фильмов, вывести всех.

with actorappearances as (
    select
        actor.first_name,
        actor.last_name,
        count(*) as appearances_count,
        dense_rank() over (order by count(*) desc) as actor_rank
    from actor
    inner join film_actor on actor.actor_id = film_actor.actor_id
    inner join film on film_actor.film_id = film.film_id
    inner join film_category on film.film_id = film_category.film_id
    where film_category.category_id = (
        select category.category_id
        from category
        where category.name like '%Children%'
    )
    group by actor.actor_id, actor.first_name, actor.last_name
)
select first_name, last_name, appearances_count
from actorappearances
where actor_rank <= 3
order by appearances_count desc