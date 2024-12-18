GO
--Hàm tính giá trị giảm giá cho khách hàng, giảm giá 10% nếu mua trên 1000 trang
CREATE FUNCTION CalculateDiscount (@TotalPages INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Discount DECIMAL(18, 2);
        IF @TotalPages > 1000
        SET @Discount = @TotalPages * 0.1;
    ELSE
        SET @Discount = 0;
    RETURN @Discount;
END;
GO
SELECT dbo.CalculateDiscount(1200) AS DiscountAmount;