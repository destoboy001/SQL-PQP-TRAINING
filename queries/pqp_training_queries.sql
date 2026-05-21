-- Q1. New Candidate Report
-- Retrieve the CandID and Reg_Date for every candidate in the system.
SELECT 
    CandidateID, Registration_Date
FROM
    candidate_tbl;

-- Q2. Course Catalogue
-- Display a full list of all course IDs and their names
select *
from course_tbl;

-- Q3. In-Person Attendance List
-- List all candidates who chose Physical as their training type
select *
from candidate_tbl
where Training_Type = 'Physical';

-- Q4. High-Value Transactions
-- Show all transaction records where the total amount paid exceeds ₦50,000
select *
from transaction_tbl
where Amount > 50000;

-- Q5. Candidate Count by City
-- Count candidates grouped by Loc_ID
select LocationID,count(*) as "total candidates"
from candidate_tbl
group by LocationID;

-- Q6. 2021 Intake Report
-- HR needs a report of all candidates who registered within the year 2021 for annual review
select *
from candidate_tbl
where Registration_Date between '2021-01-01' and '2021-12-31';

-- Q7. Certificate Collection Tracker
-- The admin team wants to see which candidates have physically collected their certificates
select *
from certificate_tbl
where Cert_status = 'collected';

-- Q8. Manager-Candidate Assignment Report
-- HR wants a single report showing each candidate alongside the name of their assigned manager (not just the manager ID)
SELECT CandidateID,candidate_tbl.ManagerID,Manager_Name
from candidate_tbl
inner join manager_table on candidate_tbl.ManagerID=manager_table.ManagerID;

-- Q9. Candidate Location Directory
-- Show CandID and the full location name
select CandidateID,Location_Name
from candidate_tbl
join location_tbl 
on candidate_tbl.LocationID=location_tbl.LocationID;

-- Q10. Most Popular Course
-- Return the course name and the number of candidates enrolled.
select Course_Name,count(*) as 'Number of Candidate enrolled'
from candidate_tbl
join course_tbl on candidate_tbl.CourseID=course_tbl.CourseID
group by Course_Name
order by count(*) desc
Limit 1; 

-- Q11. Pending Certificate Issuance
-- Admin wants to follow up on candidates who have not yet received their certificate
select CandID as 'CandidateID',Cert_status
from certificate_tbl
where Cert_status = '' or Cert_status IS NULL;

-- Q12. Revenue by Course
-- The finance director wants to see total revenue broken down by course to assess programme profitability
select Course_Name,sum(Amount) as 'total revenue'
from transaction_tbl t
join course_tbl c
on t.Cos_ID=c.CourseID
group by Course_Name
order by sum(Amount) desc;

-- Q13. Kunle's Candidate Portfolio
-- Manager Kunle is preparing for a performance review and needs a list of every candidate he manages
select CandidateID,Manager_Name
from candidate_tbl c
join manager_table m
on c.ManagerID=m.ManagerID
where Manager_Name='Kunle';

-- Q14. Best Performing Promo Channel
-- Marketing wants to evaluate which promo code or referral source drove the most revenue.
select Promo_code,sum(amount) as "revenue"
from transaction_tbl
group by Promo_code
order by sum(Amount) desc
limit 1;

-- Q15. Instalment Payment Tracking
-- Accounts receivable needs a list of candidates who are paying in instalments (i.e., a second payment has been recorded)
select *
from transaction_tbl
where Instalm_2 != 0.00;
