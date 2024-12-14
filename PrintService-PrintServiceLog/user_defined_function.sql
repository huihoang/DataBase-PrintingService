USE PrintingServices;
GO



-- Tạo hàm trả về tất cả lịch sử in của 1 khách hàng bằng ID
CREATE OR ALTER FUNCTION PrintService.fnGetOnePrintingLogById (
	@CutomerId VARCHAR(50)
	)
RETURNS @return TABLE (
    IdLog INT,
    StartTime DATETIME,
    [StatusPrint] NVARCHAR(50) CHECK ([StatusPrint] IN ('Pending', 'Completed', 'Failed')),
    PrintSideType NVARCHAR(50) CHECK (PrintSideType IN ('One-Sided', 'Two-Sided')),
    NumOfCopy INT,
    PageSize VARCHAR(50),
    TotalPage INT,
    CustomerId VARCHAR(50),
    PrinterId INT,

	Email VARCHAR(255),
	FamilyName VARCHAR(100),
    GivenName VARCHAR(100),
	StudentCode VARCHAR(50), 

	BrandName VARCHAR(100),
    [StatusPrinter] NVARCHAR(50) CHECK ([StatusPrinter] IN ('Active', 'Inactive')),

    RoomName VARCHAR(100),
    BuildingName VARCHAR(100),
    CampusName VARCHAR(100),

	[FileName] VARCHAR(255)
	)
AS
BEGIN
	INSERT INTO @return	
	SELECT PSL.*, C.Email, C.FamilyName, C.GivenName, C.StudentCode, P.BrandName, P.Status, PL.RoomName, PL.BuildingName, PL.CampusName, D.FileName
	FROM PrintService.PrintServiceLog PSL, InfoUser.Customer C, InfoPrinter.Printer P, InfoPrinter.PrinterLocation PL, PrintService.Document D
	WHERE PSL.CustomerId=@CutomerId AND PSL.CustomerId=C.Id AND PSL.PrinterId=P.Id AND P.LocationId=PL.Id AND D.PrintLogId=PSL.Id
	RETURN;
END;
GO

-- sử dụng hàm get lịch sử in của 1 khách hàng băng ID
EXECUTE PrintService.fnGetOnePrintingLogById 'C005';
DROP FUNCTION  PrintService.fnGetOnePrintingLogById;
GO

-- Tạo hàm trả về lịch sử in của 1 sinh viên bằng Tên, Mail, StudentCode
CREATE OR ALTER FUNCTION PrintService.fnFilterPrintingLog (
	@CutomerName VARCHAR(100),
	@StudentCode VARCHAR(50),    
	@Email VARCHAR(255)
	)
RETURNS @return TABLE (
    IdLog INT,
    StartTime DATETIME,
    [StatusPrint] NVARCHAR(50) CHECK ([StatusPrint] IN ('Pending', 'Completed', 'Failed')),
    PrintSideType NVARCHAR(50) CHECK (PrintSideType IN ('One-Sided', 'Two-Sided')),
    NumOfCopy INT,
    PageSize VARCHAR(50),
    TotalPage INT,
    CustomerId VARCHAR(50),
    PrinterId INT,

	Email VARCHAR(255),
	FamilyName VARCHAR(100),
    GivenName VARCHAR(100),
	StudentCode VARCHAR(50), 

	BrandName VARCHAR(100),
    [StatusPrinter] NVARCHAR(50) CHECK ([StatusPrinter] IN ('Active', 'Inactive')),

    RoomName VARCHAR(100),
    BuildingName VARCHAR(100),
    CampusName VARCHAR(100),

	[FileName] VARCHAR(255)
	)
AS
BEGIN
	INSERT INTO @return	
	SELECT PSL.*, C.Email, C.FamilyName, C.GivenName, C.StudentCode, P.BrandName, P.Status, PL.RoomName, PL.BuildingName, PL.CampusName, D.FileName
	FROM PrintService.PrintServiceLog PSL, InfoUser.Customer C, InfoPrinter.Printer P, InfoPrinter.PrinterLocation PL, PrintService.Document D
	WHERE (C.FamilyName LIKE '%'+@CutomerName+'%' OR C.GivenName LIKE '%'+@CutomerName+'%') 
		AND (C.StudentCode LIKE '%'+@StudentCode+'%')
		AND (C.Email LIKE '%'+@Email+'%')
		AND PSL.CustomerId=C.Id AND PSL.PrinterId=P.Id AND P.LocationId=PL.Id AND D.PrintLogId=PSL.Id
	RETURN;
END;
GO	

-- sử dụng hàm get lịch sử in của 1 sinh viên bằng Tên hoặc Mail hoặc StudentCode
EXECUTE PrintService.fnFilterPrintingLog 'customer3', '', '';
EXECUTE PrintService.fnFilterPrintingLog '', 'nguyen', '';
EXECUTE PrintService.fnFilterPrintingLog '', '', 'ST005';
DROP FUNCTION  PrintService.fnFilterPrintingLog;
GO



--END