 use pubs
 
 select CONCAT(fname,' ',lname) as name from employee;

 

declare
@n_check varchar(80),
@n_cost money
begin
select @n_check=title,@n_cost=price from titles where title='The Gourmet Microwave'
print @n_check
if(@n_check=null)
print 'not found'
else
print @n_cost
end

Select * from titles

declare 
@n_type char(12),
@p_price money
begin
set @n_type='psychology'
select @p_price=avg(price)from titles group by type having type=@n_type;
if(@p_price>15)
print @p_price
else
print 'it is less than 15'
end


