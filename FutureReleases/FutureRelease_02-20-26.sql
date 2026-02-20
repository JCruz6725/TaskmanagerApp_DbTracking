USE [TaskManagerApp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Create LicenseTypes table with relationships ******/
CREATE TABLE [dbo].[LicenseTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[LicenseTitle] [varchar](64) NOT NULL,
 CONSTRAINT [PK_LicenseTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LicenseTypes] ADD  CONSTRAINT [DF_LicenseTypes_Id]  DEFAULT (newid()) FOR [Id]
GO


/****** Create PurposeTypes table with relationships ******/
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


/****** Create Profile table with relationships ******/
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


/****** Create Address table with relationships ******/
CREATE TABLE [dbo].[Address](
	[Id] [uniqueidentifier] NOT NULL,
	[Address] [varchar](64) NOT NULL,
	[City] [varchar](64) NOT NULL,
	[State] [varchar](64) NOT NULL,
	[Zipcode] [varchar](64) NOT NULL,
	[CreatedUserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_Id]  DEFAULT (newid()) FOR [Id]
GO

ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Users] FOREIGN KEY([CreatedUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Users]
GO


/****** Create DeviceData table with relationships ******/
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


/****** Create Password table with relationships ******/
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


/*Hash and move password data from Users into Password*/
CREATE PROC [dbo].[HashPassword]
    @PlainPassword VARCHAR(100),
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @Salt VARCHAR(25);
    DECLARE @PwdWithSalt VARCHAR(125);
    -- Generate salt --
    DECLARE @Seed int;
    DECLARE @LCV tinyint;
    DECLARE @CTime DATETIME;
    SET @CTime = GETDATE();
    SET @Seed = (DATEPART(hh, @Ctime) * 10000000) + (DATEPART(n, @CTime) * 100000)
      + (DATEPART(s, @CTime) * 1000) + DATEPART(ms, @CTime);
        SET @LCV = 1;
    SET @Salt = CHAR(ROUND((RAND(@Seed) * 94.0) + 32, 3));
    WHILE (@LCV < 25)
    BEGIN
        SET @Salt = @Salt + CHAR(ROUND((RAND() * 94.0) + 32, 3));
        SET @LCV = @LCV + 1;
    END;
    SET @PwdWithSalt = @Salt + @PlainPassword;
	PRINT HASHBYTES('SHA2_256', @PwdWithSalt);
    INSERT INTO dbo.Password(Salt, PasswordHash, CreatedDate, CreatedUserId)
    VALUES (@Salt, HASHBYTES('SHA2_256', @PwdWithSalt), GETDATE(), @UserId);
END;
GO

Declare @hashQuery nvarchar(Max);

select 
	@hashQuery = 
	CONCAT_WS('', @hashQuery, 'EXEC HashPassword @PlainPassword=', Password, ', @UserId=','''',Id,'''',';' )
from users 

exec sp_executesql @hashQuery


/*drop password from User*/
ALTER TABLE Users DROP COLUMN Password;