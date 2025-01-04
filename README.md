# **Bank Loan Data Analysis Dashboard**

## **Project Overview**
This project involves analyzing financial data from a bank's loan portfolio. The objective is to create an interactive and insightful dashboard to visualize key metrics like loan applications, disbursed loan amounts, loan statuses, interest rates, and more. The analysis is conducted using SQL queries, and the dashboard is built using Tableau for visual representation.

## **Technologies Used**
- **Database**: SQL Server
- **BI Tool**: Tableau
- **SQL Queries**: Used to extract, clean, and analyze data
- **Visualization**: Tableau to create dashboards and reports

## **Data Overview**
The analysis is based on the `BankLoanDB..financial_loan` table, which contains detailed records of loans issued by the bank. The key fields used for analysis include:
- `id`: Unique identifier for each loan
- `loan_amount`: The total amount of the loan
- `int_rate`: Interest rate applied to the loan
- `dti`: Debt-to-income ratio of the borrower
- `loan_status`: Status of the loan (e.g., Fully Paid, Current, Charged off)
- `issue_date`: Date when the loan was issued
- `total_payment`: Total payment made towards the loan
