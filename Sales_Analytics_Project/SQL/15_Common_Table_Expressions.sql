/* Advanced SQL */

-- Common Table Expressions (CTEs)

-- Regional Sales Summary
-- Prepare regional sales summary for executive reporting
WITH regional_sales AS
(
SELECT
Region,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Region
)
SELECT
Region,
total_sales,
total_profit
FROM regional_sales
ORDER BY total_sales DESC;

-- Top 10 Customers by Sales
-- Prepare customer revenue ranking
WITH customer_sales AS
(
SELECT
Customer_ID,
Customer_Name,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Customer_ID,Customer_Name
)
SELECT TOP (10)
Customer_ID,
Customer_Name,
total_sales
FROM customer_sales
ORDER BY total_sales DESC;

-- Category Profitability
-- Prepare category profitability report
WITH category_profit AS
(
SELECT
Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Category
)
SELECT
Category,
total_sales,
total_profit,
(total_profit * 100.0) / total_sales AS profit_margin_percent
FROM category_profit
ORDER BY total_profit DESC;

-- Monthly Sales Trend
-- Prepare monthly sales trend for reporting
WITH monthly_sales AS
(
SELECT
YEAR(Order_Date) AS order_year,
MONTH(Order_Date) AS order_month,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
)
SELECT
order_year,
order_month,
total_sales
FROM monthly_sales
ORDER BY order_year, order_month;

-- Loss-Making Products
-- Prepare loss-making product report
WITH product_profit AS
(
SELECT
Product_Name,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY product_name
)
SELECT TOP (10)
Product_Name,
total_profit
FROM product_profit
ORDER BY total_profit ASC;

-- Customer Segment Performance
-- Prepare customer segment performance report
WITH segment_summary AS
(
SELECT
Segment,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Customer_ID) AS total_customers
FROM clean.sales_orders
GROUP BY Segment
)
SELECT
Segment,
total_sales,
total_profit,
total_customers
FROM segment_summary
ORDER BY total_sales DESC;

-- Average Order Value by Region
-- Prepare average order value by region
WITH regional_orders AS
(
SELECT
Region,
SUM(Sales) AS total_sales,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY Region
)
SELECT
Region,
total_sales,
total_orders,
total_sales / total_orders AS average_order_value
FROM regional_orders
ORDER BY average_order_value DESC;

-- Executive KPI Summary
-- Prepare executive KPI summary
WITH executive_kpis AS
(
SELECT
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Customer_ID) AS total_customers,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
)
SELECT
total_sales,
total_profit,
total_customers,
total_orders,
total_sales / total_orders AS average_order_value
FROM executive_kpis;

