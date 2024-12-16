GO
CREATE PROCEDURE AddNewCustomer
    @Id VARCHAR(50),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(255),
    @Password VARCHAR(255),
    @LastLogin DATE,
    @FamilyName VARCHAR(100),
    @GivenName VARCHAR(100),
    @StudentCode VARCHAR(50),
    @CurrentPage INT
AS
BEGIN
    INSERT INTO InfoUser.Customer (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, StudentCode, CurrentPage)
    VALUES (@Id, @PhoneNumber, @Email, @Password, @LastLogin, @FamilyName, @GivenName, 'Customer', @StudentCode, @CurrentPage);
END;
GO
EXEC AddNewCustomer 'C021', '0911082004', 'customer20@example.com', 'password123', '2024-12-06', 'Nguyen', 'Customer6', 'ST021', 600;