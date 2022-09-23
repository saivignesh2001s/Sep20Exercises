--question 8
CREATE FUNCTION Noofdays 
(	

	@n_startdate date,
	@n_enddate date
)
RETURNS int 
AS
Begin
declare @n_count int=0
while(@n_startdate<=@n_enddate)
begin
if(datename(weekday,@n_startdate)='Sunday' or datename(weekday,@n_startdate)='Saturday')
set @n_count=@n_count+0;
else
set @n_count=@n_count+1;
set @n_startdate=DATEADD(day,1,@n_startdate)
end
return @n_count
end
GO
select [dbo].[Noofdays]('2022-09-16','2022-09-20')

--question 9
Create function Yearlysalary
(
 @n_hourlysalary float
)
returns float
as
begin
declare 
@n_week float,
@n_year float;
set @n_week=365/7;
set @n_year=@n_week*40*@n_hourlysalary;
return @n_year;
end
go

select [dbo].[Yearlysalary](20.0)

--question 10
CREATE FUNCTION cylinder
(
	-- Add the parameters for the function here
	@n_radius float,
	@n_height float
)
RETURNS 
@cylinderdata TABLE 
(
	-- Add the column definitions for the TABLE variable here
	diameter float,
	circumference float,
	basearea float,
	sidearea float,
	totalarea float,
	volume float
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	declare 
	@dia float,
	@circum float,
	@base float,
	@side float,
	@total float,
	@vol float,
	@pi float=3.14
set	@dia=2*@n_radius;
set @circum=@pi*@dia;
set @base=@pi*@n_radius*@n_radius;
set @side=2*@pi*@n_radius*@n_height;
set @total=(2*@base)+@side;
set @vol=@pi*@n_radius*@n_radius*@n_height;
	
insert into @cylinderdata values(@dia,@circum,@base,@side,@total,@vol);
return

END
GO
drop function cylinder
select * from [dbo].[cylinder](7.0,14.0)