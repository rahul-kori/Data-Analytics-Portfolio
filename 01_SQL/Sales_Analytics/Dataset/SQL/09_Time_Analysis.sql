-- Time Series Analysis --

-- Analysis 1 — Monthly Sales Trend
-- Business intent: Track revenue trends over time.
-- monitor monthly business performance
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    order_year,
    order_month;

-- Analysis 2 — Quarterly Performance
-- Business intent: Compare business performance by quarter.
-- evaluate quarterly sales performance
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY
    order_year,
    order_quarter;

-- Analysis 3 — Yearly Performance
-- Business intent: Measure annual business growth.
-- summarize annual sales performance
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year;

-- Analysis 4 — Best Performing Month
-- Business intent: Identify peak sales periods.
-- identify highest revenue months
SELECT
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(sales) AS total_sales
FROM sales_orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY total_sales DESC;

-- Analysis 5 — Monthly Profit Margin
-- Business intent: Monitor profitability trends throughout the year.
-- monitor monthly profit margins
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    ROUND(
        (SUM(profit) / SUM(sales)) * 100,
        2
    ) AS profit_margin_pct
FROM sales_orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    order_year,
    order_month;

-- Analysis 6 — Month-over-Month (MoM) Sales Growth (Advanced)
-- Business intent: Measure monthly business growth using window functions.
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS sales_month,
        SUM(sales) AS total_sales
    FROM sales_orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    sales_month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY sales_month) AS previous_month_sales,
    ROUND(
        (
            (total_sales - LAG(total_sales) OVER (ORDER BY sales_month))
            / LAG(total_sales) OVER (ORDER BY sales_month)
        ) * 100,
        2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY sales_month;

