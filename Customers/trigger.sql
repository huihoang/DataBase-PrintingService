CREATE TRIGGER trg_CustomerLogin
ON InfoUser.Customer
FOR UPDATE
AS
BEGIN
    DECLARE @Id VARCHAR(50);
    DECLARE @LastLogin DATE;
    SELECT @Id = Id, @LastLogin = LastLogin FROM inserted;

    IF @LastLogin IS NULL
    BEGIN
        UPDATE InfoUser.Customer 
        SET LastLogin = GETDATE()
        WHERE Id = @Id;
    END
END;
