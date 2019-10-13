USE [master]
GO

/** Object:  Table [dbo].[customer_stg]    Script Date: 06-May-17 5:50:54 PM **/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[customer_dim](
	[customer_sk] INT IDENTITY (1,1) PRIMARY KEY,
	[customer_no] [varchar](10) NULL,
	[first_name] [varchar](50) NULL,
	[middle_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[customer_name] [varchar](50) NULL,
	[street_number] [varchar](50) NULL,
	[street_name] [varchar](50) NULL,
	[customer_address] [varchar](100) NULL,
	[po_address] [varchar](50) NULL,
	[zip_code] [varchar](10) NULL,
	[city] [varchar](30) NULL,
	[region] [varchar](30) NULL,
	[country] [varchar](30) NULL,
	[effective_date] DATE NULL DEFAULT GETDATE(),
	[expiry_date] DATE NULL DEFAULT '9999-12-31'
) ON [PRIMARY]

GO