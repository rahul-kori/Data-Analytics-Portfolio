/* SQL Analytics */

-- Regional Analysis

-- Regional Performance Summary
-- Executive summary of regional business performance
SELECT
Region,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Order_ID) AS total_orders,
COUNT(DISTINCT Customer_ID) AS total_customers
FROM clean.sales_orders
GROUP BY Region
ORDER BY total_sales DESC;

-- State Performance
-- Compare business performance across states
SELECT
State,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY state
ORDER BY total_sales DESC;

-- City Performance
-- Evaluate sales and profitability by city
SELECT
City,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY City
ORDER BY total_sales DESC;

-- Top 10 Cities by Profit
-- Identify the most profitable cities
SELECT TOP (10)
City,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY City
ORDER BY total_profit DESC;

-- Bottom 10 Cities by Profit
-- Highlight cities requiring profitability review
SELECT TOP (10)
City,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY City
ORDER BY total_profit ASC;

-- Customer Distribution by Region
-- Measure customer coverage by region
SELECT
Region,
COUNT(DISTINCT Customer_ID) AS total_customers
FROM clean.sales_orders
GROUP BY Region
ORDER BY total_customers DESC;

-- Average Sales per Customer by Region
-- Measure average customer revenue by region
SELECT
Region,
SUM(Sales) / COUNT(DISTINCT Customer_ID) AS average_sales_per_customer
FROM clean.sales_orders
GROUP BY Region
ORDER BY average_sales_per_customer DESC;

-- Regional Profit Margin
-- Compare regional profitability as a percentage of sales
SELECT
Region,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
(SUM(Profit) * 100.0) / SUM(Sales) AS profit_margin_percent
FROM clean.sales_orders
GROUP BY Region
ORDER BY profit_margin_percent DESC;
