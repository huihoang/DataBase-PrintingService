USE PrintingServices;
GO



-- Tạo report hàng tháng (tháng trước) tạm bỏ SProcedure vì trigger không cho gọi tới
-- CREATE OR ALTER PROCEDURE SystemService.CreateReport

-- Chặn insert report, chỉ cho sql-server agent insert
CREATE OR ALTER TRIGGER SystemService.DenyInsertReport
ON SystemService.Report
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @context_info VARBINARY(128); 
	SET @context_info = CONTEXT_INFO(); -- Kiểm tra nếu `CONTEXT_INFO` không phải là của SQL Server Agent 
	IF @context_info != 0x55555555 -- Giá trị đại diện cho SQL Server Agent 
	BEGIN 
		RAISERROR('Không được phép thay đổi dữ liệu bảng Report.', 16, 1); 
		RETURN;
	END
	ELSE
	BEGIN
		DECLARE @PreviousMonthYear VARCHAR(7) = FORMAT(DATEADD(MONTH, -1, GETDATE()), 'MM/yyyy');

		DECLARE @totalPrintError INT;
		SELECT @totalPrintError = COUNT(*)
		FROM PrintService.PrintServiceLog
		WHERE [Status]='Failed' 
			AND YEAR(StartTime) = SUBSTRING(@PreviousMonthYear, CHARINDEX('/', @PreviousMonthYear) + 1, 4)
			AND MONTH(StartTime) = SUBSTRING(@PreviousMonthYear, 1, 2); 
	
		DECLARE @TotalPrintSuccess INT;
		SELECT @TotalPrintSuccess = COUNT(*)
		FROM PrintService.PrintServiceLog
		WHERE [Status]='Completed'
			AND YEAR(StartTime) = SUBSTRING(@PreviousMonthYear, CHARINDEX('/', @PreviousMonthYear) + 1, 4)
			AND MONTH(StartTime) = SUBSTRING(@PreviousMonthYear, 1, 2);

		DECLARE @totalPage INT;
		SELECT @totalPage=SUM(TotalPage)
		FROM PrintService.PrintServiceLog
		WHERE YEAR(StartTime) = SUBSTRING(@PreviousMonthYear, CHARINDEX('/', @PreviousMonthYear) + 1, 4)
			AND MONTH(StartTime) = SUBSTRING(@PreviousMonthYear, 1, 2);

		IF @totalPage IS NULL 
		BEGIN 
			SET @totalPage = 0;
		END

		INSERT INTO SystemService.Report (Title, CreatedAt, TotalPrintingError, TotalPrintingSuccess, TotalPagesConsumed)
		VALUES ('Monthly Report - '+@PreviousMonthYear, GETDATE(), @totalPrintError, @TotalPrintSuccess, @totalPage);
		END
END;
GO

DROP TRIGGER SystemService.DenyInsertReport;
GO

-- Chặn delete, update report
CREATE OR ALTER TRIGGER SystemService.DenyDelAndUpdateReport
ON SystemService.Report
INSTEAD OF DELETE, UPDATE
AS 
BEGIN
	BEGIN 
		RAISERROR('Không được phép thay đổi dữ liệu bảng Report.', 16, 1); 
		RETURN;	
	END
END;
GO

DROP TRIGGER SystemService.DenyDelAndUpdateReport;
GO



--END