CREATE TRIGGER trg_AdminInsert
ON InfoUser.[Admin]
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED WHERE LEN(Ssn) <> 9)
    BEGIN
        PRINT 'SSN phải có đúng 9 ký tự.';
        ROLLBACK;
    END
    ELSE
    BEGIN
        INSERT INTO InfoUser.[Admin](Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, Ssn)
        SELECT Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, Ssn
        FROM INSERTED;
    END
END;
GO