DROP PROCEDURE UDP_fix_customer_name
GO
CREATE PROCEDURE UDP_fix_customer_name
AS
BEGIN
	UPDATE customer_stg
	SET first_name = dbo.udf_get_first_name(customer_name)
	WHERE customer_name is not null
	
	UPDATE customer_stg
	SET middle_name = dbo.udf_get_middle_name(customer_name)
	WHERE customer_name is not null
	
	UPDATE customer_stg
	SET last_name = dbo.udf_get_last_name(customer_name)
	WHERE customer_name is not null
	
END	
GO
EXECUTE dbo.UDP_fix_customer_name
Go

select * from dbo.customer_stg
SELECT [dbo].[udf_get_first_name] ('Jones Small Goods')