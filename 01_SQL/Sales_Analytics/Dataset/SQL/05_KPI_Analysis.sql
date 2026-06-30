-- KPI Development --

-- KPI 1 — Total Sales
-- Business Definition : Total revenue generated from all completed sales transactions.
-- Business Purpose : Measures the overall revenue performance of the business.

-- executive revenue summary
SELECT
    SUM(sales) AS total_sales
FROM sales_orders;

-- KPI 2 — Total Profit
-- Business Definition : Total profit earned after all sales transactions.
-- Business Purpose : Measures business profitability.

-- executive profit summary
SELECT
    SUM(profit) AS total_profit
FROM sales_orders;

-- KPI 3 — Total Orders
-- Business Definition : Number of unique customer orders.
-- Business Purpose :Tracks customer purchasing activity.

-- count unique customer orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_orders;

-- KPI 4 — Total Customers
-- Business Definition : Number of unique customers who placed an order.

-- active customer count
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales_orders;

-- KPI 5 — Average Order Value (AOV)
-- Total Sales ÷ Total Orders
-- Business Purpose : Measures average customer spending per order.

-- average revenue generated per customer order
SELECT
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM sales_orders;

-- KPI 6 — Profit Margin %
-- (Total Profit ÷ Total Sales) × 100

-- overall business profit margin
SELECT
    ROUND(
        (SUM(profit) / SUM(sales)) * 100,
        2
    ) AS profit_margin_pct
FROM sales_orders;

-- KPI 7 — Quantity Sold
-- total units sold
SELECT
    SUM(quantity) AS total_quantity
FROM sales_orders;

-- KPI 8 — Average Discount
-- average discount offered across all sales
SELECT
    ROUND(
        AVG(discount),
        2
    ) AS average_discount
FROM sales_orders;

-- Executive KPI Query
-- executive sales performance summary
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
    ) AS profit_margin_pct,
    SUM(quantity) AS total_quantity,
    ROUND(
        AVG(discount),
        2
    ) AS average_discount
FROM sales_orders;
