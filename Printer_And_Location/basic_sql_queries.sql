
USE PrintingServices;
GO
-- Truy vấn 1: Lấy danh sách tất cả các máy in
SELECT *
FROM InfoPrinter.Printer;

-- Truy vấn 2: Lấy danh sách máy in và thông tin vị trí
SELECT p.Id AS PrinterId, p.BrandName, p.Status, pl.RoomName, pl.BuildingName, pl.CampusName
FROM InfoPrinter.Printer AS p, InfoPrinter.PrinterLocation AS pl
WHERE p.LocationId = pl.Id;

-- Truy vấn 3: Lấy danh sách các máy in hoạt động (Active)
SELECT *
FROM InfoPrinter.Printer
WHERE Status = 'Active';

-- Truy vấn 4: Tìm máy in tại một phòng cụ thể
SELECT p.BrandName, pl.RoomName, pl.BuildingName, pl.CampusName
FROM InfoPrinter.Printer AS p, InfoPrinter.PrinterLocation pl
WHERE p.LocationId = pl.Id AND pl.RoomName = 'Room 102';
-- Truy vấn 5: Đếm số lượng máy in tại mỗi tòa nhà
SELECT pl.BuildingName, COUNT(p.Id) AS TotalPrinters
FROM InfoPrinter.Printer AS p, InfoPrinter.PrinterLocation AS pl
WHERE p.LocationId = pl.Id
GROUP BY pl.BuildingName;

-- Truy vấn 6: Danh sách các máy in theo thứ tự tên thương hiệu (BrandName) tăng dần
SELECT *
FROM InfoPrinter.Printer
ORDER BY BrandName ASC;

-- Truy vấn 7: Lấy thông tin máy in theo Campus
SELECT pl.CampusName, COUNT(p.Id) AS TotalPrinters
FROM InfoPrinter.Printer AS p, InfoPrinter.PrinterLocation AS pl
WHERE p.LocationId = pl.Id
GROUP BY pl.CampusName;

-- Truy vấn 8: Cập nhật trạng thái của máy in (Inactive thành Active)
UPDATE InfoPrinter.Printer
SET Status = 'Active'
WHERE Id = 2;

-- Truy vấn 9: Xóa máy in không hoạt động (Inactive)
DELETE FROM InfoPrinter.Printer
WHERE Status = 'Inactive';

-- Truy vấn 10: Lấy danh sách các máy in và số lượng tại mỗi vị trí
SELECT pl.RoomName, pl.BuildingName, COUNT(p.Id) AS TotalPrinters
FROM InfoPrinter.PrinterLocation AS pl
LEFT JOIN InfoPrinter.Printer AS p ON pl.Id = p.LocationId
GROUP BY pl.RoomName, pl.BuildingName;