
--DDL for Tables creation
--Note: Integrity constraints like foreign key, not null, primary key have been enforced in the table definition itself to ensure correct data is loaded into the table and dirty data (including header) is discarded.

-- Table: dish
CREATE TABLE dish (
    id integer NOT NULL CONSTRAINT dish_pk PRIMARY KEY,
    name text,
    description text,
    menus_appeared integer NOT NULL,
    times_appeared integer NOT NULL,
    first_appeared date,
    last_appeared date,
    lowest_price real,
    highest_price real
);

-- Table: menu
CREATE TABLE menu (
    id integer NOT NULL CONSTRAINT menu_pk PRIMARY KEY,
    name text,
    sponsor text,
    event text,
    venue text,
    place text,
    physical_description text,
	physical_description_type text,
	Physical_Description_Additional text,
    physical_description_2 text,
    physical_description_3 text,
    physical_description_4 text,
    physical_description_5 text,
    physical_description_6 text,
    physical_description_7 text,
    occasion text,
    notes text,
    call_number text,
    keywords text,
    language text,
    date date,
    location text,
    location_type text,
    currency text,
    currency_symbol text,
    status text,
    page_count integer NOT NULL,
    dish_count integer NOT NULL
);

-- Table: menuitem
CREATE TABLE menuitem (
    id integer NOT NULL CONSTRAINT menuitem_pk PRIMARY KEY,
    menu_page_id integer NOT NULL,
    price real NOT NULL,
    high_price real,
    dish_id integer NOT NULL,
    created_at datetime NOT NULL,
    updated_at datetime,
    xpos real NOT NULL,
    ypos real NOT NULL,
    CONSTRAINT menuitem_menupage FOREIGN KEY (menu_page_id)
    REFERENCES menupage (id),
    CONSTRAINT menuitem_dish FOREIGN KEY (dish_id)
    REFERENCES dish (id)
);

-- Table: menupage
CREATE TABLE menupage (
    id integer NOT NULL CONSTRAINT menupage_pk PRIMARY KEY,
    menu_id integer NOT NULL,
    page_number integer NOT NULL,
    image_id integer,
    full_height integer,
    full_width integer,
    uuid text,
    CONSTRAINT menupage_menu FOREIGN KEY (menu_id)
    REFERENCES menu (id)
);

--Data import validation for each of the tables.

--Dish
SELECT COUNT(*) FROM MENU;
--Menu
SELECT COUNT(*) FROM DISH;
--Menuitem
SELECT COUNT(*) FROM MENUITEM;
--Menupage
SELECT COUNT(*) FROM MENUPAGE;

--Integrity constraints validation in the tables.

--1. ID Duplication check for all the tables.
SELECT ID, COUNT(ID) 
FROM MENU 
GROUP BY ID
HAVING COUNT(ID) > 1;

SELECT ID, COUNT(ID) 
FROM MENUITEM 
GROUP BY ID
HAVING COUNT(ID) > 1;

SELECT ID, COUNT(ID) 
FROM MENUPAGE
GROUP BY ID
HAVING COUNT(ID) > 1;

SELECT ID, COUNT(ID) 
FROM DISH
GROUP BY ID
HAVING COUNT(ID) > 1;

--2. Null Columns check.
SELECT * 
FROM DISH
WHERE ID IS NULL
OR MENUS_APPEARED IS NULL
OR TIMES_APPEARED IS NULL;

SELECT * 
FROM MENUitem
WHERE ID IS NULL
OR PRICE IS NULL
OR DISH_ID IS NULL
OR CREATED_AT IS NULL
OR XPOS IS NULL
OR YPOS IS NULL;

SELECT * 
FROM MENUPAGE
WHERE ID IS NULL
OR MENU_ID IS NULL
OR PAGE_NUMBER IS NULL;

SELECT * 
FROM MENU
WHERE ID IS NULL
OR PAGE_COUNT IS NULL
OR DISH_COUNT IS NULL;

--3. Foreign Key constraint check.

--Records in MenuPage not having corresponding records in Menu table.
SELECT A.*
FROM MENUPAGE A
WHERE A.MENU_ID NOT IN (SELECT B.ID FROM MENU B);

--Records in MenuItem not having corresponding records in MenuPage table.
SELECT A.*
FROM MENUITEM A
WHERE A.MENU_PAGE_ID NOT IN (SELECT B.ID FROM MENUPAGE B);

--Records in MenuItem not having corresponding records in Menu table.
SELECT A.*
FROM MENUITEM A
WHERE A. DISH_ID NOT IN (SELECT B.ID FROM DISH B);

--4. Other checks.

--Records in Menu not having corresponding record in Menu table.
SELECT A.*
FROM MENU A
WHERE A.ID NOT IN (SELECT B.MENU_ID FROM MENUPAGE B);

--Records in MenuPage not having corresponding records in MenuItem table.
SELECT A.*
FROM MENUPAGE A
WHERE A.ID NOT IN (SELECT B.MENU_PAGE_ID FROM MENUITEM B);

--Records in Menu not having corresponding records in MenuItem table.
SELECT A.*
FROM DISH A
WHERE A.ID NOT IN (SELECT B.DISH_ID FROM MENUITEM B);

--Created date in MenuItem table greater than updated date.
SELECT * FROM MENUITEM
WHERE CREATED_AT > UPDATED_AT;

--Price in Menuitem greater than the higher price.
SELECT * FROM MENUITEM
WHERE PRICE > IFNULL(HIGH_PRICE,0);

--Last appeared in Dish table greater than current year
SELECT * FROM DISH
WHERE LAST_APPEARED > 2018;

--Incorrect year in the Dish table.
SELECT * FROM DISH
WHERE IFNULL(FIRST_APPEARED,0) = 0 ;

--Incorrect year in the Dish table.
SELECT * FROM DISH
WHERE IFNULL(LAST_APPEARED,0) = 0;

--First_appeared greater than last_appeared in Dish table.
SELECT * FROM DISH
WHERE IFNULL(FIRST_APPEARED,0)  > IFNULL(LAST_APPEARED,0);

--Lowest price greater than highest price  in Dish table.
SELECT * FROM DISH
WHERE IFNULL(LOWEST_PRICE,0) > IFNULL(HIGHEST_PRICE,0);

--Count of menus_appeared in dish table not matching count obtained from menuitem and menupage tables.

SELECT MENU.ID, MENU.DISH_COUNT, COUNT(*) 
FROM DISH, MENUITEM, MENUPAGE, MENU
WHERE DISH.ID =MENUITEM.DISH_ID
AND MENUITEM.MENU_PAGE_ID = MENUPAGE.ID
AND MENUPAGE.MENU_ID = MENU.ID
GROUP BY MENU.ID,MENU.DISH_COUNT
HAVING MENU.DISH_COUNT <> COUNT(*);

--Mismatch of page count between menu and menupage tables.
SELECT MENU.ID, MENU.PAGE_COUNT, COUNT(*)
FROM MENU, MENUPAGE
WHERE MENUPAGE.MENU_ID = MENU.ID
GROUP BY MENU.ID, MENU.PAGE_COUNT
HAVING MENU.PAGE_COUNT <> COUNT(*);
