CREATE FUNCTION [dbo].[udf_check_address_starts_with_a_number] (@string VARCHAR (50))
RETURNS INT
AS
BEGIN
SET @string = LTRIM(@string)
RETURN PatIndex ('[0-9]%',@string)
END