/* SQL Analytics */

-- KPI Development

-- Total Sales
-- Total revenue generated from all recorded sales transactions
SELECT
SUM(Sales) AS total_sales
FROM clean.sales_orders;

-- Total Profit
-- Total profit generated across all sales transactions
SELECT
SUM(Profit) AS total_profit
FROM clean.sales_orders;

-- Total Orders
-- Count unique customer orders processed
SELECT
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders;

-- Total Customers
-- Count unique customers contributing to sales
SELECT
COUNT(DISTINCT Customer_ID) AS total_customers
FROM clean.sales_orders;

-- Average Order Value (AOV)
-- Average revenue generated per customer order
SELECT
SUM(Sales) / COUNT(DISTINCT Order_ID) AS average_order_value
FROM clean.sales_orders;

-- Profit Margin %
-- Measure profitability as a percentage of total sales
SELECT
(SUM(Profit) * 100.0) / SUM(Sales) AS profit_margin_percent
FROM clean.sales_orders;

-- Average Discount
-- Average discount applied across all sales transactions
SELECT
AVG(Discount) AS average_discount
FROM clean.sales_orders;

-- Total Quantity Sold
-- Total units sold across all completed transactions
SELECT
SUM(Quantity) AS total_quantity_sold
FROM clean.sales_orders;

