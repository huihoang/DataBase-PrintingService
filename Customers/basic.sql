-- CRUD cho Customer
-- ==================================================Tạo Customers============================================================
INSERT INTO InfoUser.Customer (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, StudentCode, CurrentPage)
VALUES 
('C006', '0134561111', 'customer6@example.com', 'password123', '2024-12-06', 'Tran', 'Hoa', 'Customer', 'ST006', 600),
('C007', '0134562222', 'customer7@example.com', 'password123', '2024-12-07', 'Nguyen', 'Phong', 'Customer', 'ST007', 700),
('C008', '0134563333', 'customer8@example.com', 'password123', '2024-12-08', 'Le', 'Khanh', 'Customer', 'ST008', 800),
('C009', '0134564444', 'customer9@example.com', 'password123', '2024-12-09', 'Pham', 'Hieu', 'Customer', 'ST009', 900),
('C010', '0134565555', 'customer10@example.com', 'password123', '2024-12-10', 'Do', 'Linh', 'Customer', 'ST010', 1000),
('C011', '0134566666', 'customer11@example.com', 'password123', '2024-12-11', 'Nguyen', 'Ha', 'Customer', 'ST011', 1100);
-- ==================================================Truy vấn Customers=============================================================
SELECT * FROM InfoUser.Customer WHERE Id IN ('C001', 'C002', 'C003', 'C004', 'C005', 'C006', 'C007', 'C008', 'C009', 'C010');
--Lấy danh sách các khách hàng kèm số trang hiện tại
SELECT Id, FamilyName, GivenName, Email, CurrentPage FROM InfoUser.Customer;
-- Truy vấn lấy thông tin khách hàng đã thực hiện giao dịch thành công --
SELECT C.Id, C.GivenName, C.FamilyName, P.NumberOfPage, P.Price, P.PurchaseStatus
FROM InfoUser.Customer C
JOIN PrintService.PurchaseLog P ON C.Id = P.CustomerId
WHERE P.PurchaseStatus = 'Success';
--Truy vấn lấy thông tin dịch vụ in ấn cho một khách hàng cụ thể-- 
SELECT PSL.StartTime, PSL.Status, PSL.PrintSideType, PSL.NumOfCopy, PSL.TotalPage, P.BrandName
FROM PrintService.PrintServiceLog PSL
JOIN InfoPrinter.Printer P ON PSL.PrinterId = P.Id
WHERE PSL.CustomerId = 'C001';
--Truy vấn tính tổng số trang đã in của một khách hàng--
SELECT SUM(PSL.TotalPage) AS TotalPagesPrinted
FROM PrintService.PrintServiceLog PSL
WHERE PSL.CustomerId = 'C001';
--Lấy thông tin từ bảng SPSO và Admin bằng cách nối hai bảng qua cột ManagedBy và Id của Admin
SELECT SPSO.Id, SPSO.GivenName, Admin.Role
FROM InfoUser.SPSO
LEFT JOIN InfoUser.Admin ON SPSO.ManagedBy = Admin.Id;