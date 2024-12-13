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
WHERE CreatedAt BETWEEN '2024-12-01 00:00:00' AND '2024-12-31 23:59:59';

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

-- 8. Count the total documents and average number of pages per customer
SELECT COUNT(*) AS TotalDocuments, AVG(NumOfPage) AS AvgPagesPerDocument
FROM PrintService.Document;

-- 9. Fetch the earliest and latest documents created by each customer
SELECT CustomerId, MIN(CreatedAt) AS EarliestDocument, MAX(CreatedAt) AS LatestDocument
FROM PrintService.Document
GROUP BY CustomerId;

-- 10. Fetch the total number of documents grouped by file type
SELECT FileType, COUNT(*) AS TotalDocuments
FROM PrintService.Document
GROUP BY FileType;

-- 11. Fetch documents with more than a specific number of pages
SELECT *
FROM PrintService.Document
WHERE NumOfPage > 100;

-- 12. Fetch the total number of pages uploaded by each customer
SELECT CustomerId, SUM(NumOfPage) AS TotalPages
FROM PrintService.Document
GROUP BY CustomerId;
