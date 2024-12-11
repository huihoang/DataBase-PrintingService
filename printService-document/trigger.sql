-- Trigger: Validate FileType Based on Latest DefaultConfiguration

USE PrintingServices;
GO

CREATE TRIGGER trgValidateFileType
ON PrintService.Document
INSTEAD OF INSERT
AS
BEGIN
    -- Validate FileType against the latest DefaultConfiguration for each inserted row
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN (
            SELECT SPSOId, PermittedFileTypes
            FROM SystemService.DefaultConfiguration dc
            WHERE CreatedAt = (
                SELECT MAX(CreatedAt)
                FROM SystemService.DefaultConfiguration dc2
                WHERE dc.SPSOId = dc2.SPSOId
            )
        ) latestConfig ON i.CustomerId = latestConfig.SPSOId
        WHERE latestConfig.PermittedFileTypes IS NOT NULL
          AND CHARINDEX(i.FileType, latestConfig.PermittedFileTypes) = 0
    )
    BEGIN
        RAISERROR ('Invalid FileType for the given Customer.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO PrintService.Document (Id, CreatedAt, FileName, FileType, PrintLogId, CustomerId)
        SELECT Id, CreatedAt, FileName, FileType, PrintLogId, CustomerId
        FROM inserted;
    END
END;

-- Test Cases
-- Valid FileType
INSERT INTO PrintService.Document (Id, FileName, FileType, PrintLogId, CustomerId)
VALUES ('D001', 'TestFile1.pdf', 'PDF', NULL, 'C001');

-- Invalid FileType
INSERT INTO PrintService.Document (Id, FileName, FileType, PrintLogId, CustomerId)
VALUES ('D002', 'TestFile2.exe', 'EXE', NULL, 'C001');

-- No DefaultConfiguration (should be allowed)
INSERT INTO PrintService.Document (Id, FileName, FileType, PrintLogId, CustomerId)
VALUES ('D003', 'TestFile3.txt', 'TXT', NULL, 'C001');
