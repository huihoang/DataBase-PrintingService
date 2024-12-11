-- SQL Views for Statistical Analysis of Document Data

USE PrintingServices;
GO

-- 1. Total Documents by Customer
CREATE OR ALTER VIEW vwDocumentCountByCustomer AS
SELECT CustomerId, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY CustomerId;

-- Test vwDocumentCountByCustomer
SELECT * FROM vwDocumentCountByCustomer;

-- 2. Documents by FileType
CREATE OR ALTER VIEW vwDocumentByFileType AS
SELECT FileType, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY FileType;

-- Test vwDocumentByFileType
SELECT * FROM vwDocumentByFileType;

-- 3. Documents Created Per Day
CREATE OR ALTER VIEW vwDailyDocumentCreation AS
SELECT CAST(CreatedAt AS DATE) AS CreationDate, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY CAST(CreatedAt AS DATE);

-- Test vwDailyDocumentCreation
SELECT * FROM vwDailyDocumentCreation;

-- 4. Documents Linked to Print Logs
CREATE OR ALTER VIEW vwDocumentsLinkedToPrintLogs AS
SELECT PrintLogId, COUNT(*) AS TotalDocuments
FROM PrintService.Document
WHERE PrintLogId IS NOT NULL
GROUP BY PrintLogId;

-- Test vwDocumentsLinkedToPrintLogs
SELECT * FROM vwDocumentsLinkedToPrintLogs;

-- 5. Top Customers by Document Count
CREATE OR ALTER VIEW vwTopCustomersByDocument AS
SELECT TOP 10 CustomerId, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY CustomerId
ORDER BY TotalDocuments DESC;

-- Test vwTopCustomersByDocument
SELECT * FROM vwTopCustomersByDocument;

-- 6. Average Documents Per Customer
CREATE OR ALTER VIEW vwAverageDocumentsPerCustomer AS
SELECT AVG(DocumentCount) AS AverageDocuments
FROM (
    SELECT CustomerId, COUNT(*) AS DocumentCount
    FROM PrintService.Document
    GROUP BY CustomerId
) AS CustomerDocumentCounts;

-- Test vwAverageDocumentsPerCustomer
SELECT * FROM vwAverageDocumentsPerCustomer;

-- 7. Recent Documents Created
CREATE OR ALTER VIEW vwRecentDocuments AS
SELECT TOP 20 Id, FileName, FileType, CreatedAt, CustomerId
FROM PrintService.Document
ORDER BY CreatedAt DESC;

-- Test vwRecentDocuments
SELECT * FROM vwRecentDocuments;

-- 8. Documents Without Print Logs
CREATE OR ALTER VIEW vwDocumentsWithoutPrintLogs AS
SELECT *
FROM PrintService.Document
WHERE PrintLogId IS NULL;

-- Test vwDocumentsWithoutPrintLogs
SELECT * FROM vwDocumentsWithoutPrintLogs;
