CREATE PROCEDURE UDP_STANDARDISE_CUSTOMER_COUNTRY_FIELD
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

