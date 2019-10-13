USE [master]
GO

/****** Object:  Table [dbo].[customer_stg]    Script Date: 04-05-2017 18:34:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

set ansi_padding on
go

CREATE TABLE [dbo].[customer_stg](
	[customer-sk] int identity (1,1) primary key
	[customer_no] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[middle_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[customer_name] [varchar](50) NULL,
	[street_number] [varchar](50) NULL,
	[street_name] [varchar](50) NULL,
	[customer_address] [varchar](100) NULL,
	[po_address] [varchar](50) NULL,
	[zip_code] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[region] [varchar](50) NULL,
	[country] [varchar](50) NULL
	[effective_date] date null default getdate(),
	[expiry_date] date null default '9999-12-31'
) ON [PRIMARY]

GO


