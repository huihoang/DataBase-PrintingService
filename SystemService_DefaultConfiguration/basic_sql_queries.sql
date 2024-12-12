USE PrintingServices;
GO



-- Xem thông tin default config currently
SELECT TOP 1 *
FROM SystemService.DefaultConfiguration 
ORDER BY ABS(DATEDIFF(DAY, DefaultGivenDate, GETDATE()));

-- Xem lịch sử default config
SELECT * FROM SystemService.GetAllDefaultConfig;



--END