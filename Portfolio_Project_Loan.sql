-- fetching entire data
select * from BankLoanDB..financial_loan

--DASHBOARD 1 SUMMARY
--KPIS
-- total loan applications received during the period
select count(distinct(id)) as Total_Loan_Applications from BankLoanDB..financial_loan

-- total loan applications on month to month basis
select count(id) as Total_Loan_Applications,month(issue_date) as month_issued from BankLoanDB..financial_loan group by month(issue_date) order by month(issue_date)

-- total loan applications increased over the year on month to month basis
with temp 
as (select count(id) as Total_Loan_Applications2,month(issue_date) as month_issued from BankLoanDB..financial_loan group by month(issue_date))
select count(a1.id) as Total_Loan_Applications,a2.Total_Loan_Applications2,((count(a1.id)-a2.Total_Loan_Applications2)/CAST(a2.Total_Loan_Applications2 AS DECIMAL(10,2)))*100 as Percentage_change from BankLoanDB..financial_loan as a1 join temp as a2 on month(a1.issue_date)-a2.month_issued =1
group by month(a1.issue_date),a2.month_issued,a2.Total_Loan_Applications2 order by month(a1.issue_date)


-- total amount of funds disbursed as loan
select sum(loan_amount) as total_loan_issued from BankLoanDB..financial_loan

-- calculating average interest rate
select avg(int_rate) as Average_interest_rate from BankLoanDB..financial_loan

-- calculating average interest rate for every month
select avg(int_rate) as Average_interest_rate,month(issue_date) as month from BankLoanDB..financial_loan group by month(issue_date) order by month(issue_date)


-- calculating average dti 
select avg(dti) as Average_dti from BankLoanDB..financial_loan

-- calculating average dti for every month
select avg(dti) as Average_dti,month(issue_date) as month from BankLoanDB..financial_loan group by month(issue_date) order by month(issue_date)

-- identifying percentage of good loan and bad loan
-- fullypaid and current are inside good loan and charged off lies in bad loan
select (convert(decimal,count(id))/(select count(id) from BankLoanDB..financial_loan))*100 as Percentage_loan,(case when loan_status='Fully Paid' or loan_status='Current' then 'Good Loan' else 'Bad Loan' end) as Status from BankLoanDB..financial_loan group by (case when loan_status='Fully Paid' or loan_status='Current' then 'Good Loan' else 'Bad Loan' end)

-- Good loan funded amount
select sum(loan_amount) as good_loan_issued from BankLoanDB..financial_loan where loan_status='Fully Paid' or loan_status='Current'

-- Good loan payment received
select sum(total_payment) as good_loan_amount_received from BankLoanDB..financial_loan where loan_status='Fully Paid' or loan_status='Current'

-- Bad loan funded amount
select sum(loan_amount) as bad_loan_issued from BankLoanDB..financial_loan where loan_status='Charged off'

-- Bad loan payment received
select sum(total_payment) as bad_loan_amount_received from BankLoanDB..financial_loan where loan_status='Charged off'

-- loan status grid view
-- loan_status,loan_count,total_amount_received,total_funded_amount,interest_rate,DTI

select loan_status,count(id) as loan_count,sum(total_payment) as total_amount_received,sum(loan_amount) as total_funded_amount,avg(int_rate)*100 as avg_int_rate,avg(dti)*100 as avg_dti
from BankLoanDB..financial_loan group by loan_status


-- DASHBOARD 2 OVERVIEW
select * from BankLoanDB..financial_loan

-- calculating loans issued on each date
select sum(loan_amount) as loan_issued,count(id) as number_of_loans_issued,issue_date from BankLoanDB..financial_loan group by issue_date order by issue_date

-- calculating loans issued on each month
select sum(loan_amount) as loan_issued,count(id) as number_of_loans_issued,datename(month,issue_date) as month from BankLoanDB..financial_loan group by month(issue_date),datename(month,issue_date) order by month(issue_date)

-- regional analysis by state
select address_state,count(id) as number_of_loans_issued,sum(loan_amount) as loans_issued from BankLoanDB..financial_loan group by address_state order by loans_issued desc

-- terms based analysis
select distinct(term) from BankLoanDB..financial_loan
select term,count(id) as number_of_loans_issued,sum(loan_amount) as loans_issued from BankLoanDB..financial_loan group by term order by loans_issued desc

-- analysis based on emp length
select distinct(emp_length) from BankLoanDB..financial_loan
select emp_length,count(id) as number_of_loans_issued,sum(loan_amount) as loans_issued from BankLoanDB..financial_loan group by emp_length order by loans_issued desc

-- loan purpose analysis
select purpose,count(id) as number_of_loans_issued,sum(loan_amount) as loans_issued from BankLoanDB..financial_loan group by purpose order by loans_issued desc

-- home_ownership analysis
select home_ownership,count(id) as number_of_loans_issued,sum(loan_amount) as loans_issued from BankLoanDB..financial_loan group by home_ownership order by loans_issued desc

-- DASHBOARD DETAILS
-- grid view
select * from BankLoanDB..financial_loan