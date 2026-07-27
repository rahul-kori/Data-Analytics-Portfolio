/* SQL Analytics */

-- Time Series Analysis

-- Yearly Sales & Profit Trend
-- Track annual business performance for executive reporting
SELECT
YEAR(Order_Date) AS order_year,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY YEAR(Order_Date)
ORDER BY order_year;

-- Quarterly Sales & Profit Trend
-- Compare quarterly business performance
SELECT
YEAR(Order_Date) AS order_year,
DATEPART(QUARTER, Order_Date) AS order_quarter,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY YEAR(Order_Date), DATEPART(QUARTER, Order_Date)
ORDER BY order_year, order_quarter;

-- Monthly Sales Trend
-- Analyze monthly sales trend
SELECT
YEAR(Order_Date) AS order_year,
MONTH(Order_Date) AS order_month,
DATENAME(MONTH, Order_Date) AS month_name,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP By YEAR(Order_Date), MONTH(Order_Date), DATENAME(MONTH, Order_Date)
ORDER BY order_year, order_month;

-- Monthly Profit Trend
-- Analyze monthly profitability
SELECT
YEAR(Order_Date) AS order_year,
MONTH(Order_Date) AS order_month,
DATENAME(MONTH, Order_Date) AS month_name,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date), DATENAME(MONTH, Order_Date)
ORDER BY order_year, order_month;

-- Sales by Weekday
-- Evaluate sales distribution across weekdays
SELECT
DATENAME(WEEKDAY, Order_Date) AS weekday_name,
COUNT(*) AS total_orders,
SUM(Sales) AS total_sales,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY DATENAME(WEEKDAY, Order_Date)
ORDER BY total_sales DESC;

-- Monthly Order Volume
-- Measure monthly order volume
SELECT
YEAR(Order_Date) AS order_year,
MONTH(Order_Date) AS order_month,
COUNT(DISTINCT Order_ID) AS total_orders
FROM clean.sales_orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY order_year, order_month;

-- Year-over-Year (YoY) Sales Growth
-- Measure year-over-year sales growth
WITH yearly_sales AS (
SELECT
YEAR(Order_Date) AS order_year,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY YEAR(Order_Date)
)
SELECT
order_year,
total_sales,
LAG(total_sales) OVER (ORDER BY order_year) AS previous_year_sales,
total_sales - LAG(total_sales) OVER (ORDER BY order_year) AS sales_growth
FROM yearly_sales
ORDER BY order_year;

-- Rolling 3-Month Sales Average
-- Calculate rolling three-month average sales
WITH monthly_sales AS (
SELECT
YEAR(Order_Date) AS order_year,
MONTH(Order_Date) AS order_month,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY
YEAR(Order_Date),
MONTH(Order_Date)
)
SELECT
order_year,
order_month,
total_sales,
AVG(total_sales) OVER ( ORDER BY order_year, order_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) AS rolling_3_month_avg
FROM monthly_sales
ORDER BY order_year, order_month;
