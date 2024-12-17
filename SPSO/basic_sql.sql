

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

