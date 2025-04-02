# Spending Habits Analysis|Credit card transaction

## Introduction
In today's world Credit card transaction analysis is crucial for understanding spending behaviors, detecting fraudulent activities, and optimizing financial decisions based on the given category of data's. In this project I used Excel, SQL and Power BI to analyze credit card transaction data, focusing on customer demographics, transaction trends, extracting key performance indicators (KPIs) and also uncovering valuable trends in customer segmentation.

## Project Objectives:
Clean and Transform Data : Prepare the raw data for analysis by converting data types,removing duplicates,ransaction dates and times into appropriate formats and                              transforming dataas required.
Analyze Spending Behavior: Calculate total transaction amount, top speending categories, and transaction amount on a daily/weekly basis.
Segment and Compare Data : Analyze transaction based on high spenders vs low spenders,product category and based on location
Anomaly Detection : Identify unusual spending behaviors and potential fraud.

## Process:
The Credit card transaction data can be downloaded [here.](https://www.kaggle.com/datasets/priyamchoksi/credit-card-transactions-dataset/data). The total number of rows were 13,00,354.
### Key Steps in Data Transformation:
#### Data cleaning & formatting:
To process and clean the data, I picked Excel using Power Qwery.
Initially I done mergeing the required columns in the power query and decreased the total number of columns. THe change the data type of few columns which were not correct followed by removing duplicates and NULL values in the table. With the help of add column in the query I separated the date/time column and assigned the required data type for the fields. Deleted Unwanted rows which is irrelevant for the analysis. The image of the entire process is addded below 
![image](https://github.com/Surya30-stack/CreditCard_transaction_Analysis/blob/main/Excel%20Data%20Cleaning%20process.png?raw=true)  

#### Feature Engineering:
I used SQL Data Manipulation (CRUD Operations) ,Transformation Aggregate Functions (SUM, COUNT, AVG),Time Functions Conditional Logic (CASE statements) Grouping and Ordering Data. In this Creating new columns based on existing data I added a new age column into the table which is very usefull in analysis. And I Generated aggregates to find the transaction frequency per customer and total spending per customer.
At the end of this process the total number of rows have been reduced to 10,48,575.

## Exploratory Data analysis:
I used both SQL and Python for analysis.

1.Top Spending Categories by Transaction Volume & Amount:
We’ll calculate both Transaction Volume (Total number of transactions per category) and Total Amount Spent (Sum of all transaction amounts per category).
### Insights:
#### Highest Transaction Volume:
Gas & Transport has the highest number of transactions (1,06,430), indicating frequent spending, possibly on fuel or transportation services.
#### Highest Total Spending:
Grocery (POS) leads in total spending (~$11.68M), making it a major expense category.
#### Shopping Trends:
Shopping (POS) has more transactions (94,353) than Shopping (Net) (78,899), but a lower total spend.
This suggests that online purchases might have higher average transaction values.
#### Travel-related Expenses:
Travel spending is low as ($3.65M) but has fewer transactions compared to other categories.
This indicates customers don't use credit card for travel related transactions.

2.How Spending Varies Over Time (Daily, Weekly):
Analyze the spending pattern using time-based aggregations,
### Insights:
#### Daily Trends Observations:
Spending follows a clear cyclical pattern, indicating periodic peaks and dips.There is a noticeable spike around late 2019 to early 2020, possibly due to seasonal events like holidays or major purchases.Post-peak, spending decreases but retains some periodic fluctuations.
#### Seasonal Trends:
A significant spike at the start of 2020 suggests a holiday or year-end effect.The overall trend shows growth in spending over time, with fluctuations becoming more pronounced.

3.Peak Spending Hours in a Day:
### Insights:
Peak spending occurs between 10 PM - 11 PM, likely due to online shopping or bill payments. Spending gradually increases from 12 PM onwards, indicating more retail and entertainment transactions. Lowest spending happens between 4 AM - 8 AM, aligning with sleeping hours. Evening hours drive the most transactions, making it the prime spending period.





