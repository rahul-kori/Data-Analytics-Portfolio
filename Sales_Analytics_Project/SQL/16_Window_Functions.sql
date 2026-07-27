/* Advanced SQL */

-- Window Functions

-- ROW_NUMBER()
-- Assign a unique ranking for product sales performance
WITH product_sales AS
(
SELECT
Product_Name,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Product_Name
)
SELECT
Product_Name,
total_sales,
ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM product_sales;

-- RANK()
-- Rank customers by revenue contribution
WITH customer_sales AS
(
SELECT
Customer_Name,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Customer_Name
)
SELECT
Customer_Name,
total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS customer_rank
FROM customer_sales;



-- DENSE_RANK()
-- Rank categories based on profitability
WITH category_profit AS
(
SELECT
Category,
SUM(Profit) AS total_profit
FROM clean.sales_orders
GROUP BY Category
)
SELECT
Category,
total_profit,
DENSE_RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM category_profit;

-- LAG()
-- Compare current month sales with previous month
WITH monthly_sales AS
(
SELECT
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales) AS total_sales
FROM clean.sales_orders
GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
order_year,
order_month,
total_sales,
LAG(total_sales) OVER (ORDER BY order_year, order_month ) AS previous_month_sales
FROM monthly_sales;

-- LEAD()
-- Compare current month sales with next month
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
total_sales,
LEAD(total_sales) OVER (ORDER BY order_year, order_month) AS next_month_sales
FROM monthly_sales;

-- Running Total
-- Calculate cumulative sales for trend reporting
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
total_sales,
SUM(total_sales) OVER (ORDER BY order_year, order_month) AS running_total_sales
FROM monthly_sales;

-- NTILE()
-- Segment customers into revenue quartiles
WITH customer_sales AS
(
SELECT
Customer_Name,
SUM(Sales) AS total_sales
FROM clean.sales_orders
GROUP BY Customer_Name
)
SELECT
Customer_Name,
total_sales,
NTILE(4) OVER (ORDER BY total_sales DESC) AS revenue_quartile
FROM customer_sales;

-- Regional Ranking
-- Rank products within each business region
WITH regional_product_sales AS
(
SELECT
region,
product_name,
SUM(sales) AS total_sales
FROM clean.sales_orders
GROUP BY
region,
product_name
)
SELECT
region,
product_name,
total_sales,
ROW_NUMBER() OVER (PARTITION BY region ORDER BY total_sales DESC) AS regional_rank
FROM regional_product_sales;

