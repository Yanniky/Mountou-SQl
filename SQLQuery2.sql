create procedure udp_create_olap_tables
as
if object_id('customer_tab_stg','u') is not null
begin
drop table customer_tab_stg
print 'customer_tab_stg dropped!'
end
if OBJECT_ID('customer_XML_stg','u')is not null
begin
drop table customer_tab_stg
print 'customer_tab_stg dropped!'
end
if OBJECT_ID('customer_xml_stg','u')is not null
begin
drop table customer_xml_stg
print 'customer_xml_stg dropped!'
end
if OBJECT_ID('customer_stg','u') is not null
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