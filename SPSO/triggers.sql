CREATE TRIGGER trg_SPSO_Salary
ON InfoUser.SPSO
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @Salary INT;
    SELECT @Salary = Salary FROM inserted;

    IF @Salary < 0
    BEGIN
        PRINT 'Salary must be a non-negative value';
        ROLLBACK TRANSACTION;
    END
END;
