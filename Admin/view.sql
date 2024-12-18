CREATE VIEW InfoUser.AdminView AS
SELECT 
    Id, 
    PhoneNumber, 
    Email, 
    LastLogin, 
    FamilyName, 
    GivenName, 
    Role, 
    Ssn
FROM InfoUser.Admin;
