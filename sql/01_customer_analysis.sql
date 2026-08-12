USE bank_customer_analytics;

DROP TABLE IF EXISTS bank_customers;

CREATE TABLE bank_customers (
    CreditScore INT,
    Geography VARCHAR(20),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance DECIMAL(15,2),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary DECIMAL(15,2),
    Exited INT
);
SHOW TABLES;
DESCRIBE bank_customers;
LOAD DATA LOCAL INFILE 'D:/Projects/Bank Customer Descriptive Analytics/data/processed/bank_customer_analysis.csv'
INTO TABLE bank_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'D:/Projects/Bank Customer Descriptive Analytics/data/processed/bank_customer_analysis.csv'
INTO TABLE bank_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_customers
FROM bank_customers;

SELECT *
FROM bank_customers
LIMIT 5;

USE bank_customer_analytics;


SELECT 
    COUNT(*) AS total_customers
FROM bank_customers;

SELECT
    CASE
        WHEN Exited = 1 THEN 'Exited Customer'
        ELSE 'Existing Customer'
    END AS customer_status,
    COUNT(*) AS customers
FROM bank_customers
GROUP BY Exited
ORDER BY Exited;

SELECT 
    COUNT(*) AS total_customers
FROM bank_customers;

SELECT
    CASE
        WHEN Exited = 1 THEN 'Exited Customer'
        ELSE 'Existing Customer'
    END AS customer_status,
    COUNT(*) AS customers
FROM bank_customers
GROUP BY Exited
ORDER BY Exited;

SELECT
    ROUND(AVG(Exited) * 100, 2) AS attrition_rate
FROM bank_customers;


SELECT
    Geography,
    COUNT(*) AS customers,
    SUM(Exited) AS exited_customers,
    ROUND(AVG(Exited) * 100, 2) AS attrition_rate
FROM bank_customers
GROUP BY Geography
ORDER BY attrition_rate DESC;


SELECT
    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS activity_status,
    COUNT(*) AS customers,
    SUM(Exited) AS exited_customers,
    ROUND(AVG(Exited) * 100, 2) AS attrition_rate
FROM bank_customers
GROUP BY IsActiveMember
ORDER BY attrition_rate DESC;


SELECT
    NumOfProducts,
    COUNT(*) AS customers,
    SUM(Exited) AS exited_customers,
    ROUND(AVG(Exited) * 100, 2) AS attrition_rate
FROM bank_customers
GROUP BY NumOfProducts
ORDER BY NumOfProducts;


SELECT
    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance < 50000 THEN '<50K'
        WHEN Balance < 100000 THEN '50K-100K'
        WHEN Balance < 150000 THEN '100K-150K'
        ELSE '150K+'
    END AS balance_segment,
    COUNT(*) AS customers,
    SUM(Exited) AS exited_customers,
    ROUND(AVG(Exited) * 100, 2) AS attrition_rate
FROM bank_customers
GROUP BY
    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance < 50000 THEN '<50K'
        WHEN Balance < 100000 THEN '50K-100K'
        WHEN Balance < 150000 THEN '100K-150K'
        ELSE '150K+'
    END
ORDER BY attrition_rate DESC;




SELECT
    Geography,
    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS activity_status,
    COUNT(*) AS customers,
    SUM(Exited) AS exited_customers,
    ROUND(AVG(Exited) * 100, 2) AS attrition_rate
FROM bank_customers
GROUP BY
    Geography,
    IsActiveMember
ORDER BY
    attrition_rate DESC;


SELECT
    Geography,
    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS activity_status,
    CASE
        WHEN Age >= 51 THEN '51+'
        WHEN Age >= 41 THEN '41-50'
        ELSE '18-40'
    END AS age_group,
    COUNT(*) AS customers,
    SUM(Exited) AS exited_customers,
    ROUND(AVG(Exited) * 100, 2) AS attrition_rate
FROM bank_customers
GROUP BY
    Geography,
    IsActiveMember,
    CASE
        WHEN Age >= 51 THEN '51+'
        WHEN Age >= 41 THEN '41-50'
        ELSE '18-40'
    END
HAVING COUNT(*) >= 50
ORDER BY attrition_rate DESC;