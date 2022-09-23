--4thone
CREATE PROCEDURE residingcity
	-- Add the parameters for the stored procedure here
@n_city varchar(20)
AS
BEGIN
     Select pub_name from publishers where city=@n_city
END
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[residingcity]
		@n_city = N'Chicago'

SELECT	'Return Value' = @return_value

GO
--5thone
create procedure ordersfor
@n_titleid varchar(6)
as
begin
 select title_id,count(ord_num) from sales group by title_id having title_id=@n_titleid;
end
go


DECLARE	@return_value int

EXEC	@return_value = [dbo].[ordersfor]
		@n_titleid = N'PS2091'

SELECT	'Return Value' = @return_value

GO
select * from sales
--6thone
create procedure storename
as
begin
 select j.stor_name,count(i.ord_num) from sales i inner join stores j on i.stor_id=j.stor_id group by j.stor_name;
end
go
EXEC [dbo].[storename]

--7thone
CREATE PROCEDURE totalorders 
	-- Add the parameters for the stored procedure here
	@n_titleid varchar(6),
	@n_int int output
AS
BEGIN
	select @n_int=count(ord_num) from sales group by title_id having title_id=@n_titleid;
END
GO


DECLARE	@return_value int,
		@n_int int

EXEC	@return_value = [dbo].[totalorders]
		@n_titleid = N'PS2091',
		@n_int = @n_int OUTPUT

SELECT	@n_int as N'@n_int'

SELECT	'Return Value' = @return_value

GO




