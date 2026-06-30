-- Data Cleaning --

-- Standardize Text Fields
-- Business intent: Ensure consistent reporting dimensions.
UPDATE sales_orders
SET
    customer_name = TRIM(customer_name),
    category = TRIM(category),
    sub_category = TRIM(sub_category),
    region = TRIM(region),
    state = TRIM(state),
    city = TRIM(city),
    product_name = TRIM(product_name);

-- Standardize Text Case
Business intent: Prevent duplicate groupings caused by inconsistent capitalization.
SQL
UPDATE sales_orders
SET
    category = UPPER(category),
    region = UPPER(region),
    segment = UPPER(segment);

-- Remove Exact Duplicate Records
-- Business intent: Eliminate duplicate transactions that would overstate KPIs.
-- Example (using a Common Table Expression with ROW_NUMBER()):
WITH duplicate_records AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY order_id, product_id
               ORDER BY row_id
           ) AS rn
    FROM sales_orders
)
DELETE FROM duplicate_records
WHERE rn > 1;

-- Flag Invalid Dates
-- Business intent: Prevent inaccurate delivery and trend reporting.
SELECT
    order_id,
    order_date,
    ship_date
FROM sales_orders
WHERE ship_date < order_date;

-- Validate Numeric Fields
SELECT *
FROM sales_orders
WHERE sales <= 0
   OR quantity <= 0;

-- Re-run Validation
-- After cleaning, repeat the validation queries from 02_Data_Validation.sql to confirm:
-- No critical null values.
-- No duplicate order lines.
-- Consistent categories and regions.
-- Valid date relationships.
