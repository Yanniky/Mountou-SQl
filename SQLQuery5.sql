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
  
PRINT 'CUSTOMER tables address field standardised successfully!'
END

select * from dbo.customer_stg

exec UDP_STANDARDISE_CUSTOMER_ADDRESSES
