create function udf_get_last_name (@string nvarchar (100))
returns nvarchar (50)
as
begin
set @string = ltrim (@string)
set @string = rtrim (@string)
if [dbo].[udf_get_number_of_spaces] (@string) >0
begin
set @string = reverse(@string)
set @string = left (@string, charindex(' ',@string) -1)
set @string = reverse(@string)
end
return @string
end
go

select dbo.udf_get_last_name ('Richard J Dargie')