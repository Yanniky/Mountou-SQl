CREATE FUNCTION [dbo].[udf_get_the_address_number] (@string VARCHAR (50))
RETURNS NVARCHAR(50)

AS
BEGIN
IF dbo.udf_check_address_starts_with_a_number (@string)=1
BEGIN
DECLARE @index_position AS INT
SET @index_position=CHARINDEX (' ',@string)
SET @string =LEFT(@string, @index_position)
END
ELSE
SET @string=NULL
RETURN @string
END