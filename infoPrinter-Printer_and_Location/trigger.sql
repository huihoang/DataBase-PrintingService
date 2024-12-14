
USE PrintingServices;
GO


---Cập Nhật Trạng Thái Máy In Khi Vị Trí Thay Đổi---
CREATE OR ALTER TRIGGER trUpdatePrinterStatusOnLocationChange
ON InfoPrinter.PrinterLocation
AFTER UPDATE
AS
BEGIN
    DECLARE @OldLocationId INT;
    DECLARE @NewLocationId INT;

    -- Lặp qua tất cả các bản ghi trong INSERTED
    DECLARE cursor_location CURSOR FOR
    SELECT Id FROM INSERTED;

    OPEN cursor_location;
    FETCH NEXT FROM cursor_location INTO @NewLocationId;

    -- Lặp qua tất cả các bản ghi trong INSERTED
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Cập nhật trạng thái máy in cho vị trí cũ thành 'Moved'
        UPDATE InfoPrinter.Printer
        SET Status = 'Moved'
        WHERE LocationId = @NewLocationId;
        -- Lấy bản ghi tiếp theo
        FETCH NEXT FROM cursor_location INTO @NewLocationId;
    END

    -- Đóng và giải phóng con trỏ
    CLOSE cursor_location;
    DEALLOCATE cursor_location;
END;
GO


-- Test trigger the location change
UPDATE InfoPrinter.PrinterLocation
SET RoomName = 'Room 500' 
WHERE Id = 1;

EXEC GetAllPrinterLocations;
EXEC GetPrinterLocationById @Id = 1;
SELECT * FROM InfoPrinter.Printer WHERE LocationId = 1;


