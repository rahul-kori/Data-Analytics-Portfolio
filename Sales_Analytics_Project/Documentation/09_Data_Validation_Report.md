Data Validation
Data Validation verifies whether the data complies with business rules and is suitable for analysis. Unlike Data Profiling (which identifies what exists), Data Validation determines whether the data is correct, complete, and trustworthy.

At the end of this step, we'll know exactly what needs to be cleaned in Step 10: Data Cleaning SOP

Objective
Data Validation verifies whether the data complies with business rules and is suitable for analysis. Unlike Data Profiling (which identifies what exists), Data Validation determines whether the data is correct, complete, and trustworthy.
At the end of this step, we'll know exactly what needs to be cleaned in Step 10: Data Cleaning SOP.

Data Validation Report
1. Validation Scope
Field			Value
Database		Sales_Analytics_DB
Table			sales_orders
Validation Owner	Data Analyst
Validation Status	In Progress

2. Validation Rules
Validation ID	Validation Rule					Business Reason						Priority
DV-01		row_id must be unique				Prevent duplicate transactions				High
DV-02		customer_id must not be NULL			Customer analysis depends on it				High
DV-03		product_id must not be NULL			Product analysis depends on it				High
DV-04		sales must be greater than or equal to 0	Revenue cannot be negative				High
DV-05		quantity must be greater than 0	Zero or 	negative quantity is invalid				High
DV-06		discount must be between 0 and 1		Dataset stores discounts as percentages			High
DV-07		order_date must be before or equal to ship_date	Orders cannot ship before being placed			High
DV-08		region must not be NULL				Regional reporting depends on it			Medium
DV-09		category must not be NULL			Product reporting depends on it				Medium
DV-10		profit can be positive or negative		Loss-making orders are valid				Informational

3. SQL Validation Checks
DV-01: Duplicate Row ID
Business Purpose: Ensure every transaction record is unique.

SELECT
Row_ID,
COUNT(*) AS duplicate_count
FROM raw.sales_orders
GROUP BY Row_ID
HAVING COUNT(*) > 1;
Result: 0 duplicate records

DV-02: Missing Customer IDs
SELECT COUNT(*) AS missing_customer_ids
FROM raw.sales_orders
WHERE Customer_ID IS NULL;
Result: 0

DV-03: Missing Product IDs
SELECT COUNT(*) AS missing_product_ids
FROM raw.sales_orders
WHERE Product_ID IS NULL;
Result: 0

DV-04: Invalid Sales Values
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(12,5), Sales) < 0;
Result: No rows returned

DV-05: Invalid Quantity
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(INT, Quantity) <= 0;
Result: No rows returned

DV-06: Invalid Discount Values
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(12,5), Discount) < 0 
OR TRY_CONVERT(DECIMAL(12,5), Discount) > 1;
Result: No rows returned

DV-07: Invalid Order & Ship Dates
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DATE, Order_Date) > TRY_CONVERT(DATE,Ship_Date);Result: No rows returned

DV-08: Missing Region
SELECT COUNT(*) AS missing_regions
FROM raw.sales_orders
WHERE Region IS NULL;
Result: 0

DV-09: Missing Category
SELECT COUNT(*) AS missing_categories
FROM raw.sales_orders
WHERE Category IS NULL;
Result: 0

DV-10: Profit Validation
SELECT *
FROM raw.sales_orders
WHERE TRY_CONVERT(DECIMAL(18,2), Profit) < 0;
Business Note: Negative profit values are valid because they represent loss-making transactions.


