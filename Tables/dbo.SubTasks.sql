USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[SubTasks]    Script Date: 2/19/2026 9:47:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SubTasks](
	[Id] [uniqueidentifier] NOT NULL,
	[TaskItemId] [uniqueidentifier] NOT NULL,
	[SubTaskItemId] [uniqueidentifier] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_SubTasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SubTasks] ADD  CONSTRAINT [DF_SubTasks_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[SubTasks]  WITH CHECK ADD  CONSTRAINT [FK_SubTasks_TaskItems] FOREIGN KEY([TaskItemId])
REFERENCES [dbo].[TaskItems] ([Id])
GO

ALTER TABLE [dbo].[SubTasks] CHECK CONSTRAINT [FK_SubTasks_TaskItems]
GO

ALTER TABLE [dbo].[SubTasks]  WITH CHECK ADD  CONSTRAINT [FK_SubTasks_TaskItems1] FOREIGN KEY([SubTaskItemId])
REFERENCES [dbo].[TaskItems] ([Id])
GO

ALTER TABLE [dbo].[SubTasks] CHECK CONSTRAINT [FK_SubTasks_TaskItems1]
GO

ALTER TABLE [dbo].[SubTasks]  WITH CHECK ADD  CONSTRAINT [FK_SubTasks_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[SubTasks] CHECK CONSTRAINT [FK_SubTasks_Users]
GO


