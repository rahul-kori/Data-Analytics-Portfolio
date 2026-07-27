/* Advanced SQL */

-- Views

-- Executive Sales Summary
-- Reporting layer for executive sales KPIs
CREATE VIEW vw_Executive_Sales_Summary
AS
SELECT
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Order_ID) AS total_orders,
COUNT(DISTINCT Customer_ID) AS total_customers,
SUM(Quantity) AS total_quantity
FROM clean.sales_orders;

-- Regional Performance
-- Reporting layer for regional performance
CREATE VIEW vw_Regional_Performance
AS
SELECT
Region,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY Region;

-- Customer Performance
-- Reporting layer for customer analytics
CREATE VIEW vw_Customer_Performance
AS
SELECT
Customer_ID,
Customer_Name,
Segment,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY Customer_ID, Customer_Name, Segment;

-- Product Performance
-- Reporting layer for product analytics
CREATE VIEW vw_Product_Performance
AS
SELECT
Product_ID,
Product_Name,
Category,
Sub_Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
SUM(Quantity) AS total_quantity
FROM clean.sales_orders
GROUP BY Product_ID, Product_Name, Category, Sub_Category;

-- Monthly Sales Trend
-- Reporting layer for monthly trend analysis
CREATE VIEW vw_Monthly_Sales
AS
SELECT
YEAR(Order_Date) AS order_year,
MONTH(Order_Date) AS order_month,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date);

-- Category Performance
-- Reporting layer for category performance
CREATE VIEW vw_Category_Performance
AS
SELECT
Category,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
SUM(Quantity) AS total_quantity
FROM clean.sales_orders
GROUP BY Category;

-- State Performance
-- Reporting layer for geographic performance
CREATE VIEW vw_State_Performance
AS
SELECT
State,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY State;

-- Loss-Making Products
-- Reporting layer for identifying loss-making products
CREATE VIEW vw_Loss_Making_Products
AS
SELECT
Product_ID,
Product_Name,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Product_ID, Product_Name
HAVING SUM(Profit) < 0;
