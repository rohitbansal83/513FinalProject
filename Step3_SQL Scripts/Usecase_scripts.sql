--Use Case 1
--Top 10 most popular Breakfast items in New York since 2008.
select distinct a.event, a.place, d.name, menus_appeared, times_appeared, status,first_appeared, last_appeared
from menu a, menupage b, menuitem c, dish d
where a.id=b.menu_id
and b.id=c.menu_page_id
and c.dish_id=d.id
and event = 'Breakfast'
and first_appeared <> 1
and last_appeared > 2008 and last_appeared < 2018
and place= 'New York'
order by menus_appeared desc limit 10;

--Use Case 2
--Dishes served on Hotel Eastman's lunch menu.
select d.name, page_number, c.*
from menu a, menupage b, menuitem c, dish d
where a.id=b.menu_id
and b.id=c.menu_page_id
and c.dish_id=d.id
and event = 'Luncheon'
and sponsor = 'Hotel Eastman'
order by d.id desc 
;

--Use Case 3
--5 of the oldest dishes on the Menu (first appeared in 1851)
select * from dish where 
first_appeared= (select min(first_appeared) from dish where first_appeared not in ( 0,1)) order by id desc limit 5