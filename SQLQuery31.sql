create table dbo.order_dim
(
	order_sk int identity (1,1) primary key,
	order_no varchar(50) null,
	store_id int null,
	effective_date date null default getdate(),
	[expiry_date] date null default '9999-12-31'
)