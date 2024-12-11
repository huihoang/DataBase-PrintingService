-- User-Defined Function: Calculate Success Rate of Transactions by a Customer
USE PrintingServices;
GO

CREATE OR ALTER FUNCTION PrintService.fnGetSuccessRateByCustomer (
    @CustomerId NVARCHAR(50)
)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @TotalTransactions INT;
    DECLARE @SuccessfulTransactions INT;
    DECLARE @SuccessRate DECIMAL(5, 2);

    -- Calculate total transactions for the customer
    SELECT @TotalTransactions = COUNT(*)
    FROM PrintService.PurchaseLog
    WHERE CustomerId = @CustomerId;

    -- Calculate successful transactions for the customer
    SELECT @SuccessfulTransactions = COUNT(*)
    FROM PrintService.PurchaseLog
    WHERE CustomerId = @CustomerId AND PurchaseStatus = 'Success';

    -- Calculate success rate
    IF @TotalTransactions = 0
        SET @SuccessRate = 0;
    ELSE
        SET @SuccessRate = (@SuccessfulTransactions * 100.0) / @TotalTransactions;

    RETURN @SuccessRate;
END;

-- Test the function
SELECT PrintService.fnGetSuccessRateByCustomer('C001') AS SuccessRate;


-- User-Defined Function: Calculate Total Amount Spent by a Customer (Successful Transactions Only)
USE PrintingServices;
GO

CREATE OR ALTER FUNCTION PrintService.fnGetTotalAmountSpentByCustomer (
    @CustomerId NVARCHAR(50)
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @TotalAmount FLOAT;
    SELECT @TotalAmount = SUM(Price)
    FROM PrintService.PurchaseLog
    WHERE CustomerId = @CustomerId AND PurchaseStatus = 'Success';
    RETURN ISNULL(@TotalAmount, 0);
END;

-- Test the function
SELECT PrintService.fnGetTotalAmountSpentByCustomer('C001') AS TotalAmountSpent;