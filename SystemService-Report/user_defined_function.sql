USE PrintingServices;
GO



-- tạo hàm filter report xem 1 tháng cụ thể
CREATE OR ALTER FUNCTION SystemService.fnFilterReportByMonth
(
    @MonthYear VARCHAR(7)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM SystemService.Report
    WHERE FORMAT(CreatedAt, 'MM/yyyy') = @MonthYear
)
GO

-- sử dụng hàm filter report xem 1 tháng cụ thể
SELECT * FROM  SystemService.fnFilterReportByMonth('12/2024');
DROP FUNCTION SystemService.fnFilterReportByMonth;
GO

-- tạo hàm filter report xem 1 tháng cụ thể
CREATE OR ALTER FUNCTION SystemService.fnFilterReportByYear
(
    @MonthYear VARCHAR(7)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM SystemService.Report
    WHERE FORMAT(CreatedAt, 'yyyy') = @MonthYear
)
GO

-- sử dụng hàm filter report xem 1 năm cụ thể
SELECT * FROM  SystemService.fnFilterReportByYear('2024');
DROP FUNCTION SystemService.fnFilterReportByYear;
GO



--END