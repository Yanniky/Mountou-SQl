USE [NZ ASSG]
GO
/****** Object:  StoredProcedure [dbo].[clean_customer_name]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[clean_customer_name]
AS
BEGIN

UPDATE customer_stg SET first_name = dbo.udf_get_the_first_name(customer_name),
						middle_name = dbo.udf_get_Middle_name(customer_name),
						last_name = dbo.udf_get_last_name(customer_name)
		WHERE customer_name IS NOT NULL


--UPDATE customer_stg SET customer_name = NULL


END
GO
/****** Object:  StoredProcedure [dbo].[delete_records_Q5]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[delete_records_Q5]
as
begin

 delete from customer_stg where customer_no is null

end

GO
/****** Object:  StoredProcedure [dbo].[Final_Table]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Final_Table]
as
insert into dbo.customer_stg(
[customer_no],
[customer_name],
[street_number],
[street_name],
[po_address],
[zip_code],
[city],
[region],
[country])

select [customerid],[cust_name],[street_no],[street_name],[po_address],[zip],[town_city],[area],[country] from dbo.customer

exec Final_Table

select * from dbo.customer_stg
select * from dbo.customer
select * from dbo.customer_tab_stg
select * from dbo.customer_stg
select * from dbo.customer_xml_stg
GO
/****** Object:  StoredProcedure [dbo].[Import_vw_Order_From_File_Q8]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Import_vw_Order_From_File_Q8]
As
Begin

truncate table dbo.vw_orders
bulk insert dbo.vw_orders
from 'E:\qry_wellington_orders.txt'
with
(
firstrow=2,
fieldterminator=',',
rowterminator='\n'
)        

End
GO
/****** Object:  StoredProcedure [dbo].[INSERT_DATA_Q3]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_DATA_Q3]
AS
BEGIN

INSERT INTO Customer_stg(customer_address) VALUES ('Anna Campbell Flat 9 1153B Great South Road Epsom Auckland 1050')
INSERT INTO Customer_stg(customer_address) VALUES ('Paul Campbell Flat 123 11 Ongly Ave Epsom Auckland 1050')

END
GO
/****** Object:  StoredProcedure [dbo].[Insert_Rows_Q7]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[Insert_Rows_Q7]
As
Begin

             INSERT INTO vw_orders(order_date, customerid, store, product_no, qty, order_price)
             VALUES (GetDate(), 1000,1,9,2,120.50)

			 INSERT INTO vw_orders(order_date, customerid, store, product_no, qty, order_price)
             VALUES (GetDate(), 1001,1,9,3,120.50)

			 INSERT INTO vw_orders(order_date, customerid, store, product_no, qty, order_price)
             VALUES (GetDate(), 1002,1,9,4,120.50)

End
GO
/****** Object:  StoredProcedure [dbo].[SCD_Q6]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SCD_Q6]
AS
BEGIN

update product_dim
set [expiry_date]=getdate()-1
from product_dim a, product_stg b
where a.product_code = b.product_code
and
(	
	a.product_name <> b.product_name
or  a.product_price <> b.product_price
or  a.product_category <> b.product_category
)
and a.[expiry_date] ='9999-12-31'


insert into product_dim
(
    product_code
	,product_name
	,product_price
	,product_category
)
select distinct
	
	b.product_code
	,b.product_name
	,b.product_price
	,b.product_category
	
from product_dim a, product_stg b
where a.product_code = b.product_code
and
(	
	a.product_name <> b.product_name
or  a.product_price <> b.product_price
or  a.product_category <> b.product_category
)
and exists
(
	select * from product_dim x
	where b.product_code = x.product_code
	and [expiry_date]=CONVERT(date,getdate()-1)
)
and not exists
(
select * from product_dim y
where b.product_code = y.product_code
and y.expiry_date='9999-12-31'
)


insert into product_dim
(
     product_code
	,product_name
	,product_price
	,product_category
)
select
	 product_code
	,product_name
	,product_price
	,product_category
	from product_stg
	where product_code not in
	(
		select y.product_code
		from product_dim x,product_stg y
		where x.product_code=y.product_code
	)


END
GO
/****** Object:  StoredProcedure [dbo].[Segrigate_Records_Q4]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
CREATE PROCEDURE [dbo].[Segrigate_Records_Q4]

AS
BEGIN

DECLARE @address AS NVARCHAR(MAX)

	DECLARE Address_cursor CURSOR FOR   
    SELECT customer_address FROM customer_stg WHERE customer_no is null  

    OPEN Address_cursor  
    FETCH NEXT FROM Address_cursor INTO @address  	

    IF @@FETCH_STATUS <> 0              
	PRINT @address

    WHILE @@FETCH_STATUS = 0  
    BEGIN  
	PRINT @address
    UPDATE customer_stg set first_name = dbo.Wordparser(customer_address, 1) WHERE customer_no is null
	UPDATE customer_stg set last_name = dbo.Wordparser(customer_address, 2) WHERE customer_no is null
	UPDATE customer_stg set street_number = dbo.Wordparser(customer_address, 3) + ' ' + dbo.Wordparser(customer_address, 4) + ' ' + dbo.Wordparser(customer_address, 5) WHERE customer_no is null
	IF CHARINDEX('Anna',@address) > 0
	BEGIN 
	  print 'hi'
		UPDATE customer_stg set street_name = dbo.Wordparser(customer_address, 6) + ' ' + dbo.Wordparser(customer_address, 7) + ' ' + dbo.Wordparser(customer_address, 8) WHERE customer_no is null and customer_address like @address+'%'
		UPDATE customer_stg set region = dbo.Wordparser(customer_address, 9)  WHERE customer_no is null and customer_address like @address+'%'
		UPDATE customer_stg set city = dbo.Wordparser(customer_address, 10)  WHERE customer_no is null and customer_address like @address+'%'
		UPDATE customer_stg set zip_code = dbo.Wordparser(customer_address, 11)  WHERE customer_no is null and customer_address like @address+'%'
	END
	ELSE
	BEGIN
	print 'hello'
		UPDATE customer_stg set street_name = dbo.Wordparser(customer_address, 6) + ' ' + dbo.Wordparser(customer_address, 7)  WHERE customer_no is null and customer_address like @address+'%'
		UPDATE customer_stg set region = dbo.Wordparser(customer_address, 8)  WHERE customer_no is null and customer_address like @address+'%'
		UPDATE customer_stg set city = dbo.Wordparser(customer_address, 9)  WHERE customer_no is null and customer_address like @address+'%'
		UPDATE customer_stg set zip_code = dbo.Wordparser(customer_address, 10)  WHERE customer_no is null and customer_address like @address+'%'
	END
	FETCH NEXT FROM Address_cursor   
    INTO @address  

	END

    CLOSE Address_cursor  
    DEALLOCATE Address_cursor  


END

--GO

--
GO
/****** Object:  StoredProcedure [dbo].[udp_create_olap_tables]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------------------------------------------------------------------------------------------------------------

CREATE procedure [dbo].[udp_create_olap_tables]
as
if object_id('customer_tab_stg','u') is not null
begin
drop table customer_tab_stg
print 'customer_tab_stg dropped!'
end
if OBJECT_ID('customer_XML_stg','u')is not null
begin
drop table customer_tab_stg
print 'customer_tab_stg dropped!'
end
if OBJECT_ID('customer_xml_stg','u')is not null
begin
drop table customer_xml_stg
print 'customer_xml_stg dropped!'
end
if OBJECT_ID('customer_stg','u') is not null
begin
drop table customer_stg
print 'customer_stg dropped!!'
end

Print 'All Olap tables dropped successfully !'
----------------------------------

create table customer_tab_stg(
customer_code varchar(100),
customer_name varchar(100),
customer_address varchar(100),
post_code varchar(100),
city varchar(30),
region varchar(30),
country varchar(100)
)
--print 'customer_tab_stg table created!'
---------------------------------------

create table customer_xml_stg(
xml_column xml
)
--print 'customer_xml table created!'
------------------------------------- 
create table dbo.customer_stg(
customer_no varchar(50),
first_name varchar(50),
middle_name varchar(50),
last_name varchar(50),
customer_name varchar(50),
street_number varchar(50),
street_name varchar(50),
customer_address varchar(100),
po_address varchar(50),
zip_code varchar(50),
city varchar(50),
region varchar(50),
country varchar(50),
)
print 'customer staging tables created!';

------------------------------------------------------------------------------------------------------------

GO
/****** Object:  StoredProcedure [dbo].[udp_import_customer_tab_data]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[udp_import_customer_tab_data]
as
--Import the modified tab data using the bulk insert command
truncate table dbo.customer_tab_stg
bulk insert dbo.customer_tab_stg
from 'E:\initial_customers.txt'
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
select * from [dbo].[customer_tab_stg]



GO
/****** Object:  StoredProcedure [dbo].[udp_import_customer_xml_data]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------------

create procedure [dbo].[udp_import_customer_xml_data]
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


GO
/****** Object:  StoredProcedure [dbo].[udp_import_product_data]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[udp_import_product_data]
as
--Import the modified tab data using the bulk insert command
truncate table dbo.product_stg
bulk insert dbo.product_stg
from 'E:\products.txt'
with
(
firstrow=1,
fieldterminator=',',
rowterminator='\n'
)



GO
/****** Object:  StoredProcedure [dbo].[udp_import_Reguler_customer_tab_data]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[udp_import_Reguler_customer_tab_data]
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
select * from [dbo].[customer_tab_stg]



GO
/****** Object:  StoredProcedure [dbo].[UDP_INITIAL_CUSTOMER_DIM_POPULATION]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UDP_INITIAL_CUSTOMER_DIM_POPULATION]
AS
BEGIN
SET NOCOUNT ON
-- Remove the nulls first before bringing into this table
EXEC UDP_REMOVE_NULLS_FROM_CUSTOMER_STG
INSERT INTO customer_dim
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
		,country)

SELECT DISTINCT
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
	FROM dbo.customer_stg
	Print'Intial customer data in place!'
SET NOCOUNT OFF
END

GO
/****** Object:  StoredProcedure [dbo].[udp_remove_nulls_from_customer_stg]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[udp_remove_nulls_from_customer_stg]
as
begin
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
set street_name=''
where street_name is null

update dbo.customer_stg
set po_address=''
where po_address is null

update dbo.customer_stg
set zip_code=''
where zip_code is null

update dbo.customer_stg
set city=''
where city is null

update dbo.customer_stg
set region=''
where region is null

update dbo.customer_stg
set country=''
where country is null
end

GO
/****** Object:  StoredProcedure [dbo].[UDP_Remove_PO_FROM_STREETNAME]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UDP_Remove_PO_FROM_STREETNAME] 
	
AS
BEGIN
	UPDATE Customer_stg SET street_name='' WHERE street_name LIKE 'PO%'
END

GO
/****** Object:  StoredProcedure [dbo].[UDP_STANDARDISE_CUSTOMER_ADDRESSES]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UDP_STANDARDISE_CUSTOMER_ADDRESSES]
AS
BEGIN
UPDATE customer_stg
SET street_number=dbo.udf_get_the_address_number(customer_address)
WHERE customer_address IS NOT NULL

UPDATE customer_stg
SET customer_address=dbo.udf_remove_numbers_from_addresses(customer_address)

UPDATE customer_stg
SET street_name=customer_address
WHERE customer_address IS NOT NULL

PRINT'CUSTOMER tables address field standardised successfully!'
END

select*from dbo.customer_stg

GO
/****** Object:  StoredProcedure [dbo].[UDP_STANDARDISE_CUSTOMER_COUNTRY_FIELD]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UDP_STANDARDISE_CUSTOMER_COUNTRY_FIELD]
AS
BEGIN
UPDATE dbo.customer_stg SET country =CASE
WHEN country ='nz' THEN 'New Zealand'
WHEN country ='NZ' THEN 'New Zealand'
WHEN country ='New zealand' THEN 'New Zealand'
WHEN country ='new zealand' THEN 'New Zealand'
WHEN country ='NEW ZEALAND' THEN 'New Zealand'
ELSE country
END
PRINT 'Customer tables county files standardised successfully!'
END

exec UDP_STANDARDISE_CUSTOMER_COUNTRY_FIELD

select * from dbo.customer_stg


--------------------------------------------------------------------------


GO
/****** Object:  StoredProcedure [dbo].[UDP_STANDARDISE_CUSTOMER_PO_BOX]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UDP_STANDARDISE_CUSTOMER_PO_BOX]
AS
BEGIN
UPDATE customer_stg
SET customer_address=REPLACE(customer_address,'.','')
WHERE customer_address LIKE'%P.O. Box%'

UPDATE customer_stg
SET po_address =REPLACE(po_address,'.','')
WHERE po_address LIKE'%P.O. Box%'

UPDATE customer_stg
SET po_address=customer_address
WHERE customer_address LIKE'%PO Box%'

PRINT'Customer tables P.O. Box number standardised successfully!'
END

GO
/****** Object:  StoredProcedure [dbo].[UPDATE_TABLE_NEW_DATA_Q9]    Script Date: 5/11/2017 12:20:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UPDATE_TABLE_NEW_DATA_Q9]
AS
BEGIN

--INSERT INTO date_dim(date_time,date,year,quarter,month,day,hour) 
--SELECT order_date, CAST(order_date AS DATE),YEAR(order_date), DATEPART(QUARTER, order_date), MONTH(order_date), DAY(order_date), DATEPART(HOUR,order_date) FROM order_stg WHERE Cust_Code IN (1000,1001,1002)

INSERT INTO order_dim(order_no, store_id) 
SELECT order_no, store_id  FROM order_stg WHERE Cust_Code IN (1000,1001,1002)

INSERT INTO order_fact_table(customer_sk,product_sk, date_sk, store_sk, order_qty, order_price)
SELECT cust_code, product_id,9999, store_id, order_qty, order_price FROM order_stg WHERE Cust_Code IN (1000,1001,1002)

END


GO
