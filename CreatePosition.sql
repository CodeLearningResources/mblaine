USE CUSTOMERS;

create table POSITION (
POSITION_ID int NOT NULL AUTO_INCREMENT,
POSITION_NAME varchar(255),
primary key (POSITION_ID)
);

select POSITION from CUSTOMER where length(POSITION)>0 and POSITION is not null  order by POSITION;

select distinct POSITION from CUSTOMER where length(POSITION)>0 and POSITION is not null  order by POSITION;


insert into POSITION (POSITION_NAME) select distinct POSITION from CUSTOMER where length(POSITION)>0 and POSITION is not null  order by POSITION;

select * from POSITION;

-- add a column for the POSITION_ID to the CUSTOMER table
alter table CUSTOMER add POSITION_ID int;

select * from CUSTOMER;

update CUSTOMER c set c.POSITION_ID = (select P.POSITION_ID from
POSITION P where P.POSITION_NAME = c.POSITION);

-- query to check your data
select c.POSITION_ID, c.POSITION, P.POSITION_ID, P.POSITION_NAME from
CUSTOMER c inner join POSITION P on c.POSITION_ID = P.POSITION_ID;

-- remove the company column from the customers table. It is no longer needed
alter table CUSTOMER drop column POSITION;

