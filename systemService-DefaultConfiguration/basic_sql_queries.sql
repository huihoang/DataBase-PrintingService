USE PrintingServices;
GO



-- Xem thông tin default config currently
SELECT TOP 1 *
FROM SystemService.DefaultConfiguration 
ORDER BY ABS(DATEDIFF(DAY, DefaultGivenDate, GETDATE()));

-- Xem lịch sử default config
SELECT * FROM SystemService.vwGetAllDefaultConfig;

-- insert new default config
INSERT INTO SystemService.DefaultConfiguration (Id, DefaultPage, DefaultGivenDate, PermittedFileTypes, CreatedAt, SPSOId);
VALUES ('DC007', 447, '2024-05-17', 'PDF, DOCX', GETDATE(), 'S001');

-- update default config
UPDATE SystemService.DefaultConfiguration
SET DefaultPage = 447, DefaultGivenDate = '2024-05-17', PermittedFileTypes = 'PDF, DOCX', CreatedAt = GETDATE(), SPSOId = 'S001'
WHERE Id = 'DC007';

-- delete default config
DELETE FROM SystemService.DefaultConfiguration
WHERE Id = 'DC007';


--END