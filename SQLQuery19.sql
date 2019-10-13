DROP FUNCTION [dbo].[udf_get_middle_name]
GO
CREATE FUNCTION udf_get_middle_name(@string NVARCHAR (100))
 RETURNS NVARCHAR (100)
 AS
	BEGIN
		SET @string = LTRIM (@string)
		SET @string = RTRIM (@string)

		
		
		IF[dbo].[udf_get_number_of_spaces](@string)>1
			BEGIN
				SET @string = RIGHT(@string, LEN(@string)-CHARINDEX (' ', @string))						
				SET @string = LEFT (@string, CHARINDEX (' ', @string))
				
		END	
		RETURN @string
END	
GO


SELECT [dbo].[udf_get_middle_name] ('Jones Small Goods')