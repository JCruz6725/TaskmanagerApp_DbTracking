USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[Password]    Script Date: 2/18/2026 10:41:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Password](
	[Id] [uniqueidentifier] NOT NULL,
	[PasswordHash] [varbinary](64) NOT NULL,
	[Salt] [varbinary](64) NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Password] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Password] ADD  CONSTRAINT [DF_Password_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[Password]  WITH CHECK ADD  CONSTRAINT [FK_Password_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Password] CHECK CONSTRAINT [FK_Password_Users]
GO
