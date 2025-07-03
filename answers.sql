use restaurant_db;

-- 1. View the menu_items table.
select * from menu_items;

-- 2. Find the number of items on the menu.
select count(*) from menu_items;

-- 3.what are the least and most expensive list on the menu.
-- select max(price) as most_expensive, 
-- min(price) as least_expensive from menu_items;
select * from menu_items
order by price;

select * from menu_items
order by price desc;

-- 4.How many italian dishes are on the menu
select count(*) from menu_items
where category = "Italian";

-- 5.What are the least and most expensive italian dishes on the menu ?
select * from menu_items
where category ="Italian"
order by price
limit 1;

select * from menu_items
where category ="Italian"
order by price desc
limit 1;

-- 6. How many dishes are in each category
select count(item_name) as dishes,category 
from menu_items
group by category;

-- 7. what is the average dish price in each category 
select avg(price),category from menu_items
group by category;

--objective 2
-- 1. view the order details table
select * from order_details;

-- 2.what is the date range of the table
select min(order_date),max(order_date) from order_details;

-- 3.How many orders were made with this date range
select count(distinct(order_id)) from order_details;

-- 4. How many items were ordered within this date range
select count(*) from order_details;

-- 5. which orders has the most number of items
select order_id, count(item_id) as num_items 
from order_details
group by order_id
order by num_items desc;

-- 6. How many orders has more than 12 items
select count(*) from(
select order_id, count(item_id) as num_items 
from order_details
group by order_id) as t
where t.num_items >12;


--objective 3
-- 1. combine the menu_items and order_details tables into a single table.
select * from order_details as o
left join menu_items as m
on m.menu_item_id = o.item_id;

-- 2.what were the least and most ordered items? what categories were they in ?
select item_name,category, count(order_details_id) as num_purchases 
from order_details as o
left join menu_items as m
on m.menu_item_id = o.item_id
group by item_name,category
order by num_purchases;

-- 3.what were the top 5 orders that spent the most money?
select order_id,sum(price)as total_spend 
from order_details as o
left join menu_items as m
on m.menu_item_id = o.item_id
group by order_id
order by total_spend desc
limit 5;

-- 4. view the details of the highest spend order, what insights can you gather from that
select category,count(item_id) as num_items
from order_details as o
left join menu_items as m
on m.menu_item_id = o.item_id
where order_id=440
group by category;

-- 5.view the details of the top 5 highest spend orders. what insights can you gather from that
select order_id,category,count(item_id) as num_items
from order_details as o
left join menu_items as m
on m.menu_item_id = o.item_id
where order_id in (440,2075,1957,330,2675)
group by order_id,category;

