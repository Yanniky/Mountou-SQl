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