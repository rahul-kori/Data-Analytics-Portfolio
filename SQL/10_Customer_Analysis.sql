/* SQL Analytics */

-- Customer Analysis

-- Customer Performance Summary
-- Summarize business performance by customer
SELECT
Customer_ID,
Customer_Name,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
SUM(Quantity) AS total_quantity,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY Customer_ID, Customer_Name
ORDER BY total_sales DESC;

-- Top 10 Customers by Sale
-- Identify highest revenue generating customers
SELECT TOP (10)
Customer_ID,
Customer_Name,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Customer_ID, Customer_Name
ORDER BY total_sales DESC;

-- Top 10 Customers by Profit
-- Identify most profitable customers
SELECT TOP (10)
Customer_ID,
Customer_Name,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Customer_ID, Customer_Name
ORDER BY total_profit DESC;

-- Sales by Customer Segment
-- Compare sales across customer segments
SELECT
Segment,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Customer_ID) AS total_customers
FROM clean.sales_orders
GROUP BY Segment
ORDER BY total_sales DESC;

-- Average Revenue per Customer
-- Measure average revenue generated per customer
SELECT
SUM(Sales) / COUNT(DISTINCT Customer_ID) AS average_customer_revenue
FROM clean.sales_orders;

-- Customers with Negative Profit
-- Identify customers with negative overall profitability
SELECT
Customer_ID,
Customer_Name,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY
Customer_ID, Customer_Name
HAVING SUM(Profit) < 0
ORDER BY total_profit;

-- Customers by Region
-- Analyze customer distribution by region
SELECT
Region,
COUNT(DISTINCT Customer_ID) AS total_customers
FROM clean.sales_orders
GROUP BY Region
ORDER BY total_customers DESC;

-- Repeat Purchase Analysis
-- Identify customers with the highest purchase frequency
SELECT TOP (10)
Customer_ID,
Customer_Name,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY Customer_ID, Customer_Name
ORDER BY total_orders DESC;

