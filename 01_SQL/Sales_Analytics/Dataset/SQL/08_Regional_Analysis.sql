-- Regional Performance Analysis --

-- Analysis 1 — Regional Performance
-- Business intent: Compare overall regional business performance.
-- compare revenue and profitability across sales regions
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        SUM(profit) / SUM(sales) * 100,
        2
    ) AS profit_margin_pct
FROM sales_orders
GROUP BY region
ORDER BY total_sales DESC;

-- Analysis 2 — State Performance
-- Business intent: Identify top-performing states.
-- identify top-performing states by revenue
SELECT
    state,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;

-- Analysis 3 — City Performance
-- Business intent: Evaluate city-level sales performance.
-- compare city performance
SELECT
    city,
    state,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY
    city,
    state
ORDER BY total_sales DESC
LIMIT 15;

-- Analysis 4 — Loss-Making States
-- Business intent: Identify states requiring business intervention.
-- identify states with negative profitability
SELECT
    state,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY state
HAVING SUM(profit) < 0
ORDER BY total_profit;

-- Analysis 5 — Regional Category Performance
-- Business intent: Understand which product categories drive each region.
-- analyze category performance across regions
SELECT
    region,
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY
    region,
    category
ORDER BY
    region,
    total_sales DESC;

-- Analysis 6 — Average Order Value by Region
-- Business intent: Compare customer spending across regions.
-- compare average order value by region
SELECT
    region,
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM sales_orders
GROUP BY region
ORDER BY average_order_value DESC;


