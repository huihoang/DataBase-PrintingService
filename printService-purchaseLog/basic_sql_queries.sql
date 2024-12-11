-- SQL Queries for PrintService.PurchaseLog

USE PrintingServices;
GO

-- 1. Fetch all purchase logs for a specific CustomerId
SELECT *
FROM PrintService.PurchaseLog
WHERE CustomerId = 'C001';

-- 2. Fetch all purchase logs within a specific time range
SELECT *
FROM PrintService.PurchaseLog
WHERE TransactionTime BETWEEN '2024-12-01' AND '2024-12-31';

-- 3. Fetch all successful purchase logs
SELECT *
FROM PrintService.PurchaseLog
WHERE PurchaseStatus = 'Success' AND CustomerId = 'C001';

-- 4. Total pages and total price grouped by customer
SELECT CustomerId, SUM(NumberOfPage) AS TotalPages, SUM(Price) AS TotalPrice
FROM PrintService.PurchaseLog
WHERE PurchaseStatus = 'Success'
GROUP BY CustomerId;

-- 5. Successful transaction count by customer
SELECT CustomerId, COUNT(*) AS SuccessfulTransactions
FROM PrintService.PurchaseLog
WHERE PurchaseStatus = 'Success'
GROUP BY CustomerId;

-- 6. Average price of successful transactions
SELECT AVG(Price) AS AveragePrice
FROM PrintService.PurchaseLog
WHERE PurchaseStatus = 'Success';

-- 7. Transaction with the maximum pages and price
SELECT MAX(NumberOfPage) AS MaxPages, MAX(Price) AS MaxPrice
FROM PrintService.PurchaseLog;

-- 8. Complex conditions with IN, LIKE, AND
SELECT *
FROM PrintService.PurchaseLog
WHERE CustomerId IN ('C001', 'C002')
  AND PurchaseStatus LIKE 'Success';

-- 9. Fetch customers with a total spend exceeding a threshold
SELECT CustomerId, SUM(Price) AS TotalSpent
FROM PrintService.PurchaseLog
GROUP BY CustomerId
HAVING SUM(Price) > 500;

-- 10. Fetch recent transactions ordered by time
SELECT TOP 10 *
FROM PrintService.PurchaseLog
ORDER BY TransactionTime DESC;

-- 11. Fetch customers with minimum or maximum total spending
-- Maximum spending
SELECT TOP 1 CustomerId, SUM(Price) AS TotalSpent
FROM PrintService.PurchaseLog
GROUP BY CustomerId
ORDER BY TotalSpent DESC;

-- Minimum spending (more than 0)
SELECT TOP 1 CustomerId, SUM(Price) AS TotalSpent
FROM PrintService.PurchaseLog
GROUP BY CustomerId
HAVING SUM(Price) > 0
ORDER BY TotalSpent ASC;

-- 12. Total transactions and their success rate
SELECT 
    COUNT(*) AS TotalTransactions,
    SUM(CASE WHEN PurchaseStatus = 'Success' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS SuccessRate
FROM PrintService.PurchaseLog;

-- 13. Fetch transactions by pattern matching in CustomerId
SELECT *
FROM PrintService.PurchaseLog
WHERE CustomerId LIKE 'C00%';
