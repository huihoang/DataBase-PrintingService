CREATE PROCEDURE UpdateSPSOSalary
    @Id VARCHAR(50),
    @Salary INT
AS
BEGIN
    IF @Salary < 0
    BEGIN
        PRINT 'Salary cannot be negative';
        RETURN;
    END

    UPDATE InfoUser.SPSO
    SET Salary = @Salary
    WHERE Id = @Id;
END;
