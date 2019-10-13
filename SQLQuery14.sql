create procedure udp_initial_customer_dim_population
as
begin
set nocount on
--remove the nulls first before bringing into this table
exec udp_remove_nulls_from_customer_stg
insert into customer_dim
(customer_no
,first_name
,middle_name
,last_name
,street_number
,street_name
,po_address
,zip_code
,city
,region
,country
)
select distinct
customer_no
,first_name
,middle_name
,last_name
,street_name
,po_address
,zip_code
,city
,region
,country
from dbo.customer_stg
print 'Intial customer data in place!'
set nocount off
end