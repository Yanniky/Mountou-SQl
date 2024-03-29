USE [NZ ASSG]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_check_address_starts_with_a_number]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_check_address_starts_with_a_number] 
(@string VARCHAR (50))
RETURNS INT
AS
BEGIN
SET @string =LTRIM(@string)
RETURN PatIndex('[0-9]%', @string)
END

GO
/****** Object:  UserDefinedFunction [dbo].[udf_get_last_name]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[udf_get_last_name](@string nvarchar (100))
RETURNS NVARCHAR (50)
AS
BEGIN
DECLARE @first_name nvarchar(50)
DECLARE @last_name as varchar(100)
SET @last_name = @string
SET @string = dbo.udf_remove_dotsAndquotes_from_name(@string)
SET @string =ltrim(@string)
SET @string =rtrim(@string)

IF [dbo].[udf_get_number_of_spaces](@string)>0
BEGIN
IF LEN(SUBSTRING(REVERSE(@string),0,CHARINDEX(' ', REVERSE(@string)))) = 1
		BEGIN
			set @string =left(@string,charindex(' ',@string))
			
		END
		ELSE
		BEGIN
			set @string =reverse(@string)
			set @string =left(@string,charindex(' ',@string)-1)
			set @string =reverse(@string)
			
		END
END
RETURN @string
END


GO
/****** Object:  UserDefinedFunction [dbo].[udf_get_Middle_name]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[udf_get_Middle_name](@string nvarchar (100))

returns nvarchar (50)

as

begin

declare @first_name nvarchar(50)

declare @last_name as varchar(100)

set @last_name = @string

set @string = dbo.udf_remove_dotsAndquotes_from_name(@string)

set @string =ltrim(@string)

set @string =rtrim(@string)

	if [dbo].[udf_get_number_of_spaces](@string)>0

	BEGIN

		if LEN(SUBSTRING(REVERSE(@string),0,CHARINDEX(' ', REVERSE(@string)))) = 1

		BEGIN

		    SET @string=SUBSTRING(REVERSE(@string),0,CHARINDEX(' ', REVERSE(@string)))

		END

		ELSE 

		BEGIN

		 	set @first_name =left(@string,charindex(' ',@string))

			set @last_name =reverse(@string)

			set @last_name =left(@last_name,charindex(' ',@last_name)-1)

			set @last_name =reverse(@last_name)

			set @string = REPLACE(@string,@first_name,'')

			set @string = REPLACE(@string,@last_name,'')

			set @string =ltrim(@string)

			set @string =rtrim(@string)

	END

	END

return @string

end



GO
/****** Object:  UserDefinedFunction [dbo].[udf_get_number_of_spaces]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[udf_get_number_of_spaces](@string nvarchar(100))
returns int
as
begin
declare @spaces INT
set @spaces =len(@string)-len(replace(@string,' ',''))
return @spaces
end

GO
/****** Object:  UserDefinedFunction [dbo].[udf_get_the_address_number]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_get_the_address_number](@string VARCHAR (50))
RETURNS NVARCHAR(50)

AS
BEGIN
IF dbo.udf_check_address_starts_with_a_number(@string)=1
BEGIN
DECLARE @index_position AS INT
SET @index_position=CHARINDEX(' ',@string)
SET @string =LEFT(@string, @index_position)
END
ELSE
SET @string=NULL
RETURN @string
END

GO
/****** Object:  UserDefinedFunction [dbo].[udf_get_the_first_name]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[udf_get_the_first_name](@string nvarchar(100))
returns nvarchar(50)
as
begin
declare @first_name nvarchar(50)
declare @last_name nvarchar(50)
set @string = dbo.udf_remove_dotsAndquotes_from_name(@string)
set @string =ltrim(@string)
set @string =rtrim(@string)

if dbo.udf_get_number_of_spaces(@string)>0
BEGIN
	IF LEN(SUBSTRING(REVERSE(@string),0,CHARINDEX(' ', REVERSE(@string)))) = 1
	BEGIN
			set @first_name =left(@string,charindex(' ',@string))

			set @last_name =reverse(@string)
			set @last_name =left(@last_name,charindex(' ',@last_name)-1)
			set @last_name =reverse(@last_name)

			set @string = REPLACE(@string,@first_name,'')
			set @string = REPLACE(@string,@last_name,'')
			set @string =ltrim(@string)
			set @string =rtrim(@string)
			--set @string ='hI'
	END
	ELSE
	BEGIN
		set @string =left(@string,charindex(' ',@string))
		--set @string ='HELLO'
	END
END
--set @first_name = @string
return @string
end

GO
/****** Object:  UserDefinedFunction [dbo].[udf_remove_dotsAndquotes_from_name]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[udf_remove_dotsAndquotes_from_name]
(@string varchar(50))
returns varchar(50)
as
begin
set @string =replace(@string,'.',' ')
set @string =replace(@string,'"',' ')
set @string =replace(@string,',',' ')
return @string
end


GO
/****** Object:  UserDefinedFunction [dbo].[udf_remove_numbers_from_addresses]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[udf_remove_numbers_from_addresses]
(@string varchar(50))
returns varchar(50)
as
begin
if dbo.udf_check_address_starts_with_a_number(@string)=1

set @string =replace(@string,left(@string,charindex(' ',@string)),'')
set @string =ltrim(@string)
set @string =rtrim(@string)
return @string
end

GO
/****** Object:  UserDefinedFunction [dbo].[Wordparser]    Script Date: 5/11/2017 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Wordparser]
(
  @multiwordstring VARCHAR(255),
  @wordnumber      NUMERIC
)
returns VARCHAR(255)
AS
  BEGIN
      DECLARE @remainingstring VARCHAR(255)
      SET @remainingstring=@multiwordstring

      DECLARE @numberofwords NUMERIC
      SET @numberofwords=(LEN(@remainingstring) - LEN(REPLACE(@remainingstring, ' ', '')) + 1)

      DECLARE @word VARCHAR(50)
      DECLARE @parsedwords TABLE
      (
         line NUMERIC IDENTITY(1, 1),
         word VARCHAR(255)
      )

      WHILE @numberofwords > 1
        BEGIN
            SET @word=LEFT(@remainingstring, CHARINDEX(' ', @remainingstring) - 1)

            INSERT INTO @parsedwords(word)
            SELECT @word

            SET @remainingstring= REPLACE(@remainingstring, Concat(@word, ' '), '')
            SET @numberofwords=(LEN(@remainingstring) - LEN(REPLACE(@remainingstring, ' ', '')) + 1)

            IF @numberofwords = 1
              BREAK

            ELSE
              CONTINUE
        END

      IF @numberofwords = 1
        SELECT @word = @remainingstring
      INSERT INTO @parsedwords(word)
      SELECT @word

      RETURN
        (SELECT word
         FROM   @parsedwords
         WHERE  line = @wordnumber)

  END
GO
