-- Tạo CSDL
CREATE DATABASE PrintingServices;
GO

--Xóa CSDL
USE company;
DROP DATABASE PrintingServices;
GO

USE PrintingServices;
GO

--Tạo SCHEMA
CREATE SCHEMA InfoUser;
GO

CREATE SCHEMA InfoPrinter;
GO

CREATE SCHEMA SystemService;
GO

CREATE SCHEMA PrintService;
GO

-- Tạo bảng Admin
CREATE TABLE InfoUser.[Admin] (
    Id VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    LastLogin DATE,
    FamilyName VARCHAR(100),
    GivenName VARCHAR(100),
    Role NVARCHAR(50) CHECK (Role IN ('Customer', 'Admin', 'SPSO')),
    Ssn VARCHAR(12) UNIQUE NOT NULL,
    CONSTRAINT PK_Admin_Id PRIMARY KEY (Id)
);

-- Tạo bảng SPSO
CREATE TABLE InfoUser.SPSO (
    Id VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    LastLogin DATE,
    FamilyName VARCHAR(100),
    GivenName VARCHAR(100),
    Role NVARCHAR(50) CHECK (Role IN ('Customer', 'Admin', 'SPSO')),
    Ssn VARCHAR(12) UNIQUE NOT NULL,
    Salary INT,
    ManagedBy VARCHAR(50),
    CONSTRAINT PK_SPSO_Id PRIMARY KEY (Id),
    CONSTRAINT FK_SPSO_AdminId FOREIGN KEY (ManagedBy) REFERENCES InfoUser.[Admin](Id)
);

-- Tạo bảng Customer
CREATE TABLE InfoUser.Customer (
    Id VARCHAR(50),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    LastLogin DATE,
    FamilyName VARCHAR(100),
    GivenName VARCHAR(100),
    Role NVARCHAR(50) CHECK (Role IN ('Customer', 'Admin', 'SPSO')),
    StudentCode VARCHAR(50),
    CurrentPage INT,
    CONSTRAINT PK_Customer_Id PRIMARY KEY (Id)
);

-- Tạo bảng DefaultConfiguration
CREATE TABLE SystemService.DefaultConfiguration (
    Id VARCHAR(50),
    DefaultPage INT,
    DefaultGivenDate DATE,
    PermittedFileTypes VARCHAR(100),
    CreatedAt DATE DEFAULT GETDATE(),
    SPSOId VARCHAR(50),
    CONSTRAINT PK_DefaultConfiguration_Id PRIMARY KEY (Id),
    CONSTRAINT FK_DefaultConfiguration_SPSOId FOREIGN KEY (SPSOId) REFERENCES InfoUser.SPSO(Id)
);

-- Tạo bảng PurchaseLog
CREATE TABLE PrintService.PurchaseLog (
    Id INT IDENTITY,
    TransactionTime DATE,
    NumberOfPage INT,
    Price DECIMAL(18, 2),
    PurchaseStatus NVARCHAR(50) CHECK (PurchaseStatus IN ('Success', 'Failed')),
    CustomerId VARCHAR(50),
    CONSTRAINT PK_PurchaseLog_Id PRIMARY KEY (Id),
    CONSTRAINT FK_PurchaseLog_CustomerId FOREIGN KEY (CustomerId) REFERENCES InfoUser.Customer(Id)
);

-- Tạo bảng PrinterLocation
CREATE TABLE InfoPrinter.PrinterLocation (
    Id INT IDENTITY,
    RoomName VARCHAR(100),
    BuildingName VARCHAR(100),
    CampusName VARCHAR(100),
    CONSTRAINT PK_PrinterLocation_Id PRIMARY KEY (Id)
);

-- Tạo bảng Printer
CREATE TABLE InfoPrinter.Printer (
    Id INT IDENTITY,
    BrandName VARCHAR(100),
    Status NVARCHAR(50) CHECK (Status IN ('Active', 'Inactive')),
    LocationId INT,
    CONSTRAINT PK_Printer_Id PRIMARY KEY (Id),
    CONSTRAINT FK_Printer_PrinterLocationId FOREIGN KEY (LocationId) REFERENCES InfoPrinter.PrinterLocation(Id)
);

-- Tạo bảng PrintServiceLog
CREATE TABLE PrintService.PrintServiceLog (
    Id INT IDENTITY,
    StartTime DATETIME,
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'Completed', 'Failed')),
    PrintSideType NVARCHAR(50) CHECK (PrintSideType IN ('One-Sided', 'Two-Sided')),
    NumOfCopy INT,
    PageSize VARCHAR(50),
    TotalPage INT,
    CustomerId VARCHAR(50),
    PrinterId INT,
    CONSTRAINT PK_PrintServiceLog_Id PRIMARY KEY (Id),
    CONSTRAINT FK_PrintServiceLog_CustomerId FOREIGN KEY (CustomerId) REFERENCES InfoUser.Customer(Id),
    CONSTRAINT FK_PrintServiceLog_PrinterId FOREIGN KEY (PrinterId) REFERENCES InfoPrinter.Printer(Id)
);

-- Tạo bảng Document
CREATE TABLE PrintService.Document (
    Id VARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FileName VARCHAR(255),
    FileType VARCHAR(50),
    PrintLogId INT NULL,
    NumOfPage INT,
    CustomerId VARCHAR(50),
    CONSTRAINT PK_Document_Id PRIMARY KEY (Id),
    CONSTRAINT FK_Document_PrintServiceLogId FOREIGN KEY (PrintLogId) REFERENCES PrintService.PrintServiceLog(Id),
    CONSTRAINT FK_Document_CustomerId FOREIGN KEY (CustomerId) REFERENCES InfoUser.Customer(Id)
);

-- Tạo bảng Report
CREATE TABLE SystemService.Report (
    Id INT IDENTITY,
    Title VARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    TotalPrintingError INT,
    TotalPrintingSuccess INT,
    TotalPagesConsumed INT,
    CONSTRAINT PK_Report_Id PRIMARY KEY (Id)
);
GO

-- Thêm dữ liệu vào bảng Admin
INSERT INTO InfoUser.[Admin] (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, Ssn)
VALUES 
('A001', '0123456789', 'admin1@example.com', 'password123', '2024-12-01', 'Nguyen', 'Van', 'Admin', '123456789'),
('A002', '0987654321', 'admin2@example.com', 'password123', '2024-12-02', 'Tran', 'Nhat', 'Admin', '987654321'),
('A003', '0111222333', 'admin3@example.com', 'password123', '2024-12-03', 'Pham', 'Huy', 'Admin', '111222333'),
('A004', '0223344556', 'admin4@example.com', 'password123', '2024-12-04', 'Le', 'Hoang', 'Admin', '222333444'),
('A005', '0334455667', 'admin5@example.com', 'password123', '2024-12-05', 'Hoang', 'Ha', 'Admin', '333444555');

-- Thêm dữ liệu vào bảng SPSO
INSERT INTO InfoUser.SPSO (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, Ssn, Salary, ManagedBy)
VALUES 
('S001', '0123001111', 'spso1@example.com', 'password123', '2024-12-01', 'Nguyen', 'SPSO1', 'SPSO', '123001111', 5000, 'A001'),
('S002', '0123002222', 'spso2@example.com', 'password123', '2024-12-02', 'Tran', 'SPSO2', 'SPSO', '123002222', 6000, 'A002'),
('S003', '0123003333', 'spso3@example.com', 'password123', '2024-12-03', 'Pham', 'SPSO3', 'SPSO', '123003333', 7000, 'A003'),
('S004', '0123004444', 'spso4@example.com', 'password123', '2024-12-04', 'Le', 'SPSO4', 'SPSO', '123004444', 8000, 'A004'),
('S005', '0123005555', 'spso5@example.com', 'password123', '2024-12-05', 'Hoang', 'SPSO5', 'SPSO', '123005555', 9000, 'A005');

-- Thêm dữ liệu vào bảng Customer
INSERT INTO InfoUser.Customer (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, StudentCode, CurrentPage)
VALUES 
('C001', '0124001111', 'customer1@example.com', 'password123', '2024-12-01', 'Nguyen', 'Customer1', 'Customer', 'ST001', 100),
('C002', '0124002222', 'customer2@example.com', 'password123', '2024-12-02', 'Tran', 'Customer2', 'Customer', 'ST002', 200),
('C003', '0124003333', 'customer3@example.com', 'password123', '2024-12-03', 'Pham', 'Customer3', 'Customer', 'ST003', 300),
('C004', '0124004444', 'customer4@example.com', 'password123', '2024-12-04', 'Le', 'Customer4', 'Customer', 'ST004', 400),
('C005', '0124005555', 'customer5@example.com', 'password123', '2024-12-05', 'Hoang', 'Customer5', 'Customer', 'ST005', 500);

-- Thêm dữ liệu vào bảng DefaultConfiguration
INSERT INTO SystemService.DefaultConfiguration (Id, DefaultPage, DefaultGivenDate, PermittedFileTypes, CreatedAt, SPSOId)
VALUES 
('DC001', 50, '2024-01-01', 'PDF, DOCX', '2024-12-01', 'S001'),
('DC002', 60, '2024-01-02', 'PDF, JPG', '2024-12-02', 'S002'),
('DC003', 70, '2024-01-03', 'DOCX, JPG', '2024-12-03', 'S003'),
('DC004', 80, '2024-01-04', 'PDF', '2024-12-04', 'S004'),
('DC005', 90, '2024-01-05', 'DOCX', '2024-12-05', 'S005');

-- Thêm dữ liệu vào bảng PurchaseLog
INSERT INTO PrintService.PurchaseLog (TransactionTime, NumberOfPage, Price, PurchaseStatus, CustomerId)
VALUES 
('2024-12-01', 10, 5.00, 'Success', 'C001'),
('2024-12-02', 20, 10.00, 'Failed', 'C002'),
('2024-12-03', 15, 7.50, 'Success', 'C003'),
('2024-12-04', 25, 12.50, 'Success', 'C004'),
('2024-12-05', 30, 15.00, 'Failed', 'C005');

-- Thêm dữ liệu vào bảng PrinterLocation
INSERT INTO InfoPrinter.PrinterLocation (RoomName, BuildingName, CampusName)
VALUES 
('Room 101', 'Building A', 'Campus X'),
('Room 102', 'Building B', 'Campus Y'),
('Room 103', 'Building C', 'Campus Z'),
('Room 104', 'Building D', 'Campus X'),
('Room 105', 'Building E', 'Campus Y');

-- Thêm dữ liệu vào bảng Printer
INSERT INTO InfoPrinter.Printer (BrandName, Status, LocationId)
VALUES 
('Canon', 'Active', 1),
('HP', 'Inactive', 2),
('Epson', 'Active', 3),
('Brother', 'Active', 4),
('Samsung', 'Inactive', 5);

-- Thêm dữ liệu vào bảng PrintServiceLog
INSERT INTO PrintService.PrintServiceLog (StartTime, Status, PrintSideType, NumOfCopy, PageSize, TotalPage, CustomerId, PrinterId)
VALUES 
('2024-12-01 10:00:00', 'Completed', 'One-Sided', 2, 'A4', 20, 'C001', 1),
('2024-12-02 11:00:00', 'Pending', 'Two-Sided', 3, 'Letter', 30, 'C002', 2),
('2024-12-03 12:00:00', 'Failed', 'One-Sided', 1, 'A4', 10, 'C003', 3),
('2024-12-04 13:00:00', 'Completed', 'Two-Sided', 5, 'A3', 50, 'C004', 4),
('2024-12-05 14:00:00', 'Pending', 'One-Sided', 4, 'A4', 40, 'C005', 5);

-- Thêm dữ liệu vào bảng Document
INSERT INTO PrintService.Document (Id, FileName, FileType, PrintLogId, NumOfPage, CustomerId)
VALUES 
('D001', 'Doc1', 'PDF', 1, 20, 'C001'),
('D002', 'Doc2', 'DOCX', 2, 30, 'C002'),
('D003', 'Doc3', 'JPG', 3, 40, 'C003'),
('D004', 'Doc4', 'PDF', 4, 100, 'C004'),
('D005', 'Doc5', 'DOCX', 5, 10, 'C005');    

-- Thêm dữ liệu vào bảng Report
INSERT INTO SystemService.Report (Title, CreatedAt, TotalPrintingError, TotalPrintingSuccess, TotalPagesConsumed)
VALUES 
('Monthly Report - January', '2024-01-31', 2, 30, 500),
('Monthly Report - February', '2024-02-28', 1, 25, 400),
('Monthly Report - March', '2024-03-31', 3, 35, 600),
('Monthly Report - April', '2024-04-30', 0, 40, 700),
('Monthly Report - May', '2024-05-31', 4, 20, 300);
GO


SELECT *
FROM InfoUser.[Admin];

SELECT *
FROM InfoUser.SPSO;

SELECT *
FROM InfoUser.Customer;

SELECT *
FROM InfoPrinter.Printer;

SELECT *
FROM InfoPrinter.PrinterLocation;

SELECT *
FROM PrintService.PrintServiceLog;

SELECT *
FROM PrintService.PurchaseLog;

SELECT *
FROM SystemService.DefaultConfiguration;

SELECT *
FROM PrintService.Document;

SELECT *
FROM SystemService.Report;
