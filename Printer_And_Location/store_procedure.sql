-- *** CRUD cho schema Printer ***

USE PrintingServices;
GO


---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-------------------------------Printer-------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- 1. CREATE: Thêm một máy in mới vào bảng Printer
CREATE OR ALTER PROCEDURE InfoPrinter.spAddPrinter
    @BrandName VARCHAR(100),
    @Status NVARCHAR(50),
    @LocationId INT
AS
BEGIN
    INSERT INTO InfoPrinter.Printer (BrandName, Status, LocationId)
    VALUES (@BrandName, @Status, @LocationId);
END;
GO

-- 2. READ: Lấy danh sách tất cả các máy in
CREATE OR ALTER PROCEDURE InfoPrinter.spGetAllPrinters
AS
BEGIN
    SELECT * FROM InfoPrinter.Printer;
END;
GO

-- 3. READ: Lấy thông tin máy in theo ID
CREATE OR ALTER PROCEDURE InfoPrinter.spGetPrinterById
    @Id INT
AS
BEGIN
    SELECT *
    FROM InfoPrinter.Printer
    WHERE Id = @Id;
END;
GO

-- 4. UPDATE: Cập nhật thông tin máy in
CREATE OR ALTER PROCEDURE InfoPrinter.spUpdatePrinter
    @Id INT,
    @BrandName VARCHAR(100),
    @Status NVARCHAR(50),
    @LocationId INT
AS
BEGIN
    UPDATE InfoPrinter.Printer
    SET BrandName = @BrandName,
        Status = @Status,
        LocationId = @LocationId
    WHERE Id = @Id;
END;
GO

-- 5. DELETE: Xóa một máy in theo ID
CREATE OR ALTER PROCEDURE InfoPrinter.spDeletePrinter
    @Id INT
AS
BEGIN
    DELETE FROM InfoPrinter.Printer
    WHERE Id = @Id;
END;
GO

-- 6. UPDATE: Cập nhật trạng thái của máy in (Active/Inactive)
CREATE OR ALTER PROCEDURE InfoPrinter.spUpdatePrinterStatus
    @Id INT,
    @Status NVARCHAR(50)
AS
BEGIN
    UPDATE InfoPrinter.Printer
    SET Status = @Status
    WHERE Id = @Id;
END;
GO

-- 7. READ: Lấy danh sách máy in theo trạng thái (Active/Inactive)
CREATE OR ALTER PROCEDURE InfoPrinter.spGetPrintersByStatus
    @Status NVARCHAR(50)
AS
BEGIN
    SELECT * FROM InfoPrinter.Printer
    WHERE Status = @Status;
END;
GO

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------PrinterLocation---------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- 1. CREATE: Thêm một địa điểm máy in mới
CREATE OR ALTER PROCEDURE InfoPrinter.spAddPrinterLocation
    @RoomName VARCHAR(100),
    @BuildingName VARCHAR(100),
    @CampusName VARCHAR(100)
AS
BEGIN
    INSERT INTO InfoPrinter.PrinterLocation (RoomName, BuildingName, CampusName)
    VALUES (@RoomName, @BuildingName, @CampusName);
END;
GO

-- 2. READ: Lấy danh sách tất cả các địa điểm máy in
CREATE OR ALTER PROCEDURE InfoPrinter.spGetAllPrinterLocations
AS
BEGIN
    SELECT * FROM InfoPrinter.PrinterLocation;
END;
GO

-- 3. READ: Lấy thông tin địa điểm máy in theo ID
CREATE OR ALTER PROCEDURE InfoPrinter.spGetPrinterLocationById
    @Id INT
AS
BEGIN
    SELECT *
    FROM InfoPrinter.PrinterLocation
    WHERE Id = @Id;
END;
GO

-- 4. UPDATE: Cập nhật thông tin địa điểm máy in
CREATE OR ALTER PROCEDURE InfoPrinter.spUpdatePrinterLocation
    @Id INT,
    @RoomName VARCHAR(100),
    @BuildingName VARCHAR(100),
    @CampusName VARCHAR(100)
AS
BEGIN
    UPDATE InfoPrinter.PrinterLocation
    SET RoomName = @RoomName,
        BuildingName = @BuildingName,
        CampusName = @CampusName
    WHERE Id = @Id;
END;
GO

-- 5. DELETE: Xóa một địa điểm máy in theo ID
CREATE OR ALTER PROCEDURE InfoPrinter.spDeletePrinterLocation
    @Id INT
AS
BEGIN
    DELETE FROM InfoPrinter.PrinterLocation
    WHERE Id = @Id;
END;
GO

-- 6. READ: Lấy danh sách các địa điểm máy in theo Campus
CREATE OR ALTER PROCEDURE InfoPrinter.spGetPrinterLocationsByCampus
    @CampusName VARCHAR(100)
AS
BEGIN
    SELECT * FROM InfoPrinter.PrinterLocation
    WHERE CampusName = @CampusName;
END;
GO

-- 7. UPDATE: Cập nhật tên tòa nhà (BuildingName) của một địa điểm máy in
CREATE OR ALTER PROCEDURE InfoPrinter.spUpdateBuildingName
    @Id INT,
    @NewBuildingName VARCHAR(100)
AS
BEGIN
    UPDATE InfoPrinter.PrinterLocation
    SET BuildingName = @NewBuildingName
    WHERE Id = @Id;
END;
GO


---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------PrinterLocation And Printer Report and some advanced--------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------

-- 1. CREATE: Thêm một báo cáo mới cho máy in
CREATE OR ALTER PROCEDURE InfoPrinter.AddPrinterReport
    @ReportTitle VARCHAR(255),
    @TotalPrinters INT,
	@TotalPagesConsumed INT,
	@TotalPrintingError INT,
    @Status NVARCHAR(50)
AS
BEGIN
    INSERT INTO SystemService.Report (Title, TotalPrintingError, TotalPrintingSuccess, TotalPagesConsumed)
    VALUES (@ReportTitle, @TotalPrintingError, @TotalPrinters, @TotalPagesConsumed);  
END;
GO

-- 2. READ: Lấy báo cáo cho tất cả các máy in
CREATE OR ALTER PROCEDURE InfoPrinter.GetAllPrinterReports
AS
BEGIN
    SELECT * FROM SystemService.Report;
END;
GO

-- 3. DELETE: Xóa báo cáo theo ID
CREATE OR ALTER PROCEDURE InfoPrinter.DeletePrinterReport
    @ReportId INT
AS
BEGIN
    DELETE FROM SystemService.Report
    WHERE Id = @ReportId;
END;
GO

-- 4. READ: Lấy danh sách máy in theo một phòng cụ thể
CREATE OR ALTER PROCEDURE InfoPrinter.GetPrintersByRoom
    @RoomName VARCHAR(100)
AS
BEGIN
    SELECT p.Id, p.BrandName, p.Status, pl.RoomName, pl.BuildingName, pl.CampusName
    FROM InfoPrinter.Printer AS p
    JOIN InfoPrinter.PrinterLocation AS pl ON p.LocationId = pl.Id
    WHERE pl.RoomName = @RoomName;
END;
GO


-- Test Thêm một máy in mới
EXEC InfoPrinter.AddPrinter 
    @BrandName = 'HP LaserJet 3000', 
    @Status = 'Active', 
    @LocationId = 1;

-- Test Lấy tất cả các máy in
EXEC InfoPrinter.GetAllPrinters;

-- Test Lấy thông tin máy in theo ID
EXEC InfoPrinter.GetPrinterById @Id = 1;

-- Test Cập nhật thông tin máy in
EXEC InfoPrinter.UpdatePrinter 
    @Id = 1, 
    @BrandName = 'HP LaserJet 4500', 
    @Status = 'Inactive', 
    @LocationId = 2;

-- Test Xóa một máy in theo ID
EXEC InfoPrinter.DeletePrinter @Id = 1;

-- Test Cập nhật trạng thái máy in (Active/Inactive)
EXEC InfoPrinter.UpdatePrinterStatus 
    @Id = 2, 
    @Status = 'Active';

-- Test Lấy danh sách máy in theo trạng thái
EXEC InfoPrinter.GetPrintersByStatus @Status = 'Active';


-- Test Thêm một địa điểm máy in mới
EXEC InfoPrinter.AddPrinterLocation 
    @RoomName = 'Room 500', 
    @BuildingName = 'Building A', 
    @CampusName = 'Campus 1';

-- Test Lấy tất cả các địa điểm máy in
EXEC InfoPrinter.GetAllPrinterLocations;

-- Test Lấy thông tin địa điểm máy in theo ID
EXEC InfoPrinter.GetPrinterLocationById @Id = 51;

-- Test Cập nhật thông tin địa điểm máy in
EXEC InfoPrinter.UpdatePrinterLocation 
    @Id = 51, 
    @RoomName = 'Room 2002', 
    @BuildingName = 'Building B', 
    @CampusName = 'Campus 2';

-- Test Xóa một địa điểm máy in theo ID
EXEC InfoPrinter.DeletePrinterLocation @Id = 51;

-- Test Lấy danh sách các địa điểm máy in theo Campus
EXEC InfoPrinter.GetPrinterLocationsByCampus @CampusName = 'Campus 1';

-- Test Cập nhật tên tòa nhà của một địa điểm máy in
EXEC InfoPrinter.UpdateBuildingName 
    @Id = 52, 
    @NewBuildingName = 'Building C';

-- Test Thêm một báo cáo mới cho máy in
EXEC InfoPrinter.AddPrinterReport 
    @ReportTitle = 'Monthly Printer Report', 
    @TotalPrinters = 50, 
	@TotalPagesConsumed = 1000,
	@TotalPrintingError = 10,
    @Status = 'Active';

-- Test Lấy tất cả các báo cáo máy in
EXEC InfoPrinter.GetAllPrinterReports;

-- Test Xóa báo cáo theo ID
EXEC InfoPrinter.DeletePrinterReport @ReportId = 6;

-- Test Lấy danh sách máy in theo phòng
EXEC InfoPrinter.GetPrintersByRoom @RoomName = 'Room 101';
