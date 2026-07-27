Data Profiling
Data Profiling is the first technical step after understanding the dataset.

The goal is not to clean the data, but to measure and document its quality before making any changes.

In a real company, analysts profile data before writing business queries to identify potential issues that could affect reporting accuracy.


Data Profiling 	Report
1. Profiling 	Scope
Database: 	Sales_Analytics_DB
Table: 		sales_orders
Data Source: 	Kaggle Superstore Dataset
Profiling Date: Project Execution Date

2. Profiling Checklist
Check				            
Total Row Count			    
Total Column Count		
Data Types			
NULL Value Analysis		
Duplicate Record Check		
Primary Key Validation		
Customer ID Validation		
Product ID Validation		
Date Range Analysis		
Numeric Field Validation	
Category Distribution		
Region Distribution		
Business Rule Validation	


1. Data Profiling Check: Total Row Count

SELECT COUNT(*) AS Total_Row_Count
FROM raw.sales_orders;

Total Records: 9,994 rows


2. Data Profiling Check: Total Column Count

SELECT COUNT(*) AS total_columns_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'raw'
AND TABLE_NAME = 'sales_orders';

Total Columns: 21


3. Data Profiling Check: Column Data Type Validation

SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'raw'
AND TABLE_NAME = 'sales_orders'
ORDER BY ORDINAL_POSITION;

Result: All Columns contain nvarchar datatypes


4. Data Profiling Check: NULL Value Analysis

SELECT
SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS profit_nulls
FROM raw.sales_orders;

Result:
customer_id	customer_id	product_id	sales	profit
0		0		0		0	0


5. Data Profiling Check: Duplicate Records Analysis

SELECT
Row_ID,
COUNT(*) AS duplicate_count
FROM raw.sales_orders
GROUP BY Row_ID
HAVING COUNT(*) > 1;

SELECT 
    *,
    COUNT(*) AS Duplicate_Count
FROM raw.sales_orders
GROUP BY 
    Row_ID,
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit
HAVING COUNT(*) > 1;

Result : Zero duplicate record found


6. Data Profiling Check: Primary Key Validation

-- Primary Key Duplicate Check
SELECT 
Row_ID,
COUNT(*) AS Record_Count
FROM raw.sales_orders
GROUP BY Row_ID
HAVING COUNT(*) > 1;

-- Primary Key NULL Check
SELECT 
COUNT(*) AS Null_Primary_Key_Count
FROM raw.sales_orders
WHERE Row_ID IS NULL;

-- Total Unique Primary Key Count Validatio
SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT Row_ID) AS unique_row_ids
FROM raw.sales_orders;

Result:
Primary Key Column: Row_ID
Duplicate Values: Zero
NULL Values: zero
Unique_Row_ID_Count : 9994

7. Data Profiling Check: Customer Key Validation
SELECT 
Customer_ID,
COUNT(*) AS Order_Count
FROM raw.sales_orders
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Unique Customer Count Check
SELECT 
COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM raw.sales_orders;

-- Customer Key Quality Check 
SELECT
COUNT(*) AS Total_Transactions,
COUNT(DISTINCT Customer_ID) AS Unique_Customers,
COUNT(*) - COUNT(Customer_ID) AS Missing_Customer_ID
FROM raw.sales_orders;

Result:	
Total Transactions:9994
Unique Customers: 793	
Missing Customer IDs : 0

8. Data Profiling Check: Product Key Validation
Objective:
To validate the completeness and reliability of the product identifier for product-level sales analysis.

SELECT 
Product_ID,
COUNT(*) AS Order_Frequency
FROM raw.sales_orders
GROUP BY Product_ID
HAVING COUNT(*) > 1;

-- Unique Product Count Validation
SELECT 
COUNT(DISTINCT Product_ID) AS Unique_Product_Count
FROM raw.sales_orders;

-- Product Key Completeness Check
SELECT
COUNT(*) AS Total_Transactions,
COUNT(DISTINCT Product_ID) AS Unique_Products,
COUNT(*) - COUNT(Product_ID) AS Missing_Product_ID
FROM raw.sales_orders;

Result:	
Total Transactions: 9994
Unique Customers: 1862	
Missing Customer IDs : 0


9. Date Analysis 

-- Date Format Check
-- Order_Date
SELECT
Row_ID,
Order_Date,
TRY_CONVERT(DATE, Order_Date)
FROM raw.sales_orders
WHERE TRY_CONVERT(DATE, Order_Date) IS NULL;

-- Ship_Date
SELECT
Row_ID,
Ship_Date,
TRY_CONVERT(DATE, Ship_Date)
FROM raw.sales_orders
WHERE TRY_CONVERT(DATE, Ship_Date) IS NULL;

-- Date Range Analysis
SELECT
MIN(TRY_CONVERT(DATE, Order_Date)) AS first_order_date,
MAX(TRY_CONVERT(DATE, Order_Date)) AS last_order_date,
MIN(TRY_CONVERT(DATE, Ship_Date)) AS first_ship_date,
MAX(TRY_CONVERT(DATE, Ship_Date)) AS last_ship_date
FROM raw.sales_orders;

-- Total Analysis Period (Years/Days)
SELECT
DATEDIFF(DAY, MIN(TRY_CONVERT(DATE, Order_Date)), MAX(TRY_CONVERT(DATE, Order_Date))) AS Total_Days_Covered
FROM raw.sales_orders;

Result:
Earliest Order Date:2014-01-03
Latest Order Date:2017-12-30
Analysis Period:1457 Days


10. Category Distribution
SELECT
Category,
COUNT(*) AS transaction_count
FROM raw.sales_orders
GROUP BY category
ORDER BY transaction_count DESC;

result:
Category	Record_Count	Percentage_Distribution
Office Supplies	6026		60.300000000000
Furniture	2121		21.220000000000
Technology	1847		18.480000000000

11. Region Distribution

-- Region Count Analysis
SELECT
Region,
COUNT(*) AS transaction_count
FROM raw.sales_orders
GROUP BY Region
ORDER BY transaction_count DESC;

-- Region Percentage Distribution
SELECT
Region,
COUNT(*) AS Record_Count,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM raw.sales_orders),2) AS Percentage_Distribution
FROM raw.sales_orders
GROUP BY Region
ORDER BY Percentage_Distribution DESC;

Result:
Region	Record_Count	Percentage_Distribution
West	3203		32.050000000000
East	2848		28.500000000000
Central	2323		23.240000000000
South	1620		16.210000000000














