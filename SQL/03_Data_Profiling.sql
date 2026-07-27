/* Data Profiling */

-- Profiling Checklist 
/*
| Check                    
| Total Row Count          
| Total Column Count       
| Data Types               
| NULL Value Analysis      
| Duplicate Record Check   
| Primary Key Validation   
| Customer ID Validation   
| Product ID Validation    
| Date Range Analysis      
| Numeric Field Validation 
| Category Distribution    
| Region Distribution   
| Business Rule Validation 
*/


-- Row Count
SELECT COUNT(*) AS total_rows_count
FROM raw.sales_orders;

-- Column Count
SELECT COUNT(*) AS total_columns_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'raw'
AND TABLE_NAME = 'sales_orders';

-- Data Type Validation
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'raw'
AND TABLE_NAME = 'sales_orders'
ORDER BY ORDINAL_POSITION;

-- NULL Value Analysis
SELECT
SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS profit_nulls
FROM raw.sales_orders;

-- Duplicate Record Check
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

/*  Primary Key Validation */

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

/* Customer ID Validation */

-- Customer_ID NULL Check
SELECT 
COUNT(*) AS Null_Customer_ID_Count
FROM raw.sales_orders
WHERE Customer_ID IS NULL;

-- Customer_ID Duplicate Analysis
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

/* Product Key Validation */

-- Product_ID NULL Check
SELECT 
COUNT(*) AS Null_Product_ID_Count
FROM raw.sales_orders
WHERE Product_ID IS NULL;

-- Product_ID Duplicate Analysis
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



/* Date Analysis */
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

-- Numeric Fields 
SELECT
Row_ID,
Sales,
Quantity,
Discount,
Profit
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(18,2), Sales) IS NULL
OR TRY_CONVERT(INT, Quantity) IS NULL
OR TRY_CONVERT(DECIMAL(5,2), Discount) IS NULL
OR TRY_CONVERT(DECIMAL(18,2), Profit) IS NULL 

-- Numeric Field Validation
SELECT
MIN(TRY_CONVERT(DECIMAL(18,2), Sales)) AS min_sales,
MAX(TRY_CONVERT(DECIMAL(18,2), Sales)) AS max_sales,
MIN(TRY_CONVERT(DECIMAL(18,2), Profit)) AS min_profit,
MAX(TRY_CONVERT(DECIMAL(18,2), Profit)) AS max_profit,
MIN(TRY_CONVERT(INT, Quantity)) AS min_quantity,
MAX(TRY_CONVERT(INT, Quantity)) AS max_quantity,
MIN(TRY_CONVERT(DECIMAL(5,2), Discount)) AS min_discount,
MAX(TRY_CONVERT(DECIMAL(5,2), Discount)) AS max_discount
FROM raw.sales_orders;

/* Category Distribution */

--  Count Analysis
SELECT
Category,
COUNT(*) AS transaction_count
FROM raw.sales_orders
GROUP BY category
ORDER BY transaction_count DESC;

-- Category Percentage Distribution
SELECT
Category,
COUNT(*) AS Record_Count,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM raw.sales_orders),2) AS Percentage_Distribution
FROM raw.sales_orders
GROUP BY Category
ORDER BY Percentage_Distribution DESC;

/*  Region Distribution */

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


-- Business Rule Validation
/*                 
| Sales ≥ 0              
| Quantity > 0           
| Order Date ≤ Ship Date 
| Customer ID Present
| Product ID Present
| Region Present
*/
-- Sales ≥ 0 
SELECT 
TRY_CONVERT(DECIMAL(18,2), Sales) AS total_sales
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(18,2), Sales) >= 0;

-- Quantity > 0 
SELECT 
TRY_CONVERT(DECIMAL(18,2), Quantity) AS total_Quantity
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(18,2), Quantity) > 0;

-- Order Date ≤ Ship Date 
SELECT 
TRY_CONVERT(DATE, Order_Date) AS Order_Date,
TRY_CONVERT(DATE, Ship_Date) AS Ship_Date
FROM raw.sales_orders
WHERE TRY_CONVERT(DATE, Order_Date) <= TRY_CONVERT(DATE, Ship_Date);

-- Customer ID Present, Product ID Present, Region Present
SELECT
Customer_ID,
Product_ID,
Region
FROM raw.sales_orders;


