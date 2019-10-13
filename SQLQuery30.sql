create table dbo.date_dim
(
	date_sk int identity(1,1) primary key,
	date_time datetime null,
	[date] as (cast(date_time as date)),
	year as (datepart(year,date_time)),
	quarter as (datepart(quarter,date_time)),
	month as (datename(month,date_time)),
	day as (datepart(day,date_time)),
	hour as (datepart(hour,date_time)),
	effective_date date null default getdate(),
	[expiry_date] date null default '9999-12-31'
)
