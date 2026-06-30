-- Customer Performance Analysis --

-- Analysis 1 — Top 10 Customers by Sales
-- Business intent: Identify customers generating the highest revenue.
-- identify highest revenue-generating customers
SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY
    customer_id,
    customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Analysis 2 — Top 10 Customers by Profit
-- Business intent: Identify customers contributing the most to overall profitability.
-- identify highest profit-generating customers
SELECT
    customer_id,
    customer_name,
    SUM(profit) AS total_profit,
    SUM(sales) AS total_sales
FROM sales_orders
GROUP BY
    customer_id,
    customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- Analysis 3 — Most Active Customers
-- Business intent: Measure customer engagement by purchase frequency.
-- identify customers with the highest order frequency
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales
FROM sales_orders
GROUP BY
    customer_id,
    customer_name
ORDER BY total_orders DESC
LIMIT 10;

-- Analysis 4 — Average Customer Spend
-- Business intent: Understand the average revenue generated per customer.
-- calculate average customer spending
SELECT
    ROUND(
        SUM(sales) / COUNT(DISTINCT customer_id),
        2
    ) AS average_customer_spend
FROM sales_orders;

-- Analysis 5 — Customer Segment Performance
-- Business intent: Compare revenue and profitability across customer segments.
-- evaluate customer segment performance
SELECT
    segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(sales) / COUNT(DISTINCT customer_id),
        2
    ) AS average_sales_per_customer
FROM sales_orders
GROUP BY segment
ORDER BY total_sales DESC;

-- Analysis 6 — Customer Revenue Contribution
-- Business intent: Identify customer concentration risk.
-- measure each customer's contribution to company revenue
SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales,
    ROUND(
        (SUM(sales) / (SELECT SUM(sales) FROM sales_orders)) * 100,
        2
    ) AS revenue_contribution_pct
FROM sales_orders
GROUP BY
    customer_id,
    customer_name
ORDER BY total_sales DESC;

