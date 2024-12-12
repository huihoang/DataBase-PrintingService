USE PrintingServices;
GO



-- Tạo view cho Report
CREATE OR ALTER VIEW SystemService.GetAllReport 
AS
SELECT * FROM SystemService.Report;
GO

-- Sử dụng view GetAllReport
SELECT * FROM SystemService.GetAllReport;
DROP VIEW SystemService.GetAllReport;
GO



-- END