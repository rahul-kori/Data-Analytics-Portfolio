/* SQL Analytics */

-- Profit Analysis

-- Overall Profit Performance
-- Executive summary of overall profitability
SELECT
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
(SUM(Profit) * 100.0) / SUM(Sales) AS profit_margin_percent
FROM clean.sales_orders;

-- Profit by Category
-- Compare profitability across product categories
SELECT
Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
(SUM(Profit) * 100.0) / SUM(Sales) AS profit_margin_percent
FROM clean.sales_orders
GROUP BY Category
ORDER BY total_profit DESC;

-- Profit by Sub-Category
-- Evaluate profitability by product sub-category
SELECT
Sub_Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Sub_Category
ORDER BY total_profit DESC;

-- Top 10 Most Profitable Products
-- Identify highest profit generating products
SELECT TOP (10)
Product_Name,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY product_name
ORDER BY total_profit DESC;

-- Top 10 Loss-Making Products
-- Identify products requiring pricing or portfolio review
SELECT TOP (10)
Product_Name,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Product_Name
ORDER BY total_profit ASC;

-- Profit by Customer Segment
-- Compare profitability across customer segments
SELECT
Segment,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
(SUM(Profit) * 100.0) / SUM(Sales) AS profit_margin_percent
FROM clean.sales_orders
GROUP BY Segment
ORDER BY total_profit DESC;

-- Discount Impact on Profit
-- Measure profitability across discount levels
SELECT
Discount,
COUNT(*) AS total_orders,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Discount
ORDER BY Discount;

-- Profit by Region
-- Compare profitability across business regions
SELECT
Region,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
(SUM(Profit) * 100.0) / SUM(Sales) AS profit_margin_percent
FROM clean.sales_orders
GROUP BY Region
ORDER BY total_profit DESC;
