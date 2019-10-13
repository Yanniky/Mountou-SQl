create function udf_get_the_first_name (@string nvarchar(100))
returns nvarchar(50)
as
begin
declare @first_name nvarchar(50)
set @string = ltrim(@string)
set @string = rtrim(@string)

if dbo.udf_get_number_of_spaces(@string)>0
set @first_name = left (@string, charindex(' ',@string))
else
set @first_name = @string
return @first_name
end
go

select dbo.udf_get_the_first_name ('Richard J Dargie')