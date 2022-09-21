use library
Select Category,avg(Cost) as average from Book group by Category having Category='Database'
Select Category,count(distinct(Book_No)) as NumberofBooks from Book group by Category
Select Book_No,count(Book_No) as count1 from issue group by Book_No order by count1 desc
Select max(penaltyamount) as max,min(penaltyamount) as min,sum(penaltyamount) as total,avg(penaltyamount) as average from member
Select member_id,count(distinct(Book_No)) as booksborrowed from issue group by Member_Id having count(distinct(Book_No))>=2
Select member_id,Book_No,count(distinct(Book_No)) as count1 from issue group by Book_No,Member_Id order by count1 desc--needs to check
Select datename(MONTH,Issue_Date) as monthnames,COUNT(Book_No) as noofbooks from issue group by datename(Month,Issue_Date) order by 2 desc 
Select * from issue
Select Book_No,Book_Name from Book where Book_No not in(Select Book_No from issue)
Select i.member_id from issue i inner join member j on i.Member_Id=j.member_id group by i.member_id having count(Book_No)>0 --question8
Select member_id from issue where member_id in(Select member_id from member) intersect (Select member_id from issue group by member_id having count(Book_No)>0)--qn8
Select top 1 member_id,count(Book_No) as count1 from issue group by member_id order by count1 desc 
Select top 1 member_id,count(Book_No) as count1 from issue group by member_id order by count1
Select * from issue where DATENAME(month,Issue_Date) in ('July','December')
Select i.Book_No,i.Book_Name,j.Issue_Date FROM Book i inner join issue j on i.Book_No=j.Book_No where MONTH(j.issue_date)=12 and i.Category='Database' 
Select issue.member_id,member.member_name,count(issue.Book_No) as count1  from member inner join issue on issue.Member_Id=member.Member_Id group by issue.member_id,member.member_name order by count1 desc
Select issue.Lib_Issue_Id,issue.Member_Id,issue.Book_No,issue.Issue_Date,issue.Return_date from issue inner join member on issue.Member_Id=member.member_id where member.member_name='Richa Sharma'
Select * from member where member_id in (Select issue.member_id from issue inner join Book on issue.Book_No=Book.Book_No where Book.Category='Database') 
Select Category,max(Cost) as highprice from Book group by Category
Select issue.Lib_Issue_Id,issue.Member_Id,issue.Book_No from issue inner join member on issue.Member_Id=member.member_id where issue.Issue_Date not between member.Acc_open_date and issue.Return_date
Select * from member
Select * from member where member_id not in(Select member.member_id from issue inner join member on member.member_id=Issue.Member_Id group by member.member_id)
Select member.member_id,member.member_name,count(issue.Book_No) as booksissued,member.maxbooksallowed  from issue inner join member on issue.Member_Id=member.member_id  group by member.member_id,member.member_name,member.maxbooksallowed having member.maxbooksallowed<=count(issue.Book_No)
Select member.member_id,member_name,issue.Book_No from issue inner join member on member.member_id=Issue.Member_Id where issue.Book_No in(Select issue.Book_No from issue inner join member on member.member_id=Issue.Member_Id where member.member_name like'Garima%')
Select Book.Book_No,Book.Book_Name,Book.Cost from issue inner join Book on Issue.Book_No=Book.Book_No where DATEDIFF(day,Issue.Issue_Date,Issue.Return_date)>30 
Select Book_Name,author from Book where author in (Select author from book group by author having count(Book_Name)>1)
Select top 3 * from Book order by Cost desc
Select sum(Cost) from Book where Book_No in(Select Book_No from issue where Return_date is null)
Select * from Book where Book_No in(Select top 1 Book_No from issue group by Book_No order by count(Book_No) desc)