USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[DeviceData]    Script Date: 2/18/2026 10:41:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DeviceData](
	[Id] [uniqueidentifier] NOT NULL,
	[IpAdress] [varchar](64) NOT NULL,
	[BrowserType] [varchar](64) NOT NULL,
	[AccessTime] [int] NOT NULL,
	[AccessCount] [int] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DeviceData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DeviceData] ADD  CONSTRAINT [DF_DeviceData_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[DeviceData]  WITH CHECK ADD  CONSTRAINT [FK_DeviceData_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[DeviceData] CHECK CONSTRAINT [FK_DeviceData_Users]
GO