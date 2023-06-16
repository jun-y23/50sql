-- select * from payment;

-- select * from payment where customer_id = 1;

-- select * from customer where first_name = 'KELLY';

-- select * from customer where last_name = 'KNOTT' and first_name = 'KELLY';

-- select first_name, last_name from customer where first_name = 'KELLY' or first_name = 'MARIA';

-- select first_name, last_name from customer where not (first_name = 'KELLY' or first_name = 'MARIA');

-- select first_name, last_name from customer where first_name in ('AARON', 'ADAM', 'ANN');

-- select payment_id, amount from payment where amount >= 6.99;

-- select payment_id, amount from payment where amount != 0.99;

-- select * from rental where return_date is NULL;

-- select rental_id, return_date from rental where return_date is not NULL;

-- select customer_id, first_name from customer where customer_id between 11 and 13;

-- select film_id, description from film where description like '%Amazing%';

-- select film_id, description from film where description not like '%Amazing%';

-- select count(*) from payment;

-- select distinct(customer_id) from payment;

-- select count(distinct(customer_id)) from payment;

-- select customer_id, last_name from customer order by last_name asc;

-- select customer_id from customer order by customer_id desc;

-- select count(customer_id) as count from payment group by customer_id order by count desc limit 3;

--select payment_id, round(amount * 110) as yen from payment limit 10;

-- select payment_id, concat(round(amount * 110), 'yen') as yen from payment limit 10;

-- 中級

-- select p.payment_id, c.last_name, c.first_name from payment as p
-- left join customer as c on (p.customer_id = c.customer_id);

-- select * from payment as p
-- inner join customer as c on (p.customer_id = c.customer_id)
-- where c.first_name = 'BRIAN' and c.last_name = 'WYMAN';

-- select count(c.name) as filmcount, c.name from film as f
-- inner join film_category as fc on (f.film_id = fc.film_id)
-- inner join category as c on (fc.category_id = c.category_id)
-- group by c.name
-- having count(c.name) >= 65;

-- select
-- payment_id,
-- amount,
-- case
--   when amount > 5 then 'expensive'
--   when amount > 1 then 'modest'
--   else 'cheap'
-- end
-- from payment;

-- select count(*) from film
-- where description ~ '(Thou|Insi)ghtful';

-- select sum(p.amount) as total from payment as p
-- inner join customer as c on (c.customer_id = p.customer_id)
-- group by p.customer_id
-- order by total desc
-- limit 5
-- ;

-- select
-- CAST(payment_date as DATE) as p_date,
-- sum(amount) as dayAmount
-- from payment
-- group by p_date;
