-- Вывести названия фильмов, которых нет в inventory. Написать запрос без использования оператора IN.

select film.title
from film
left join inventory on inventory.film_id = film.film_id
where inventory.inventory_id is null