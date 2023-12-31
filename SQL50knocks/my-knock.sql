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

-- select
-- sum(amount),
-- extract(MONTH from payment_date) as month
-- from payment
-- group by month
-- order by month asc

-- select
--   left(
--     cast(payment_date as VARCHAR),
--     7
--   ) as yyyymm,
--   sum(amount) as total
-- from payment
-- group by yyyymm
-- order by yyyymm;


-- select
--   sum(amount)
-- from payment
-- where payment_date > '2022-01-01' and payment_date < '2022-02-01';
-- where cast(payment_date as date) between '2022-01-01' and '2022-01-31';

-- 応用
-- select
--   max(tbl.total),
--   min(tbl.total),
--   avg(tbl.total)
-- from (
--   select
--     customer_id,
--     sum(amount) as total
--   from payment
--   group by customer_id
-- ) as tbl;


-- select
--   c.last_name
-- from customer as c
-- inner join payment_p2022_05 as p5 on c.customer_id = p5.customer_id;
--
-- select
--  c.last_name
-- from customer as c
-- where c.customer_id in (
--   select customer_id from payment_p2022_05
-- );


-- select
--   distinct(customer_id)
-- from
--   payment_p2022_01
-- intersect
-- select
--   distinct(customer_id)
-- from
--  payment_p2022_02
-- intersect
-- select
--   distinct(customer_id)
-- from
--  payment_p2022_03;

-- select
--   distinct customer_id
-- from payment_p2022_05
-- except
-- select
--   distinct customer_id
-- from payment_p2022_01
--

-- select distinct customer_id
-- from payment_p2022_01
-- union
-- select distinct customer_id
-- from payment_p2022_05
-- order by customer_id asc
-- limit 3;

-- WITH loyal_customers as (
--   select
--     customer_id,
--     count(*) as cnt
--   from payment_p2022_01
--   group by customer_id
--   having count(*) >= 5
-- )
--
-- select c.* from customer as c
-- inner join loyal_customers as lc on lc.customer_id = c.customer_id;

-- select count(p1.*) as cnt, rank() over(order by cnt), cl.name from payment_p2022_01 as p1
-- inner join customer_list as cl on cl.id = p1.customer_id
-- group by p1.customer_id, cl.name
-- order by cnt desc;
-- ;

-- select
-- cl.name,
-- count(*) as cnt,
-- rank() over (
--   order by count(*) desc
-- ) as ranking
-- from payment_p2022_01 as p
-- inner join customer_list as cl on p.customer_id = cl.id
-- group by cl.name


-- 累積比率=累積利用回数 / 全体の利用回数

-- partition
-- over


-- select
-- cl.id,
-- cl.country,
-- count(*) as cnt,
-- round(sum(count(*)) over(
--   partition by cl.country
-- ),2) sum,
-- rank() over(
--   partition by cl.country
--   order by count(*) desc
-- )
-- from payment_p2022_01 as p
-- inner join customer_list as cl on cl.id = p.customer_id
-- group by cl.id, cl.country;

-- select
--   cl.country,
--   count(*) as count,
--   rount(
--   sum(count(*)) over (
--     order by count(*) desc
--     rows between
--       unbounded preceding
--       and current row
--   ) / sum(count(*)) oevr (), as cumulative_count,
-- from payment_p2022_01 as p 
-- inner join customer_list as cl on cl.id = p.customer_id
-- group by cl.country
-- order by count desc;

select
  cast(payment_date as DATE) as d,
  count(*),
  round(AVG(count(*)) over (
    order by cast(payment_date as DATE) asc
    rows between
      2 preceding
      and current row
  ), 2) as heikin
from payment
where cast(payment_date as DATE) between '2022-04-06' and '2022-04-12'
group by d
order by d asc


Group by 集約関数は１行にグループ化（集約）して、そのグループに対して、そのグループ内の最大値や平均とかを集約関数を使って出力できる
行のグループに対して単一の集計値を返す

window関数(分析関数)は入力行のグループに対して分析関数を計算することで行ごとに単一の値を返す

