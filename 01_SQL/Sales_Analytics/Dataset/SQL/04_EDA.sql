-- Exploratory Data Analysis (EDA) --

-- Analysis 1 — Business Overview
-- Business intent: Provide an executive summary of overall business performance.
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales_orders;

-- Analysis 2 — Sales by Category
-- Business intent: Identify which product categories contribute the most revenue.
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY category
ORDER BY total_sales DESC;

-- Analysis 3 — Sales by Region
-- Business intent: Compare regional performance.
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY region
ORDER BY total_sales DESC;

-- Analysis 4 — Customer Segment Performance
-- Business intent: Determine which customer segment generates the highest business value.
SELECT
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT customer_id) AS customers
FROM sales_orders
GROUP BY segment
ORDER BY total_sales DESC;

-- Analysis 5 — Monthly Sales Trend
-- Business intent: Identify seasonality and business growth patterns.
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(sales) AS monthly_sales
FROM sales_orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    order_year,
    order_month;

-- Analysis 6 — Top 10 Products
-- Business intent: Identify products driving the highest revenue.
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Analysis 7 — Loss-Making Products
-- Business intent: Highlight products that reduce profitability.
SQL
SELECT
    product_name,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;

