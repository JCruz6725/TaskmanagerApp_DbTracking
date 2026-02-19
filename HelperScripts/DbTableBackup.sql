USE [master]
GO
/****** Object:  Database [TaskManagerApp]    Script Date: 10/2/2025 1:32:14 AM ******/
CREATE DATABASE [TaskManagerApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskManagerApp', FILENAME = N'C:\Users\< UserName_Here >\TaskManagerApp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TaskManagerApp_log', FILENAME = N'C:\Users\< UserName_Here >\TaskManagerApp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TaskManagerApp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskManagerApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskManagerApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskManagerApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskManagerApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskManagerApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskManagerApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskManagerApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaskManagerApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskManagerApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskManagerApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskManagerApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskManagerApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskManagerApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskManagerApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskManagerApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskManagerApp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TaskManagerApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskManagerApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskManagerApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskManagerApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskManagerApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskManagerApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaskManagerApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskManagerApp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TaskManagerApp] SET  MULTI_USER 
GO
ALTER DATABASE [TaskManagerApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskManagerApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskManagerApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskManagerApp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TaskManagerApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TaskManagerApp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TaskManagerApp] SET QUERY_STORE = OFF
GO
USE [TaskManagerApp]
GO
/****** Object:  Table [dbo].[Lists]    Script Date: 10/2/2025 1:32:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lists](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](64) NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Lists] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 10/2/2025 1:32:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[Code] [int] NOT NULL,
 CONSTRAINT [PK_Statuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubTasks]    Script Date: 10/2/2025 1:32:14 AM ******/
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
/****** Object:  Table [dbo].[TaskItemNotes]    Script Date: 10/2/2025 1:32:14 AM ******/
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
/****** Object:  Table [dbo].[TaskItems]    Script Date: 10/2/2025 1:32:14 AM ******/
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
/****** Object:  Table [dbo].[TaskItemStatusHistory]    Script Date: 10/2/2025 1:32:14 AM ******/
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
/****** Object:  Table [dbo].[TaskWithinList]    Script Date: 10/2/2025 1:32:14 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 10/2/2025 1:32:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[FirstName] [varchar](64) NOT NULL,
	[LastName] [varchar](64) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[Password] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Lists] ADD  CONSTRAINT [DF_Lists_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Statuses] ADD  CONSTRAINT [DF_Statuses_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[SubTasks] ADD  CONSTRAINT [DF_SubTasks_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[TaskItemNotes] ADD  CONSTRAINT [DF_TaskItemNotes_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[TaskItems] ADD  CONSTRAINT [DF_TaskItems_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[TaskItemStatusHistory] ADD  CONSTRAINT [DF_TaskItemStatusHistory_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Lists]  WITH CHECK ADD  CONSTRAINT [FK_Lists_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Lists] CHECK CONSTRAINT [FK_Lists_Users]
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
ALTER TABLE [dbo].[TaskItems]  WITH CHECK ADD  CONSTRAINT [FK_TaskItems_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[TaskItems] CHECK CONSTRAINT [FK_TaskItems_Users]
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
USE [master]
GO
ALTER DATABASE [TaskManagerApp] SET  READ_WRITE 
GO
