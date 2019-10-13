USE [master]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_get_first_name]    Script Date: 06-May-17 4:50:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[udf_get_first_name](@string NVARCHAR(100))
RETURNS NVARCHAR(50)
AS
BEGIN
SET @string=LTRIM (@string)
SET @string = RTRIM (@string)
IF[dbo].[udf_get_number_of_spaces](@string)>1
BEGIN
SET @string = LEFT ( @string,CHARINDEX( ' ', @string)-1)
END
RETURN @string
END
