USE PrintingServices;
GO

CREATE TRIGGER trInsertPurchaseLog
ON PrintService.PurchaseLog
AFTER INSERT
AS
BEGIN
    -- Update CurrentPage for all affected customers
    UPDATE InfoUser.Customer
    SET CurrentPage = CurrentPage + ISNULL(agg.TotalPages, 0)
    FROM InfoUser.Customer
    INNER JOIN (
        SELECT CustomerId, SUM(NumberOfPage) AS TotalPages
        FROM inserted
        WHERE PurchaseStatus = 'Success'
        GROUP BY CustomerId
    ) agg ON InfoUser.Customer.Id = agg.CustomerId;
END;
GO

-- Disable the trigger first
DISABLE TRIGGER PrintService.trInsertPurchaseLog ON PrintService.PurchaseLog;
GO

-- Drop the trigger
DROP TRIGGER PrintService.trInsertPurchaseLog;
GO