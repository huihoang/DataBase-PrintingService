USE PrintingServices;
GO



-- Tao view PrintingLog
CREATE VIEW PrintService.GetAllPrintingLog 
AS
SELECT * FROM PrintService.PrintServiceLog;
GO

DROP VIEW PrintService.GetAllPrintingLog;
GO



--END