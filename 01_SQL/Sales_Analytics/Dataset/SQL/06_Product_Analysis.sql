-- Product Performance Analysis --

-- Analysis 1 — Top 10 Products by Sales
-- Business intent: Identify products driving the highest revenue.
-- identify highest revenue-generating products
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales_orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Analysis 2 — Top 10 Products by Profit
-- Business intent: Identify products contributing most to business profitability.
-- identify most profitable products
SELECT
    product_name,
    SUM(profit) AS total_profit,
    SUM(sales) AS total_sales
FROM sales_orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Analysis 3 — Loss-Making Products
-- Business intent: Highlight products that reduce overall profitability.
-- identify products generating negative profit
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit;

-- Analysis 4 — Category Performance
-- Business intent: Compare business performance across product categories.
-- evaluate category-level revenue and profitability
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity
FROM sales_orders
GROUP BY category
ORDER BY total_sales DESC;

-- Analysis 5 — Sub-Category Performance
-- Business intent: Identify high- and low-performing product groups.
-- compare sub-category performance
SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_orders
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Analysis 6 — Product Contribution to Revenue
-- Business intent: Measure each product's contribution to total company sales.
-- calculate each product's percentage contribution to revenue
SELECT
    product_name,
    SUM(sales) AS total_sales,
    ROUND(
        (SUM(sales) / (SELECT SUM(sales) FROM sales_orders)) * 100,
        2
    ) AS revenue_contribution_pct
FROM sales_orders
GROUP BY product_name
ORDER BY total_sales DESC;

