create database library
go

use library

create table member(
member_id numeric(5) not null constraint pk_member primary key,
member_name char(25),
Acc_open_date date,
maxbooksallowed numeric check(maxbooksallowed<=10),
penaltyamount numeric(7,2)
)

create table Book(Book_No numeric(6) constraint pk_book primary key,
Book_Name varchar(30),
Author Char(30),
Cost numeric(7,2), 
Category Char(10))

create table Issue(Lib_Issue_Id	numeric(10) constraint pk_issue primary key,
Book_No numeric(6) constraint pk_bk foreign key references Book(Book_No),
Member_Id numeric(5) constraint pk_mem foreign key references member(member_id),
Issue_Date Date,
Return_date Date)

sp_help Book
sp_help member
sp_help issue

Alter table issue
add comments char(100)

Alter table member
alter column member_name char(30)

Alter table issue
add reference char(30)

Alter table issue
drop column reference



insert into member values(1,'Richa sharma','2005-12-10',5,50)
insert into member values(2,'Nupur sharma',CURRENT_TIMESTAMP,3,null)
insert into member values(3,'Garima Sen','2006-8-10',7,30)
insert into member values(4,'Kareena Kapoor','2007-9-20',8,20)
insert into member values(5,'Anjali','2008-10-25',3,50)

Alter table member
alter column member_name char(20)

insert into member values(6,'Anupama','2019-10-25',110,45)

Select * into member101 from member
insert into Book values(101,'Let us C','Denis Ritchie',450,'System')
insert into Book values(102,'Oracle – Complete Ref','Loni',550,'Database')
insert into Book values(103,'Mastering SQL','Loni',250,'Database')
insert into Book values(104,'PL SQL-Ref','Scott Urman',750,'Database')

Select * into Book101 from Book where 1>2

Insert into Book101 Select * from Book

Select * from Book101


Select * from Book
Begin tran
commit tran
Begin tran
Insert into Book values(105,'National Geographic','Adis Scott',1000,'Science') 
Select * from Book
rollback tran
Select * from Book

update Book set Cost=300,Category='RDBMS' where Book_No=103


Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7001,101,1,'2006-12-10')
Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7002,102,2,'2006-12-25')
Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7003,104,1,	'2006-01-06')
Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7004,101,1,'2006-07-04')
Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7005,104,2,'2006-11-15')
Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7006,101,3,'2006-02-18')
begin tran
commit tran
Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7007,103,2,'2006-06-28')
Insert into issue(Lib_Issue_Id,Book_No,Member_Id,Issue_Date) values(7008,104,4,'2006-01-29')
update issue set Return_date=DATEADD(DAY,15,Issue_Date) where Lib_Issue_Id in (7004,7005)
 
begin tran
rollback tran
Select * from issue 
update member set penaltyamount=100 where member_name='Garima Sen'
Select * from member
begin transaction t
save transaction t
Delete from issue where member_id=1 and Issue_Date<'2006-12-10'
Select * from issue
Delete from Book where Category not in ('RDBMS','Database')
rollback transaction t
drop table member101
drop table Book101


SELECT Table_name FROM INFORMATION_SCHEMA.TABLES;

Select * from member where Year(Acc_open_date)=2006
Select * from Book where Author='Loni' and Cost<600
Select * from issue where Return_date IS NULL
update issue set Return_date='2006-12-31' where Return_date is NULL
Select * from issue where DATEDIFF(day,Issue_Date,Return_date)>30
Select * from Book where cost between 500 and 700 intersect (Select * from Book where Category='Database')
Select * from Book where Category in('Science','Database','Fiction','Management')
Select member_name,penaltyamount from member order by penaltyamount desc
Select Book_No,Book_Name,Author,Cost,Category from Book order by 5,4 desc
Select Book_Name from Book where Book_Name like '%SQL%'
Select member_name from member where member_name like'R%' or member_name like 'G%' and member_name like '%i%'
Select Concat(upper(left(Book_Name,1)),right(Book_Name,len(Book_Name)-1)) as bookname,Upper(Author) as author from Book order by Book_Name desc
Select Book_Name,'is written by' as comment,Author from Book 
Select Lib_Issue_Id,Book_No,Member_Id,Concat(datename(WEEKDAY,Issue_Date),',',CONVERT(varchar,Issue_Date,107)) as issuedate,Concat(DATENAME(WEEKDAY,Return_date),',',CONVERT(varchar,Return_date,107)) as returndate from issue where Member_Id=1
Select Book_No,Book_Name,Cost,Category,
case
when Category='Database' then 'D'
when Category='RDBMS' then 'R'
else 'O'
End as datadisplayed
from Book
Select CoNCAT(Book_Name,'*****',Author) as details from Book
Select Lib_Issue_Id,Issue_Date,Return_date,DATEDIFF(Day,Issue_Date,Return_date) as Noofdaysissued from issue 
Select * from member order by Acc_open_date
Select member_id,count(distinct(Book_No)) as count1 from issue group by member_id having Member_Id=1
Select sum(penaltyamount) as total from member
Select Category,sum(Cost) as total from Book group by Category having Category='Database'
Select min(Cost) as mincost from Book 
Select min(Issue_date) as firstbook from issue
Select max(Issue_date) as firstbook from issue
Select Category,avg(Cost) as average from Book group by Category having Category='Database'
Select Category,count(distinct(Book_No)) as NumberofBooks from Book group by Category
Select Book_No,count(Book_No) as count1 from issue group by Book_No order by count1 desc
Select max(penaltyamount) as max,min(penaltyamount) as min,sum(penaltyamount) as total,avg(penaltyamount) as average from member
Select member_id,count(distinct(Book_No)) as booksborrowed from issue group by Member_Id having count(distinct(Book_No))>=2
Select member_id,Book_No,count(distinct(Book_No)) as count1 from issue order by count1 desc--needs to check
Select MONTH(Issue_Date) as monthnames,COUNT(Book_No) as noofbooks from issue group by Month(Issue_Date) order by 2 desc 
Select * from issue
Select Book_No,Book_Name from Book where Book_No not in(Select Book_No from issue)
Select i.member_id from issue i inner join member j on i.Member_Id=j.member_id group by i.member_id having count(Book_No)>0 --question8
Select member_id from issue where member_id in(Select member_id from member) intersect (Select member_id from issue group by member_id having count(Book_No)>0)--qn8
Select top 1 member_id,count(Book_No) as count1 from issue group by member_id order by count1 desc 
Select top 1 member_id,count(Book_No) as count1 from issue group by member_id order by count1
Select * from issue where MONTH(issue_date) in (7,12)
Select i.Book_No,i.Book_Name,j.Issue_Date FROM Book i inner join issue j on i.Book_No=j.Book_No where MONTH(j.issue_date)=12 and i.Category='Database' 
Select issue.member_id,member.member_name,count(issue.Book_No) as count1  from member inner join issue on issue.Member_Id=member.Member_Id group by issue.member_id,member.member_name order by count1 desc
Select issue.Lib_Issue_Id,issue.Member_Id,issue.Book_No,issue.Issue_Date,issue.Return_date from issue inner join member on issue.Member_Id=member.member_id where member.member_name='Richa Sharma'
Select * from member where member_id in (Select issue.member_id from issue inner join Book on issue.Book_No=Book.Book_No where Book.Category='Database') 
Select Category,max(Cost) as highprice from Book group by Category
Select issue.Lib_Issue_Id,issue.Member_Id,issue.Book_No from issue inner join member on issue.Member_Id=member.member_id where issue.Issue_Date not between member.Acc_open_date and issue.Return_date
Select * from member
Select * from member where member_id not in(Select member.member_id from issue inner join member on member.member_id=Issue.Member_Id group by member.member_id)
Select member.member_id,member.member_name,count(Book_No) as booksissued,member.maxbooksallowed into issu01 from issue inner join member on issue.Member_Id=member.member_id group by member.member_id,member.member_name,member.maxbooksallowed
Select member_id,member_name from issu01 where maxbooksallowed<=booksissued
Select member.member_id,member.member_name,count(issue.Book_No) as booksissued,member.maxbooksallowed  from issue inner join member on issue.Member_Id=member.member_id  group by member.member_id,member.member_name,member.maxbooksallowed having member.maxbooksallowed<=count(issue.Book_No)
Select member.member_id,member_name,issue.Book_No from issue inner join member on member.member_id=Issue.Member_Id where issue.Book_No in(Select issue.Book_No from issue inner join member on member.member_id=Issue.Member_Id where member.member_name like'Garima%')
Select Book.Book_No,Book.Book_Name,Book.Cost from issue inner join Book on Issue.Book_No=Book.Book_No where DATEDIFF(day,Issue.Issue_Date,Issue.Return_date)>30 
Select Book_Name,author from Book where author in (Select author from book group by author having count(Book_Name)>1)
Select top 3 * from Book order by Cost desc
Select sum(Cost) from Book where Book_No in(Select Book_No from issue where Return_date is null)
Select * from Book where Book_No in(Select top 1 Book_No from issue group by Book_No order by count(Book_No) desc)
sp_help issu01
Select t.Book_No,t.Member_Id,p.Book_Name,s.Member_Name from issue t inner join Book p on t.Book_No=p.Book_No inner join member s on t.Member_Id=s.member_id

