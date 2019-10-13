create function udf_get_number_of_spaces (@string nvarchar(100))
returns int
as
begin
declare @spaces INT
set @spaces = len (@string) - len(replace(@string, ' ', ''))
return @spaces
end

select dbo.udf_get_number_of_spaces('Richard J Dargie')