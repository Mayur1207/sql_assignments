
### Q 1)
create table linkdin (ID int,tech varchar(50));
insert into linkdin values(1,"DS"),
(1,"tableu"),(1,"SQL"),
(1,"SQL"),(2,"R"),
(2,"power BI"),(1,"python"),
(1,"python");
			
select * from linkdin;

select ID from linkdin
where tech = "DS"
and ID in (select ID from linkdin where tech="python"
and ID in (select ID from linkdin where tech="SQL"
and ID in (select ID from linkdin where tech="tableu")
)
);


# Q 2)

create table product_info (pr_id int,pr_name varchar(50));

insert into product_info values
(1001,"Blog"),(1002,"YouTube"),(1003,"Education");

create table product_likes (user_id int,pr_id int ,
liked_date date);

insert into product_likes values (1,1001,"2023-08-19"),
(2,1003,"2023-01-18");

select p.pr_id from product_info p 
where p.pr_id not in (select pr_id from product_likes);

