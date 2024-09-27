-- Вывести категорию фильмов, на которую потратили больше всего денег.

select category.name, sum(payment.amount) as spent_on_category
from category
inner join film_category on category.category_id = film_category.category_id
inner join inventory on film_category.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
group by category.category_id, category.name
order by spent_on_category desc
limit 1