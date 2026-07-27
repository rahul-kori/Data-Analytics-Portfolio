/* SQL Analytics */

-- Sales Analysis

-- Overall Sales Performance
-- Executive summary of overall sales performance
SELECT
SUM(Sales) AS total_sales,
COUNT(DISTINCT Order_ID) AS total_orders,
COUNT(DISTINCT Customer_ID) AS total_customers,
SUM(Quantity) AS total_quantity
FROM clean.sales_orders;

-- Sales by Category
-- Compare revenue contribution across product categories
SELECT
Category,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY category
ORDER BY total_sales DESC;

-- Sales by Sub-Category
-- Identify top-performing product sub-categories
SELECT
Sub_Category,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Sub_Category
ORDER BY total_sales DESC;

-- Sales by Region
-- Compare sales performance across regions
SELECT
Region,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Region
ORDER BY total_sales DESC;

-- Top 10 States by Sales
-- Highlight highest revenue generating states
SELECT TOP (10)
State,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY State
ORDER BY total_sales DESC;

-- Top 10 Cities by Sales
-- Identify cities contributing the highest sales
SELECT TOP (10)
City,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY City
ORDER BY total_sales DESC;

-- Monthly Sales Trend
-- Track monthly sales performance over time
SELECT
YEAR(Order_Date) AS sales_year,
MONTH(Order_Date) AS sales_month,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY sales_year, sales_month;

-- Average Sales per Order
-- Measure average revenue generated per order
SELECT
SUM(Sales) / COUNT(DISTINCT Order_ID) AS average_order_value
FROM clean.sales_orders;

