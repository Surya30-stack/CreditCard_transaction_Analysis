create schema credit_Transaction;
Use credit_Transaction;

SET GLOBAL max_allowed_packet = 1073741824;  
SET GLOBAL net_read_timeout = 800;  
SET GLOBAL net_write_timeout = 800; 
SET GLOBAL wait_timeout = 800;
SET GLOBAL interactive_timeout = 800;



CREATE TABLE Transactions (
    Full_Name VARCHAR(255),
    dob DATE,
    gender VARCHAR(10),
    job VARCHAR(255),
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(10),
    zip VARCHAR(10),
    cc_num BIGINT,
    category VARCHAR(100),
    amt DECIMAL(10,2),
    Date date,
    Time time,
    lat DECIMAL(10,6),
    longitude DECIMAL(10,6),
    city_pop int,
    trans_num varchar(255),
    merchant VARCHAR(255),
    unix_time BIGINT,
    Time_U time,
    merch_lat DECIMAL(10,6),
    merch_long DECIMAL(10,6),
    is_fraud TINYINT,
    merch_zipcode VARCHAR(10)
);
LOAD DATA INFILE "D:\\Surya\\Office and resume\\Programming study material\\Projects\\Transactions.csv"
INTO TABLE Transactions
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS  
(Full_Name, dob, gender, job, street, city, state, zip, cc_num, category, amt, Date, Time, lat, longitude, city_pop, trans_num, merchant, unix_time, Time_U, merch_lat, merch_long, is_fraud, merch_zipcode);

SELECT * FROM Transactions
limit 10;
SELECT count(*) as Total_Transactions from transactions;
SELECT 
    COUNT(DISTINCT full_name) AS Total_cc_holders,
    COUNT(DISTINCT category) AS Total_categories
FROM transactions;

SELECT category, COUNT(*) AS category_count
FROM transactions
GROUP BY category
ORDER BY category_count DESC;


#DATA CLEANING:

#since merch_zipcode column has null values we can drop the column  
alter table transactions drop column merch_zipcode;
# Data type of each column 
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Transactions'
ORDER BY ORDINAL_POSITION;

#DATA TRANSFORMATION FOR ANALYSIS:

#to calculate the age of the cc holder for analysis
ALTER TABLE transactions
ADD COLUMN age INT;
UPDATE transactions
SET age = FLOOR(DATEDIFF(CURDATE(), DOB) / 365.25)
WHERE DOB IS NOT NULL;
SELECT full_name, dob, age FROM transactions
GROUP BY full_name, dob, age;
#total spending per customer:
SELECT full_name AS CC_holder, FLOOR(SUM(amt)) AS total_spending
FROM transactions
GROUP BY full_name
ORDER BY total_spending DESC;
#transaction frequency per customer:
SELECT full_name, COUNT(*) AS transaction_frequency
FROM transactions
GROUP BY full_name
ORDER BY transaction_frequency DESC;

#EXPLORATORY DATA ANALYSIS:

#Calculate Mode (Most frequent value)
SELECT amt, COUNT(*) AS frequency
FROM transactions
GROUP BY amt
ORDER BY frequency DESC
LIMIT 1;

#Calculate Standard Deviation
SELECT STDDEV(amt) AS standard_deviation
FROM transactions;

#avg spending amt:
SELECT avg(amt) from transactions;

# Top Spending Categories by Transaction Volume & Amount:
SELECT category, 
       COUNT(*) AS transaction_volume, 
       SUM(amt) AS total_spending
FROM transactions
GROUP BY category
ORDER BY total_spending DESC;  

# Spending Trends - Daily:
SELECT DATE(date) AS Date, 
       SUM(amt) AS total_spending
FROM transactions
GROUP BY Date
ORDER BY Date;
# Spending Trends - weekly:
SELECT yearweek(date) AS week, 
       SUM(amt) AS total_spending
FROM transactions
GROUP BY week
ORDER BY week;

# Peak Spending Hours in a Day:
SELECT HOUR(time) AS hour, 
       SUM(amt) AS total_spending
FROM transactions
GROUP BY hour
ORDER BY total_spending DESC;

#Group by Age and Show Total Transaction Amount:
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    SUM(amt) AS total_spending,
    COUNT(*) AS transaction_count
FROM transactions
WHERE age IS NOT NULL
GROUP BY age_group
ORDER BY age_group;

# Merchants Have the Highest Transactions:
SELECT merchant, 
       COUNT(*) AS transaction_count, 
       SUM(amt) AS total_spending
FROM transactions
GROUP BY merchant
ORDER BY transaction_count DESC; 

#Customer Segments: High Spenders vs. Low Spenders:
SELECT Full_Name, 
       SUM(amt) AS total_spending,
       CASE 
           WHEN SUM(amt) > (SELECT AVG(total_spending) FROM 
                                (SELECT Full_Name, SUM(amt) AS total_spending 
                                 FROM transactions 
                                 GROUP BY Full_Name) AS subquery) THEN 'High Spender'
           ELSE 'Low Spender'
       END AS spending_segment
FROM transactions
GROUP BY Full_name
ORDER BY total_spending DESC;

#Compare Spending Before and After Payday:
SELECT 
    CASE 
        WHEN DAY(date) BETWEEN 1 AND 5 THEN 'After Payday'
        WHEN DAY(date) BETWEEN 26 AND 31 THEN 'Before Payday'
        ELSE 'Other'
    END AS spending_period,
    SUM(amt) AS total_spending,
    COUNT(*) AS transaction_count,
    AVG(amt) AS avg_transaction_value
FROM transactions
WHERE DAY(date) BETWEEN 1 AND 5 
   OR DAY(date) BETWEEN 26 AND 31
GROUP BY spending_period
ORDER BY FIELD(spending_period, 'Before Payday', 'After Payday');

#any trends among high-frequency customers:
#high freq customers:
WITH transactions AS (
    SELECT Full_name, COUNT(*) AS transaction_count
    FROM transactions
    GROUP BY Full_name
)
SELECT Full_name
FROM transactions
WHERE transaction_count > 2000; 

#Spending Habits of High-Frequency Customers:
WITH HighFrequencyCustomers AS (
    SELECT Full_Name
    FROM (
        SELECT Full_Name, COUNT(*) AS transaction_count
        FROM transactions
        GROUP BY Full_Name
    ) AS CustomerTransactionCount
    WHERE transaction_count > 2000  
)
SELECT 
    hfc.Full_Name,
    SUM(t.amt) AS total_spending,
    AVG(t.amt) AS avg_transaction_value,
    COUNT(t.amt) AS total_transactions
FROM transactions t
JOIN HighFrequencyCustomers hfc ON t.Full_Name = hfc.Full_Name
GROUP BY hfc.Full_Name
ORDER BY total_spending DESC;

#Types of Merchants High-Frequency Customers Visit:
WITH HighFrequencyCustomers AS (
    SELECT Full_Name
    FROM (
        SELECT Full_Name, COUNT(*) AS transaction_count
        FROM transactions
        GROUP BY Full_Name
    ) AS CustomerTransactionCount
    WHERE transaction_count > 2000  
)
SELECT 
    t.merchant, 
    COUNT(*) AS transaction_count,
    SUM(t.amt) AS total_spending,
    AVG(t.amt) AS avg_transaction_value
FROM transactions t
JOIN HighFrequencyCustomers hfc ON t.Full_Name = hfc.Full_Name
GROUP BY t.merchant
ORDER BY total_spending DESC;







#FRAUD DETECTION:
#Fraud Detection Methods Using UNIX Time
SELECT 'No user has more than 5 transactions in the last 10 minutes' AS Message, 0 AS Transaction_Count
UNION
SELECT Full_name, COUNT(*) AS Transaction_Count
FROM Transactions
WHERE Unix_Time BETWEEN 
      (SELECT COALESCE(MAX(Unix_Time), 0) - 600 FROM Transactions) 
      AND (SELECT COALESCE(MAX(Unix_Time), 0) FROM Transactions)
GROUP BY Full_name
HAVING COUNT(*) > 5;

# Transactions at Unusual Hours:
SELECT T.Full_name, 
       T.merchant, 
       T.Time, 
       C.transaction_count
FROM Transactions T
JOIN (
    SELECT Full_name, COUNT(*) AS transaction_count
    FROM Transactions
    WHERE HOUR(Time) BETWEEN 0 AND 5
    GROUP BY Full_name
) C
ON T.Full_name = C.Full_name
WHERE HOUR(T.Time) BETWEEN 0 AND 5
ORDER BY C.transaction_count DESC, T.Full_name, T.Time;

#High-Value Purchases Not Matching Normal Spending Behavior
WITH Avg_Spending_CTE AS (
    SELECT Full_name, AVG(amt) AS Avg_Spending
    FROM Transactions
    GROUP BY Full_name
)
SELECT t1.Full_name, t1.Merchant, t1.amt, cte.Avg_Spending
FROM Transactions t1
JOIN Avg_Spending_CTE cte ON t1.Full_name = cte.Full_name
WHERE t1.amt > (cte.Avg_Spending * 5);

#total fraud trnsactions by customers:
SELECT 
    Full_name, 
    COUNT(*) AS fraud_count
FROM transactions
WHERE is_fraud = 1
GROUP BY Full_name
ORDER BY fraud_count DESC;



truncate transactions;




