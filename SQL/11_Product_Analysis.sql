/* SQL Analytics */

-- Product Analysis

-- Product Performance Summary
-- Summarize product performance for portfolio evaluation
SELECT
Product_ID,
Product_Name,
Category,
Sub_Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
SUM(Quantity) AS total_quantity,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY Product_ID, Product_Name, Category, Sub_Category
ORDER BY total_sales DESC;


-- Top 10 Products by Sales
-- Identify highest revenue generating products
SELECT TOP (10)
Product_ID,
Product_Name,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Product_ID, Product_Name
ORDER BY total_sales DESC;

-- Top 10 Products by Profit
-- Identify most profitable products
SELECT TOP (10)
Product_ID,
Product_Name,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Product_ID, Product_Name
ORDER BY total_profit DESC;

-- Bottom 10 Products by Profit
-- Identify products contributing the largest losses
SELECT TOP (10)
Product_ID,
Product_Name,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Product_ID, Product_Name
ORDER BY total_profit ASC;

-- Category Performance
-- Compare business performance across product categories
SELECT
Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
SUM(Quantity) AS total_quantity
FROM clean.sales_orders
GROUP BY category
ORDER BY total_sales DESC;

-- Sub-Category Performance
-- Evaluate revenue and profitability by sub-category
SELECT
Sub_Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Sub_Category
ORDER BY total_sales DESC;

-- Quantity Sold by Product
-- Identify products with the highest sales volume
SELECT TOP (10)
Product_ID,
Product_Name,
SUM(Quantity) AS total_quantity
FROM clean.sales_orders
GROUP BY Product_ID, Product_Name
ORDER BY total_quantity DESC;

-- Average Selling Price (ASP)
-- Measure average selling price per unit sold
SELECT
Product_ID,
Product_Name,
SUM(Sales) / SUM(Quantity) AS average_selling_price
FROM clean.sales_orders
GROUP BY Product_id, Product_Name
HAVING SUM(Quantity) > 0
ORDER BY average_selling_price DESC;
