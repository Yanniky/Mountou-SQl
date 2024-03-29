USE [NZ ASSG]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 5/11/2017 12:18:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[customer](
	[customerid] [int] IDENTITY(1000,1) NOT NULL,
	[cust_name] [varchar](50) NOT NULL,
	[street_no] [varchar](50) NOT NULL,
	[street_name] [varchar](50) NOT NULL,
	[po_address] [varchar](50) NULL,
	[zip] [varchar](50) NOT NULL,
	[town_city] [varchar](50) NOT NULL,
	[area] [varchar](50) NOT NULL,
	[country] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[customerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[customer_dim]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[customer_dim](
	[customer_sk] [int] IDENTITY(1,1) NOT NULL,
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
	[effective_date] [date] NULL,
	[expiry_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[customer_stg]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[customer_stg](
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
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[customer_tab_stg]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[customer_tab_stg](
	[customer_code] [varchar](100) NULL,
	[customer_name] [varchar](100) NULL,
	[customer_address] [varchar](100) NULL,
	[post_code] [varchar](100) NULL,
	[city] [varchar](30) NULL,
	[region] [varchar](30) NULL,
	[country] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[customer_xml_stg]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_xml_stg](
	[xml_column] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[date_dim]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[date_dim](
	[date_sk] [int] IDENTITY(1,1) NOT NULL,
	[date_time] [datetime] NULL,
	[date]  AS (CONVERT([date],[date_time])),
	[year]  AS (datepart(year,[date_time])),
	[quarter]  AS (datepart(quarter,[date_time])),
	[month]  AS (datename(month,[date_time])),
	[day]  AS (datepart(day,[date_time])),
	[hour]  AS (datepart(hour,[date_time])),
	[effective_date] [date] NULL,
	[expiry_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[date_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[order_dim]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[order_dim](
	[order_sk] [int] IDENTITY(1,1) NOT NULL,
	[order_no] [varchar](50) NULL,
	[store_id] [int] NULL,
	[effective_date] [date] NULL,
	[expiry_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[order_fact_table]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_fact_table](
	[order_sk] [int] NOT NULL,
	[customer_sk] [int] NOT NULL,
	[product_sk] [int] NOT NULL,
	[date_sk] [int] NOT NULL,
	[store_sk] [int] NOT NULL,
	[order_qty] [int] NULL,
	[order_price] [smallmoney] NULL,
 CONSTRAINT [oft_pk] PRIMARY KEY CLUSTERED 
(
	[order_sk] ASC,
	[customer_sk] ASC,
	[product_sk] ASC,
	[date_sk] ASC,
	[store_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[order_stg]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[order_stg](
	[order_no] [varchar](10) NOT NULL,
	[order_date] [varchar](25) NULL,
	[cust_code] [varchar](10) NULL,
	[store_id] [varchar](3) NULL,
	[product_id] [varchar](50) NULL,
	[order_qty] [varchar](5) NULL,
	[order_price] [varchar](20) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product_dim]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[product_dim](
	[product_sk] [int] IDENTITY(1,1) NOT NULL,
	[product_code] [varchar](50) NULL,
	[product_name] [varchar](50) NULL,
	[product_price] [decimal](18, 2) NULL,
	[product_category] [varchar](50) NULL,
	[effective_date] [date] NULL,
	[expiry_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product_stg]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_stg](
	[product_code] [nvarchar](50) NULL,
	[product_name] [nvarchar](50) NULL,
	[product_price] [nvarchar](50) NULL,
	[product_category] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[store_dim]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[store_dim](
	[store_sk] [int] IDENTITY(1,1) NOT NULL,
	[store_id] [int] NOT NULL,
	[store_name] [varchar](50) NOT NULL,
	[store_location] [varchar](50) NOT NULL,
	[effective_date] [date] NULL,
	[expiry_date] [date] NULL,
 CONSTRAINT [PK__store_di__A2F3D558F6F0EE93] PRIMARY KEY CLUSTERED 
(
	[store_sk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vw_orders]    Script Date: 5/11/2017 12:18:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vw_orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[order_date] [datetime] NOT NULL,
	[customerid] [int] NOT NULL,
	[store] [int] NOT NULL,
	[product_no] [int] NOT NULL,
	[qty] [int] NOT NULL,
	[order_price] [decimal](18, 2) NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[customer_dim] ADD  DEFAULT (getdate()) FOR [effective_date]
GO
ALTER TABLE [dbo].[customer_dim] ADD  DEFAULT ('9999-12-31') FOR [expiry_date]
GO
ALTER TABLE [dbo].[date_dim] ADD  DEFAULT (getdate()) FOR [effective_date]
GO
ALTER TABLE [dbo].[date_dim] ADD  DEFAULT ('9999-12-31') FOR [expiry_date]
GO
ALTER TABLE [dbo].[order_dim] ADD  DEFAULT (getdate()) FOR [effective_date]
GO
ALTER TABLE [dbo].[order_dim] ADD  DEFAULT ('9999-12-31') FOR [expiry_date]
GO
ALTER TABLE [dbo].[product_dim] ADD  DEFAULT (getdate()) FOR [effective_date]
GO
ALTER TABLE [dbo].[product_dim] ADD  DEFAULT ('9999-12-31') FOR [expiry_date]
GO
ALTER TABLE [dbo].[store_dim] ADD  CONSTRAINT [DF__store_dim__effec__59FA5E80]  DEFAULT (getdate()) FOR [effective_date]
GO
ALTER TABLE [dbo].[store_dim] ADD  CONSTRAINT [DF__store_dim__expir__5AEE82B9]  DEFAULT ('9999-12-31') FOR [expiry_date]
GO
ALTER TABLE [dbo].[vw_orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[vw_orders] ADD  DEFAULT ((1)) FOR [store]
GO
ALTER TABLE [dbo].[order_fact_table]  WITH CHECK ADD  CONSTRAINT [oft_customer_sk_fk] FOREIGN KEY([customer_sk])
REFERENCES [dbo].[customer_dim] ([customer_sk])
GO
ALTER TABLE [dbo].[order_fact_table] CHECK CONSTRAINT [oft_customer_sk_fk]
GO
ALTER TABLE [dbo].[order_fact_table]  WITH CHECK ADD  CONSTRAINT [oft_date_sk_fk] FOREIGN KEY([date_sk])
REFERENCES [dbo].[date_dim] ([date_sk])
GO
ALTER TABLE [dbo].[order_fact_table] CHECK CONSTRAINT [oft_date_sk_fk]
GO
ALTER TABLE [dbo].[order_fact_table]  WITH CHECK ADD  CONSTRAINT [oft_order_sk_fk] FOREIGN KEY([order_sk])
REFERENCES [dbo].[order_dim] ([order_sk])
GO
ALTER TABLE [dbo].[order_fact_table] CHECK CONSTRAINT [oft_order_sk_fk]
GO
ALTER TABLE [dbo].[order_fact_table]  WITH CHECK ADD  CONSTRAINT [oft_product_sk_fk] FOREIGN KEY([product_sk])
REFERENCES [dbo].[product_dim] ([product_sk])
GO
ALTER TABLE [dbo].[order_fact_table] CHECK CONSTRAINT [oft_product_sk_fk]
GO
ALTER TABLE [dbo].[order_fact_table]  WITH CHECK ADD  CONSTRAINT [oft_store_sk_fk] FOREIGN KEY([store_sk])
REFERENCES [dbo].[store_dim] ([store_sk])
GO
ALTER TABLE [dbo].[order_fact_table] CHECK CONSTRAINT [oft_store_sk_fk]
GO
