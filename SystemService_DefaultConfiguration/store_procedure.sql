USE PrintingServices;
GO



-- Tạo record mới cho DefaultConfig
CREATE OR ALTER PROCEDURE SystemService.spCreateDefaultConfig (
	@Id VARCHAR(50),
    @DfPage INT,
    @DfGivenDate DATE,
    @FileTypes VARCHAR(100),
    @SPSOId VARCHAR(50)
	)
AS
BEGIN
    --defautlPage âm
    IF @DfPage < 0
    BEGIN
        RAISERROR ('DefaultPage must be greater than 0', 16, 1);
        RETURN;
    END;
    --defaultGivenDate < current date
    IF @DfGivenDate < GETDATE()
    BEGIN
        RAISERROR ('DefaultGivenDate must be greater than current date', 16, 1);
        RETURN;
    END;    
    --spsoId không tồn tại
    IF NOT EXISTS (SELECT * FROM SystemService.SPSO WHERE Id = @SPSOId)
    BEGIN
        RAISERROR ('SPSOId does not exist', 16, 1);
        RETURN;
    END;

	INSERT INTO SystemService.DefaultConfiguration (Id, DefaultPage, DefaultGivenDate, PermittedFileTypes, CreatedAt, SPSOId)
	VALUES	(@Id, @DfPage, @DfGivenDate, @FileTypes, GETDATE(), @SPSOId);
END;
GO

-- thực thi mới cho DefaultConfig
EXECUTE SystemService.CreateDefaultConfig 'DC006', 447, '2024-05-17', 'PDF, DOCX','S001';
DROP PROCEDURE SystemService.CreateDefaultConfig;
GO

-- Update for DefaultConfig id lớn nhất (record mới nhất)
CREATE OR ALTER PROCEDURE SystemService.spUpdateDefaultConfig (
    @DfPage INT,
    @DfGivenDate DATE,
    @FileTypes VARCHAR(100),
    @SPSOId VARCHAR(50)
    )
AS
BEGIN
    --defautlPage âm
    IF @DfPage < 0
    BEGIN
        RAISERROR ('DefaultPage must be greater than 0', 16, 1);
        RETURN;
    END;
    --defaultGivenDate < current date
    IF @DfGivenDate < GETDATE()
    BEGIN
        RAISERROR ('DefaultGivenDate must be greater than current date', 16, 1);
        RETURN;
    END;    
    --spsoId không tồn tại
    IF NOT EXISTS (SELECT * FROM SystemService.SPSO WHERE Id = @SPSOId)
    BEGIN
        RAISERROR ('SPSOId does not exist', 16, 1);
        RETURN;
    END;

    UPDATE SystemService.DefaultConfiguration
    SET DefaultPage = @DfPage,
        DefaultGivenDate = @DfGivenDate,
        PermittedFileTypes = @FileTypes,
        SPSOId = @SPSOId
    WHERE Id = @Id AND CreatedAt = (SELECT MAX(CreatedAt) FROM SystemService.DefaultConfiguration WHERE Id = @Id);
END;

-- thực ti ví dụ Update
EXECUTE SystemService.spUpdateDefaultConfig 47, '2024-05-17', 'PDF, DOCX','S001';
DROP PROCEDURE SystemService.spUpdateDefaultConfig;
GO



--END