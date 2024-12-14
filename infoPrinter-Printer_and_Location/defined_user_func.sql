-- User-Defined Function: Calculate Total Documents Uploaded by a Customer
USE PrintingServices;
GO

CREATE OR ALTER FUNCTION InfoPrinter.GetPrinterCountByLocation (@LocationId INT)
RETURNS INT
AS
BEGIN
    DECLARE @PrinterCount INT;
    SELECT @PrinterCount = COUNT(*) FROM InfoPrinter.Printer WHERE LocationId = @LocationId;
    RETURN @PrinterCount;
END;
GO