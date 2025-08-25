# Loan Portfolio Analysis (SQL Project)

## 📌 Project Overview
This project simulates **Loan Portfolio Analysis** for a bank using SQL.  
It demonstrates how SQL can be used for **NPA calculation, overdue loan detection, and repayment trend analysis**.

---

## 🗂️ Database Schema
**Tables:**
1. **Customers** – Customer details (ID, Name, Age, City)
2. **Loans** – Loan details (Amount, Dates, Status)
3. **Repayments** – Loan repayment transactions

---

## 📝 Sample Data
- Customers: 4 sample records (Amit, Jyoti, Rahul, Neha)
- Loans: 4 sample loans (including 1 Defaulted loan)
- Repayments: Payment history for each loan

---

## 🔍 Key SQL Queries & Expected Outputs

### (A) Total Loan Portfolio
```sql
SELECT SUM(loan_amount) AS total_loan_portfolio FROM Loans;
```
**Output:**
| total_loan_portfolio |
|-----------------------|
| 2000000              |

---

### (B) Non-Performing Assets (Defaulted Loans)
```sql
SELECT loan_id, customer_id, loan_amount FROM Loans WHERE status = 'Defaulted';
```
**Output:**
| loan_id | customer_id | loan_amount |
|---------|-------------|-------------|
| 103     | 3           | 1000000     |

---

### (C) Overdue Loans (Past End Date but Not Closed)
```sql
SELECT loan_id, customer_id, loan_amount, end_date
FROM Loans
WHERE end_date < CURRENT_DATE AND status != 'Closed';
```
**Output Example (if run in 2025):**
| loan_id | customer_id | loan_amount | end_date   |
|---------|-------------|-------------|------------|
| 103     | 3           | 1000000     | 2024-07-01 |

---

### (D) Repayment Trends Per Customer
```sql
SELECT c.name, l.loan_id, SUM(r.amount_paid) AS total_repaid
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
JOIN Repayments r ON l.loan_id = r.loan_id
GROUP BY c.name, l.loan_id;
```
**Output:**
| name        | loan_id | total_repaid |
|-------------|---------|--------------|
| Amit Kumar  | 101     | 40000        |
| Jyoti Sharma| 102     | 20000        |
| Rahul Verma | 103     | 50000        |
| Neha Singh  | 104     | 15000        |

---

## 🛠️ Tech Used
- SQL (MySQL / PostgreSQL / Teradata)
- Excel (for report visualization)

---

## 🎯 Impact
- Helps **Risk & Compliance teams** identify risky loans.  
- Provides insights into **customer repayment behavior**.  
- Automates **regulatory loan reporting**.  

---

## 🚀 How to Run
1. Create database in MySQL/Postgres/Teradata.  
2. Run the SQL script from `Loan_Portfolio_Analysis.sql`.  
3. Execute queries to generate reports.  

---

## 📂 Files
- `Loan_Portfolio_Analysis.sql` → Database schema + sample queries  
- `README.md` → Documentation with outputs  

---
