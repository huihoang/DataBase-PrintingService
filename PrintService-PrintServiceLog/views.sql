USE PrintingServices;
GO



-- Tao view PrintingLog
CREATE VIEW PrintService.vwGetAllPrintingLog 
AS
SELECT * FROM PrintService.PrintServiceLog;
GO

DROP VIEW PrintService.vwGetAllPrintingLog;
GO



--END