-------------------------------------
-------The Date Dimension Table------
-----------date_dim------------------

CREATE TABLE dbo.date_dim(
	date_sk int IDENTITY(1,1) PRIMARY KEY,
	date_time datetime NULL,
	[date] AS (cast(date_time as DATE)),
	year AS (datepart(year,date_time)),
	quarter AS (datepart(quarter,date_time)),
	month AS (datename(month,date_time)),
	day AS (datepart(day,date_time)),
	hour AS (datepart(hour, date_time)),
	effective_date date NULL DEFAULT GETDATE(),
	[expiry_date] date NULL DEFAULT '9999-12-31'
	)

------------------------------------------
---------The Order Dimension Table--------
-------------order_dim--------------------

CREATE TABLE dbo.order_dim(
	order_sk int IDENTITY (1,1) PRIMARY KEY,
	order_no varchar(50) NULL,
	store_id INT NULL,
	effective_date date NULL DEFAULT GETDATE(),
	[expiry_date] date NUll DEFAULT '9999-12-31'
	)

-------------------------------------------
-------The Product Dimension Table---------
-------------product_dim-------------------

CREATE TABLE dbo.product_dim(
	product_sk int IDENTITY(1,1) PRIMARY KEY,
	product_code varchar(50) NULL,
	product_name varchar(50) NULL,
	product_price decimal(18,2) NULL,
	product_category varchar(50) NULL,
	effective_date date NULL DEFAULT GETDATE(),
	[expiry_date] date NUll DEFAULT '9999-12-31'
	)
	
----------------------------------------------
----------The Store Dimension Table-----------

CREATE TABLE dbo.store_dim(
	store_sk int IDENTITY(1,1) PRIMARY KEY,
	store_id int NOT NULL,
	store_name varchar(50) NOT NULL,
	store_location varchar(50) NOT NULL,
	effective_date date NULL DEFAULT GETDATE(),
	[expiry_date] date NUll DEFAULT '9999-12-31'
	)

---------------------------------------------------
----------The Order Fact Table---------------------
-------------oder_fact_table-----------------------

CREATE TABLE dbo.order_fact_table(
	order_sk int NOT NULL,
	customer_sk int NOT NULL,
	product_sk int NOT NULL,
	date_sk int NOT NULL,
	store_sk int NOT NULL,
	order_qty int NULL,
	order_price smallmoney NULL,

	CONSTRAINT oft_order_sk_fk FOREIGN KEY(order_sk) REFERENCES order_dim(order_sk),
	CONSTRAINT oft_customer_sk_fk FOREIGN KEY(customer_sk) REFERENCES customer_dim(customer_sk),
	CONSTRAINT oft_product_sk_fk FOREIGN KEY(product_sk) REFERENCES product_dim(product_sk),
	CONSTRAINT oft_date_sk_fk FOREIGN KEY(date_sk) REFERENCES date_dim(date_sk),
	CONSTRAINT oft_store_sk_fk FOREIGN KEY(store_sk) REFERENCES store_dim(store_sk),
	CONSTRAINT oft_pk PRIMARY KEY (order_sk,customer_sk,product_sk,date_sk,store_sk)
	)

------------------------------------------------------
-----------The Order Staging table--------------------
------ Create the sales order staging table-----------

CREATE TABLE dbo.order_stg(
	order_no varchar(10) NOT NULL,
	order_date varchar(25) NULL,
	cust_code varchar(10) NULL,
	store_id varchar(3) NULL,
	product_id varchar(50) NULL,
	order_qty varchar(5) NULL,
	order_price varchar(20) NULL
	)

------------------------------------------------------
--------The Palmy Shop Sales Order Data(OLTP)---------
------------------------------------------------------

CREATE TABLE dbo.vw_orders(
	order_id int identity NOT NULL,
	order_date DATETIME DEFAULT GETDATE() NOT NULL,
	customerid int NOT NULL,
	store int DEFAULT 1 NOT NULL,
	product_no int NOT NULL,
	qty int NOT NULL,
	order_price decimal(18,2) NOT NULL
	)

---------------------------------------------------------------
-----Populate the vw_orders table with sample order data-------

insert dbo.vw_orders values (GETDATE() -1,1000, DEFAULT, 3, 2, 290.50)
insert dbo.vw_orders values (GETDATE() -1,1000, DEFAULT, 6, 2, 190.50)
insert dbo.vw_orders values (GETDATE() -1,1001, DEFAULT, 3, 4, 290.50)
insert dbo.vw_orders values (GETDATE() -1,1001, DEFAULT, 7, 5, 50.50)
insert dbo.vw_orders values (GETDATE() -1,1002, DEFAULT, 4, 1, 400.50)
insert dbo.vw_orders values (GETDATE() -1,1002, DEFAULT, 1, 3, 290.50)
PRINT 'OLTP Tables created and reset with original data successfully'

-----------------------------------------------
----Populating the Order Dim-------------------

INSERT INTO dbo.order_dim (order_no,store_id)
SELECT DISTINCT a.order_no, a.store_id
FROM dbo.order_stg AS a
WHERE a.order_no NOT IN (SELECT b.order_no
						FROM dbo.order_dim AS b)

-----------------------------------------------
---------Populating the Date_Dim---------------

INSERT INTO dbo.date_dim(date_time)
SELECT DISTINCT a.order_date
FROM dbo.order_stg AS a
WHERE a.order_date NOT IN (SELECT b.date_time
							FROM dbo.date_dim AS b)

------------------------------------------------
-------Populating the Fact table----------------

INSERT INTO order_fact_table(
	order_sk,
	customer_sk,
	product_sk,
	store_sk,
	date_sk,
	order_qty,
	order_price
)
SELECT order_sk,
	customer_sk,
	product_sk,
	store_sk,
	date_sk,
	order_qty,
	order_price
FROM dbo.order_stg AS a,
order_dim AS b,
customer_dim AS c,
product_dim AS d,
date_dim AS f,
store_dim e
WHERE b.order_sk NOT IN (select order_sk from order_fact_table)
AND a.order_no=b.order_no
AND a.cust_code=c.customer_no
AND a.product_id=d.product_code
AND a.store_id=e.store_id
AND a.order_date=f.[date_time]
--AND f.date=CAST(GETDATE() AS DATE)

----------------------------------------------









