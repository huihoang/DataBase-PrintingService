-- Stored Procedure: Get Documents by Condition
USE PrintingServices;
GO

CREATE OR ALTER PROCEDURE PrintService.spGetDocumentByCondition
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL,
    @CustomerId NVARCHAR(50) = NULL,
    @PrintLogId INT = NULL,
    @FileName NVARCHAR(255) = NULL,
    @FileType NVARCHAR(50) = NULL
AS
BEGIN
    SELECT *
    FROM PrintService.Document
    WHERE (
        @StartDate IS NULL OR @EndDate IS NULL OR CreatedAt BETWEEN @StartDate AND @EndDate
    )
    AND (
        @CustomerId IS NULL OR CustomerId = @CustomerId
    )
    AND (
        @PrintLogId IS NULL OR PrintLogId = @PrintLogId
    )
    AND (
        @FileName IS NULL OR FileName LIKE '%' + @FileName + '%'
    )
    AND (
        @FileType IS NULL OR FileType = @FileType
    );
END;

-- Test the stored procedure
-- Fetch all documents within a specific date range
EXEC PrintService.spGetDocumentByCondition @StartDate = '2024-01-01', @EndDate = '2024-1-31';

-- Fetch documents for a specific customer
EXEC PrintService.spGetDocumentByCondition @CustomerId = 'C001';

-- Fetch documents with a specific file type
EXEC PrintService.spGetDocumentByCondition @FileType = 'PDF';

-- Fetch documents containing a specific keyword in the file name
EXEC PrintService.spGetDocumentByCondition @FileName = 'Report', @FileType = 'PDF';

-- Fetch documents linked to a specific print log
EXEC PrintService.spGetDocumentByCondition @PrintLogId = 123;