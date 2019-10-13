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
exec udp_import_customer_tab_data

select * from [dbo].[customer_xml_stg]