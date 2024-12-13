-- SQL Views for Statistical Analysis of Document Data with NumOfPage

USE PrintingServices;
GO

-- 1. Total Documents and Total Pages by Customer
CREATE OR ALTER VIEW vwDocumentAndPageCountByCustomer AS
SELECT 
    CustomerId, 
    COUNT(*) AS TotalDocuments, 
    SUM(NumOfPage) AS TotalPages
FROM PrintService.Document
GROUP BY CustomerId;

-- Test vwDocumentAndPageCountByCustomer
SELECT * FROM vwDocumentAndPageCountByCustomer;

-- 2. Documents and Pages by FileType
CREATE OR ALTER VIEW vwDocumentAndPageByFileType AS
SELECT 
    FileType, 
    COUNT(*) AS TotalDocuments, 
    SUM(NumOfPage) AS TotalPages
FROM PrintService.Document
GROUP BY FileType;

-- Test vwDocumentAndPageByFileType
SELECT * FROM vwDocumentAndPageByFileType;

-- 3. Documents and Pages Created Per Day
CREATE OR ALTER VIEW vwDailyDocumentAndPageCreation AS
SELECT 
    CAST(CreatedAt AS DATE) AS CreationDate, 
    COUNT(*) AS TotalDocuments, 
    SUM(NumOfPage) AS TotalPages
FROM PrintService.Document
GROUP BY CAST(CreatedAt AS DATE);

-- Test vwDailyDocumentAndPageCreation
SELECT * FROM vwDailyDocumentAndPageCreation;

-- 4. Documents and Pages Linked to Print Logs
CREATE OR ALTER VIEW vwDocumentsAndPagesLinkedToPrintLogs AS
SELECT 
    PrintLogId, 
    COUNT(*) AS TotalDocuments, 
    SUM(NumOfPage) AS TotalPages
FROM PrintService.Document
WHERE PrintLogId IS NOT NULL
GROUP BY PrintLogId;

-- Test vwDocumentsAndPagesLinkedToPrintLogs
SELECT * FROM vwDocumentsAndPagesLinkedToPrintLogs;

-- 5. Top Customers by Total Documents and Pages
CREATE OR ALTER VIEW vwTopCustomersByDocumentAndPage AS
SELECT TOP 10 
    CustomerId, 
    COUNT(*) AS TotalDocuments, 
    SUM(NumOfPage) AS TotalPages
FROM PrintService.Document
GROUP BY CustomerId
ORDER BY TotalDocuments DESC, TotalPages DESC;

-- Test vwTopCustomersByDocumentAndPage
SELECT * FROM vwTopCustomersByDocumentAndPage;

-- 6. Average Pages Per Document and Per Customer
CREATE OR ALTER VIEW vwAveragePagesPerDocumentAndCustomer AS
SELECT 
    (SELECT AVG(NumOfPage) FROM PrintService.Document) AS AveragePagesPerDocument,
    AVG(CustomerPageStats.TotalPages) AS AveragePagesPerCustomer
FROM (
    SELECT CustomerId, SUM(NumOfPage) AS TotalPages
    FROM PrintService.Document
    GROUP BY CustomerId
) AS CustomerPageStats;

-- Test vwAveragePagesPerDocumentAndCustomer
SELECT * FROM vwAveragePagesPerDocumentAndCustomer;

-- 7. Recent Documents with Total Pages
CREATE OR ALTER VIEW vwRecentDocumentsWithPages AS
SELECT TOP 20 
    Id, 
    FileName, 
    FileType, 
    CreatedAt, 
    CustomerId, 
    NumOfPage
FROM PrintService.Document
ORDER BY CreatedAt DESC;

-- Test vwRecentDocumentsWithPages
SELECT * FROM vwRecentDocumentsWithPages;

-- 8. Documents Without Print Logs Including Pages
CREATE OR ALTER VIEW vwDocumentsWithoutPrintLogsWithPages AS
SELECT 
    Id, 
    FileName, 
    FileType, 
    CreatedAt, 
    NumOfPage, 
    CustomerId
FROM PrintService.Document
WHERE PrintLogId IS NULL;

-- Test vwDocumentsWithoutPrintLogsWithPages
SELECT * FROM vwDocumentsWithoutPrintLogsWithPages;
