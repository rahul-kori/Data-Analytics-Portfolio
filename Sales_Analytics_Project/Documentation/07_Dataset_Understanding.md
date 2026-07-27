Dataset Understanding
Before profiling or cleaning data, a Data Analyst must understand what the dataset contains, how it maps to the business, and what each column represents. This step forms the basis of a professional Data Dictionary.

Dataset Understanding Document
1. Dataset Information
Field			Value
Dataset Name		Superstore Dataset
Source			Kaggle (Public Dataset)
File Format		CSV
Database		Sales_Analytics_DB
Table Name		sales_orders
Domain			Retail Sales
Data Type		Transactional Sales Data
Granularity		One row represents one order line (an individual product within an order)
Business Note: Since one order can contain multiple products, Order ID is not unique. The Row ID is the unique identifier for each record.

2. Business Process
The dataset represents the following business flow:
Customer Places Order
        ↓
Order Created
        ↓
Product Assigned
        ↓
Shipment Processed
        ↓
Order Delivered
        ↓
Sales & Profit Recorded


3. Entity Overview
The dataset contains information about:
Business Entity	Description
Orders		Individual sales transactions
Customers	Customers who placed orders
Products	Products sold
Geography	Country, Region, State, City
Shipping	Ship Mode and Ship Date
Financials	Sales, Quantity, Discount, Profit

4. Column Dictionary
Column			Data Type	Business Meaning
Row ID			Unique 		record identifier
Order ID		Text		Sales order number
Order Date		Date		Date the order was placed
Ship Date		Date		Date the order was shipped
Ship Mode		Text		Shipping method used
Customer ID		Text		Unique customer identifier
Customer Name		Text		Customer name
Segment	Text		Customer 	segment (Consumer, Corporate, Home Office)
Country	Text		Customer 	country
City	Text		Customer 	city
State	Text		Customer 	state
Postal Code		Text		Postal code
Region	Text		Business 	region
Product ID		Text		Unique product identifier
Category		Text		Product category
Sub-Category		Text		Product sub-category
Product Name		Text		Product description
Sales			Decimal		Revenue generated
Quantity		Integer		Units sold
Discount		Decimal		Discount applied
Profit			Decimal		Profit earned or lost

5. Business Keys
Key			Purpose
Row ID			Primary Key (Unique Record)
Order ID		Groups products belonging to the same order
Customer ID		Links transactions to customers
Product ID		Links transactions to products

6. Business Dimensions
The following dimensions will later become dimension tables when we design the Star Schema:
Dimension		Source Columns
Customer		Customer ID, Customer Name, Segment
Product			Product ID, Product Name, Category, Sub-Category
Location		Country, Region, State, City, Postal Code
Date			Order Date, Ship Date
Sales Fact		Sales, Quantity, Discount, Profit

7. Measures
These numeric columns will be aggregated during analysis:
Measure		Business Purpose
Sales		Revenue analysis
Profit		Profitability analysis
Quantity	Volume analysis
Discount	Discount impact analysis





8. Relationships (Future Star Schema)
              Dim_Date
                 |
                 |
Dim_Customer -- Fact_Sales -- Dim_Product
                 |
                 |
            Dim_Location
This structure will be implemented in Phase 5 → Step 23: Star Schema Design.

9. Business Assumptions
•	Each row represents one product sold within an order.
•	Negative profit indicates a loss-making transaction.
•	Discount is stored as a decimal (e.g., 0.20 = 20%).
•	Sales values are recorded before aggregation.
•	Dates are historical and suitable for trend analysis.

10. Data Quality Expectations
Before analysis, we expect to verify:
•	Duplicate records
•	Missing values
•	Invalid dates
•	Incorrect data types
•	Duplicate business keys
•	Negative sales (if any)
•	Invalid quantities
•	Business rule violations
These checks will be completed in the next phases.

11. Data Flow
CSV Dataset
      ↓
SQL Server Import
      ↓
Data Profiling
      ↓
Data Validation
      ↓
Data Cleaning
      ↓
Business Analysis
      ↓
Power BI Dashboard
