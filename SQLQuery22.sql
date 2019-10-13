create procedure dbo.udp_remove_nulls_from_customer_stg
as begin

update dbo.customer_stg
set first_name=''
where first_name is null

update dbo.customer_stg
set middle_name=''
where middle_name is null

update dbo.customer_stg
set last_name=''
where last_name is null

update dbo.customer_stg
set street_number=''
where street_number is null

update dbo.customer_stg
set street_number=''
where po_address is null

update dbo.customer_stg
set po_address=''
where po_address is null

update dbo.customer_stg
set zip_code=''
where zip_code is null

update dbo.customer_stg
set country=''
where country is null

end 
