show databases;
use bhoomika1;
CREATE TABLE Branch1 (
    BranchName VARCHAR(50) PRIMARY KEY,
    BranchCity VARCHAR(50),
    Assets DECIMAL(15.0)
);
CREATE TABLE BankAccount (
    AccNo INT PRIMARY KEY,
    BranchName VARCHAR(50),
    Balance DECIMAL(15.2),
    FOREIGN KEY (BranchName) REFERENCES Branch1(BranchName)
);

CREATE TABLE BankCustomer (
    CustomerName VARCHAR(50) PRIMARY KEY,
    CustomerStreet VARCHAR(100),
    City VARCHAR(50)
);
CREATE TABLE Depositor (
    CustomerName VARCHAR(50),
    AccNo INT,
    PRIMARY KEY (CustomerName, AccNo),
    FOREIGN KEY (CustomerName) REFERENCES BankCustomer(CustomerName)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (AccNo) REFERENCES BankAccount(AccNo)
);
CREATE TABLE Loan (
    LoanNumber INT PRIMARY KEY,
    BranchName VARCHAR(50),
    Amount DECIMAL(15,2),
    FOREIGN KEY (BranchName) REFERENCES Branch1(BranchName)
);
desc branch1;
desc BankAccount;
desc loan;
desc depositor;
desc bankcustomer;

INSERT INTO Branch1 VALUES 
('SBI_CHAMARAJAPETE', 'Bangalore', 50000),
('SBI_REDIDENCYROAD', 'Bangalore', 10000),
('SBI_SHIVAJIROAD', 'Chennai', 20000),
('SBI_Delhi', 'Delhi', 10000),
('SBI_JANTARMANTAR', 'Hyderabad', 20000);
SELECT * FROM BRANCH1;
 
INSERT INTO BankAccount VALUES 
(1, 'SBI_CHAMARAJAPETE', 20000),
(2, 'SBI_REDIDENCYROAD', 50000),
(3, 'SBI_SHIVAJIROAD', 60000),
(4, 'SBI_Delhi', 90000),
(5, 'SBI_JANTARMANTAR', 60000),
(6, 'SBI_SHIVAJIROAD',50000);
SELECT * FROM BankAccount;

INSERT INTO BankCustomer VALUES
('AVINASH', 'BULL_TEMPLE_ROAD', 'Bangalore'),
('DINESH', 'BANNERGATTA_ROAD', 'Bangalore'),
('MOHAN', 'NATINAL COLLEGE', 'Bangalore'),
('NIKIL', 'AKBAR_ROAD', 'Delhi'),
('RAVI', 'PRITHUIRAJ_ROAD', 'DELHI');
SELECT * FROM BANKCUSTOMER;

INSERT INTO Depositor VALUES
('AVINASH', 1),
('DINESH', 2),
('MOHAN',3),
('NIKIL', 5),
('RAVI', 4);


INSERT INTO Loan VALUES
(1, 'SBI_CHAMARAJAPETE', 10000),
(2, 'SBI_REDIDENCYROAD', 20000),
(3, 'SBI_SHIVAJIROAD', 30000),
(4, 'SBI_JANTARMANTAR', 40000),
(5, 'SBI_SHIVAJIROAD', 50000);

SELECT BRANCHNAME,(ASSETS/3000) AS "ASSETS IN LAKHS" FROM BRANCH1;

SELECT d.CustomerName, b.BranchName, COUNT(*) AS No_of_Accounts
FROM Depositor d
JOIN BankAccount b ON d.AccNo = b.AccNo
GROUP BY d.CustomerName, b.BranchName
HAVING COUNT(*) >= 2 AND b.BranchName = 'SBI_SHIVAJIROAD';


SELECT d.CustomerName, a.BranchName
FROM Depositor d
JOIN BankAccount a ON d.AccNo = a.AccNo
GROUP BY d.CustomerName, a.BranchName
HAVING COUNT(d.AccNo) >=2  ;



CREATE VIEW BRANCHLOANSUM AS SELECT BRANCHNAME,SUM(AMOUNT) AS TOTALAMOUNT FROM LOAN group by BRANCHNAME;

select * FROM BRANCHLOANSUM;

SELECT DISTINCT d.CustomerName
FROM Depositor d
JOIN BankAccount b ON d.AccNo = b.AccNo
JOIN Branch1 br ON b.BranchName = br.BranchName
WHERE br.BranchCity = 'Delhi';

SELECT DISTINCT bc.CustomerName
FROM BankCustomer bc
WHERE bc.CustomerName NOT IN (SELECT CustomerName FROM Depositor)
AND bc.CustomerName IN (
    SELECT DISTINCT bc2.CustomerName
    FROM BankCustomer bc2, Loan l, Branch1 br
    WHERE l.BranchName = br.BranchName
);

SELECT DISTINCT d.CustomerName
FROM Depositor d
JOIN BankAccount b ON d.AccNo = b.AccNo
JOIN Branch1 br ON b.BranchName = br.BranchName
WHERE br.BranchCity = 'Bangalore'
AND d.CustomerName IN (
    SELECT DISTINCT bc.CustomerName
    FROM BankCustomer bc, Loan l, Branch1 br2
    WHERE br2.BranchName = l.BranchName
    AND br2.BranchCity = 'Bangalore'
);
SELECT BranchName
FROM Branch1
WHERE Assets > ALL (
    SELECT Assets
    FROM Branch1
    WHERE BranchCity = 'Bangalore'
);
DELETE FROM BankAccount
WHERE BranchName IN (
    SELECT BranchName
    FROM Branch1
    WHERE BranchCity = 'Dehli'
);
SELECT * FROM BANKCUSTOMER;

UPDATE BankAccount
SET Balance = Balance + (Balance * 0.5)
WHERE BranchName = 'SBI_SHIVAJIROAD';

select * from bankaccount;













