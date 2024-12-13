-- User-Defined Function: Calculate Total Documents Uploaded by a Customer
USE PrintingServices;
GO

CREATE OR ALTER FUNCTION PrintService.fnGetTotalDocumentsByCustomer (
    @CustomerId NVARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalDocuments INT;
    SELECT @TotalDocuments = COUNT(*)
    FROM PrintService.Document
    WHERE CustomerId = @CustomerId;
    RETURN ISNULL(@TotalDocuments, 0);
END;

-- Test the function
SELECT PrintService.fnGetTotalDocumentsByCustomer('C001') AS TotalDocuments;


-- User-Defined Function: Calculate Average Documents Uploaded Per Day by a Customer
USE PrintingServices;
GO

CREATE OR ALTER FUNCTION PrintService.fnGetAverageDocumentsPerDayByCustomer (
    @CustomerId NVARCHAR(50)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalDocuments INT;
    DECLARE @FirstUploadDate DATE;
    DECLARE @LastUploadDate DATE;
    DECLARE @TotalDays INT;
    DECLARE @AveragePerDay DECIMAL(10, 2);

    SELECT @TotalDocuments = COUNT(*),
           @FirstUploadDate = MIN(CAST(CreatedAt AS DATE)),
           @LastUploadDate = MAX(CAST(CreatedAt AS DATE))
    FROM PrintService.Document
    WHERE CustomerId = @CustomerId;

    IF @TotalDocuments = 0 OR @FirstUploadDate IS NULL OR @LastUploadDate IS NULL
        SET @AveragePerDay = 0;
    ELSE
    BEGIN
        SET @TotalDays = DATEDIFF(DAY, @FirstUploadDate, @LastUploadDate) + 1;
        SET @AveragePerDay = @TotalDocuments * 1.0 / @TotalDays;
    END;

    RETURN ISNULL(@AveragePerDay, 0);
END;

-- Test the function
SELECT PrintService.fnGetAverageDocumentsPerDayByCustomer('C001') AS AverageDocumentsPerDay;