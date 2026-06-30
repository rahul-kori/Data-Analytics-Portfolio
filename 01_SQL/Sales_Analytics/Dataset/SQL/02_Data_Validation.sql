-- Data Validation

-- Validation 1 — Total Row Count
--Business intent: Verify that all expected sales transactions are available for reporting.
SELECT
    COUNT(*) AS total_rows
FROM sales_orders;

-- Validation 2 — Null Value Assessment
-- Business intent: Identify missing business-critical information that could affect KPI accuracy.
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit
FROM sales_orders;

-- Validation 3 — Duplicate Order Lines
-- Business intent: Detect duplicate transactions that could overstate revenue and profit.
SELECT
    order_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM sales_orders
GROUP BY
    order_id,
    product_id
HAVING COUNT(*) > 1;

-- Validation 4 — Order Date Integrity
-- Business intent: Ensure shipping does not occur before the order is placed.
SELECT
    order_id,
    order_date,
    ship_date
FROM sales_orders
WHERE ship_date < order_date;

-- Validation 5 — Sales Validation
-- Business intent: Identify transactions with invalid revenue values.
SELECT *
FROM sales_orders
WHERE sales <= 0;

-- Validation 6 — Quantity Validation
-- Business intent: Ensure every reported sale contains a valid quantity.
SELECT *
FROM sales_orders
WHERE quantity <= 0;

-- Validation 7 — Discount Validation
-- Business intent: Verify discount percentages fall within the approved business range.
SELECT *
FROM sales_orders
WHERE discount < 0
   OR discount > 1;

-- Validation 8 — Category Consistency
-- Business intent: Confirm product categories follow the approved master list.
SELECT DISTINCT
    category
FROM sales_orders
ORDER BY category;

-- Validation 9 — Region Consistency
-- Business intent: Confirm all transactions are assigned to valid sales regions.
SELECT DISTINCT
    region
FROM sales_orders
ORDER BY region;

-- Validation 10 — Date Coverage
-- Business intent: Confirm the reporting period available for trend analysis.
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM sales_orders;





