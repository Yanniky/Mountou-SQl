EXEC [dbo].[SCD_Q6]


SELECT * from Product_dim
SELECT * from Product_stg
exec [dbo].[udp_import_product_data]