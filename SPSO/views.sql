CREATE VIEW InfoUser.SPSOView AS
SELECT 
    Id, 
    PhoneNumber, 
    Email, 
    LastLogin, 
    FamilyName, 
    GivenName, 
    Role, 
    Ssn, 
    Salary, 
    ManagedBy
FROM InfoUser.SPSO;
