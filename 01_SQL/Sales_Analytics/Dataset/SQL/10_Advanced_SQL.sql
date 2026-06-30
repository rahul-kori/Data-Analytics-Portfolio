-- Advanced SQL Analytics (Window Functions & Ranking) --

-- Analysis 1 — Rank Products Within Each Category
-- Business intent: Rank products by revenue inside each product category.
-- rank products by sales within each category
SELECT
    category,
    product_name,
    SUM(sales) AS total_sales,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM sales_orders
GROUP BY
    category,
    product_name;

-- Analysis 2 — Top Customer in Each Region
-- Business intent: Identify the highest revenue customer in every region.
WITH customer_sales AS (
    SELECT
        region,
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM sales_orders
    GROUP BY
        region,
        customer_id,
        customer_name
)

SELECT *
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) AS region_rank
    FROM customer_sales
) ranked
WHERE region_rank = 1;

-- Analysis 3 — Running Total of Monthly Sales
-- Business intent: Monitor cumulative revenue growth throughout the year.
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
    SUM(total_sales) OVER (
        ORDER BY sales_month
    ) AS running_total_sales
FROM monthly_sales;

-- Analysis 4 — Previous Month Comparison (LAG)
-- Business intent: Compare current performance with the previous month.
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
    LAG(total_sales) OVER (
        ORDER BY sales_month
    ) AS previous_month_sales
FROM monthly_sales;

-- Analysis 5 — 3-Month Moving Average
-- Business intent: Smooth monthly fluctuations to identify long-term trends.
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
    ROUND(
        AVG(total_sales) OVER (
            ORDER BY sales_month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS moving_avg_3_month
FROM monthly_sales;

-- Analysis 6 — Top 10% Customers by Revenue
-- Business intent: Identify strategic customers for retention programs.
WITH customer_sales AS (
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM sales_orders
    GROUP BY
        customer_id,
        customer_name
)

SELECT
    customer_id,
    customer_name,
    total_sales,
    NTILE(10) OVER (
        ORDER BY total_sales DESC
    ) AS revenue_decile
FROM customer_sales;



