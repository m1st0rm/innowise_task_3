-- Вывести города с количеством активных и неактивных клиентов (активный — customer.active = 1). Отсортировать по количеству неактивных клиентов по убыванию.

select city.city as city_name, sum(customer.active) as active_customers_count, (count(*) - sum(customer.active)) as inactive_customers_count
from customer
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
group by city.city_id, city.city
order by inactive_customers_count desc