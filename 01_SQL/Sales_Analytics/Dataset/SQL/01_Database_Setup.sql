-- Create Table 
-- Business intent: Create the reporting table for validated retail sales transactions.
CREATE TABLE sales_orders (
    row_id INT,
    order_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20) NOT NULL,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(30) NOT NULL,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2)
);

-- Import Process
After creating the table:
Download the Sample Superstore CSV.
Import it into your SQL database (MySQL Workbench, PostgreSQL, or SQL Server).
Map each CSV column to the corresponding table column.
Verify that all rows load successfully.

-- Post-Import Validation Queries
  
-- Verify Total Rows
-- verify all transactions were imported successfully
SELECT COUNT(*) AS total_rows
FROM sales_orders;

-- Verify Total Columns
SELECT *
FROM sales_orders
LIMIT 5;

-- Verify Date Range
-- verify available reporting period
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM sales_orders;

-- Verify Numeric Fields
-- validate sales and profit ranges before reporting
SELECT
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales,
    MIN(profit) AS min_profit,
    MAX(profit) AS max_profit
FROM sales_orders;

-- Verify Categories
-- confirm expected business categories
SELECT DISTINCT category
FROM sales_orders
ORDER BY category;

-- Verify Regions
-- confirm expected sales regions
SELECT DISTINCT region
FROM sales_orders
ORDER BY region;

