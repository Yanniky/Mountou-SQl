CREATE PROCEDURE UDP_INITIAL_CUSTOMER_DIM_POPULATION
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
	Print 'Intial customer data in place!'
SET NOCOUNT OFF
END