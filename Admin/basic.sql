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