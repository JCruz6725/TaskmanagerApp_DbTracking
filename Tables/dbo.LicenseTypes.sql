USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[LicenseTypes]    Script Date: 2/18/2026 10:41:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LicenseTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[LicenseTitle] [varchar](64) NOT NULL,
 CONSTRAINT [PK_LicenseTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LicenseTypes] ADD  CONSTRAINT [DF_LicenseTypes_Id]  DEFAULT (newid()) FOR [Id]
GO
