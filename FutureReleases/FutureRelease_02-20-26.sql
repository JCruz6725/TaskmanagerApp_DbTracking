USE [TaskManagerApp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

BEGIN TRY
	BEGIN TRANSACTION;
		/****** Create LicenseTypes table with relationships ******/
		CREATE TABLE [dbo].[LicenseTypes](
			[Id] [uniqueidentifier] NOT NULL,
			[LicenseTitle] [varchar](64) NOT NULL,
		 CONSTRAINT [PK_LicenseTypes] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[LicenseTypes] ADD  CONSTRAINT [DF_LicenseTypes_Id]  DEFAULT (newid()) FOR [Id]


		/****** Create PurposeTypes table with relationships ******/
		CREATE TABLE [dbo].[PurposeTypes](
			[Id] [uniqueidentifier] NOT NULL,
			[PurposeTitle] [varchar](64) NOT NULL,
		CONSTRAINT [PK_PurposeTypes] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[PurposeTypes] ADD  CONSTRAINT [DF_PurposeTypes_Id]  DEFAULT (newid()) FOR [Id]


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

		ALTER TABLE [dbo].[Profile] ADD  CONSTRAINT [DF_Profile_Id]  DEFAULT (newid()) FOR [Id]

		ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_PurposeTypes] FOREIGN KEY([PurposeId])
		REFERENCES [dbo].[PurposeTypes] ([Id])

		ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_PurposeTypes]

		ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_LicenseTypes] FOREIGN KEY([LicenseId])
		REFERENCES [dbo].[LicenseTypes] ([Id])

		ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_LicenseTypes]

		ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_Users] FOREIGN KEY([CreatedUserId])
		REFERENCES [dbo].[Users] ([Id])
	
		ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_Users]


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

		ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_Id]  DEFAULT (newid()) FOR [Id]

		ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Users] FOREIGN KEY([CreatedUserId])
		REFERENCES [dbo].[Users] ([Id])

		ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Users]


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

		ALTER TABLE [dbo].[DeviceData] ADD  CONSTRAINT [DF_DeviceData_Id]  DEFAULT (newid()) FOR [Id]

		ALTER TABLE [dbo].[DeviceData]  WITH CHECK ADD  CONSTRAINT [FK_DeviceData_Users] FOREIGN KEY([CreatedUserId])
		REFERENCES [dbo].[Users] ([Id])

		ALTER TABLE [dbo].[DeviceData] CHECK CONSTRAINT [FK_DeviceData_Users]


		/****** Create Password table with relationships ******/
		CREATE TABLE [dbo].[Password](
			[Id] [uniqueidentifier] NOT NULL,
			[PasswordHash] [varbinary](64) NOT NULL,
			[Salt] [varchar](64) NOT NULL,
			[CreatedDate] [smalldatetime] NOT NULL,
			[CreatedUserId] [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_Password] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] 

		ALTER TABLE [dbo].[Password] ADD  CONSTRAINT [DF_Password_Id]  DEFAULT (newid()) FOR [Id]

		ALTER TABLE [dbo].[Password]  WITH CHECK ADD  CONSTRAINT [FK_Password_Users] FOREIGN KEY([CreatedUserId])
		REFERENCES [dbo].[Users] ([Id])

		ALTER TABLE [dbo].[Password] CHECK CONSTRAINT [FK_Password_Users]

		EXEC sp_executesql N'
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
			DECLARE @LCV tinyint;
			DECLARE @i int = 0; 
				SET @LCV = 12;
			WHILE (32 > @i or @i > 126)
			BEGIN 
				SET @i = ROUND((RAND() * 100) +32,0)
		END; 
				SET @Salt = CHAR(@i);
			WHILE (@LCV < 25)
			BEGIN
				SET @i = 0;
			WHILE (32 > @i or @i > 126)
			BEGIN 
			SET @i = ROUND((RAND() * 100) +32,0)
		END;
		/* Salt must be between 32 and 126 in the ASCII table to avoid issues with hashing and storage */
		/* Salt is a total of 15 characters /*
				SET @Salt = @Salt + CHAR(@i)
				SET @LCV = @LCV + 1;
		END;
				SET @PwdWithSalt = @Salt + @PlainPassword;
			PRINT HASHBYTES(''SHA2_256'', @PwdWithSalt);
			INSERT INTO dbo.Password(Salt, PasswordHash, CreatedDate, CreatedUserId)
			VALUES (@Salt, HASHBYTES(''SHA2_256'', @PwdWithSalt), GETDATE(), @UserId);
		END';


		Declare @hashQuery nvarchar(Max);

		select 
			@hashQuery = 
			CONCAT_WS('', @hashQuery, 'EXEC HashPassword @PlainPassword=', Password, ', @UserId=','''',Id,'''',';' )
		from users 

		exec sp_executesql @hashQuery

		/*drop password from User*/
		ALTER TABLE Users DROP COLUMN Password;

		select * From Password

	rollback TRANSACTION;

END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
		THROW;
END CATCH

