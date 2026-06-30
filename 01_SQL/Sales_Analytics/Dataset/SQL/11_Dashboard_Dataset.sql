-- Dashboard Dataset Preparation --

-- Reporting View 1 — Executive Summary
-- Business intent: Provide executive KPIs for the dashboard landing page.
-- executive reporting dataset
CREATE VIEW vw_executive_summary AS
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value,
    ROUND(
        (SUM(profit) / SUM(sales)) * 100,
        2
    ) AS profit_margin_pct
FROM sales_orders;

-- Reporting View 2 — Monthly Sales Trend
-- monthly sales reporting dataset
CREATE VIEW vw_monthly_sales AS
SELECT
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY DATE_TRUNC('month', order_date);

-- Reporting View 3 — Category Performance
-- category performance reporting dataset
CREATE VIEW vw_category_performance AS
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales_orders
GROUP BY category;

-- Reporting View 4 — Regional Performance
-- regional performance reporting dataset
CREATE VIEW vw_region_performance AS
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_orders
GROUP BY region;

-- Reporting View 5 — Customer Performance
-- customer reporting dataset
CREATE VIEW vw_customer_performance AS
SELECT
    customer_id,
    customer_name,
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_orders
GROUP BY
    customer_id,
    customer_name,
    segment;

-- Reporting View 6 — Product Performance
-- product reporting dataset
CREATE VIEW vw_product_performance AS
SELECT
    product_name,
    category,
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales_orders
GROUP BY
    product_name,
    category,
    sub_category;

