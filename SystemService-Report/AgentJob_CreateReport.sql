--File này để chạy lệnh trong Step của SQL Server Agent

DECLARE @info VARBINARY(128);

SET @info = 0x55555555; -- Giá trị đại diện cho SQL Server Agent

-- Thiết lập `CONTEXT_INFO` cho session hiện tại
SET CONTEXT_INFO @info;

-- Tạo lệnh insert giả để bật trigger
INSERT INTO SystemService.Report (Title) VALUES('Start Trigger to Create Report');