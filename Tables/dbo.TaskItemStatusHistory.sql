USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[TaskItemStatusHistory]    Script Date: 2/19/2026 9:48:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TaskItemStatusHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[TaskItemId] [uniqueidentifier] NOT NULL,
	[StatusId] [uniqueidentifier] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TaskItemStatusHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TaskItemStatusHistory] ADD  CONSTRAINT [DF_TaskItemStatusHistory_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[TaskItemStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_TaskItemStatusHistory_Statuses] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([Id])
GO

ALTER TABLE [dbo].[TaskItemStatusHistory] CHECK CONSTRAINT [FK_TaskItemStatusHistory_Statuses]
GO

ALTER TABLE [dbo].[TaskItemStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_TaskItemStatusHistory_TaskItems] FOREIGN KEY([TaskItemId])
REFERENCES [dbo].[TaskItems] ([Id])
GO

ALTER TABLE [dbo].[TaskItemStatusHistory] CHECK CONSTRAINT [FK_TaskItemStatusHistory_TaskItems]
GO

ALTER TABLE [dbo].[TaskItemStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_TaskItemStatusHistory_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[TaskItemStatusHistory] CHECK CONSTRAINT [FK_TaskItemStatusHistory_Users]
GO


