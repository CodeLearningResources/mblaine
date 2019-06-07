-- This script creates a state table and populates it from the customer table
-- adds a state_id column to customer table
-- populates the state_id column in the customer table
-- then finally drops the state column from the customer table

USE CUSTOMERS;

create table STATE (
STATE_ID int NOT NULL AUTO_INCREMENT,
STATE_ABBREV varchar(5),
primary key (STATE_ID)
);

select distinct STATE from CUSTOMER where length(STATE)>0 and COMPANY is not null  order by STATE;

insert into STATE (STATE_ABBREV) select distinct STATE from CUSTOMER where length(STATE)>0 and COMPANY is not null  order by STATE;

select * from STATE;

select STATE from CUSTOMER;

select * from CUSTOMER;

-- add a column for the STATE_ID to the CUSTOMER table
alter table CUSTOMER add STATE_ID int;

update CUSTOMER c set c.STATE_ID = (select S.STATE_ID from
STATE S where S.STATE_ABBREV=c.STATE);

-- query to check your data
select c.STATE_ID, c.STATE, s.STATE_ID, s.STATE_ABBREV from
CUSTOMER c inner join STATE s on c.STATE_ID = s.STATE_ID;

-- remove the company column from the customers table. It is no longer needed
alter table CUSTOMER drop column STATE;