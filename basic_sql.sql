-- CRUD cho Admin
-- Tạo Admins
INSERT INTO InfoUser.[Admin] (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, Ssn)
VALUES 
('A006', '0345566778', 'admin6@example.com', 'password123', '2024-12-06', 'Nguyen', 'Lan', 'Admin', '444555666'),
('A007', '0456677889', 'admin7@example.com', 'password123', '2024-12-07', 'Tran', 'Binh', 'Admin', '555666777'),
('A008', '0567788990', 'admin8@example.com', 'password123', '2024-12-08', 'Pham', 'Ha', 'Admin', '666777888'),
('A009', '0678899001', 'admin9@example.com', 'password123', '2024-12-09', 'Le', 'Phuong', 'Admin', '777888999'),
('A010', '0789900012', 'admin10@example.com', 'password123', '2024-12-10', 'Hoang', 'Anh', 'Admin', '888999000'),
('A011', '0890011123', 'admin11@example.com', 'password123', '2024-12-11', 'Vu', 'Dung', 'Admin', '999000111'),
('A012', '0901122234', 'admin12@example.com', 'password123', '2024-12-12', 'Ngo', 'Hung', 'Admin', '000111222'),
('A013', '0912233345', 'admin13@example.com', 'password123', '2024-12-13', 'Do', 'Minh', 'Admin', '111222444'),
('A014', '0923344456', 'admin14@example.com', 'password123', '2024-12-14', 'Bui', 'Quang', 'Admin', '222333555'),
('A015', '0934455567', 'admin15@example.com', 'password123', '2024-12-15', 'Nguyen', 'Thanh', 'Admin', '333444666');

-- =====================================Truy Vấn Admins========================================================================
SELECT * FROM InfoUser.[Admin] WHERE Id IN ('A001', 'A002', 'A003', 'A004', 'A005', 'A006', 'A007', 'A008', 'A009', 'A010');
--Lọc Admin có vai trò là 'Admin'
SELECT * FROM InfoUser.[Admin]
WHERE Role = 'Admin';
--Lọc Admin đăng nhập lần cuối trước ngày 2024-12-10
SELECT * FROM InfoUser.[Admin]
WHERE LastLogin < '2024-12-10';
-- Truy vấn lấy dữ liệu từ bảng Admin chỉ những admin có Role = 'Admin' và PhoneNumber bắt đầu bằng "03"
SELECT * 
FROM InfoUser.Admin
WHERE Role = 'Admin' 
AND PhoneNumber LIKE '03%';
-- GROUP BY với HAVING
SELECT Role, SUM(Salary) AS TotalSalary
FROM InfoUser.SPSO
GROUP BY Role
HAVING SUM(Salary) > 10000;
--Truy vấn lấy thông tin của các admin và sắp xếp theo LastLogin từ mới đến cũ
SELECT Id, Email, LastLogin
FROM InfoUser.Admin
ORDER BY LastLogin DESC;
--Đếm số lượng admin có role là 'Admin'
SELECT COUNT(*) AS TotalAdmins
FROM InfoUser.Admin
WHERE Role = 'Admin';
--Lọc các admin có LastLogin trong khoảng thời gian từ '2024-01-01' đến '2024-12-31'
SELECT Id, Email, LastLogin
FROM InfoUser.Admin
WHERE LastLogin BETWEEN '2024-01-01' AND '2024-12-31';
--======================================== Cập nhật Admins ============================================================================
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887771' WHERE Id = 'A001';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887772' WHERE Id = 'A002';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887773' WHERE Id = 'A003';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887774' WHERE Id = 'A004';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887775' WHERE Id = 'A005';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887776' WHERE Id = 'A006';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887777' WHERE Id = 'A007';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887778' WHERE Id = 'A008';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887779' WHERE Id = 'A009';
UPDATE InfoUser.[Admin] SET PhoneNumber = '0998887780' WHERE Id = 'A010';

-- ==========================================Xóa Admins=============================================================================
DELETE FROM InfoUser.[Admin] WHERE Id = 'A006';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A007';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A008';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A009';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A010';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A011';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A012';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A013';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A014';
DELETE FROM InfoUser.[Admin] WHERE Id = 'A015';

-- CRUD cho SPSO
-- ================================================Tạo SPSOs==================================================================================
INSERT INTO InfoUser.SPSO (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, Ssn, Salary, ManagedBy)
VALUES 
('S006', '0123451111', 'spso6@example.com', 'password123', '2024-12-06', 'Tran', 'Minh', 'SPSO', '123456111', 10000, 'A001'),
('S007', '0123452222', 'spso7@example.com', 'password123', '2024-12-07', 'Nguyen', 'Phuc', 'SPSO', '123456222', 11000, 'A002'),
('S008', '0123453333', 'spso8@example.com', 'password123', '2024-12-08', 'Le', 'Quynh', 'SPSO', '123456333', 12000, 'A003'),
('S009', '0123454444', 'spso9@example.com', 'password123', '2024-12-09', 'Pham', 'An', 'SPSO', '123456444', 13000, 'A004'),
('S010', '0123455555', 'spso10@example.com', 'password123', '2024-12-10', 'Do', 'Hai', 'SPSO', '123456555', 14000, 'A005'),
('S011', '0123456666', 'spso11@example.com', 'password123', '2024-12-11', 'Bui', 'Linh', 'SPSO', '123456666', 15000, 'A001'),
('S012', '0123457777', 'spso12@example.com', 'password123', '2024-12-12', 'Ngo', 'Nghia', 'SPSO', '123456777', 16000, 'A002'),
('S013', '0123458888', 'spso13@example.com', 'password123', '2024-12-13', 'Vu', 'Duc', 'SPSO', '123456888', 17000, 'A003'),
('S014', '0123459999', 'spso14@example.com', 'password123', '2024-12-14', 'Doan', 'Vu', 'SPSO', '123456999', 18000, 'A004'),
('S015', '0123460000', 'spso15@example.com', 'password123', '2024-12-15', 'Ngo', 'Khoa', 'SPSO', '123457000', 19000, 'A005');

-- ==================================================Truy vấn SPSOs==============================================================================
SELECT * FROM InfoUser.SPSO WHERE Id IN ('S001', 'S002', 'S003', 'S004', 'S005', 'S006', 'S007', 'S008', 'S009', 'S010');
--Lấy danh sách tất cả SPSOs kèm theo thông tin Admin quản lý:
SELECT SPSO.Id, SPSO.FamilyName, SPSO.GivenName, SPSO.Email, Admin.FamilyName AS AdminFamilyName, Admin.GivenName AS AdminGivenName
FROM InfoUser.SPSO SPSO
JOIN InfoUser.[Admin] Admin ON SPSO.ManagedBy = Admin.Id;
--Truy vấn lương trung bình
SELECT AVG(Salary) AS AverageSalary
FROM InfoUser.SPSO;
--Truy vấn lương thấp nhất trong bảng SPSO
SELECT MIN(Salary) AS MinSalary
FROM InfoUser.SPSO;
--Truy vấn lương thấp nhất trong bảng SPSO
SELECT MAX(Salary) AS MaxSalary
FROM InfoUser.SPSO;
--Lọc các SPSO có Role là 'Manager' hoặc 'Supervisor'
SELECT Id, Role, Salary
FROM InfoUser.SPSO
WHERE Role IN ('Manager', 'Supervisor');
--Truy vấn tổng lương của các SPSO theo Role, chỉ hiển thị các nhóm có tổng lương lớn hơn 5000, và sắp xếp theo tổng lương giảm dần
SELECT Role, SUM(Salary) AS TotalSalary
FROM InfoUser.SPSO
GROUP BY Role
HAVING SUM(Salary) > 5000
ORDER BY TotalSalary DESC;
--================================================== Cập nhật SPSOs===================================================================
UPDATE InfoUser.SPSO SET Salary = 10500 WHERE Id = 'S001';
UPDATE InfoUser.SPSO SET Salary = 11500 WHERE Id = 'S002';
UPDATE InfoUser.SPSO SET Salary = 12500 WHERE Id = 'S003';
UPDATE InfoUser.SPSO SET Salary = 13500 WHERE Id = 'S004';
UPDATE InfoUser.SPSO SET Salary = 14500 WHERE Id = 'S005';
UPDATE InfoUser.SPSO SET Salary = 15500 WHERE Id = 'S006';
UPDATE InfoUser.SPSO SET Salary = 16500 WHERE Id = 'S007';
UPDATE InfoUser.SPSO SET Salary = 17500 WHERE Id = 'S008';
UPDATE InfoUser.SPSO SET Salary = 18500 WHERE Id = 'S009';
UPDATE InfoUser.SPSO SET Salary = 19500 WHERE Id = 'S010';

--==================================================== Xóa SPSOs================================================================
DELETE FROM InfoUser.SPSO WHERE Id = 'S006';
DELETE FROM InfoUser.SPSO WHERE Id = 'S007';
DELETE FROM InfoUser.SPSO WHERE Id = 'S008';
DELETE FROM InfoUser.SPSO WHERE Id = 'S009';
DELETE FROM InfoUser.SPSO WHERE Id = 'S010';
DELETE FROM InfoUser.SPSO WHERE Id = 'S011';
DELETE FROM InfoUser.SPSO WHERE Id = 'S012';
DELETE FROM InfoUser.SPSO WHERE Id = 'S013';
DELETE FROM InfoUser.SPSO WHERE Id = 'S014';
DELETE FROM InfoUser.SPSO WHERE Id = 'S015';

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