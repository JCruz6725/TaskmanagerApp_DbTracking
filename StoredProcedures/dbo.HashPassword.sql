USE [TaskManagerApp]
GO

/****** Object:  StoredProcedure [dbo].[HashPassword]    Script Date: 2/20/2026 4:51:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


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


