/* Exploratory Data Analysis (EDA) */

/* Dataset Summary */

-- Total Transactions
SELECT 
COUNT(*) AS total_transactions
FROM clean.sales_orders;

-- Total Orders
SELECT
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders;

-- Total Customers
SELECT
COUNT(DISTINCT Customer_ID) AS total_customers
FROM clean.sales_orders;

-- Total Products
SELECT
COUNT(DISTINCT Product_ID) AS total_Products
FROM clean.sales_orders;

/* Revenue Performance Analysis */

-- Total Sales
SELECT 
SUM(Sales) AS total_sales
FROM clean.sales_orders;

-- Total Profit
SELECT 
SUM(Profit) AS total_Profit
FROM clean.sales_orders;

-- Overall Profit Margin
SELECT
SUM(Profit)/SUM(Sales) AS profit_margin
FROM clean.sales_orders;

/* Time Based Analysis */

-- Yearly Sales Trend
SELECT
YEAR(Order_Date) AS sales_year,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_Profit
FROM clean.sales_orders
GROUP BY YEAR(Order_Date)
ORDER BY sales_year;

-- Monthly Sales Trend
SELECT
YEAR(Order_Date) AS sales_year,
MONTH(Order_Date) AS sales_month,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_Profit
FROM clean.sales_orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY sales_year, sales_month;

-- Customer Segment Analysis
SELECT
Segment,
COUNT(DISTINCT Customer_ID) AS customers,
SUM(Sales) AS revenue,
SUM(Profit) AS profit
FROM clean.sales_orders
GROUP BY Segment
ORDER BY revenue DESC;

-- Category Performance Analysis
SELECT
Category,
SUM(Sales) AS revenue,
SUM(Profit) AS profit
FROM clean.sales_orders
GROUP BY Category
ORDER BY revenue DESC;

-- Sub-Category Analysis
SELECT
Sub_Category,
SUM(Sales) AS revenue,
SUM(Profit) AS profit
FROM clean.sales_orders
GROUP BY Sub_Category
ORDER BY revenue DESC;

-- Regional Analysis
SELECT
Region,
SUM(Sales) AS revenue,
SUM(Profit) AS profit
FROM clean.sales_orders
GROUP BY Region
ORDER BY revenue DESC;

-- Loss-Making Products
SELECT TOP 10
Product_Name,
SUM(Sales) AS revenue,
SUM(Profit) AS profit
FROM clean.sales_orders
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Profit;

-- Discount Impact Analysis
SELECT
Discount,
SUM(Sales) AS revenue,
SUM(Profit) AS profit
FROM clean.sales_orders
GROUP BY Discount
ORDER BY Discount;











