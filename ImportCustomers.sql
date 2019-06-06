-- Creating CUSTOMERS database and tables from customers.csv
-- Only need to run this if you start over
DROP DATABASE CUSTOMERS;

-- Creare database
CREATE DATABASE CUSTOMERS;
USE CUSTOMERS;

-- Import customers.csv using MySQL Workbench GUI

-- Chck how many rows are in CUSTOMER table
select count(*) as `Customer Count` from CUSTOMER;

-- add an Id to the customer table
alter table CUSTOMER add CUSTOMER_ID int not null primary key auto_increment;

-- add a column for the CompanyID to the customers table
alter table CUSTOMER add COMPANY_ID int;

-- notice that the companyId is null
select COMPANY_ID, COMPANY from CUSTOMER;

-- create a table for the companies
-- this statement will also create a companyID column which will
-- increment when you insert a new record
create table COMPANY (
COMPANY_ID int NOT NULL AUTO_INCREMENT,
COMPANY varchar(255),
primary key (COMPANY_ID)
);

-- see what's in your company table now
select * from COMPANY;

-- generate a sql statement which shows which companies will be added to the new customer table
select distinct COMPANY from CUSTOMER where length(COMPANY)>0 and COMPANY is not null  order by COMPANY;

-- add the above companies from customers to the company table
insert into COMPANY (COMPANY) select distinct COMPANY from CUSTOMER where length(COMPANY)>0 and COMPANY is not null  order by COMPANY;

-- look at what you've done
select * from COMPANY;

-- another way to select is to list the fields
select COMPANY_ID, COMPANY from COMPANY;

/*
If you get ...
Error Code: 1175. You are using safe update mode and you tried 
to update a table without a WHERE that uses a KEY column 
To disable safe mode, toggle the option in 
Preferences -> SQL Editor and reconnect.

To reconnect: Query Menu -> Reconnect to Server
*/

-- update the compnayId in the customers table
update CUSTOMER c set c.COMPANY_ID = (select t.COMPANY_ID from
COMPANY t where t.COMPANY=c.COMPANY);

-- query to check your data
select c.COMPANY_ID,c.COMPANY,t.COMPANY_ID,t.COMPANY from
CUSTOMER c inner join COMPANY t on c.CompanyID=t.COMPANY_ID;

-- remove the company column from the customers table. It is no longer needed
alter table CUSTOMER drop column COMPANY;

-- also remove fullname, we don't need calculated columns. They're a maintenance headache
alter table CUSTOMER drop column fullname;

-- You can generate fullname more efficiently as:
select CONCAT(`FirstName`,' ',`LastName`) as `Full Name` from CUSTOMER;

-- notice you won't see the company (or fullname) column
select * from CUSTOMER;

-- the company column and the id are in Company
select * from COMPANY;

-- a query to bring it all back together
select CONCAT(`FirstName`,' ',`LastName`) as `Full Name`, COMPANY from CUSTOMER 
inner join COMPANY on 
CUSTOMER.COMPANY_ID=COMPANY.COMPANY_ID;
