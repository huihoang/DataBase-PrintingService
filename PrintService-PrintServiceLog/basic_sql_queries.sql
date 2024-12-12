USE PrintingServices;
GO



-- Xem tat ca lich su in cua tat ca khach hang
SELECT * FROM PrintService.GetAllPrintingLog;


SELECT * FROM PrintService.GetOnePrintingLogById('C005');

SELECT * FROM PrintService.FilterPrintingLog('', '', 'customer3');


SELECT * FROM PrintService.Document;
SELECT * FROM PrintService.PrintServiceLog;

ALTER TABLE PrintService.PrintServiceLog NOCHECK CONSTRAINT ALL;
ALTER TABLE PrintService.PrintServiceLog CHECK CONSTRAINT ConstraintName;

INSERT INTO PrintService.Document (Id, FileName, FileType, PrintLogId, NumOfPage, CustomerId)
VALUES 
('D0111', 'Doc11', 'PDF', NULL, 20, 'C001'),
('D0212', 'Doc11', 'DOCX', NULL, 30, 'C001'),
('D1111', 'Doc11', 'PDF', NULL, 200, 'C002'),
('D2222', 'Doc11', 'DOCX', NULL, 30, 'C002');



--END