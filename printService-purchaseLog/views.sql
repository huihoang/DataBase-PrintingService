-- SQL Views for Statistical Analysis of PurchaseLog

USE PrintingServices;
GO

-- 1. Total Pages and Total Price by Customer
CREATE OR ALTER VIEW vwCustomerSummary AS
SELECT CustomerId, SUM(NumberOfPage) AS TotalPages, SUM(Price) AS TotalPrice
FROM PrintService.PurchaseLog
WHERE PurchaseStatus = 'Success'
GROUP BY CustomerId;

-- Test vwCustomerSummary
SELECT * FROM vwCustomerSummary;

-- 2. Daily Transaction Statistics
CREATE OR ALTER VIEW vwDailyTransactionSummary AS
SELECT TransactionTime, COUNT(*) AS TotalTransactions, SUM(NumberOfPage) AS TotalPages, SUM(Price) AS TotalRevenue
FROM PrintService.PurchaseLog
GROUP BY TransactionTime;

-- Test vwDailyTransactionSummary
SELECT * FROM vwDailyTransactionSummary;

-- 3. Success and Failure Count by Customer
CREATE OR ALTER VIEW vwCustomerTransactionStatus AS
SELECT CustomerId,
       SUM(CASE WHEN PurchaseStatus = 'Success' THEN 1 ELSE 0 END) AS SuccessCount,
       SUM(CASE WHEN PurchaseStatus = 'Failed' THEN 1 ELSE 0 END) AS FailureCount
FROM PrintService.PurchaseLog
GROUP BY CustomerId;

-- Test vwCustomerTransactionStatus
SELECT * FROM vwCustomerTransactionStatus;

-- 4. Monthly Revenue Summary
CREATE OR ALTER VIEW vwMonthlyRevenueSummary AS
SELECT YEAR(TransactionTime) AS TransactionYear, MONTH(TransactionTime) AS TransactionMonth, 
       SUM(Price) AS TotalRevenue
FROM PrintService.PurchaseLog
GROUP BY YEAR(TransactionTime), MONTH(TransactionTime);

-- Test vwMonthlyRevenueSummary
SELECT * FROM vwMonthlyRevenueSummary;

-- 5. Top Spending Customers
CREATE OR ALTER VIEW vwTopCustomers AS
SELECT TOP 10 CustomerId, SUM(Price) AS TotalSpending
FROM PrintService.PurchaseLog
GROUP BY CustomerId
ORDER BY TotalSpending DESC;

-- Test vwTopCustomers
SELECT * FROM vwTopCustomers;

-- 6. Average Transaction Value by Customer
CREATE OR ALTER VIEW vwAverageTransactionByCustomer AS
SELECT CustomerId, AVG(Price) AS AverageTransactionValue
FROM PrintService.PurchaseLog
GROUP BY CustomerId;

-- Test vwAverageTransactionByCustomer
SELECT * FROM vwAverageTransactionByCustomer;

-- 7. Peak Transaction Days
CREATE OR ALTER VIEW vwPeakTransactionDays AS
SELECT TransactionTime, COUNT(*) AS TotalTransactions
FROM PrintService.PurchaseLog
GROUP BY TransactionTime

-- Test vwPeakTransactionDays
SELECT * FROM vwPeakTransactionDays;

-- 8. Revenue and Pages by Transaction Status
CREATE OR ALTER VIEW vwRevenueByStatus AS
SELECT PurchaseStatus, SUM(NumberOfPage) AS TotalPages, SUM(Price) AS TotalRevenue
FROM PrintService.PurchaseLog
GROUP BY PurchaseStatus;

-- Test vwRevenueByStatus
SELECT * FROM vwRevenueByStatus;
