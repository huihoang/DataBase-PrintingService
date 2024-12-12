USE PrintingServices;
GO



-- Tạo view DefaultConfig
CREATE VIEW SystemService.GetAllDefaultConfig
AS
SELECT * FROM SystemService.DefaultConfiguration;
GO

-- Xoá view DefaultConfig
DROP VIEW SystemService.GetAllDefaultConfig;
GO



--END