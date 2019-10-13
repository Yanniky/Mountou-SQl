insert into customer_dim
(
	customer_no
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
	b.customer_no
	,b.first_name
	,b.middle_name
	,b.last_name
	,b.street_number
	,b.street_name
	,b.po_address
	,b.zip_code
	,b.city
	,b.region
	,b.country
from customer_dim a, customer_stg b
where a.customer_no = b.customer_no
and
(	
	a.first_name <> b.first_name
or  a.middle_name <> b.middle_name
or  a.last_name <> b.last_name
or	a.street_number <> b.street_number
or  a.street_name <> b.street_name
or	a.po_address <> b.po_address
or	a.zip_code <> b.zip_code
or	a.city <> b.city
or	a.region <> b.region
or	a.country <> b.country

)
and exists
(
	select * from customer_dim x
	where b.customer_no = x.customer_no
	and [expiry_date]=CONVERT(date,getdate() -1)
)
and not exists
(
select * from customer_dim y
where b.customer_no = y.customer_no
and y.expiry_date = '9999-12-31'
)