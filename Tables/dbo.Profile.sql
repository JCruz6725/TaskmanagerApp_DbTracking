USE [TaskManagerApp]
GO

/****** Object:  Table [dbo].[Profile]    Script Date: 2/18/2026 10:41:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Profile](
	[Id] [uniqueidentifier] NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[PhoneNumber] [varchar](64) NOT NULL,
	[Gender] [varchar](64) NOT NULL,
	[Education] [varchar](64) NOT NULL,
	[Employer] [varchar](64) NOT NULL,
	[JobTitle] [varchar](64) NOT NULL,
	[PurposeId] [uniqueidentifier] NOT NULL,
	[LicenseId] [uniqueidentifier] NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_PurposeTypes] FOREIGN KEY([PurposeId])
REFERENCES [dbo].[PurposeTypes] ([Id])
GO

ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_PurposeTypes]
GO

ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_LicenseTypes] FOREIGN KEY([LicenseId])
REFERENCES [dbo].[LicenseTypes] ([Id])
GO

ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_LicenseTypes]
GO

ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_Users]
GO


