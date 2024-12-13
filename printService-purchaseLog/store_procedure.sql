USE PrintingServices;
GO

-- Stored Procedure
CREATE OR ALTER PROCEDURE PrintService.spGetPurchaseLogByCondition
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @Status NVARCHAR(50) = NULL,
    @CustomerId NVARCHAR(50) = NULL
AS
BEGIN
    SELECT *
    FROM PrintService.PurchaseLog
    WHERE (
        @StartDate IS NULL OR @EndDate IS NULL OR TransactionTime BETWEEN @StartDate AND @EndDate
    )
    AND (
        @Status IS NULL OR PurchaseStatus = @Status
    )
    AND (
        @CustomerId IS NULL OR CustomerId = @CustomerId
    );
END;

-- Test Cases for Stored Procedure
-- 1. Retrieve all records
EXEC PrintService.spGetPurchaseLogByCondition;

-- 2. Filter by date range
EXEC PrintService.spGetPurchaseLogByCondition @StartDate = '2024-12-01', @EndDate = '2024-12-31';

-- 3. Filter by status
EXEC PrintService.spGetPurchaseLogByCondition @Status = 'Success';

-- 4. Filter by CustomerId
EXEC PrintService.spGetPurchaseLogByCondition @CustomerId = 'C001';

-- 5. Filter by date range and status
EXEC PrintService.spGetPurchaseLogByCondition @StartDate = '2024-01-01', @EndDate = '2024-12-31', @Status = 'Failed';

-- 6. Filter by date range, status, and CustomerId
EXEC PrintService.spGetPurchaseLogByCondition @StartDate = '2024-12-01', @EndDate = '2024-12-31', @Status = 'Success', @CustomerId = 'C002';