
USE PrintingServices;
GO

-- View to Get All Printers with Location
CREATE OR ALTER VIEW vwPrinterWithLocation AS
SELECT P.Id AS PrinterId, P.BrandName, P.Status, L.RoomName, L.BuildingName, L.CampusName
FROM InfoPrinter.Printer P, InfoPrinter.PrinterLocation L
WHERE P.LocationId = L.Id;
GO

-- View to Get All Active Printers
CREATE OR ALTER VIEW vwActivePrinters AS
SELECT P.Id AS PrinterId, P.BrandName, P.Status, L.RoomName, L.BuildingName, L.CampusName
FROM InfoPrinter.Printer P, InfoPrinter.PrinterLocation L
WHERE P.LocationId = L.Id AND P.Status = 'Active';
GO

-- View to Get Printer Count by Location
CREATE OR ALTER VIEW vwPrinterCountByLocation AS
SELECT L.RoomName, L.BuildingName, L.CampusName, COUNT(P.Id) AS PrinterCount
FROM InfoPrinter.Printer P, InfoPrinter.PrinterLocation L
WHERE P.LocationId = L.Id
GROUP BY L.RoomName, L.BuildingName, L.CampusName;
GO

-- View to Get Printer Status Summary
CREATE OR ALTER VIEW vwPrinterStatusSummary AS
SELECT P.Status, COUNT(P.Id) AS PrinterCount
FROM InfoPrinter.Printer P
GROUP BY P.Status;
GO

-- View to Get All Printers with Location and Status
CREATE OR ALTER VIEW vwPrintersWithLocationAndStatus AS
SELECT P.Id AS PrinterId, P.BrandName, P.Status, L.RoomName, L.BuildingName, L.CampusName
FROM InfoPrinter.Printer P, InfoPrinter.PrinterLocation L
WHERE P.LocationId = L.Id;
GO



-- Test for View: vwPrinterWithLocation
SELECT * FROM vwPrinterWithLocation;

-- Test for View: vwActivePrinters
SELECT * FROM vwActivePrinters;

-- Test for View: vwPrinterCountByLocation
SELECT * FROM vwPrinterCountByLocation;

-- Test for View: vwPrinterStatusSummary
SELECT * FROM vwPrinterStatusSummary;

-- Test for View: vwPrintersWithLocationAndStatus
SELECT * FROM vwPrintersWithLocationAndStatus;

