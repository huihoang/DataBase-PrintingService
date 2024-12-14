USE PrintingServices;
GO



-- Xử lý yêu cầu in thành 1 record mới trong lịch sử (mặc định lúc đầu sẽ đang xử lý in) 
CREATE OR ALTER PROCEDURE PrintService.spRequestPrint (
	@PrintSideType NVARCHAR(50),
    @NumOfCopy INT,
    @PageSize VARCHAR(50),
    @CustomerId VARCHAR(50),
    @PrinterId INT
	)
AS
	DECLARE @TotalPage INT;

	SELECT @TotalPage = SUM(NumOfPage)
	FROM PrintService.Document
	WHERE PrintLogId IS NULL AND CustomerId=@CustomerId;

	IF @TotalPage IS NULL
	BEGIN 
		RAISERROR('Not have file upload yet, Please Upload File!', 16, 1);
		RETURN;
	END
	SET @TotalPage = @TotalPage * @NumOfCopy;

	INSERT INTO PrintService.PrintServiceLog (StartTime, [Status], PrintSideType, NumOfCopy, PageSize, TotalPage, CustomerId, PrinterId)
	VALUES (GETDATE(), 'Pending', @PrintSideType, @NumOfCopy, @PageSize, @TotalPage, @CustomerId, @PrinterId);

	UPDATE PrintService.Document
	SET PrintLogId = SCOPE_IDENTITY()
	WHERE PrintLogId IS NULL AND CustomerId = @CustomerId;
GO

-- ! Nhớ Upload file truoc khi gui yeu cau in
EXECUTE PrintService.spRequestPrint 'One-Sided', 1, 'A4', 'C002', 1; 
DROP PROCEDURE PrintService.spRequestPrint;
GO

-- Máy in gửi phản hồi lần in đó thành công hoặc thất bại
CREATE OR ALTER PROCEDURE PrintService.spUpdateStatus (
	@Status NVARCHAR(50),
    @CustomerId VARCHAR(50),
    @PrinterId INT
	)
AS
	IF @Status = 'Failed' OR @Status = 'Completed'
	BEGIN
		UPDATE PrintService.PrintServiceLog  
		SET	[Status] = @Status
		WHERE CustomerId = @CustomerId AND PrinterId = @PrinterId AND [Status] = 'Pending';
	END
	ELSE 
	BEGIN
		RAISERROR('Cập nhật kiểu trạng thái không hợp lệ!', 16, 1);
	END
GO

-- thực thi ví dụ
EXECUTE PrintService.spUpdateStatus 'Failed', 'C002', 2;
DROP PROCEDURE PrintService.spUpdateStatus;
GO



--END