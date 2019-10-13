CREATE PROCEDURE [dbo].[UDP_clean_customer_address]
AS
BEGIN
	UPDATE customer_stg
	SET street_number = dbo.udf_get_the_address_number(customer_address)	
	WHERE customer_address IS NOT NULL
	
	UPDATE customer_stg
	SET customer_address = dbo.udf_remove_numbers_from_addresses(customer_address)
	WHERE customer_address IS NOT NULL
	

	UPDATE customer_stg
	SET street_name = dbo.udf_remove_number_from_addresses(street_name)
	WHERE customer_address IS NOT NULL
	

	UPDATE customer_stg
	SET street_name = customer_address
	WHERE customer_address IS NOT NULL
	
	UPDATE customer_stg 
    SET customer_address = NULL
	where customer_address IS NOT NULL
	
	
END	

EXECUTE dbo.UDP_clean_customer_address



SELECT * FROM dbo.customer_stg