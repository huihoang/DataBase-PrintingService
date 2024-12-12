USE PrintingServices;
GO



-- tạo hàm filter report xem 1 tháng cụ thể
CREATE OR ALTER FUNCTION SystemService.FilterReportByMonth
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
SELECT * FROM  SystemService.FilterReportByMonth('12/2024');
DROP FUNCTION SystemService.FilterReportByMonth;
GO

-- tạo hàm filter report xem 1 tháng cụ thể
CREATE OR ALTER FUNCTION SystemService.FilterReportByYear
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
SELECT * FROM  SystemService.FilterReportByYear('2024');
DROP FUNCTION SystemService.FilterReportByYear;
GO



--END