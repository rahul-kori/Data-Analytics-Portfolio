SQL Analytics

KPI Development

Objective
Before writing analytical SQL queries, we must define what the business wants to measure. A KPI (Key Performance Indicator) should have a clear business definition, formula, stakeholder owner, reporting frequency, and visualization recommendation.
Business Rule: A KPI should answer a business question and support a business decision.

KPI Framework

KPI 1: Total Sales
Field			Value
KPI Name		Total Sales
Business Definition	Total revenue generated from all completed sales transactions
Formula			SUM(Sales)
Business Purpose	Measure overall revenue performance
Stakeholder		CEO, CFO, Head of Sales
Reporting Frequency	Daily, Weekly, Monthly
Visualization		KPI Card

Production SQL
-- Total revenue generated from all recorded sales transactions
SELECT
SUM(sales) AS total_sales
FROM raw.sales_orders;

KPI 2: Total Profit
Field			Value
KPI Name		Total Profit
Business Definition	Total profit earned after all sales transactions
Formula			SUM(Profit)
Business Purpose	Measure business profitability
Stakeholder		CFO, CEO
Reporting Frequency	Monthly
Visualization		KPI Card

Production SQL
-- Total profit generated across all sales transactions
SELECT
SUM(profit) AS total_profit
FROM raw.sales_orders;

KPI 3: Total Orders
Field			Value
KPI Name		Total Orders
Business Definition	Number of unique customer orders
Formula			COUNT(DISTINCT Order_ID)
Business Purpose	Measure order volume
Stakeholder		COO, Head of Sales
Reporting Frequency	Daily, Weekly, Monthly
Visualization		KPI Card

Production SQL
-- Count unique customer orders processed
SELECT
COUNT(DISTINCT order_id) AS total_orders
FROM raw.sales_orders;

KPI 4: Total Customers
Field			Value
KPI Name		Total Customers
Business Definition	Number of unique customers who placed orders
Formula			COUNT(DISTINCT Customer_ID)
Business Purpose	Measure customer reach
Stakeholder		Head of Sales
Reporting Frequency	Monthly
Visualization		KPI Card

Production SQL
-- Count unique customers contributing to sales
SELECT
COUNT(DISTINCT customer_id) AS total_customers
FROM raw.sales_orders;

KPI 5: Average Order Value (AOV)
Field			Value
KPI Name		Average Order Value
Business Definition	Average revenue generated per unique order
Formula			SUM(Sales) / COUNT(DISTINCT Order_ID)
Business Purpose	Understand customer purchasing behavior
Stakeholder		CEO, Head of Sales
Reporting Frequency	Monthly
Visualization		KPI Card

Production SQL
-- Average revenue generated per customer order
SELECT
SUM(sales) / COUNT(DISTINCT order_id) AS average_order_value
FROM raw.sales_orders;

KPI 6: Profit Margin %
Field			Value
KPI Name		Profit Margin %
Business Definition	Percentage of sales retained as profit
Formula			(SUM(Profit) / SUM(Sales)) × 100
Business Purpose	Evaluate overall profitability
Stakeholder		CFO
Reporting Frequency	Monthly
Visualization		KPI Card / Gauge

Production SQL
-- Measure profitability as a percentage of total sales
SELECT
(SUM(profit) * 100.0) / SUM(sales) AS profit_margin_percent
FROM raw.sales_orders;

KPI 7: Average Discount
Field			Value
KPI Name		Average Discount
Business Definition	Average discount applied across transactions
Formula			AVG(Discount)
Business Purpose	Monitor discounting strategy
Stakeholder		CFO, Head of Sales
Reporting Frequency	Monthly
Visualization		KPI Card

Production SQL
-- Average discount applied across all sales transactions
SELECT
AVG(discount) AS average_discount
FROM sales_orders;

KPI 8: Total Quantity Sold
Field			Value
KPI Name		Total Quantity Sold
Business Definition	Total units sold
Formula			SUM(Quantity)
Business Purpose	Measure sales volume
Stakeholder		COO, Head of Sales
Reporting Frequency	Daily, Monthly
Visualization		KPI Card

Production SQL
-- Total units sold across all completed transactions
SELECT
SUM(quantity) AS total_quantity_sold
FROM raw.sales_orders;

KPI Summary
KPI				            Formula						                    Primary Stakeholder
Total Sales			      SUM(Sales)					                  CEO
Total Profit			    SUM(Profit)					                  CFO
Total Orders			    COUNT(DISTINCT Order_ID)			        COO
Total Customers			  COUNT(DISTINCT Customer_ID)			      Head of Sales
Average Order Value		SUM(Sales)/COUNT(DISTINCT Order_ID)		CEO
Profit Margin %			  SUM(Profit)/SUM(Sales)				        CFO
Average Discount		  AVG(Discount)					                CFO
Total Quantity Sold		SUM(Quantity)					                COO

KPI-to-Business Question Mapping
Business Question						                    KPI
How much revenue did we generate?				      Total Sales
Are we profitable?						                Total Profit, Profit Margin %
How many orders did we receive?				      	Total Orders
How many customers purchased?					        Total Customers
How much does an average order generate?			Average Order Value
Are discounts impacting profitability?				Average Discount
How many products were sold?					        Total Quantity Sold

