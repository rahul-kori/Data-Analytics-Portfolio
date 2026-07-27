/* Data Cleaning */

-- Duplicate Records
SELECT
Row_ID,
COUNT(*) AS duplicate_count
FROM raw.sales_orders
GROUP BY Row_ID
HAVING COUNT(*) > 1;

-- Missing Values
SELECT
SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS customer_nulls,
SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS product_nulls,
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS profit_nulls
FROM raw.sales_orders;

-- Data Type Standardization
SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'raw'
AND TABLE_NAME = 'sales_orders'
ORDER BY ORDINAL_POSITION;


-- Datatype to be fixed
/*
 Column      Required Type 
 Order Date  DATE          
 Ship Date   DATE          
 Sales       DECIMAL       
 Profit      DECIMAL       
 Quantity    INT           
 Discount    DECIMAL       
*/

-- FIX Date Datatype
SELECT
Order_Date,
TRY_CONVERT(DATE,Order_Date)
FROM raw.sales_orders;

SELECT
Ship_Date,
TRY_CONVERT(DATE,Ship_Date)
FROM raw.sales_orders;

-- FIX Numeric Fields Datatypes
SELECT
Sales,
TRY_CONVERT(DECIMAL(12,5),Sales)
FROM raw.sales_orders;

SELECT
Profit,
TRY_CONVERT(DECIMAL(12,5),Profit)
FROM raw.sales_orders;

SELECT
Quantity,
TRY_CONVERT(INT,Quantity)
FROM raw.sales_orders;

SELECT
Discount,
TRY_CONVERT(DECIMAL(5,2),Discount)
FROM raw.sales_orders;


-- Date Validation
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DATE,Order_Date) > TRY_CONVERT(DATE,Ship_Date);

-- Numeric Value Validation
SELECT *
FROM raw.sales_orders
WHERE Try_CONVERT(DECIMAL(12,5),Sales) < 0
OR TRY_CONVERT(INT,Quantity) <= 0
OR TRY_CONVERT(DECIMAL(5,2), Discount) < 0
OR TRY_CONVERT(DECIMAL(5,2), Discount) > 1;

-- Text Standardization
SELECT 
DISTINCT(Region)
FROM raw.sales_orders;

SELECT 
DISTINCT(Category)
FROM raw.sales_orders;

SELECT 
DISTINCT(Sub_Category)
FROM raw.sales_orders;

SELECT 
DISTINCT(Segment)
FROM raw.sales_orders;

SELECT 
DISTINCT(Ship_Mode)
FROM raw.sales_orders;

-- Business Key Validation
SELECT
Customer_ID,
Product_ID,
Order_ID
FROM raw.sales_orders;





