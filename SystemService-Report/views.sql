USE PrintingServices;
GO



-- Tạo view cho Report
CREATE OR ALTER VIEW SystemService.vwGetAllReport 
AS
SELECT * FROM SystemService.Report;
GO

-- Sử dụng view GetAllReport
SELECT * FROM SystemService.vwGetAllReport;
DROP VIEW SystemService.vwGetAllReport;
GO



-- END