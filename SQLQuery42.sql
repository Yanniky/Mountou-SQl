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
select 
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
	from customer_stg
	where customer_no not in
	(
		select y.customer_no
		from customer_dim x,customer_stg y
		where x.customer_no=y.customer_no
	)
