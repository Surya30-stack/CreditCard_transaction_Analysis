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
To process and clean the data, I picked Excel using Power Query.
Initially I done mergeing the required columns in the power query and decreased the total number of columns. Then I changed the data type of few columns which were not correct followed by removing duplicates and NULL values in the table. With the help of add column in the query I separated the date/time column and assigned the required data type for the fields. Deleted Unwanted rows which is irrelevant for the analysis. The image of the entire process is addded below 
![image](https://github.com/Surya30-stack/CreditCard_transaction_Analysis/blob/main/Excel%20Data%20Cleaning%20process.png?raw=true)  

#### Feature Engineering:
I used SQL Data Manipulation (CRUD Operations) ,Transformation Aggregate Functions (SUM, COUNT, AVG),Time Functions Conditional Logic (CASE statements) Grouping and Ordering Data. In this Creating new columns based on existing data I added a new age column into the table which is very usefull in analysis. And I Generated aggregates to find the transaction frequency per customer and total spending per customer.
At the end of this data cleaning and transformation process the total number of rows have been reduced to 10,48,575.

## Exploratory Data analysis EDA:
I used both SQL and Python for analysis.

1.Top Spending Categories by Transaction Volume & Amount:
We’ll calculate both Transaction Volume (Total number of transactions per category) and Total Amount Spent (Sum of all transaction amounts per category).
#### Insights:
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
#### Insights:
#### Daily Trends Observations:
Spending follows a clear cyclical pattern, indicating periodic peaks and dips.There is a noticeable spike around late 2019 to early 2020, possibly due to seasonal events like holidays or major purchases.Post-peak, spending decreases but retains some periodic fluctuations.
#### Seasonal Trends:
A significant spike at the start of 2020 suggests a holiday or year-end effect.The overall trend shows growth in spending over time, with fluctuations becoming more pronounced.

3.Peak Spending Hours in a Day:
#### Insights:
Peak spending occurs between 10 PM - 11 PM, likely due to online shopping or bill payments. Spending gradually increases from 12 PM onwards, indicating more retail and entertainment transactions. Lowest spending happens between 4 AM - 8 AM, aligning with sleeping hours. Evening hours drive the most transactions, making it the prime spending period.

4.Group by Age and Show Total Transaction Amount:
I grouped the age by 18-25,26-35,36-45,46-55,56+ by doing these I analysed that,
#### Insights:
Age more than 56+ has more transaction count and spending compared to others and the least of the both were by customers age around 18-25. By this we can conclude that card was mostly purchased by customers only after completing graduation or joining a job and the age of 56+ use a lot in grocery kind of category where it is difficult for them to go to store for purchase everytime.

5.Customer Segments: Based on Gender & High Spenders vs. Low Spenders:
#### Insights:
From the analysis it is clear that female users take about (54.5%) of total transaction amount and in High spender category they were about (55%) which is again higher than male. Top high spenders in females are Environmental consultant of about ($4,71,982).

6.Compare Spending Before and After Payday:
#### Insights:
Total spending is higher before payday than after payday, indicating that people tend to spend more when they anticipate their next paycheck.Average transaction amounts remain nearly the same before and after payday, suggesting spending habits per transaction are consistent.The surge in total spending before payday may reflect bill payments, necessary expenses, or impulse purchases before receiving the next paycheck.After payday, spending may drop as individuals regain financial stability and budget for upcoming expenses.

7.Spending Habits of High-Frequency Customers:
#### Insights:
By keeping a limit as above 2000 for high frequency customers we can analyse that their average transaction amount was in range of $46-$85 and their total spending was around $93000. By this we can see that high frequency customers usually keep them down in spending which eventually tend to increase the total number of transaction till the card limit.

8.Based Location_spending:
#### Insights:
In City-Level Spending Trends Houston, and Phoniex have the highest total spending. Spending is concentrated in a few key urban areas, indicating higher economic activity and in State-Level Spending Trends Texas (TX), California (CA), and Florida (FL) lead in total spending. Most of the transaction and high amount are from east and south side of North America.

## Fraud Detection:

1.Fraud Detection Methods Using UNIX Time:
The UNIX time in the data likely represents the exact time the transaction occurred at the merchant's system.This helps in tracking merchant-side transaction processing times, fraud detection, or reconciliation.
#### Insights:
Based on the Unix time I had set a limit that if transaction count exceeds 5 in 10 minutes gap that it is fruad alert but according to the given data there is no record according to this case statement.

2.Transactions at Unusual Hours:
I had set a limit that if transaction is done around 12am-5am in daily basis or most transaction it has a high chance to be fraud.
#### Insights:
Based on the above limit and from the output we can see that "Scott Martin" has done about 750 transactions from his 3697 transaction in these time which has a high chance of fraud transaction.

## Data Visualization:
I used PowerBI tool and created captivating visualizations to display the results of my analysis. Feel free to checkout my visualizations and insights.
[here.](https://app.powerbi.com/groups/me/reports/02693ce9-c452-4f34-ac0d-5a385bf59ef2/c252f4d208748936b8e6?redirectedFromSignup=1&experience=power-bi)


## Conclusion:
Through exploratory data analysis (EDA) on credit card transaction data, we uncovered key spending patterns, customer behaviors, and potential fraud indicators. The analysis revealed that Gas & Transport had the highest transaction volume, while Grocery (POS) led in total spending, indicating essential expenses drive significant card usage. Shopping behaviors highlighted a preference for online purchases with higher average transaction values. Peak spending hours were observed between 10 PM - 11 PM, with spending gradually increasing from midday. Older age groups (56+) showed the highest spending, particularly in grocery-related purchases, reflecting their reliance on credit cards for convenience. Demographic segmentation indicated that female users contributed to 54.5% of total spending and dominated the high-spender category. Spending behavior before and after payday revealed a surge in transactions before salary credits, suggesting financial anticipation influences spending patterns.Geographically, Texas, California, and Florida led in transaction volume and amount, with spending concentrated in key metropolitan areas.In terms of fraud detection, analyzing transaction timestamps helped flag unusual activity.
Overall, this analysis provides valuable insights into consumer behavior, spending trends, and fraud risks. It highlights the importance of understanding transaction patterns to enhance business strategies, optimize customer targeting, and improve fraud detection.










