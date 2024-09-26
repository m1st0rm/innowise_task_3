-- Вывести количество фильмов в каждой категории, отсортировать по убыванию.
select category.name, count(*) as films_in_category_count
from category
inner join film_category on category.category_id = film_category.category_id
group by category.name
order by films_in_category_count desc;