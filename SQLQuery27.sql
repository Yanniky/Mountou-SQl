USE [master]
GO

/****** Object:  StoredProcedure [dbo].[udp_import_customer_tab_data]    Script Date: 06-05-2017 19:57:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ONse
GO

alter procedure [dbo].[udp_import_regular_customer_tab_data]
as
--Import the modified tab data using the bulk insert command
truncate table dbo.customer_tab_stg
bulk insert dbo.customer_tab_stg
from 'E:\regular_customers.txt'
with
(
firstrow=2,
fieldterminator='\t',
rowterminator='\n'
)
GO

execute udp_import_regular_customer_tab_data

select * from customer_tab_stg