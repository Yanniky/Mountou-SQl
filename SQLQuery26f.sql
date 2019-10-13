create procedure dbo.udp_update_customer_dim
as
begin
update customer_dim
set [expiry_date] = getdate()-1
from customer_dim a, customer_stg b
where a.customer_no = b.customer_no
and
(
   a.first_name <> b.first_name
or a.middle_name <> b.middle_name
or a.last_name <> b.last_name
or a.street_number <> b.street_number
or a.street_name <> b.street_name
or a.po_address <> b.po_address
or a.zip_code <> b.zip_code
or a.city <> b.city
or a.region <> b.region
or a.country <> b.country
)
and a.[expiry_date]='9999-12-31'
end

execute dbo.udp_update_customer_dim