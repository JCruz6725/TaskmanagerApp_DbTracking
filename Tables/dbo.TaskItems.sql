USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[TaskItems]    Script Date: 2/19/2026 9:48:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TaskItems](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [varchar](max) NOT NULL,
	[DueDate] [smalldatetime] NULL,
	[Priority] [int] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TaskItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[TaskItems] ADD  CONSTRAINT [DF_TaskItems_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[TaskItems]  WITH CHECK ADD  CONSTRAINT [FK_TaskItems_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[TaskItems] CHECK CONSTRAINT [FK_TaskItems_Users]
GO


