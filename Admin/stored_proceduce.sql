CREATE PROCEDURE AddNewAdmin
    @Id VARCHAR(50),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(255),
    @Password VARCHAR(255),
    @FamilyName VARCHAR(100),
    @GivenName VARCHAR(100),
    @Role NVARCHAR(50),
    @Ssn VARCHAR(12)
AS
BEGIN
    INSERT INTO InfoUser.Admin (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, Ssn)
    VALUES (@Id, @PhoneNumber, @Email, @Password, GETDATE(), @FamilyName, @GivenName, @Role, @Ssn);
END;
