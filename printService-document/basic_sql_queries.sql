-- SQL Queries for PrintService.Document Table
USE PrintingServices;
GO
-- 1. Fetch all documents for a specific customer
SELECT *
FROM PrintService.Document
WHERE CustomerId = 'C001';

-- 2. Fetch documents created within a specific date range
SELECT *
FROM PrintService.Document
WHERE CreatedAt BETWEEN '2024-12-01' AND '2024-12-31';

-- 3. Fetch documents with specific file types
SELECT *
FROM PrintService.Document
WHERE FileType IN ('PDF', 'DOCX');

-- 4. Fetch documents containing a keyword in their name
SELECT *
FROM PrintService.Document
WHERE FileName LIKE '%Report%';

-- 5. Count the total number of documents by each customer
SELECT CustomerId, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY CustomerId;

-- 6. Find customers who have uploaded more than 10 documents
SELECT CustomerId, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY CustomerId
HAVING COUNT(*) > 10;

-- 7. Order documents by creation date (newest first)
SELECT *
FROM PrintService.Document
ORDER BY CreatedAt DESC;

-- 8. Count the total documents and average file count per customer
SELECT COUNT(*) AS TotalDocuments, AVG(FileCount) AS AvgDocumentsPerCustomer
FROM (
    SELECT CustomerId, COUNT(*) AS FileCount
    FROM PrintService.Document
    GROUP BY CustomerId
) AS DocumentStats;

-- 9. Fetch the earliest and latest documents created by each customer
SELECT CustomerId, MIN(CreatedAt) AS EarliestDocument, MAX(CreatedAt) AS LatestDocument
FROM PrintService.Document
GROUP BY CustomerId;

-- 10. Fetch documents uploaded by multiple customers (specific IDs)
SELECT *
FROM PrintService.Document
WHERE CustomerId IN ('C001', 'C002', 'C003');

-- 11. Fetch the total number of documents grouped by file type
SELECT FileType, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY FileType;
