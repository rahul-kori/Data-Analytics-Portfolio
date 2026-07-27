/* Data Cleaning & Create Analytics-Ready Clean Table */

-- Create Clean Table
CREATE TABLE clean.sales_orders(
Row_ID INT,
Order_ID VARCHAR(50),
Order_Date DATE,
Ship_Date DATE,
Ship_Mode VARCHAR(50),
Customer_ID VARCHAR(50),
Customer_Name VARCHAR(100),
Segment VARCHAR(50),
Country VARCHAR(100),
City VARCHAR(100),
State VARCHAR(100),
Postal_Code VARCHAR(20),
Region VARCHAR(50),
Product_ID VARCHAR(50),
Category VARCHAR(50),
Sub_Category VARCHAR(50),
Product_Name VARCHAR(225),
Sales DECIMAL(12,2),
Quantity INT,
Discount DECIMAL(5,2),
Profit DECIMAL(12,2)
);
GO

-- Insert Clean Data
INSERT INTO clean.sales_orders
(
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
)
SELECT
TRY_CONVERT(INT,Row_ID),
Order_ID,
TRY_CONVERT(DATE,Order_Date),
TRY_CONVERT(DATE,Ship_Date),
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
TRY_CONVERT(DECIMAL(12,2),Sales),
TRY_CONVERT(INT,Quantity),
TRY_CONVERT(DECIMAL(5,2),Discount),
TRY_CONVERT(DECIMAL(12,2),Profit)

FROM raw.sales_orders
WHERE 
Row_ID IS NOT NULL
AND Order_ID IS NOT NULL
AND Product_ID IS NOT NULL;

/* Validate Clean Table */

SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'clean'
AND TABLE_NAME = 'sales_orders'
ORDER BY ORDINAL_POSITION;

--  check Date
SELECT
Order_Date
FROM clean.sales_orders;


SELECT
Ship_Date,
TRY_CONVERT(DATE,Ship_Date)
FROM raw.sales_orders;


-- Date Validation
SELECT *
FROM clean.sales_orders
WHERE Order_Date > Ship_Date;

-- Numeric Value Validation
SELECT *
FROM clean.sales_orders
WHERE Sales < 0
OR Quantity <= 0
OR Discount < 0
OR Discount > 1;

-- Text Standardization
SELECT 
DISTINCT(Region)
FROM clean.sales_orders;

SELECT 
DISTINCT(Category)
FROM clean.sales_orders;

SELECT 
DISTINCT(Sub_Category)
FROM clean.sales_orders;

SELECT 
DISTINCT(Segment)
FROM clean.sales_orders;

SELECT 
DISTINCT(Ship_Mode)
FROM clean.sales_orders;

-- Business Key Validation
SELECT
Customer_ID,
Product_ID,
Order_ID
FROM clean.sales_orders;
