-- Вывести категорию фильмов, у которой самое большое кол-во часов суммарной аренды в городах (customer.address_id в этом city), и которые начинаются на букву “a”.
-- То же самое сделать для городов в которых есть символ “-”. Написать все в одном запросе.

(
    select category.name,
           sum(EXTRACT(EPOCH FROM (rental.return_date - rental.rental_date))) as category_summary_rental_time
    from category
    inner join film_category on category.category_id = film_category.category_id
    inner join inventory on film_category.film_id = inventory.film_id
    inner join rental on inventory.inventory_id = rental.inventory_id
    inner join customer on rental.customer_id = customer.customer_id
    inner join address on customer.address_id = address.address_id
    inner join city on address.city_id = city.city_id
    where rental.rental_date is not null and rental.return_date is not null
      and city.city like 'A%'
    group by category.category_id, category.name
    order by category_summary_rental_time desc
    limit 1
)

UNION

(
    select category.name,
           sum(EXTRACT(EPOCH FROM (rental.return_date - rental.rental_date))) as category_summary_rental_time
    from category
    inner join film_category on category.category_id = film_category.category_id
    inner join inventory on film_category.film_id = inventory.film_id
    inner join rental on inventory.inventory_id = rental.inventory_id
    inner join customer on rental.customer_id = customer.customer_id
    inner join address on customer.address_id = address.address_id
    inner join city on address.city_id = city.city_id
    where rental.rental_date is not null and rental.return_date is not null
      and city.city like '%-%'
    group by category.category_id, category.name
    order by category_summary_rental_time desc
    limit 1
);