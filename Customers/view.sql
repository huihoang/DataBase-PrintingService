GO
CREATE VIEW vCustomerPurchaseSummary AS
SELECT C.Id, C.GivenName, C.FamilyName, SUM(P.NumberOfPage) AS TotalPagesPrinted
FROM InfoUser.Customer C
JOIN PrintService.PurchaseLog P ON C.Id = P.CustomerId
GROUP BY C.Id, C.GivenName, C.FamilyName;
GO
SELECT * FROM vCustomerPurchaseSummary;
GO
-- View hiển thị danh sách tất cả người dùng trong hệ thống
CREATE VIEW InfoUser.AllUsers AS
SELECT 
    Id, PhoneNumber, Email, Role, LastLogin
FROM InfoUser.[Admin]
UNION
SELECT 
    Id, PhoneNumber, Email, Role, LastLogin
FROM InfoUser.SPSO
UNION
SELECT 
    Id, PhoneNumber, Email, Role, LastLogin
FROM InfoUser.Customer;
GO