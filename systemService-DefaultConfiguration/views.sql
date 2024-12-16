USE PrintingServices;
GO



-- Tạo view DefaultConfig
CREATE OR ALTER VIEW SystemService.vwGetAllDefaultConfig
AS
SELECT * FROM SystemService.DefaultConfiguration;
GO

-- Xoá view DefaultConfig
DROP VIEW SystemService.vwGetAllDefaultConfig;
GO



--END