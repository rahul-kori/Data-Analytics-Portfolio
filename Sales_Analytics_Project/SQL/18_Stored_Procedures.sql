/* Advanced SQL */

-- Stored Procedures

-- Executive KPI Summary
-- Generate executive KPI summary
CREATE PROCEDURE usp_Executive_KPI_Summary
AS
BEGIN
SET NOCOUNT ON;

SELECT
SUM(sales) AS total_sales,
SUM(profit) AS total_profit,
COUNT(DISTINCT order_id) AS total_orders,
COUNT(DISTINCT customer_id) AS total_customers,
SUM(quantity) AS total_quantity
FROM clean.sales_orders;
END;

EXEC usp_Executive_KPI_Summary;


-- Regional Performance Report
-- Generate regional performance report
CREATE PROCEDURE usp_Regional_Performance
    @Region VARCHAR(50)
AS
BEGIN
SET NOCOUNT ON;

SELECT
region,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit,
COUNT(DISTINCT order_id) AS total_orders
FROM clean.sales_orders
WHERE region = @Region
GROUP BY region;
END;

EXEC usp_Regional_Performance
    @Region = 'West';

-- Customer Performance
-- Generate customer performance report
CREATE PROCEDURE usp_Customer_Performance
    @CustomerID VARCHAR(20)
AS
BEGIN
SET NOCOUNT ON;

SELECT
customer_id,
customer_name,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit,
COUNT(DISTINCT order_id) AS total_orders
FROM clean.sales_orders
WHERE customer_id = @CustomerID
GROUP BY customer_id, customer_name;
END;

EXEC usp_Customer_Performance
    @CustomerID = 'CG-12520';

-- Product Performance
-- Generate category performance report
CREATE PROCEDURE usp_Category_Performance
    @Category VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

SELECT
category,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit,
SUM(quantity) AS total_quantity
FROM clean.sales_orders
WHERE category = @Category
GROUP BY category;
END;

EXEC usp_Category_Performance
    @Category = 'Technology';

-- Monthly Sales Report
-- Generate annual monthly sales report
CREATE PROCEDURE usp_Monthly_Sales_Report
    @ReportYear INT
AS
BEGIN
SET NOCOUNT ON;

SELECT
MONTH(order_date) AS order_month,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM clean.sales_orders
WHERE YEAR(order_date) = @ReportYear
GROUP BY MONTH(order_date)
ORDER BY order_month;
END;

EXEC usp_Monthly_Sales_Report
    @ReportYear = 2017;

-- Top Customers
-- Generate top customer report
CREATE PROCEDURE usp_Top_Customers
    @TopCount INT
AS
BEGIN
SET NOCOUNT ON;

SELECT TOP (@TopCount)
customer_id,
customer_name,
SUM(sales) AS total_sales
FROM clean.sales_orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC;
END;

EXEC usp_Top_Customers
    @TopCount = 10;

-- Loss-Making Products
-- Generate loss-making product report
CREATE PROCEDURE usp_Loss_Making_Products
AS
BEGIN
SET NOCOUNT ON;

SELECT
product_name,
SUM(profit) AS total_profit
FROM clean.sales_orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;
END;

EXEC usp_Loss_Making_Products;

-- State Performance Report
-- Generate state performance report
CREATE PROCEDURE usp_State_Performance
    @State VARCHAR(100)
AS
BEGIN
SET NOCOUNT ON;

SELECT
state,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM clean.sales_orders
WHERE state = @State
GROUP BY state;
END;

EXEC usp_State_Performance
    @State = 'California';

