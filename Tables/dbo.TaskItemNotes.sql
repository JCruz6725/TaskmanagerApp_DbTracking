USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[TaskItemNotes]    Script Date: 2/19/2026 9:48:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TaskItemNotes](
	[Id] [uniqueidentifier] NOT NULL,
	[TaskItemId] [uniqueidentifier] NOT NULL,
	[Note] [varchar](max) NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TaskItemNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[TaskItemNotes] ADD  CONSTRAINT [DF_TaskItemNotes_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[TaskItemNotes]  WITH CHECK ADD  CONSTRAINT [FK_TaskItemNotes_TaskItems] FOREIGN KEY([TaskItemId])
REFERENCES [dbo].[TaskItems] ([Id])
GO

ALTER TABLE [dbo].[TaskItemNotes] CHECK CONSTRAINT [FK_TaskItemNotes_TaskItems]
GO

ALTER TABLE [dbo].[TaskItemNotes]  WITH CHECK ADD  CONSTRAINT [FK_TaskItemNotes_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[TaskItemNotes] CHECK CONSTRAINT [FK_TaskItemNotes_Users]
GO


