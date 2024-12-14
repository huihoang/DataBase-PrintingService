USE PrintingServices;
GO



-- Tạo view DefaultConfig
CREATE VIEW SystemService.vwGetAllDefaultConfig
AS
SELECT * FROM SystemService.vwDefaultConfiguration;
GO

-- Xoá view DefaultConfig
DROP VIEW SystemService.vwGetAllDefaultConfig;
GO



--END