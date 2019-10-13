create table customer
(customerid int identity(1000,1) not null primary key(customerid),
cust_name varchar(50) not null,
street_no varchar(50) not null,
street_name varchar(50) not null,
po_address varchar(50),
zip varchar(50) not null,
town_city varchar(50) not null,
area varchar(50) not null,
country varchar(50) not null)
go

INSERT into customer VALUES
('Mary J. Smith','95','Scott Street','PO Box 456','2323','Fielding','Manawatu','NZ'),
('Waynes World','321','Bisley Street','PO Box 456','4434','Palmerston Nth','Manawatu','NZ'),
('Ace Freely','34','Galway Ave',null,'4778','Wellington','Wellington','NZ')
go


select * from customer
go

-----------------------------------------------------------------------------------------------------------------------

create procedure udp_create_olap_tables
as
if object_id('customer_tab_stg','U') is not null
begin
drop table customer_tab_stg
print 'customer_tab_stg dropped!'
end

if OBJECT_ID('customer_XML_stg','U')is not null
begin
drop table customer_XML_stg
print 'customer_xml_stg dropped!'
end

if OBJECT_ID('customer_stg','U') is not null
begin
drop table customer_stg
print 'customer_stg dropped!!'
end

----------------------------------

create table customer_tab_stg(
customer_code varchar(100),
customer_name varchar(100),
customer_address varchar(100),
post_code varchar(100),
city varchar(30),
region varchar(30),
country varchar(100)
)
print 'customer_tab_stg table created!'
---------------------------------------

create table customer_xml_stg(
xml_column xml
)
print 'customer_xml table created!'
------------------------------------- 
create table dbo.customer_stg(
customer_no varchar(50),
first_name varchar(50),
middle_name varchar(50),
last_name varchar(50),
customer_name varchar(50),
street_number varchar(50),
street_name varchar(50),
customer_address varchar(100),
po_address varchar(50),
zip_code varchar(50),
city varchar(50),
region varchar(50),
country varchar(50),
)
print 'customer_stg table created!'

------------------------------------------------------------------------------------------------------------

create procedure udp_import_customer_tab_data
as
--Import the modified tab data using the bulk insert command
truncate table dbo.customer_tab_stg
bulk insert dbo.customer_tab_stg
from 'E:\Customers.txt'
with
(
firstrow=2,
fieldterminator='\t',
rowterminator='\n'
)
---transfer from temp table to the stage
truncate table customer_stg
insert into customer_stg
(
 customer_no, 
 customer_name, 
 customer_address, 
 zip_code, 
 city, 
 region, 
 country
)
select * from [dbo].[customer_tab_stg]

exec udp_import_customer_tab_data


---------------------------------------------------------------------------------------------------------------

create procedure udp_import_customer_xml_data
as
--import the xml data from te customers.xml file
truncate table dbo.customer_xml_stg
insert into dbo.customer_xml_stg(xml_column)
select * from openrowset
(
bulk 'E:\Customers.xml', 
single_blob
)
as xml_column

--Inserting the customer data from the temp customer xml table
declare @pointer_to_document int
declare @customers_xml xml
set @customers_xml = (select xml_column from dbo.customer_xml_stg)
exec sp_xml_preparedocument @pointer_to_document output, @customers_xml

--Openxml provider
insert into dbo.customer_stg
(customer_no
,customer_name
,customer_address
,zip_code
,city
,region
,country
)
select * from openxml (@pointer_to_document , 'dataroot/Customers',2)
with (cust_code nvarchar(10)
,customer_name nvarchar(50)
,customer_address nvarchar(50)
,post_codes nvarchar(10)
,city nvarchar(30)
,region nvarchar(30)
,country nvarchar(30)
)

exec udp_import_customer_xml_data

create procedure Final_Table
as
insert into dbo.customer_stg(
[customer_no],
[customer_name],
[street_number],
[street_name],
[po_address],
[zip_code],
[city],
[region],
[country])

select [customerid],[cust_name],[street_no],[street_name],[po_address],[zip],[town_city],[area],[country] from dbo.customer

exec Final_Table

select * from dbo.customer_stg
select * from dbo.customer
select * from dbo.customer_tab_stg
select * from dbo.customer_stg
	select * from dbo.customer_xml_stg