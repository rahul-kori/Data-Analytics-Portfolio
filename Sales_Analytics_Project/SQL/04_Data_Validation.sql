/* Data Validation */

-- Validation Checks

-- Duplicate Row ID
SELECT
Row_ID,
COUNT(*) AS duplicate_count
FROM raw.sales_orders
GROUP BY Row_ID
HAVING COUNT(*) > 1;

-- Missing Customer IDs
SELECT COUNT(*) AS missing_customer_ids
FROM raw.sales_orders
WHERE Customer_ID IS NULL;

-- Missing Product IDs
SELECT COUNT(*) AS missing_product_ids
FROM raw.sales_orders
WHERE Product_ID IS NULL;

-- Invalid Order & Ship Dates
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DATE, Order_Date) > TRY_CONVERT(DATE,Ship_Date);

-- Missing Region
SELECT COUNT(*) AS missing_regions
FROM raw.sales_orders
WHERE Region IS NULL;

-- Missing Category
SELECT COUNT(*) AS missing_categories
FROM raw.sales_orders
WHERE Category IS NULL;

-- Invalid Sales Values
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(12,5), Sales) < 0;

-- Invalid Quantity
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(INT, Quantity) <= 0;

-- Invalid Discount Values
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(12,5), Discount) < 0 
OR TRY_CONVERT(DECIMAL(12,5), Discount) > 1;

-- Negative Profit Validation
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(18,2), Profit) < 0;

SELECT COUNT(*)
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(18,2), Profit) < 0;
