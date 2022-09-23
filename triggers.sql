create database pro

use pro

create table newcategories(
categoryid nchar(5),
categoryname varchar(25)
)

create table newproducts(
productid nchar(5),
productname varchar(25),
category varchar(25),
discontinuedcol int)

insert into newcategories values('10','Flour')

insert into newproducts(productid,productname,category) values('1','Wheatflour','Flour');
insert into newproducts(productid,productname,category) values('2','Ragiflour','Flour');
insert into newproducts(productid,productname,category) values('3','Maidaflour','Flour');
insert into newproducts(productid,productname,category) values('4','Dosaflour','Flour');

delete from newproducts where productname='1'
--question number
create trigger trigafterdeleted
on newcategories for Delete as
declare
@v_cat varchar(25),
@v_prod int=1,
@v_pr varchar(150)
begin
set @v_pr='delete trigger successfully';
select categoryname from deleted;
select @v_cat=categoryname from deleted;
update newproducts set discontinuedcol=@v_prod where category=@v_cat;
print 'trigger fired successfully'
end



delete from newcategories where categoryid=10

Select * from newproducts

create trigger deletenotmorethan3
on newproducts instead of Delete as
declare
@n_count int,
@n_audit_action varchar(100)
begin
set @n_audit_action='trigger before delete';
select @n_count=count(*) from deleted;
if(@n_count>=3)
print 'cant delete more than 3'
end

delete from newproducts where category='Flour'

select * from newproducts