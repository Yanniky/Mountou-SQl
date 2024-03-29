USE [NZ ASSG]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_TABLE_NEW_DATA_Q9]    Script Date: 12-05-2017 09:09:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[UPDATE_TABLE_NEW_DATA_Q9]
AS
BEGIN

--INSERT INTO date_dim(date_time,date,year,quarter,month,day,hour) 
--SELECT order_date, CAST(order_date AS DATE),YEAR(order_date), DATEPART(QUARTER, order_date), MONTH(order_date), DAY(order_date), DATEPART(HOUR,order_date) FROM order_stg WHERE Cust_Code IN (1000,1001,1002)

INSERT INTO order_dim(order_no, store_id) 
SELECT order_no, store_id  FROM order_stg WHERE Cust_Code IN (1000,1001,1002)

INSERT INTO order_fact_table(customer_sk,product_sk, date_sk, store_sk, order_qty, order_price)
SELECT cust_code, product_id,9999, store_id, order_qty, order_price FROM order_stg WHERE Cust_Code IN (1000,1001,1002)

END