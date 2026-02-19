USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[TaskWithinList]    Script Date: 2/19/2026 9:48:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TaskWithinList](
	[TaskListId] [uniqueidentifier] NOT NULL,
	[TaskItemId] [uniqueidentifier] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TaskWithinList] PRIMARY KEY CLUSTERED 
(
	[TaskListId] ASC,
	[TaskItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TaskWithinList]  WITH CHECK ADD  CONSTRAINT [FK_TaskWithinList_Lists] FOREIGN KEY([TaskListId])
REFERENCES [dbo].[Lists] ([Id])
GO

ALTER TABLE [dbo].[TaskWithinList] CHECK CONSTRAINT [FK_TaskWithinList_Lists]
GO

ALTER TABLE [dbo].[TaskWithinList]  WITH CHECK ADD  CONSTRAINT [FK_TaskWithinList_TaskItems] FOREIGN KEY([TaskItemId])
REFERENCES [dbo].[TaskItems] ([Id])
GO

ALTER TABLE [dbo].[TaskWithinList] CHECK CONSTRAINT [FK_TaskWithinList_TaskItems]
GO

ALTER TABLE [dbo].[TaskWithinList]  WITH CHECK ADD  CONSTRAINT [FK_TaskWithinList_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[TaskWithinList] CHECK CONSTRAINT [FK_TaskWithinList_Users]
GO


