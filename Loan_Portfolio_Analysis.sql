-- Loan Portfolio Analysis Project (SQL)

-- Step 1: Create Tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    city VARCHAR(50)
);

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(12,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20), -- Active, Closed, Defaulted
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Repayments (
    repayment_id INT PRIMARY KEY,
    loan_id INT,
    payment_date DATE,
    amount_paid DECIMAL(12,2),
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id)
);

-- Step 2: Insert Sample Data
INSERT INTO Customers VALUES
(1, 'Amit Kumar', 34, 'Delhi'),
(2, 'Jyoti Sharma', 28, 'Mumbai'),
(3, 'Rahul Verma', 45, 'Bangalore'),
(4, 'Neha Singh', 38, 'Chennai');

INSERT INTO Loans VALUES
(101, 1, 500000, '2023-01-01', '2026-01-01', 'Active'),
(102, 2, 200000, '2022-05-01', '2025-05-01', 'Active'),
(103, 3, 1000000, '2021-07-01', '2024-07-01', 'Defaulted'),
(104, 4, 300000, '2023-03-01', '2026-03-01', 'Active');

INSERT INTO Repayments VALUES
(1001, 101, '2023-02-01', 20000),
(1002, 101, '2023-03-01', 20000),
(1003, 102, '2022-06-01', 10000),
(1004, 102, '2022-07-01', 10000),
(1005, 103, '2021-08-01', 50000),
(1006, 104, '2023-04-01', 15000);

-- Step 3: Queries

-- (A) Total Loan Portfolio
SELECT SUM(loan_amount) AS total_loan_portfolio FROM Loans;

-- (B) Non-Performing Assets (Defaulted Loans)
SELECT loan_id, customer_id, loan_amount 
FROM Loans
WHERE status = 'Defaulted';

-- (C) Overdue Loans (loans past end_date but not closed)
SELECT loan_id, customer_id, loan_amount, end_date
FROM Loans
WHERE end_date < CURRENT_DATE AND status != 'Closed';

-- (D) Repayment Trends per Customer
SELECT c.name, l.loan_id, SUM(r.amount_paid) AS total_repaid
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
JOIN Repayments r ON l.loan_id = r.loan_id
GROUP BY c.name, l.loan_id;
