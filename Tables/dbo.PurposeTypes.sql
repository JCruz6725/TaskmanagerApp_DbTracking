USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[PurposeTypes]    Script Date: 2/18/2026 10:41:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurposeTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[PurposeTitle] [varchar](64) NOT NULL,
 CONSTRAINT [PK_PurposeTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PurposeTypes] ADD  CONSTRAINT [DF_PurposeTypes_Id]  DEFAULT (newid()) FOR [Id]
GO
