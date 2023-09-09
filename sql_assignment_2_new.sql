use mayur;
select * from city_table;

/*
Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
The CountryCode for America is USA.
The CITY table is described as follows:
*/
select * from city_table c where c.POPULATION>100000 and c.COUNTRYCODE="USA";

/*
Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
The CountryCode for America is USA.
The CITY table is described as follows:
*/
select * from city_table c where c.POPULATION>120000 and c.COUNTRYCODE="USA";

/*
Q3. Query all columns (attributes) for every row in the CITY table.
The CITY table is described as follows:
*/
select * from city_table;

/*
Q4. Query all columns for a city in CITY with the ID 1661.
The CITY table is described as follows:
*/
select *  from city_table where ID=1661;

/*
Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is
JPN.
The CITY table is described as follows:
*/
select * from city_table c where c.COUNTRYCODE='JPN'; 

/*
Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is
JPN.
The CITY table is described as follows:
*/
select distinct c.DISTRICT from city_table c where c.COUNTRYCODE='JPN'; 

/*
Q7. Query a list of CITY and STATE from the STATION table.
The STATION table is described as follows:
*/
select distinct s.City,s.State  from station s;

/*
Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results
in any order, but exclude duplicates from the answer.
*/
select s.City from station s where id%2=0;

/*
Q9. Find the difference between the total number of CITY entries in the table and the number of
distinct CITY entries in the table.
*/

select count(s.City) as no_of_city,count(distinct s.City) as distinct_city,(count(s.City)-count(distinct(s.City)))as difference 
from station s
group by s.City;

/*
Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
largest city, choose the one that comes first when ordered alphabetically.
The STATION table is described as follows:
*/
(select city , length(city) as 'len_city' from station 
order by length(city) asc, city asc limit 1)
union
(select city , length(city) as 'len_city' from station 
order by length(city) desc, city asc limit 1);

/*
Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
cannot contain duplicates.
*/
select distinct city from station 
where left(city, 1) IN ('a', 'e', 'i', 'o', 'u')
order by left(city, 1) asc;

/*
Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
contain duplicates.
*/
select distinct city from station
where right(city, 1) IN ('a', 'e', 'i', 'o', 'u')
order by right(city, 1) asc;

/*
Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
contain duplicates.
*/
select distinct s.City from station s 
where left(s.City,1) not in ('a','e','i','o','u')
order by left(s.City,1) asc;

/*
Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
contain duplicates.
*/
select distinct s.City from station s
where right(s.City,1) not in ('a','e','i','o','u')
order by right(s.City,1) asc;

/*
Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
with vowels. Your result cannot contain duplicates.
*/
select distinct s.City from station s
where left(s.City,1) not in ('a','e','i','o','u')
or right(s.City,1) not in ('a','e','i','o','u')
order by left(s.City,1) asc;

/*
Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with
vowels. Your result cannot contain duplicates.
*/
select distinct s.City from station s
where left(s.City,1) not in ('a','e','i','o','u')
and right(s.City,1) not in ('a','e','i','o','u')
order by left(s.City,1) asc;

/*
Q17.Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
between 2019-01-01 and 2019-03-31 inclusive.
*/

create table product (
    product_id int primary key auto_increment,
    product_name varchar(30),
    unit_price int);

create table sales (
    seller_id int,
    product_id int,
    buyer_id int,
    sale_date date,
    quantity int,
    price int,
    foreign key (product_id) references product(product_id)
);

insert into product(product_name, unit_price) values 
('S8',1000),
('G4',800),
('iPhone',1400);

insert into sales(seller_id, product_id, buyer_id, sale_date, quantity, price) values
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 2, 3, '2019-06-02', 1, 800),
(3, 3, 4, '2019-05-13', 2, 2800);

select * from product;
select * from sales;

select p.product_id,p.product_name from product p
where p.product_id in (select s.product_id from sales s
where s.sale_date between '2019-01-01' and '2019-03-31');

/*
Q18.Write an SQL query to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.
*/
create table Views (
article_id int,
author_id int,
viewer_id int,
view_date date);

insert into Views values
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');

select distinct author_id from views
where author_id=viewer_id
order by author_id asc;

/*
Q19.Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
places.
*/
create table Delivery(
    delivery_id int primary key auto_increment,
    customer_id int,
    order_date date,
    customer_pref_delivery_date date
);

insert into Delivery(customer_id, order_date, customer_pref_delivery_date) values
(1 ,'2019-08-01','2019-08-02'),
(5 ,'2019-08-02','2019-08-02'),
(1 ,'2019-08-11','2019-08-11'),
(3 ,'2019-08-24','2019-08-26'),
(4 ,'2019-08-21','2019-08-22'),
(2 ,'2019-08-11','2019-08-13');


select round((select count(delivery_id) from delivery 
where order_date = customer_pref_delivery_date) * 100.0 /
(select count(delivery_id) from delivery),2)AS immediate_order_percentage;

/*
Q20.Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
*/
create table ads (
    ad_id int,
    user_id int,
    `action` enum ('clicked', 'viewed', 'ignored'),
    primary key (ad_id , user_id)
);

insert into ads (ad_id, user_id, `action`)
values
    (1, 1, 'clicked'),
    (2, 2, 'clicked'),
    (3, 3, 'viewed'),
    (5, 5, 'ignored'),
    (1, 7, 'ignored'),
    (2, 7, 'viewed'),
    (3, 5, 'clicked'),
    (1, 4, 'viewed'),
    (2, 11, 'viewed'),
    (1, 2, 'clicked');
    
    select 
    ad_id,
    case
        when sum(case when `action` = 'clicked' then 1 else 0 end) = 0 then 0
        else round((sum(case when `action` = 'clicked' then 1 else 0 end) / nullif(sum(case when `action` in ('clicked', 'viewed') then 1 else 0 end), 0)) * 100, 2)
    end as ctr
from ads
group by ad_id
having sum(case when `action` in ('clicked', 'viewed') then 1 else 0 end) > 0
order by ctr desc, ad_id asc;

/*
Q21.Write an SQL query to find the team size of each of the employees.
Return result table in any order.
*/
create table employee (
    employee_id int auto_increment primary key,
    team_id int);

insert into employee (team_id) values
    (8),
    (8),
    (8),
    (7),
    (9),
    (9);
    
select * from employee;
select
    e.employee_id,
    (select count(*) from employee as em where em.team_id = e.team_id) as team_size
from employee e;
 
/*
Q22.Write an SQL query to find the type of weather in each country for November 2019.
The type of weather is:
● Cold if the average weather_state is less than or equal 15,
● Hot if the average weather_state is greater than or equal to 25, and
● Warm otherwise.
Return result table in any order.
*/
create table countries (
    country_id int primary key,
    country_name varchar(255)
);

insert into countries (country_id, country_name)
values
    (2, 'USA'),
    (3, 'Australia'),
    (7, 'Peru'),
    (5, 'China'),
    (8, 'Morocco'),
    (9, 'Spain');

create table weather (
    country_id int,
    weather_state int,
    day date,
    primary key (country_id, day)
);

insert into weather (country_id, weather_state, day)
values
    (2, 15, '2019-11-01'),
    (2, 12, '2019-10-28'),
    (2, 12, '2019-10-27'),
    (3, -2, '2019-11-10'),
    (3, 0, '2019-11-11'),
    (3, 3, '2019-11-12'),
    (5, 16, '2019-11-07'),
    (5, 18, '2019-11-09'),
    (5, 21, '2019-11-23'),
    (7, 25, '2019-11-28'),
    (7, 22, '2019-12-01'),
    (7, 20, '2019-12-02'),
    (8, 25, '2019-11-05'),
    (8, 27, '2019-11-15'),
    (8, 31, '2019-11-25'),
    (9, 7, '2019-10-23'),
    (9, 3, '2019-12-23');
    
    
select c.country_name,
case
   when avg(w.weather_state)<=15 then 'cold'
  when avg(w.weather_state)>=25 then 'hot'
  else 'warm'
  end as wheather_type
  from countries c
 left join weather w on  c.country_id=w.country_id
where w.day between '2019-11-01' and '2019-11-30'
group by c.country_name;

/*
Q23.Write an SQL query to find the average selling price for each product. average_price should be
rounded to 2 decimal places.
Return the result table in any order.
*/
create table prices (
    product_id int,
    start_date date,
    end_date date,
    price int,
    primary key (product_id, start_date, end_date)
);
insert into prices (product_id, start_date, end_date, price) values
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);

create table unitssold (
    product_id int,
    purchase_date date,
    units int
);

insert into unitssold (product_id, purchase_date, units) values
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);
    
select p.product_id,
round(sum(p.price * u.units) / sum(u.units),2) 
as average_price from prices p
join unitssold u on u.product_id = p.product_id
and u.purchase_date between p.start_date and p.end_date
group by p.product_id;

/*
Q24.Write an SQL query to report the first login date for each player.
Return the result table in any order.
*/

create table activity (
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    primary key (player_id, event_date)
);

insert into activity (player_id, device_id, event_date, games_played)
values
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);

select distinct(player_id),min(event_date) as first_login from  activity
group by player_id;


/*
Q25.Write an SQL query to report the device that is first logged in for each player.
Return the result table in any order.
*/
select distinct(player_id),min(device_id) as device_id from activity
group by player_id;

/*
Q26.Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
Return result table in any order.
*/
create table products (
    product_id int primary key,
    product_name varchar(255),
    product_category varchar(255)
);


create table orders (
    product_id int,
    order_date date,
    unit int
);
insert into products (product_id, product_name, product_category)
values
    (1, 'Leetcode Solutions Book', 'Book'),
    (2, 'Jewels of Stringology Book', 'Book'),
    (3, 'HP Laptop', 'Laptop'),
    (4, 'Lenovo Laptop', 'Laptop'),
    (5, 'Leetcode Kit T-shirt', 'Clothing');

insert into orders (product_id, order_date, unit)
values
    (1, '2020-02-05', 60),
    (1, '2020-02-10', 70),
    (2, '2020-01-18', 30),
    (2, '2020-02-11', 80),
    (3, '2020-02-17', 2),
    (3, '2020-02-24', 3),
    (4, '2020-03-01', 20),
    (4, '2020-03-04', 30),
    (4, '2020-03-04', 60),
    (5, '2020-02-25', 50),
    (5, '2020-02-27', 50),
    (5, '2020-03-01', 50);
    
    select * from orders;
    select * from products;
    
select products.product_name, sum(unit) as amount
from products
inner join orders on products.product_id = orders.product_id
where extract(month from order_date) = 2
group by products.product_name
having sum(unit) >= 100;

/*
Q27.Write an SQL query to find the users who have valid emails.
A valid e-mail has a prefix name and a domain where:
● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
'_', period '.', and/or dash '-'. The prefix name must start with a letter.
● The domain is '@leetcode.com'.
Return the result table in any order.
*/
create table users (
    user_id int primary key,
    name varchar(255),
    mail varchar(255)
);

insert into users (user_id, name, mail)
values
    (1, 'Winston', 'winston@leetcode.com'),
    (2, 'Jonathan', 'jonathanisgreat'),
    (3, 'Annabelle', 'bella-@leetcode.com'),
    (4, 'Sally', 'sally.come@leetcode.com'),
    (5, 'Marwan', 'quarz#2020@leetcode.com'),
    (6, 'David', 'david69@gmail.com'),
    (7, 'Shapiro', '.shapo@leetcode.com');

select * from users;


select user_id, name, mail from users
where mail like '_%@leetcode.com'
and mail not like '%[^a-zA-Z0-9_-.]%'
and mail not like '.%'
and mail not like '%.@%'
and mail not like '%..%'
and mail not like '%-@%'
and mail not like '%@-%'
and mail not like '%-.';

/*
Q28.Write an SQL query to report the customer_id and customer_name of customers who have spent at
least $100 in each month of June and July 2020.
Return the result table in any order.
*/

create database sqlque_;

use sqlque_;

create table customers(
    customer_id int primary key,
    name varchar(50),
    country varchar(50)
);
create table products(
    product_id int primary key,
    `description` varchar(50),
    price int
);
create table orders(
    order_id int primary key,
    customer_id int, 
    product_id int ,
    order_date date,
    quantity int,
    foreign key (customer_id) references customers(customer_id), 
    foreign key (product_id) references products(product_id) 
);


insert into customers values
    (1, 'Winston', 'USA'),
    (2, 'Jonathan', 'Peru'),
    (3, 'Moustafa', 'Egypt');

insert into products values
    (10, 'LC Phone', 300),
    (20, 'LC T-Shirt', 10),
    (30, 'LC Book', 45),
    (40, 'LC Keychain', 2);

insert into orders values
    (1, 1, 10, '2020-06-10', 1),
    (2, 1, 20, '2020-07-01', 1),
    (3, 1, 30, '2020-07-08', 2),
    (4, 2, 10, '2020-06-15', 2),
    (5, 2, 40, '2020-07-01', 10),
    (6, 3, 20, '2020-06-24', 2),
    (7, 3, 30, '2020-06-25', 2),
    (9, 3, 30, '2020-05-08', 1);

select * from orders;
select * from products;
select * from customers;


-- 28 

select c.customer_id, c.name
from customers c
where c.customer_id in (
    select o.customer_id
    from orders o
    where (month(o.order_date) = 6 and year(o.order_date) = 2020)
    group by o.customer_id
    having sum(o.quantity * (select price from products p where p.product_id = o.product_id)) >= 100
) and c.customer_id in (
    select o.customer_id
    from orders o
    where (month(o.order_date) = 7 and year(o.order_date) = 2020)
    group by o.customer_id
    having sum(o.quantity * (select price from products p where p.product_id = o.product_id)) >= 100
);

/*
Q29.Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
Return the result table in any order.
*/
create table content (
    content_id varchar(50) primary key,
    title varchar(50),
    kids_content enum('Y', 'N'),
    content_type varchar(50)
);

insert into content values
    ('1', 'leetcode movie', 'n', 'movies'),
    ('2', 'alg. for kids', 'y', 'series'),
    ('3', 'database sols', 'n', 'series'),
    ('4', 'aladdin', 'y', 'movies'),
    ('5', 'cinderella', 'y', 'movies');

create table tvprogram (
    program_date date,
    content_id int,
    channel varchar(50),
    primary key (program_date, content_id)
);

insert into tvprogram values
    ('2020-06-10', 1, 'lc-channel'),
    ('2020-05-11', 2, 'lc-channel'),
    ('2020-05-12', 3, 'lc-channel'),
    ('2020-05-13', 4, 'disney ch'),
    ('2020-06-18', 4, 'disney ch'),
    ('2020-07-15', 5, 'disney ch');
    

select * from tvprogram;
select * from content;

select c.title from content c 
join tvprogram t on c.content_id=t.content_id
where c.kids_content='Y' and c.content_type='movies' and t.program_date between '2020-06-01' and '2020-06-30';

/*
Q30.Write an SQL query to find the npv of each query of the Queries table.
Return the result table in any order.
*/
create table npv (
    id int,
    year int,
    npv int,
    primary key (id, year)
);
insert into npv (id, year, npv)
values
    (1, 2018, 100),
    (7, 2020, 30),
    (13, 2019, 40),
    (1, 2019, 113),
    (2, 2008, 121),
    (3, 2009, 12),
    (11, 2020, 99),
    (7, 2019, 0);
    
create table queries (
    id int,
    year int,
    primary key (id, year)
);
insert into queries (id, year)
values
    (1, 2019),
    (2, 2008),
    (3, 2009),
    (7, 2018),
    (7, 2019),
    (7, 2020),
    (13, 2019);
    
select q.id,q.year,ifnull(n.npv,0) as npv from queries q
left join npv n on n.id=q.id and q.year=n.year;

/*
Q31.Write an SQL query to find the npv of each query of the Queries table.
Return the result table in any order.
*/
select q.id,q.year,ifnull(n.npv,0) as npv from queries q
left join npv n on n.id=q.id and n.year=q.year;

/*
Q32.Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
show null.
*/
create table employees (
    id int primary key,
    name varchar(255)
);
insert into employees (id, name)
values
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');
    
create table employeeuni (
    id int primary key,
    unique_id int
);

insert into employeeuni (id, unique_id)
values
    (3, 1),
    (11, 2),
    (90, 3);
    
select em.unique_id,e.name from employees e
left join employeeuni em on e.id=em.id
order by e.name;

/*
Q33.Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users
travelled the same distance, order them by their name in ascending order.alter
*/

create table users (
    id int primary key,
    name varchar(255));
    
insert into users values
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');
    
create table rides (
    id int primary key,
    user_id int,
    distance int
);

insert into rides values
    (1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);

-- 33
select u.name, ifnull(sum(r.distance), 0) as travelled_distance
from users u
left join rides r on u.id = r.user_id
group by u.id, u.name
order by travelled_distance desc, u.name;

/*
Q34.Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
*/
create table products (
    product_id int primary key,
    product_name varchar(255),
    product_category varchar(255)
);

insert into products (product_id, product_name, product_category)
values
    (1, 'Leetcode Solutions Book', 'Book'),
    (2, 'Jewels of Stringology Book', 'Book'),
    (3, 'HP Laptop', 'Electronics'),
    (4, 'Lenovo Laptop', 'Electronics'),
    (5, 'Leetcode Kit T-shirt', 'Apparel');

create table orders (
    product_id int,
    order_date date,
    unit int
);

insert into orders (product_id, order_date, unit)
values
    (1, '2020-02-15', 150),
    (2, '2020-02-10', 80),
    (3, '2020-02-05', 120),
    (4, '2020-03-01', 200),
    (5, '2020-02-20', 90),
    (1, '2020-02-18', 110);
    
select p.product_name, sum(o.unit) as amount
from products p
inner join orders o on p.product_id = o.product_id
where o.order_date between '2020-02-01' and '2020-02-29'
group by p.product_name
having sum(o.unit) >= 100;

/*
Q35.Write an SQL query to:
● Find the name of the user who has rated the greatest number of movies. In case of a tie,
return the lexicographically smaller user name.
● Find the movie name with the highest average rating in February 2020. In case of a tie, return
the lexicographically smaller movie name.
*/

create table movies (
    movie_id int primary key,
    title varchar(255)
);

insert into movies (movie_id, title)
values
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');


create table users (
    user_id int primary key,
    name varchar(255)
);

insert into users (user_id, name)
values
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');

create table movierating (
    movie_id int,
    user_id int,
    rating int,
    created_at date,
    primary key (movie_id, user_id)
);

insert into movierating (movie_id, user_id, rating, created_at)
values
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22'),
    (3, 2, 4, '2020-02-25');

 -- 35
 
(with UserMovieCounts as (
    select u.name, count(distinct mr.movie_id) as movie_count
    from users u
    left join movierating mr on u.user_id = mr.user_id
    group by u.user_id, u.name
)
select name from UserMovieCounts
where movie_count = (select max(movie_count) from UserMovieCounts)
order by name limit 1)
union
(with MovieAvgRatings as (
    select m.title, avg(mr.rating) as avg_rating
    from movies m
    join movierating mr on m.movie_id = mr.movie_id
    where mr.created_at >= '2020-02-01' and mr.created_at <= '2020-02-29'
    group by m.movie_id, m.title
)
select title from MovieAvgRatings
where avg_rating = (select max(avg_rating) from MovieAvgRatings)
order by title limit 1);

/*
Q36.Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users
travelled the same distance, order them by their name in ascending order.
*/

create table users (
    id int primary key,
    name varchar(255)
);

insert into users values
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');

create table rides (
    id int primary key,
    user_id int,
    distance int
);

insert into rides values
    (1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);

select u.name, coalesce(sum(r.distance), 0) as travelled_distance
from users u
left join rides r on u.id = r.user_id
group by u.id, u.name
order by travelled_distance desc, u.name;

/*
Q37.Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
show null.
*/
create table employees (
    id int primary key,
    name varchar(255)
);

insert into employees values
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');

create table employeeuni (
    id int primary key,
    unique_id int
);

insert into employeeuni values
    (3, 1),
    (11, 2),
    (90, 3);


select e.name, eu.unique_id
from employees e
left join employeeuni eu on e.id = eu.id
order by eu.id;

/*
Q38.Write an SQL query to find the id and the name of all students who are enrolled in departments that no
longer exist.
*/
create table departments (
    id int primary key,
    name varchar(255)
);

insert into departments values
    (1, 'Electrical Engineering'),
    (7, 'Computer Engineering'),
    (13, 'Business Administration');

create table students (
    id int primary key,
    name varchar(255),
    department_id int
);

insert into students values
    (23, 'Alice', 1),
    (1, 'Bob', 7),
    (5, 'Jennifer', 13),
    (2, 'John', 14),
    (4, 'Jasmine', 77),
    (3, 'Steve', 74),
    (6, 'Luis', 1),
    (8, 'Jonathan', 7),
    (7, 'Daiana', 33),
    (11, 'Madelynn', 1);

select s.id, s.name
from students s
left join departments d on s.department_id = d.id
where d.id is null;

/*
Q39.Write an SQL query to report the number of calls and the total call duration between each pair of
distinct persons (person1, person2) where person1 < person2.
*/
create table calls (
    from_id int,
    to_id int,
    duration int
);

insert into calls (from_id, to_id, duration)
values
    (1, 2, 59),
    (2, 1, 11),
    (1, 3, 20),
    (3, 4, 100),
    (3, 4, 200),
    (3, 4, 200),
    (4, 3, 499);

select
    case when from_id < to_id then from_id else to_id end as person1,
    case when from_id < to_id then to_id else from_id end as person2,
    count(*) as call_count,
    sum(duration) as total_duration
from calls
group by person1, person2;

/*
Q40.Write an SQL query to find the average selling price for each product. average_price should be
rounded to 2 decimal places.
*/

create table prices (
    product_id int,
    start_date date,
    end_date date,
    price int,
    primary key (product_id, start_date, end_date)
);

insert into prices values
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);

create table units_sold (
    product_id int,
    purchase_date date,
    units int
);

insert into units_sold values
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);


select
    u.product_id,
    round(sum(u.units * p.price) / sum(u.units), 2) as average_price
from units_sold u
join prices p on u.product_id = p.product_id and u.purchase_date >= p.start_date and u.purchase_date <= p.end_date
group by u.product_id;

/*
Q41.Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
warehouse.
*/
create table warehouse (
    name varchar(100),
    product_id int,
    units int,
    primary key (name, product_id)
);

insert into warehouse values
    ('LCHouse1', 1, 1),
    ('LCHouse1', 2, 10),
    ('LCHouse1', 3, 5),
    ('LCHouse2', 1, 2),
    ('LCHouse2', 2, 2),
    ('LCHouse3', 4, 1);

create table products (
    product_id int,
    product_name varchar(100),
    width int,
    length int,
    height int,
    primary key (product_id)
);

insert into products values
    (1, 'LC-TV', 5, 50, 40),
    (2, 'LC-KeyChain', 5, 5, 5),
    (3, 'LC-Phone', 2, 10, 10),
    (4, 'LC-T-Shirt', 4, 10, 20);


select
    w.name as warehouse_name,
    sum(p.width * p.length * p.height * w.units) as volume
from warehouse w
join products p on w.product_id = p.product_id
group by w.name;

/*
Q42.Write an SQL query to report the difference between the number of apples and oranges sold each day.
Return the result table ordered by sale_date.
*/

create table Sales (
    sale_date date,
    fruit enum('apples', 'oranges'),
    sold_num int,
    primary key (sale_date, fruit)
);

insert into Sales values
('2020-05-01', 'apples', 10),
('2020-05-01', 'oranges', 8),
('2020-05-02', 'apples', 15),
('2020-05-02', 'oranges', 15),
('2020-05-03', 'apples', 20),
('2020-05-03', 'oranges', 0),
('2020-05-04', 'apples', 15),
('2020-05-04', 'oranges', 16);


select sale_date, 
       sum(case when fruit = 'apples' then sold_num else -sold_num end) as diff
from Sales
group by sale_date
order by sale_date;

/*
Q43.Write an SQL query to report the fraction of players that logged in again on the day after the day they
first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
that logged in for at least two consecutive days starting from their first login date, then divide that
number by the total number of players.
*/
create table Activity (
    player_id int,
    device_id int,
    event_date date,
    games_played int,
    primary key (player_id, event_date)
);

insert into Activity values
(1, 2, '2016-03-01', 5),
(1, 2, '2016-03-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

with firstlogin as (
    select player_id, min(event_date) as first_login_date
    from activity
    group by player_id
)
select round(sum(case when a.event_date = date_add(fl.first_login_date, interval 1 day) then 1 else 0 end) / count(distinct fl.player_id), 2) as fraction
from firstlogin fl
left join activity a on fl.player_id = a.player_id;

/*
Q44.Write an SQL query to report the managers with at least five direct reports.
Return the result table in any order.
*/

create table Employee (
    id int primary key,
    name varchar(50),
    department varchar(50),
    managerId int
);

insert into Employee values
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);


select distinct e1.name
from Employee e1
join (select managerId, count(*) as cnt
      from Employee
      group by managerId
      having count(*) >= 5) e2
on e1.id = e2.managerId;

/*
Q45.Write an SQL query to report the respective department name and number of students majoring in
each department for all departments in the Department table (even ones with no current students).
Return the result table ordered by student_number in descending order. In case of a tie, order them by
dept_name alphabetically.
*/










/*
Q46.Write an SQL query to report the customer ids from the Customer table that bought all the products in
the Product table.
*/

create table Customer (
    customer_id int,
    product_key int
);

create table Product (
    product_key int primary key
);

insert into Customer (customer_id, product_key) values
(1, 5),
(2, 6),
(3, 5),
(3, 6),
(1, 6);

insert into Product (product_key) values
(5),
(6);

select c.customer_id
from Customer c
join Product p on c.product_key = p.product_key
group by c.customer_id
having count(distinct c.product_key) = (select count(*) from Product);

/*
Q47.Write an SQL query that reports the most experienced employees in each project. In case of a tie,
report all employees with the maximum number of experience years.
*/

create table employee (
    employee_id int primary key,
    name varchar(50),
    experience_years int
);

insert into employee values
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 3),
    (4, 'Doe', 2);

create table project (
    project_id int,
    employee_id int,
    primary key (project_id, employee_id),
    foreign key (employee_id) references employee(employee_id)
);

insert into project values
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);


with rankedemployees as (
    select
        p.project_id,
        e.employee_id,
        e.experience_years,
        rank() over (partition by p.project_id order by e.experience_years desc) as rnk
    from
        project p
    join
        employee e on p.employee_id = e.employee_id
)
select
    project_id,
    employee_id
from
    rankedemployees
where
    rnk = 1;
    
/*
Q48.Write an SQL query that reports the books that have sold less than 10 copies in the last year,
excluding books that have been available for less than one month from today. Assume today is
2019-06-23. 
*/
create table books (
    book_id int primary key,
    name varchar(255),
    available_from date
);

insert into books values
    (1, 'Kalila And Demna', '2010-01-01'),
    (2, '28 letters', '2012-05-12'),
    (3, 'The Hobbit', '2019-06-10'),
    (4, '13 Reasons Why', '2019-06-01'),
    (5, 'The Hunger Games', '2008-09-21');

create table orders (
    order_id int primary key,
    book_id int,
    quantity int,
    dispatch_date date
);


select distinct b.name
from books b
left join orders o on b.book_id = o.book_id
where 
    (o.dispatch_date between date_sub('2019-06-23', interval 1 year) and '2019-06-23')
    or o.dispatch_date is null
group by b.name, b.available_from
having sum(ifnull(o.quantity, 0)) < 10
    and datediff('2019-06-23', b.available_from) >= 30;
    
/*
Q49.Write a SQL query to find the highest grade with its corresponding course for each student. In case of
a tie, you should find the course with the smallest course_id.
Return the result table ordered by student_id in ascending order.
*/

create table enrollments (
    student_id int,
    course_id int,
    grade int,
    primary key (student_id, course_id)
);

insert into enrollments values
    (2, 2, 95),
    (2, 3, 95),
    (1, 1, 90),
    (1, 2, 99),
    (3, 1, 80),
    (3, 2, 75),
    (3, 3, 82);
    

select student_id, course_id, grade
from (
    select student_id, course_id, grade,
           row_number() over (partition by student_id order by grade desc, course_id asc) as rn
    from enrollments
) ranked
where rn = 1
order by student_id;

/*
Q50.The winner in each group is the player who scored the maximum total points within the group. In the
case of a tie, the lowest player_id wins.
Write an SQL query to find the winner in each group.
Return the result table in any order.
*/

-- wrong quetion in pdf

create table players (
    player_id int primary key,
    group_id int
);

insert into players values
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2),
    (6, 3),
    (7, 3),
    (8, 3);

with groupscores as (
    select
        p.group_id,
        p.player_id,
        row_number() over(partition by p.group_id order by p.player_id) as `rank`
    from players p
)
select
    gs.group_id,
    gs.player_id
from groupscores gs
where gs.rank = 1;











