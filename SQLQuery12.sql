Create Function [dbo].[udf_stripsingleQuote] (@string varchar(50))
    returns int
as
begin
    declare @CleanString varchar(50)
    SET @var=(Replace(@strip,'',''))
    return @var
end